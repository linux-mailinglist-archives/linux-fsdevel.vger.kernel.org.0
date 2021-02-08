Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EADB31346B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Feb 2021 15:06:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbhBHOE4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Feb 2021 09:04:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232333AbhBHODG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Feb 2021 09:03:06 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3164CC061788;
        Mon,  8 Feb 2021 06:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mIwF8HmqKUBLjBFyeS1Mjx7gZY+Wus4iD1MoxhHXTdc=; b=ekWLTDcknhWy0j6/589jbaOVx0
        LF0ACLiIM8xIUoCsjVWxirkhtfbxpSxIdt9iug61kvF+6/HThXmtNQYXHi5bZy04xAkTeZyfe5ChG
        Yjpq3SFRO8QnaecJcY3xadIZiw41tWlehb0S08A6qURrq9lo75fdikzL+Gc5VkhKE2k97Kb5Z7UrR
        mWlBkfgfe1VJ/lRB8RfZkKD1ASvGoFSNfhTTqkSZpKS5F2PREEiuXV7+kTARvQtPZSljrcmJVAHKw
        qunY1/GVkzBCL0Lvi6sf2cxcrak+wQZvuGNrMsCkaQDs3g2rS7ttQBcLPnetcu03f5ezFF6QWgwLl
        RkcNqb2g==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l977J-00637g-EP; Mon, 08 Feb 2021 14:02:18 +0000
Date:   Mon, 8 Feb 2021 14:02:17 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Dave Chinner <david@fromorbit.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andreas Dilger <adilger@dilger.ca>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Dave Kleikamp <shaggy@kernel.org>,
        David Sterba <dsterba@suse.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Jan Kara <jack@suse.cz>,
        Joel Becker <jlbec@evilplan.org>,
        Mike Marshall <hubcap@omnibond.com>,
        Richard Weinberger <richard@nod.at>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>, Tyler Hicks <code@tyhicks.com>
Subject: Re: [PATCH 00/18] new API for FS_IOC_[GS]ETFLAGS/FS_IOC_FS[GS]ETXATTR
Message-ID: <20210208140217.GQ308988@casper.infradead.org>
References: <20210203130501.GY308988@casper.infradead.org>
 <CAJfpegs3YWybmH7iKDLQ-KwmGieS1faO1uSZ-ADB0UFYOFPEnQ@mail.gmail.com>
 <20210203135827.GZ308988@casper.infradead.org>
 <CAJfpegvHFHcCPtyJ+w6uRx+hLH9JAT46WJktF_nez-ZZAria7A@mail.gmail.com>
 <20210203142802.GA308988@casper.infradead.org>
 <CAJfpegtW5-XObARX87A8siTJNxTCkzXG=QY5tTRXVUvHXXZn3g@mail.gmail.com>
 <20210203145620.GB308988@casper.infradead.org>
 <CAJfpegvV19DT+nQcW5OiLsGWjnp9-DoLAY16S60PewSLcKLTMA@mail.gmail.com>
 <20210208020002.GM4626@dread.disaster.area>
 <CAJfpeguTt+0099BE6DsVFW_jht_AD8_rtuSyxcz=r+JAnazQGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpeguTt+0099BE6DsVFW_jht_AD8_rtuSyxcz=r+JAnazQGA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 08, 2021 at 09:25:22AM +0100, Miklos Szeredi wrote:
> On Mon, Feb 8, 2021 at 3:00 AM Dave Chinner <david@fromorbit.com> wrote:
> >
> > On Wed, Feb 03, 2021 at 04:03:06PM +0100, Miklos Szeredi wrote:
> > > On Wed, Feb 3, 2021 at 3:56 PM Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > > But let's talk specifics.  What does CIFS need to contact the server for?
> > > > Could it be cached earlier?
> > >
> > > I don't understand what CIFS is doing, and I don't really care.   This
> > > is the sort of operation where adding a couple of network roundtrips
> > > so that the client can obtain the credentials required to perform the
> > > operation doesn't really matter.  We won't have thousands of chattr(1)
> > > calls per second.
> >
> > Incorrect.
> 
> Okay, I was wrong.
> 
> Still, CIFS may very well be able to perform these operations without
> a struct file.   But even if it can't, I'd still only add the file
> pointer as an *optional hint* from the VFS, not as the primary object
> as Matthew suggested.
> 
> I stand by my choice of /struct dentry/ as the object to pass to these
> operations.

Why the dentry?  This is an inode operation.  Why doesn't it take an
inode as its primary object?
