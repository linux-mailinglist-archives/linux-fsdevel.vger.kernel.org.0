Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B088780F02
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Aug 2023 17:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350816AbjHRPWT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Aug 2023 11:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378117AbjHRPVw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Aug 2023 11:21:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106D84215
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Aug 2023 08:21:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A3A5764C84
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Aug 2023 15:21:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB39DC433C7;
        Fri, 18 Aug 2023 15:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692372100;
        bh=GF4cXzIiPal1eGF4bYsVmCoYbUS+ZY+/tmnqJKPrd1E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gBKtIvR6sbQU0sS5zdLhAEFYNWne0N+7EmjFZFM+nsurQ+OkcN2jThYfvxA2lBKCr
         gbsWt28CPtUWC+HIFa34GCwwjZYBpI6S+6mISlHgyRS+VgLcleWTS2biXHhRtG74Hz
         08fnZX/t9LtzNnTRF1tbZ4LNeFT/nVhTTfIaZRIJ1aF3znxtZPuIbGFu3Dnl5qxDbT
         UjsR2i4Zew6vEtTsYsUn4OF18E3An8R3pg+ve6zYjIuApt2rmG0ORHOAV5TEuIwyXb
         DyGJCQcTc1Nq7cmvJqjnjvs9k1/QLwUTu3TRxFxbWdhzWLzoZK39TDsy2D2Quff62I
         OalVEIjP6X39A==
Date:   Fri, 18 Aug 2023 17:21:35 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 3/4] super: wait for nascent superblocks
Message-ID: <20230818-daheim-produkt-6ef68fe29b1a@brauner>
References: <20230818-vfs-super-fixes-v3-v3-0-9f0b1876e46b@kernel.org>
 <20230818-vfs-super-fixes-v3-v3-3-9f0b1876e46b@kernel.org>
 <ZN+G5NtU2y3wGSJh@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZN+G5NtU2y3wGSJh@casper.infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Here's my suggestion:
> 
> /**
>  * super_lock - Wait for superblock to become ready and lock it.
>  * @sb: Superblock to wait for.
>  * @excl: Whether exclusive access is required.
>  *
>  * If the superblock has neither passed through vfs_get_tree() or
>  * generic_shutdown_super() yet wait for it to happen. Either superblock
>  * creation will succeed and SB_BORN is set by vfs_get_tree() or we're
>  * woken and we'll see SB_DYING.
>  *
>  * Context: May sleep.  The caller must have incremented @sb->s_count.
>  * Return: s_umount is always acquired.  Returns true if the superblock
>  * is active, false if the superblock is dying.
>  */

Yeah, sure. Applied in-tree.
