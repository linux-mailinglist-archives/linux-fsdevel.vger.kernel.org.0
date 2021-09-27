Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05B55419FC6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Sep 2021 22:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236798AbhI0UJJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Sep 2021 16:09:09 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:39998 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236733AbhI0UJG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Sep 2021 16:09:06 -0400
Received: from relay1.suse.de (relay1.suse.de [149.44.160.133])
        by smtp-out2.suse.de (Postfix) with ESMTP id AE35B1FF7C;
        Mon, 27 Sep 2021 20:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1632773245;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kxAIhH1YVtxRZIYXNVbyWMpsZD18tjPURBL8yhlODKY=;
        b=rqCL/ZfaKLBBJ11Lvyjkmko7G0IT9x86WIcCx9OduTjm1NgsLZkg1W4/Fe1cCG/Qk9Yn8S
        4UptkV/P2rPm+amFEtaKPN0FQNf0vfitqRtoMdyT/aUQpEjjB27ybGR9tRkeTK0IWi6EvT
        6Aqpa+pvsMRplJz18xNNO1ZRkBSH1D8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1632773245;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kxAIhH1YVtxRZIYXNVbyWMpsZD18tjPURBL8yhlODKY=;
        b=QEbbg8qe4mXGT8/Upe6yCLvS822wAxZpuHOGT5K9AL53fjW4hFZgMNlgvVQ4RqvbLrzxR0
        6bmSu51+HcRz6eCA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay1.suse.de (Postfix) with ESMTP id 389D425D42;
        Mon, 27 Sep 2021 20:07:24 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 862D3DA799; Mon, 27 Sep 2021 22:07:08 +0200 (CEST)
Date:   Mon, 27 Sep 2021 22:07:08 +0200
From:   David Sterba <dsterba@suse.cz>
To:     David Howells <dhowells@redhat.com>
Cc:     willy@infradead.org, hch@lst.de, trond.myklebust@primarydata.com,
        Theodore Ts'o <tytso@mit.edu>, linux-block@vger.kernel.org,
        ceph-devel@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Jeff Layton <jlayton@kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Anna Schumaker <anna.schumaker@netapp.com>, linux-mm@kvack.org,
        Bob Liu <bob.liu@oracle.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Seth Jennings <sjenning@linux.vnet.ibm.com>,
        Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-cifs@vger.kernel.org, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>,
        Minchan Kim <minchan@kernel.org>,
        Steve French <sfrench@samba.org>, NeilBrown <neilb@suse.de>,
        Dan Magenheimer <dan.magenheimer@oracle.com>,
        linux-nfs@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>,
        linux-btrfs@vger.kernel.org, viro@zeniv.linux.org.uk,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH v3 0/9] mm: Use DIO for swap and fix NFS swapfiles
Message-ID: <20210927200708.GI9286@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, David Howells <dhowells@redhat.com>,
        willy@infradead.org, hch@lst.de, trond.myklebust@primarydata.com,
        Theodore Ts'o <tytso@mit.edu>, linux-block@vger.kernel.org,
        ceph-devel@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Jeff Layton <jlayton@kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Anna Schumaker <anna.schumaker@netapp.com>, linux-mm@kvack.org,
        Bob Liu <bob.liu@oracle.com>, "Darrick J. Wong" <djwong@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Seth Jennings <sjenning@linux.vnet.ibm.com>,
        Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-cifs@vger.kernel.org, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>, Minchan Kim <minchan@kernel.org>,
        Steve French <sfrench@samba.org>, NeilBrown <neilb@suse.de>,
        Dan Magenheimer <dan.magenheimer@oracle.com>,
        linux-nfs@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>,
        linux-btrfs@vger.kernel.org, viro@zeniv.linux.org.uk,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
References: <163250387273.2330363.13240781819520072222.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163250387273.2330363.13240781819520072222.stgit@warthog.procyon.org.uk>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 24, 2021 at 06:17:52PM +0100, David Howells wrote:
> 
> Hi Willy, Trond, Christoph,
> 
> Here's v3 of a change to make reads and writes from the swapfile use async
> DIO, adding a new ->swap_rw() address_space method, rather than readpage()
> or direct_IO(), as requested by Willy.  This allows NFS to bypass the write
> checks that prevent swapfiles from working, plus a bunch of other checks
> that may or may not be necessary.
> 
> Whilst trying to make this work, I found that NFS's support for swapfiles
> seems to have been non-functional since Aug 2019 (I think), so the first
> patch fixes that.  Question is: do we actually *want* to keep this
> functionality, given that it seems that no one's tested it with an upstream
> kernel in the last couple of years?
> 
> There are additional patches to get rid of noop_direct_IO and replace it
> with a feature bitmask, to make btrfs, ext4, xfs and raw blockdevs use the
> new ->swap_rw method and thence remove the direct BIO submission paths from
> swap.
> 
> I kept the IOCB_SWAP flag, using it to enable REQ_SWAP.  I'm not sure if
> that's necessary, but it seems accounting related.
> 
> The synchronous DIO I/O code on NFS, raw blockdev, ext4 swapfile and xfs
> swapfile all seem to work fine.  Btrfs refuses to swapon because the file
> might be CoW'd.  I've tried doing "chattr +C", but that didn't help.

There was probably some step missing. The file must not have holes, so
either do 'dd' to the right size or use fallocate (which is recommended
in manual page btrfs(5) SWAPFILE SUPPORT). There are some fstests
exercising swapfile (grep -l _format_swapfile tests/generic/*) so you
could try that without having to set up the swapfile manually.
