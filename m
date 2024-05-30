Return-Path: <linux-fsdevel+bounces-20515-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D9C18D4A14
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 13:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F5B81C21E63
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 11:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFCDF16F282;
	Thu, 30 May 2024 11:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="KA06aF0U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0517C16F0DE
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 May 2024 11:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717067450; cv=none; b=GT26Ko+/pnap2L/7NwhrDVe26uALNpqJoJfL4U/DAOcI45/hr0PTAs+nimvyuPLU8DRogZNTH5+uWKLpFqalI0nXud+gDkuuelDg+zXP9RQsucZAQFQ8IqLovKFNCF376EVXgEGqeLtg6h/yFDEX0FA7bOjgl0gxugCzudFxNVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717067450; c=relaxed/simple;
	bh=6cQQT1iNHkPNVZ1fV3a9CoRBkW4GBeWmVMJ7xh+x3P4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bE0rrb7CiksKcomVdV28DFSgGKNNKQCv0vPos28/3vFQ9VgxgZwmnIJi+HYyQ28KiwC/wE6sOxMOqTuUmHM+zwbx21vwGKh6QnVc0mWN98gY1e//nmlWLjZO38EcRu9e8DL5GNWQUXXMoFH96LM9uh+PLg8xOmchWcg4RsAwDwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=KA06aF0U; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-35507a3a038so518965f8f.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 May 2024 04:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1717067446; x=1717672246; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Kiy02xbpkVoe0jsA57DQLD//qIOyPVkR19TcyOZjzlw=;
        b=KA06aF0UxXX6gvPHAi5VEaG8RTIwT1rANECvghtsv0echx0y6+rrUGuuOE+WV4IRS2
         1wn+zXckFKQi5kSxJgsjaBlu8L6HkwNaNyM1CCKQkKPjo/HD2odYWYsf2jq4v4pUn+Ao
         0VOCEttYmYJoooRTWrRTLY2qiejUW/ynlI+sNslT+nyMmy3b2C3RjIXC2WvWGnodAvQP
         YnIsxnTh2YITS2prbeZSnNy2CxxuU0ljpgu0Fm7/Cr6JsQ27RN6KxNf2qb81IKkcDRSS
         umRZozZpRCFGN+gVIJ+/MrLC08KfuJGLDp5+ZVYQZpiivn6wRN4gRYXzV/qD8gDvgWiR
         O8Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717067446; x=1717672246;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kiy02xbpkVoe0jsA57DQLD//qIOyPVkR19TcyOZjzlw=;
        b=pmzTm0waWeJeOoZiQbhyp5eaMAM3q549SDoZD3CVWZ8KCE/PK++ojpuWM0hixekK/S
         W61RvoSPP0tAuha9TRtT+7Dega82A8xCYK1c0374DKFCMO7T2uAKRl0+kROeFpep75S0
         Ioyc88VHf8V422Fhog++0cRpmoHXy/eY4z5/QDSfkKggP99yp3OzDnLYQ11C7IkmNRtF
         AYX5Drs9rSS2mcFA1ob/6FGpSwD/pFsy5GmRX4JlIJh1NmdhuLaSWmAjrHhrIdd8h+ce
         xOJShakUqf7Se16qyWLlTTPhiwOsMxKfXv1vXnjlIe6tKvbZmnpdk63mSU3uk/Y7MhL8
         /HBA==
X-Forwarded-Encrypted: i=1; AJvYcCW++nv54XFoYDV55SjlE8QrPIWYWCCUXYeCAJ0z0tapGWgw1ggslka8KwwBkPk1wJ8TwLSo5koAyqfA1unlfZtREf3U/XkGwChw1eoCew==
X-Gm-Message-State: AOJu0YxEivwXAFytC9FgOyf2QtNnDFAqv1SKiRXE7EGalqA4HllXJsYj
	pfSby2XvUk3KkVTwWhJz4Grfo/nKO4n/Dm1NAEJ1rvMdiSWDKZVhzmXnAvmpG/I=
X-Google-Smtp-Source: AGHT+IGchwI3vGbp2XfZ0nNpV0truuCoIeo7BGZQIyTNoxwDO/cF3FCmMTdbSH9KXzYGNrWg5l0NwA==
X-Received: by 2002:a5d:6acd:0:b0:354:faec:c9e4 with SMTP id ffacd0b85a97d-35dc00c7d46mr2029957f8f.60.1717067446409;
        Thu, 30 May 2024 04:10:46 -0700 (PDT)
Received: from airbuntu (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-357ad6c2fabsm13518620f8f.83.2024.05.30.04.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 04:10:45 -0700 (PDT)
Date: Thu, 30 May 2024 12:10:44 +0100
From: Qais Yousef <qyousef@layalina.io>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org, Phil Auld <pauld@redhat.com>
Subject: Re: [PATCH v2] sched/rt: Clean up usage of rt_task()
Message-ID: <20240530111044.d4jegeiueizvdjrg@airbuntu>
References: <20240515220536.823145-1-qyousef@layalina.io>
 <20240521110035.KRIwllGe@linutronix.de>
 <20240527172650.kieptfl3zhyljkzx@airbuntu>
 <20240529082912.gPDpgVy3@linutronix.de>
 <20240529103409.3iiemroaavv5lh2p@airbuntu>
 <20240529105528.9QBTCqCr@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240529105528.9QBTCqCr@linutronix.de>

On 05/29/24 12:55, Sebastian Andrzej Siewior wrote:
> On 2024-05-29 11:34:09 [+0100], Qais Yousef wrote:
> > > behaviour. But then it is insistent which matters only in the RT case.
> > > Puh. Any sched folks regarding policy?
> > 
> > I am not sure I understood you here. Could you rephrase please?
> 
> Right now a SCHED_OTHER task boosted to a realtime priority gets
> slack=0. In the !RT scenario everything is fine.
> For RT the slack=0 also happens but the init of the timer looks at the
> policy instead at the possible boosted priority and uses a different
> clock attribute. This can lead to a delayed wake up (so avoiding the
> slack does not solve the problem).
> 
> This is not consistent because IMHO the clock setup & slack should be
> handled equally. So I am asking the sched folks for a policy and I am
> leaning towards looking at task-policy in this case instead of prio
> because you shouldn't do anything that can delay.

Can't we do that based on is_soft/is_hard flag in hrtimer struct when we apply
the slack in hrtimer_set_expires_range_ns() instead?

(not compile tested even)

diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index aa1e65ccb615..e001f20bbea9 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -102,12 +102,16 @@ static inline void hrtimer_set_expires(struct hrtimer *timer, ktime_t time)
 
 static inline void hrtimer_set_expires_range(struct hrtimer *timer, ktime_t time, ktime_t delta)
 {
+       if (timer->is_soft || timer->is_hard)
+               delta = 0;
        timer->_softexpires = time;
        timer->node.expires = ktime_add_safe(time, delta);
 }
 
 static inline void hrtimer_set_expires_range_ns(struct hrtimer *timer, ktime_t time, u64 delta)
 {
+       if (timer->is_soft || timer->is_hard)
+               delta = 0;
        timer->_softexpires = time;
        timer->node.expires = ktime_add_safe(time, ns_to_ktime(delta));
 }

