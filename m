Return-Path: <linux-fsdevel+bounces-26481-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF85959FE1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 16:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F5851C226E2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2024 14:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C7511B3B3D;
	Wed, 21 Aug 2024 14:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="QgHYXfZG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7AE1B5301
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2024 14:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724250524; cv=none; b=iz3b1T9BpBmubtNrMNkxxbd7qbhou0j5Ou1A+AZYk8avQb34IggdDV1i26GvzHafiQaun6LFKZsyEPxrGvd38+cgpd+lzeLRGjxGMz1+nhbN7hKUE2K8BIgjPzbSw1POMJi8cynlv2BEdxzRlB0ZzRCgUkxMqIryXZ0kI56i9jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724250524; c=relaxed/simple;
	bh=0usleXSjtqWB3cCO9177/ecHC+tSdMcbeJ2QL/I7BUI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N6SKui3n7vxfedBY6dpQhgcg/SRjS8qfE0DGRfsWjt6s/AzTpkJEp4dpaVHGEzXtKvHYIBvqaEZMOyujzqde2pZzEF/mAUKxlb+qralww+oMzlQgsmG1GUrOM/+vwuSmBqGu7GJ/Y7pUsRhD8Ehl6OTG+XGap9gejbXuz0/IFPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=QgHYXfZG; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a83597ce5beso144797966b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2024 07:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1724250520; x=1724855320; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0usleXSjtqWB3cCO9177/ecHC+tSdMcbeJ2QL/I7BUI=;
        b=QgHYXfZGbB3IFxBdSAc/tkLivmTn9r/QyaHkImcwDmsZNJmaXVi1XLU5OzhUtWBziM
         x2I2N5TsFY+Y63FWtIagZRLhVWYDWWRtaNPl1ETPc2klXCfGjhX+DMlsUsR0f3dHRkzi
         iBXEkBScv+zdbiWZUnIsweVdjLiiYU1jZmKdU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724250520; x=1724855320;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0usleXSjtqWB3cCO9177/ecHC+tSdMcbeJ2QL/I7BUI=;
        b=ppKscbw2AcYSy3zjRMHtglJaXbo6ts4p/TLifasFejhCxFN0D6vBZGzqum43YV6o9D
         4zDg28hQjvCFv+y19Ch7rsd26Q+cbUU1d41kCGCyA23U8Ia52iIddGfSxDUI6bd9uRXP
         /Yd3CDR36VtZnAoxDCwLpLhMbtTSzb706yEbUEmTeEUMvmcTS1YrPCBrKluhRz2GBxkG
         Kov3ko7s9qrjS8Cz3MQBotM11ZZZyW+7+SJHNjNcSiQKgEs/3bLRMLDUMVSat+RpcA8q
         EiEfqQK0a/7YCfsRFpTveord+pwns9eQWrdcSmbo29GL5pVFALr10eUc7ewqqztpCRhp
         7Klw==
X-Gm-Message-State: AOJu0YzdDbZErbaCHvF8iTjZdU0rsDEctKsmWWm4dZmAyfdNIRAdoLz4
	+2UwScQGuDt1wbhqIfmrZngH4gqX2aQwXLbJHQ9OIdSvut/O0iJI2WtCsq+gcxHbDuQpjNhEjIt
	4S3mIMFk+9hrgyg/WkEGJ3w8yurwLCY8rI74DeQ==
X-Google-Smtp-Source: AGHT+IEMSkPUwVbhP6KLl2OaW1JgeiMJcEo5tXaQvHUmQLXRie2wkW1EAaSlCPATtfgoiGvSz8wl4ROOl/OHOcY9Lgo=
X-Received: by 2002:a17:907:97d3:b0:a77:ce4c:8c9c with SMTP id
 a640c23a62f3a-a866ff4b56bmr226808466b.8.1724250520207; Wed, 21 Aug 2024
 07:28:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240820211735.2098951-1-bschubert@ddn.com>
In-Reply-To: <20240820211735.2098951-1-bschubert@ddn.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 21 Aug 2024 16:28:28 +0200
Message-ID: <CAJfpegvdXpkaxL9sdDCE=MePdDDoLVGfLsJrTafk=9L1iSQ0vg@mail.gmail.com>
Subject: Re: [PATCH] fuse: Add open-gettr for fuse-file-open
To: Bernd Schubert <bschubert@ddn.com>
Cc: linux-fsdevel@vger.kernel.org, bernd.schubert@fastmail.fm, 
	josef@toxicpanda.com, joannelkoong@gmail.com, jefflexu@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 20 Aug 2024 at 23:18, Bernd Schubert <bschubert@ddn.com> wrote:
>
> This is to update attributes on open to achieve close-to-open
> coherency even if an inode has a attribute cache timeout.
>
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
>
> ---
> libfuse patch:
> https://github.com/libfuse/libfuse/pull/1020
> (FUSE_OPENDIR_GETATTR still missing at time of writing)
>
> Note: This does not make use of existing atomic-open patches
> as these are more complex than two new opcodes for open-getattr.

The format of the requests would be very similar to the atomic open ones, right?

Thanks,
Miklos

