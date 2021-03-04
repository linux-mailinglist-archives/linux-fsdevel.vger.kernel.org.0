Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2790832DDFF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Mar 2021 00:50:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233280AbhCDXuK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Mar 2021 18:50:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:50612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232543AbhCDXuK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Mar 2021 18:50:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A8F7F64FEA;
        Thu,  4 Mar 2021 23:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614901809;
        bh=la+/LlUFeQYvhLySDR4vAFpG+8JYc37BPuVHhh/Xkwo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AKCe315TTti7vXaDkftIB9RAiJKo7klEiBS5CoaUGufcb2RT0N6rraHjbpFBjG670
         zodPbs7P67fX4UvV0tbq0GuaoGMl+f1YGJH0AEnJlMT0VvH9OaDMjs0G7F+djIB13h
         a0QayLF3Cc7bYfl/Z5x44VhKF8ijlhkS0SIFIfcYQF0tTzhgzvM3R806Sptq/7AztU
         cSeOmck9FCU63eeS3robzcrzFCv5XDlbI2/l9MdYA8V6nKY80KiwbQ5zc0waiij5NO
         TkD8cNwNDDV3xmipHZWxB8s3i4hBiAdk6vwUDsVQrT1O3ZqiSHDlshsRU2xFJoEbjj
         pT3Qz5nwZR4SQ==
Date:   Thu, 4 Mar 2021 15:50:06 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
Cc:     linux-man@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Luis Henriques <lhenriques@suse.de>,
        Steve French <sfrench@samba.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Jeff Layton <jlayton@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dave Chinner <dchinner@redhat.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Ian Lance Taylor <iant@google.com>,
        Luis Lozano <llozano@chromium.org>,
        Andreas Dilger <adilger@dilger.ca>,
        Olga Kornievskaia <aglo@umich.edu>,
        Christoph Hellwig <hch@infradead.org>,
        ceph-devel <ceph-devel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Walter Harms <wharms@bfs.de>
Subject: Re: [RFC v4] copy_file_range.2: Update cross-filesystem support for
 5.12
Message-ID: <20210304235006.GW7269@magnolia>
References: <20210224142307.7284-1-lhenriques@suse.de>
 <20210304093806.10589-1-alx.manpages@gmail.com>
 <20210304171350.GC7267@magnolia>
 <37df00f9-a88e-3f16-d0b4-3297248aee66@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37df00f9-a88e-3f16-d0b4-3297248aee66@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 04, 2021 at 07:24:02PM +0100, Alejandro Colomar (man-pages) wrote:
> Hi Darrick,
> 
> On 3/4/21 6:13 PM, Darrick J. Wong wrote:
> > On Thu, Mar 04, 2021 at 10:38:07AM +0100, Alejandro Colomar wrote:
> > > +However, on some virtual filesystems,
> > > +the call failed to copy, while still reporting success.
> > 
> > ...success, or merely a short copy?
> 
> Okay.
> 
> > 
> > (The rest looks reasonable (at least by c_f_r standards) to me.)
> 
> I'm curious, what does "c_f_r standards" mean? :)

c_f_r is shorthand for "copy_file_range".

As for standards... well... I'll just say that this being the /second/
major shift in behavior reflects our poor community development
processes.  The door to general cross-fs copies should not have been
thrown open with as little testing as it did.  There are legendary
dchinner rants about how obviously broken the generic fallback was when
it was introduced.

There's a reason why we usually wire up new kernel functionality on an
opt-in basis, and that is to foster gradual enablement as QA resources
permit.  It's one thing for maintainers to blow up their own subsystems
in isolation, and an entirely different thing to do it between projects
with no coordination.

Did c_f_r work between an ext4 and an xfs?  I have no idea.  It seemed
to work between xfses of a similar vintage and featureset, at least, but
that's about as much testing as I have ever managed.

--D

> 
> Cheers,
> 
> Alex
> 
> -- 
> Alejandro Colomar
> Linux man-pages comaintainer; https://www.kernel.org/doc/man-pages/
> http://www.alejandro-colomar.es/
