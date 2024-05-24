Return-Path: <linux-fsdevel+bounces-20114-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79CEE8CE660
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 May 2024 15:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB1851C21AF1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 May 2024 13:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133B612C470;
	Fri, 24 May 2024 13:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="YVdOKINE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2195B86651;
	Fri, 24 May 2024 13:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716558782; cv=none; b=SQqllyvcEr4pVyQCyJjaPC/684PP2zJ6UAn1AR/oewnM6U3b6CEoRnak6YiSwpIZhb2EJZ0C6yTCQQt8VvIo5CtB0M2sYOyLpVRQFJXMDlyolbZg1zi6PowSMn/XzRS1YVP4itq82TkOg6y72i7+11by5Hdf4DtonsYRlFGHqZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716558782; c=relaxed/simple;
	bh=2rXmAoTx3CNlh/GGc7KRf6DwDOKO0u6bWqKxzMYf8jk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D2uv1afxbC90d/+oGzSBXZ7snV6GMiNxkTZX2/HiOtZe2DyxfpIybl+STfqVOBDz9pJDe5JNn5hU876bFPSeWWqYT5AUzZ/MFkyff+480PRhcp5P4EHvzzXLTJ5MlgYBkkG64obUZYh1yNrzcaUp350Gwh5NnINT5qdHVVleRUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=YVdOKINE; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4Vm61m2xr9zlgMVR;
	Fri, 24 May 2024 13:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1716558774; x=1719150775; bh=2rXmAoTx3CNlh/GGc7KRf6Dw
	DOKO0u6bWqKxzMYf8jk=; b=YVdOKINEcaBAiCvlkuTSwdmRd4IpR916nbHNtrWY
	5T2+ihVtDJKqlKwmp55t4ZGsaAzSwT8N3iUuthzOrGokFyOvHHHwoPanRwsFqJ3L
	3v2Tf12D8XdQq//ARpexroy8PAQc3DvIPAo1doOavE1SyJ7oHv4W9OV2603l0oco
	7zFScfLDbfWVFi/uA43qiK6iKKSKOEcdEHdyd7YLIsf2nNPig8QWNBxvW+wBDWpB
	pbjSBfk2Fl1FpSrXDsqy4y/4rKohiQq0aoPcAgDKotDRQNQ449I/UEpVFtqL/lsU
	q8KrTHUOkpAz2XpNOWt/hyTOKKxQkQz9q/Wy8v7/RNAGKQ==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id IazCX3NYb6ZA; Fri, 24 May 2024 13:52:54 +0000 (UTC)
Received: from [192.168.50.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4Vm61V3wB5zlgMVP;
	Fri, 24 May 2024 13:52:46 +0000 (UTC)
Message-ID: <144e9e03-d16d-4158-a9eb-177a53b67c6c@acm.org>
Date: Fri, 24 May 2024 06:52:44 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 02/12] Add infrastructure for copy offload in block
 and request layer.
To: Nitesh Shetty <nj.shetty@samsung.com>, Hannes Reinecke <hare@suse.de>
Cc: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>, martin.petersen@oracle.com, david@fromorbit.com,
 damien.lemoal@opensource.wdc.com, anuj20.g@samsung.com, joshi.k@samsung.com,
 nitheshshetty@gmail.com, gost.dev@samsung.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 dm-devel@lists.linux.dev, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org
References: <20240520102033.9361-1-nj.shetty@samsung.com>
 <CGME20240520102842epcas5p4949334c2587a15b8adab2c913daa622f@epcas5p4.samsung.com>
 <20240520102033.9361-3-nj.shetty@samsung.com>
 <f54c770c-9a14-44d3-9949-37c4a08777e7@suse.de>
 <66503bc7.630a0220.56c85.8b9dSMTPIN_ADDED_BROKEN@mx.google.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <66503bc7.630a0220.56c85.8b9dSMTPIN_ADDED_BROKEN@mx.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/23/24 23:54, Nitesh Shetty wrote:
> Regarding merge, does it looks any better, if we use single request
> operation such as REQ_OP_COPY and use op_flags(REQ_COPY_DST/REQ_COPY_SRC)
> to identify dst and src bios ?

I prefer to keep the current approach (REQ_COPY_DST/REQ_COPY_SRC) and to
use a more appropriate verb than "merge", e.g. "combine".

Thanks,

Bart.


