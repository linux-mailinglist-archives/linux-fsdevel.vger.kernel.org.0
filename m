Return-Path: <linux-fsdevel+bounces-67225-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC45C38374
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 23:42:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EF69734F6CA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 22:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD062F12C5;
	Wed,  5 Nov 2025 22:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="um8kvRLz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FB6291C3F;
	Wed,  5 Nov 2025 22:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762382566; cv=none; b=sgFQRNcZVlrS7XXoU6Ri8tgSp9Mdwjp6lxsDnJRtHmKo4ri9UMsLaa6QeGRddqOmhU6Yup9jog0w5geriCwOCD5Dw1x6uz5pV/NL0BBEkzAqugLqxCbUQ/nVN6QNwLMuzHsetflCKww/frcoE5d3oCQD95j4+Q0O703NqFw6u9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762382566; c=relaxed/simple;
	bh=x96aWo+3oxcfwhk54dst6GQHHvDiaJBKXdpyxACDSKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=copv0r27bEbaKbWxwNvjnnQBukoPZG3UznG/wCD3+NNxChzStojCfh1PoqvpTeQiS+Wsv13k9H+yZnxQtySFwJzUguz7koLBqSgG1q91e9wZN4R67KqIjnq/yy1+aAStHnRmsXCXgf6Pr00n+INU3TWw7Ra38wVnGfk3HQrlYGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=um8kvRLz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7EE0C4CEFB;
	Wed,  5 Nov 2025 22:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762382565;
	bh=x96aWo+3oxcfwhk54dst6GQHHvDiaJBKXdpyxACDSKk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=um8kvRLzl4Ueyn1plegw1+3eFPM+1buAwb2HuOTXQP7Gi/1pzk/uMFOyUZsh/1dXb
	 TisvxISn5xQsYI/HmbNG2BNnyfv9H9iE6YAU7930ViFQCEm8DuUT9JekBs/fM4QELa
	 d7toxbDYElDsbdD8oh2HuQPvcmxp8zGBguFwF7gdFQvnennJmglm7DW9pqUeVc7H+y
	 pp9cOn4JiHz5S88AWU2ds77HTEXkdY2VTXA8r9UqTodRAwjjCpz4QzrusnUD4zkIfX
	 RljBAU2UmDEzpCwDEz5gqBm+1JbDc9h9g9I+tCHVPAEYz/kSRe9tIQgvOAG7hYlVuA
	 sGxpgdzd9nO+Q==
Date: Wed, 5 Nov 2025 14:42:45 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Bernd Schubert <bschubert@ddn.com>
Cc: Amir Goldstein <amir73il@gmail.com>, Luis Henriques <luis@igalia.com>,
	Bernd Schubert <bernd@bsbernd.com>, Theodore Ts'o <tytso@mit.edu>,
	Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, Kevin Chen <kchen@ddn.com>
Subject: Re: [RFC] Another take at restarting FUSE servers
Message-ID: <20251105224245.GP196362@frogsfrogsfrogs>
References: <2e57be4f-e61b-4a37-832d-14bdea315126@bsbernd.com>
 <20250912145857.GQ8117@frogsfrogsfrogs>
 <CAOQ4uxhm3=P-kJn3Liu67bhhMODZOM7AUSLFJRiy_neuz6g80g@mail.gmail.com>
 <2e1db15f-b2b1-487f-9f42-44dc7480b2e2@bsbernd.com>
 <CAOQ4uxg8sFdFRxKUcAFoCPMXaNY18m4e1PfBXo+GdGxGcKDaFg@mail.gmail.com>
 <20250916025341.GO1587915@frogsfrogsfrogs>
 <CAOQ4uxhLM11Zq9P=E1VyN7puvBs80v0HrPU6HqY0LLM6HVc_ZQ@mail.gmail.com>
 <87ldkm6n5o.fsf@wotan.olymp>
 <CAOQ4uxg7b0mupCVaouPXPGNN=Ji2XceeceUf8L6pW8+vq3uOMQ@mail.gmail.com>
 <7ee1e308-c58c-45a0-8ded-6694feae097f@ddn.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7ee1e308-c58c-45a0-8ded-6694feae097f@ddn.com>

On Wed, Nov 05, 2025 at 11:24:01PM +0100, Bernd Schubert wrote:
> 
> 
> On 11/4/25 14:10, Amir Goldstein wrote:
> > On Tue, Nov 4, 2025 at 12:40 PM Luis Henriques <luis@igalia.com> wrote:
> >>
> >> On Tue, Sep 16 2025, Amir Goldstein wrote:
> >>
> >>> On Tue, Sep 16, 2025 at 4:53 AM Darrick J. Wong <djwong@kernel.org> wrote:
> >>>>
> >>>> On Mon, Sep 15, 2025 at 10:41:31AM +0200, Amir Goldstein wrote:
> >>>>> On Mon, Sep 15, 2025 at 10:27 AM Bernd Schubert <bernd@bsbernd.com> wrote:
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>> On 9/15/25 09:07, Amir Goldstein wrote:
> >>>>>>> On Fri, Sep 12, 2025 at 4:58 PM Darrick J. Wong <djwong@kernel.org> wrote:
> >>>>>>>>
> >>>>>>>> On Fri, Sep 12, 2025 at 02:29:03PM +0200, Bernd Schubert wrote:
> >>>>>>>>>
> >>>>>>>>>
> >>>>>>>>> On 9/12/25 13:41, Amir Goldstein wrote:
> >>>>>>>>>> On Fri, Sep 12, 2025 at 12:31 PM Bernd Schubert <bernd@bsbernd.com> wrote:
> >>>>>>>>>>>
> >>>>>>>>>>>
> >>>>>>>>>>>
> >>>>>>>>>>> On 8/1/25 12:15, Luis Henriques wrote:
> >>>>>>>>>>>> On Thu, Jul 31 2025, Darrick J. Wong wrote:
> >>>>>>>>>>>>
> >>>>>>>>>>>>> On Thu, Jul 31, 2025 at 09:04:58AM -0400, Theodore Ts'o wrote:
> >>>>>>>>>>>>>> On Tue, Jul 29, 2025 at 04:38:54PM -0700, Darrick J. Wong wrote:
> >>>>>>>>>>>>>>>
> >>>>>>>>>>>>>>> Just speaking for fuse2fs here -- that would be kinda nifty if libfuse
> >>>>>>>>>>>>>>> could restart itself.  It's unclear if doing so will actually enable us
> >>>>>>>>>>>>>>> to clear the condition that caused the failure in the first place, but I
> >>>>>>>>>>>>>>> suppose fuse2fs /does/ have e2fsck -fy at hand.  So maybe restarts
> >>>>>>>>>>>>>>> aren't totally crazy.
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> I'm trying to understand what the failure scenario is here.  Is this
> >>>>>>>>>>>>>> if the userspace fuse server (i.e., fuse2fs) has crashed?  If so, what
> >>>>>>>>>>>>>> is supposed to happen with respect to open files, metadata and data
> >>>>>>>>>>>>>> modifications which were in transit, etc.?  Sure, fuse2fs could run
> >>>>>>>>>>>>>> e2fsck -fy, but if there are dirty inode on the system, that's going
> >>>>>>>>>>>>>> potentally to be out of sync, right?
> >>>>>>>>>>>>>>
> >>>>>>>>>>>>>> What are the recovery semantics that we hope to be able to provide?
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> <echoing what we said on the ext4 call this morning>
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> With iomap, most of the dirty state is in the kernel, so I think the new
> >>>>>>>>>>>>> fuse2fs instance would poke the kernel with FUSE_NOTIFY_RESTARTED, which
> >>>>>>>>>>>>> would initiate GETATTR requests on all the cached inodes to validate
> >>>>>>>>>>>>> that they still exist; and then resend all the unacknowledged requests
> >>>>>>>>>>>>> that were pending at the time.  It might be the case that you have to
> >>>>>>>>>>>>> that in the reverse order; I only know enough about the design of fuse
> >>>>>>>>>>>>> to suspect that to be true.
> >>>>>>>>>>>>>
> >>>>>>>>>>>>> Anyhow once those are complete, I think we can resume operations with
> >>>>>>>>>>>>> the surviving inodes.  The ones that fail the GETATTR revalidation are
> >>>>>>>>>>>>> fuse_make_bad'd, which effectively revokes them.
> >>>>>>>>>>>>
> >>>>>>>>>>>> Ah! Interesting, I have been playing a bit with sending LOOKUP requests,
> >>>>>>>>>>>> but probably GETATTR is a better option.
> >>>>>>>>>>>>
> >>>>>>>>>>>> So, are you currently working on any of this?  Are you implementing this
> >>>>>>>>>>>> new NOTIFY_RESTARTED request?  I guess it's time for me to have a closer
> >>>>>>>>>>>> look at fuse2fs too.
> >>>>>>>>>>>
> >>>>>>>>>>> Sorry for joining the discussion late, I was totally occupied, day and
> >>>>>>>>>>> night. Added Kevin to CC, who is going to work on recovery on our
> >>>>>>>>>>> DDN side.
> >>>>>>>>>>>
> >>>>>>>>>>> Issue with GETATTR and LOOKUP is that they need a path, but on fuse
> >>>>>>>>>>> server restart we want kernel to recover inodes and their lookup count.
> >>>>>>>>>>> Now inode recovery might be hard, because we currently only have a
> >>>>>>>>>>> 64-bit node-id - which is used my most fuse application as memory
> >>>>>>>>>>> pointer.
> >>>>>>>>>>>
> >>>>>>>>>>> As Luis wrote, my issue with FUSE_NOTIFY_RESEND is that it just re-sends
> >>>>>>>>>>> outstanding requests. And that ends up in most cases in sending requests
> >>>>>>>>>>> with invalid node-IDs, that are casted and might provoke random memory
> >>>>>>>>>>> access on restart. Kind of the same issue why fuse nfs export or
> >>>>>>>>>>> open_by_handle_at doesn't work well right now.
> >>>>>>>>>>>
> >>>>>>>>>>> So IMHO, what we really want is something like FUSE_LOOKUP_FH, which
> >>>>>>>>>>> would not return a 64-bit node ID, but a max 128 byte file handle.
> >>>>>>>>>>> And then FUSE_REVALIDATE_FH on server restart.
> >>>>>>>>>>> The file handles could be stored into the fuse inode and also used for
> >>>>>>>>>>> NFS export.
> >>>>>>>>>>>
> >>>>>>>>>>> I *think* Amir had a similar idea, but I don't find the link quickly.
> >>>>>>>>>>> Adding Amir to CC.
> >>>>>>>>>>
> >>>>>>>>>> Or maybe it was Miklos' idea. Hard to keep track of this rolling thread:
> >>>>>>>>>> https://lore.kernel.org/linux-fsdevel/CAJfpegvNZ6Z7uhuTdQ6quBaTOYNkAP8W_4yUY4L2JRAEKxEwOQ@mail.gmail.com/
> >>>>>>>>>
> >>>>>>>>> Thanks for the reference Amir! I even had been in that thread.
> >>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>>>
> >>>>>>>>>>> Our short term plan is to add something like FUSE_NOTIFY_RESTART, which
> >>>>>>>>>>> will iterate over all superblock inodes and mark them with fuse_make_bad.
> >>>>>>>>>>> Any objections against that?
> >>>>>>>>
> >>>>>>>> What if you actually /can/ reuse a nodeid after a restart?  Consider
> >>>>>>>> fuse4fs, where the nodeid is the on-disk inode number.  After a restart,
> >>>>>>>> you can reconnect the fuse_inode to the ondisk inode, assuming recovery
> >>>>>>>> didn't delete it, obviously.
> >>>>>>>
> >>>>>>> FUSE_LOOKUP_HANDLE is a contract.
> >>>>>>> If fuse4fs can reuse nodeid after restart then by all means, it should sign
> >>>>>>> this contract, otherwise there is no way for client to know that the
> >>>>>>> nodeids are persistent.
> >>>>>>> If fuse4fs_handle := nodeid, that will make implementing the lookup_handle()
> >>>>>>> API trivial.
> >>>>>>>
> >>>>>>>>
> >>>>>>>> I suppose you could just ask for refreshed stat information and either
> >>>>>>>> the server gives it to you and the fuse_inode lives; or the server
> >>>>>>>> returns ENOENT and then we mark it bad.  But I'd have to see code
> >>>>>>>> patches to form a real opinion.
> >>>>>>>>
> >>>>>>>
> >>>>>>> You could make fuse4fs_handle := <nodeid:fuse_instance_id>
> >>>>>>> where fuse_instance_id can be its start time or random number.
> >>>>>>> for auto invalidate, or maybe the fuse_instance_id should be
> >>>>>>> a native part of FUSE protocol so that client knows to only invalidate
> >>>>>>> attr cache in case of fuse_instance_id change?
> >>>>>>>
> >>>>>>> In any case, instead of a storm of revalidate messages after
> >>>>>>> server restart, do it lazily on demand.
> >>>>>>
> >>>>>> For a network file system, probably. For fuse4fs or other block
> >>>>>> based file systems, not sure. Darrick has the example of fsck.
> >>>>>> Let's assume fuse4fs runs with attribute and dentry timeouts > 0,
> >>>>>> fuse-server gets restarted, fsck'ed and some files get removed.
> >>>>>> Now reading these inodes would still work - wouldn't it
> >>>>>> be better to invalidate the cache before going into operation
> >>>>>> again?
> >>>>>
> >>>>> Forgive me, I was making a wrong assumption that fuse4fs
> >>>>> was using ext4 filehandle as nodeid, but of course it does not.
> >>>>
> >>>> Well now that you mention it, there /is/ a risk of shenanigans like
> >>>> that.  Consider:
> >>>>
> >>>> 1) fuse4fs mount an ext4 filesystem
> >>>> 2) crash the fuse4fs server
> >>>> <fuse4fs server restart stalls...>
> >>>> 3) e2fsck -fy /dev/XXX deletes inode 17
> >>>> 4) someone else mounts the fs, makes some changes that result in 17
> >>>>    being reallocated, user says "OOOOOPS", unmounts it
> >>>> 5) fuse4fs server finally restarts, and reconnects to the kernel
> >>>>
> >>>> Hey, inode 17 is now a different file!!
> >>>>
> >>>> So maybe the nodeid has to be an actual file handle.  Oh wait, no,
> >>>> everything's (potentially) fine because fuse4fs supplied i_generation to
> >>>> the kernel, and fuse_stale_inode will mark it bad if that happens.
> >>>>
> >>>> Hm ok then, at least there's a way out. :)
> >>>>
> >>>
> >>> Right.
> >>>
> >>>>> The reason I made this wrong assumption is because fuse4fs *can*
> >>>>> already use ext4 (64bit) file handle as nodeid, with existing FUSE protocol
> >>>>> which is what my fuse passthough library [1] does.
> >>>>>
> >>>>> My claim was that although fuse4fs could support safe restart, which
> >>>>> cannot read from recycled inode number with current FUSE protocol,
> >>>>> doing so with FUSE_HANDLE protocol would express a commitment
> >>>>
> >>>> Pardon my naïvete, but what is FUSE_HANDLE?
> >>>>
> >>>> $ git grep -w FUSE_HANDLE fs
> >>>> $
> >>>
> >>> Sorry, braino. I meant LOOKUP_HANDLE (or FUSE_LOOKUP_HANDLE):
> >>> https://lore.kernel.org/linux-fsdevel/CAJfpegvNZ6Z7uhuTdQ6quBaTOYNkAP8W_4yUY4L2JRAEKxEwOQ@mail.gmail.com/
> >>>
> >>> Which means to communicate a variable sized "nodeid"
> >>> which can also be declared as an object id that survives server restart.
> >>>
> >>> Basically, the reason that I brought up LOOKUP_HANDLE is to
> >>> properly support NFS export of fuse filesystems.
> >>>
> >>> My incentive was to support a proper fuse server restart/remount/re-export
> >>> with the same fsid in /etc/exports, but this gives us a better starting point
> >>> for fuse server restart/re-connect.
> >>
> >> Sorry for resurrecting (again!) this discussion.  I've been thinking about
> >> this, and trying to get some initial RFC for this LOOKUP_HANDLE operation.
> >> However, I feel there are other operations that will need to return this
> >> new handle.
> >>
> >> For example, the FUSE_CREATE (for atomic_open) also returns a nodeid.
> >> Doesn't this means that, if the user-space server supports the new
> >> LOOKUP_HANDLE, it should also return an handle in reply to the CREATE
> >> request?
> > 
> > Yes, I think that's what it means.
> > 
> >> The same question applies for TMPFILE, LINK, etc.  Or is there
> >> something special about the LOOKUP operation that I'm missing?
> >>
> > 
> > Any command returning fuse_entry_out.
> > 
> > READDIRPLUS, MKNOD, MKDIR, SYMLINK
> 
> Btw, checkout out <libfuse>/doc/libfuse-operations.txt for these
> things. With double checking, though, the file was mostly created by AI
> (just added a correction today). With that easy to see the missing
> FUSE_TMPFILE.
> 
> 
> > 
> > fuse_entry_out was extended once and fuse_reply_entry()
> > sends the size of the struct.
> 
> Sorry, I'm confused. Where does fuse_reply_entry() send the size?
> 
> > However fuse_reply_create() sends it with fuse_open_out
> > appended and fuse_add_direntry_plus() does not seem to write
> > record size at all, so server and client will need to agree on the
> > size of fuse_entry_out and this would need to be backward compat.
> > If both server and client declare support for FUSE_LOOKUP_HANDLE
> > it should be fine (?).
> 
> If max_handle size becomes a value in fuse_init_out, server and
> client would use it? I think appended fuse_open_out could just
> follow the dynamic actual size of the handle - code that
> serializes/deserializes the response has to look up the actual
> handle size then. For example I wouldn't know what to put in
> for any of the example/passthrough* file systems as handle size - 
> would need to be 128B, but the actual size will be typically
> much smaller.

name_to_handle_at ?

I guess the problem here is that technically speaking filesystems could
have variable sized handles depending on the file.  Sometimes you encode
just the ino/gen of the child file, but other times you might know the
parent and put that in the handle too.

--D

> 
> Thanks,
> Bernd
> 

