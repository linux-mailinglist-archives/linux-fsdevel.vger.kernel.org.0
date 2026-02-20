Return-Path: <linux-fsdevel+bounces-77818-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cHz4AWC7mGktLgMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77818-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 20:52:00 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF5616A77B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 20:51:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A01E30470D6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 19:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 561F12F3618;
	Fri, 20 Feb 2026 19:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="U023nnZr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884D02D9492
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Feb 2026 19:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771617109; cv=none; b=d88BP+BK0gPs97Y0P4zeshXJGoUnEbrnS0XGnnTSxxeuKSU3NAFsqeDeh9lB4mn9BhpwzFDj5GwavPk33dMZPnffnuFRmsTiM0lJdZPJmKfcVLGqbFW+f8wj+tpO0yDnNtXGoMQpqqwYz/6/W6mTzUQQanHUdvdlco2l+HXC9NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771617109; c=relaxed/simple;
	bh=Sna3faXRtux0Z9f8A66NY4rgLle0iab1MWcshAkBqEk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=BoB1GHgS2jJFlv9iVOztASQWctkJQibz18jWVSGyolIW1q77RLwBl+eYeY6Hl1U1zEIWgjgOE4zhdmlhWN9WOA7CadDBZ4GFZHXR+sIrQ4Z/jABbtTm97Lkj+BqF00Tdz73Tbx/XCKxDlNQukNDSEcj69iLC4ur/v2GcyZ8QANI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=U023nnZr; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20260220195144epoutp03c7c5f42bf530e6b0b490690ff10283a2~WDF7ZHOU61150411504epoutp03a
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Feb 2026 19:51:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20260220195144epoutp03c7c5f42bf530e6b0b490690ff10283a2~WDF7ZHOU61150411504epoutp03a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1771617104;
	bh=qJfXqlaMYUrivx9UbRrp/3ASCTxv81wpGnEms4X1HLs=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=U023nnZrRK1h8bylNcZR699fxymrNYNUnArJJhCAAREixmcduBvMgPZe8x97LF+yu
	 2Zu51U+G32s4pqb/pWBQYPwyH6G/LD2YWjqF1h+yjRCMuAukWixmQVL8jEJ8pSi5xP
	 fmRs6wD/Snt3SHhFzwtWfITW8xgngdGrIgNpj4Mk=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPS id
	20260220195143epcas5p2fd265f018d7953738de4a5e7971cf5e3~WDF6M-1W50438904389epcas5p2N;
	Fri, 20 Feb 2026 19:51:43 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.89]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4fHgqf5LNMz2SSKX; Fri, 20 Feb
	2026 19:51:42 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20260220195141epcas5p185689d52acc2604fe2da5000934e9cc6~WDF4RLwKw2242822428epcas5p12;
	Fri, 20 Feb 2026 19:51:41 +0000 (GMT)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260220195139epsmtip173c94db8a8c22d49e6fd6920dbc1b287~WDF2pZZd72353723537epsmtip1X;
	Fri, 20 Feb 2026 19:51:39 +0000 (GMT)
Message-ID: <ee9893dc-986b-403e-8ba9-5fe4670459b6@samsung.com>
Date: Sat, 21 Feb 2026 01:21:38 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] FDP file I/O via write-streams
To: Christoph Hellwig <hch@lst.de>
Cc: "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>, Keith Busch <kbusch@kernel.org>,
	jack@suse.cz, amir73il@gmail.com
Content-Language: en-US
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20260220151137.GB14064@lst.de>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260220195141epcas5p185689d52acc2604fe2da5000934e9cc6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260220110725epcas5p41a6ae8751fee9782f338cbd66dd2700d
References: <CGME20260220110725epcas5p41a6ae8751fee9782f338cbd66dd2700d@epcas5p4.samsung.com>
	<83f2e586-75d8-44a3-8427-ea6165f1dff9@samsung.com>
	<20260220151137.GB14064@lst.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[samsung.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[samsung.com:s=mail20170921];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.linux-foundation.org,vger.kernel.org,kernel.org,suse.cz,gmail.com];
	TAGGED_FROM(0.00)[bounces-77818-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[samsung.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshi.k@samsung.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 8EF5616A77B
X-Rspamd-Action: no action

On 2/20/2026 8:41 PM, Christoph Hellwig wrote:
> I think you'll get much better traction if you don't tie a high-level
> feature to the buzzword of yesteryear as one possible implementation.
> 
Let me confirm my understanding. Perhaps this is about using the term 
stream in the UAPI naming (i.e., FS_IOC_WRITE_STREAM ioctl) and the 
concern is that it reminds of the older NVMe multi-stream (streams 
directive) feature?

My thought process was: block-layer already abstracts the 
hardware-specific implementation (NVMe FDP's placement id/RUHs) into 
generic write-stream construct (and this name is also used in io_uring 
SQE for per I/O), so it seemed fine to extend the existing block-layer 
terminology up to the VFS user-interface.

If I decouple the user-facing interface (and also iomap and xfs inode 
too) from block-layer's naming, would one of the following address the 
concern and be more palatable for VFS-level abstraction?
- FS_IOC_PLACEMENT_GROUP (or _CLASS)
- FS_IOC_WRITE_GROUP

But if you meant something else (that should be changed in patches), 
please elaborate.

