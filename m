Return-Path: <linux-fsdevel+bounces-79451-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4CtPJ3TOqGn/xQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79451-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Mar 2026 01:29:40 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED742096EB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Mar 2026 01:29:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 52E8C3004F2F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Mar 2026 00:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E071D798E;
	Thu,  5 Mar 2026 00:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EOEwvuTI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5A6CA5A
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Mar 2026 00:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772670577; cv=none; b=JIjXa02t3OiwwJFQppk4j8ipG7YkmoJHflR8rfSherdK8SpJJCXBujNR63HL5wGedmt1iBJYlyc4icn6qpz7lwCkyYJcssMtINbSa1nUuh6HDQQX3dHLErigX/zgfRJ6tC/42b+qFgu7mDB+yefy8xIVlX7vUwA/WfrkYVgW9wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772670577; c=relaxed/simple;
	bh=8w0/2aHTgk3Y1URJHcCGIqdHYV02OC9XJLx3AaRaVrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pHTWc3lN/goj1Lr1XOMc1O4CQSd7yMytUYlJ0BVya4O65iOCvn1MS3B9p7ftxh4uPg3GfzmrwARggtwpiR7KZadq4r6kGox0GFjTZlc5omKD3vZ4d5lVV9mlTkWEXS3LxpOM7/Iq7/i2gSd0iZVykVLU4RQfcHqC5Aeh6ZvQ2eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EOEwvuTI; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3598df39444so2312188a91.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Mar 2026 16:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772670575; x=1773275375; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9jlNrAz1UvM653xado2ms+LhpEPfsdXO8bzmSwpijj4=;
        b=EOEwvuTIEe1YQ6knzwBJigzq6Gag8aAZy88Lt3cBCm5mrOofMREs36BTSwCcXPOBjK
         ZkV4jecWmp/x73wWuydRKNuvrJcyiVNfoRU+y97LSKBbUOhRxWFIs05JChFfjKTWtz2N
         n7jZcXKVAeFFY1v6ytA2uVR+b9mimjPVDyLt4KUimaBJ4h0twrNzxWa7v9Nb0XAaYm+I
         j/Yhbf4KLVS0//zRqdNthhp91CVGJKnGtgGndxO7S8HJke771lJP47fWm2iaX8I8BHOm
         SjYbMnSjowdCWAxyZhgceldrx7iNCHeiR/Ko97ttfE0dMc1wq+43+H2qRxBfiMalUkaL
         /YOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772670575; x=1773275375;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9jlNrAz1UvM653xado2ms+LhpEPfsdXO8bzmSwpijj4=;
        b=q7fKoNPA4KpZJ3suwjQeeJlka7+LJoEnDCaJBepwqqhsEqqo1K9RYtDcb9mJFclyBy
         ATsetp1cR5pzmzGrksO4tt5H7I1JTuvCmptZnax4qxXZb4I7QB15GleCgpQKFVs8HY1v
         KuSdRYIW5kYhS0a7IGPI6tVoTE66J0PWIhk5hlOJj8wfuunphRCDg+wSQKsQsTzaTzLb
         VRHycIEr1xZMoMe/povwVqSL6RMmnZLuPVRJoiTCf9YcULNpuYspiXLev48IXk+VMgJs
         iJrKXQtwIM67hJMeCZQ9IErlu58C35yK4szWZJjpdec96K+pKLcQZ9PCvmBq3WVrWZ95
         IEkg==
X-Forwarded-Encrypted: i=1; AJvYcCXvIv95LdXYNfRttoSkMXG7o5CTGBNoBpFaQCNZnzf/PhwfUxf26OycSNIhffi7muq6W0S0+Y12E3krANCI@vger.kernel.org
X-Gm-Message-State: AOJu0YytOAOAMuI0hjthH9KPsU9xvYf5pHHqp/8md2hOfPttmis15CnW
	u0rMCbHwpC/ceA3Po/bbFbixguHykjQcRNuXmV1f6a73gXgW4hhllsrc
X-Gm-Gg: ATEYQzyFzWA0q7w4lsg8hFP9ATjNswWkCIlxFr/ukgnPQwoAKElqjgnawls3D3AuYSX
	jGihs30wPZABcU4BV/Y0ZwJqn/RVMhrbaGhc3Y23tMSNJotEXELHiLTd69ADhwYWSez/VkbXOC8
	VC8BhFziROt0s/zDWhYS4JlaZtyDLR3umFSfd+heM9vokH2Y6yhdIhBXcFib3FQ3D4kC9G3jwDD
	8yOiXVr8elTQzlquIwlfDNGSA+/sCqGCamR6z3HK1uSrobYz68nQwbri2pZIHDMItcgQjrMYXhI
	I8Xwcx4+WSfG948xlkxEVe/A6Fj3GUNi2jbCoUasFevTKt93XWiARpVOslYE+HLNtGF5f2x34m4
	hmZBgUipP5yk+ExIuDlqlu6pRlxCn/0TwagIMMKiNniIG1bJNUT0dtz98Xj3EOX1hn5YK8S3qzR
	FDV1eiP5/4bRz7Vg==
X-Received: by 2002:a17:90b:1b0d:b0:359:8dc0:428d with SMTP id 98e67ed59e1d1-359a6a531acmr3412364a91.25.1772670575448;
        Wed, 04 Mar 2026 16:29:35 -0800 (PST)
Received: from localhost ([27.122.242.71])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359b2d50ebdsm73977a91.5.2026.03.04.16.29.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 16:29:34 -0800 (PST)
Date: Thu, 5 Mar 2026 09:29:33 +0900
From: Hyunchul Lee <hyc.lee@gmail.com>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "hch@infradead.org" <hch@infradead.org>,
	"glaubitz@physik.fu-berlin.de" <glaubitz@physik.fu-berlin.de>,
	"frank.li@vivo.com" <frank.li@vivo.com>,
	"slava@dubeyko.com" <slava@dubeyko.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"cheol.lee@lge.com" <cheol.lee@lge.com>
Subject: Re: [PATCH] hfsplus: limit sb_maxbytes to partition size
Message-ID: <aajObSSRGVXG3sI_@hyunchul-PC02>
References: <20260303082807.750679-1-hyc.lee@gmail.com>
 <aaguv09zaPCgdzWO@infradead.org>
 <5c670210661f30038070616c65492fa2a96b028c.camel@ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5c670210661f30038070616c65492fa2a96b028c.camel@ibm.com>
X-Rspamd-Queue-Id: 3ED742096EB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79451-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hyclee@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Wed, Mar 04, 2026 at 08:04:30PM +0000, Viacheslav Dubeyko wrote:
> On Wed, 2026-03-04 at 05:08 -0800, Christoph Hellwig wrote:
> > On Tue, Mar 03, 2026 at 05:28:07PM +0900, Hyunchul Lee wrote:
> > > s_maxbytes currently is set to MAX_LFS_FILESIZE,
> > > which allows writes beyond the partition size.
> > 
> > The "partition size" does not matter here.  s_maxbytes is the maximum
> > size supported by the format and has nothing to do with the actual space
> > allocated to the file system (which in Linux terminology would be the
> > block device and not the partition anyway).
> > 
> > > 
> > > As a result,
> > > large-offset writes on small partitions can fail late
> > > with ENOSPC.
> > 
> > That sounds like some other check is missing in hfsplus, but it
> > should be about the available free space, not the device size.
> > 
> 
> I agree with Christoph.
> 
> But, frankly speaking, I don't quite follow which particular issue is under fix
> here. I can see that generic/268 failure has been mentioned. However, I can see
> this:
> 
> sudo ./check generic/268 
> FSTYP         -- hfsplus
> PLATFORM      -- Linux/x86_64 hfsplus-testing-0001 6.19.0-rc1+ #95 SMP
> PREEMPT_DYNAMIC Thu Feb 19 15:29:55 PST 2026
> MKFS_OPTIONS  -- /dev/loop51
> MOUNT_OPTIONS -- /dev/loop51 /mnt/scratch
> 
> generic/268       [not run] Reflink not supported by scratch filesystem type:
> hfsplus
> Ran: generic/268
> Not run: generic/268
> Passed all 1 tests
> 
> Which particular issue is under fix?

Sorry it's generic/285, not generic/268.
in generic/285, there is a test that creates a hole exceeding the block
size and appends small data to the file. hfsplus fails because it fills
the block device and returns ENOSPC. However if it returns EFBIG
instead, the test is skipped.

For writes like xfs_io -c "pwrite 8t 512", should fops->write_iter
returns ENOSPC, or would it be better to return EFBIG?

> 
> Thanks,
> Slava.

-- 
Thanks,
Hyunchul

