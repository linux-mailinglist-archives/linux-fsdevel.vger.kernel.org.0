Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4645E5306E2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 May 2022 02:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232334AbiEWAmk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 22 May 2022 20:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbiEWAmk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 22 May 2022 20:42:40 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E039930569
        for <linux-fsdevel@vger.kernel.org>; Sun, 22 May 2022 17:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lvHUaLLcyeN48C3kdGLGXj9tNoTC1KzaKc9y8eGSN4w=; b=hOGiOv7P6XSrkYS+HyqmQ+i8AQ
        hxnMK3EIPVxNxXwFeye+BHGsh3B5RcW6ymxO7qesoVFLyb9V92U//SsPS9r21jaEBiYBEsOLprxYX
        sso4a62EqWUQwONAZ1w8RPPEY+lZ2M0vkOFkW9WSu8650nzdF6bWM36DGWEQtxisLVt0BkIc+gTaW
        i7Zttop43qQXwcerMONGSVVyox6xqihOZTN0STY/7VQb8ir5BVGXvoNcTuXldDIWx/Sf99tlkelCt
        r886wrkyUYmFIEnLgDiL0zxpg+5UIQlhaTMuXHlbDFanFcp1LPA2KdVIlTSfTECwjU8YfOtz1WEdF
        xAu09UVw==;
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nsw9Z-00HLo5-9y; Mon, 23 May 2022 00:42:33 +0000
Date:   Mon, 23 May 2022 00:42:33 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] what to do with IOCB_DSYNC?
Message-ID: <YorYeQpW9nBJEeSx@zeniv-ca.linux.org.uk>
References: <96aa35fc-3ff7-a3a1-05b5-9fae5c9c1067@kernel.dk>
 <Yoo1q1+ZRrjBP2y3@zeniv-ca.linux.org.uk>
 <e2bb980b-42e8-27dc-cb6b-51dfb90d7e0a@kernel.dk>
 <7abc2e36-f2f3-e89c-f549-9edd6633b4a1@kernel.dk>
 <YoqAM1RnN/er6GDP@zeniv-ca.linux.org.uk>
 <41f4fba6-3ab2-32a6-28d9-8c3313e92fa5@kernel.dk>
 <YoqDTV9sa4k9b9nb@zeniv-ca.linux.org.uk>
 <737a889f-93b9-039f-7708-c15a21fbca2a@kernel.dk>
 <YoqJROtrPpXWv948@zeniv-ca.linux.org.uk>
 <1b2cb369-2247-8c10-bd6e-405a8167f795@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b2cb369-2247-8c10-bd6e-405a8167f795@kernel.dk>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 22, 2022 at 02:03:35PM -0600, Jens Axboe wrote:

> Right, I'm saying it's not _immediately_ clear which cases are what when
> reading the code.
> 
> > up a while ago.  And no, turning that into indirect calls ended up with
> > arseloads of overhead, more's the pity...
> 
> It's a shame, since indirect calls make for nicer code, but it's always
> been slower and these days even more so.
> 
> > Anyway, at the moment I have something that builds; hadn't tried to
> > boot it yet.
> 
> Nice!

Boots and survives LTP and xfstests...  Current variant is in vfs.git#work.iov_iter
(head should be at 27fa77a9829c).  I have *not* looked into the code generation
in primitives; the likely/unlikely on those cascades of ifs need rethinking.

I hadn't added ITER_KBUF (or KADDR, whatever); should be an easy incremental,
though.

At the moment it's carved up into 6 commits:
	btrfs_direct_write(): cleaner way to handle generic_write_sync() suppression
	struct file: use anonymous union member for rcuhead and llist
	iocb: delay evaluation of IS_SYNC(...) until we want to check IOCB_DSYNC
	keep iocb_flags() result cached in struct file
	new iov_iter flavour - ITER_UBUF
	switch new_sync_{read,write}() to ITER_UBUF

Review and testing would be welcome, but it's obviously not this window fodder.
