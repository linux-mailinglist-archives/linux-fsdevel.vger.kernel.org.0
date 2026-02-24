Return-Path: <linux-fsdevel+bounces-78315-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4OzwLR4knmn5TgQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78315-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 23:20:14 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 36B8018D172
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 23:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 57A783017510
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 22:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104123191BB;
	Tue, 24 Feb 2026 22:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mbyR0iMF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECBD263F34
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Feb 2026 22:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771971610; cv=pass; b=OdXvNZtz0bwPcuOCXmM0dp1s90kY7C/vJxCToeLz9Btq/cD4M4TljpeHq/2iQvM8K3jCco5G57MYZsBch6XFeu2+WB0IV5wdsMsGsUqsthzQiG7BH8cxj2lLkBT12G5IUw3sJOy/d5vtBXKHcVFKdfncG4EkiMsT29wO8eyNCjA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771971610; c=relaxed/simple;
	bh=TMIFMqdBl4eMMy+jCyFV21h7j8GU0gDuLzYzqhVKvVY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NzZqllWMkUnfZ/lWwPxc0ZEznXV2QTswGhkalAhThvB49Idj4i+4j08Pdgk3W0N7fkN4pcrjq9dgXajov75ICIXdK5sSLPp8CnJxC5+wRyTWikyaDVZ1Wjz0u1R6aMgprku0fsJVbV+IGZ8Ej/sfVnOtPox9NQqTyPvK1mJD8Kg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mbyR0iMF; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-506a019a7f3so76185621cf.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Feb 2026 14:20:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771971608; cv=none;
        d=google.com; s=arc-20240605;
        b=POXAYB49ydphfk87dqHrI1U5Vz7yMQ/ByA7rCzQvBM6ZJKi1SzsV11yBM0A+gFZ6+G
         V3uJOZFU/UJYACfR1zKmfGKV46BrcVLfy1ozlpgGMBn8qScBjYYvrP1Vfp4sZujfKogw
         Z7Oc+ORnSt3qXj8WWpcj9kHLZyovnL3qLgY5en7ouDGkjTTsrjRiAkXNefueTuNmyGUn
         UL8xJEIkG5CIjMB1g8rw1DXSg6nQQcn5Cy5dQn9Rsi0SIbxCnjLaeRo8lnxP5eDbSpmw
         H3c7FWKBP7OKYv/daN4YueMqhaCtdECTzzTxEeBT+3U3opn1u2Wh87jA3bIlxsq/8xO0
         VKJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TMIFMqdBl4eMMy+jCyFV21h7j8GU0gDuLzYzqhVKvVY=;
        fh=XX7VX/xT1eCawMId5fvCyJhrd4z792v6iVyqX85quIw=;
        b=UwsVqghcJsGEL9Tc1ejHxDN13ycTIK14AJJqsqB6KQ9smFwvjRgIGslb/MtB6Ln1Ge
         3K7mCBpT+L6RKxajkCEB4K0etUWL/F8f1ZZ1LGqfpBHW6lyLBDcjmzzm9RtVfZwCUHtQ
         CqfSZYEJX9bDhznHuFcPgJfuC3DSTa6kMvNJHkGQmFxzhOTO8zNk2K2qPpJXGsNemCMz
         o7h/vmCNbkbHnXno3TC6WcZzrVIOfpNeRC4712vgm2wMa6JeZ5MixbVQJlNR4PGMWVKp
         TITBegN0xqGt0OwI2QjUPA/AGNw7xtrxJvviTEAJFTCDAoNgYsonoDADbkA4dAbpqeJg
         68JQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771971608; x=1772576408; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TMIFMqdBl4eMMy+jCyFV21h7j8GU0gDuLzYzqhVKvVY=;
        b=mbyR0iMFQ7EHSGPAylOzgv1CR3Op0UHLIZUuHZhwX1sgmmONJFq75imbCT1EYUJ1ws
         bnoK8F2KabWF2w+JNK3hkPXR6IVAbuB1nZL7Fe+Y0C9DGhMpjwRAOQgwVdXp4L3ldtCh
         dRBwj+zr7UiaD+plyfbsbwmeESeJkEZStxW5/EwnPjsR74WPt55uimQDWRHs3/pRqsJ2
         wPEjyzykH8Ku+/1z3DdcjvWpn8NPZWjyYDIbpG3LRR9Js4TuSfvEkRYuVOfIYMbz4EYl
         KDMZ3OdyMIXor9ABhSf9oOo/QctglDZHBj3cprUWxMxgIItdyR4WXKQg9JV7uxT1W2Mz
         uQOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771971608; x=1772576408;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TMIFMqdBl4eMMy+jCyFV21h7j8GU0gDuLzYzqhVKvVY=;
        b=lyiwe71RfE6x8utKus+6nQPrLdN91KxcpPY4Bc6vHyxRsLDLpiMA2nmKgCUmKCsbgp
         wTCS9ayW/Jz5q7NpNA2c6KtnTUZuojVIdoqQ9sRuoD6kR8wb2A6Se4ZyNUgSQi1IvlUz
         IYvecvoL+CYZNxQ5c3Lja1W9b/I35IBWv/GPiIr2FxklJQ51CY5YebdTO8HcdL7t6KUo
         +kCu8mmBdW2YGpJAM9WGz8SMl52lrz46PErktFq400GUEl6bNx2TljSbzvOVrpw/6pGX
         gmUVuuCl8mBosJEmdLUaurY1Hhf/as5Wg8hircIZiiL4fCym6xARJxh1CDR+4upJaL/m
         xQvg==
X-Forwarded-Encrypted: i=1; AJvYcCWQLmJYjHV5YPFUl5lmtDOPZX+BQsNu/XiqZzHQL3p7+cnXS1gbP2/52xO+YKFlZXYNRrLb3P0/G7E9IX8I@vger.kernel.org
X-Gm-Message-State: AOJu0YxonPxbYubHEfPEm9/eiCo1472TMIKKIkI+OiY2EKmvf6EJkVHc
	36SsQPfF2gOtV0LjBaD/sG6SNeUp2pWWWsbOZWfV6G21RJEfyrBcATV3NOItH730ekL2OO/Tfib
	W75VmMQTBT7NkjoObDJCaX1yQwmO2Ie4=
X-Gm-Gg: ATEYQzwX4dMOvC2HCJxvevVxAyV4LyHzOJ2Wc8uM3PCTf056hOnZ9W4lNDxNEdMIU7h
	2l/QwRRC5ESMdkKQkhudWO9LkMUBOwkdLH1mtcM6HgfIyYnfkDtfd+kkDiPAQtc+RAYHNe0yaqx
	YIbp5WAXUskKZ8W3TR7jv+XNUopriwhNQtneibkkrzz81QB7jJqCAJimS3arTbtXD4T9+5Z71uW
	bl0n8HVUOMz5C59Ek3Dei3GlL6JhQFxPi2tsUD2Dlhpj5/y9Z7ANdsiTOlmcBI0QprlEzags5Gl
	c1s2Hg==
X-Received: by 2002:ac8:570e:0:b0:4ed:2ff9:b325 with SMTP id
 d75a77b69052e-5073a329538mr3977721cf.59.1771971607910; Tue, 24 Feb 2026
 14:20:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260210002852.1394504-1-joannelkoong@gmail.com>
 <20260210002852.1394504-4-joannelkoong@gmail.com> <89c75fc1-2def-4681-a790-78b12b45478a@gmail.com>
 <aYykILfX_u9-feH-@infradead.org> <bd488a4e-a856-4fa5-b2bb-427280e6a053@gmail.com>
 <aY7QX-BIW-SMJ3h_@infradead.org> <34cf24a3-f7f3-46ed-96be-bf716b2db060@gmail.com>
 <CAJnrk1a+YuPpoLghA01uJhEKrhmrLhQ+5bw2OeeuLG3tG8p6Ew@mail.gmail.com>
 <7a62c5a9-1ac2-4cc2-a22f-e5b0c52dabea@gmail.com> <CAJnrk1Y5iTOhj4_RbnR7RJPkr7fFcCdh1gY=3Hm72M91D-SnyQ@mail.gmail.com>
 <11869d3d-1c40-4d49-a6c2-607fd621bf91@gmail.com> <CAJnrk1Zr=9RMGpNXpe6=fSDkG2uVijB9qa1vENHpQozB3iPQtg@mail.gmail.com>
 <94ae832e-209a-4427-925c-d4e2f8217f5a@gmail.com>
In-Reply-To: <94ae832e-209a-4427-925c-d4e2f8217f5a@gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 24 Feb 2026 14:19:56 -0800
X-Gm-Features: AaiRm52fYZKXpBWIpBV_6pmVZ_13_zNMt5QmejWfADpJGVdq1QSE2sEdRzWOlJ4
Message-ID: <CAJnrk1a1FAARebZ0Aqw18zxtOy8WTMb2UfcAK6jQaigXiZbTfQ@mail.gmail.com>
Subject: Re: [PATCH v1 03/11] io_uring/kbuf: add support for kernel-managed
 buffer rings
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, axboe@kernel.dk, io-uring@vger.kernel.org, 
	csander@purestorage.com, krisman@suse.de, bernd@bsbernd.com, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78315-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid]
X-Rspamd-Queue-Id: 36B8018D172
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 12:00=E2=80=AFPM Pavel Begunkov <asml.silence@gmail=
.com> wrote:
>
> On 2/21/26 02:14, Joanne Koong wrote:
> > On Fri, Feb 20, 2026 at 4:53=E2=80=AFAM Pavel Begunkov <asml.silence@gm=
ail.com> wrote:
> ...
> >> So I'm asking whether you expect that a server or other user space
> >> program should be able to issue a READ_OP_RECV, READ_OP_READ or any
> >> other similar request, which would consume buffers/entries from the
> >> km ring without any fuse kernel code involved? Do you have some
> >> use case for that in mind?
> >
> > Thanks for clarifying your question. Yes, this would be a useful
> > optimization in the future for fuse servers with certain workload
> > characteristics (eg network-backed servers with high concurrency and
> > unpredictable latencies). I don't think the concept of kmbufrings is
> > exclusively fuse-specific though (for example, Christoph's use case
> > being a recent instance);
>
> Sorry, I don't see relevance b/w km rings and what Christoph wants.
> I explained why in some sub-thread, but maybe someone can tell
> what I'm missing.
>
> > I think other subsystems/users that'll use
> > kmbuf rings would also generically find it useful to have the option
> > of READ_OP_RECV/READ_OP_READ operating directly on the ring.
>
> Yep, it could be, potentially, it's just the patchset doesn't plumb
> it to other requests and uses it within fuse. It's just cases like

This patchset just represents the most basic foundation. The
optimization patches (eg incremental buffer consumption, plumbing it
to other io-uring requests, etc) were to be follow-up patchsets that
would be on top of this.

> that always make me wonder, here it was why what is basically an
> internal kernel fuse API is exposed as an io_uring uapi. Maybe there

It's not really an internal kernel fuse API. There's nothing
fuse-specific about it - the infrastructure that's added is the
infrastructure for a generic buffer ring.

The memory that backs the buffers for the buf ring needs to be
io-uring specific. io-uring already has all the infrastructure for
buffer rings. So I'm not really fully understanding why it's better in
this case to just have the fuse kernel code re-implement all the logic
for a buffer ring and go through these layers of indirection to use
registered buffers, instead of just leveraging what's already in
io-uring.

> was a discussion about it I missed?
>
> >> So you already can do all that using the mmap()'ed region user
> >> pointer, and you just want it to be more efficient, right?
> >> For that let's just reuse registered buffers, we don't need a
> >> new mechanism that needs to be propagated to all request types.
> >> And registered buffer are already optimised for I/O in a bunch
> >> of ways. And as a bonus, it'll be similar to the zero-copy
> >> internally registered buffers if you still plan to add them.
> >>
> >> The simplest way to do that is to create a registered buffer out
> >> of the mmap'ed region pointer. Pseudo code:
> >>
> >> // mmap'ed if it's kernel allocated.
> >> {region_ptr, region_size} =3D create_region();
> >>
> >> struct iovec iov;
> >> iov.iov_base =3D region_ptr;
> >> iov.iov_len =3D region_size;
> >> io_uring_register_buffers(ring, &iov, 1);
> >>
> >> // later instead of this:
> >> ptr =3D region_ptr + off;
> >> io_uring_prep_read(sqe, fd, ptr, ...);
> >>
> >> // you use registered buffers as usual:
> >> io_uring_prep_read_fixed(sqe, fd, off, regbuf_idx, ...);
> >>
> >
> > I feel like this design makes the interface more convoluted and now
> > muddies different concepts together by adding new complexity /
> > relationships between them whereas they were otherwise cleanly
> > isolated. Maybe I'm just not seeing/understanding the overarching
> > vision for why conceptually it makes sense for them to be tied
> > together besides as a mechanism to tell io-uring requests where to
> > copy from by reusing what exists for fixed buffer ids. There's more
> > complexity now on the kernel side (eg having to detect if the buffer
> > passed in is kernel-allocated to know whether to pin the pages /
> > charge it against the user's RLIMIT_MEMLOCK limit) but I'm not
> > understanding what we gain from it.
>
> That would avoid doing a large revamp of uapi and plumbing it
> to each every request type when there is already a uapi that does
> what you want, does it well and have lots of things figured out.
> Keeping the I/O path sane is important, io_uring already has 3
> different ways of passing buffers, let's not add a 4th one
> unless it achieves something meaningful.
>
> > I got the sense from your previous
> > comments that memory regions are the de facto way to go and should be
>
> Sorry, maybe I wasn't clear. With what I see you're trying to do,
> i.e. copying client's data into user space (server), I think
> registered buffers would be a better abstraction. However, I just
> went with your design on top of regions, since it's not the first
> iteration of the series and I wasn't following previous ones, and
> IIRC you was already using registered buffers in previous revisions
> but moved from that for some reason. IOW, I was taking you main I/O
> path and was trying to make the setup path a bit more flexible and
> reusable.
>
> > decoupled from other structures, so if that's the case, why doesn't it
> > make sense for io-uring to add native support for using memory regions
> > for io-uring requests? I feel like from the userspace side it makes
> > things more confusing with this extra layer of indirection that now
> > has to go through a fixed buffer.
>
> There is a high bar for adding a new interface for passing buffers
> that needs to be propagated to a good number of request handlers,
> and there is already one that gives you all you need to write
> efficient user space.
>
> >> IIRC the registration would fail because it doesn't allow file
> >> backed pages, but it should be fine if we know it's io_uring
> >> region memory, so that would need to be patched.
> >>
> >> There might be a bunch of other ways you can do that like
> >> create a kernel allocated registered buffer like what Cristoph
> >> wants, and then register it as a region. Or allow creating
> >> registered buffers out of a region. etc.
> >>
> >> I wanted to unify registered buffers and regions internally
> >> at some point, but then drifted away from active io_uring core
> >> infrastructure development, so I guess that could've been useful.
> >>
> >>> Right now there's only a uapi to register a memory region and none to
> >>> unregister one. Is it guaranteed that io-uring will never add
> >>> something in the future that will let userspace unregister the memory
> >>> region or at least unregister it while it's being used (eg if we add
> >>> future refcounting to it to track active uses of it)?
> >>
> >> Let's talk about it when it's needed or something changes, but if
> >> you do registered buffers instead as per above, they'll be holding
> >> page references and or have to pin the region in some other way.
> >
> > I don't think we can guarantee that the caller will register the
> > memory region as a fixed buffer (eg if it doesn't need/want to use the
> > buffer for normal io-uring requests). On the kernel side, the internal
>
> It's up to the user (i.e. fuse server) to either use OP_READ/etc. using
> user addresses that you have in your design from mmap()ing regions, or
> registering it and using OP_READ_FIXED.

Yes but I don't think this solves the concern of userspace being able
to unregister the memory region at any time (eg while not doing
io-uring requests) while the kernel still points to those addresses
for the backing buffers of the bufring, since there's no callback that
gets triggered in the subsystem when a memory region is unregistered,
which means there will need to be extra per I/O overhead for having to
ensure the memory region is still valid. Though since there's no uapi
for unregistering a memory region this is not a concern, unless this
is planned to be added in the future.

Thanks,
Joanne

>
> > buffer entry uses the kaddr of the registered memory region buffer for
> > any memcpys. If it's not guaranteed that registered memory regions
> > persist for the lifetime of the ring, there'll have to be extra
> > overhead for every I/O (eg grab the io-uring lock, checking if the mem
> > region is still registered, grab a refcount to that mem region, unlock
> > the ring, do the memcpy to the kaddr, then grab the io-uring lock
> > again, decrement the refcount, and unlock). Or I guess we could add
> > pinning to a registered memory region.
>
>
>
> --
> Pavel Begunkov
>

