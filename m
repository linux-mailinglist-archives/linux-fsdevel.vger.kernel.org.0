Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF3662149C1
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Jul 2020 05:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbgGEDML (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 Jul 2020 23:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728046AbgGEDML (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 Jul 2020 23:12:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E57C061794;
        Sat,  4 Jul 2020 20:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=m+BXN9Ytx6NK3kafN0BfTeKYVvshGw4EyEVUqxlddGg=; b=r/5xO+CDJwnLpUWAykeEJqPcna
        7jaY7a5X/ftYwrLjwrKC71NN9CN4BO4JMYWLpqM4kHxl7w+zLD3IY06Tw6pI13SpD5/Qg76yjCfob
        xjRGi1v0MLZQa7EGddIbtFF/YKkauwo2f5V8nUVrxQYltqaCnQ9JSw3lVg80tn/5oKSAjmBgZ5HXK
        V/Q61jQzCSsB1Y78p5qL9s03jNSu5HnCsHJlpIO18yxHnlqBTJBf3vBwFzIquERMcoheWnvisWSGv
        Bif3ajYNVei5TcRImcla12cETM3F3gVnTCzrLG8BNC4El/vWEm5vJfWlGbJAttDrmU+jGD1aXqd2v
        iMbyN8XA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jrv4a-00021V-DJ; Sun, 05 Jul 2020 03:12:08 +0000
Date:   Sun, 5 Jul 2020 04:12:08 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Jan Ziak <0xe2.0x9a.0x9b@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-man@vger.kernel.org,
        mtk.manpages@gmail.com, shuah@kernel.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCH 0/3] readfile(2): a new syscall to make open/read/close
 faster
Message-ID: <20200705031208.GS25523@casper.infradead.org>
References: <CAODFU0q6CrUB_LkSdrbp5TQ4Jm6Sw=ZepZwD-B7-aFudsOvsig@mail.gmail.com>
 <20200705021631.GR25523@casper.infradead.org>
 <CAODFU0qwtPTaBRbA3_ufA6N7fajhi61Sp5iE75Shdk25NSOTLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAODFU0qwtPTaBRbA3_ufA6N7fajhi61Sp5iE75Shdk25NSOTLA@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jul 05, 2020 at 04:46:04AM +0200, Jan Ziak wrote:
> On Sun, Jul 5, 2020 at 4:16 AM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Sun, Jul 05, 2020 at 04:06:22AM +0200, Jan Ziak wrote:
> > > Hello
> > >
> > > At first, I thought that the proposed system call is capable of
> > > reading *multiple* small files using a single system call - which
> > > would help increase HDD/SSD queue utilization and increase IOPS (I/O
> > > operations per second) - but that isn't the case and the proposed
> > > system call can read just a single file.
> > >
> > > Without the ability to read multiple small files using a single system
> > > call, it is impossible to increase IOPS (unless an application is
> > > using multiple reader threads or somehow instructs the kernel to
> > > prefetch multiple files into memory).
> >
> > What API would you use for this?
> >
> > ssize_t readfiles(int dfd, char **files, void **bufs, size_t *lens);
> >
> > I pretty much hate this interface, so I hope you have something better
> > in mind.
> 
> I am proposing the following:
> 
> struct readfile_t {
>   int dirfd;
>   const char *pathname;
>   void *buf;
>   size_t count;
>   int flags;
>   ssize_t retval; // set by kernel
>   int reserved; // not used by kernel
> };
> 
> int readfiles(struct readfile_t *requests, size_t count);
> 
> Returns zero if all requests succeeded, otherwise the returned value
> is non-zero (glibc wrapper: -1) and user-space is expected to check
> which requests have succeeded and which have failed. retval in
> readfile_t is set to what the single-file readfile syscall would
> return if it was called with the contents of the corresponding
> readfile_t struct.

You should probably take a look at io_uring.  That has the level of
complexity of this proposal and supports open/read/close along with many
other opcodes.
