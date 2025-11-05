Return-Path: <linux-fsdevel+bounces-67117-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D99DFC358F6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 13:08:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0986A4E3A94
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 12:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B598313520;
	Wed,  5 Nov 2025 12:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="f9V8CaEy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779B12FBDF9;
	Wed,  5 Nov 2025 12:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762344484; cv=none; b=LF55c375cLVPjztZWzgttkWv6SeHy38AV33EPI4VBtvwwme+67VqlsbrxPMRUsroQL/yR4y/1Krl4ozvUQemuOOkaVOTNhwfgPJj+suUCkcobtwYy5BGqOC/wyBvgy39XeL2sSBQH5JpbWJ//waT/LErUa4jDujcc6N9NuLtbQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762344484; c=relaxed/simple;
	bh=+ptFIIXNux56jTdIHkQh+L0ymiChNnE4O2KJNDkHPx4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MkrhAh3PSjAAXwojtme1GuT5qZNuDZ6dqCLtXBQhoHAbF43uff5q+l5IUunSB/8ypO1VF2u04bsugdebk79JwaPCn2MWXtPGv43cjRPmem6EJm9ND9slOxAn6qf48nv2JSEQl9Tdpo+wGSCNQzyeAn3FCBHUJ/h2sn9rEVQ+QUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=f9V8CaEy; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=vTO8EnjLO5swXZ6FWpsMmIsZo65AKmUpAPijx6QQubU=; b=f9V8CaEybgkktQHZDnmRRUifDF
	4YlSzUZXbkX7AMBR8YHq4Y+cmf+VrUJSThnF1VFt08HaUH4TMuMA/eriRvWPMmOApZr7HlRK97uXt
	dluCEOenGgBBxqwfoBu+ar3jZ1jVBaMpLTMbdqdQjoUEi7+cHVC8MvilUuPllJjmj8/IQm64MyFOH
	cfmPvJfDSDwSkOWrIE5tEzTqY5YkjxFEepLT5rKvCQt8LCgbcNxUCqp6Mi4bm5zIxWUa9Ssniz1zu
	TVW/Lp0x80oojUsTjOyEJr9IUePfOfE5wLBUA4S5OfdK0GvsDuMXWUlqydtRuXF2tXxirJl65YL8R
	4nw3Colg==;
Received: from bl17-145-117.dsl.telepac.pt ([188.82.145.117] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vGc2G-002Lpq-A4; Wed, 05 Nov 2025 12:50:44 +0100
From: Luis Henriques <luis@igalia.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>,  Bernd Schubert
 <bernd@bsbernd.com>,  "Theodore Ts'o" <tytso@mit.edu>,  Miklos Szeredi
 <miklos@szeredi.hu>,  Bernd Schubert <bschubert@ddn.com>,
  linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org,  Kevin Chen
 <kchen@ddn.com>,
    Matt Harvey <mharvey@jumptrading.com>
Subject: Re: [RFC] Another take at restarting FUSE servers
In-Reply-To: <CAOQ4uxjZ0B5TwV+HiWsUpBuFuZJZ_e4Bm_QfNn4crDoVAfkA9Q@mail.gmail.com>
	(Amir Goldstein's message of "Wed, 5 Nov 2025 11:21:14 +0100")
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
	<87cy5x7sud.fsf@wotan.olymp>
	<CAOQ4uxjZ0B5TwV+HiWsUpBuFuZJZ_e4Bm_QfNn4crDoVAfkA9Q@mail.gmail.com>
Date: Wed, 05 Nov 2025 11:50:43 +0000
Message-ID: <87ecqcpujw.fsf@wotan.olymp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Amir,

On Wed, Nov 05 2025, Amir Goldstein wrote:

> On Tue, Nov 4, 2025 at 3:52=E2=80=AFPM Luis Henriques <luis@igalia.com> w=
rote:

<...>

>> > fuse_entry_out was extended once and fuse_reply_entry()
>> > sends the size of the struct.
>>
>> So, if I'm understanding you correctly, you're suggesting to extend
>> fuse_entry_out to add the new handle (a 'size' field + the actual handle=
).
>
> Well it depends...
>
> There are several ways to do it.
> I would really like to get Miklos and Bernd's opinion on the preferred wa=
y.

Sure, all feedback is welcome!

> So far, it looks like the client determines the size of the output args.
>
> If we want the server to be able to write a different file handle size
> per inode that's going to be a bigger challenge.
>
> I think it's plenty enough if server and client negotiate a max file hand=
le
> size and then the client always reserves enough space in the output
> args buffer.
>
> One more thing to ask is what is "the actual handle".
> If "the actual handle" is the variable sized struct file_handle then
> the size is already available in the file handle header.

Actually, this is exactly what I was trying to mimic for my initial
attempt.  However, I was not going to do any size negotiation but instead
define a maximum size for the handle.  See below.

> If it is not, then I think some sort of type or version of the file handl=
es
> encoding should be negotiated beyond the max handle size.

In my initial stab at this I was going to take a very simple approach and
hard-code a maximum size for the handle.  This would have the advantage of
allowing the server to use different sizes for different inodes (though
I'm not sure how useful that would be in practice).  So, in summary, I
would define the new handle like this:

/* Same value as MAX_HANDLE_SZ */
#define FUSE_MAX_HANDLE_SZ 128

struct fuse_file_handle {
	uint32_t	size;
	uint32_t	padding;
	char		handle[FUSE_MAX_HANDLE_SZ];
};

and this struct would be included in fuse_entry_out.

There's probably a problem with having this (big) fixed size increase to
fuse_entry_out, but maybe that could be fixed once I have all the other
details sorted out.  Hopefully I'm not oversimplifying the problem,
skipping the need for negotiating a handle size.

>> That's probably a good idea.  I was working towards having the
>> LOOKUP_HANDLE to be similar to LOOKUP, but extending it so that it would
>> include:
>>
>>  - An extra inarg: the parent directory handle.  (To be honest, I'm not
>>    really sure this would be needed.)
>
> Yes, I think you need extra inarg.
> Why would it not be needed?
> The problem is that you cannot know if the parent node id in the lookup
> command is stale after server restart.

Ah, of course.  Hence the need for this extra inarg.

> The thing is that the kernel fuse inode will need to store the file handl=
e,
> much the same as an NFS client stores the file handle provided by the
> NFS server.
>
> FYI, fanotify has an optimized way to store file handles in
> struct fanotify_fid_event - small file handles are stored inline
> and larger file handles can use an external buffer.
>
> But fuse does not need to support any size of file handles.
> For first version we could definitely simplify things by limiting the size
> of supported file handles, because server and client need to negotiate
> the max file handle size anyway.

I'll definitely need to have a look at how fanotify does that.  But I
guess that if my simplistic approach with a static array is acceptable for
now, I'll stick with it for the initial attempt to implement this, and
eventually revisit it later to do something more clever.

>>  - An extra outarg: for the actual handle.
>>
>> With your suggestion, only the extra inarg would be required.
>>
>
> Yes, either extra arg or just an extended size of fuse_entry_out
> negotiated at init time.
>
> TBH it seems cleaner to add 2nd outarg to all the commands,
> but CREATE already has a 2nd arg and 2nd arg does not solve
> READDIRPLUS.

Right.  I'm more and more convinced that extending fuse_entry_out is the
way to go.

>> > However fuse_reply_create() sends it with fuse_open_out
>> > appended
>>
>> This one should be fine...
>>
>> > and fuse_add_direntry_plus() does not seem to write
>> > record size at all, so server and client will need to agree on the
>> > size of fuse_entry_out and this would need to be backward compat.
>> > If both server and client declare support for FUSE_LOOKUP_HANDLE
>> > it should be fine (?).
>>
>> ... yeah, this could be a bit trickier.  But I'll need to go look into i=
t.
>>
>> Thanks a lot for your comments, Amir.  I was trying to get an RFC out
>> soon(ish) to get early feedback, hoping to prevent me following wrong
>> paths.
>>
>
> Disclaimer, following my advice may well lead you down wrong paths..
> Best to wait for confirmation from Miklos and Bernd if you want to have
> more certainty...

Haha thanks for the warning :-)

And again, thanks a lot for your feedback, Amir.

Cheers,
--=20
Lu=C3=ADs

