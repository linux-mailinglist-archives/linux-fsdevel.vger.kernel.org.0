Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9B3930DCBC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Feb 2021 15:28:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232937AbhBCO2v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Feb 2021 09:28:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232931AbhBCO2t (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Feb 2021 09:28:49 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 316C3C061573;
        Wed,  3 Feb 2021 06:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2Ge18xC9FLXty9oYdiqbqe+rDGvC8RbA/BrkeMW4ybk=; b=WeekyKtyxO/B1D02xzTYO8MP4G
        t+Ii2u3OoQ5Ke0xDP+/mVbosBl/fg0nDLi/1jhnocaGsO+7OpjplSu2W8Z/Qb8nqf8HERZ+08h9IH
        gHFpEfAcXm3ecPMBRSVEBVlEhjrbflhRjxZiVPF2Om2Tsy2Fy/yo8rU5CPuRdkIUi1qvGSXnOYZse
        PNqYT2s0bCgeA4i7ffSxhUsoK7zzryYoGUY8k53pLZ6dud3563tfuu9AL+db8Bb3ozo3SOL9Rfeiy
        09qX5U/OC5Zmmg6BYo4pnQGVOqzwPrzWINQ6o51ldBgGwb4wPm5CfVQhrnPgZTFWFyhXCkWmOqTkd
        bPRjCuoQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l7J8U-00H1Wg-F5; Wed, 03 Feb 2021 14:28:03 +0000
Date:   Wed, 3 Feb 2021 14:28:02 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
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
        Matthew Garrett <matthew.garrett@nebula.com>,
        Mike Marshall <hubcap@omnibond.com>,
        Richard Weinberger <richard@nod.at>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>, Tyler Hicks <code@tyhicks.com>
Subject: Re: [PATCH 00/18] new API for FS_IOC_[GS]ETFLAGS/FS_IOC_FS[GS]ETXATTR
Message-ID: <20210203142802.GA308988@casper.infradead.org>
References: <20210203124112.1182614-1-mszeredi@redhat.com>
 <20210203130501.GY308988@casper.infradead.org>
 <CAJfpegs3YWybmH7iKDLQ-KwmGieS1faO1uSZ-ADB0UFYOFPEnQ@mail.gmail.com>
 <20210203135827.GZ308988@casper.infradead.org>
 <CAJfpegvHFHcCPtyJ+w6uRx+hLH9JAT46WJktF_nez-ZZAria7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegvHFHcCPtyJ+w6uRx+hLH9JAT46WJktF_nez-ZZAria7A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 03, 2021 at 03:13:29PM +0100, Miklos Szeredi wrote:
> On Wed, Feb 3, 2021 at 2:58 PM Matthew Wilcox <willy@infradead.org> wrote:
> 
> > Network filesystems frequently need to use the credentials attached to
> > a struct file in order to communicate with the server.  There's no point
> > fighting this reality.
> 
> IDGI.  Credentials can be taken from the file and from the task.  In
> this case every filesystem except cifs looks at task creds. Why are
> network filesystem special in this respect?

I don't necessarily mean 'struct cred'.  I mean "the authentication
that the client has performed to the server".  Which is not a per-task
thing, it's stored in the struct file, which is why we have things like

        int (*write_begin)(struct file *, struct address_space *mapping,
                                loff_t pos, unsigned len, unsigned flags,
                                struct page **pagep, void **fsdata);

disk filesystems ignore the struct file argument, but network filesystems
very much use it.
