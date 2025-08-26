Return-Path: <linux-fsdevel+bounces-59302-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D12D6B37150
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 19:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C90B98E3134
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 17:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B54A2E7F21;
	Tue, 26 Aug 2025 17:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GL3EkfL8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F08C2E7645;
	Tue, 26 Aug 2025 17:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756229155; cv=none; b=VBuVcOMLN0mbUcQdgZOA4Q16QYLNUun+82FBsjsb9wYa7gByACb7fzcBtha/daydyDWJXvxr2GCsPTMcF9nbp+VxZhZtkMNTLw47ztiuTvJJDTuZGdOozimCZ0d4XfBiHxN28taXs43H8ErW8MoW4LfCBLN+Ns1y9bB+HUn/jR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756229155; c=relaxed/simple;
	bh=mfizfHDWKSGlozkc4tLuwDndi6x0KhMxNlC41A3u0sU=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-version:Content-type; b=mJIju3+XS2wPqQtjtDBoHqAKIl1lUK1Lh0FbW32ZwHpa3VXrR7Axx+atzYe3ojeWEIeiOqitTcUyMtP+a/pD8897XlgwzH3jeShYDQNinn/VnO+OL03Pv/i0mMyUMxOt7SjbzNZDidfOKlIzIOqeDZSkuQybr/htMgaqkG/rK1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GL3EkfL8; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2467de5160eso29206395ad.0;
        Tue, 26 Aug 2025 10:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756229153; x=1756833953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:message-id:date
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uLw9Uoz6Tbt81Fl6ED1MMbaPVoc6YtscpFiSGvOkBd4=;
        b=GL3EkfL87O/A7OlKgXmRLmBfz6wD6dtuPg6MbFwmNFycQ2jmHOKThl+4ao3AfsXKhu
         LrrU29aaDN0y69sxowFP5Q9XUYzo4nQdsqyIMsOexj5YrSIvpNHOP3fxGUyFWsMG+5fm
         rk/AzzrVUKdVDoAzwYvsFzys0TM2hXlPg5vfMfUTMvMfHmZig57QKzn46O0FwRKeECQH
         lXlBPGx+1rTXHPKHItQTAn4vlumyL/yzQCYQmw1pQj7KW2UEnJX+WWXZYEvqq0OQTIQe
         iHzZ0m9ICyn3IDX8PRbTYTF+yh1e+wCXi3p3t+DUw7MJ6m0mvQpNJAJB0Ndeq3pl4yo2
         rGsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756229154; x=1756833954;
        h=content-transfer-encoding:mime-version:references:message-id:date
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uLw9Uoz6Tbt81Fl6ED1MMbaPVoc6YtscpFiSGvOkBd4=;
        b=rsq/8B07CYfQefiws1fhvvWa9A70WIGDaSp0xMyxj7scsCWHhPW3PwTgru6M/7Ulkt
         lTFSmY+FaIgFGXhiq3D++M0UcSS4UdTTcc7jmHBKFe5A8Q0TP0zGDXAtWfw535/snq/n
         ZC404nIORaYCwDyFOBxXF0NwmstEaserOIJ6n710QBnxH5rHQFO7Gm0jO5XtYTGE7Y0M
         hRGDHlhQ9bl7su+j2cg1bKIRR8c29FLU5YIqpiGyyFSh0MbxcnkWi1FFtR2axFODNyJP
         6GQ9l2Ulwbh+vIV/PoQZfGeYk0l6UfnoWOOdgQuxDYTIm11ytKdCNmmtrS9skKkW9oqY
         k/8Q==
X-Forwarded-Encrypted: i=1; AJvYcCV+ZM+For/+DPnQ0IUUHp6rtKwist7rptKd7tslXkJNC9MlJpx7MT6r/idxHeFpKjvz+rC28lxWSHy2Iw==@vger.kernel.org, AJvYcCXaUBl3ayjtWPzu5t8VtOppjOsJy/pDZZNFDJw/+O3gjoraOMzwzVhJZYBGGQo5YUmbaFzrWQRxdc8m@vger.kernel.org, AJvYcCXooQwE96Ohbs8klubjhl7b4FvZT6cyoUz0oDONmAWF0cPhsW+w0RL9qGtNZBzTEG/MF9ZJ5F12BSv3cFxUyQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyqyxBfcyKNJLy/2aDnZxNqwxaZ511AKuUo7i9LPXwY/SlN9VTi
	JTZdlkpCDPOUwtikeEah7EqHyzGebORLoYGlFUMERh3Or0SKUQT4bRza
X-Gm-Gg: ASbGncsKgPJu9kJzOyk1sisklf78GQHY75C6ljPGfBR2vafV/5iOczze1Vn0IkWxlTR
	0wGoYC96HDVb3gkfXWStDeGJRFXIZz8fdsYhAsBFwP7cFIb1Kt0+Caa7g8r3cve0mnEFfSuOYtL
	2Qv99Buovj+fNSIO+oUY1h92ZvikRMNB9VkfyIkVxWC6T+Ja9wcfMT+FmCWht6VMrpfzC85pDeF
	ec0+NIHBnSRR8gk3xY/Pb1AeZdMwUKaakx988EOgw0mjpGNto1Ne5h5aNsP0y8A2Hrgy39sfAv6
	Le3XrfK/YN90Ewb0VS8CNWzBO7841uCl0M0IjoGX58ZZMU6V+CGTea4WYB4QvDzHeAP5LXpP9sG
	FDvJZMKPOhdsGnVH+oXPWTQxs
X-Google-Smtp-Source: AGHT+IEWgBRM0v2G+FcafZmJl/omfs0Uh0JKNPlp/i5SCyYCxuFG2i32PH0SvPbcdPMPohfb3MIzow==
X-Received: by 2002:a17:902:e788:b0:246:80ef:87fc with SMTP id d9443c01a7336-24680ef8bc7mr154253345ad.45.1756229153495;
        Tue, 26 Aug 2025 10:25:53 -0700 (PDT)
Received: from dw-tp ([171.76.82.15])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32745bbff33sm1024685a91.9.2025.08.26.10.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 10:25:52 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Fengnan Chang <changfengnan@bytedance.com>, 
Cc: Matthew Wilcox <willy@infradead.org>, "Darrick J. Wong" <djwong@kernel.org>, brauner@kernel.org, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] iomap: allow iomap using the per-cpu bio cache
In-Reply-To: <CAPFOzZvBvHWHUwNLnH+Ss90OMdu91oZsSD0D7_ncjVh0pF29rQ@mail.gmail.com>
Date: Tue, 26 Aug 2025 22:23:05 +0530
Message-ID: <878qj6qb2m.fsf@gmail.com>
References: <20250822082606.66375-1-changfengnan@bytedance.com> <20250822150550.GP7942@frogsfrogsfrogs> <aKiP966iRv5gEBwm@casper.infradead.org> <877byv9w6z.fsf@gmail.com> <aKif_644529sRXhN@casper.infradead.org> <874ityad1d.fsf@gmail.com> <CAPFOzZufTPCT_56-7LCc6oGHYiaPixix30yFNEsiFfN1s9ySMQ@mail.gmail.com> <aKwq_QoiEvtK89vY@infradead.org> <CAPFOzZvBvHWHUwNLnH+Ss90OMdu91oZsSD0D7_ncjVh0pF29rQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Fengnan Chang <changfengnan@bytedance.com> writes:

> Christoph Hellwig <hch@infradead.org> 于2025年8月25日周一 17:21写道：
>>
>> On Mon, Aug 25, 2025 at 04:51:27PM +0800, Fengnan Chang wrote:
>> > No restrictions for now, I think we can enable this by default.
>> > Maybe better solution is modify in bio.c?  Let me do some test first.

If there are other implications to consider, for using per-cpu bio cache
by default, then maybe we can first get the optimizations for iomap in
for at least REQ_ALLOC_CACHE users and later work on to see if this
can be enabled by default for other users too.
Unless someone else thinks otherwise.

Why I am thinking this is - due to limited per-cpu bio cache if everyone
uses it for their bio submission, we may not get the best performance
where needed. So that might require us to come up with a different
approach.

>>
>> Any kind of numbers you see where this makes a different, including
>> the workloads would also be very valuable here.
> I'm test random direct read performance on  io_uring+ext4, and try
> compare to io_uring+ raw blkdev,  io_uring+ext4 is quite poor, I'm try to
> improve this, I found ext4 is quite different with blkdev when run
> bio_alloc_bioset. It's beacuse blkdev ext4  use percpu bio cache, but ext4
> path not. So I make this modify.

I am assuming you meant to say - DIO with iouring+raw_blkdev uses
per-cpu bio cache where as iouring+(ext4/xfs) does not use it.
Hence you added this patch which will enable the use of it - which
should also improve the performance of iouring+(ext4/xfs). 

That make sense to me. 

> My test command is:
> /fio/t/io_uring -p0 -d128 -b4096 -s1 -c1 -F1 -B1 -R1 -X1 -n1 -P1 -t0
> /data01/testfile
> Without this patch:
> BW is 1950MB
> with this patch
> BW is 2001MB.

Ok. That's around 2.6% improvement.. Is that what you were expecting to
see too? Is that because you were testing with -p0 (non-polled I/O)? 

Looking at the numbers here [1] & [2], I was hoping this could give
maybe around 5-6% improvement ;) 

[1]: https://lore.kernel.org/io-uring/cover.1666347703.git.asml.silence@gmail.com/
[2]: https://lore.kernel.org/all/20220806152004.382170-3-axboe@kernel.dk/


-ritesh

