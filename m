Return-Path: <linux-fsdevel+bounces-75274-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mDd/H/Znc2mivQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75274-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 13:22:14 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C5175B2B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 13:22:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AD92B304320D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 12:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A898C2D6E76;
	Fri, 23 Jan 2026 12:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="m3M1j562"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F6728F50F
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Jan 2026 12:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769170813; cv=none; b=B1BNKiZY+f/VDUuCu1Bia+UlypnD174ch89/2Z59vX8DmiXm2yVfR+URPX0/JDDUtIE4I5yy/yq1/VlErnl2Xqe3eYNM/npvbOkN7mvRS9VA3qkE3oQZpX/L8rAR7wEWPxbhGVQbcb1iXriWpfo/txKlB1NDzVBMeJzk9aQ/1UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769170813; c=relaxed/simple;
	bh=ilL2dlrE/KiSomwQdu5uRqkjqR2ZbkgNV34FQzAfqYo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=c/dNaCt6D6QmKRmI696lgcetdNViAA+B+UJb5INopF/cawcXFkYWiXV7Eh2JuA9kqOPV57yk6LezrHsARdylYYV+TjtpXPOU43yWSP4WR8LX6ygjTEb3ZNDqlI23mbPsCAiqpKOXNluUCThw/2x/H2TmuBLjo2m/CiBA/5LnaMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=m3M1j562; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20260123122009epoutp02c0fea26383a0e40523d5d2b109910aff~NW3pQN1wV0828208282epoutp02M
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Jan 2026 12:20:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20260123122009epoutp02c0fea26383a0e40523d5d2b109910aff~NW3pQN1wV0828208282epoutp02M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1769170809;
	bh=6+VPzKKm5P4+Ukz98y3OdGrfpQMZIr0UqmXEbym8kBI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=m3M1j5627yLPoZL30Kc47gc3PxKWO6Dy7mXBhF9PunIhXyoVWYLOolryD9S+tbFcn
	 CwnVFYU4c0XCy7mYFZiL7MVxOtgU2T2du2f7VizleoYfSO4lFQBi2wz13JuCdCkvcP
	 c98DV+XAqFd7ysvkob1WXG7spGGYx91WGPp+LqfM=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20260123122009epcas5p497a6027961c55a49979853365ccb782b~NW3o6MLxm2354823548epcas5p48;
	Fri, 23 Jan 2026 12:20:09 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.86]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4dyH7X19GGz3hhT4; Fri, 23 Jan
	2026 12:20:08 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20260123122007epcas5p3e7949f3926d91a345d37a057466ccaf3~NW3nnYea-2988829888epcas5p3W;
	Fri, 23 Jan 2026 12:20:07 +0000 (GMT)
Received: from green245.gost (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260123122006epsmtip1d12cea2890678c165bf6707bb45365a0~NW3mTG6ie1400814008epsmtip1v;
	Fri, 23 Jan 2026 12:20:06 +0000 (GMT)
Date: Fri, 23 Jan 2026 17:45:53 +0530
From: Anuj Gupta <anuj20.g@samsung.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>, Carlos Maiolino <cem@kernel.org>, Qu
	Wenruo <wqu@suse.com>, Al Viro <viro@zeniv.linux.org.uk>,
	linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 02/14] block: open code bio_add_page and fix handling of
 mismatching P2P ranges
Message-ID: <20260123121553.cykonmoibjyvb6mq@green245.gost>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260119074425.4005867-3-hch@lst.de>
X-CMS-MailID: 20260123122007epcas5p3e7949f3926d91a345d37a057466ccaf3
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----HKC0oM6l2X7jDELFNxUL3gr1rNZobpnU9ZVzK0VPY15yFScq=_11fb2d_"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260123122007epcas5p3e7949f3926d91a345d37a057466ccaf3
References: <20260119074425.4005867-1-hch@lst.de>
	<20260119074425.4005867-3-hch@lst.de>
	<CGME20260123122007epcas5p3e7949f3926d91a345d37a057466ccaf3@epcas5p3.samsung.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTYPE_MIXED_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[samsung.com,none];
	R_DKIM_ALLOW(-0.20)[samsung.com:s=mail20170921];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[samsung.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75274-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,samsung.com:email,samsung.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anuj20.g@samsung.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 35C5175B2B
X-Rspamd-Action: no action

------HKC0oM6l2X7jDELFNxUL3gr1rNZobpnU9ZVzK0VPY15yFScq=_11fb2d_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 19/01/26 08:44AM, Christoph Hellwig wrote:
>bio_add_page fails to add data to the bio when mixing P2P with non-P2P
>ranges, or ranges that map to different P2P providers.  In that case
>it will trigger that WARN_ON and return an error up the chain instead of
>simply starting a new bio as intended.  Fix this by open coding
>bio_add_page and handling this case explicitly.  While doing so, stop
>merging physical contiguous data that belongs to multiple folios.  While
>this merge could lead to more efficient bio packing in some case,
>dropping will allow to remove handling of this corner case in other
>places and make the code more robust.
>
>Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Anuj Gupta <anuj20.g@samsung.com

------HKC0oM6l2X7jDELFNxUL3gr1rNZobpnU9ZVzK0VPY15yFScq=_11fb2d_
Content-Type: text/plain; charset="utf-8"


------HKC0oM6l2X7jDELFNxUL3gr1rNZobpnU9ZVzK0VPY15yFScq=_11fb2d_--

