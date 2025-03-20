Return-Path: <linux-fsdevel+bounces-44607-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 578EAA6AA0F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 16:39:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED933189787B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 15:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 014C41E7C3B;
	Thu, 20 Mar 2025 15:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="Qv4MB0lJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA61A1DDC0F;
	Thu, 20 Mar 2025 15:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742485047; cv=none; b=k6MTFhsESs+Oms/Ikpka+hnhyqWhXjFYFXbnEK/pAyRaq43qLOiOwtIPO8NiCrY7T6WQ++TRP3QNyYDHumAVYg4DQ4q7huHi0GIki1D4x5A2rnLZHOJib6Iwj5dWzlVCfKNAhhgsD+If3LCSO4gXg847bPQnNBPZFU2vQLOiOkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742485047; c=relaxed/simple;
	bh=J+e8IhyIIBJvv0xjeU0BQK7lYADTbr9FmLCze4AWg3Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tZRr8k7VVCBYc5IMjKpPAk6swNLxJGZ3ho97un7CCQ8gD8AFMHW3Sagz3MpGDbiXxp782wedflkCJtMqM4eMyJQIhbKVGKwSDXa8Kl8qJbcWGP3PZgDYBPQqp4n/LBqY0ebgubkx2Naw7Q4eb4NAkR3UAPcNIBTmRoaPD1+41Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=Qv4MB0lJ; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4ZJV7m2n5qzmWRtG;
	Thu, 20 Mar 2025 15:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1742485041; x=1745077042; bh=3XYe1tuQS507NL5nm9rpDihD
	H8Gzkr7TFGJUWeSwmG8=; b=Qv4MB0lJ9xWZJ9jMy8RMFI9qzNsHX2Zk8MxpcKaH
	c4HSTrBC9zuL8atxolDY9431JpPYULMP/TAF/Cej53mMuAM6OsnjQKiXq1oeqDqA
	RHIXi5Hkh0JYIMEzcSYQfnVgJZf6RnJvxjisw5Rw6a6tLIBwMkLuKIhpaw0Cp1XK
	hksP4adk00A0QIY4Ebo0BKimLRW9zAhR1wfY/50RhrUD8n3QHGIxkNWMg6klQrAn
	rhKkLib7pV1kZjzwbd0F2YzxQ/208axbE0tYcls+8KzTkXm/YLimi96KDaHUfvNm
	lsRhKyOHR/3nAlBty+Jzd81HQ7SyD++zqsEXhc9t0hgiCg==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id GJk4IoTrJnfO; Thu, 20 Mar 2025 15:37:21 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4ZJV7R4kR0zmWSKQ;
	Thu, 20 Mar 2025 15:37:06 +0000 (UTC)
Message-ID: <a40a704f-22c8-4ae9-9800-301c9865cee4@acm.org>
Date: Thu, 20 Mar 2025 08:37:05 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] breaking the 512 KiB IO boundary on x86_64
To: Christoph Hellwig <hch@lst.de>, Luis Chamberlain <mcgrof@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-block@vger.kernel.org, lsf-pc@lists.linux-foundation.org,
 david@fromorbit.com, leon@kernel.org, kbusch@kernel.org, sagi@grimberg.me,
 axboe@kernel.dk, joro@8bytes.org, brauner@kernel.org, hare@suse.de,
 willy@infradead.org, djwong@kernel.org, john.g.garry@oracle.com,
 ritesh.list@gmail.com, p.raghav@samsung.com, gost.dev@samsung.com,
 da.gomez@samsung.com
References: <Z9v-1xjl7dD7Tr-H@bombadil.infradead.org>
 <20250320141846.GA11512@lst.de>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20250320141846.GA11512@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/20/25 7:18 AM, Christoph Hellwig wrote:
> On Thu, Mar 20, 2025 at 04:41:11AM -0700, Luis Chamberlain wrote:
>> We've been constrained to a max single 512 KiB IO for a while now on x86_64.
> 
> No, we absolutely haven't.  I'm regularly seeing multi-MB I/O on both
> SCSI and NVMe setup.

Is NVME_MAX_KB_SZ the current maximum I/O size for PCIe NVMe
controllers? From drivers/nvme/host/pci.c:

/*
  * These can be higher, but we need to ensure that any command doesn't
  * require an sg allocation that needs more than a page of data.
  */
#define NVME_MAX_KB_SZ	8192
#define NVME_MAX_SEGS	128
#define NVME_MAX_META_SEGS 15
#define NVME_MAX_NR_ALLOCATIONS	5

>> This is due to the number of DMA segments and the segment size.
> 
> In nvme the max_segment_size is UINT_MAX, and for most SCSI HBAs it is
> fairly large as well.

I have a question for NVMe device manufacturers. It is known since a
long time that submitting large I/Os with the NVMe SGL format requires
less CPU time compared to the NVMe PRP format. Is this sufficient to
motivate NVMe device manufacturers to implement the SGL format? All SCSI
controllers I know of, including UFS controllers, support something that
is much closer to the NVMe SGL format rather than the NVMe PRP format.

Thanks,

Bart.



