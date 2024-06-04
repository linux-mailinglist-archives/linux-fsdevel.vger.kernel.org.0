Return-Path: <linux-fsdevel+bounces-20969-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9AD8FB835
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 17:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FE1C1C24EC0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 15:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FBCE146D7D;
	Tue,  4 Jun 2024 15:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hRi4Sl74"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F091311A1
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Jun 2024 15:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717516675; cv=none; b=rvY6KIPs5QQNbEBiY4Rw1Hsccct8zteJGjcCqs9EI3Z9bg3n+VeeAXyhwFEn3Maswu33jjgkgmGTijL6mEEPGogFWEdf+yAXsKRj0+GKqQ0h9aaG7QgFLeRE2AUE7SoawgxMVbgVGXvTXs30V49hQ2pqLRsI1eo8KHPCgUUcrsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717516675; c=relaxed/simple;
	bh=vhZYleApZN8kWLF7LONqg/TsuUedJgn2Sb+eQ5I6y7Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=amVMcbl1B5PvKSbtvmMQGpgi+3hzIHF5SjNCqHTM649WNzOqqdl9IqrKSxmxIYqqCAuhoRM1E5QV3wDD50FZSMPrGKjPn1mDEkIl98ctf33/5RzRmhZjjoCnF5gTw2g9ukdxIr/nAKsmuVP7rPmQhudubYPogaaql7l5bUIYbTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hRi4Sl74; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717516672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iY8Smgr4TinEDzI3seLjT/wKu7RCmTGwq48l1prhDuY=;
	b=hRi4Sl747QM4XXrk0fhl1Mhj7A/yOcqzJR+zrLPiUbiNhOvrhWNuuSZa7OFC1MpQ85K5E6
	y3jxC7b/C/ZCvifOK1lLl/cMhTVMPUvz91HasCX4fkx98ghqd5repN/vTBEG5/K1dUjWlV
	BoTqFX5oAzWvZCC9uBr4RvLFbBXmlvA=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-372-1RhPyV4ANTmFBpXrDCYYEg-1; Tue, 04 Jun 2024 11:57:50 -0400
X-MC-Unique: 1RhPyV4ANTmFBpXrDCYYEg-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-57a61b52181so971777a12.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 04 Jun 2024 08:57:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717516668; x=1718121468;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iY8Smgr4TinEDzI3seLjT/wKu7RCmTGwq48l1prhDuY=;
        b=bWYBFdWChrF8NwbYL0BNqzaUCLS159xdCrrnAIeRLBOkJDnD3nWS+XTD6R65ihOrYf
         4IAFVWdjip5UOGYUfaFekGzKHSbQ3Pen516u3GuCPVZD1jtXmTeOOjLIxKDuwbXybBB0
         sHlZ1QlhKJTAtGkAwG4CBAXlghatpQ73gh9CVyaaYYNcsrIMdj8T9Wm7ythq8HU0kpkt
         1fBR1/ODR2Bb1kAAO1X7M2VSKqYRHhM4XtJt63f6YKTjkKweRViS7qwAUBzd9yYMuee6
         Qx9F7v1e5Nq0mbrUpADyFm83+QqUm5Z2UFNT0EtnfEnyO5V2Z03dEXU221H87vphU/Mi
         bdJA==
X-Forwarded-Encrypted: i=1; AJvYcCUpntVu6ynRVYXu+P683qzXyIwMORbDImMus8yJiwDBX/TjJCDR1J89I0JSkH6684Q3AG6ALEgJNzw6tQVZwEro/ePSrqQr0eRu5Vr/6g==
X-Gm-Message-State: AOJu0Yzfj3GFzgg5IjFKPPpIBsx8eTF//WDP6M5Tpk+zEInxNRoiWMqM
	iVP+hBtjuS3MoZg8N9hgU/AuZVaO6Ri/OuvN7ZeO9gcJJ5dBwcFEBrrFTu23Ai4n3CVw1N+Otte
	vYMMmtHszpazl+BCh3c80Rdtg/6DUJQTqGR/NLio/7z+n45/fPzzr6Tk8SH+ESsE=
X-Received: by 2002:a50:d65d:0:b0:578:64b9:d02e with SMTP id 4fb4d7f45d1cf-57a8bcd7c9emr10594a12.40.1717516668754;
        Tue, 04 Jun 2024 08:57:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZ80kTYg345fHCJuh2+pANonRw+zjSWqYbitUEjpOBdxl6OvwCwCuHkL4bn4QKZ8cVZwCvRA==
X-Received: by 2002:a50:d65d:0:b0:578:64b9:d02e with SMTP id 4fb4d7f45d1cf-57a8bcd7c9emr10582a12.40.1717516668361;
        Tue, 04 Jun 2024 08:57:48 -0700 (PDT)
Received: from [192.168.0.161] (host-87-11-37-195.retail.telecomitalia.it. [87.11.37.195])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a86a6a5d3sm898050a12.65.2024.06.04.08.57.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jun 2024 08:57:47 -0700 (PDT)
Message-ID: <b298bca1-190f-48a2-8d2c-58d54b879c72@redhat.com>
Date: Tue, 4 Jun 2024 17:57:46 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] sched/rt: Clean up usage of rt_task()
To: Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Steven Rostedt <rostedt@goodmis.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>,
 Metin Kaya <metin.kaya@arm.com>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-mm@kvack.org, Phil Auld <pauld@redhat.com>
References: <20240604144228.1356121-1-qyousef@layalina.io>
 <20240604144228.1356121-2-qyousef@layalina.io>
Content-Language: en-US, pt-BR, it-IT
From: Daniel Bristot de Oliveira <bristot@redhat.com>
In-Reply-To: <20240604144228.1356121-2-qyousef@layalina.io>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/4/24 16:42, Qais Yousef wrote:
> -	    (wakeup_rt && !dl_task(p) && !rt_task(p)) ||
> +	    (wakeup_rt && !realtime_task(p)) ||

I do not like bikeshedding, and no hard feelings...

But rt is a shortened version of realtime, and so it is making *it less*
clear that we also have DL here.

I know we can always read the comments, but we can do without changes
as well...

I would suggest finding the plural version for realtime_task()... so
we know it is not about the "rt" scheduler, but rt and dl schedulers.

-- Daniel


