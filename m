Return-Path: <linux-fsdevel+bounces-62159-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E103B8651B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 19:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 680C23A073E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 17:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B9128135D;
	Thu, 18 Sep 2025 17:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vRY4LbNn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A955F2749EA;
	Thu, 18 Sep 2025 17:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758217802; cv=none; b=dl8z5CLe1VxNW1qzv6PV8RO6onp3+i/0D1pu1SJGst63dzUbeqkE1stTGm7CCwa0t1sxyJP2rzAA1iK7jDN0zW8y2trMl9uFUvC8+rzYebNPAHM/BZ0exAKcM4Nkl3F+VxmMvjVbuc/gzzlkHQpf0tkr3RHZyCAcPgbfzo8Vcwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758217802; c=relaxed/simple;
	bh=Fviy6AooPqBlirFUNgRWQ/yLPYm3xPrD+KZwS6ZCyzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n5Ftj1DGg3oAHVYnm1d5QmtFnId440tE9NOSHkw9r3BnnHPpU2v7GO5OBXXhmJoHAXzk06oDfe7IzQO7XNNgWOVoEbVYJqrQRiCaip6Nt2y6WIiGVug+ogI6CpdYZvNBQNZb3nWeZJUsNyXGqqERLx54AekVk7qyGE+o9G20pAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vRY4LbNn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23325C4CEE7;
	Thu, 18 Sep 2025 17:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758217802;
	bh=Fviy6AooPqBlirFUNgRWQ/yLPYm3xPrD+KZwS6ZCyzc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vRY4LbNnxf2Er3fVU5TS418YAf3komQjHsYNi162woTgtAJhhZx0xsEw3IJnEUGMP
	 QXQDRDqlmIVTjTr+g2ta1SkRaF2TXfTcj8Dor7CxtfLlBZ4QDW1rQovmdf4Sf6yYBW
	 QEtHMGY/bMIVKYAFSRW6Kw73Q1bQ1zTuaTdyXcTUAqSaDT9b9SC+iBkLDEdj03TpR8
	 9Fs7lJfvoqJKkgeLI56CUTfyoOw0hy2GMGdjAOu9m9z51I+IYvV1d18wc8JTrhbMJw
	 Sc0rIrGEQIrb4wyfRs0QnSQV6tpx1QRvZckMW4JrcHvU7oXb7WR38CcJ8kbG+S8KOX
	 o7royO5PkW+QA==
Date: Thu, 18 Sep 2025 10:50:01 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Bernd Schubert <bernd@bsbernd.com>, Luis Henriques <luis@igalia.com>,
	Theodore Ts'o <tytso@mit.edu>, Miklos Szeredi <miklos@szeredi.hu>,
	Bernd Schubert <bschubert@ddn.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, Kevin Chen <kchen@ddn.com>
Subject: Re: [RFC] Another take at restarting FUSE servers
Message-ID: <20250918175001.GY8117@frogsfrogsfrogs>
References: <8734abgxfl.fsf@igalia.com>
 <39818613-c10b-4ed2-b596-23b70c749af1@bsbernd.com>
 <CAOQ4uxg1zXPTB1_pFB=hyqjAGjk=AC34qP1k9C043otxcwqJGg@mail.gmail.com>
 <2e57be4f-e61b-4a37-832d-14bdea315126@bsbernd.com>
 <20250912145857.GQ8117@frogsfrogsfrogs>
 <CAOQ4uxhm3=P-kJn3Liu67bhhMODZOM7AUSLFJRiy_neuz6g80g@mail.gmail.com>
 <2e1db15f-b2b1-487f-9f42-44dc7480b2e2@bsbernd.com>
 <CAOQ4uxg8sFdFRxKUcAFoCPMXaNY18m4e1PfBXo+GdGxGcKDaFg@mail.gmail.com>
 <20250916025341.GO1587915@frogsfrogsfrogs>
 <CAOQ4uxhLM11Zq9P=E1VyN7puvBs80v0HrPU6HqY0LLM6HVc_ZQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxhLM11Zq9P=E1VyN7puvBs80v0HrPU6HqY0LLM6HVc_ZQ@mail.gmail.com>

On Tue, Sep 16, 2025 at 09:59:36AM +0200, Amir Goldstein wrote:
> On Tue, Sep 16, 2025 at 4:53 AM Darrick J. Wong <djwong@kernel.org> wrote:
> >
> > On Mon, Sep 15, 2025 at 10:41:31AM +0200, Amir Goldstein wrote:
> > > On Mon, Sep 15, 2025 at 10:27 AM Bernd Schubert <bernd@bsbernd.com> wrote:
> > > >
> > > >
> > > >
> > > > On 9/15/25 09:07, Amir Goldstein wrote:
> > > > > On Fri, Sep 12, 2025 at 4:58 PM Darrick J. Wong <djwong@kernel.org> wrote:
> > > > >>
> > > > >> On Fri, Sep 12, 2025 at 02:29:03PM +0200, Bernd Schubert wrote:
> > > > >>>
> > > > >>>
> > > > >>> On 9/12/25 13:41, Amir Goldstein wrote:
> > > > >>>> On Fri, Sep 12, 2025 at 12:31 PM Bernd Schubert <bernd@bsbernd.com> wrote:
> > > > >>>>>
> > > > >>>>>
> > > > >>>>>
> > > > >>>>> On 8/1/25 12:15, Luis Henriques wrote:
> > > > >>>>>> On Thu, Jul 31 2025, Darrick J. Wong wrote:
> > > > >>>>>>
> > > > >>>>>>> On Thu, Jul 31, 2025 at 09:04:58AM -0400, Theodore Ts'o wrote:
> > > > >>>>>>>> On Tue, Jul 29, 2025 at 04:38:54PM -0700, Darrick J. Wong wrote:
> > > > >>>>>>>>>
> > > > >>>>>>>>> Just speaking for fuse2fs here -- that would be kinda nifty if libfuse
> > > > >>>>>>>>> could restart itself.  It's unclear if doing so will actually enable us
> > > > >>>>>>>>> to clear the condition that caused the failure in the first place, but I
> > > > >>>>>>>>> suppose fuse2fs /does/ have e2fsck -fy at hand.  So maybe restarts
> > > > >>>>>>>>> aren't totally crazy.
> > > > >>>>>>>>
> > > > >>>>>>>> I'm trying to understand what the failure scenario is here.  Is this
> > > > >>>>>>>> if the userspace fuse server (i.e., fuse2fs) has crashed?  If so, what
> > > > >>>>>>>> is supposed to happen with respect to open files, metadata and data
> > > > >>>>>>>> modifications which were in transit, etc.?  Sure, fuse2fs could run
> > > > >>>>>>>> e2fsck -fy, but if there are dirty inode on the system, that's going
> > > > >>>>>>>> potentally to be out of sync, right?
> > > > >>>>>>>>
> > > > >>>>>>>> What are the recovery semantics that we hope to be able to provide?
> > > > >>>>>>>
> > > > >>>>>>> <echoing what we said on the ext4 call this morning>
> > > > >>>>>>>
> > > > >>>>>>> With iomap, most of the dirty state is in the kernel, so I think the new
> > > > >>>>>>> fuse2fs instance would poke the kernel with FUSE_NOTIFY_RESTARTED, which
> > > > >>>>>>> would initiate GETATTR requests on all the cached inodes to validate
> > > > >>>>>>> that they still exist; and then resend all the unacknowledged requests
> > > > >>>>>>> that were pending at the time.  It might be the case that you have to
> > > > >>>>>>> that in the reverse order; I only know enough about the design of fuse
> > > > >>>>>>> to suspect that to be true.
> > > > >>>>>>>
> > > > >>>>>>> Anyhow once those are complete, I think we can resume operations with
> > > > >>>>>>> the surviving inodes.  The ones that fail the GETATTR revalidation are
> > > > >>>>>>> fuse_make_bad'd, which effectively revokes them.
> > > > >>>>>>
> > > > >>>>>> Ah! Interesting, I have been playing a bit with sending LOOKUP requests,
> > > > >>>>>> but probably GETATTR is a better option.
> > > > >>>>>>
> > > > >>>>>> So, are you currently working on any of this?  Are you implementing this
> > > > >>>>>> new NOTIFY_RESTARTED request?  I guess it's time for me to have a closer
> > > > >>>>>> look at fuse2fs too.
> > > > >>>>>
> > > > >>>>> Sorry for joining the discussion late, I was totally occupied, day and
> > > > >>>>> night. Added Kevin to CC, who is going to work on recovery on our
> > > > >>>>> DDN side.
> > > > >>>>>
> > > > >>>>> Issue with GETATTR and LOOKUP is that they need a path, but on fuse
> > > > >>>>> server restart we want kernel to recover inodes and their lookup count.
> > > > >>>>> Now inode recovery might be hard, because we currently only have a
> > > > >>>>> 64-bit node-id - which is used my most fuse application as memory
> > > > >>>>> pointer.
> > > > >>>>>
> > > > >>>>> As Luis wrote, my issue with FUSE_NOTIFY_RESEND is that it just re-sends
> > > > >>>>> outstanding requests. And that ends up in most cases in sending requests
> > > > >>>>> with invalid node-IDs, that are casted and might provoke random memory
> > > > >>>>> access on restart. Kind of the same issue why fuse nfs export or
> > > > >>>>> open_by_handle_at doesn't work well right now.
> > > > >>>>>
> > > > >>>>> So IMHO, what we really want is something like FUSE_LOOKUP_FH, which
> > > > >>>>> would not return a 64-bit node ID, but a max 128 byte file handle.
> > > > >>>>> And then FUSE_REVALIDATE_FH on server restart.
> > > > >>>>> The file handles could be stored into the fuse inode and also used for
> > > > >>>>> NFS export.
> > > > >>>>>
> > > > >>>>> I *think* Amir had a similar idea, but I don't find the link quickly.
> > > > >>>>> Adding Amir to CC.
> > > > >>>>
> > > > >>>> Or maybe it was Miklos' idea. Hard to keep track of this rolling thread:
> > > > >>>> https://lore.kernel.org/linux-fsdevel/CAJfpegvNZ6Z7uhuTdQ6quBaTOYNkAP8W_4yUY4L2JRAEKxEwOQ@mail.gmail.com/
> > > > >>>
> > > > >>> Thanks for the reference Amir! I even had been in that thread.
> > > > >>>
> > > > >>>>
> > > > >>>>>
> > > > >>>>> Our short term plan is to add something like FUSE_NOTIFY_RESTART, which
> > > > >>>>> will iterate over all superblock inodes and mark them with fuse_make_bad.
> > > > >>>>> Any objections against that?
> > > > >>
> > > > >> What if you actually /can/ reuse a nodeid after a restart?  Consider
> > > > >> fuse4fs, where the nodeid is the on-disk inode number.  After a restart,
> > > > >> you can reconnect the fuse_inode to the ondisk inode, assuming recovery
> > > > >> didn't delete it, obviously.
> > > > >
> > > > > FUSE_LOOKUP_HANDLE is a contract.
> > > > > If fuse4fs can reuse nodeid after restart then by all means, it should sign
> > > > > this contract, otherwise there is no way for client to know that the
> > > > > nodeids are persistent.
> > > > > If fuse4fs_handle := nodeid, that will make implementing the lookup_handle()
> > > > > API trivial.
> > > > >
> > > > >>
> > > > >> I suppose you could just ask for refreshed stat information and either
> > > > >> the server gives it to you and the fuse_inode lives; or the server
> > > > >> returns ENOENT and then we mark it bad.  But I'd have to see code
> > > > >> patches to form a real opinion.
> > > > >>
> > > > >
> > > > > You could make fuse4fs_handle := <nodeid:fuse_instance_id>
> > > > > where fuse_instance_id can be its start time or random number.
> > > > > for auto invalidate, or maybe the fuse_instance_id should be
> > > > > a native part of FUSE protocol so that client knows to only invalidate
> > > > > attr cache in case of fuse_instance_id change?
> > > > >
> > > > > In any case, instead of a storm of revalidate messages after
> > > > > server restart, do it lazily on demand.
> > > >
> > > > For a network file system, probably. For fuse4fs or other block
> > > > based file systems, not sure. Darrick has the example of fsck.
> > > > Let's assume fuse4fs runs with attribute and dentry timeouts > 0,
> > > > fuse-server gets restarted, fsck'ed and some files get removed.
> > > > Now reading these inodes would still work - wouldn't it
> > > > be better to invalidate the cache before going into operation
> > > > again?
> > >
> > > Forgive me, I was making a wrong assumption that fuse4fs
> > > was using ext4 filehandle as nodeid, but of course it does not.
> >
> > Well now that you mention it, there /is/ a risk of shenanigans like
> > that.  Consider:
> >
> > 1) fuse4fs mount an ext4 filesystem
> > 2) crash the fuse4fs server
> > <fuse4fs server restart stalls...>
> > 3) e2fsck -fy /dev/XXX deletes inode 17
> > 4) someone else mounts the fs, makes some changes that result in 17
> >    being reallocated, user says "OOOOOPS", unmounts it
> > 5) fuse4fs server finally restarts, and reconnects to the kernel
> >
> > Hey, inode 17 is now a different file!!
> >
> > So maybe the nodeid has to be an actual file handle.  Oh wait, no,
> > everything's (potentially) fine because fuse4fs supplied i_generation to
> > the kernel, and fuse_stale_inode will mark it bad if that happens.
> >
> > Hm ok then, at least there's a way out. :)
> >
> 
> Right.
> 
> > > The reason I made this wrong assumption is because fuse4fs *can*
> > > already use ext4 (64bit) file handle as nodeid, with existing FUSE protocol
> > > which is what my fuse passthough library [1] does.
> > >
> > > My claim was that although fuse4fs could support safe restart, which
> > > cannot read from recycled inode number with current FUSE protocol,
> > > doing so with FUSE_HANDLE protocol would express a commitment
> >
> > Pardon my naïvete, but what is FUSE_HANDLE?
> >
> > $ git grep -w FUSE_HANDLE fs
> > $
> 
> Sorry, braino. I meant LOOKUP_HANDLE (or FUSE_LOOKUP_HANDLE):
> https://lore.kernel.org/linux-fsdevel/CAJfpegvNZ6Z7uhuTdQ6quBaTOYNkAP8W_4yUY4L2JRAEKxEwOQ@mail.gmail.com/
> 
> Which means to communicate a variable sized "nodeid"
> which can also be declared as an object id that survives server restart.
> 
> Basically, the reason that I brought up LOOKUP_HANDLE is to
> properly support NFS export of fuse filesystems.
> 
> My incentive was to support a proper fuse server restart/remount/re-export
> with the same fsid in /etc/exports, but this gives us a better starting point
> for fuse server restart/re-connect.

Ah.  I don't think that's necessary for ext4, but probably desirable for
fancy filesystems that support things like subvolumes or do weird stuff.

--D

> Thanks,
> Amir.

