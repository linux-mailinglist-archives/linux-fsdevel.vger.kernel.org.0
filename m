Return-Path: <linux-fsdevel+bounces-71545-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C294CC6DD7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 10:45:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CFE963042284
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 09:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D3434321D;
	Wed, 17 Dec 2025 09:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Ue+D3Pu7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A21C33B6E9;
	Wed, 17 Dec 2025 09:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765964324; cv=none; b=lHlpcSsTATcFZdVdA/MdrI5AwMT0umNE/18qHq2QBQQUAv7W8Sd6SoxZAfIf7UG6BoBCsTl5EiczwBIv+si1g24NUSSE5Q8g1WySy70gfJnFsVrsTWu5VFPXeqTqFgpZLWGqTxzqpvuYwDFNO/U6zFwwNQ0jaB0Cn8/gekHUp8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765964324; c=relaxed/simple;
	bh=jHcrKNj/7gbuT0MF/uPEzqI3ZwENF6KPti8a80uRO2M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bAnDOHlH45nG1ET4h+P4OVcPx9YeXsR2vwvjw2QYOu2M2H5UZVhBHiswa3hx/UOKXWE3D8Q2p6m5hFoLeNysx+LkfKhOqfGzSzCOI9vJKWGeGopyKlwRxQFGXRrSyIOoY5pAWrkvlo5E756l9bso5MZUHpfTTqU/jBoWNKMTEgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Ue+D3Pu7; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=oa8WvOWzD6otvTr74s2mqSBL+LJuojs7HdjwHGUxgHY=; b=Ue+D3Pu7GEUt7L/CrpbCkg/ulb
	tSyeS7nUBXVyRZpqeeYK+qicLOclp3cZ0DEH0QlDT2VPQZaUQvtV90m1Aoc1z+ZxFxq60zciWUAvX
	emeJkaszTjQyFP8nHP+enFhjbSKmWqWMkeSlcWYxImRIBJjxxi+wvJvj8lC+/reu762QpzIejUF7P
	PwPpebgRIVkHciYfwFAKBXpL7cf+vmxHcO2vR51aY0F0jfaoUWBilAqg5ONtD18240bKXjjCYJ+s+
	hl/8nrnmjPn0IdEo3hHHAYpcWyE1oKhTDklcuKQL22/p3T+plXFMlrGzI3Nrq/UpDu/njcKyILTdn
	O/S1cHdA==;
Received: from bl17-145-117.dsl.telepac.pt ([188.82.145.117] helo=localhost)
	by fanzine2.igalia.com with utf8esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vVnzK-00Dmuo-IR; Wed, 17 Dec 2025 10:38:30 +0100
From: Luis Henriques <luis@igalia.com>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>,  Bernd Schubert
 <bschubert@ddn.com>,  Miklos Szeredi <miklos@szeredi.hu>,  Amir Goldstein
 <amir73il@gmail.com>,  Kevin Chen <kchen@ddn.com>,  Horst Birthelmer
 <hbirthelmer@ddn.com>,  "linux-fsdevel@vger.kernel.org"
 <linux-fsdevel@vger.kernel.org>,  "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>,  Matt Harvey <mharvey@jumptrading.com>,
  "kernel-dev@igalia.com" <kernel-dev@igalia.com>
Subject: Re: [RFC PATCH v2 4/6] fuse: implementation of the
 FUSE_LOOKUP_HANDLE operation
In-Reply-To: <CAJnrk1bVZDA9Q8u+9dpAySuaz+JDGdp9AcYyEMLe9zME35Y48g@mail.gmail.com>
	(Joanne Koong's message of "Wed, 17 Dec 2025 10:48:27 +0800")
References: <20251212181254.59365-1-luis@igalia.com>
	<20251212181254.59365-5-luis@igalia.com>
	<CAJnrk1aN4icSpL4XhVKAzySyVY+90xPG4cGfg7khQh-wXV+VaA@mail.gmail.com>
	<0427cbb9-f3f2-40e6-a03a-204c1798921d@ddn.com>
	<CAJnrk1a8nFhws6L61QSw21A4uR=67JSW+PyDF7jBH-YYFS8CEQ@mail.gmail.com>
	<20251217010046.GC7705@frogsfrogsfrogs>
	<CAJnrk1bVZDA9Q8u+9dpAySuaz+JDGdp9AcYyEMLe9zME35Y48g@mail.gmail.com>
Date: Wed, 17 Dec 2025 09:38:30 +0000
Message-ID: <87ike5xxbd.fsf@wotan.olymp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 17 2025, Joanne Koong wrote:

> On Wed, Dec 17, 2025 at 9:00=E2=80=AFAM Darrick J. Wong <djwong@kernel.or=
g> wrote:
>>
>> On Wed, Dec 17, 2025 at 08:32:02AM +0800, Joanne Koong wrote:
>> > On Tue, Dec 16, 2025 at 4:54=E2=80=AFPM Bernd Schubert <bschubert@ddn.=
com> wrote:
>> > >
>> > > On 12/16/25 09:49, Joanne Koong wrote:
>> > > > On Sat, Dec 13, 2025 at 2:14=E2=80=AFAM Luis Henriques <luis@igali=
a.com> wrote:
>> > > >>
>> > > >> The implementation of LOOKUP_HANDLE modifies the LOOKUP operation=
 to include
>> > > >> an extra inarg: the file handle for the parent directory (if it is
>> > > >> available).  Also, because fuse_entry_out now has a extra variabl=
e size
>> > > >> struct (the actual handle), it also sets the out_argvar flag to t=
rue.
>> > > >>
>> > > >> Most of the other modifications in this patch are a fallout from =
these
>> > > >> changes: because fuse_entry_out has been modified to include a va=
riable size
>> > > >> struct, every operation that receives such a parameter have to ta=
ke this
>> > > >> into account:
>> > > >>
>> > > >>   CREATE, LINK, LOOKUP, MKDIR, MKNOD, READDIRPLUS, SYMLINK, TMPFI=
LE
>> > > >>
>> > > >> Signed-off-by: Luis Henriques <luis@igalia.com>
>> > > >> ---
>> > > >>  fs/fuse/dev.c             | 16 +++++++
>> > > >>  fs/fuse/dir.c             | 87 ++++++++++++++++++++++++++++++---=
------
>> > > >>  fs/fuse/fuse_i.h          | 34 +++++++++++++--
>> > > >>  fs/fuse/inode.c           | 69 +++++++++++++++++++++++++++----
>> > > >>  fs/fuse/readdir.c         | 10 ++---
>> > > >>  include/uapi/linux/fuse.h |  8 ++++
>> > > >>  6 files changed, 189 insertions(+), 35 deletions(-)
>> > > >>
>> > > >
>> > > > Could you explain why the file handle size needs to be dynamically=
 set
>> > > > by the server instead of just from the kernel-side stipulating that
>> > > > the file handle size is FUSE_HANDLE_SZ (eg 128 bytes)? It seems to=
 me
>> > > > like that would simplify a lot of the code logic here.
>> > >
>> > > It would be quite a waste if one only needs something like 12 or 16
>> > > bytes, wouldn't it? 128 is the upper limit, but most file systems wo=
n't
>> > > need that much.
>> >
>> > Ah, I was looking at patch 5 + 6 and thought the use of the lookup
>> > handle was for servers that want to pass it to NFS. But just read
>> > through the previous threads and see now it's for adding server
>> > restart. That makes sense, thanks for clarifying.
>>
>> <-- wakes up from his long slumber
>>
>> Why wouldn't you use the same handle format for NFS and for fuse server
>> restarts?  I would think that having separate formats would cause type
>> confusion and friction.
>>
>> But that said, the fs implementation (fuse server) gets to decide the
>> handle format it uses, because they're just binary blobcookies to the
>> clients.  I think that's why the size is variable.
>>
>> (Also I might be missing some context, if fuse handles aren't used in
>> the same places as nfs handles...)
>
> I think the fuse server would use the same NFS handle format if it
> needs to pass it to NFS but with the server restart stuff, the handle
> will also be used generically by servers that don't need to interact
> with NFS (or at least that's my understanding of it though I might be
> missing some context here too).

That is correct: the handle is to be used both by new FUSE lookup
operation, and by the NFS.  If the FUSE server does not implement this
LOOKUP_HANDLE operation (only the LOOKUP), then the old NFS handle
(nodeid+gen) is used instead.

(A question that just appeared in my mind is whether the two lookup
operations should be exclusive, i.e. if the kernel should explicitly avoid
sending a LOOKUP to a server that implements LOOKUP_HANDLE and vice-versa.
I _think_ the current implementation currently does this, but that was
mostly by accident.)

The relation of all this to the server restartability is that this new
handle will (eventually!) allow a server to recover a connection/mount
because it has to be a unique identifier (as opposed to the nodeid, which
can be reused).  But other use-cases have been mentioned, such as the
usage of open_by_handle_at() for example.

Cheers,
--=20
Lu=C3=ADs

