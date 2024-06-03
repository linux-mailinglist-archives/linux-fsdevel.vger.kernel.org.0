Return-Path: <linux-fsdevel+bounces-20853-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A06DC8D87BD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 19:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CFB31F235C4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 17:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6431136E26;
	Mon,  3 Jun 2024 17:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="gxqXSxhz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB2C12EBCA;
	Mon,  3 Jun 2024 17:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717434796; cv=none; b=DlH7QsJoy3nVDPak4A3HUslpYgW1rdxmwtYs0aCTGK87s7jgHpTyU6PwQhSH0YkmuABFvZ7SVvMrrriubDKgaQ5c+eqRwd+NLe2ickfv/Cfx1aB1VkbFHjXKb0mxUV7hAVUGxwS2hC9/wKI0h5Ig5uXy8URA7U5PD5k1buw6OGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717434796; c=relaxed/simple;
	bh=JvLh7AbakjmzOrW6DkzL8QseI/8qErtZlt8Ymeg//Dc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W41Y8bD/slkxKTXPeuzkCyJ+VURMR8iNchWJ2/7U31UG5S3XnLtVFOHNIihQ9JoypeCnhvnP54UbU5i70f4QmavLG3Yf1uj/U4vztKGyrv9Rw2BLidZ9CJGj0+BF9eKVmwKJkkB09lkSA0AKGiwcWy8daWHUiubjxjF87rJa6lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=gxqXSxhz; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4VtL036QTzz6CmQtD;
	Mon,  3 Jun 2024 17:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1717434776; x=1720026777; bh=v5lz8KDSVqQxkVH7H7CVN5A4
	DbKQZhIXNO+ngY2Ze6U=; b=gxqXSxhzpblr5Pr//MwRCn6ubzSylXkeRojMTrLA
	pI+/3nY5RsSrCKLBRXmo4tvyPlm1atdv/yQUc19ruOrub0WzBxgEngx+z8ZBK7CN
	z2LWF2xwH0N+8gwAAOUr9vGGxQZfuktIQEH44zyFv0Ozg1U63A6m9MFYm5Z4Vtip
	R43+TjNareecPim87+fX8wvQtiscHn21Ly4/6EE4o663Pks+2WwoQ5JQuy6T5FVy
	bHwZP3+sDp8vygc53DhScfnLDQpTHf9mcLZr1Xktgz7bWMSyX+84Ct4IuOn7mWKz
	7wTjIIowjeVZWKCf0y87eCG7hhXr2HLGMfxeXkwVhMK3OQ==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id MlLOLRIWRk0a; Mon,  3 Jun 2024 17:12:56 +0000 (UTC)
Received: from [192.168.50.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4VtKzl6rhRz6CmQwP;
	Mon,  3 Jun 2024 17:12:51 +0000 (UTC)
Message-ID: <d7ae00c8-c038-4bed-937e-222251bc627a@acm.org>
Date: Mon, 3 Jun 2024 10:12:48 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 02/12] Add infrastructure for copy offload in block
 and request layer.
To: Christoph Hellwig <hch@lst.de>
Cc: Nitesh Shetty <nj.shetty@samsung.com>, Damien Le Moal
 <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Jonathan Corbet <corbet@lwn.net>, Alasdair Kergon <agk@redhat.com>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>, martin.petersen@oracle.com, david@fromorbit.com,
 hare@suse.de, damien.lemoal@opensource.wdc.com, anuj20.g@samsung.com,
 joshi.k@samsung.com, nitheshshetty@gmail.com, gost.dev@samsung.com,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, dm-devel@lists.linux.dev,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
References: <20240520102033.9361-1-nj.shetty@samsung.com>
 <CGME20240520102842epcas5p4949334c2587a15b8adab2c913daa622f@epcas5p4.samsung.com>
 <20240520102033.9361-3-nj.shetty@samsung.com>
 <eda6c198-3a29-4da4-94db-305cfe28d3d6@acm.org>
 <9f1ec1c1-e1b8-48ac-b7ff-8efb806a1bc8@kernel.org>
 <a866d5b5-5b01-44a2-9ccb-63bf30aa8a51@acm.org>
 <665850bd.050a0220.a5e6b.5b72SMTPIN_ADDED_BROKEN@mx.google.com>
 <abe8c209-d452-4fb5-90eb-f77b5ec1a2dc@acm.org> <20240601055931.GB5772@lst.de>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240601055931.GB5772@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/31/24 22:59, Christoph Hellwig wrote:
> On Thu, May 30, 2024 at 10:11:15AM -0700, Bart Van Assche wrote:
>> This new approach has the following two disadvantages:
>> * Without plug, REQ_OP_COPY_SRC and REQ_OP_COPY_DST are not combined. These two
>>    operation types are the only operation types for which not using a plug causes
>>    an I/O failure.
> 
> So?  We can clearly document that and even fail submission with a helpful
> message trivially to enforce that.

Consider the following use case:
* Task A calls blk_start_plug()
* Task B calls blk_start_plug()
* Task A submits a REQ_OP_COPY_DST bio and a REQ_OP_COPY_SRC bio.
* Task B submits a REQ_OP_COPY_DST bio and a REQ_OP_COPY_SRC bio.
* The stacking driver to which all REQ_OP_COPY_* operations have been
   submitted processes bios asynchronusly.
* Task A calls blk_finish_plug()
* Task B calls blk_finish_plug()
* The REQ_OP_COPY_DST bio from task A and the REQ_OP_COPY_SRC bio from
   task B are combined into a single request.
* The REQ_OP_COPY_DST bio from task B and the REQ_OP_COPY_SRC bio from
   task A are combined into a single request.

This results in silent and hard-to-debug data corruption. Do you agree
that we should not restrict copy offloading to stacking drivers that
process bios synchronously and also that this kind of data corruption
should be prevented?

Thanks,

Bart.

