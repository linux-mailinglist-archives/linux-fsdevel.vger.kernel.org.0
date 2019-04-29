Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 516D0EBA1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2019 22:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729323AbfD2U3K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Apr 2019 16:29:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:43032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729212AbfD2U3K (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Apr 2019 16:29:10 -0400
Received: from tleilax.poochiereds.net (cpe-71-70-156-158.nc.res.rr.com [71.70.156.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA9FE215EA;
        Mon, 29 Apr 2019 20:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556569748;
        bh=Jk+Ut6VnEM2gDEMrqDpr5RWbDS4Oxf8tr7ly8mz+Jik=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=qCufzh7q8tN36SxukFrsp771vQ611pxhTQV1P0vzf3gAuRTRrD9hr38va1dBsF9iV
         jGoK7cvRLa5j0Ilrreb7Dq/NAkpWTnsg+ORDgKrDzriDCCGQnh6GU7XeGBIteJ4DRw
         x7h051K/s14BS7ecF4wcQtz86AbUbkEdUniHAPoQ=
Message-ID: <bc2f04c55ba9290fc48d5f2b909262171ca6a19f.camel@kernel.org>
Subject: Re: Better interop for NFS/SMB file share mode/reservation
From:   Jeff Layton <jlayton@kernel.org>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        "amir73il@gmail.com" <amir73il@gmail.com>
Cc:     "bfields@fieldses.org" <bfields@fieldses.org>,
        "samba-technical@lists.samba.org" <samba-technical@lists.samba.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "Volker.Lendecke@sernet.de" <Volker.Lendecke@sernet.de>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "pshilov@microsoft.com" <pshilov@microsoft.com>
Date:   Mon, 29 Apr 2019 16:29:06 -0400
In-Reply-To: <b4ee6b6f5544114c3974790a784c3e784e617ccf.camel@hammerspace.com>
References: <CAOQ4uxjQdLrZXkpP30Pq_=Cckcb=mADrEwQUXmsG92r-gn2y5w@mail.gmail.com>
         <379106947f859bdf5db4c6f9c4ab8c44f7423c08.camel@kernel.org>
         <CAOQ4uxgewN=j3ju5MSowEvwhK1HqKG3n1hBRUQTi1W5asaO1dQ@mail.gmail.com>
         <930108f76b89c93b2f1847003d9e060f09ba1a17.camel@kernel.org>
         <CAOQ4uxgQsRaEOxz1aYzP1_1fzRpQbOm2-wuzG=ABAphPB=7Mxg@mail.gmail.com>
         <20190426140023.GB25827@fieldses.org>
         <CAOQ4uxhuxoEsoBbvenJ8eLGstPc4AH-msrxDC-tBFRhvDxRSNg@mail.gmail.com>
         <20190426145006.GD25827@fieldses.org>
         <e69d149c80187b84833fec369ad8a51247871f26.camel@kernel.org>
         <CAOQ4uxjt+MkufaJWoqWSYZbejWa1nJEe8YYRroEBSb1jHjzkwQ@mail.gmail.com>
         <8504a05f2b0462986b3a323aec83a5b97aae0a03.camel@kernel.org>
         <CAOQ4uxi6fQdp_RQKHp-i6Q-m-G1+384_DafF3QzYcUq4guLd6w@mail.gmail.com>
         <1d5265510116ece75d6eb7af6314e6709e551c6e.camel@hammerspace.com>
         <CAOQ4uxjUBRt99efZMY8EV6SAH+9eyf6t82uQuKWHQ56yjpjqMw@mail.gmail.com>
         <95bc6ace0f46a1b1a38de9b536ce74faaa460182.camel@hammerspace.com>
         <CAOQ4uxhQOLZ_Hyrnvu56iERPZ7CwfKti2U+OgyaXjM9acCN2LQ@mail.gmail.com>
         <b4ee6b6f5544114c3974790a784c3e784e617ccf.camel@hammerspace.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2019-04-29 at 00:57 +0000, Trond Myklebust wrote:
> On Sun, 2019-04-28 at 18:33 -0400, Amir Goldstein wrote:
> > On Sun, Apr 28, 2019 at 6:08 PM Trond Myklebust <
> > trondmy@hammerspace.com> wrote:
> > > On Sun, 2019-04-28 at 18:00 -0400, Amir Goldstein wrote:
> > > > On Sun, Apr 28, 2019 at 11:06 AM Trond Myklebust
> > > > <trondmy@hammerspace.com> wrote:
> > > > > On Sun, 2019-04-28 at 09:45 -0400, Amir Goldstein wrote:
> > > > > > On Sun, Apr 28, 2019 at 8:09 AM Jeff Layton <
> > > > > > jlayton@kernel.org>
> > > > > > wrote:
> > > > > > > On Sat, 2019-04-27 at 16:16 -0400, Amir Goldstein wrote:
> > > > > > > > [adding back samba/nfs and fsdevel]
> > > > > > > > 
> > > > > > > 
> > > > > > > cc'ing Pavel too -- he did a bunch of work in this area a
> > > > > > > few
> > > > > > > years
> > > > > > > ago.
> > > > > > > 
> > > > > > > > On Fri, Apr 26, 2019 at 6:22 PM Jeff Layton <
> > > > > > > > jlayton@kernel.org>
> > > > > > > > wrote:
> > > > > > > > > On Fri, 2019-04-26 at 10:50 -0400, J. Bruce Fields
> > > > > > > > > wrote:
> > > > > > > > > > On Fri, Apr 26, 2019 at 04:11:00PM +0200, Amir
> > > > > > > > > > Goldstein
> > > > > > > > > > wrote:
> > > > > > > > > > > On Fri, Apr 26, 2019, 4:00 PM J. Bruce Fields <
> > > > > > > > > > > bfields@fieldses.org> wrote:
> > > > > > > > > > > 
> > > > > > > > > That said, we could also look at a vfs-level mount
> > > > > > > > > option
> > > > > > > > > that
> > > > > > > > > would
> > > > > > > > > make the kernel enforce these for any opener. That
> > > > > > > > > could
> > > > > > > > > also
> > > > > > > > > be useful,
> > > > > > > > > and shouldn't be too hard to implement. Maybe even make
> > > > > > > > > it
> > > > > > > > > a
> > > > > > > > > vfsmount-
> > > > > > > > > level option (like -o ro is).
> > > > > > > > > 
> > > > > > > > 
> > > > > > > > Yeh, I am humbly going to leave this struggle to someone
> > > > > > > > else.
> > > > > > > > Not important enough IMO and completely independent
> > > > > > > > effort to
> > > > > > > > the
> > > > > > > > advisory atomic open&lock API.
> > > > > > > 
> > > > > > > Having the kernel allow setting deny modes on any open call
> > > > > > > is
> > > > > > > a
> > > > > > > non-
> > > > > > > starter, for the reasons Bruce outlined earlier. This
> > > > > > > _must_ be
> > > > > > > restricted in some fashion or we'll be opening up a
> > > > > > > ginormous
> > > > > > > DoS
> > > > > > > mechanism.
> > > > > > > 
> > > > > > > My proposal was to make this only be enforced by
> > > > > > > applications
> > > > > > > that
> > > > > > > explicitly opt-in by setting O_SH*/O_EX* flags. It wouldn't
> > > > > > > be
> > > > > > > too
> > > > > > > difficult to also allow them to be enforced on a per-fs
> > > > > > > basis
> > > > > > > via
> > > > > > > mount
> > > > > > > option or something. Maybe we could expand the meaning of
> > > > > > > '-o
> > > > > > > mand'
> > > > > > > ?
> > > > > > > 
> > > > > > > How would you propose that we restrict this?
> > > > > > > 
> > > > > > 
> > > > > > Our communication channel is broken.
> > > > > > I did not intend to propose any implicit locking.
> > > > > > If samba and nfsd can opt-in with O_SHARE flags, I do not
> > > > > > understand why a mount option is helpful for the cause of
> > > > > > samba/nfsd interop.
> > > > > > 
> > > > > > If someone else is interested in samba/local interop than
> > > > > > yes, a mount option like suggested by Pavel could be a good
> > > > > > option,
> > > > > > but it is an orthogonal effort IMO.
> > > > > 
> > > > > If an NFS client 'opts in' to set share deny, then that still
> > > > > makes
> > > > > it
> > > > > a non-optional lock for the other NFS clients, because all
> > > > > ordinary
> > > > > open() calls will be gated by the server whether or not their
> > > > > application specifies the O_SHARE flag. There is no flag in the
> > > > > NFS
> > > > > protocol that could tell the server to ignore deny modes.
> > > > > 
> > > > > IOW: it would suffice for 1 client to use O_SHARE|O_DENY* to
> > > > > opt
> > > > > all
> > > > > the other clients in.
> > > > > 
> > > > 
> > > > Sorry for being thick, I don't understand if we are in agreement
> > > > or
> > > > not.
> > > > 
> > > > My understanding is that the network file server implementations
> > > > (i.e. samba, knfds, Ganesha) will always use share/deny modes.
> > > > So for example nfs v3 opens will always use O_DENY_NONE
> > > > in order to have correct interop with samba and nfs v4.
> > > > 
> > > > If I am misunderstanding something, please enlighten me.
> > > > If there is a reason why mount option is needed for the sole
> > > > purpose
> > > > of interop between network filesystem servers, please enlighten
> > > > me.
> > > > 
> > > > 
> > > 
> > > Same difference. As long as nfsd and/or Ganesha are translating
> > > OPEN4_SHARE_ACCESS_READ and OPEN4_SHARE_ACCESS_WRITE into share
> > > access
> > > locks, then those will conflict with any deny locks set by whatever
> > > application that uses them.
> > > 
> > > IOW: any open(O_RDONLY) and open(O_RDWR) will conflict with an
> > > O_DENY_READ that is set on the server, and any open(O_WRONLY) and
> > > open(O_RDWR) will conflict with an O_DENY_WRITE that is set on the
> > > server. There is no opt-out for NFS clients on this issue, because
> > > stateful NFSv4 opens MUST set one or more of
> > > OPEN4_SHARE_ACCESS_READ
> > > and OPEN4_SHARE_ACCESS_WRITE.
> > > 
> > 
> > Urgh! I *think* I understand the confusion.
> > 
> > I believe Jeff was talking about implementing a mount option
> > similar to -o mand for local fs on the server.
> > With that mount option, *any* open() by any app of file from
> > that mount will use O_DENY_NONE to interop correctly with
> > network servers that explicitly opt-in for interop on share modes.
> > I agree its a nice feature that is easy to implement - not important
> > for first version IMO.
> > 
> > I *think* you are talking on nfs client mount option for
> > opt-in/out of share modes? there was no such intention.
> > 
> 
> No. I'm saying that whether you intended to or not, you _are_
> implementing a mandatory lock over NFS. No talk about O_SHARE flags and
> it being an opt-in process for local applications changes the fact that
> non-local applications (i.e. the ones that count ☺) are being subjected
> to a mandatory lock with all the potential for denial of service that
> implies.
> So we need a mechanism beyond O_SHARE in order to ensure this system
> cannot be used on sensitive files that need to be accessible to all. It
> could be an export option, or a mount option, or it could be a more
> specific mechanism (e.g. the setgid with no execute mode bit as using
> in POSIX mandatory locks).
> 

That's a great point.

I was focused on the local fs piece in order to support NFS/SMB serving,
but we also have to consider that people using nfs or cifs filesystems
would want to use this interface to have their clients set deny bits as
well.

So, I think you're right that we can't really do this without involving
non-cooperating processes in some way.

A mount option sounds like the simplest way to do this. We have
SB_MANDLOCK now, so we'd just need a SB_DENYLOCK or something that would
enable the use of O_DENY_READ/WRITE on a file. Maybe '-o denymode' or
something.

You might still get back EBUSY on a nfs or cifs filesystem even without
that option, but there's not much we can do about that.
-- 
Jeff Layton <jlayton@kernel.org>

