Return-Path: <linux-fsdevel+bounces-75273-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0LTMMIpnc2mivQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75273-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 13:20:26 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5807175AD2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 13:20:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 789AA30498E6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 12:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E946267B92;
	Fri, 23 Jan 2026 12:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="O6kpcJ/L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0B0222575
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Jan 2026 12:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769170720; cv=none; b=k5IQ6oAJfU2vjDnMSWAiF3CPos9ko6gka0XW6Qurf2yiaLMs7rbKAgRPDds4J0wdD8DHJAbnNnF8kn0H0GCuA+v2nSvGlAAhS2bjX9vWpvBgjZ1RK11l2fNpWB1IgYTLJJE1gJGu7OAQERwKcfPxvsaW6vAwDt9/vOuM56qXiak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769170720; c=relaxed/simple;
	bh=Ibv50jU/EOdekdVYIAJPI44nrpi7ec4RH5igVxtsObo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=ah3zndsm/HpzRgQRB6E2VvEoLEKxbfLA0cD1XDN9/6Bq7NxXBjPFFHPSEoD5tC8bsqQNoSo6N9ADExDdSyfTOGignsKi/FQKfVGgE4IohqTQjuHEEl7vQu+vz5yRbGH75lZzfVmLJnGbBG5V3OKVb0oY9Qck9zgqqEi/fdLLjcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=O6kpcJ/L; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20260123121836epoutp03394b97aa1363595772a7a50beabb8955~NW2STCVXg2612926129epoutp03d
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Jan 2026 12:18:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20260123121836epoutp03394b97aa1363595772a7a50beabb8955~NW2STCVXg2612926129epoutp03d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1769170716;
	bh=Ibv50jU/EOdekdVYIAJPI44nrpi7ec4RH5igVxtsObo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=O6kpcJ/LOM5juIc2+PSBkjULkndByHLszHOhF4y1/wZkjKg0TlIbKcc78cC/WlHj9
	 pis948jRu5Xad8R7HRNCUBKVe1iTX4Q9vDmIsLYd4Zqgg1e4uoGr677FaCe2+uef73
	 T25Ia3foGItfQ6UNM3a4fT/q6jZhrfGSvKIr8Apc=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20260123121835epcas5p35edc9c7b887ace25845fb69073fd02c1~NW2R0pHFq0347603476epcas5p3F;
	Fri, 23 Jan 2026 12:18:35 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.92]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4dyH5k4wG7z6B9m6; Fri, 23 Jan
	2026 12:18:34 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20260123121834epcas5p16908988385a372270e3f617c6b0a52d9~NW2Qj7lKT1530515305epcas5p1p;
	Fri, 23 Jan 2026 12:18:34 +0000 (GMT)
Received: from green245.gost (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260123121832epsmtip1ab33741bd6d15ae8a231c7e47e81dba4~NW2POcCiO1297612976epsmtip1P;
	Fri, 23 Jan 2026 12:18:32 +0000 (GMT)
Date: Fri, 23 Jan 2026 17:44:16 +0530
From: Anuj Gupta <anuj20.g@samsung.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>, Carlos Maiolino <cem@kernel.org>, Qu
	Wenruo <wqu@suse.com>, Al Viro <viro@zeniv.linux.org.uk>,
	linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 01/14] block: refactor get_contig_folio_len
Message-ID: <20260123121416.pdj5peze755kdnth@green245.gost>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260119074425.4005867-2-hch@lst.de>
X-CMS-MailID: 20260123121834epcas5p16908988385a372270e3f617c6b0a52d9
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----IrfruICR4kMULzJWPGPqiSt5VhS9eUGYkVmPB-DHhmy0YhYM=_11f361_"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260123121834epcas5p16908988385a372270e3f617c6b0a52d9
References: <20260119074425.4005867-1-hch@lst.de>
	<20260119074425.4005867-2-hch@lst.de>
	<CGME20260123121834epcas5p16908988385a372270e3f617c6b0a52d9@epcas5p1.samsung.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	CTYPE_MIXED_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[samsung.com,none];
	R_DKIM_ALLOW(-0.20)[samsung.com:s=mail20170921];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[samsung.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75273-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anuj20.g@samsung.com,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 5807175AD2
X-Rspamd-Action: no action

------IrfruICR4kMULzJWPGPqiSt5VhS9eUGYkVmPB-DHhmy0YhYM=_11f361_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 19/01/26 08:44AM, Christoph Hellwig wrote:
>Move all of the logic to find the contigous length inside a folio into
>get_contig_folio_len instead of keeping some of it in the caller.
>
>Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Anuj Gupta <anuj20.g@samsung.com

------IrfruICR4kMULzJWPGPqiSt5VhS9eUGYkVmPB-DHhmy0YhYM=_11f361_
Content-Type: text/plain; charset="utf-8"


------IrfruICR4kMULzJWPGPqiSt5VhS9eUGYkVmPB-DHhmy0YhYM=_11f361_--

