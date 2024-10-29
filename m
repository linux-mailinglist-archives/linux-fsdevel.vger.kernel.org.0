Return-Path: <linux-fsdevel+bounces-33116-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C40039B499A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Oct 2024 13:27:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B4001F2377B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Oct 2024 12:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D99E206051;
	Tue, 29 Oct 2024 12:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vt7t35wH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0864220515A
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Oct 2024 12:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730204812; cv=none; b=njzuk4t4EknNL6f9H2m/F9qPqYm0fEEMFMftMUMW29UqRLWuc735dTSWD8CwwGYyljGNiqn8V6n+kqNn4IR84kn9VkrGpmX4RLCwJmdr8daROmLoDWpQ5BQAgLyWUXppuHel8Qcc6A/gnkwNPxgdu4K+hm81rmrqVIUVcuCIpTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730204812; c=relaxed/simple;
	bh=OIiNsApqwgm71NjUFM1ADgAthsV5yL2jS8pl3Uc8ZmQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=uuPq6+HdwTbKvnEYL+jP/VyRrCvGR24XEIX8EizuP04xi+YNs+BihFfE9hmo0xmniRtF5yn7yrOUJqn+OHz6Up8Tk/w2f096FHaCPb2zLM2CSAseKKG5M9rOXX0m78XaA7MjObh6Ei1wO3jklx6CKtcE9amC+OYAajRAbZ+i7v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vt7t35wH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730204810;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GOZTaD4SZpZxUnHx9eqNQXCMnDT5MQfWDHUrJEYUGAI=;
	b=Vt7t35wHnLgvy7vBnA8aqxcVgERbWrFMxWnwQgrGj4imxl/s9ozfpv9tsw9y0+NxYUx7Lq
	fIJtCFZK7jZeclL4HvRjU2aS02r+f4PCTY82b7zuaK3aI51tt0kZYy/QDpZBcbXA4dy8M+
	KDwyM7GSgcpB7a+g6Z6wKekYfBbDTMo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-o6tlHVXjOX-Yv6vbCLWXLA-1; Tue, 29 Oct 2024 08:26:48 -0400
X-MC-Unique: o6tlHVXjOX-Yv6vbCLWXLA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-37d67fe93c6so2773135f8f.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Oct 2024 05:26:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730204807; x=1730809607;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GOZTaD4SZpZxUnHx9eqNQXCMnDT5MQfWDHUrJEYUGAI=;
        b=A7uJ4HrhyutTbdqnPZj0Lco99mSe0SjQN9izGHxikDNEduLurtuZ+LlmNXwGNdQci0
         ldHXwkwy1500oUtwYaFwpSyeDKeV62CLd0dcw2YSO4BldMEh4IP8fbxwD2dwIK3Ykf4d
         nn11PJmMBCWfdcujH6O0cvtg9nxyKWfth+RGLEtpVTC9jh2OzjmbuEulpXeyg0oMsW/h
         e3DGZ8alvLeoIbiKDDBsjdHVJ5YV+Y5JOQKYuYGRhJFMV9IcyrIYemkCboWOCgmAIaEL
         tZSgQJoScG/Ct0Sau3+gM4NHxRD+63/g+S902B+DKih0uxk7cr5fJGlrFrUIS3aWlrGZ
         Zdkg==
X-Forwarded-Encrypted: i=1; AJvYcCXj1+1zQUxNFYybnnl2ZOsALV8kwUwMArxJMR5YIKHaVBd5F1bm6iwBQjeWZEs5eGWPZPRm7fycQ1GkLJil@vger.kernel.org
X-Gm-Message-State: AOJu0YxBbE5VbM7vri5PZtGkTyjaceW98PyGbpttD2jhH9ixcSqx4VF9
	7V9C7yY9AdyTAGTTnfDJY49xMImAgkD8OIgnoSEoEIoPZIR/g64XPL7PPsa06Aa53NXVJcChmnK
	SijDKgsuMz4/iZ2yjs7onRUPz7ukXrZH0W4WAVtqbkR2MJ3WZZiyqUomg1CblgL4=
X-Received: by 2002:a5d:4849:0:b0:37d:4e03:635c with SMTP id ffacd0b85a97d-380611441bbmr8953987f8f.21.1730204807538;
        Tue, 29 Oct 2024 05:26:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7KLM8OM21izjqXfNP/B0QCUjjPNIlLTzWnqUD6a68rC1KUBMbMRh54JsB8kR9ClHY4mPX5A==
X-Received: by 2002:a5d:4849:0:b0:37d:4e03:635c with SMTP id ffacd0b85a97d-380611441bbmr8953961f8f.21.1730204807135;
        Tue, 29 Oct 2024 05:26:47 -0700 (PDT)
Received: from [192.168.88.248] (146-241-44-112.dyn.eolo.it. [146.241.44.112])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b46bffsm12311553f8f.46.2024.10.29.05.26.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Oct 2024 05:26:46 -0700 (PDT)
Message-ID: <dee9769f-d86b-471f-bbe2-f0165489618c@redhat.com>
Date: Tue, 29 Oct 2024 13:26:44 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 net-next 14/14] net: sysctl: introduce sysctl
 SYSCTL_FIVE
To: chia-yu.chang@nokia-bell-labs.com, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 dsahern@kernel.org, netfilter-devel@vger.kernel.org, kadlec@netfilter.org,
 coreteam@netfilter.org, pablo@netfilter.org, bpf@vger.kernel.org,
 joel.granados@kernel.org, linux-fsdevel@vger.kernel.org, kees@kernel.org,
 mcgrof@kernel.org, ij@kernel.org, ncardwell@google.com,
 koen.de_schepper@nokia-bell-labs.com, g.white@CableLabs.com,
 ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com,
 cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com,
 vidhi_goel@apple.com
References: <20241021215910.59767-1-chia-yu.chang@nokia-bell-labs.com>
 <20241021215910.59767-15-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241021215910.59767-15-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/21/24 23:59, chia-yu.chang@nokia-bell-labs.com wrote:
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> 
> Add SYSCTL_FIVE for new AccECN feedback modes of net.ipv4.tcp_ecn.

How many sysctl entries will use such value? If just one you are better
off not introducing the new sysctl value and instead using a static
constant in the tcp code.

Also this patch makes the commit message in the previous one incorrect.
Please adjust that.

Side note: on new version, you should include the changelog in the
affected patches, after a '---' separator, to help the reviewers.

Thanks,

Paolo


