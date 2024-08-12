Return-Path: <linux-fsdevel+bounces-25708-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C96A94F610
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 19:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFD7328227E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 17:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6159B189509;
	Mon, 12 Aug 2024 17:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="iiF5iGRm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CD025569
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Aug 2024 17:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723484963; cv=none; b=Qg+1BVfHNhyTJum54As13yBFdAykYKVjSUzvYZtyoqM0CdTIzUL4V0VVnIA1CqSaRebmefrP686NrH/Giti2sk5irndG1kJmB/k4qNVDLRlU9C07hPwGUG7eJx4KnkkzSG8naehKJlzkSRCC8vWfLDJLI6TxOUvRVbwOk7OgD7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723484963; c=relaxed/simple;
	bh=xJQAO73DqYcpcrpzJhRms2PChIKKquV3jxP/QxepmOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tYQ5h3eEh08EXCxrxUyBjU16VvqZUuixYh0eGn9LwTE/WsjXera5ZloYqF09Mv5CfaDB3TbSM0Mf+oY3nBGj7SwJ1w9hvmhzMCF8wGq9jXRN6+hyPwghU/S0EpxKLnpXHis2a3BhYumuEqqficNoIoMg1OKRqdO6xdiDjn/i9y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=iiF5iGRm; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2f040733086so43706101fa.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Aug 2024 10:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1723484960; x=1724089760; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HsI/85POvh5vnBnJl/Ml+X2MbaaQJCBmp/2HiWmFvVc=;
        b=iiF5iGRm+xjNYB05LFMinOGVbkuG+f8p1MAbrYrAO5KaiE3ByaO/JtckqgjOSftpvj
         Yzxguj2w7raY32efEEJRCkYOiATpK8DqQs75CPbxVfjdVN5Vi0kl0MfSXrkyYusEjbwT
         nRJ6wlyQzu7lRlCGjrcGTR24vE+iIBzvHwwyY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723484960; x=1724089760;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HsI/85POvh5vnBnJl/Ml+X2MbaaQJCBmp/2HiWmFvVc=;
        b=rpIwKhAd788eUpsy7btryCBbBUBulsN4X1J4I0IjkG59OKbnq8459rScAUWRjkX1AP
         jgA72bppTS6/ekHLDcwUt3yq/shTLoyXxLQpKW9FNXfJsK/QhPe/wvGoRGw5v0jz5OZg
         imL021zjFj8DTnWFf2PjDDSXRGPSdJMPCLu4M+QUZLOOAJXGpmNkZ0EIxWkFtWfo1J9h
         upjTEa9jy93iPSEtHyObAYWGdRKz9X7VPUAyfOB/OMzws/CWhCHbblg1RvFDB0XdVKJI
         j3vUzpJTMHq/MyFYx04bXbuCw1XSfBxuMh0DOkqHUFDXROYzK0HJrtaCBlv5qFTxXhio
         FPjA==
X-Forwarded-Encrypted: i=1; AJvYcCUHC869p0wpDKJ1U5UhWJ9CoNL4TOKCRKt3C0CIQjADwDrg9cF8J6zOaPqfDTiGmIqh7KvnjNrDJOqBeq4gbLGm26iXARm2+YFNCGqfkw==
X-Gm-Message-State: AOJu0YxHzTbim9g2quT4lmF1KUDDJyuLdt5kC212MQpYbzFngwgHgFuo
	dj59SXhRaZxb8YNz7wdMPZga+UjHIy0VHo7ymSEJJrYuSWzYUpVWpp88XbuMLnMWaM+VPRnT93S
	hFDQ=
X-Google-Smtp-Source: AGHT+IHgUZXFjwqJh/Us+96cJZXvkGbwq6boy3DczVlFRyIDhGV6ztmvUfcpiRsijYp2iY9FkY3/Xw==
X-Received: by 2002:a05:651c:2227:b0:2ee:7a3e:4721 with SMTP id 38308e7fff4ca-2f2b717968fmr7861821fa.39.1723484960099;
        Mon, 12 Aug 2024 10:49:20 -0700 (PDT)
Received: from LQ3V64L9R2 ([80.208.222.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4f0a7111sm8167034f8f.117.2024.08.12.10.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 10:49:19 -0700 (PDT)
Date: Mon, 12 Aug 2024 18:49:18 +0100
From: Joe Damato <jdamato@fastly.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Christoph Hellwig <hch@infradead.org>, netdev@vger.kernel.org,
	mkarsten@uwaterloo.ca, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com, sdf@fomichev.me,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	"open list:FILESYSTEMS (VFS and infrastructure)" <linux-fsdevel@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC net-next 4/5] eventpoll: Trigger napi_busy_loop, if
 prefer_busy_poll is set
Message-ID: <ZrpLHogt9IyzNxXk@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Matthew Wilcox <willy@infradead.org>,
	Christoph Hellwig <hch@infradead.org>, netdev@vger.kernel.org,
	mkarsten@uwaterloo.ca, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com, sdf@fomichev.me,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	"open list:FILESYSTEMS (VFS and infrastructure)" <linux-fsdevel@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
References: <20240812125717.413108-1-jdamato@fastly.com>
 <20240812125717.413108-5-jdamato@fastly.com>
 <ZroL54bAzdR-Vr4d@infradead.org>
 <Zro1onXfGkKoIRbY@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zro1onXfGkKoIRbY@casper.infradead.org>

On Mon, Aug 12, 2024 at 05:17:38PM +0100, Matthew Wilcox wrote:
> On Mon, Aug 12, 2024 at 06:19:35AM -0700, Christoph Hellwig wrote:
> > On Mon, Aug 12, 2024 at 12:57:07PM +0000, Joe Damato wrote:
> > > From: Martin Karsten <mkarsten@uwaterloo.ca>
> > > 
> > > Setting prefer_busy_poll now leads to an effectively nonblocking
> > > iteration though napi_busy_loop, even when busy_poll_usecs is 0.
> > 
> > Hardcoding calls to the networking code from VFS code seems like
> > a bad idea.   Not that I disagree with the concept of disabling
> > interrupts during busy polling, but this needs a proper abstraction
> > through file_operations.
> 
> I don't understand what's going on with this patch set.  Is it just
> working around badly designed hardware?  NVMe is specified in a way that
> lets it be completely interruptless if the host is keeping up with the
> incoming completions from the device (ie the device will interrupt if a
> completion has been posted for N microseconds without being acknowledged).
> I assumed this was how network devices worked too, but I didn't check.

Thanks for taking a look. I'd kindly point you back to the cover
letter [1], which describes the purpose of the patch set in greater
detail.

At a high level: the networking stack has a mechanism for deferring
interrupts that was introduced in commit 6f8b12d661d0 ("net: napi:
add hard irqs deferral feature") and expanded upon in 7fd3253a7de6
("net: Introduce preferred busy-polling"). We are expanding the
existing mechanisms further so that when applications are busy
polling, IRQs are totally disabled.

While traditional NAPI does prevent IRQs from being re-enabled, it
runs in softIRQ context and only retrieves the available data at the
time NAPI poll runs. The kernel's pre-existing busy polling however,
lets the application drive packet processing (instead of NAPI). Busy
polling when used in combination with various options allowed user
applications to defer IRQs, but as we show in our cover letter it is
extremely difficult to pick the correct values for all traffic cases
at all times.

We are introducing an extension of the existing mechanism to allow
epoll-based busy poll applications to run more efficiently by
keeping IRQs disabled throughout the duration of successful busy
poll iterations.

- Joe

[1]: https://lore.kernel.org/netdev/20240812125717.413108-1-jdamato@fastly.com/

