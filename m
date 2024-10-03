Return-Path: <linux-fsdevel+bounces-30892-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F9498F159
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 16:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B13CB22572
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 14:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3E01547DA;
	Thu,  3 Oct 2024 14:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="eeCI0hWJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7233C19E976
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Oct 2024 14:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727965583; cv=none; b=aGd4U+WkllTDoiJcHk2Ii/rXT6B0XMMDfTg5OxTcAfFI28HTMiRPggaGWMzCB8MPubovSVqRfN9mQBRdopMdXWUwVr5gT4xMfFh1UjakYnMm99dnCQLE7pTHAHow31cfGYCPH8Qizns8wRQfgOb2hrPUF8KICW1YeZhFRYGhLLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727965583; c=relaxed/simple;
	bh=dUaDgP7B0z3zVdaJWcGHrmG2eAunyVlQe8sce5zFQAo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N+JgsnD0O6gFmfsHzSF/2e1pbUejCLbp9FNQhhWIhk0ctz9lHI/C+cLf8fwyrMciqzsNn2otKT7O9XdBfb6x9lxxV8o1/d6+fPMcEQn7hv8GrGAHrfHCpYYnTHbjMm7umNNjkOvFWz38euARU1WTwvibptDRg4LzadzKdUTc0Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=eeCI0hWJ; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-53991d05416so1261080e87.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Oct 2024 07:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1727965580; x=1728570380; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kgL+ZRVrAJ1YZuTAwAP07K+beors5kOGujJ0YGeFmC0=;
        b=eeCI0hWJ7srpnAdiXiywS14DV2PtiRVa4nXkmSe2Mh58DIDFltjXGTB9DYMPG/c1as
         YgZEcQ7bYAV/bJLmidujlCLZjwZQ59DxQacIjRLoA0QIRmvk9FnXdK2I1boNqWEPq9vl
         48aJrxHKQAqXi/10c8sc/dTFYCM9Mnxkz0mMs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727965580; x=1728570380;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kgL+ZRVrAJ1YZuTAwAP07K+beors5kOGujJ0YGeFmC0=;
        b=Qlx/o4mwn5QN5VXRS4fqoaMZ5vXgqMJLC8x3yvJntV/aEYjfxEYmWURgNs+fSNKVq2
         vl3+6Zxt5opj1rb8FGKcrpJJoTjAY+MsIOVyCv9tXEjcyHeb910LpUlT2M3oNiaKjDFW
         dn+Bgsl8tKyKHLapxb1M2HENKGcU8WYGvu+0wE47Cy0s8xZPgaLhqd2bvkVVO/hMAxTI
         ejqbXTUghZmx8wg7+LfsllHb/Y0o5QltNFcOJCKYJWZ7+8bMnmeJeu3xrdSm3NtPfX3H
         11F9Kuod2eH+SwVVAMSczLPpSeVe+HmmNd2Y/RWfxJ/aNhumtLkSnHnglnRWvV8A6FR5
         Y9rg==
X-Gm-Message-State: AOJu0YyZxeRex/i1y564qCWv9ZIfrW+5EVbCG6D51c/Gr3UJ+T0Qc77h
	gtXfMJfglpNCMgh0lbE46pNgwWQZsZO6Rjnha69M/8ifkBgeg5Re3MSySJlrb6vtMly6FN7Whuw
	0YwGXM/LTcaHINTyo39zhX9xcx26I+D8LUak6QA==
X-Google-Smtp-Source: AGHT+IEfTRocBLwXbkEs+wM4qIxCFdpEdZLUIQ6bA8a7yuw3Siu9wjhWgUs2mjLIGHmzzJWstx0lj9msmNrLFPnEZ9E=
X-Received: by 2002:a05:6512:15a9:b0:52e:fa5f:b6a7 with SMTP id
 2adb3069b0e04-539a0662b84mr6133796e87.13.1727965579644; Thu, 03 Oct 2024
 07:26:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e3a4e7a8-a40f-495f-9c7c-1f296c306a35@fastmail.fm>
 <CAJfpegsCXix+vVRp0O6bxXgwKeq11tU655pk9kjHN85WzWTpWA@mail.gmail.com>
 <813548b9-efd7-40d9-994f-20347071e7b6@fastmail.fm> <CAJfpegtazfLLV9FoeUzSMbN3SoVoA6XfcHmOrMZnVMKxbRs0hQ@mail.gmail.com>
 <c2346ef4-7cf1-412a-982c-cf961aa8c433@fastmail.fm> <a97070c4-c3ec-4545-bff5-496db3c9e967@fastmail.fm>
 <CAJfpegvK2+Q=L4hM5o0fZPuJc-zkCwZHj2EcLXFFEq__sPmXgQ@mail.gmail.com>
 <CAJfpegtpCdGPN=X1_58bpD9eBnnK1gCBKTkGsRqn7cK3wJzk8g@mail.gmail.com> <e75d6df7-d39b-4186-b319-08b3d1207712@fastmail.fm>
In-Reply-To: <e75d6df7-d39b-4186-b319-08b3d1207712@fastmail.fm>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 3 Oct 2024 16:26:08 +0200
Message-ID: <CAJfpegu_UQ1BNp0UDHeOZFWwUoXbJ_LP4W=o+UX6MB3DsJbH8g@mail.gmail.com>
Subject: Re: fuse-io-uring: We need to keep the tag/index
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, Joanne Koong <joannelkoong@gmail.com>, 
	Josef Bacik <josef@toxicpanda.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 3 Oct 2024 at 16:09, Bernd Schubert <bernd.schubert@fastmail.fm> wrote:

> Well, we need to search - either rbtree or xarray, please not the
> existing request_find() with a list search - totally unsuitable for
> large number of requests in fly (think of a ring with 32768 entries).
> I.e. that points to not using req->unique, but own own index.

Even then it won't add a significant overhead (that's a tight loop
with ~128 iterations, with likely everything in cache).

But I won't stop you from trying to improve this, if you can justify a
separate index with some great performance numbers, then I'll accept
that.  I just think it's unlikely to be the case.

Thanks,
Miklos

