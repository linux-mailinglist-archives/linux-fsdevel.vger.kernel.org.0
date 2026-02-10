Return-Path: <linux-fsdevel+bounces-76889-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QKi0NYuai2k3XAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76889-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 21:52:27 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A5F11F1F7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 21:52:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8B231304AD12
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 20:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A4233121E;
	Tue, 10 Feb 2026 20:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PS2vNFdE";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="UUWs4bCV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52F33EBF1A
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Feb 2026 20:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770756744; cv=none; b=iSBV7wo4vl3SEdI+UqemYoQgikKMyxPeksU2RLnrQbbXqbvRXDAVpSTt7saxEcu1/QbbUf5ufb4M29D3SI0iT0uXknWhO7ZjEJa6kNYCoEc47zE74hp1HvxCM2W+/LTkUkpeNgwxjpvYdkaF0+BMh0mls5H+Nc2mLYH/SFRZDa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770756744; c=relaxed/simple;
	bh=tbMfLojvuFwMWz9D1VDuGbM3HCZvpiNZyOdCiWSzfpo=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oEgsfw6+JaFuVDasdawxLcy1MZiETlw4yArmkQXgBd/umWRlXh8uuD3hU1bpEYMkQdYvuAzeVoUAKQZy/ztX05Xu8Hq7dlvVsWfKqTdv6QxyZUmsdIlKzlq6Y4sljYUsttVB2QgLWUCvjcHvndDfmDj7+zZeey0Hig7QcW95xdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PS2vNFdE; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=UUWs4bCV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770756741;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=MrCEFLIbdwEIb4gpQxK0QNreKVswbTUWGMdqr2Xi3hA=;
	b=PS2vNFdEaDGX5Xi7l9TTvKGtfauREBRNx7fnX3Fw5GvCCBKhayd0keXaYPG1mzp8n1PPh3
	/LfGocjhl8Pt0II89BO0p649KlFcV0qRFDMVMM4Gg+yYvlCtb/oEBU3LktQxGlyYx58m3f
	mYcY/xckQAUJoqx739JEVBycXyb6mIE=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-394-5yw5tlWCOwuUGQoci0u_oQ-1; Tue, 10 Feb 2026 15:52:20 -0500
X-MC-Unique: 5yw5tlWCOwuUGQoci0u_oQ-1
X-Mimecast-MFC-AGG-ID: 5yw5tlWCOwuUGQoci0u_oQ_1770756740
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-5061d1ef1f3so50007891cf.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Feb 2026 12:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770756740; x=1771361540; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MrCEFLIbdwEIb4gpQxK0QNreKVswbTUWGMdqr2Xi3hA=;
        b=UUWs4bCV2qOeaNNOViTdsX22RNc9GNV25LoaN0zMJOAuQpl0MtxsxyBWek5eZgEzis
         IqAvLLLIugP5cjgFZ4mROfBpidLDeCFVEVsRw1XnIuMq/c7m442fct2E4ivpOfIf1Xor
         FI15Qmn0yc6cigl1YiXdzjvABHQVp7u4sBC+8JWqp6hPqVi9EsdiyMvKeu7p1+T5w71W
         CZSpvg4NCaXKmyAx0vlWvwjCArjh2jgAhszFhh7MWjrndFJdViRs8L22Y/keXD0cbSy/
         GCtp4W49euj4d8Op1PFO+9L5agi0UpE2oYCUgb5rR5kZj5OpymjzjoEBTaulXL//OGc7
         eHcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770756740; x=1771361540;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MrCEFLIbdwEIb4gpQxK0QNreKVswbTUWGMdqr2Xi3hA=;
        b=PQOsE7XxFj5QzY9QkZt3VtilbnsgKxWgbpUbFLu1qhvQEwrc+lzuSOxf54oZMxAyZo
         NkjaXc0cF/nzt4yU+q7eR5JEGf6fwk3q06btUoUAEK5sx2BIOpAzVaMUJIrBnPgNktxm
         UxRGLdYpe9hFPaKkZacthGqA68vTOeMh2DtWNoPJhUokZsas648NOLf6lXLnKcSmlYKN
         rFOvbA4o8NAXuLH5eBDq4Mry0csngx4u+rauZ6Gakt1SFwV+bvVSJCkqDxLNRzPCJoJ2
         nnf1yBd1aGu3GtGyHWVQV0IJJc0KLPMbXV0YtwS8XJFIRZgGGI7zTvEMMIMl1+2E8v2P
         2h4g==
X-Forwarded-Encrypted: i=1; AJvYcCVWfFBB+dVo2vcSdKi+qf92N6C026wmOMyJ136z/Pwm84lZENgwF38l4iRkui2thJKlpGr4kgI+gOUvaeXA@vger.kernel.org
X-Gm-Message-State: AOJu0YwRGkKqyfFkUEOHclU2A0sC/FBjPcDWE8IqfEBbT0SA3qTQ1OTd
	UcmKsp1Z/pHRQu3ISf90GARQ/RIeWlV2mY00fyfKENnPs2+9rZSXMrCTehz5jLARYKo/MlwEx+v
	seHnrrYzm4TmMm+EMSAgT7jWQsW7ZCDgTPquuFUeqD428SbcwqnRgXItf9sPS2DauXhgu+BhGbb
	E=
X-Gm-Gg: AZuq6aIVdvTwNmA6yW8/zsjMU7BQjcat+0hTIQ8eQOLMC4VYCEcieOEKnVQuvyUoJz9
	spr+3Zj7s46zCR5Lx2lXiePkrjEPKi/8oVqa7AxxNfY1tU1ab/2qg2ntLqGCtX8Vkxu0AGS5U8S
	RjfzKCXhtRv7y5CNi5V+iiC1gGFsfsDBxY+MZNbsscEnlBllPiVVkoTjBWwfEpwbApqmkthZZx/
	l3cAV7aDdqiyiSrdQI3MBWmAOFHvw9xxHJEXIhe/NDvPxs+WeSFD/rqUWhdqq6rm43DPE8Tl71C
	ghTgf13R9VUPUoyLxJU+6KAAa6kl3FbtP6seyCWeXSB1WbW8R3qfVjq5JUDLmQ6+e9YYI0x9WAM
	B+KEgucOBN8oh/w==
X-Received: by 2002:a05:622a:54d:b0:4ed:2edb:92b9 with SMTP id d75a77b69052e-506399da643mr228209551cf.81.1770756740028;
        Tue, 10 Feb 2026 12:52:20 -0800 (PST)
X-Received: by 2002:a05:622a:54d:b0:4ed:2edb:92b9 with SMTP id d75a77b69052e-506399da643mr228209331cf.81.1770756739560;
        Tue, 10 Feb 2026 12:52:19 -0800 (PST)
Received: from x1.local ([174.91.117.149])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8953c056e78sm109453876d6.39.2026.02.10.12.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 12:52:19 -0800 (PST)
Date: Tue, 10 Feb 2026 15:52:07 -0500
From: Peter Xu <peterx@redhat.com>
To: lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: [LSF/MM/BPF TOPIC] Userspace-driven memory tiering
Message-ID: <aYuad2k75iD9bnBE@x1.local>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76889-lists,linux-fsdevel=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peterx@redhat.com,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,x1.local:mid]
X-Rspamd-Queue-Id: 52A5F11F1F7
X-Rspamd-Action: no action

Hi,

I would like to propose a topic to discuss userspace-driven memory tiering.

Note, that neither the subject nor contents are stablized; currently, the
only thing that is for certain is the use case.  The hope is below content
will define well on the topic, and especially, the use case to be discussed
here to collect feedbacks.

I'll try to make the topic more condensed and focused if this will be
selected and discussed on the conference.  If anyone thinks below is too
much for one topic, I am open to spit it into two or more.

It's also possible I make stupid mistakes below as I didn't code anything
up or test yet so I may overlook things, please kindly bare with me if so.

Problem
=======

Here, I'm not yet looking for anything more complex than two tiers.  The
use case can be as simple as: one process, having only a portion of its
memory serviced by fast devices (like DRAM), the rest serviced by slow
devices (e.g. SSDs). In a VM use case, it allows a host to service more VMs
with over provisioning.

With the help of memcg and MGLRU, Linux swap system can do this well
enough, except that it misses one pillar stone of VM where we want to be
flexible enough to move VMs around all over the cluster.

When that happens, the hypervisor needs to scan the VM pages one by one and
copy them to a peer host in a busy loop.  Here, by the nature of swap
transparency, the userspace will need to fault in all the cold pages to
fetch the data for moving.  Meanwhile, after migration the hotness
information is also lost because of such "transparency", because we must
apply those data on top of RAMs first.

In this use case, memcg is almost great to service multiple needs.
However, it is still coarse grained from some aspects: it allows specify
swap usage, whilst it doesn't yet allow to specify swap device to use for a
process, or IOPS allowed to be consumed on the swap devices.  This is less
of a concern in the whole picture, but would be nice to have.

Some possible solutions I would like to collect some inputs below.  NACKs
are more than welcomed, then it may also help to find the right path
acceptable to everyone.

I'll start with the solution that I think might be the most efficient and
straightforward, and I'll only try to discuss the solutions from the kernel
perspective.  The last solution will be fully userspace-implemented.  I'll
only mention it; there's nothing we need to change from Linux POV.

Possible Solutions
==================

(1) Backend-aware Swap Data Access

To solve the major problem above, we want to know if there is way an
userspace can directly access a swap device but without causing it to be
faulted, polluting hotness information (in case of MGLRU, on generations or
tierings), or consuming DRAM / causing folio allocations while doing so.

Considering we have mincore(2) system call, would it be possible we can
provide a similar syscall, besides knowing "whether the page is resident in
RAM", also access the data on the back when it's a swap?

(1.a) New syscall swap_access()

  swap_access(addr, len, flags, *vec, *buffer)

  addr:   start virtual address of the range
  len:    len of the virtual address range
  flags:  operation flags (e.g. read / write for swap)
  vec:    an array containing pgtable info (e.g. is it a swap?)
  buffer: an array containing data buffers (for either read / write)

Examples:

When the userapp finds mincore() reports a swap entry, to read the data
instead of fault it into the mapping, it can bypass the mapping and issue:

  swap_access(addr, PSIZE, SWAP_OP_READ, vec[], buffer[])

It will check the page in the pgtable to see if it's a swap entry first, if
so, read from the swap backend, put the data into buffer[0], setting
SWAP_FL_READ_OK in vec[0] saying it's a swap entry and read successfully.
It doesn't touch the pgtable and keep the entry to be a swap entry.

OTOH, when the userapp knows some data is cold (but still useful), and want
to populate some data directly from swap without allocating folios at all,
one can use:

  swap_access(addr, PSIZE, SWAP_OP_WRITE, vec[], buffer[])

It will first check if the pgtable is empty and not allocated, if so,
allocate a swap entry, put the data (in buffer[0]) to swap device, then set
vec[0] to SWAP_FL_WRITE_OK saying data populated.  The pgtable (after
syscall returns) should have one swap entry populated without any folio
being allocated.

NOTE: due to the transparency, there might be race conditions on
swap_access() v.s. the page being swapped in/out on the fly.  We can either
make the swap_access() be serialized with those, or directly fail those
swap_access() saying "concurrent access / -EBUSY".  Normally it means some
page are being promoted to hotter tiers, hence failure to userspace would
be fine; it implies to the userspace that this is a hot page now and it can
directly access from DRAM.

Both anonymous and shmem support should suffice in this regard.  We could
really start from one of them, say, anonymous, if this would ever be
anything useful.

(1.b) Genuine O_DIRECT support for shmem

Shmem supports O_DIRECT since Hugh's commit e88e0d366f9cf ("tmpfs: trivial
support for direct IO") in 2023 (v6.6+).  At that time, it was only for
easier testing purpose, and I believe there's no real use case.  Maybe we
can re-define this API so that O_DIRECT means "read/write to swap"?

It means reads/writes will need to be 4K-aligned with shmem O_DIRECT, all
operations happen directly on swap devices without updating the page cache
with real folios.  We'll likely need to properly serialize concurrent
accesses but it's fine; when doing O_DIRECT it means this shmem page is
already cold, so slower is OK.

It also means we can't easily support anonymous use this method,
unfortunately.

(2) Hotness Information API

One step back, if above solution won't work out for whatever reason, it may
mean the userapp needs to implement the swap on its own to be able to
access the backends directly.  Then, there's still chance we can share the
information on page hotness with the kernel's vmscan logic.  Here as MGLRU
seems to be a better candidate now, I'll focus on it.

MGLRU by default doesn't work well with idle page tracking.  It's likely
because nobody should be using idle page tracking when MGLRU is
present.. However if an userapp needs to manage swap for one single process
for whatever reason, we may want to allow most of the host run with MGLRU,
however for the specific process it will manage swap on its own.  The
single process may still need page hotness info.

Then the question is: can this process still be able to share page hotness
information with the kernel, so that we don't need idle page tracking
(which will almost stop working well with MGLRU enabled)?

It means allows per-page / per-folio reporting of MGLRU hotness information
on either generations and tiers.  One way we can do it is via pagemap or
similar interface.  Would this be acceptable?

To make things further, consider if we move a cold page from one host to
another, then we want to apply the page with the same hotness alongside
with the data to be applied: would we allow a reverse operation of such so
that we can provide hotness hint to kernel from userspace?  E.g., consider
ioctl(UFFDIO_COPY) with a gen+tier information attached, so when the new
folio is atomically created and populated, it will be put into proper
gen+tier.

(3) Fully Userspace Swap Implementation

This will almost always work with no kernel change needed, with the help of
userfaultfd.  I'll skip all details whatever to happen in an userapp.

Except that we may still need idle page tracking in this case if above (2)
will not be accepted upstream.. so either we may want to conditionally
enable idle page tracking with a CONFIG_ option (so distro can opt-in
enabling idle page tracking together with MGLRU), or somehow allow MGLRU to
work properly with this specific process knowing it may use idle page
tracking.

-- 
Peter Xu


