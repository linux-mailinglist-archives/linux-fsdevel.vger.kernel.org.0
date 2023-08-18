Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6292780E68
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Aug 2023 16:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377819AbjHRO57 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Aug 2023 10:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377850AbjHRO5s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Aug 2023 10:57:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 263AE30F3
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Aug 2023 07:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=m5vpJD4cJmMP3d2SVgAWhfFz+Dr0XxgEPHah1ieKd9E=; b=XQkWXppj0ngXH1pBUaOLgYOjMw
        BYMcpBc6PcylAR61e7u17MwnsFvxvcIs6DkTN2s2Eit+SkHcSydS2k0VnILuf0nk7pgfd7r/qBgmA
        Whic81UDxyi1E32YEV6CSNajW2Zkvkq+i3346QA1J/TrxEaO1BMGV8WSObThC5JV6fG8WGAquKuLC
        jybCk6CV70oV5/WmgwcezUeA64eKZnWdXwgcDL3aF58TJG2h48ZGKwHCP/5+FAiRf0XOthWH554uX
        jOjvflDFdWj+crlRomcNN8YqlwnyRvZ75IypBd63TJZyo3qJW014kE0lPjDuWxxVibZuCYJ2lbL6Z
        orZ0sPLg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qX0uy-00A3tA-Oh; Fri, 18 Aug 2023 14:57:40 +0000
Date:   Fri, 18 Aug 2023 15:57:40 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 3/4] super: wait for nascent superblocks
Message-ID: <ZN+G5NtU2y3wGSJh@casper.infradead.org>
References: <20230818-vfs-super-fixes-v3-v3-0-9f0b1876e46b@kernel.org>
 <20230818-vfs-super-fixes-v3-v3-3-9f0b1876e46b@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230818-vfs-super-fixes-v3-v3-3-9f0b1876e46b@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 18, 2023 at 04:00:50PM +0200, Christian Brauner wrote:
> +/**
> + * super_lock - wait for superblock to become ready and lock it
> + * @sb: superblock to wait for
> + * @excl: whether exclusive access is required
> + *
> + * If the superblock has neither passed through vfs_get_tree() or
> + * generic_shutdown_super() yet wait for it to happen. Either superblock
> + * creation will succeed and SB_BORN is set by vfs_get_tree() or we're
> + * woken and we'll see SB_DYING.
> + *
> + * The caller must have acquired a temporary reference on @sb->s_count.
> + *
> + * Return: This returns true if SB_BORN was set, false if SB_DYING was
> + *         set. The function acquires s_umount and returns with it held.

I think this needs slightly stronger language to warn callers that
*even if it returns false*, it returns with the lock held!  I find
this surprising.  Usually returning failure means that the lock isn't
held, but looking at the callers shows that it wouldn't simplify them
to release the lock before returning failure.

Here's my suggestion:

/**
 * super_lock - Wait for superblock to become ready and lock it.
 * @sb: Superblock to wait for.
 * @excl: Whether exclusive access is required.
 *
 * If the superblock has neither passed through vfs_get_tree() or
 * generic_shutdown_super() yet wait for it to happen. Either superblock
 * creation will succeed and SB_BORN is set by vfs_get_tree() or we're
 * woken and we'll see SB_DYING.
 *
 * Context: May sleep.  The caller must have incremented @sb->s_count.
 * Return: s_umount is always acquired.  Returns true if the superblock
 * is active, false if the superblock is dying.
 */

