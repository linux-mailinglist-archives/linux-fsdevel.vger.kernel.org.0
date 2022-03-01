Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D15D4C910E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Mar 2022 18:00:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236338AbiCARBg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Mar 2022 12:01:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236245AbiCARBe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Mar 2022 12:01:34 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F12F535245
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Mar 2022 09:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=V9bn03LYF2Wan4w9BhhDudLDH+5fas8t+G2/4sGJYb0=; b=IkWFPbNiXwed2LDaAZtCaoMxOY
        oc3t7MnSH5K6OypdOkZ/ITpGsYm6sZyKs5ouP3bMhbCOu6xzh6Lj+klU6HhwOn2QuKrLl1HqEMvOP
        ar7FthAnqxvkNNn3xP7RWQ6O/m+FB7/wEeqwEI9ym7ZtDcDnI/xwZgrcj+AQZiSl8DlxshteQNRlx
        xd5J37kkPxoZiXNVKwj+VJUYblmFqDPCw/G/NjP1OwOObHS1p5UXoK9CKh8pw/FPMY3zYu2uSvkQR
        gxm5z9f+1af9yFPsjjPqSk+1s+XRAIgBHzxQvjCmnfe9XRFoKrPxwx1EeFRotVJmFFSvjM1+WhCoI
        8npEydJw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nP5rl-009lkk-6r; Tue, 01 Mar 2022 17:00:49 +0000
Date:   Tue, 1 Mar 2022 17:00:49 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        dchinner@redhat.com
Subject: Re: [LSF/MM/BPF Topic] Shared memory for shared file extents
Message-ID: <Yh5RQdAllZ3rRS3C@casper.infradead.org>
References: <20220209215410.vl5777f7g6utgipt@fiona>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220209215410.vl5777f7g6utgipt@fiona>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 09, 2022 at 03:54:10PM -0600, Goldwyn Rodrigues wrote:
> Copy-on-write filesystem such as btrfs (or reflinks in XFS/OCFS2) have
> files which share extents on disk. Multiple files can have extents
> pointing to same physical disk location. When mutliple files share a
> common extent and these files are read(), each file will have it's own
> copy of the content in the page cache.
> 
> The problem is this leads to wastage of memory since multiple
> copies of the same content is in memory. The proposal is to have a
> common cache which would be used *for reads only* (excluding read before
> writes for non page aligned writes).
> 
> I would like to discuss the problems which will arise to implement this:
>  - strategies to maintain such a shared cache
>    - location of the shared cache: device inode or separate inode?
>    - all reads go through shared cache OR only shared extents 
>      should be in shared cache
>  - actions to perform if write occurs at offsets of shared extents
>    - should it be CoW'd in memory? OR
>    - move the pages from shared cache to inode's cache?
>  - what should be done to the pages after writeback. Should they be
>    dropped, so further reads are read into shared cache?
>  - Shrinking in case of system memory pressure
> 
> An initial RFC patch was posted here:
> https://lore.kernel.org/all/YXNoxZqKPkxZvr3E@casper.infradead.org/t/

Yes, we should discuss this.  Sorry I've been too busy to work on it
recently.  Hopefully I have time this year.
