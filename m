Return-Path: <linux-fsdevel+bounces-74613-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +I0KBqNAcGnXXAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74613-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 03:57:39 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 799B5501C1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 03:57:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 60B747E1A33
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 10:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146FB352C2D;
	Tue, 20 Jan 2026 10:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rubrik.com header.i=@rubrik.com header.b="DRe8zEIW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D056C37F8BB
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 10:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768906607; cv=none; b=pUTfKVSp4jIo0cr1nsOq/29/jvPTUSH6aRmTwBRQPQC2azWDDHmNm20Ygg7le/pAZp1rsiWKkWSItZbbS8zxRvfZ8QkQ++FqEPhEQwFWyGp2yzmMOtVYXx0xbvVObSa+B4mDhjgOsA/hyqU9Ld1aTVrWlRW4nc/8sDiJTgE0GNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768906607; c=relaxed/simple;
	bh=cD5k8UR8IhRzXGj5e5PKMGzBfU1OmdTxIuHLCAdg2lE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gXhjZuFOGp8i3wjtjcGDniLdxsMMYKpOkbRhgRabeXqbF11UuKAVt/dmePIRruiO4FzQbbbTyhmRZsT4NyG4IsiU8B2KBl+/mZsx+fk7IY/umyi26TDtLondP6SbcYkQznM/fWppbbry4sOkR2JKwNo0+fb4MHfDi+3WfFNenyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rubrik.com; spf=fail smtp.mailfrom=rubrik.com; dkim=pass (2048-bit key) header.d=rubrik.com header.i=@rubrik.com header.b=DRe8zEIW; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rubrik.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=rubrik.com
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2b6fd5bec41so1009660eec.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Jan 2026 02:56:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rubrik.com; s=google; t=1768906605; x=1769511405; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IohJAnQSDm7aXW2yp3iRXAEYaHwSvSwfoB/OjZULkVU=;
        b=DRe8zEIWZtlJDG+62v4NEJj0Rh9cPMYKPGCRceHw8eA3rNVVAuV2b5PpMUNZmtb3Oi
         0O8s+mYN2bl+7Bf+zQ1jtvpfy/R7FZKjB1GBdCcYgD6jYeVgYCVFUdIvNZbR4jHKQQr0
         Waacb13kifroJos1IaAhmp22lUVhqol7kU3eogtxtThnFsCe08mkmhobN6h0se2Hiv2y
         I/IcF/vM8GSlslsUUhX64TMia+9CtctSwTRo41zgsuCt7I9oBSoWkPWg3/C6aGmGqZZQ
         zYJpA10A4hPKBmsEvEavvT95jqO85ujwhwXulhyWCk2/DDROuBpmrB0oUY77czWO/S7G
         a88w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768906605; x=1769511405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IohJAnQSDm7aXW2yp3iRXAEYaHwSvSwfoB/OjZULkVU=;
        b=BQa5THVw/d9V7Hlnm/7sv/LobMd8JBFy02GsBGunXqE3acHWG6OEfVaFrTmoDAKKT1
         VwLik2x8hXja7fgNciGl1PNQHFw5vIRGWTLsdAV0f6ns9TzE56r8H0ThMomvA2VIUPRZ
         39Ec3GzkhbCVKCTdD3uKJMtLnn4kw9ZZWdZ+CNNv0I86bLs/GkpSe75ZhkG4gYUKwxSk
         Ilafse7HuTIoZeggCligYALBj7LYhiXlPqKQJ57XznHjlq5btLR3vEEn8QGYlGLxJWa5
         TRcyo5HcI5P766V7nNhwdbm5oAzokpGsArS5viCTeo0SkAvZO8IihKIzoQ0JlFW8/cRY
         TUHA==
X-Forwarded-Encrypted: i=1; AJvYcCXUOjJv/ueQ+8C7DMGHnJxEWK2kOdNyBHqkW2b8aPhvjMQzGCIjrfIJOLgrT+s3FdRFYyIKqtQseM4akd7C@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8lQiCJgHhv4ZLq1JFVU2mQa7FrxigUbMCY0I874ib8u9klEo6
	jDoXNRcUScfruAh7qH3P9e7QvfYSgtoK9zfAmJqjZgbCZpBXsGNkuR7vJelz5Wpy+fc=
X-Gm-Gg: AZuq6aI7M5ehP7FYeNeA330+76WMFqa5q22fNOEI9JYKyUaRJE4W204XTdmbmR+SuxA
	dEErh/EhhxTWdgQde9po0CW6tlGNUk77q9hP8EjZJxGacZEuh0xsjHzucbt/Odn+w48CwcrC1nF
	D8BP4TUhNQ/H17NKil1Jv2dehK5tivnHnQGEhV089FTI66AN0lnRTGtnplZul/IdNZYYKAZ1tG0
	USeFPvMf7oBnufRsyW/clPvdBelBdH2yEjkRxXt1NQNZXiElRR022RKPYKWSMYKjfLnsMxiKATa
	Jjv8GP3F6SX3JYWvQhC61HSC+7E1shmf1YTDRkg04hxaMzvJ2KzF/Lg02jrNAa3IiHmwHcnCFpa
	ddilUDyh9W5TRrTS7t0hziIM82l+XnJiIpy4OTMP+6V2NSZ5xa2bA4eU9gt16p/sUP8rAGom5dI
	mbycNmNuSUIc+Ws9MnmjffY9lQTeakZY3D681UPjyR+KLjrUFPsGI6sBqvfqXqFQ==
X-Received: by 2002:a05:7301:1286:b0:2b0:59f9:aed6 with SMTP id 5a478bee46e88-2b6b3f182cemr12583367eec.9.1768906604592;
        Tue, 20 Jan 2026 02:56:44 -0800 (PST)
Received: from abhishek-angale-l02.colo.rubrik.com ([104.171.196.13])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-2b6beeb4b9csm17424483eec.30.2026.01.20.02.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 02:56:44 -0800 (PST)
From: Abhishek Angale <abhishek.angale@rubrik.com>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	Jan Kara <jack@suse.cz>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	NeilBrown <neilb@ownmail.net>,
	linux-fsdevel@vger.kernel.org,
	Abhishek Angale <abhishek.angale@rubrik.com>
Subject: Re: [PATCH v2 1/1] fuse: wait on congestion for async readahead
Date: Tue, 20 Jan 2026 10:55:52 +0000
Message-Id: <20260120105552.760619-1-abhishek.angale@rubrik.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAJnrk1Yi-_x6w0f7w=xRBT7s4SDEJKcTm_f-hCZjdyBVtvxCzQ@mail.gmail.com>
References: <CAJnrk1Yi-_x6w0f7w=xRBT7s4SDEJKcTm_f-hCZjdyBVtvxCzQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.96 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[rubrik.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[szeredi.hu,suse.cz,kernel.org,hammerspace.com,ownmail.net,vger.kernel.org,rubrik.com];
	TAGGED_FROM(0.00)[bounces-74613-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DMARC_POLICY_ALLOW(0.00)[rubrik.com,reject];
	DKIM_TRACE(0.00)[rubrik.com:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[abhishek.angale@rubrik.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,rubrik.com:mid,rubrik.com:dkim]
X-Rspamd-Queue-Id: 799B5501C1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Joanne,

First, please accept my apologies for the delay in responding.

Thanks for the thoughtful questions. I agree these are the right
concerns to validate before making readahead block on congestion, since
it can block application thread.

A few clarifications on the call path and what the patch actually waits
on:

* The wait only triggers when we’ve reached the congestion threshold and
  there are only async pages left in the current readahead window:
  - Condition: fc->num_background >= fc->congestion_threshold &&
    rac->ra->async_size >= readahead_count(rac)
  - In other words, the page(s) needed to satisfy the caller’s current
    read are already accounted for; we don’t block those. We only decide
    whether to continue prefetching the remainder of the window or skip
    it.

* The wait is killable (wait_event_killable), so signals will break out
  immediately.

* Wakeups are driven by fuse_request_end() when the number of background
  requests falls below the congestion threshold. The patch does not
  increase concurrency; it only avoids the “idle gap” caused by aborting
  async readahead when congestion eases.

> How does this perform on workloads where there's other work
> interspersed between the buffered sequential reads, or on random/mixed
> workloads where readahead is triggered but not fully utilized?

To your questions on interspersed and mixed/random workloads:

* Interspersed workload (thinktime between reads): We specifically
  tested a workload with thinktime (to simulate CPU or other work
  between IOs). Results are essentially unchanged with the patch:
  - Avg latency: 6.12 us -> 6.29 us
  - Avg IOPS: 7577 -> 7571
  - BW: 29.60 -> 29.58 MB/s
  - These deltas are within run-to-run noise. This makes sense given the
    wait only applies to the async portion and doesn’t block the
    synchronous data needed by the caller.
  Command:
    fio --name=interspersed_work --filename=file.1G --rw=read --bs=4K \
        --numjobs=1 --ioengine=libaio --iodepth=1 --thinktime=1000 \
        --thinktime_blocks=8 --size=1G

* Strided workload (wasted readahead): This is a case where readahead is
  often not fully utilized. The patch doesn’t hurt; we actually see a
  small improvement:
  - Avg latency: 2565.90 us -> 2561.92 us
  - Avg IOPS: 44260 -> 44960
  - BW: 173.0 -> 175.8 MB/s
  Command:
    fio --name=strided_wasted_ra --filename=file.250G --rw=read --bs=4K \
        --zonemode=strided --zonesize=128k --zoneskip=100M --numjobs=32 \
        --ioengine=libaio --iodepth=4 --offset_increment=1G --size=1G

* Random read stability: Also slightly better with the patch:
  - Avg latency: 15829.10 us -> 15536.74 us
  - Avg IOPS: 7856.6 -> 8009.2
  - BW: 30.7 -> 31.3 MB/s
  Command:
    fio --name=random_read --filename=file.250G --rw=randread --bs=4K \
        --numjobs=32 --ioengine=libaio --iodepth=4 --offset_increment=1G \
        --size=1G

> I'm also concerned about how this would affect application-visible
> tail latency, since congestion could take a while to clear up (eg if
> writeback is to a remote server somewhere).

On application-visible tail latency: because the wait only happens when
the request stream has reached the congestion limit and only async pages
remain, there is no blocking of the “needed now” page(s) for the current
read. So the caller’s synchronous read path latency is not delayed by
this wait. The killable wait helps ensure responsiveness to signals. In
practice, the wakeup happens as soon as one background request completes
and num_background drops below the threshold, so the wait typically
lasts for one completion interval and then prefetch proceeds.

That said, I’m completely open to bounding the wait if you’d prefer an
extra safeguard for remote/backends with long stalls. A minimal change
would be switching to wait_event_interruptible_timeout() with a small
timeout (for example, 20–50 ms). If the timeout expires, we fall back to
the current behavior (skip the remainder of async readahead for that
window). This keeps the throughput benefit when congestion clears
quickly, while bounding worst-case waits when it doesn’t.

Thanks again for the review. Happy to refine this along the lines above.

Thanks,
Abhishek

