Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1846659774
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Dec 2022 11:58:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233838AbiL3K6B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Dec 2022 05:58:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbiL3K6A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Dec 2022 05:58:00 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A79961A390
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Dec 2022 02:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=I5P17+MDIkCpDQZB1LcswKgVFyMsYHYc2INWURQYUYc=; b=uLKdQC+SutNeMcCIIbqbNVAhR8
        3DHYP8uTjAEPUWFWnJE4J1mbgPmlAwuDn+h3w7aM4shUlsx/YotASq6z5WoCY4tpfG/sJwGZXzWQK
        VujDU5KkSGAYtzv+g4YMk4nKP+//HvSDOHlj/lZBRsX0Ox2ingyf5tyyCWCTwIkKhZ6W/X0czDqyT
        AtiiDi3qIIGaw3xfuliTYOiZHCtnDnyA89ujbQziS+2f2TeYw72y+aHNaF9AyZ54HvSiaN/T+FLCx
        PcKY8awpO/1xLzhfVXfx09NdMPNKIgWDF2zRwvt5PQfwhd5M/AVlKB9geWHVJ7IsVVCVaGt21Ct2m
        1nxDnOgg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pBD5Q-00AYIS-Po; Fri, 30 Dec 2022 10:58:04 +0000
Date:   Fri, 30 Dec 2022 10:58:04 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Yun Levi <ppbuk5246@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [Question] Unlinking original file of bind mounted file.
Message-ID: <Y67EPM+fIu41hlCO@casper.infradead.org>
References: <CAM7-yPQOZx85f3KxKO1feSPcwYTZGRNNVEgqn4D_+nhhXvqQzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM7-yPQOZx85f3KxKO1feSPcwYTZGRNNVEgqn4D_+nhhXvqQzQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 30, 2022 at 05:08:31PM +0900, Yun Levi wrote:
> Hello fs-devel folks,
> 
> I have a few questions about below situation's handling.
> 
> ======================================================
> 1. mount --bind {somefile} {target}
> 2. rm -f {somefile}
> =======================================================
> 
> when it happens, the step (2)'s operation is working -- it removes.
> But, the inode of {somefile} is live with i_nlink = 0 with an orphan
> state of ext4_inode_info in ext4-fs.
> 
> IIUC, because ext4-inode-entry is removed in the disk via ext4_unlink,
> and it seems possible
> the inode_entry which is freed by unlink in step(2) will be used again
> when a new file is created.

No, that's not correct.  Here's how to think about Unix files (not just
ext4, going all the way back to the 1970s).  Each inode has a reference
count.  All kinds of things hold a reference count to an inode; some of
the more common ones are a name in a directory, an open file, a mmap of
that open file, passing a file descriptor through a unix socket, etc, etc.

Unlink removes a name from a directory.  That causes the reference count
to be decreased, but the inode will only be released if that causes the
reference count to drop to 0.  If the file is open, or it has multiple
names, it won't be removed.

mount --bind obviously isn't traditional Unix, but it fits in the same
paradigm.  It causes a new reference count to be taken on the inode.
So you can remove the original name that was used to create the link,
and that causes i_nlink to drop to 0, but the in-memory refcount is
still positive, so the inode will not be reused.

