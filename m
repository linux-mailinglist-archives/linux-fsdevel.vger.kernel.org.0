Return-Path: <linux-fsdevel+bounces-66931-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A3EC30CA0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 04 Nov 2025 12:41:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D4FB94E9F50
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Nov 2025 11:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E45402EA47E;
	Tue,  4 Nov 2025 11:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="fOPFO5xY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37722E8E00;
	Tue,  4 Nov 2025 11:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762256483; cv=none; b=hWiiKV0XCWgaIMJh/UgJ7rqU3aP3dUrWA2NbuZw51aB02HA8aFGyOrTSB0N5nzBjqGUpU+E+Nsz9xf6Q5+ysaUb8ONqRf85WQU0LJNQOqqq4IOsxJpeljmbEddoghQ++cwmziuDHnyvEL7AqxqM/PInqqnwq6KmCp+F5TngRL8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762256483; c=relaxed/simple;
	bh=DVrYqgjcUjIMn6oDzKHXDbkaaz+vZZ/9sNKfsnKDC3c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=r9GuehdQg7P7xE8SS+2uC24jOln8e4OpzKcnOrQ5QeuCooa8Ury6xa6cmDuo34pCUvmFBUftpnt8M8+vGoCRlN+CvjqZsjhJT1dzjl2TlXhqP/ZgMIloGoVzX9t4VLnExASVRUJxzzJCFWBq+MIefzCBphN/qESNJw5x0xFQ5CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=fOPFO5xY; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=+gIEVXoeuV2P48R970I1VtDR7J+4dUcDPwEf9FWo24c=; b=fOPFO5xY6RxlTKiMRl7x8qAUuJ
	uCOHfpzLFjrSucQGvC08noy1ugVN29qxX6Oj9Tr3ifxLbCU5yAJgNOv8QD3DvtV5McJG+Y7rLuTk7
	MQHzWEbpH2/YgrFBRO3D9sSD3jvgjUqmGmn0M+iGhyqP0aBhXpjtEgyDEoYZoMxWqKSnZz2emicsJ
	Sl0pKbOaqxEjSy+djT2bhScEF9Wx9C4u/UIlhj8MwAR4BD/G/JlvgUnWjwjC0Z2qndtDkrrTxMxrZ
	FRezOiYJdr+gspu0wHaH84NH5IQ1VNUDkjgE/bUKYHkTQIj380VAmoPlQuVn5esML5HbQ6KfJp85+
	HWlP3YgA==;
Received: from bl17-145-117.dsl.telepac.pt ([188.82.145.117] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vGFPA-001KnI-70; Tue, 04 Nov 2025 12:40:52 +0100
From: Luis Henriques <luis@igalia.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>,  Bernd Schubert
 <bernd@bsbernd.com>,  "Theodore Ts'o" <tytso@mit.edu>,  Miklos Szeredi
 <miklos@szeredi.hu>,  Bernd Schubert <bschubert@ddn.com>,
  linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org,  Kevin Chen
 <kchen@ddn.com>
Subject: Re: [RFC] Another take at restarting FUSE servers
In-Reply-To: <CAOQ4uxhLM11Zq9P=E1VyN7puvBs80v0HrPU6HqY0LLM6HVc_ZQ@mail.gmail.com>
	(Amir Goldstein's message of "Tue, 16 Sep 2025 09:59:36 +0200")
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
Date: Tue, 04 Nov 2025 11:40:51 +0000
Message-ID: <87ldkm6n5o.fsf@wotan.olymp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16 2025, Amir Goldstein wrote:

> On Tue, Sep 16, 2025 at 4:53=E2=80=AFAM Darrick J. Wong <djwong@kernel.or=
g> wrote:
>>
>> On Mon, Sep 15, 2025 at 10:41:31AM +0200, Amir Goldstein wrote:
>> > On Mon, Sep 15, 2025 at 10:27=E2=80=AFAM Bernd Schubert <bernd@bsbernd=
.com> wrote:
>> > >
>> > >
>> > >
>> > > On 9/15/25 09:07, Amir Goldstein wrote:
>> > > > On Fri, Sep 12, 2025 at 4:58=E2=80=AFPM Darrick J. Wong <djwong@ke=
rnel.org> wrote:
>> > > >>
>> > > >> On Fri, Sep 12, 2025 at 02:29:03PM +0200, Bernd Schubert wrote:
>> > > >>>
>> > > >>>
>> > > >>> On 9/12/25 13:41, Amir Goldstein wrote:
>> > > >>>> On Fri, Sep 12, 2025 at 12:31=E2=80=AFPM Bernd Schubert <bernd@=
bsbernd.com> wrote:
>> > > >>>>>
>> > > >>>>>
>> > > >>>>>
>> > > >>>>> On 8/1/25 12:15, Luis Henriques wrote:
>> > > >>>>>> On Thu, Jul 31 2025, Darrick J. Wong wrote:
>> > > >>>>>>
>> > > >>>>>>> On Thu, Jul 31, 2025 at 09:04:58AM -0400, Theodore Ts'o wrot=
e:
>> > > >>>>>>>> On Tue, Jul 29, 2025 at 04:38:54PM -0700, Darrick J. Wong w=
rote:
>> > > >>>>>>>>>
>> > > >>>>>>>>> Just speaking for fuse2fs here -- that would be kinda nift=
y if libfuse
>> > > >>>>>>>>> could restart itself.  It's unclear if doing so will actua=
lly enable us
>> > > >>>>>>>>> to clear the condition that caused the failure in the firs=
t place, but I
>> > > >>>>>>>>> suppose fuse2fs /does/ have e2fsck -fy at hand.  So maybe =
restarts
>> > > >>>>>>>>> aren't totally crazy.
>> > > >>>>>>>>
>> > > >>>>>>>> I'm trying to understand what the failure scenario is here.=
  Is this
>> > > >>>>>>>> if the userspace fuse server (i.e., fuse2fs) has crashed?  =
If so, what
>> > > >>>>>>>> is supposed to happen with respect to open files, metadata =
and data
>> > > >>>>>>>> modifications which were in transit, etc.?  Sure, fuse2fs c=
ould run
>> > > >>>>>>>> e2fsck -fy, but if there are dirty inode on the system, tha=
t's going
>> > > >>>>>>>> potentally to be out of sync, right?
>> > > >>>>>>>>
>> > > >>>>>>>> What are the recovery semantics that we hope to be able to =
provide?
>> > > >>>>>>>
>> > > >>>>>>> <echoing what we said on the ext4 call this morning>
>> > > >>>>>>>
>> > > >>>>>>> With iomap, most of the dirty state is in the kernel, so I t=
hink the new
>> > > >>>>>>> fuse2fs instance would poke the kernel with FUSE_NOTIFY_REST=
ARTED, which
>> > > >>>>>>> would initiate GETATTR requests on all the cached inodes to =
validate
>> > > >>>>>>> that they still exist; and then resend all the unacknowledge=
d requests
>> > > >>>>>>> that were pending at the time.  It might be the case that yo=
u have to
>> > > >>>>>>> that in the reverse order; I only know enough about the desi=
gn of fuse
>> > > >>>>>>> to suspect that to be true.
>> > > >>>>>>>
>> > > >>>>>>> Anyhow once those are complete, I think we can resume operat=
ions with
>> > > >>>>>>> the surviving inodes.  The ones that fail the GETATTR revali=
dation are
>> > > >>>>>>> fuse_make_bad'd, which effectively revokes them.
>> > > >>>>>>
>> > > >>>>>> Ah! Interesting, I have been playing a bit with sending LOOKU=
P requests,
>> > > >>>>>> but probably GETATTR is a better option.
>> > > >>>>>>
>> > > >>>>>> So, are you currently working on any of this?  Are you implem=
enting this
>> > > >>>>>> new NOTIFY_RESTARTED request?  I guess it's time for me to ha=
ve a closer
>> > > >>>>>> look at fuse2fs too.
>> > > >>>>>
>> > > >>>>> Sorry for joining the discussion late, I was totally occupied,=
 day and
>> > > >>>>> night. Added Kevin to CC, who is going to work on recovery on =
our
>> > > >>>>> DDN side.
>> > > >>>>>
>> > > >>>>> Issue with GETATTR and LOOKUP is that they need a path, but on=
 fuse
>> > > >>>>> server restart we want kernel to recover inodes and their look=
up count.
>> > > >>>>> Now inode recovery might be hard, because we currently only ha=
ve a
>> > > >>>>> 64-bit node-id - which is used my most fuse application as mem=
ory
>> > > >>>>> pointer.
>> > > >>>>>
>> > > >>>>> As Luis wrote, my issue with FUSE_NOTIFY_RESEND is that it jus=
t re-sends
>> > > >>>>> outstanding requests. And that ends up in most cases in sendin=
g requests
>> > > >>>>> with invalid node-IDs, that are casted and might provoke rando=
m memory
>> > > >>>>> access on restart. Kind of the same issue why fuse nfs export =
or
>> > > >>>>> open_by_handle_at doesn't work well right now.
>> > > >>>>>
>> > > >>>>> So IMHO, what we really want is something like FUSE_LOOKUP_FH,=
 which
>> > > >>>>> would not return a 64-bit node ID, but a max 128 byte file han=
dle.
>> > > >>>>> And then FUSE_REVALIDATE_FH on server restart.
>> > > >>>>> The file handles could be stored into the fuse inode and also =
used for
>> > > >>>>> NFS export.
>> > > >>>>>
>> > > >>>>> I *think* Amir had a similar idea, but I don't find the link q=
uickly.
>> > > >>>>> Adding Amir to CC.
>> > > >>>>
>> > > >>>> Or maybe it was Miklos' idea. Hard to keep track of this rollin=
g thread:
>> > > >>>> https://lore.kernel.org/linux-fsdevel/CAJfpegvNZ6Z7uhuTdQ6quBaT=
OYNkAP8W_4yUY4L2JRAEKxEwOQ@mail.gmail.com/
>> > > >>>
>> > > >>> Thanks for the reference Amir! I even had been in that thread.
>> > > >>>
>> > > >>>>
>> > > >>>>>
>> > > >>>>> Our short term plan is to add something like FUSE_NOTIFY_RESTA=
RT, which
>> > > >>>>> will iterate over all superblock inodes and mark them with fus=
e_make_bad.
>> > > >>>>> Any objections against that?
>> > > >>
>> > > >> What if you actually /can/ reuse a nodeid after a restart?  Consi=
der
>> > > >> fuse4fs, where the nodeid is the on-disk inode number.  After a r=
estart,
>> > > >> you can reconnect the fuse_inode to the ondisk inode, assuming re=
covery
>> > > >> didn't delete it, obviously.
>> > > >
>> > > > FUSE_LOOKUP_HANDLE is a contract.
>> > > > If fuse4fs can reuse nodeid after restart then by all means, it sh=
ould sign
>> > > > this contract, otherwise there is no way for client to know that t=
he
>> > > > nodeids are persistent.
>> > > > If fuse4fs_handle :=3D nodeid, that will make implementing the loo=
kup_handle()
>> > > > API trivial.
>> > > >
>> > > >>
>> > > >> I suppose you could just ask for refreshed stat information and e=
ither
>> > > >> the server gives it to you and the fuse_inode lives; or the server
>> > > >> returns ENOENT and then we mark it bad.  But I'd have to see code
>> > > >> patches to form a real opinion.
>> > > >>
>> > > >
>> > > > You could make fuse4fs_handle :=3D <nodeid:fuse_instance_id>
>> > > > where fuse_instance_id can be its start time or random number.
>> > > > for auto invalidate, or maybe the fuse_instance_id should be
>> > > > a native part of FUSE protocol so that client knows to only invali=
date
>> > > > attr cache in case of fuse_instance_id change?
>> > > >
>> > > > In any case, instead of a storm of revalidate messages after
>> > > > server restart, do it lazily on demand.
>> > >
>> > > For a network file system, probably. For fuse4fs or other block
>> > > based file systems, not sure. Darrick has the example of fsck.
>> > > Let's assume fuse4fs runs with attribute and dentry timeouts > 0,
>> > > fuse-server gets restarted, fsck'ed and some files get removed.
>> > > Now reading these inodes would still work - wouldn't it
>> > > be better to invalidate the cache before going into operation
>> > > again?
>> >
>> > Forgive me, I was making a wrong assumption that fuse4fs
>> > was using ext4 filehandle as nodeid, but of course it does not.
>>
>> Well now that you mention it, there /is/ a risk of shenanigans like
>> that.  Consider:
>>
>> 1) fuse4fs mount an ext4 filesystem
>> 2) crash the fuse4fs server
>> <fuse4fs server restart stalls...>
>> 3) e2fsck -fy /dev/XXX deletes inode 17
>> 4) someone else mounts the fs, makes some changes that result in 17
>>    being reallocated, user says "OOOOOPS", unmounts it
>> 5) fuse4fs server finally restarts, and reconnects to the kernel
>>
>> Hey, inode 17 is now a different file!!
>>
>> So maybe the nodeid has to be an actual file handle.  Oh wait, no,
>> everything's (potentially) fine because fuse4fs supplied i_generation to
>> the kernel, and fuse_stale_inode will mark it bad if that happens.
>>
>> Hm ok then, at least there's a way out. :)
>>
>
> Right.
>
>> > The reason I made this wrong assumption is because fuse4fs *can*
>> > already use ext4 (64bit) file handle as nodeid, with existing FUSE pro=
tocol
>> > which is what my fuse passthough library [1] does.
>> >
>> > My claim was that although fuse4fs could support safe restart, which
>> > cannot read from recycled inode number with current FUSE protocol,
>> > doing so with FUSE_HANDLE protocol would express a commitment
>>
>> Pardon my na=C3=AFvete, but what is FUSE_HANDLE?
>>
>> $ git grep -w FUSE_HANDLE fs
>> $
>
> Sorry, braino. I meant LOOKUP_HANDLE (or FUSE_LOOKUP_HANDLE):
> https://lore.kernel.org/linux-fsdevel/CAJfpegvNZ6Z7uhuTdQ6quBaTOYNkAP8W_4=
yUY4L2JRAEKxEwOQ@mail.gmail.com/
>
> Which means to communicate a variable sized "nodeid"
> which can also be declared as an object id that survives server restart.
>
> Basically, the reason that I brought up LOOKUP_HANDLE is to
> properly support NFS export of fuse filesystems.
>
> My incentive was to support a proper fuse server restart/remount/re-export
> with the same fsid in /etc/exports, but this gives us a better starting p=
oint
> for fuse server restart/re-connect.

Sorry for resurrecting (again!) this discussion.  I've been thinking about
this, and trying to get some initial RFC for this LOOKUP_HANDLE operation.
However, I feel there are other operations that will need to return this
new handle.

For example, the FUSE_CREATE (for atomic_open) also returns a nodeid.
Doesn't this means that, if the user-space server supports the new
LOOKUP_HANDLE, it should also return an handle in reply to the CREATE
request?  The same question applies for TMPFILE, LINK, etc.  Or is there
something special about the LOOKUP operation that I'm missing?

Cheers,
--=20
Lu=C3=ADs

