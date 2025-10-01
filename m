Return-Path: <linux-fsdevel+bounces-75622-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uIgoIzHaeGmwtgEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75622-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 16:30:57 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C04296BC4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 16:30:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3CEB030B1924
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 15:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C1C35C18D;
	Tue, 27 Jan 2026 15:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="Y7Guxh82";
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="fJdgKSL/";
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="fJdgKSL/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail1.bemta39.messagelabs.com (mail1.bemta39.messagelabs.com [195.245.231.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B253EBF03;
	Tue, 27 Jan 2026 15:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.245.231.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769526945; cv=none; b=BpdwXJNMIRvTAmX9UzNuzcKP/AunlLA1jRofba6MEQiPL8St2hm4Rsekg3a7jdVR8b5FxCfydcfut1XEg+1IzJLFHf6bv6mwBiWNUH8pP6P7nwPIwpYl/8DTkys/MQg5wYrQGX2XnTAZSzIhI+o8+3hISc5skyOrXEDyW0Xr+XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769526945; c=relaxed/simple;
	bh=3Ocr8+IV+WRlNqAHeAyIW1ArEK7R5P3dT2S+WayxlrY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J+Qr7QGXv6rl0eF+yE1xdHrOgU5HDrVOv3Q4MYCHxqld+9IBJHZVDrTblHNIRX6EuhCVpPzLxa3I7Mbt4HSnjzfq3DmpVF51eDNBbk5Rc1lUq9S/3DjRmkh24Vn+YGfEXxwydp9Pt/jiGL+V9FqFo4A+/G/9MEGPOYGgoLqhwzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=Y7Guxh82; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=fJdgKSL/; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=fJdgKSL/; arc=none smtp.client-ip=195.245.231.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
	s=170520fj; t=1769526940; i=@fujitsu.com;
	bh=eKJgZOL9+TZVs7y3reqL2VrxdmtxW8FanAU5WaL7bc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	b=Y7Guxh82jmLxwnMDghz1zHbcVBArW8J+LaRspyiKbkxRUZ5LWtc7kIufNtR+xQqiP
	 LB3mcqmumQt0c5d85PeSSx1OHn0zFA12n1QXXeGGQrbp9dS2jfEtG/V5g/Mum3SKd9
	 oVyiV31Fy/D8tBlvUtgq/Ebl+m1Gnw+9uAFTYkYDGAXHy89iYK3/NPJuPvehilUk7N
	 lIaZHfrT+tsIzwjkZtnYTGj80m0rdKGPWM7RkLjpBcZDjDfhoSeUDEAHFBQW4GFtL6
	 gGU0rYJpjrFScxVSWZBiK49bt/QXIyHKH3lPNv0/PSzwJZeKhsu4y0k38oywH9g8kL
	 uRXgqq+oUa3PA==
X-Brightmail-Tracker: H4sIAAAAAAAAA22Sb0xTVxyGOffe3l6Qkkth49jBXGrGFjKKBDU
  nSJiLWXJNlskcWdQP0xaubbEt2FtcWTIHAhMq/ywgWKTgnIYxsimIFEKFYUVEHRWEFRgBVFS6
  MGFlCCJsrYhzyb69yfOc97wffhQuvEWKKFavY7UaqUpM+hCxMZQx3DSgV25oXRKhkXt2Eo1O/
  MFDC7OPATpunsOQ6/wyicpK7QB1DWaQ6IfBOoAyz/xEop6GZyRqm3hIoIqyTAwZLf04qj09QC
  JTiRVDPaZuArVarxOor+UUiVz5NoCyzVMA5UyUYuj7+Wc8lPM4HUfX8tsxVDlbiqPfTpwDqOz
  REg/Vzc7gaLirh4eGijoxtDjvLrhsGyW2vsU8yS4gmOzeJZJpNo3wmSzbFI9pqAljzrROYkx9
  bS7JtFXW8ZlHDScB0+5cAkxpxdfMzWobn3HVv8ksVnSCOL89PKVGlqzfx1OUFeTgKcXb9VVXe
  3jpYD7GAHwoIX0RwD7Lbb4BeFMEvQMOjV0lPYCgLxHwwe+V/BXrKAZvPWghV63ixivY/1jlAL
  oyGnEDoCiSjoDm4SjPg0A6EHYMzRCejNN2ElbPqj05gGbhmKsAWyl9G1Y3OZ/PENCxsHdhGvd
  kSK+DzpIGnid701vgNx1nn/cI6Wh431yDr/j+8PrJ+y/618HMxooXb0Nh/y/1eBEIML2imV7R
  qgFWCxDHag+x2vAoiUyrlCt0aqlSJZF+GS6VsKna5BQ2/AuW022UyBNSJCzHSbg0dYIqUaJhd
  fXAfVM+03HVFrC4lB3RAdZSmPg1wbfn9Eqhnyw5MU0h5RR7takqlusAwRQlhoKdd9zMX8vKWf
  1+pcp9masYUr7iQMHcFTcWcClSNaeUr6BuEEWNnLZacWpmsvRnXEhokjWsKEiQ5WmiPaoiVfO
  yaPXKe0GIKEAAvLy8hL4prFat1P2XO0EQBcQBgoP97hZfpUb38j+newrmnlJ1LdUzRSf9F4nS
  sQMjZ0N3Xmzb1Talc9LeuRsvx2zVPhTv/9v2+fr3x/aFSR19EUnxH+OFm/NJ0d17sjfkBscn2
  z/t+dABBV6vb8OPp/Yb1Y4P3jWOL9oHJqbXDDvLhafMCwfN0Rtmm4yR+aBFPw4lg7K1GZs1U3
  TNQpXhuz+X94yb8nZtEfqX+O22fXThEBFbkYSFdM40TQ4bnx7rK1/ey4/qarZM/9WeuNi5Oz4
  9odjgv806lP9ZUrfq5pHKmFx73JG8icOhzkvRQwfumqZCZM2qr07EpNl/fOfX9+YsF47eOD8a
  bAy6HejKztq0YCGD76yp7XwSVnQjXm7NOHY47ymKdMjXG8Y21YcUFooJTiGNDMO1nPQfhoo4K
  WAEAAA=
X-Env-Sender: Tomasz.Wolski@fujitsu.com
X-Msg-Ref: server-10.tower-874.messagelabs.com!1769526937!463212!1
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received:
X-StarScan-Version: 9.120.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 22084 invoked from network); 27 Jan 2026 15:15:38 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
  by server-10.tower-874.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 27 Jan 2026 15:15:38 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
	by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id 942E010060B;
	Tue, 27 Jan 2026 15:15:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 n03ukasimr02.n03.fujitsu.local 942E010060B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
	s=dspueurope; t=1769526937;
	bh=eKJgZOL9+TZVs7y3reqL2VrxdmtxW8FanAU5WaL7bc4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fJdgKSL/yInFjLLT+wnUQb6GDlEIDNpHFMGTqp9lBw2HGu58Rcz4jgevdJ2KJ5cY8
	 0FCERaA2b8iAxlUkoLOmuwTyxZZ29x84ztPiqIhZaiyP6LyyD3hNIsxa5xhO+lSrFP
	 mWifWKeX42HdVbypZOmvbZRqXQgC4e0uZ1rVWz5IvcA8o3FQn8W3UkRQRkEAo8GRT8
	 4n6BICzHOm2G/OCnCl6xOwQxYyrCcWZR2B75yAT8o3G/a2zhoiNKpoTL/Gvkx7TQra
	 I99aEbQOSAbmrSvhxWwBvwaSFWEwXqu/4RHVfxHH2VFh3eSk+FpzszrZOgPutSaJ3/
	 BAD9spur12iag==
Received: from ubuntudhcp (unknown [10.172.107.4])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id 6920C100605;
	Tue, 27 Jan 2026 15:15:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 n03ukasimr02.n03.fujitsu.local 6920C100605
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
	s=dspueurope; t=1769526937;
	bh=eKJgZOL9+TZVs7y3reqL2VrxdmtxW8FanAU5WaL7bc4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fJdgKSL/yInFjLLT+wnUQb6GDlEIDNpHFMGTqp9lBw2HGu58Rcz4jgevdJ2KJ5cY8
	 0FCERaA2b8iAxlUkoLOmuwTyxZZ29x84ztPiqIhZaiyP6LyyD3hNIsxa5xhO+lSrFP
	 mWifWKeX42HdVbypZOmvbZRqXQgC4e0uZ1rVWz5IvcA8o3FQn8W3UkRQRkEAo8GRT8
	 4n6BICzHOm2G/OCnCl6xOwQxYyrCcWZR2B75yAT8o3G/a2zhoiNKpoTL/Gvkx7TQra
	 I99aEbQOSAbmrSvhxWwBvwaSFWEwXqu/4RHVfxHH2VFh3eSk+FpzszrZOgPutSaJ3/
	 BAD9spur12iag==
Received: from localhost.BIOS.GDCv6 (unknown [10.172.196.44])
	by ubuntudhcp (Postfix) with ESMTP id 037E12202F9;
	Tue, 27 Jan 2026 15:15:37 +0000 (UTC)
From: Tomasz Wolski <Tomasz.Wolski@fujitsu.com>
To: alucerop@amd.com
Cc: Smita.KoralahalliChannabasappa@amd.com,
	alison.schofield@intel.com,
	ardb@kernel.org,
	benjamin.cheatham@amd.com,
	bp@alien8.de,
	dan.j.williams@intel.com,
	dave.jiang@intel.com,
	dave@stgolabs.net,
	gregkh@linuxfoundation.org,
	huang.ying.caritas@gmail.com,
	ira.weiny@intel.com,
	jack@suse.cz,
	jeff.johnson@oss.qualcomm.com,
	jonathan.cameron@huawei.com,
	len.brown@intel.com,
	linux-cxl@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	lizhijian@fujitsu.com,
	ming.li@zohomail.com,
	nathan.fontenot@amd.com,
	nvdimm@lists.linux.dev,
	pavel@kernel.org,
	peterz@infradead.org,
	rafael@kernel.org,
	rrichter@amd.com,
	skoralah@amd.com,
	terry.bowman@amd.com,
	tomasz.wolski@fujitsu.com,
	vishal.l.verma@intel.com,
	willy@infradead.org,
	yaoxt.fnst@fujitsu.com,
	yazen.ghannam@amd.com
Subject: Re: [PATCH v5 6/7] dax/hmem, cxl: Defer and resolve ownership of Soft Reserved memory ranges
Date: Wed,  1 Oct 2025 19:15:46 +0200
Message-ID: <20251001171553.31343-1-Tomasz.Wolski@fujitsu.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <f4bdf04d-7481-4282-b9da-ce5fcf911af9@amd.com>
References: <f4bdf04d-7481-4282-b9da-ce5fcf911af9@amd.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	DATE_IN_PAST(1.00)[2830];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[fujitsu.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[fujitsu.com:s=170520fj,fujitsu.com:s=dspueurope];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[amd.com,intel.com,kernel.org,alien8.de,stgolabs.net,linuxfoundation.org,gmail.com,suse.cz,oss.qualcomm.com,huawei.com,vger.kernel.org,fujitsu.com,zohomail.com,lists.linux.dev,infradead.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75622-lists,linux-fsdevel=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Tomasz.Wolski@fujitsu.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[fujitsu.com:+];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,fujitsu.com:mid,fujitsu.com:dkim,lpc.events:url];
	RCPT_COUNT_TWELVE(0.00)[35];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 4C04296BC4
X-Rspamd-Action: no action

>> [responding to the questions raised here before reviewing the patch...]
>>
>> Koralahalli Channabasappa, Smita wrote:
>>> Hi Alejandro,
>>>
>>> On 1/23/2026 3:59 AM, Alejandro Lucero Palau wrote:
>>>> On 1/22/26 04:55, Smita Koralahalli wrote:
>>>>> The current probe time ownership check for Soft Reserved memory based
>>>>> solely on CXL window intersection is insufficient. dax_hmem probing is
>>>>> not
>>>>> always guaranteed to run after CXL enumeration and region assembly, which
>>>>> can lead to incorrect ownership decisions before the CXL stack has
>>>>> finished publishing windows and assembling committed regions.
>>>>>
>>>>> Introduce deferred ownership handling for Soft Reserved ranges that
>>>>> intersect CXL windows at probe time by scheduling deferred work from
>>>>> dax_hmem and waiting for the CXL stack to complete enumeration and region
>>>>> assembly before deciding ownership.
>>>>>
>>>>> Evaluate ownership of Soft Reserved ranges based on CXL region
>>>>> containment.
>>>>>
>>>>>      - If all Soft Reserved ranges are fully contained within committed
>>>>> CXL
>>>>>        regions, DROP handling Soft Reserved ranges from dax_hmem and allow
>>>>>        dax_cxl to bind.
>>>>>
>>>>>      - If any Soft Reserved range is not fully claimed by committed CXL
>>>>>        region, tear down all CXL regions and REGISTER the Soft Reserved
>>>>>        ranges with dax_hmem instead.
>>>>
>>>> I was not sure if I was understanding this properly, but after looking
>>>> at the code I think I do ... but then I do not understand the reason
>>>> behind. If I'm right, there could be two devices and therefore different
>>>> soft reserved ranges, with one getting an automatic cxl region for all
>>>> the range and the other without that, and the outcome would be the first
>>>> one getting its region removed and added to hmem. Maybe I'm missing
>>>> something obvious but, why? If there is a good reason, I think it should
>>>> be documented in the commit and somewhere else.
>>> Yeah, if I understood Dan correctly, that's exactly the intended behavior.
>>>
>>> I'm trying to restate the "why" behind this based on Dan's earlier
>>> guidance. Please correct me if I'm misrepresenting it Dan.
>>>
>>> The policy is meant to be coarse: If all SR ranges that intersect CXL
>>> windows are fully contained by committed CXL regions, then we have high
>>> confidence that the platform descriptions line up and CXL owns the memory.
>>>
>>> If any SR range that intersects a CXL window is not fully covered by
>>> committed regions then we treat that as unexpected platform shenanigans.
>>> In that situation the intent is to give up on CXL entirely for those SR
>>> ranges because partial ownership becomes ambiguous.
>>>
>>> This is why the fallback is global and not per range. The goal is to
>>> leave no room for mixed some SR to CXL, some SR to HMEM configurations.
>>> Any mismatch should push the platform issue back to the vendor to fix
>>> the description (ideally preserving the simplifying assumption of a 1:1
>>> correlation between CXL Regions and SR).
>>>
>>> Thanks for pointing this out. I will update the why in the next revision.
>> You have it right. This is mostly a policy to save debug sanity and
>> share the compatibility pain. You either always get everything the BIOS
>> put into the memory map, or you get the fully enlightened CXL world.
>>
>> When accelerator memory enters the mix it does require an opt-in/out of
>> this scheme. Either the device completely opts out of this HMEM fallback
>> mechanism by marking the memory as Reserved (the dominant preference),
>> or it arranges for CXL accelerator drivers to be present at boot if they
>> want to interoperate with this fallback. Some folks want the fallback:
>> https://lpc.events/event/19/contributions/2064/
>
>
>I will take a look at this presentation, but I think there could be 
>another option where accelerators information is obtained during pci 
>enumeration by the kernel and using this information by this 
>functionality skipping those ranges allocated to them. Forcing them to 
>be compiled with the kernel would go against what distributions 
>currently and widely do with initramfs. Not sure if some current "early" 
>stubs could be used for this though but the information needs to be 
>recollected before this code does the checks.
>
>
>>>> I have also problems understanding the concurrency when handling the
>>>> global dax_cxl_mode variable. It is modified inside process_defer_work()
>>>> which I think can have different instances for different devices
>>>> executed concurrently in different cores/workers (the system_wq used is
>>>> not ordered). If I'm right race conditions are likely.
>> It only works as a single queue of regions. One sync point to say "all
>> collected regions are routed into the dax_hmem or dax_cxl bucket".
>
>
>That is how I think it should work, handling all the soft reserved 
>ranges vs regions by one code execution. But that is not the case. More 
>later.
>
>
>>> Yeah, this is something I spent sometime thinking on. My rationale
>>> behind not having it and where I'm still unsure:
>>>
>>> My assumption was that after wait_for_device_probe(), CXL topology
>>> discovery and region commit are complete and stable.
>> ...or more specifically, any CXL region discovery after that point is a
>> typical runtime dynamic discovery event that is not subject to any
>> deferral.
>>
>>> And each deferred worker should observe the same CXL state and
>>> therefore compute the same final policy (either DROP or REGISTER).
>> The expectation is one queue, one event that takes the rwsem and
>> dispositions all present regions relative to initial soft-reserve memory
>> map.
>>
>>> Also, I was assuming that even if multiple process_defer_work()
>>> instances run, the operations they perform are effectively safe to
>>> repeat.. though I'm not sure on this.
>> I think something is wrong if the workqueue runs more than once. It is
>> just a place to wait for initial device probe to complete and then fixup
>> all the regions (allow dax_region registration to proceed) that were
>> waiting for that.
>>
>>> cxl_region_teardown_all(): this ultimately triggers the
>>> devm_release_action(... unregister_region ...) path. My expectation was
>>> that these devm actions are single shot per device lifecycle, so
>>> repeated teardown attempts should become noops.
>> Not noops, right? The definition of a devm_action is that they always
>> fire at device_del(). There is no facility to device_del() a device
>> twice.
>>
>>> cxl_region_teardown_all() ultimately leads to cxl_decoder_detach(),
>>> which takes "cxl_rwsem.region". That should serialize decoder detach and
>>> region teardown.
>>>
>>> bus_rescan_devices(&cxl_bus_type): I assumed repeated rescans during
>>> boot are fine as the rescan path will simply rediscover already present
>>> devices..
>> The rescan path likely needs some logic to give up on CXL region
>> autodiscovery for devices that failed their memmap compatibility check.
>>
>>> walk_hmem_resources(.., hmem_register_device): in the DROP case,I
>>> thought running the walk multiple times is safe because devm managed
>>> platform devices and memregion allocations should prevent duplicate
>>> lifetime issues.
>>>
>>> So, even if multiple process_defer_work() instances execute
>>> concurrently, the CXL operations involved in containment evaluation
>>> (cxl_region_contains_soft_reserve()) and teardown are already guarded.
>>>
>>> But I'm still trying to understand if bus_rescan_devices(&cxl_bus_type)
>>> is not safe when invoked concurrently?
>> It already races today between natural bus enumeration and the
>> cxl_bus_rescan() call from cxl_acpi. So it needs to be ok, it is
>> naturally synchronized by the region's device_lock and regions' rwsem.
>>
>>> Or is the primary issue that dax_cxl_mode is a global updated from one
>>> context and read from others, and should be synchronized even if the
>>> computed final value will always be the same?
>> There is only one global hmem_platform device, so only one potential
>> item in this workqueue.
>
>
>Well, I do not think so.
>
>
>hmem_init() in drivers/dax/device.c walks IORESOURCE_MEM looking for 
>IORES_DESC_SOFT_RESERVED descriptors and calling hmem_register_one for 
>each of them. That leads to create an hmem_platform platform device (no 
>typo, just emphasizing this is a platform device with name 
>hmem_platform) so there will be as many hmem_platform devices as 
>descriptors found.
>
>
>Then each hmem_platform probe() will create an hmem platform device, 
>where a work will be schedule passing this specific hmem platform device 
>as argument. So, each work will check for the specific ranges of its own 
>pdev and not all of them. The check can result in a different value 
>assigned to dax_cxl_mode leading to potential race conditions with 
>concurrent workers and also potentially leaving soft reserved ranges 
>without both, a dax or an hmem device.

Hi Alejandro,

Isn't below  check in __hmem_register_resource ensuring that only one
hmem_platform device can be created? So first resource would
create platform device and set the platform_initialized bool to true

static void __hmem_register_resource(int target_nid, struct resource *res)
..
	if (platform_initialized)
		return;
..

Thanks,
Tomasz

