Return-Path: <linux-fsdevel+bounces-71085-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9008FCB4444
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Dec 2025 00:36:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DCE7E3011000
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Dec 2025 23:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B3B930C60A;
	Wed, 10 Dec 2025 23:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PAh2LoBP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687AC3093DF
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Dec 2025 23:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765409374; cv=none; b=Ic4kMS2yq8i1Cu5Zb69qKBdworRMe7H/laQIeTGwYd555dSvy8+e8cBuAIyJIP+/3z/1rnIemo7kLjvh/ngE+t9xT3avwXczqhVgR14kQjP9yrFSpUpXc6BTynFfE/pJNTyd4WkTU5tKYkeTOsgOlaiSBIq9bYQHzbaAchpb/iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765409374; c=relaxed/simple;
	bh=aqF0b14UzprPB5/tmIN8f6wh+mcFPv9LoXj+TufMJqA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J/Th6EAUTEEFI9wzpIXrRMTIqA7DgtvuAxsh5NutaA1veI8aU4twAm1kt8w3oHO/I5A2KfpgQw0m3Y0pAUYs3+tCQKl2jiWeIBy26uBewtaiTXoZ2LH66DwOBVFLwEmiTi7Qty2MpnvYkeA6w10M52xoW5iDuT8etI2pDSJYrrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PAh2LoBP; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-64951939e1eso592309a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Dec 2025 15:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765409368; x=1766014168; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nS0J0O1eWQ7LAl0fVJkBnyD56Bk+EqzYYTzRp7Kqlh0=;
        b=PAh2LoBPROnW/UxCEr36AVItv2hO9PDUd5fcFF5xjlULFudKg2SIBrUrDjOMziqn5i
         +x4/ofdRQebNMVshENcl4XzO1qwiIu+BJdS1+kqJkPXz7Q3o9QR3vXez2yoc4FtHivXj
         5nDKDzYxo09A1UaG/EkXpSS1f8WqpvK2X7WhMOTZsJ77pIm0HOxpGsL6LVAsKUujzYer
         iISBIcIqzjLH7tT8p64oogMfSV3+5ZZ0EiBkt3sZzLP1cWVPPcCh+te+EV4S+OiwFE9T
         t/898Vyy5kXypNVyNaN/cwkxIa9ZhsQpxHGYhbbZbH8Dk89+eWjcRyEEspspTB2BFuTT
         BuDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765409368; x=1766014168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nS0J0O1eWQ7LAl0fVJkBnyD56Bk+EqzYYTzRp7Kqlh0=;
        b=Gtg8Z3/BvNAbfFKm/hqnmKGxZG+ZXS6TryQOaAS+7Ob+qg/4Cf2HP5eDtIkXYRssAV
         tBbPjd8q1UmVE9qGgXnKYS0JOZRy8Vqgrc6jyX5OMPkOWthKzvBWOZy1nNVjZtVm/7dE
         JNegorl03Rx0ujROmvcyPMWvhwWd2zPxRga1p3UWKWRs/REZ5+YXk9ddI03xf6K7Cgrl
         ffs7MvQo/oBRI5Lrc1HKEqydqYp8a+F4xCaT4SPisPr8ME1/nWTZpQ0nA8oHw5tOvlvW
         wjMLd+Hubvg+jM5Lpiv+hbISBNLLiplDe8rdhSCTT7o4p+rSt6N/BN9n/emssJZrtvTU
         qD7g==
X-Forwarded-Encrypted: i=1; AJvYcCVy0Q2o8TacK6wwo8+FZ6hz60GOu68jjJsse5JFp7nlofhuKf5/0ADrt/B8whkb2PWbqmvHa+tGPGMW1bad@vger.kernel.org
X-Gm-Message-State: AOJu0Yx28D41eaDkfkeqcWkTPCL1F7Qb19JAHFvhDC/r3Eghl432S0Hr
	oB/pnRGyVNco20730EMvO6mDbOdcHA+G5+3QJ1gjsNpFxsxMhQtr/eiJqY0g4EDWxHsVQ812hjO
	4mFYjIRxX5CYygfa2hx+aKDPx0sL8jKM=
X-Gm-Gg: AY/fxX7yBqfiXrqxqlxVYDmDoCdpF0a1tPEmWHFquSvg0+KSPbyHH8cEyalNuSiDCUY
	g8x82+j/PdK9tBULK/5c8zuNZDNIxyrbE89sE+URiP11CT4/nK92+t/+53Og6DOBeLwkyEdbnBn
	aS5nsBgnZBoYc58jUzFeXlRh3cyJLUe5g6JqL0S2+TbAhgnfghaoAvzZiXNWuUAwaey857vhg0m
	D5pGLYKoDpVzltCfj3tzmJ8Dm276ojzKJAojmFT2SoUGbuw7vtQifxD5LGmqipjCRiC+AWSQg==
X-Google-Smtp-Source: AGHT+IFY2YnYNX5FT/khwOBS5XvuY7d1BKMmotDhd8P0VT8JClJq7mTFg7XBz3sw2vVuh5yIn5xaUUThFRZtLG6SNg8=
X-Received: by 2002:a05:6402:34c3:b0:649:5dbf:fb9c with SMTP id
 4fb4d7f45d1cf-6496db7a2aamr4068714a12.30.1765409367863; Wed, 10 Dec 2025
 15:29:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112192936.2574429-1-gourry@gourry.net> <de15aca2-a27c-4a9b-b2bf-3f132990cd98@kernel.org>
 <aSSepu6NDqS8HHCa@gourry-fedora-PF4VCD3F>
In-Reply-To: <aSSepu6NDqS8HHCa@gourry-fedora-PF4VCD3F>
From: Yiannis Nikolakopoulos <yiannis.nikolakop@gmail.com>
Date: Thu, 11 Dec 2025 00:29:15 +0100
X-Gm-Features: AQt7F2r_GFKD_JRPuqTk3RRhGxs_7478IUrJgqKiJlyTjHAwK1VTUcsA5pzKhMI
Message-ID: <CAOi6=wTCPDM4xDJyzB1SdU6ChDch27eyTUtTAmajRNFhOFUN=A@mail.gmail.com>
Subject: Re: [RFC LPC2026 PATCH v2 00/11] Specific Purpose Memory NUMA Nodes
To: Gregory Price <gourry@gourry.net>
Cc: "David Hildenbrand (Red Hat)" <david@kernel.org>, linux-mm@kvack.org, kernel-team@meta.com, 
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, 
	nvdimm@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	cgroups@vger.kernel.org, dave@stgolabs.net, jonathan.cameron@huawei.com, 
	dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com, 
	ira.weiny@intel.com, dan.j.williams@intel.com, longman@redhat.com, 
	akpm@linux-foundation.org, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com, 
	mhocko@suse.com, osalvador@suse.de, ziy@nvidia.com, matthew.brost@intel.com, 
	joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com, 
	ying.huang@linux.alibaba.com, apopple@nvidia.com, mingo@redhat.com, 
	peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, tj@kernel.org, hannes@cmpxchg.org, 
	mkoutny@suse.com, kees@kernel.org, muchun.song@linux.dev, 
	roman.gushchin@linux.dev, shakeel.butt@linux.dev, rientjes@google.com, 
	jackmanb@google.com, cl@gentwo.org, harry.yoo@oracle.com, 
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com, 
	zhengqi.arch@bytedance.com, yosry.ahmed@linux.dev, nphamcs@gmail.com, 
	chengming.zhou@linux.dev, fabio.m.de.francesco@linux.intel.com, 
	rrichter@amd.com, ming.li@zohomail.com, usamaarif642@gmail.com, 
	brauner@kernel.org, oleg@redhat.com, namcao@linutronix.de, 
	escape@linux.alibaba.com, dongjoo.seo1@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Just managed to go through the series and I think there are very good
ideas here. It seems to cover the isolation requirements that are
needed for the devices with inline compression.
As an RFC I can try to build something on top of it and test it more.

I hope we find the right abstractions for this to move forward.

On Tue, Nov 25, 2025 at 6:58=E2=80=AFAM Gregory Price <gourry@gourry.net> w=
rote:
>
> On Mon, Nov 24, 2025 at 10:19:37AM +0100, David Hildenbrand (Red Hat) wro=
te:
> > [...]
> >
>
> Apologies in advance for the wall of text, both of your questions really
> do cut to the core of the series.  The first (SPM nodes) is basically a
> plumbing problem I haven't had time to address pre-LPC, the second (GFP)
> is actually a design decision that is definitely up in the air.
>
> So consider this a dump of everything I wouldn't have had time to cover
> in the LPC session.
>
> > > 3) Addition of MHP_SPM_NODE flag to instruct memory_hotplug.c that th=
e
> > >     capacity being added should mark the node as an SPM Node.
> >
> > Sounds a bit like the wrong interface for configuring this. This smells=
 like
> > a per-node setting that should be configured before hotplugging any mem=
ory.
> >
>
> Assuming you're specifically talking about the MHP portion of this.
>
> I agree, and I think the plumbing ultimately goes through acpi and
> kernel configs.  This was my shortest path to demonstrate a functional
> prototype by LPC.
>
> I think the most likely option simply reserving additional NUMA nodes for
> hotpluggable regions based on a Kconfig setting.
>
> I think the real setup process should look like follows:
>
> 1. At __init time, Linux reserves additional SPM nodes based on some
>    configuration (build? runtime? etc)
>
>    Essentially create:  nodes[N_SPM]
>
> 2. At SPM setup time, a driver registers an "Abstract Type" with
>    mm/memory_tiers.c  which maps SPM->Type.
>
>    This gives the core some management callback infrastructure without
>    polluting the core with device specific nonsense.
>
>    This also gives the driver a change to define things like SLIT
>    distances for those nodes, which otherwise won't exist.
>
> 3. At hotplug time, memory-hotplug.c should only have to flip a bit
>    in `mt_sysram_nodes` if NID is not in nodes[N_SPM].  That logic
>    is still there to ensure the base filtering works as intended.
>
>
> I haven't quite figured out how to plumb out nodes[N_SPM] as described
> above, but I did figure out how to demonstrate roughly the same effect
> through memory-hotplug.c - hopefully that much is clear.
>
> The problem with the above plan, is whether that "Makes sense" according
> to ACPI specs and friends.
>
> This operates in "Ambiguity Land", which is uncomfortable.
What you describe in a high level above makes sense. And while I agree
that ACPI seems like a good layer for this, it could take a while for
things to converge. At the same time different vendors might do things
differently (unsurprisingly I guess...). For example, it would not be
an absurd idea that the "specialness" of the device (e.g. compression)
appears as a vendor specific capability in CXL. So, it would make
sense to allow specific device drivers to set the respective node as
SPM (as I understood you suggest above, right?)

Finally, going back to the isolation, I'm curious to see if this
covers GPU use cases as Alistair brought up or HBMs in general. Maybe
there could be synergies with the HBM related talk in the device MC?

Best,
/Yiannis

