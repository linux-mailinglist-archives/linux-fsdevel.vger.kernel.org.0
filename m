Return-Path: <linux-fsdevel+bounces-66960-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD09C31A43
	for <lists+linux-fsdevel@lfdr.de>; Tue, 04 Nov 2025 15:54:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93E1C1884AB5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Nov 2025 14:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E583032F76B;
	Tue,  4 Nov 2025 14:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="OUPe7Vqg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E95832F770;
	Tue,  4 Nov 2025 14:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762267984; cv=none; b=CXyPy5ZoQsDNE35xuBdORrtq3pcFC67IHg7TzZj7G+l7zi+kfQeWm1a1pKEP6fvmqhqyMarrE/GJtUXQr2+KXgyYT6kl9FO7ccCJmO39raG05ne8oc3PXCn2bCQVZEJ2pl5iimwnYVbNzaPAn9Qpq6MqDQwA2hvx9ee4q1roU1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762267984; c=relaxed/simple;
	bh=qInCnx2+Z5thwsd3KEG5EmcqUFc39AtXbpat2Hrf2fk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Cg6nbI3uszU+evd/4YR/9mmXmrUlylpQX6owj22XNhpGcQz3e5YuJqcLo1vkLOdrp6VJLDXDPxJH0TA93Rm8jJ7w9y04QnTMacVOxxlhx8StzQvgsoSnoJ1EmhZixvJRZjQdELHnWIRf0ISTfWLbwrjVPUwAdyNB3Fy1QbeCNNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=OUPe7Vqg; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=oZ3ny1sqekfnMUJ9A/jQipGDI3u5GrYIN0pg9BuU9TA=; b=OUPe7VqgCFHEcg3DbFOlKeTE8r
	e4dlacQgpRpteyraO/7IimBl2voi20CLMWeZeRssrdpF4Nz81nBNujRN1I8iBbTPCxuClURtwmbAS
	oxvwJ5yvyo1PsQt0UsPXLOm/hhOPzlI5G2R6ZLSqhMyRJKhdSchD/nxGNJRkviN4doIzNa5b6Nf7j
	lPvpcVQBqcXtE10+QflexmOUV2WH2Yu06ynlNAgB4Q9FdU+wmGi31ouZNHKOrrKqbaCPyScdasqY7
	SdnM0DsORxNXglnjqeDo1vkXAvo+Zq52Ig6IsRz5sGTBJ60XZyCyDPBVxsaObVKzllF83YHWDfuB2
	wz3je4/A==;
Received: from bl17-145-117.dsl.telepac.pt ([188.82.145.117] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vGIOp-001PW6-8V; Tue, 04 Nov 2025 15:52:43 +0100
From: Luis Henriques <luis@igalia.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>,  Bernd Schubert
 <bernd@bsbernd.com>,  "Theodore Ts'o" <tytso@mit.edu>,  Miklos Szeredi
 <miklos@szeredi.hu>,  Bernd Schubert <bschubert@ddn.com>,
  linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org,  Kevin Chen
 <kchen@ddn.com>
Subject: Re: [RFC] Another take at restarting FUSE servers
In-Reply-To: <CAOQ4uxg7b0mupCVaouPXPGNN=Ji2XceeceUf8L6pW8+vq3uOMQ@mail.gmail.com>
	(Amir Goldstein's message of "Tue, 4 Nov 2025 14:10:32 +0100")
References: <20250731130458.GE273706@mit.edu>
	<20250731173858.GE2672029@frogsfrogsfrogs> <8734abgxfl.fsf@igalia.com>
	<39818613-c10b-4ed2-b596-23b70c749af1@bsbernd.com>
	<CAOQ4uxg1zXPTB1_pFB=hyqjAGjk=AC34qP1k9C043otxcwqJGg@mail.gmail.com>
	<2e57be4f-e61b-4a37-832d-14bdea315126@bsbernd.com>
	<20250912145857.GQ8117@frogsfrogsfrogs>
	<CAOQ4uxhm3=P-kJn3Liu67bhhMODZOM7AUSLFJRiy_neuz6g80g@mail.gmail.com>
	<2e1db15f-b2b1-487f-9f42-44dc7480b2e2@bsbernd.com>
	<CAOQ4uxg8sFdFRxKUcAFoCPMXaNY18m4e1PfBXo+GdGxGcKDaFg@mail.gmail.com>
	<20250916025341.GO1587915@frogsfrogsfrogs>
	<CAOQ4uxhLM11Zq9P=E1VyN7puvBs80v0HrPU6HqY0LLM6HVc_ZQ@mail.gmail.com>
	<87ldkm6n5o.fsf@wotan.olymp>
	<CAOQ4uxg7b0mupCVaouPXPGNN=Ji2XceeceUf8L6pW8+vq3uOMQ@mail.gmail.com>
Date: Tue, 04 Nov 2025 14:52:42 +0000
Message-ID: <87cy5x7sud.fsf@wotan.olymp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 04 2025, Amir Goldstein wrote:

> On Tue, Nov 4, 2025 at 12:40=E2=80=AFPM Luis Henriques <luis@igalia.com> =
wrote:
>>
>> On Tue, Sep 16 2025, Amir Goldstein wrote:
>>
>> > On Tue, Sep 16, 2025 at 4:53=E2=80=AFAM Darrick J. Wong <djwong@kernel=
.org> wrote:
>> >>
>> >> On Mon, Sep 15, 2025 at 10:41:31AM +0200, Amir Goldstein wrote:
>> >> > On Mon, Sep 15, 2025 at 10:27=E2=80=AFAM Bernd Schubert <bernd@bsbe=
rnd.com> wrote:
>> >> > >
>> >> > >
>> >> > >
>> >> > > On 9/15/25 09:07, Amir Goldstein wrote:
>> >> > > > On Fri, Sep 12, 2025 at 4:58=E2=80=AFPM Darrick J. Wong <djwong=
@kernel.org> wrote:
>> >> > > >>
>> >> > > >> On Fri, Sep 12, 2025 at 02:29:03PM +0200, Bernd Schubert wrote:
>> >> > > >>>
>> >> > > >>>
>> >> > > >>> On 9/12/25 13:41, Amir Goldstein wrote:
>> >> > > >>>> On Fri, Sep 12, 2025 at 12:31=E2=80=AFPM Bernd Schubert <ber=
nd@bsbernd.com> wrote:
>> >> > > >>>>>
>> >> > > >>>>>
>> >> > > >>>>>
>> >> > > >>>>> On 8/1/25 12:15, Luis Henriques wrote:
>> >> > > >>>>>> On Thu, Jul 31 2025, Darrick J. Wong wrote:
>> >> > > >>>>>>
>> >> > > >>>>>>> On Thu, Jul 31, 2025 at 09:04:58AM -0400, Theodore Ts'o w=
rote:
>> >> > > >>>>>>>> On Tue, Jul 29, 2025 at 04:38:54PM -0700, Darrick J. Won=
g wrote:
>> >> > > >>>>>>>>>
>> >> > > >>>>>>>>> Just speaking for fuse2fs here -- that would be kinda n=
ifty if libfuse
>> >> > > >>>>>>>>> could restart itself.  It's unclear if doing so will ac=
tually enable us
>> >> > > >>>>>>>>> to clear the condition that caused the failure in the f=
irst place, but I
>> >> > > >>>>>>>>> suppose fuse2fs /does/ have e2fsck -fy at hand.  So may=
be restarts
>> >> > > >>>>>>>>> aren't totally crazy.
>> >> > > >>>>>>>>
>> >> > > >>>>>>>> I'm trying to understand what the failure scenario is he=
re.  Is this
>> >> > > >>>>>>>> if the userspace fuse server (i.e., fuse2fs) has crashed=
?  If so, what
>> >> > > >>>>>>>> is supposed to happen with respect to open files, metada=
ta and data
>> >> > > >>>>>>>> modifications which were in transit, etc.?  Sure, fuse2f=
s could run
>> >> > > >>>>>>>> e2fsck -fy, but if there are dirty inode on the system, =
that's going
>> >> > > >>>>>>>> potentally to be out of sync, right?
>> >> > > >>>>>>>>
>> >> > > >>>>>>>> What are the recovery semantics that we hope to be able =
to provide?
>> >> > > >>>>>>>
>> >> > > >>>>>>> <echoing what we said on the ext4 call this morning>
>> >> > > >>>>>>>
>> >> > > >>>>>>> With iomap, most of the dirty state is in the kernel, so =
I think the new
>> >> > > >>>>>>> fuse2fs instance would poke the kernel with FUSE_NOTIFY_R=
ESTARTED, which
>> >> > > >>>>>>> would initiate GETATTR requests on all the cached inodes =
to validate
>> >> > > >>>>>>> that they still exist; and then resend all the unacknowle=
dged requests
>> >> > > >>>>>>> that were pending at the time.  It might be the case that=
 you have to
>> >> > > >>>>>>> that in the reverse order; I only know enough about the d=
esign of fuse
>> >> > > >>>>>>> to suspect that to be true.
>> >> > > >>>>>>>
>> >> > > >>>>>>> Anyhow once those are complete, I think we can resume ope=
rations with
>> >> > > >>>>>>> the surviving inodes.  The ones that fail the GETATTR rev=
alidation are
>> >> > > >>>>>>> fuse_make_bad'd, which effectively revokes them.
>> >> > > >>>>>>
>> >> > > >>>>>> Ah! Interesting, I have been playing a bit with sending LO=
OKUP requests,
>> >> > > >>>>>> but probably GETATTR is a better option.
>> >> > > >>>>>>
>> >> > > >>>>>> So, are you currently working on any of this?  Are you imp=
lementing this
>> >> > > >>>>>> new NOTIFY_RESTARTED request?  I guess it's time for me to=
 have a closer
>> >> > > >>>>>> look at fuse2fs too.
>> >> > > >>>>>
>> >> > > >>>>> Sorry for joining the discussion late, I was totally occupi=
ed, day and
>> >> > > >>>>> night. Added Kevin to CC, who is going to work on recovery =
on our
>> >> > > >>>>> DDN side.
>> >> > > >>>>>
>> >> > > >>>>> Issue with GETATTR and LOOKUP is that they need a path, but=
 on fuse
>> >> > > >>>>> server restart we want kernel to recover inodes and their l=
ookup count.
>> >> > > >>>>> Now inode recovery might be hard, because we currently only=
 have a
>> >> > > >>>>> 64-bit node-id - which is used my most fuse application as =
memory
>> >> > > >>>>> pointer.
>> >> > > >>>>>
>> >> > > >>>>> As Luis wrote, my issue with FUSE_NOTIFY_RESEND is that it =
just re-sends
>> >> > > >>>>> outstanding requests. And that ends up in most cases in sen=
ding requests
>> >> > > >>>>> with invalid node-IDs, that are casted and might provoke ra=
ndom memory
>> >> > > >>>>> access on restart. Kind of the same issue why fuse nfs expo=
rt or
>> >> > > >>>>> open_by_handle_at doesn't work well right now.
>> >> > > >>>>>
>> >> > > >>>>> So IMHO, what we really want is something like FUSE_LOOKUP_=
FH, which
>> >> > > >>>>> would not return a 64-bit node ID, but a max 128 byte file =
handle.
>> >> > > >>>>> And then FUSE_REVALIDATE_FH on server restart.
>> >> > > >>>>> The file handles could be stored into the fuse inode and al=
so used for
>> >> > > >>>>> NFS export.
>> >> > > >>>>>
>> >> > > >>>>> I *think* Amir had a similar idea, but I don't find the lin=
k quickly.
>> >> > > >>>>> Adding Amir to CC.
>> >> > > >>>>
>> >> > > >>>> Or maybe it was Miklos' idea. Hard to keep track of this rol=
ling thread:
>> >> > > >>>> https://lore.kernel.org/linux-fsdevel/CAJfpegvNZ6Z7uhuTdQ6qu=
BaTOYNkAP8W_4yUY4L2JRAEKxEwOQ@mail.gmail.com/
>> >> > > >>>
>> >> > > >>> Thanks for the reference Amir! I even had been in that thread.
>> >> > > >>>
>> >> > > >>>>
>> >> > > >>>>>
>> >> > > >>>>> Our short term plan is to add something like FUSE_NOTIFY_RE=
START, which
>> >> > > >>>>> will iterate over all superblock inodes and mark them with =
fuse_make_bad.
>> >> > > >>>>> Any objections against that?
>> >> > > >>
>> >> > > >> What if you actually /can/ reuse a nodeid after a restart?  Co=
nsider
>> >> > > >> fuse4fs, where the nodeid is the on-disk inode number.  After =
a restart,
>> >> > > >> you can reconnect the fuse_inode to the ondisk inode, assuming=
 recovery
>> >> > > >> didn't delete it, obviously.
>> >> > > >
>> >> > > > FUSE_LOOKUP_HANDLE is a contract.
>> >> > > > If fuse4fs can reuse nodeid after restart then by all means, it=
 should sign
>> >> > > > this contract, otherwise there is no way for client to know tha=
t the
>> >> > > > nodeids are persistent.
>> >> > > > If fuse4fs_handle :=3D nodeid, that will make implementing the =
lookup_handle()
>> >> > > > API trivial.
>> >> > > >
>> >> > > >>
>> >> > > >> I suppose you could just ask for refreshed stat information an=
d either
>> >> > > >> the server gives it to you and the fuse_inode lives; or the se=
rver
>> >> > > >> returns ENOENT and then we mark it bad.  But I'd have to see c=
ode
>> >> > > >> patches to form a real opinion.
>> >> > > >>
>> >> > > >
>> >> > > > You could make fuse4fs_handle :=3D <nodeid:fuse_instance_id>
>> >> > > > where fuse_instance_id can be its start time or random number.
>> >> > > > for auto invalidate, or maybe the fuse_instance_id should be
>> >> > > > a native part of FUSE protocol so that client knows to only inv=
alidate
>> >> > > > attr cache in case of fuse_instance_id change?
>> >> > > >
>> >> > > > In any case, instead of a storm of revalidate messages after
>> >> > > > server restart, do it lazily on demand.
>> >> > >
>> >> > > For a network file system, probably. For fuse4fs or other block
>> >> > > based file systems, not sure. Darrick has the example of fsck.
>> >> > > Let's assume fuse4fs runs with attribute and dentry timeouts > 0,
>> >> > > fuse-server gets restarted, fsck'ed and some files get removed.
>> >> > > Now reading these inodes would still work - wouldn't it
>> >> > > be better to invalidate the cache before going into operation
>> >> > > again?
>> >> >
>> >> > Forgive me, I was making a wrong assumption that fuse4fs
>> >> > was using ext4 filehandle as nodeid, but of course it does not.
>> >>
>> >> Well now that you mention it, there /is/ a risk of shenanigans like
>> >> that.  Consider:
>> >>
>> >> 1) fuse4fs mount an ext4 filesystem
>> >> 2) crash the fuse4fs server
>> >> <fuse4fs server restart stalls...>
>> >> 3) e2fsck -fy /dev/XXX deletes inode 17
>> >> 4) someone else mounts the fs, makes some changes that result in 17
>> >>    being reallocated, user says "OOOOOPS", unmounts it
>> >> 5) fuse4fs server finally restarts, and reconnects to the kernel
>> >>
>> >> Hey, inode 17 is now a different file!!
>> >>
>> >> So maybe the nodeid has to be an actual file handle.  Oh wait, no,
>> >> everything's (potentially) fine because fuse4fs supplied i_generation=
 to
>> >> the kernel, and fuse_stale_inode will mark it bad if that happens.
>> >>
>> >> Hm ok then, at least there's a way out. :)
>> >>
>> >
>> > Right.
>> >
>> >> > The reason I made this wrong assumption is because fuse4fs *can*
>> >> > already use ext4 (64bit) file handle as nodeid, with existing FUSE =
protocol
>> >> > which is what my fuse passthough library [1] does.
>> >> >
>> >> > My claim was that although fuse4fs could support safe restart, which
>> >> > cannot read from recycled inode number with current FUSE protocol,
>> >> > doing so with FUSE_HANDLE protocol would express a commitment
>> >>
>> >> Pardon my na=C3=AFvete, but what is FUSE_HANDLE?
>> >>
>> >> $ git grep -w FUSE_HANDLE fs
>> >> $
>> >
>> > Sorry, braino. I meant LOOKUP_HANDLE (or FUSE_LOOKUP_HANDLE):
>> > https://lore.kernel.org/linux-fsdevel/CAJfpegvNZ6Z7uhuTdQ6quBaTOYNkAP8=
W_4yUY4L2JRAEKxEwOQ@mail.gmail.com/
>> >
>> > Which means to communicate a variable sized "nodeid"
>> > which can also be declared as an object id that survives server restar=
t.
>> >
>> > Basically, the reason that I brought up LOOKUP_HANDLE is to
>> > properly support NFS export of fuse filesystems.
>> >
>> > My incentive was to support a proper fuse server restart/remount/re-ex=
port
>> > with the same fsid in /etc/exports, but this gives us a better startin=
g point
>> > for fuse server restart/re-connect.
>>
>> Sorry for resurrecting (again!) this discussion.  I've been thinking abo=
ut
>> this, and trying to get some initial RFC for this LOOKUP_HANDLE operatio=
n.
>> However, I feel there are other operations that will need to return this
>> new handle.
>>
>> For example, the FUSE_CREATE (for atomic_open) also returns a nodeid.
>> Doesn't this means that, if the user-space server supports the new
>> LOOKUP_HANDLE, it should also return an handle in reply to the CREATE
>> request?
>
> Yes, I think that's what it means.

Awesome, thank you for confirming this.

>> The same question applies for TMPFILE, LINK, etc.  Or is there
>> something special about the LOOKUP operation that I'm missing?
>>
>
> Any command returning fuse_entry_out.
>
> READDIRPLUS, MKNOD, MKDIR, SYMLINK

Right, I had this list, but totally missed READDIRPLUS.

> fuse_entry_out was extended once and fuse_reply_entry()
> sends the size of the struct.

So, if I'm understanding you correctly, you're suggesting to extend
fuse_entry_out to add the new handle (a 'size' field + the actual handle).
That's probably a good idea.  I was working towards having the
LOOKUP_HANDLE to be similar to LOOKUP, but extending it so that it would
include:

 - An extra inarg: the parent directory handle.  (To be honest, I'm not
   really sure this would be needed.)
 - An extra outarg: for the actual handle.

With your suggestion, only the extra inarg would be required.

> However fuse_reply_create() sends it with fuse_open_out
> appended

This one should be fine...

> and fuse_add_direntry_plus() does not seem to write
> record size at all, so server and client will need to agree on the
> size of fuse_entry_out and this would need to be backward compat.
> If both server and client declare support for FUSE_LOOKUP_HANDLE
> it should be fine (?).

... yeah, this could be a bit trickier.  But I'll need to go look into it.

Thanks a lot for your comments, Amir.  I was trying to get an RFC out
soon(ish) to get early feedback, hoping to prevent me following wrong
paths.

Cheers,
--=20
Lu=C3=ADs

