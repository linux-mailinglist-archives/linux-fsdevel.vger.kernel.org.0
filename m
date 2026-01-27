Return-Path: <linux-fsdevel+bounces-75593-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cNTKIpOfeGn4rQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75593-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 12:20:51 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1813493840
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 12:20:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B2988305A4A6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 11:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEBD83469FE;
	Tue, 27 Jan 2026 11:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RsSpRvLN";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="UK2vLTiN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A8730EF68
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jan 2026 11:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769512728; cv=pass; b=bh0k0hBSpG7eMENMuHY3EwuzXNC8oMthNTmFlVw8wOYBkHizrW87ApLtjK+u4NQw/eW2JB2XMHWnK57fW4zunLbkrFF3jGUv252qlUbsM3Uc54xBcl0RMXGaKMa90187NyPeD4fBqHbyl0EWxDPdVvV8OUiVaAuX5VWzJggsazQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769512728; c=relaxed/simple;
	bh=bIQKEAqon/zvS3zMBpN1jKOsEnXnkrzCIWz6Jl30sgs=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J3QqqCKCieK4VPpmzKVy0gE2/4xRK16Ljj8/TPlsIZHurf3+EnOn/TkG8182X9FbyxGEc8uAvslz7poAXfgaMZv/lFXy2CXF+R3G3h27+AFb6ioflJyn5dVtTG5Bhi3/y1oyB6JSGo2GwZvWRSyN1gyNguA4IYX92sTfILoMZg8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RsSpRvLN; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=UK2vLTiN; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769512726;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bIQKEAqon/zvS3zMBpN1jKOsEnXnkrzCIWz6Jl30sgs=;
	b=RsSpRvLNbQceO5VUvAk8G9w0qmnQe8YTO+Eb9eJiBkmEHTrrvM8H83owofgyTtbrVLrUMD
	NN3fOoVg9mwI6KQW6rH4P9w1Yln3uYBT9ln/Ce4X2GURxgKamO0IRxJVbpCcSHP8ZRSXZU
	Y7BkfZgbIhxhYQwE960qjYqEoTj/lyM=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-YVz-QoTVNgahcBY9Tl2RUg-1; Tue, 27 Jan 2026 06:18:44 -0500
X-MC-Unique: YVz-QoTVNgahcBY9Tl2RUg-1
X-Mimecast-MFC-AGG-ID: YVz-QoTVNgahcBY9Tl2RUg_1769512724
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-79477dab067so8768137b3.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jan 2026 03:18:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769512724; cv=none;
        d=google.com; s=arc-20240605;
        b=HwrzoNSHyEETwuF6DLQ5Ic43i9KTbWD+MxrjIWKNgGN9avvP+RpSvmGg3Cklg7UVkb
         4gSRGp3IOm3VrPrhH5QA7cLBmRuh0Ent0HA+NkCyn2TFENC9GhEA/kr71RG7zOrOf8yo
         B+ZiYZpudjrP48kRVq1C3OC5tLghlguVYDCYnk3MKTfOrbVFcItc9JesKMWRAPJgLwqy
         AbSlBMk8V2pH7qMD5JQLlwNZE1F4leTDj7128Pu8/w5n2eGP5438AzomchY4IbKG9uRx
         nk8muuR7lyECfDkuFpNqeDWMhQ7+p+bKExLlIbt/UffsDR9K1T5gj73bSxRH3CUhUARp
         rpvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=bIQKEAqon/zvS3zMBpN1jKOsEnXnkrzCIWz6Jl30sgs=;
        fh=2qLuJfwpgjDTygTgFp3duqMTE9Wc89CtOnpWN7gi9k0=;
        b=ZgQPEtNdyreUKVaFJarv3WfyJU/btXTpIWM7wP5shS0zmtZkOtNfbMrrqlKQwHG1AO
         Y+dizFjUY2qQvqPCN6p05dt12pJ4qEVaQy9ijdUkMzT4Wl9wlDBY3Gd7yJhA12FAF6kQ
         /GcomNLtgk6+tHqe98pi2Sm3WgvWukXQZHFuudOcU+T4gzXL6kYyzIGzxv9KquWcT6oa
         Cnu5MCYbKgmkMmYtDxiWH76x7Mtox2kIjZizjpHHzIlBIO9y0NOpeFZtNfx21xACKnU4
         15WcnxUipUf770ZXPAX63xcMmxVyUNFbgJ6BY6d2sSrBRyb/OZ8eB/lGHO6U9RhkoFLI
         cywg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769512724; x=1770117524; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=bIQKEAqon/zvS3zMBpN1jKOsEnXnkrzCIWz6Jl30sgs=;
        b=UK2vLTiN8sqNlJUAUA016saT6xrZBJlqqGe7DKRJds5LQHee0M6skD/w9yHviOne23
         JAy35TWvMT3T3N0GdEC3EuApWCxJ3spI6LJhkBP59mJ3EI1n5CbWurKW18Hq5lVSTMwt
         C95SkiZOrm7ZjM6s07Plfkxqlal6x3FxqgSty1MduRE2G5XUHDuYy3uttt95FixjLIe5
         sPeLydW6q/gk5v3PuTb6vyQ9gcn0PTQK4Ksn4zTDZp77SYSQHdHHYR1hFYr11Lfg0YZv
         4ZL9nRCi6tm3m/soORU4KeT6SrpqRNq6sDjUR09QtVPx7EKnlgIdalre88DhjeP6yB1p
         TDCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769512724; x=1770117524;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bIQKEAqon/zvS3zMBpN1jKOsEnXnkrzCIWz6Jl30sgs=;
        b=czNpWHZl3WkvKSz2bNrLBjj32pXrd1iQQPUNpdcHyjL+czpvLA0Io21O3if7ExzzgE
         KGg9+DAfXQn3ZwamI5ESBIkR3U7M9GSy0wlF3657dZ033RRlJ3FgS1dJlzMPJxihnOKJ
         LhwnBaI9JbOay+RwyKMMNPN0IT1yTyexKSuQNpthLcxSXU9Ist3k3ytw2LErGzKg9cr8
         rk9RLztAYkvVgiW5XJiTcgdjfE56PxBEJN67RShZKo9v4B9fnCKoZFGCpzIJjg1jdTQW
         7N1oF5x4XbPrJBaRfF51Pie4HoUk0vvFt5JjLGQhuyev1gyYX+iQz8CRTVwxjpBDcFQC
         YCuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdEIx+dDjYwADKR8LfSqdspkEg+c4s7iDkchWN9DYuQQA+TT/OXZ2lAP0wWnZYF3zBn9yBI/AbzhKYZ6cP@vger.kernel.org
X-Gm-Message-State: AOJu0YyaZ8NMh8OVcBVe8OFfHPFQrYjs+0kcsEwX9aj9e/OhOVcaJ4Wt
	X/cFV9Gt6MyDaOPxzW3CnkVIQnO9vfUCwYPavq3b8itrWj5kLfCT4PPxFPf6i6Wd85xZMXxy3fs
	Eh0QEBEkFCLJIn8snuy68VzA+kGkOxbK5jVapHxJ8LGim53hgSDQQy8YGqgfFkKnaHkTUw45A7i
	mqGYP/+Ih2jR0Dc1fruN5ZSloxEeoUrIWXZdUHsjfQYQ==
X-Gm-Gg: AZuq6aLYBVeMhRVIKa/AStv36YsQAU0Z+XcY4F+kLa+RPgrbVXf07HNssaK4yiTgMzw
	Js2aej/Qe/cwajS8rHmksU3pupbzNR2rk5zkBVRJBa0SVFTUDVRUm6gFbLMHcb66WVJ26tlzRb9
	5GwjWWqJOK5YMkpY3ah6UshbrY52wQQj0kcD3WSU4WzGgSrK1jmLPRTkgnSNQmwy/Z
X-Received: by 2002:a05:690c:93:b0:786:4fd5:e5c8 with SMTP id 00721157ae682-7947ac4c8bfmr9015407b3.57.1769512724160;
        Tue, 27 Jan 2026 03:18:44 -0800 (PST)
X-Received: by 2002:a05:690c:93:b0:786:4fd5:e5c8 with SMTP id
 00721157ae682-7947ac4c8bfmr9015307b3.57.1769512723820; Tue, 27 Jan 2026
 03:18:43 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 27 Jan 2026 05:18:41 -0600
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 27 Jan 2026 05:18:41 -0600
From: Sergio Lopez Pascual <slp@redhat.com>
In-Reply-To: <5a9bdacc-a385-474e-9328-6ff217f6916b@linux.alibaba.com>
References: <20260118232411.536710-1-slp@redhat.com> <20260126184015.GC5900@frogsfrogsfrogs>
 <5a9bdacc-a385-474e-9328-6ff217f6916b@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 27 Jan 2026 05:18:41 -0600
X-Gm-Features: AZwV_QjnoV5I44yowk4t8pgklpVBjUYUkpdWar45U56FrM2EZwHLLN7RE27Cq04
Message-ID: <CAAiTLFULeJw2y53dM2QqDqHv2ycD8rZmptVX7yRML0_XVneY=g@mail.gmail.com>
Subject: Re: [PATCH] fuse: mark DAX inode releases as blocking
To: Jingbo Xu <jefflexu@linux.alibaba.com>, "Darrick J. Wong" <djwong@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-75593-lists,linux-fsdevel=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[slp@redhat.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 1813493840
X-Rspamd-Action: no action

Jingbo Xu <jefflexu@linux.alibaba.com> writes:

> On 1/27/26 2:40 AM, Darrick J. Wong wrote:
>
>> I wonder if fuse ought to grow the ability to whine when something is
>> trying to issue a synchronous fuse command while running in a command
>> queue completion context (aka the worker threads) but I don't know how
>> difficult that would *really* be.
>
> I had also observed similar issue where the FUSE daemon thread is
> hanging in:
>
> request_wait_answer
> fuse_simple_request
> fuse_flush_times
> fuse write_inode
> writeback_single_inode
> write_inode_now
> fuse_release
> _fput
>
> At that time I had no idea how FUSE daemon thread could trigger fuse
> file release and thus I didn't dive into this further...
>
> I think commit 26e5c67deb2e ("fuse: fix livelock in synchronous file put
> from fuseblk workers") is not adequate in this case, as the commit only
> makes FUSE_RELEASE request asynchronously, while in this case the daemon
> thread can wait for FUSE_WRITE and FUSE_SETATTR.
>
> Maybe the very first entry i.e. fuse_release() needs to be executed in
> an asynchronous context (e.g. workqueue)...

Do you have the rest of the stacktrace? We need to know if it's running
in the context of the worker thread, as otherwise it must be a different
problem.

Thanks,
Sergio.


