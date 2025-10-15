Return-Path: <linux-fsdevel+bounces-64248-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D4066BDF7B6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 17:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A5000506439
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Oct 2025 15:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D8132F771;
	Wed, 15 Oct 2025 15:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="wBUNX/cc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5053431D72A;
	Wed, 15 Oct 2025 15:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760543399; cv=none; b=akGVY+vdW6iaDwnB2Q+U2a9lbfW48pwNQwGK3gVVZJOwHB8PMqyHvvJyVN0k2FlmVGvAk6fvnie97m/JGykLLTbYZJ3R/xDi/Kr1rTodoaBmH7askT8PdtG1Ug69RQfakmMC61iD8jxiPCvOlSVoONlXj6ztURVmQW8qQ0Jtr/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760543399; c=relaxed/simple;
	bh=mvZdPVPVaO5k6gu0wAaHcaTfkKnllSH9+CHkNU0Axqw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HEMKbezOX08Pgj6eQZB7OPzopIbAdVMIDVecUfSWeF1PaTYBKxm4yuIactmVTcFz4SVvu6HvA2eWbhQIyawOSFWRqzYOaOU4xHRarFGHkRTzxLu5IGGfYWj0MYE1pdEezakvT6fpIreYG/tBb33J1NoJGqlv8WAtu8+X5JLikOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=wBUNX/cc; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4cmwWn19M0zm0ytb;
	Wed, 15 Oct 2025 15:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1760543395; x=1763135396; bh=P6CsY+QgG2g19qmpsp0XX8U5
	06R5dVKM9Tj2/hdg+VY=; b=wBUNX/cc/mad7vi37m5N7JVQQhRJmg0qDVKQw6Ac
	Bt0c1gUcnS+pf5B4LF93npAduO79UQ/237s+hOLfmKgAmDphbaRSP9Y/w68+1SPz
	sdNqnpAgA2sntOKfLapl/ba6RXQLYrEedW0BnBC3Hb5XD7O+P8wdmxYtTItBzj5v
	nB13L48pOS9oRUSGVgWhoohHFm5tREHRo2EKnOKhgaFxVqsHI36hUAV0wnpHBbIp
	myXx143qYLOFoz4u2ovP1km/YG89V8zCyPhYg9iBss5f2y/MKN2B6zzgrBYBSsHS
	Lsv7pk/nv5BbS4QmYZAtA8rbvm/LRJ3+L54P5/mQPYS45Q==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id ER9U6AwfhCvl; Wed, 15 Oct 2025 15:49:55 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4cmwWc4fxlzm16kk;
	Wed, 15 Oct 2025 15:49:46 +0000 (UTC)
Message-ID: <5692dd74-ab1c-4451-9d28-b436ee658f6e@acm.org>
Date: Wed, 15 Oct 2025 08:49:45 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5 1/6] loop: add helper lo_cmd_nr_bvec()
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org
Cc: Mikulas Patocka <mpatocka@redhat.com>,
 Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
 Dave Chinner <dchinner@redhat.com>, linux-fsdevel@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>
References: <20251015110735.1361261-1-ming.lei@redhat.com>
 <20251015110735.1361261-2-ming.lei@redhat.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20251015110735.1361261-2-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/15/25 4:07 AM, Ming Lei wrote:
> +static inline unsigned lo_cmd_nr_bvec(struct loop_cmd *cmd)
> +{
> +	struct request *rq = blk_mq_rq_from_pdu(cmd);
> +	struct req_iterator rq_iter;
> +	struct bio_vec tmp;
> +	int nr_bvec = 0;
> +
> +	rq_for_each_bvec(tmp, rq, rq_iter)
> +		nr_bvec++;
> +
> +	return nr_bvec;
> +}

'cmd' is not used in this function other than in the conversion to a
struct request. Has it been considered to change the argument type of
this function from 'struct loop_cmd *' into 'struct request *'? That
will allow to leave out the blk_mq_rq_from_pdu() from this function.
Otherwise this patch looks good to me.

Thanks,

Bart.

