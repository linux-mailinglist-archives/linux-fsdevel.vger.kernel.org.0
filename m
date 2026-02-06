Return-Path: <linux-fsdevel+bounces-76623-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WAcUGaMshmnkKAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76623-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 19:02:11 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C76A1101935
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 19:02:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 16EE8302FA82
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Feb 2026 18:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3982817993;
	Fri,  6 Feb 2026 18:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nXH925yQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9DC35F8D9
	for <linux-fsdevel@vger.kernel.org>; Fri,  6 Feb 2026 18:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770400891; cv=none; b=aCzr+UxEZ/je/USMd+l0R9DojLCRk1ZGTsVM2m5883pLrUHbD7ebJT8jdkt9OFEqpTnsJi9k1rO7fX7OTXMR/+WIWWsnTQ2CGvjdhLkbJ8JgYuKn6sK8cRtFZSkWa96bEy01/xfMRLOzJ2FKIj6Ve/FesYiNsFn8goKfbmDuaAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770400891; c=relaxed/simple;
	bh=lSzknfIv//vW3XrZo3ZB5GwoTGxjRj4lI8kJmwNoH0g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VvLU6CKedZkC47JHDEI3sAAF8You2fTfIxjMtebdS81huBGCbyagV6JAJt7d/5EqI4hHLlmsCcXBhBbL1Y3JyFxamAfp4qlBvNLDdsGAYAkYqvpDSss7+g5EuNny/e4elE61kVkJwgO4mUzdzrSTwZ9kHsUAeBQrUfAOIHMRRpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nXH925yQ; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48069a48629so22018225e9.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Feb 2026 10:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770400890; x=1771005690; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=chld7W3Rbl2PUp6cBiIbC1iT7uESUsO9DngY57S8hBw=;
        b=nXH925yQME2C/lv7xU3N2pyQIphEEpo2HaEr2mjExOB/V12/17synnPdfVx259zHFa
         s/OseDtCvCMxhdFsZLcZGyLFKeicyTGl9TNKK2V162hPxUPSZHxJvxdUWBxeC/uRPbZV
         ba34+SNbt/Tyv8GVhI7vlL39IXY+/iV9t0h1tjdxAzd5rIXvEQYsjGIB/YCOysu+iWg7
         Iu/7ambw7HtnGIKk40JQ/GMgK1cQalk+dr13K8cVTiJXvWpMR0GV5NdL01XtEFRO/VwC
         HQnhdy7a0ZGyIpNM5WWwzlA4q4iNp6c8P5xGdITM5xHOLCZj2YzbHJzegInrFimdGerZ
         mTLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770400890; x=1771005690;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=chld7W3Rbl2PUp6cBiIbC1iT7uESUsO9DngY57S8hBw=;
        b=gPncVV79aZyfd+v3aI1JLWjrcMYcdIn8y+IVrztvBSYKpW5gikE70DqjzDJLbcdzlK
         y5tNYIXpG6xN5rrGB89sqgt3LP3SvG0J8gJS+mreDRtPi2m+BO5FaTDzNcfrKkFn97iB
         6rg306tvGAyZEoALyldAbjfAgfnMsJaKuVPvsABEaUC678OyJDM/6WxjDAWCsbBJ+7D6
         RIonI9aLOFqIH9nERNKVV96zMcnJKQBdi13stTO0NjjEfLo+gbnO1uQqZEWpJOLcBbp+
         3LJgRH+srmMe6o24A2yZWWU++ccmwnqYUI7+Xsttc07piqtBj2OVkL5rFHSyG+xgO8xg
         u67A==
X-Forwarded-Encrypted: i=1; AJvYcCUFCbWYZebu8RcqW9/9K8xETLgvx2cY7DpOSImFihIS0kmN5FhQOhlMKf31FKYZH/oYbxwIK4rYSMqmK1UU@vger.kernel.org
X-Gm-Message-State: AOJu0YwoMnrVCwkHLbjWE5X5bbSJy80T7cb0XgXqyS6LaCfFjBr0pbZM
	AacqOK2q1DOg/4ZrTZQRP3KPMD/8JXK7iTJlTP7fomm0O8KeoJcEQ7ZN
X-Gm-Gg: AZuq6aLLwIyHhD5MaU3m7GwliKesbVzk3DXAoF0ccZWICJOBOO6PCSbEe5qiSBKP4Vv
	H/k66mdkuCTu1yU65YcG+V1omqUwCNeui/6Y4X6T9XJAgpPirKs9LQQQ+uJsjP8+bf3zGjnwLgd
	qT35lvCyMKO68LxzZQXV1govoRDAcbbLJGLcmu609R+tvoyn6fKCDIjYdO1ZXHvPUc/urGH61Tb
	03tJJFSk6iLosf+nmAhjMphrRrnynXxcHlOn92TFIRfHyulVcZXxYCnoNA6TZ8ij8c5WlA+GpDq
	siGZSeu1S8e1OEyTgCH8sfYw/cfv/LvxRN5qaeeQBCJxtU//NXoTi5CPpZCWH2LQz/IPNMs0MdN
	ZYiSz2Mp1wfM5VE7uV1Vwwcly2Tsp62iAXtOAk4Uz+eFewNMcSUEz3HqDn/oxxrFsqs1QRvK6Cb
	LdHjxwRubTwXwFvP7TTh62uTAoPpH28uWG19Yvl2Kix5jbOJuCzzlaIISUrkinvcfgwqKc0BsGS
	obIpHh83g4Ge+JhdIlND9ZYCXXSO3aBbEN2LFti2CbNsL97xK+vCmLkDJjhQrcLPQ==
X-Received: by 2002:a05:600c:628d:b0:47d:6856:9bd9 with SMTP id 5b1f17b1804b1-48320216d31mr49104765e9.23.1770400889507;
        Fri, 06 Feb 2026 10:01:29 -0800 (PST)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483203e126dsm51230805e9.2.2026.02.06.10.01.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Feb 2026 10:01:29 -0800 (PST)
Message-ID: <b0ec01bc-4cbd-431b-bcdd-084cc14553be@gmail.com>
Date: Fri, 6 Feb 2026 18:01:31 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 05/11] block: add infra to handle dmabuf tokens
To: Anuj gupta <anuj1072538@gmail.com>
Cc: linux-block@vger.kernel.org, io-uring@vger.kernel.org,
 Vishal Verma <vishal1.verma@intel.com>, tushar.gohad@intel.com,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
References: <cover.1763725387.git.asml.silence@gmail.com>
 <51cddd97b31d80ec8842a88b9f3c9881419e8a7b.1763725387.git.asml.silence@gmail.com>
 <CACzX3AupFeAy0-pPsZ51ixd7qW++LYYjiKBZ3aK5Y2JDrB_JWw@mail.gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <CACzX3AupFeAy0-pPsZ51ixd7qW++LYYjiKBZ3aK5Y2JDrB_JWw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76623-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[asmlsilence@gmail.com,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: C76A1101935
X-Rspamd-Action: no action

On 2/6/26 15:08, Anuj gupta wrote:
>> +
>> +       dma_fence_init(&fence->base, &blk_mq_dma_fence_ops, &fence->lock,
>> +                       token->fence_ctx, atomic_inc_return(&token->fence_seq));
>> +       spin_lock_init(&fence->lock);
> 
> nit lock should be initialized before handing its address to
> dma_fence_init()

Good catch, thanks, I'll apply that and other suggestions. And I still
need to address bits Christoph pointed out during review.

-- 
Pavel Begunkov


