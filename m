Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2559676A83
	for <lists+linux-fsdevel@lfdr.de>; Sun, 22 Jan 2023 02:06:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbjAVBGq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Jan 2023 20:06:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjAVBGp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Jan 2023 20:06:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67BF022DD0;
        Sat, 21 Jan 2023 17:06:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F3BDE60918;
        Sun, 22 Jan 2023 01:06:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F310CC433D2;
        Sun, 22 Jan 2023 01:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1674349602;
        bh=f++QpVWpQpCa5Y2lUzhkXb5vN7dWMnG6EbTBZMDoyqE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=K8ITSredLjN6RsWmDw7F2N5WthD7EgH6VTWaz2+ik16Ka/pQziEgWZn04WqCXW071
         r9erU5+Z1B/9XVDshRwPjHKsFWahHPGqUMQB+YcCLd2gj1WLD9x48LlmxmE5voLZAV
         4SleWXBskXm0bHHmpptYnTnhCBrc4uX5NActjowk=
Date:   Sat, 21 Jan 2023 17:06:41 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>, linux-afs@lists.infradead.org,
        linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        cluster-devel@redhat.com, linux-mm@kvack.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-nilfs@vger.kernel.org
Subject: Re: return an ERR_PTR from __filemap_get_folio v2
Message-Id: <20230121170641.121f4224a0e8304765bb4738@linux-foundation.org>
In-Reply-To: <20230121065755.1140136-1-hch@lst.de>
References: <20230121065755.1140136-1-hch@lst.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 21 Jan 2023 07:57:48 +0100 Christoph Hellwig <hch@lst.de> wrote:

> Hi all,
> 
> __filemap_get_folio and its wrappers can return NULL for three different
> conditions, which in some cases requires the caller to reverse engineer
> the decision making.  This is fixed by returning an ERR_PTR instead of
> NULL and thus transporting the reason for the failure.  But to make
> that work we first need to ensure that no xa_value special case is
> returned and thus return the FGP_ENTRY flag.  It turns out that flag
> is barely used and can usually be deal with in a better way.
> 
> Note that the shmem patches in here are non-trivial and need some
> careful review and testing.

I'll hide for a while, awaiting that review.  Plus...

> Changes since v1:
>  - drop the patches to check for errors in btrfs and gfs2
>  - document the new calling conventions for the wrappers around
>    __filemap_get_folio
>  - rebased against the iomap changes in latest linux-next

This patchset doesn't apply to fs/btrfs/ because linux-next contains
this 6+ month-old commit:

commit 964688b32d9ada55a7fce2e650d85ef24188f73f                
Author:     Matthew Wilcox (Oracle) <willy@infradead.org>
AuthorDate: Tue May 17 18:03:27 2022 -0400
Commit:     Matthew Wilcox (Oracle) <willy@infradead.org>
CommitDate: Wed Jun 29 08:51:07 2022 -0400

    btrfs: Use a folio in wait_dev_supers()


Matthew, what's the story here?
