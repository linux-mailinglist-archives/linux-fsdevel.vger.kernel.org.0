Return-Path: <linux-fsdevel+bounces-75507-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oABYEZCud2n2kAEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75507-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 19:12:32 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B13968BEFF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 19:12:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BA4AE30080A9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jan 2026 18:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D821E2858;
	Mon, 26 Jan 2026 18:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ePaB18WJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34250238C0D
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jan 2026 18:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769451140; cv=none; b=FpmRQuWTbRjDs/RshoKXbSv1six+FrILuXueOck0g86NcCJunIQ3gLM5EiWU3yS4QnaieaTSdInv2k+M/1dz8H0pjMtb2UAbJZCniPr0d5eAB7LNiRCM4HDMhOPHB1b7HZ0NW8TNOO61nrq9hgpDhXsFa79IQW9atzSp1IT2uYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769451140; c=relaxed/simple;
	bh=dUDJklRUyBCtwVBXqiZuTlf4ktJxUuHhz0YhaaM3L5Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=CpaNeAKLTErKFqC1I0edlLQ2KcGoeJtqEwgO6InatYy4jCvByzhVfRHWXdeVDYt37MKbV8idbzDUQ/pWDcbBy/nyY1K7wYS3xLPMYpqTjyvjrkZ8CkF3RLaLI/ZSowiTyn5qkBnAAt4tC3fvZETkT4iIBdM2CZc0h0v/0mFYApU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ePaB18WJ; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20260126181216epoutp02810f9d282e80919540dfe98c72dd0aa8~OWm77LlYN1156311563epoutp02Z
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jan 2026 18:12:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20260126181216epoutp02810f9d282e80919540dfe98c72dd0aa8~OWm77LlYN1156311563epoutp02Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1769451136;
	bh=HI9T2RA7VOtVuTSzybt8pORWuVyrZSQXeAtg/v4Fa4k=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=ePaB18WJeimp9QkKHAuBSTpvFWwc4tyhJuDaGMKvAKsEyHR0yeFzBiJLniLNi/Ci9
	 lU8QHbCheF+Ba9H3wos4Ssh7d0eaRSkU8dzm9pBURQD9rxOeqfsSFs1wBw7+q/+jZA
	 dF40Y10FQnFeeFXc7dObeQOOGWbGboMMomEcgTjs=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20260126181215epcas5p191ed832304a212ec72f7dc6d7dca698c~OWm7NZo-j0315803158epcas5p1P;
	Mon, 26 Jan 2026 18:12:15 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.38.92]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4f0GpQ4J00z6B9m4; Mon, 26 Jan
	2026 18:12:14 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20260126181213epcas5p4af751bc99b8580fa9ce35639c29dabdc~OWm5HONnU2857928579epcas5p4B;
	Mon, 26 Jan 2026 18:12:13 +0000 (GMT)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260126181211epsmtip27bf74f74dd344e89aa167a9d696f9bc8~OWm3pJ0TC1200712007epsmtip2r;
	Mon, 26 Jan 2026 18:12:11 +0000 (GMT)
Message-ID: <95af59e3-fe94-4d62-8931-5b8a9c7f8429@samsung.com>
Date: Mon, 26 Jan 2026 23:42:10 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/15] block: add fs_bio_integrity helpers
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, Christian
	Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Carlos Maiolino <cem@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>, Anuj Gupta
	<anuj20.g@samsung.com>, linux-block@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Content-Language: en-US
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20260121064339.206019-7-hch@lst.de>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260126181213epcas5p4af751bc99b8580fa9ce35639c29dabdc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260121064416epcas5p3aa66a19640d8d7411016e34a1fee0592
References: <20260121064339.206019-1-hch@lst.de>
	<CGME20260121064416epcas5p3aa66a19640d8d7411016e34a1fee0592@epcas5p3.samsung.com>
	<20260121064339.206019-7-hch@lst.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[samsung.com,none];
	R_DKIM_ALLOW(-0.20)[samsung.com:s=mail20170921];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[samsung.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[samsung.com:mid,samsung.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75507-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	FROM_NEQ_ENVFROM(0.00)[joshi.k@samsung.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: B13968BEFF
X-Rspamd-Action: no action

On 1/21/2026 12:13 PM, Christoph Hellwig wrote:
> +void fs_bio_integrity_alloc(struct bio *bio)
> +{
> +	struct fs_bio_integrity_buf *iib;
> +	unsigned int action;
> +
> +	action = bio_integrity_action(bio);
> +	if (!action)
> +		return;

So this may return from here, but <below>

> +
> +	iib = mempool_alloc(&fs_bio_integrity_pool, GFP_NOIO);
> +	bio_integrity_init(bio, &iib->bip, &iib->bvec, 1);
> +
> +	bio_integrity_alloc_buf(bio, action & BI_ACT_ZERO);
> +	if (action & BI_ACT_CHECK)
> +		bio_integrity_setup_default(bio);
> +}
> +
> +void fs_bio_integrity_free(struct bio *bio)
> +{
> +	struct bio_integrity_payload *bip = bio_integrity(bio);
> +
> +	bio_integrity_free_buf(bip);
> +	mempool_free(container_of(bip, struct fs_bio_integrity_buf, bip),
> +			&fs_bio_integrity_pool);
> +
> +	bio->bi_integrity = NULL;
> +	bio->bi_opf &= ~REQ_INTEGRITY;
> +}
> +
> +void fs_bio_integrity_generate(struct bio *bio)
> +{
> +	fs_bio_integrity_alloc(bio);

no check here. A potential null pointer deference in the next line as 
bio has no bip?
> +	bio_integrity_generate(bio);
> +}


