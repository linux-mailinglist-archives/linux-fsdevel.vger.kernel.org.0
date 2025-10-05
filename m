Return-Path: <linux-fsdevel+bounces-63448-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD44FBBCE12
	for <lists+linux-fsdevel@lfdr.de>; Mon, 06 Oct 2025 01:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57B0B1895485
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Oct 2025 23:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48AA1233722;
	Sun,  5 Oct 2025 23:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="KAt6JuNa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163DC1DF75A
	for <linux-fsdevel@vger.kernel.org>; Sun,  5 Oct 2025 23:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759707505; cv=none; b=j+JUN09aEzEm0mX5IPPGXnTFRDsZuJdLJcwlcZpuJxa1BHRNHcXp60GndRb5zr1gQWUbN7SX/68Tss2xPgRDLCoc7BtW7q3CkuNFzJzxR3oxranFQTKZdrf3v9v+2s3wjoZhRSgERSFqT2ReYqyQq5SyrTYj8B7A+/2RL9K4bgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759707505; c=relaxed/simple;
	bh=ZeL8g3+NIGghkoED2HmChwuHilgupZ9KQh+zbVphGW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L34ZPpuRDfZIMCSVcWkoNAEPTiNZhv1sfZKvp32dR6Z1WMaUKV1iywgApWRg65MioFmOTjV5lEgECjCOHiJghNupAGCbPMJQ6xOE1kFzC8BEWaXRJvUiRiHDv09xI/lU8lgHpq/Vj0Plm1jIpbo2wRa3uFzYuKoZh1Fs+yr5Ec4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=KAt6JuNa; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-77f1f29a551so5282658b3a.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 05 Oct 2025 16:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1759707503; x=1760312303; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wYZUqfHCkY9qWTGMyfXAR/EXot/02oxeQhh+iKW+hV4=;
        b=KAt6JuNao17F0KLky6jysffcgeHqsYte1hgupMEyzH9N/l8yrthDpUQLwB/ftz1DU5
         xH+fgRIscd9OYV19/pkQs/Jeolq8Uq3nb38twgr4C7wk21xz6GZNUNWh204Wb09SxGU2
         l9Ers5x4rb4uAqYqzYYZ86sX4ZNdzISF458bvUu6SXrqLFpeKkIbCAIhx3MHI1z7MT/v
         nrkvhgVFzNAS4H3dN9pKr30BOk6dd6Daf5BGMXdnLgeVOipgJ1UK/53DxvHeevoFxxT2
         XV2ojKqHSW/Kj+coRzd+B3hBCFw/FK9RB0+lRxzTA9TmHnmjCgibOKMng2GdvsCIudXX
         1Xdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759707503; x=1760312303;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wYZUqfHCkY9qWTGMyfXAR/EXot/02oxeQhh+iKW+hV4=;
        b=Le5TaPOBNl6Sf3XlOFENsibdAAQV3+2bJikWF3Aj1N5LccRnaE3EpBeNIR2Kuxp3H2
         +VEzZlpEm7Dvc3fl31EjwRB1C6zYjUWVcQns4mbG9/yT/zktqf0r2glkpJAnVYda6aam
         TF2RQafv4bLeF6Ruz/XIZR58rEZrvnePcizqyRv3syueLpRcue7//A8Sd2rFLTH3oL5B
         /rMBxiAhczXJUxW+wWqtAR7LSwE+Wjojg16etnQnIjJQdVRHAFDVGyudX8BnLShzdkFA
         3A5j+4q4KoC+5+q3FIH9dn/Gk3QigT23pVwWOr4g88dFs7hemykmsC3mOGO9ofyBxNsF
         DO/Q==
X-Forwarded-Encrypted: i=1; AJvYcCV89nzSDutjSnUTDyExvel18g5b3lqzFKw9i7ae7Nh+O2Qvlzl3FJHA7ewNfx9NIIKKwJPxhN5ioMRD3R6H@vger.kernel.org
X-Gm-Message-State: AOJu0YxmAQwL60n57c3yboeVYwI8IeoAHT/UdIL6NmJbb8k0huN9VlFQ
	nJL1D8K+NUNzqcyAEHkJmG7jfPyjWH/M+kNjFM9Sje75FrAcqKtH5FdO21UlojSAlRjhboZxjA6
	EliGA
X-Gm-Gg: ASbGncudi1ysY8ICCX2p4cAVwDvKGi0xnqWlh3uu9hzatV66S9fpUyR2YRl4SmnpQ0u
	axS4WdLLsfvdL1GexApnA4bn024QTjY60MqGKd8ak3CS1feeHLcmrPZyZ0yCZSbPVdejNtYx4qF
	uJ9hcHgwWCkEeil+KUgdP2h8rcupYRx6fRovxtfZ11ykmlYU//lLs9l5kDYQTdC1/0IUBPpygzx
	jZNXjJ0G7d/lRql+3rmg2IPQrc418/37LsqHvZ3vnQ2HBODOvYTWHqig+czyG4MUp0mvgf98uA1
	ofE3c0KypReHv7fUX9G9gGP4KpUNJu3qBaCiej4C2RqpTnKXhgHGIw5yY/hMdfxSKZrEy6RolfZ
	WcjpZLokqSMr4eVmMB5TKNupOexIvavhm5KG3oY9Pd7mR3mycK16GIjAtt4Y6osHpGfzwGd9wKq
	YFV9MxNxIMjymTuzY3ykRQZQ==
X-Google-Smtp-Source: AGHT+IHsY0pPmwLcFhMINPZMciPWEOHQAe8XZcWIZ+42Ncu6X7pq8uNjulttyDUGl4xm8ixxs91eVA==
X-Received: by 2002:a05:6a00:39a6:b0:77f:11bd:749a with SMTP id d2e1a72fcca58-78c98cb7834mr10735744b3a.20.1759707503195;
        Sun, 05 Oct 2025 16:38:23 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-91-142.pa.nsw.optusnet.com.au. [49.180.91.142])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b020537e0sm10861937b3a.56.2025.10.05.16.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Oct 2025 16:38:22 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1v5YJ2-0000000B2DA-1HKV;
	Mon, 06 Oct 2025 10:38:20 +1100
Date: Mon, 6 Oct 2025 10:38:20 +1100
From: Dave Chinner <david@fromorbit.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Pavel Emelyanov <xemul@scylladb.com>, linux-fsdevel@vger.kernel.org,
	"Raphael S . Carvalho" <raphaelsc@scylladb.com>,
	linux-api@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH] fs: Propagate FMODE_NOCMTIME flag to user-facing
 O_NOCMTIME
Message-ID: <aOMBbKUlvv2uYLzD@dread.disaster.area>
References: <20251003093213.52624-1-xemul@scylladb.com>
 <aOCiCkFUOBWV_1yY@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aOCiCkFUOBWV_1yY@infradead.org>

On Fri, Oct 03, 2025 at 09:26:50PM -0700, Christoph Hellwig wrote:
> On Fri, Oct 03, 2025 at 12:32:13PM +0300, Pavel Emelyanov wrote:
> > The FMODE_NOCMTIME flag tells that ctime and mtime stamps are not
> > updated on IO. The flag was introduced long ago by 4d4be482a4 ([XFS]
> > add a FMODE flag to make XFS invisible I/O less hacky. Back then it
> > was suggested that this flag is propagated to a O_NOCMTIME one.
> 
> skipping c/mtime is dangerous.  The XFS handle code allows it to
> support HSM where data is migrated out to tape, and requires
> CAP_SYS_ADMIN.  Allowing it for any file owner would expand the scope
> for too much as now everyone could skip timestamp updates.

We have already provided a safe method for minimising the overhead
of c/mtime updates in the IO path - it's called lazytime.  The
lazytime mount option provides eventual consistency for c/mtime
updates for IO operations instead of immediate consistency.

Timestamps are still updated to have the correct values, but the
latency/performance of the timestamp updates is greatly improved by
holding them purely in memory until some other trigger forces them
to be persisted to disk.

> > It can be used by workloads that want to write a file but don't care
> > much about the preciese timestamp on it and can update it later with
> > utimens() call.
> 
> The workload might not care, the rest of the system does.  ctime can't
> bet set to arbitrary values, so it is important for backups and as
> an audit trail.

Lazytime works for this use case; a call to utimens() will cause a
persistent update of the timestamps. As will any other inode
modification that has persistence requirements (e.g.  block
allocation during IO or other syscalls that modify inode metadata).

> > There's another reason for having this patch. When performing AIO write,
> > the file_modified_flags() function checks whether or not to update inode
> > times. In case update is needed and iocb carries the RWF_NOWAIT flag,
> > the check return EINTR error that quickly propagates into cb completion
> > without doing any IO. This restriction effectively prevents doing AIO
> > writes with nowait flag, as file modifications really imply time update.
> 
> Well, we'll need to look into that, including maybe non-blockin
> timestamp updates.

This came up recently on #xfs w.r.t. lazytime behaviour - we need to
pass the NOWAIT decision semnatics down to the filesystem to allow
lazytime to be truly non-blocking.  At the moment the high level VFS
NOWAIT checks (via inode_needs_update_time()) have no visibility of
this filesystem specific functionality, so even if we can do the
lazy timestamp update without blocking we still give an -EAGAIN if
IOCB_NOWAIT is set.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

