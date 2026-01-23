Return-Path: <linux-fsdevel+bounces-75275-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YB3tNQdpc2mivQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75275-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 13:26:47 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B34275BFE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 13:26:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 00BBD306E53E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 12:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5545230EF8B;
	Fri, 23 Jan 2026 12:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="pHzDMq9G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B88A2E7F11
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Jan 2026 12:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769170934; cv=none; b=DO1Fw4lithywa3qwmn3NW7XsSIX5J3nP//OLsVoW+xLGvyGFfPvGtc4KL5Q1QPcSE91yjy1NraPEAvj4ug0iecG0l9LgdM09qmG+MF3bJKB7614DETKwMDXLQ3Tg9Kry5DrOgGMbpuAT1vA3g3O48/rcRM66hRA4RZTcG2rvQpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769170934; c=relaxed/simple;
	bh=uE0Y4/PZw6wM3Bwc/XbiA6B4xt+1e3lNTVbeP03NVw0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=sWdR88ui8lZXjXMLQOty5BZ4C+lbmekJNtMpJLiS0w4po43ZxlH6H3tF+Vp2UbxvrydrtsAoRnmvrTlQP6G2PFahXaEwHAgvLk66jYv4rPqOHCEYsr8lT9ef4wFYlBqSYEsoqrwjkniHvRV/OC3Skhd+zZRkti2Zb4VyMF6rTQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=pHzDMq9G; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20260123122211epoutp015e4793355f910673145076922256904c~NW5a_jMGi2474624746epoutp01L
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Jan 2026 12:22:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20260123122211epoutp015e4793355f910673145076922256904c~NW5a_jMGi2474624746epoutp01L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1769170931;
	bh=uE0Y4/PZw6wM3Bwc/XbiA6B4xt+1e3lNTVbeP03NVw0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pHzDMq9GVyrdzmlgmj+xglim8lm/NSM9ExAxwKvli8ZCeQznXAuFbBzFV9jtIDlPt
	 Sh/A/HrUcnDyMr9NksMrblF1StFTJRF87NckjFlCaACmXqz88ydmg33LkZ0UblSt+3
	 4kpM2U3zZYurCzjNpb4Y72bt2+xOOmRn1j8tX09k=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20260123122211epcas5p3fc203848070cabcb3d1611b073778c37~NW5ajvokM0046200462epcas5p30;
	Fri, 23 Jan 2026 12:22:11 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.90]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4dyH9t3RKPz3hhT4; Fri, 23 Jan
	2026 12:22:10 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20260123122209epcas5p410ecea8a612e90a02822fc9a134d58a8~NW5ZLiw6V2254622546epcas5p4O;
	Fri, 23 Jan 2026 12:22:09 +0000 (GMT)
Received: from green245.gost (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260123122202epsmtip2e97547376611835d0ca7313b0258a322~NW5SvexHq2333523335epsmtip2w;
	Fri, 23 Jan 2026 12:22:02 +0000 (GMT)
Date: Fri, 23 Jan 2026 17:47:44 +0530
From: Anuj Gupta <anuj20.g@samsung.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>, Carlos Maiolino <cem@kernel.org>, Qu
	Wenruo <wqu@suse.com>, Al Viro <viro@zeniv.linux.org.uk>,
	linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 04/14] block: remove bio_release_page
Message-ID: <20260123121744.rv6cp4veiltp2ssi@green245.gost>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260119074425.4005867-5-hch@lst.de>
X-CMS-MailID: 20260123122209epcas5p410ecea8a612e90a02822fc9a134d58a8
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----dZkOkAIazzHoUX-2rQXwJ8woeHD-_lbejx.E5KOGiu3cq0eS=_11eefd_"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260123122209epcas5p410ecea8a612e90a02822fc9a134d58a8
References: <20260119074425.4005867-1-hch@lst.de>
	<20260119074425.4005867-5-hch@lst.de>
	<CGME20260123122209epcas5p410ecea8a612e90a02822fc9a134d58a8@epcas5p4.samsung.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	CTYPE_MIXED_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[samsung.com,none];
	R_DKIM_ALLOW(-0.20)[samsung.com:s=mail20170921];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[samsung.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75275-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anuj20.g@samsung.com,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 4B34275BFE
X-Rspamd-Action: no action

------dZkOkAIazzHoUX-2rQXwJ8woeHD-_lbejx.E5KOGiu3cq0eS=_11eefd_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 19/01/26 08:44AM, Christoph Hellwig wrote:
>Merge bio_release_page into the only remaining caller.
>
>Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Anuj Gupta <anuj20.g@samsung.com

------dZkOkAIazzHoUX-2rQXwJ8woeHD-_lbejx.E5KOGiu3cq0eS=_11eefd_
Content-Type: text/plain; charset="utf-8"


------dZkOkAIazzHoUX-2rQXwJ8woeHD-_lbejx.E5KOGiu3cq0eS=_11eefd_--

