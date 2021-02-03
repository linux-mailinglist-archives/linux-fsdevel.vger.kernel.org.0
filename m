Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5774030DC0C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Feb 2021 15:01:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231969AbhBCN7P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Feb 2021 08:59:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231700AbhBCN7M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Feb 2021 08:59:12 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E41C061573;
        Wed,  3 Feb 2021 05:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bMQZ9sGdF4kiy1VwyBsDpeGzjll7erReyrT+FzyYdzY=; b=BbtFhsntImjnyUgYADRrgWEdrq
        UYMVfXJaEd7CX1KRsZ84AINp7vUEZQiGnXdrJkK7+MEEHGjOMmQl7IxDCNuSasbULR0GTBWJAclnH
        4bbn1n6eMt+jm6uOmPSo6FHpsXxv+GkhwuC432Kh3HDLsFj4JA/qsgCTS2v131Th9km15WJl9XwZW
        AlombG2qXOCCk/4tJGlmVgyt+D23Q5wZkm9/LKw3W4rzJnAsVLzH8KyYLntoFmSrxIIHljRLkKVTp
        Nr6kz4o+Mw0NbbudRRHXnglMSIvwinWfciB3o5UGlVs5/wfzgsu81eGqkuo3KVcmA3bmiXEmdhwAX
        3p61UOUQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l7Ifr-00Gyqr-Cv; Wed, 03 Feb 2021 13:58:28 +0000
Date:   Wed, 3 Feb 2021 13:58:27 +0000
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
Message-ID: <20210203135827.GZ308988@casper.infradead.org>
References: <20210203124112.1182614-1-mszeredi@redhat.com>
 <20210203130501.GY308988@casper.infradead.org>
 <CAJfpegs3YWybmH7iKDLQ-KwmGieS1faO1uSZ-ADB0UFYOFPEnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegs3YWybmH7iKDLQ-KwmGieS1faO1uSZ-ADB0UFYOFPEnQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 03, 2021 at 02:13:27PM +0100, Miklos Szeredi wrote:
> On Wed, Feb 3, 2021 at 2:08 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Wed, Feb 03, 2021 at 01:40:54PM +0100, Miklos Szeredi wrote:
> > > This series adds the infrastructure and conversion of filesystems to the
> > > new API.
> > >
> > > Two filesystems are not converted: FUSE and CIFS, as they behave
> > > differently from local filesystems (use the file pointer, don't perform
> > > permission checks).  It's likely that these two can be supported with minor
> > > changes to the API, but this requires more thought.
> >
> > Why not change the API now?  ie pass the file instead of the dentry?
> 
> These are inode attributes we are talking about, not much sense in
> passing an open file to the filesystem.  That was/is due to ioctl
> being an fd based API.

You might as well say "Not much point passing a dentry to the filesystem"
and just pass the inode.

> It would make more sense to convert these filesystems to use a dentry
> instead of a file pointer.  Which is not trivial, unfortuantely.

Network filesystems frequently need to use the credentials attached to
a struct file in order to communicate with the server.  There's no point
fighting this reality.
