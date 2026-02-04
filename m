Return-Path: <linux-fsdevel+bounces-76357-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iGzOMvHWg2lbuwMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76357-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 00:32:01 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA28ED498
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 00:32:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4ADAA3050D56
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Feb 2026 23:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2958F3A0B0B;
	Wed,  4 Feb 2026 23:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="kppxTa81";
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="eRLn0W4C";
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="eRLn0W4C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail1.bemta45.messagelabs.com (mail1.bemta45.messagelabs.com [85.158.142.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A761039E6CB;
	Wed,  4 Feb 2026 23:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.158.142.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770247687; cv=none; b=rqDbAhLvX8IX9pssrQ+ipEGI4kww2H9nhg4hwa+/7t43TJe7vIoKgmFrVfiqPY/Sih9w9jXZQX4G7lv+6WDIUiIhs5A6RJ0sJXD4LuKhiOxilXeT2c/GHv7xkI+VMkrUXn+frw+AYUHsuPNI8q012iw7M6WqN9axDyonmyRRyKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770247687; c=relaxed/simple;
	bh=RTgoh1URLzesQ/bDDWsOSGNKKatiPoxeEWWxVFDR/R4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YpDj1kDJvxxIchcFJrp9eu5xutMHoXWEDtp2QFZ+MKFiI0yqBTteu3GrAfvzlCQPgoP5EvwmOUBkZ/m7Rq+1uDB1JGb345R1UbyjgoYBMl16lIK+1V3RV2UcOXi5IGFvinfjxPewSe7lAqN/TwLpJEK81TbavLKW8Tb/1YMInpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=kppxTa81; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=eRLn0W4C; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=eRLn0W4C; arc=none smtp.client-ip=85.158.142.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
	s=170520fj; t=1770247684; i=@fujitsu.com;
	bh=/wcBbpG/fe1WA2GpRprGItWbDS58o1LvjODQUxOXBgs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	b=kppxTa81axupJRTu6pYoMis4a8zkzfiSGsueKAhmGvkKitYjES1WF8IeQj0R8FpaI
	 GDTIBFxvRlDG9eiCsozX88YEpbcBgxKWNuLiB9qaZlJgSqfw3y+J/Yq9Gbb3H9rIWZ
	 YY4hdqyfSNgVryJwgAIEuYEVijvt8JfhUBfQ/B3DrdHLtIGQBGv9zUOD9DpHi9/7SZ
	 cozBjWP0k8nOIjh3sg8PtgtWPgrgmHCGnp8a8W5/QNJRCsxQwu8d/w6+uEtUQj/Cae
	 46wEifpQ57t9UZxqwJaebA8afWUDfr4Yxq+n0cV7ViAYqO2zzKlHmQedNUA85822ac
	 GNudX8IJodxwA==
X-Brightmail-Tracker: H4sIAAAAAAAAA22Se0xTZxjG+51bDx0lh4LpJ6IkFXXRUJFd8rk
  xNl1mTsYC2x+QRUe2Uzy01VJqWwyYTHGlTmGC6CpruajxMmGoXJWqCBLCbWbcyRCZsIHDOgIM
  MrpRdKcQ1CX77837/J7nff54aVw2QgXRfJqZN+o5nYKSEFGR9MkwUb9FG/7MrUBDv3VS6O/ZS
  YDyiv/C0Ez5Uwrl2zoBah04TKEfBsoAspy/RqGOKg+F6sd+J1BBvgVDJ2v7cFR6rp9Cjm/rMN
  ThaCfQ7bo2AvXcLKTQzPEmgKzFEwAdHbNhqMTtIdHRyQwctRxvwFDRrA1HD05fAih/fIFEZbP
  TOBps7SDR/RPNGJp3CwF3mh4S74Wwc9YcgrV2L1Cs0zEkZjObJki26vJG9vztxxhbWXqMYuuL
  ysTseJUdsA2uBcDaCg6x9842idmZyjXsfEEz+NhvJ6nVq1LSviA19zJzgKEqLC0zN4PMAL2hW
  UBCy5hqALtanOIs4EMTTCz8tXyK8goEc52AD+pqwBL1NQbdRy6Ty5TT5Sb/hyoCsPqRdZGimM
  3w51OFwDsHMsGw/NkN3AvhTA0FM7tvLEIBDA+HZ3Kwpdh1sL21iPDOUuYdWOkcXTRDJgSesbU
  t8j5MJLzl6cW9s4x5Gz4auUIu8f6wzT4qeGnhwAZ4rVjmXeOC1VJTgC/FrId9P1XiJ0Cg4yWH
  44XD8ZLjLMBLwVYTb9zPG8MilCqjVq0xJ3NanZI7EMYp+VRjioEP06cYzZotSnWiQcmbTEpTe
  nKibrdSz5srgfBnkil/shbMLVg3N4KVNKZYIcW1Fq3MT5WyO13DmTSfG1N1vKkRBNO0Akoreg
  TN38ir+bQkrU741mUZ0r6KQGlJryBLTQYu2aRVL0nt4DX6WH1WA05PP7bdxWWEPkXPB8mlU10
  CynhRTar+edDy53eD1UEBUiASiWS+Bt6YrDX/V3cBOQ0UAdJ4bx9frd78/J5LqIIJVfovHvZW
  MXMvpKAMLMEW3Tee2ii7XrXNM5k1dOFgzOon8jguAg2Gfja86r54pGLA9kl2dO7A3h/VR+5M/
  bHrXXeLepdPuCXR05S9Vhwv/qdE0v4hEbi948L2u6+K7M6guOj96wpfORBxrvRq10dcZBSXtC
  Z2X9Ims/ngG80lO54upD7se3+iLkF16Tv13p21e3bEndp0dSw2r2JFq/9wiAT2FB/C9rS2faW
  J18uzPQU+TGfom18abr1ulzXTmSNv9Ralb033u3mmNmtl/bw86lN/sj2KUCSczl9lz50O/+aX
  70cNNqcse+22wSsxCXYPyp5QWYKdH+RV9EvyhlTVMa4Nc1Nj1fI/e/bFKGiMe6IgTBpuy0bca
  OL+BUGOxLR0BAAA
X-Env-Sender: tomasz.wolski@fujitsu.com
X-Msg-Ref: server-3.tower-838.messagelabs.com!1770247679!32445!1
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received:
X-StarScan-Version: 9.120.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 12431 invoked from network); 4 Feb 2026 23:28:00 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
  by server-3.tower-838.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 4 Feb 2026 23:28:00 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
	by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id 49B18100614;
	Wed,  4 Feb 2026 23:27:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 n03ukasimr02.n03.fujitsu.local 49B18100614
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
	s=dspueurope; t=1770247679;
	bh=/wcBbpG/fe1WA2GpRprGItWbDS58o1LvjODQUxOXBgs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eRLn0W4CelTHDfI+I8ssjb0yJQMPREvqo/AvbhrJ7HvlffkpW5+foyRXvXddoP40X
	 7uFZdN5whb6wyO4st63AVh7+uk41Hw4cI/6l+giT9ejVgjRjgi5sZbiDvzzZ7QwtBh
	 +U0yYsVpYZ3HpB+GnFHFSjWvveedRvykCWmp21gq54OnU9YwunGf82FYtQoB1gsEEs
	 ncFVAvImjyBQqg1RQpdE+aLKZPgnNO8WnQHjSpXHrKOTuA6OkGAtObgZSGao+kjV4/
	 ePnA2rHtS2/ALu9gd9Pbv/I2RhbFSjG1Ze3HWZSZUyd7yvf6+RSPFskiBu7FrvonBA
	 lGA+/GTUFt7Tg==
Received: from ubuntudhcp (unknown [10.172.107.4])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id 1CCB51005E1;
	Wed,  4 Feb 2026 23:27:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 n03ukasimr02.n03.fujitsu.local 1CCB51005E1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
	s=dspueurope; t=1770247679;
	bh=/wcBbpG/fe1WA2GpRprGItWbDS58o1LvjODQUxOXBgs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eRLn0W4CelTHDfI+I8ssjb0yJQMPREvqo/AvbhrJ7HvlffkpW5+foyRXvXddoP40X
	 7uFZdN5whb6wyO4st63AVh7+uk41Hw4cI/6l+giT9ejVgjRjgi5sZbiDvzzZ7QwtBh
	 +U0yYsVpYZ3HpB+GnFHFSjWvveedRvykCWmp21gq54OnU9YwunGf82FYtQoB1gsEEs
	 ncFVAvImjyBQqg1RQpdE+aLKZPgnNO8WnQHjSpXHrKOTuA6OkGAtObgZSGao+kjV4/
	 ePnA2rHtS2/ALu9gd9Pbv/I2RhbFSjG1Ze3HWZSZUyd7yvf6+RSPFskiBu7FrvonBA
	 lGA+/GTUFt7Tg==
Received: from isar2.ecs00.fujitsu.local (unknown [10.172.183.27])
	by ubuntudhcp (Postfix) with ESMTP id 326B122045F;
	Wed,  4 Feb 2026 23:28:41 +0000 (UTC)
From: Tomasz Wolski <tomasz.wolski@fujitsu.com>
To: dan.j.williams@intel.com
Cc: Smita.KoralahalliChannabasappa@amd.com,
	alison.schofield@intel.com,
	ardb@kernel.org,
	benjamin.cheatham@amd.com,
	bp@alien8.de,
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
Date: Thu,  5 Feb 2026 00:27:54 +0100
Message-Id: <20260204232754.9531-1-tomasz.wolski@fujitsu.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <697bd8b7fb6f_1d6f100e9@dwillia2-mobl4.notmuch>
References: <697bd8b7fb6f_1d6f100e9@dwillia2-mobl4.notmuch>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[fujitsu.com,reject];
	R_DKIM_ALLOW(-0.20)[fujitsu.com:s=170520fj,fujitsu.com:s=dspueurope];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[amd.com,intel.com,kernel.org,alien8.de,stgolabs.net,linuxfoundation.org,gmail.com,suse.cz,oss.qualcomm.com,huawei.com,vger.kernel.org,fujitsu.com,zohomail.com,lists.linux.dev,infradead.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76357-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tomasz.wolski@fujitsu.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[fujitsu.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_TWELVE(0.00)[34];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 3AA28ED498
X-Rspamd-Action: no action

>> > I was thinking through what Alison asked about what to do later in boot
>> > when other regions are being dynamically created. It made me wonder if
>> > this safety can be achieved more easily by just making sure that the
>> > alloc_dax_region() call fails.
>> 
>> Agreed with all the points above, including making alloc_dax_region() 
>> fail as the safety mechanism. This also cleanly avoids the no Soft 
>> Reserved case Alison pointed out, where dax_cxl_mode can remain stuck in 
>> DEFER and return -EPROBE_DEFER.
>> 
>> What I’m still trying to understand is the case of “other regions being 
>> dynamically created.” Once HMEM has claimed the relevant HPA range, any 
>> later userspace attempts to create regions (via cxl create-region) 
>> should naturally fail due to the existing HPA allocation. This already 
>> shows up as an HPA allocation failure currently.
>> 
>> #cxl create-region -d decoder0.0 -m mem2 -w 1 -g256
>> cxl region: create_region: region0: set_size failed: Numerical result 
>> out of range
>> cxl region: cmd_create_region: created 0 regions
>> 
>> And in the dmesg:
>> [  466.819353] alloc_hpa: cxl region0: HPA allocation error (-34) for 
>> size:0x0000002000000000 in CXL Window 0 [mem 0x850000000-0x284fffffff 
>> flags 0x200]
>> 
>> Also, at this point, with the probe-ordering fixes and the use of 
>> wait_for_device_probe(), region probing should have fully completed.
>> 
>> Am I missing any other scenario where regions could still be created 
>> dynamically beyond this?
>
>The concern is what to do about regions and memory devices that are
>completely innocent. So, for example imagine deviceA is handled by BIOS
>and deviceB is ignored by BIOS. If deviceB was ignored by BIOS then it
>would be rude to tear down any regions that might be established for
>deviceB. So if alloc_dax_region() exclusion and HPA space reservation
>prevent future collisions while not disturbing innocent devices, then I
>think userspace can pick up the pieces from there.

I'm trying to follow the idea of "deviceB being ignored by BIOS" 
Do you consider hot-plug devices and user creating reqions manually? 
Could you please describe such scenario?

>> > Something like (untested / incomplete, needs cleanup handling!)
>> > 
>> > diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
>> > index fde29e0ad68b..fd18343e0538 100644
>> > --- a/drivers/dax/bus.c
>> > +++ b/drivers/dax/bus.c
>> > @@ -10,6 +10,7 @@
>> >   #include "dax-private.h"
>> >   #include "bus.h"
>> >   
>> > +static struct resource dax_regions = DEFINE_RES_MEM_NAMED(0, -1, "DAX Regions");
>> >   static DEFINE_MUTEX(dax_bus_lock);
>> >   
>> >   /*
>> > @@ -661,11 +662,7 @@ struct dax_region *alloc_dax_region(struct device *parent, int region_id,
>> >          dax_region->dev = parent;
>> >          dax_region->target_node = target_node;
>> >          ida_init(&dax_region->ida);
>> > -       dax_region->res = (struct resource) {
>> > -               .start = range->start,
>> > -               .end = range->end,
>> > -               .flags = IORESOURCE_MEM | flags,
>> > -       };
>> > +       dax_region->res = __request_region(&dax_regions, range->start, range->end, flags);
>> >   
>> >          if (sysfs_create_groups(&parent->kobj, dax_region_attribute_groups)) {
>> >                  kfree(dax_region);
>> > 
>> > ...which will result in enforcing only one of dax_hmem or dax_cxl being
>> > able to register a dax_region.
>> > 
>> > Yes, this would leave a mess of disabled cxl_dax_region devices lying
>> > around, but it would leave more breadcrumbs for debug, and reduce the
>> > number of races you need to worry about.
>> > 
>> > In other words, I thought total teardown would be simpler, but as the
>> > feedback keeps coming in, I think that brings a different set of
>> > complexity. So just inject failures for dax_cxl to trip over and then we
>> > can go further later to effect total teardown if that proves to not be
>> > enough.
>> 
>> One concern with the approach of not tearing down CXL regions is the 
>> state it leaves behind in /proc/iomem. Soft Reserved ranges are 
>> REGISTERed to HMEM while CXL regions remain present. The resulting 
>> nesting (dax under region, region under window and window under SR) 
>> visually suggests a coherent CXL hierarchy, even though ownership has 
>> effectively moved to HMEM. When users, then attempt to tear regions down 
>> and recreate them from userspace, they hit the same HPA allocation 
>> failures described above.
>
>So this gets back to a question of do we really need "Soft Reserved" to
>show up in /proc/iomem? It is an ABI change to stop publishing it
>altogether, so at a minimum we need to be prepared to keep publishing it
>if it causes someone's working setup to regress.
>
>The current state of the for-7.0/cxl-init branch drops publishing "Soft
>Reserved". I am cautiously optimistic no one notices as long as DAX
>devices keep appearing, but at the first sign of regression we need a
>plan B.
>
>> If we decide not to tear down regions in the REGISTER case, should we 
>> gate decoder resets during user initiated region teardown? Today, 
>> decoders are reset when regions are torn down dynamically, and 
>> subsequent attempts to recreate regions can trigger a large amount of 
>> mailbox traffic. Much of what shows up as repeated “Reading event logs/ 
>> Clearing …” messages which ends up interleaved with the HPA allocation 
>> failure, which can be confusing.
>
>One of the nice side effects of installing the "Soft Reserved" entries
>late, when HMEM takes over, is that they are easier to remove.
>
>So the flow would be, if you know what you are doing, is to disable the
>HMEM device which uninstalls the "Soft Reserved" entries, before trying
>to decommit the region and reclaim the HPA space.
>

