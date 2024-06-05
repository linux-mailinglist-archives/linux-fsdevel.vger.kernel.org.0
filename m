Return-Path: <linux-fsdevel+bounces-21039-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A448FD0C0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 16:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 858D5B35560
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 14:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C059B1A291;
	Wed,  5 Jun 2024 14:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="atKZRxah"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D063F14A90
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Jun 2024 14:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717596333; cv=none; b=ZYFuHPzhfye/uJzVp8R2lqxu1UrlnZ3Zjty67q5/DIlbpSorfQhdJhkWwSsDG3/btNzXEOGmkbOyfg17T2+oc2BIImPiZBYrZLTriklbi5ShtBtM3WV8xF9vlWbV5z3h3tyzKjqixxPdosGjkMUV3bhUIKcRo5NmsaHu9C3WW6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717596333; c=relaxed/simple;
	bh=J2kQ4wQoNvDj4NE3mHtx5/BMuZd20qs1tyhxegM305Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OXBtkHpY23IjyAF6dvzpOkkpZeDPqWvtjPQ5McCwTlO6C22r3gsWhR+K0SwoDbzI6pSHSreRR+aYna+4h99pG+qvY5LkF7rLjDh0Qqg3QSnzTGKnJvtAqM9ekIoi7dXKBQqe2puPLqnzZNuwaZqJZNwwurKfNq3bAWZ+CRqXwvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=atKZRxah; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717596330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SnAjRPdPslLKR6RQzu2pBmXnTD4p4gc93G0q5GXgtK8=;
	b=atKZRxahyKqBWMITw3//jXZ/qgaYnbk6sy/7/be1CTdWLyksHTj46AfJvr25Qjif2DSUmS
	YBlr2Tl+tFnlXaIJA40Pg18W2wWS5V7g1xBe1PJEgf8W8ub97eL9TnyZdnjSqEir+XnRF0
	e4VBwH1mcGXnrpUTXDpw39oxAGn8k9c=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-481-3pbxlI2BN-SezNj2B1YJ9g-1; Wed, 05 Jun 2024 10:05:29 -0400
X-MC-Unique: 3pbxlI2BN-SezNj2B1YJ9g-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-52baa2e4ab1so1376963e87.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Jun 2024 07:05:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717596325; x=1718201125;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SnAjRPdPslLKR6RQzu2pBmXnTD4p4gc93G0q5GXgtK8=;
        b=Wt1Ndjyg50GfhWZG5KyEXt2a/bC+BqPvempMX7E2lRkWPqjxSZ/hbnNxUfN7T4oqkT
         cfRDskNOA1sNyjJ/9Ii+Oj1iarH3XaCslWtWeLDqLjskj3yJf3kyF5ZCK+pjc7TWvt/A
         TGkyHvWPjFzd07AQEzi3iLPhkfQOMTj55OX926f/0DvKPTFZ9Aml9SPRPBrNkEB9HPZk
         SKIApNcWSGW5CFgP6YEIGlMW/SnSG364/+sPIB7P4Y0WpKLWHTWM82D1lcB+aDKDnV32
         se6l+8oavI2Y7AlHiQxi5TV/2iBEV2LxcA85AXP4hzms5St6Xs4ApOVK47IZOJxkpxlH
         e+qw==
X-Forwarded-Encrypted: i=1; AJvYcCWBmy2kRq09NouIjiaW2KzDiY535tlvTgohx3wjLwMjgTHzYtaUaHkEVlU+oDwtXSyMIy9/feiYN7qXo3nDWZNTwBhFULFqb7Ke7u71ww==
X-Gm-Message-State: AOJu0Yxhia14k2Us06YvhT6b0ZKS908sFN5laq0U1FSlrGtmeCVNqr7f
	z1xpqr3cgQWytH1ydWL2gtESMe12RWhwYAGUptBSIiHk4GkU2TlpK4glQyOWTMOXF/KCMIuiCMC
	rL59tl3M9ZI4Yo9sGC9NAefu9FiPxQfXgDSKyYN4Z8sHVQuqG3tTIcfMuAiifPQM=
X-Received: by 2002:a05:6512:3e5:b0:52b:4ae8:46d9 with SMTP id 2adb3069b0e04-52bab4ca6d4mr1891847e87.5.1717596325735;
        Wed, 05 Jun 2024 07:05:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGC7EdqZjYrmyMx/USwVrnIBDKTdRMVW5oYpkXPFLx7eROHA0u1LtZeLxEwCYBnW4Z+lNhiRA==
X-Received: by 2002:a05:6512:3e5:b0:52b:4ae8:46d9 with SMTP id 2adb3069b0e04-52bab4ca6d4mr1891750e87.5.1717596321944;
        Wed, 05 Jun 2024 07:05:21 -0700 (PDT)
Received: from [192.168.0.161] (host-79-23-6-148.retail.telecomitalia.it. [79.23.6.148])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a681c4f2b6fsm777163266b.144.2024.06.05.07.05.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jun 2024 07:05:21 -0700 (PDT)
Message-ID: <9f21c8e5-1103-44fa-82bd-cf608f8a96f6@redhat.com>
Date: Wed, 5 Jun 2024 16:05:19 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] sched/rt: Clean up usage of rt_task()
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>,
 Metin Kaya <metin.kaya@arm.com>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-mm@kvack.org, Phil Auld <pauld@redhat.com>
References: <20240604144228.1356121-1-qyousef@layalina.io>
 <20240604144228.1356121-2-qyousef@layalina.io>
 <b298bca1-190f-48a2-8d2c-58d54b879c72@redhat.com>
 <20240605093246.4h0kCR67@linutronix.de>
Content-Language: en-US, pt-BR, it-IT
From: Daniel Bristot de Oliveira <bristot@redhat.com>
In-Reply-To: <20240605093246.4h0kCR67@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/5/24 11:32, Sebastian Andrzej Siewior wrote:
> On 2024-06-04 17:57:46 [+0200], Daniel Bristot de Oliveira wrote:
>> On 6/4/24 16:42, Qais Yousef wrote:
>>> -	    (wakeup_rt && !dl_task(p) && !rt_task(p)) ||
>>> +	    (wakeup_rt && !realtime_task(p)) ||
>>
>> I do not like bikeshedding, and no hard feelings...
>>
>> But rt is a shortened version of realtime, and so it is making *it less*
>> clear that we also have DL here.
> 
> Can SCHED_DL be considered a real-time scheduling class as in opposite
> to SCHED_BATCH for instance? Due to its requirements it fits for a real
> time scheduling class, right?
> And RT (as in real time) already includes SCHED_RR and SCHED_FIFO.

It is a real-time scheduler, but the problem is that FIFO and RR are in rt.c and
they are called the "realtime" ones, so they are the first to come in mind.

-- Daniel

>> -- Daniel
> 
> Sebastian
> 


