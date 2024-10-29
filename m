Return-Path: <linux-fsdevel+bounces-33115-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A47B69B4982
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Oct 2024 13:19:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C75A31C21DEA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Oct 2024 12:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB506205AC6;
	Tue, 29 Oct 2024 12:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YuyTlG44"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408E91DF960
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Oct 2024 12:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730204345; cv=none; b=MqhH0D59N31tKohM8oG29TjSthn8mFKVyfxgOTaPLEdtvpk+bFWnfP+p1ZTq+EmC53j4b32rq26L/tKTUauyLt5vilt7kW9LOIG6xvgV1cPc1VqsjPPvGb87AZZS3/6f1CAioyIzKFXw8PcTpfE7MTKbLdRhRGr72gD6CCo7Rns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730204345; c=relaxed/simple;
	bh=0I7kvJtFLDqQM0siDKT0j8ymg14gRFLwbFQ5gaEXjw8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=U/ZV1iMX/pdVx+m+LC7TDMKFMN2DtjVwgSRAtrqNp2T8l8D6rLnhnr0xnDL1kDX0mYVjPKCn22R58KeZ2yiVpvEN0AvLQeBvJa8orpP7n13/q/gPZUn2VRfl+T77CFZ23a4K6KW9a9hiQ5L2holjQns/d6eyJ4QCPxcAlNjQoO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YuyTlG44; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730204342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vfuf4xyKDvT9u1kPEhld7930e8myJyX3Zvs5SawIvSg=;
	b=YuyTlG44rGdGOTGNMYOmP7O4m4uLkLMn+8UHTndNLpN/lAHsUpJAMWwvuBJM5IsouhxHX/
	x0LwU71GKh9sUK63OKZbfVXUcQgqRMLlnSsLs9CLRyjzrJvPMoSoF2GBUgerm2BTaKLAjW
	+4J9jA1btXqasr+JoAiG+dLbbmcOEBw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-A7_V_7oaPye74WaGXPIRiQ-1; Tue, 29 Oct 2024 08:19:01 -0400
X-MC-Unique: A7_V_7oaPye74WaGXPIRiQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4315e8e9b1cso30784045e9.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Oct 2024 05:19:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730204340; x=1730809140;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vfuf4xyKDvT9u1kPEhld7930e8myJyX3Zvs5SawIvSg=;
        b=cFAucQZW9tvDVaZIuS3mvoMNJeObQtpHos09TBjSaBQVkXG3quID6nN+c+Q5VJElDQ
         MQ18IncOiDZFu/CcYuYknNj9CDUUhFTxKf1xPMfE8Gw8sBiEmIrs8rOoj7ko3a/Z7uHN
         ajiI2ljDkpI+9xMR5HqmShTyf3VCVWbRrb4aF8+5UgRYeVG57ns/ABA/BCms78td0Cwo
         inzYeJm0+mFllw6JtLLhyMQDBSRd7zm/gU15ozo2CB1UYYBvX27M7uzn5d7yIJ7+ohvT
         CfUTL2X+7xUIyeg76pia1ciJYDJ6Ejerrp+qg+1FpddwPkPso/NmaDu+BK6lChE0whZS
         Gnvg==
X-Forwarded-Encrypted: i=1; AJvYcCWO9wrcXcQyL5Nv/Nv/sXPQzgwyvHAMNDSilg6qdjo2m2qySxMrn4Alv0hG2vtm6a0r2BhHfWOkyE/4kj1R@vger.kernel.org
X-Gm-Message-State: AOJu0YywbwltZW4Pp1M0EJOVvf1JImDlsA9lpy6SZbrquaBxs9P70kAv
	cIFhDZg8JyAZSFuo4FstDpIGMLEBaNGi0TUyzMpWRWrLzr8oS9pM2bNgSQolq4gOwokD7+KT/mG
	47EyHImqgZNAivXkrbINThbQp01JU9T0jgKRrxaNZzCmoIZpoTHskn93UHk5gukc=
X-Received: by 2002:a05:600c:3555:b0:42c:b166:913 with SMTP id 5b1f17b1804b1-431b5727f7fmr14851895e9.11.1730204339711;
        Tue, 29 Oct 2024 05:18:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmrOsa0Gr67Yj5/cS+/SQl29FfUNpizydNLzGmFEG+bAVc4wyWPLsRt8+pgyP6z3kTKadvOg==
X-Received: by 2002:a05:600c:3555:b0:42c:b166:913 with SMTP id 5b1f17b1804b1-431b5727f7fmr14851665e9.11.1730204339372;
        Tue, 29 Oct 2024 05:18:59 -0700 (PDT)
Received: from [192.168.88.248] (146-241-44-112.dyn.eolo.it. [146.241.44.112])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4318b5430edsm173654585e9.2.2024.10.29.05.18.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Oct 2024 05:18:59 -0700 (PDT)
Message-ID: <c0a4d1ad-cb3a-4d61-93b5-471c1033d67d@redhat.com>
Date: Tue, 29 Oct 2024 13:18:56 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 net-next 11/14] tcp: allow ECN bits in TOS/traffic
 class
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
 <20241021215910.59767-12-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241021215910.59767-12-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/21/24 23:59, chia-yu.chang@nokia-bell-labs.com wrote:
> @@ -2178,6 +2185,7 @@ static void tcp_v4_fill_cb(struct sk_buff *skb, const struct iphdr *iph,
>  int tcp_v4_rcv(struct sk_buff *skb)
>  {
>  	struct net *net = dev_net(skb->dev);
> +	enum tcp_tw_status tw_status;
>  	enum skb_drop_reason drop_reason;
>  	int sdif = inet_sdif(skb);
>  	int dif = inet_iif(skb);

Minor nit: please respect the reverse x-mas tree order.

More instances below.

Cheers,

Paolo


