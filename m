Return-Path: <linux-fsdevel+bounces-71973-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC08CD9242
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 12:42:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6DE99303A1B2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 11:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD2D133554E;
	Tue, 23 Dec 2025 11:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O80TsSIg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7496D10F2
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Dec 2025 11:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766489669; cv=none; b=UiukuHe4f0r4F0mJZAPvnORI4R3pZyO0+GVOJllqC3Gh7vGk21sExUKnGo0nJY1aMLYOcR01A3dGka3iX2+VuRbcMQ++xQknSxRJcdimotgn8HJCDGC5X7CE5dI+jBt4G70qoU1XWUQhUZfiWlWKiVenG1x8xLPDcFvZamzXaoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766489669; c=relaxed/simple;
	bh=C034Ohk5Hd+6karn2UsEEXPOrQF88pxxmlwmolPSEoM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dlcvy7zpXC3TH/BwOfB4HMnfVjmsq11EKp1mb8QXI8Byl/yl2aHSM00zgT5+ySZE3emT8v8e+UPkJbcQrvMjYXCPNOEYoahe4lU50ADhmpbe3IFA0Gweu/J6v6qZPqmAm4iBHguGQl658+LR3Gs6t+PLJ/0o1z/a37J5CMzon7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O80TsSIg; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-5dd88eef2f3so1731764137.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Dec 2025 03:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766489666; x=1767094466; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uksPH/bt5lZqNSEYs+iqY9x3zVZnqcBLH6mlcdZ6GZM=;
        b=O80TsSIg+EwPY43yXK7U808c68uXQzDqgyZv6eSGXAMUZvJjl0o3VXX6ASkdX9p/11
         s4BArD+cifnux2VNBVsXvtOs+zo0QyZ3052Z0yA9gST25UBEWhFVULLQxeboD6lsi04G
         3vShdR0op99NDeA9R0mcq/Bgc1X0P4lucA/76hMVIkd0pa6drKz8ilWQiwS3KAQPhRzX
         YV00P4Em+4oZM214M0rPAfK7FgYmbDCuMOQgjw6I7vj6KAbNv+Tkp8LIAHSuYUmTYvIo
         J86GiA1zhLuqVatI3X8e3UocdhGQ73VZDq+TTl2JiSqXPNVzWFjcVgXsFz/+xr8Zj3VX
         TMOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766489666; x=1767094466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uksPH/bt5lZqNSEYs+iqY9x3zVZnqcBLH6mlcdZ6GZM=;
        b=rfJOwEnjf5lfwCHtF7pXpJJIf5m2EgdFGlg2eWwaPLsD9HFivqaEX61OjE6eqfv/VQ
         xDVug2lwWCDUcTcq56JoM9kbvyeC1zanPwhqNvbb3CYsc+28zg2emQ9TKALoZcxUNHd1
         EFNt/+W5zE0DS0Lmb/Z34pmJP3CNTY7TrLHgknblkRMnoZ1Hxv508mHUUxDanS3Ke7vc
         a2O3WB38Nbx9pp+i5SMnMEHqNorFq6gkeQjnBhax9CJXBXluO0WQRETac5uSNZ1F5q57
         VYvOXbBtw/NPCDrowd9zJGRMysQtgmjJR2tFD130mkUMFrMV8N+wYphLcABN2b2KRheR
         5NDQ==
X-Gm-Message-State: AOJu0Yxa87Yd5Os+JFU9BPSUjhORWLyYYuxQQfBQ2q6WXINYUarexdn9
	H1GCk9yCLowna2AMQgCRP09BzNkJnn5JepJDC+TaE99DuClgB7m/klK/jTQ3x1nfBkQTmBVZk7W
	g9h287AHIJtIEnWAnziaH8Fdl4ECJALR0Q9fc
X-Gm-Gg: AY/fxX4bab5FpGHXA9N2ydhYiol49Oh4OhDNQ24tVuDcXquXfp1vJrcvBa98stIWFQ+
	qPJNou6roqSj7bVMxgaYBEEIRGCDh8eNEHlxHuZyVWdPYg1WZn/9jYb1aSdxHyCf90Z12GRQPbS
	SNepk/4nQ8mY9+J4BkUDv13K4zbT6JzDW4OeSAbMjtpbZGWfRIW5j45mkD33q6XI6ydW2PISsU6
	pQZyMVpuwW9p9ce32L9AYaKEUaxVEVqgls1W5i5LNwK/ETjZVvsmECANtL1CYUHJDPhFUqmrDSO
	sOj3Y7O0vvCsxt94InTYUhkvJPvcMemGwSMr944HNqKwkfvn5j6+PNHpEjE=
X-Google-Smtp-Source: AGHT+IHtMewDH0nrwLunp0cbNlGCqqmmT0A2FaYrWgIGKLCXmMaR4WuAI5YT0d+sWBg1VpYMONc30rJT+m366Xk8YJM=
X-Received: by 2002:a05:6102:2b84:b0:5dd:b288:e780 with SMTP id
 ada2fe7eead31-5eb1a40decbmr4169085137.0.1766489666247; Tue, 23 Dec 2025
 03:34:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251221132402.27293-1-vitalifster@gmail.com> <aUh_--eKRKYOHzLz@kbusch-mbp>
 <CAPqjcqqFN-Axot-5Oxc7pXybQW9gt-+G99NnW6cfC==x39WiAg@mail.gmail.com>
 <CAPqjcqqi8uR=RWEpLEC+JiwOg0fzvWvwEOscj-XYHKLuPcnDBA@mail.gmail.com>
 <9304d77a-7439-4772-a549-5ebcf8bf371d@oracle.com> <CAPqjcqrkR7rc+R2+__iH7LwvC=DM_p-a86W9-UdvOrMfzrtB4g@mail.gmail.com>
In-Reply-To: <CAPqjcqrkR7rc+R2+__iH7LwvC=DM_p-a86W9-UdvOrMfzrtB4g@mail.gmail.com>
From: Vitaliy Filippov <vitalifster@gmail.com>
Date: Tue, 23 Dec 2025 14:34:14 +0300
X-Gm-Features: AQt7F2pD0dtUBlO9h4RGLaeS2l0qoy1k1xLOnOT4yB-0G6pm-UBDhObfcpDmadA
Message-ID: <CAPqjcqqjUMNSc20OeNtK7QO+6EZsjVZgvogKskBBP1expmWKrw@mail.gmail.com>
Subject: Re: [PATCH v2] Do not require atomic writes to be power of 2 sized
 and aligned on length boundary
To: John Garry <john.g.garry@oracle.com>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

For example, in theory, there are also SAS disks which require a
separate WRITE ATOMIC command for writes to be atomic.
I'm not sure which actual disk models support it, though... :)
But as I understand, Linux won't be able to send this command without
the RWF_ATOMIC flag.
And RWF_ATOMIC is limited to 2^N and length-aligned writes so it would
block SAS/SCSI atomic write usage for at least part of use-cases.

On Tue, Dec 23, 2025 at 2:19=E2=80=AFPM Vitaliy Filippov <vitalifster@gmail=
.com> wrote:
>
> What does "just the kernel atomic write rules" mean?
> What's the idea of these restrictions?
> I want to use atomic writes, but without this restriction.
> And generally I don't think this restriction is needed for anyone at all.
> That's why I ask - can it be removed? Can I remove it in my patch?
>
> On Tue, Dec 23, 2025 at 12:26=E2=80=AFPM John Garry <john.g.garry@oracle.=
com> wrote:
> >
> > On 22/12/2025 13:28, Vitaliy Filippov wrote:
> > > Hi linux-fsdevel,
> > > I recently discovered that Linux incorrectly requires all atomic
> > > writes to have 2^N length and to be aligned on the length boundary.
> > > This requirement contradicts NVMe specification which doesn't require
> > > such alignment and length and thus highly restricts usage of atomic
> > > writes with NVMe disks which support it (Micron and Kioxia).
> >
> > All these alignment and size rules are specific to using RWF_ATOMIC. Yo=
u
> > don't have to use RWF_ATOMIC if you don't want to - as you prob know,
> > atomic writes are implicit on NVMe.
> >
> > > NVMe specification has its own atomic write restrictions - AWUPF and
> > > NABSPF/NABO, but both are already checked by the nvme subsystem.
> > > The 2^N restriction comes from generic_atomic_write_valid().
> > > I submitted a patch which removes this restriction to linux-block and
> > > linux-nvme. Sorry if these maillists weren't the right place to send
> > > it to, it's my first patch :).
> > > But the function is currently used in 3 places: block/fops.c,
> > > fs/ext4/file.c and fs/xfs/xfs_file.c.
> > > Can you tell me if ext4 and xfs really want atomic writes to be 2^N
> > > sized and length-aligned?
> >
> > As above, this is just the kernel atomic write rules to support using
> > different storage technologies.
> >
> > >  From looking at the code I'd say they don't really require it?
> > > Can you approve my patch if I'm right? Please :-)
> > >
> > > On Mon, Dec 22, 2025 at 12:54=E2=80=AFPM Vitaliy Filippov <vitalifste=
r@gmail.com> wrote:
> > >>
> > >> Hi! Thanks a lot for your reply! This is actually my first patch eve=
r
> > >> so please don't blame me for not following some standards, I'll try =
to
> > >> resubmit it correctly.
> > >>
> > >> Regarding the rest:
> > >>
> > >> 1) NVMe atomic boundaries seem to already be checked in
> > >> nvme_valid_atomic_write().
> > >>
> > >> 2) What's atomic_write_hw_unit_max? As I understand, Linux also
> > >> already checks it, at least
> > >> /sys/block/nvme**/queue/atomic_write_max_bytes is already limited by
> > >> max_hw_sectors_kb.
> > >>
> > >> 3) Yes, I've of course seen that this function is also used by ext4
> > >> and xfs, but I don't understand the motivation behind the 2^n
> > >> requirement. I suppose file systems may fragment the write according
> > >> to currently allocated extents for example, but I don't see how issu=
es
> > >> coming from this can be fixed by requiring writes to be 2^n.
> > >>
> > >> But I understand that just removing the check may break something if
> > >> somebody relies on them. What do you think about removing the
> > >> requirement only for NVMe or only for block devices then? I see 3 wa=
ys
> > >> to do it:
> > >> a) split generic_atomic_write_valid() into two functions - first for
> > >> all types of inodes and second only for file systems.
> > >> b) remove generic_atomic_write_valid() from block device checks at a=
ll.
> > >> c) change generic_atomic_write_valid() just like in my original patc=
h
> > >> but copy original checks into other places where it's used (ext4 and
> > >> xfs).
> > >>
> > >> Which way do you think would be the best?
> > >>
> > >> On Mon, Dec 22, 2025 at 2:17=E2=80=AFAM Keith Busch <kbusch@kernel.o=
rg> wrote:
> > >>>
> > >>> On Sun, Dec 21, 2025 at 04:24:02PM +0300, Vitaliy Filippov wrote:
> > >>>> It contradicts NVMe specification where alignment is only required=
 when atomic
> > >>>> write boundary (NABSPF/NABO) is set and highly limits usage of NVM=
e atomic writes
> > >>>
> > >>> Commit header is missing the "fs:" prefix, and the commit log shoul=
d
> > >>> wrap at 72 characters.
> > >>>
> > >>> On the techincal side, this is a generic function used by multiple
> > >>> protocols, so you can't just appeal to NVMe to justify removing the
> > >>> checks.
> > >>>
> > >>> NVMe still has atomic boundaries where straddling it fails to be an
> > >>> atomic operation. Instead of removing the checks, you'd have to rep=
lace
> > >>> it with a more costly operation if you really want to support more
> > >>> arbitrary write lengths and offsets. And if you do manage to remove=
 the
> > >>> power of two requirement, then the queue limit for nvme's
> > >>> atomic_write_hw_unit_max isn't correct anymore.
> > >
> >

