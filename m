Return-Path: <linux-fsdevel+bounces-25744-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4968A94FB32
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 03:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CB181C21B66
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2024 01:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B8C58F5A;
	Tue, 13 Aug 2024 01:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mqH1/MQD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1186FC5;
	Tue, 13 Aug 2024 01:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723513338; cv=none; b=rVGI2a0MYXXoESYEJXOx2w6miBfV3+Uir/rppB1uU9W+aGz6VXE/ubO3qedc8h/Q2eqrxID2sFLjLHzcMMv6k8qXj8xR8g0TiZs9VGWLi2wrTwQe9zYu8K61ZQAtVxZPVk5Bn15AsQTrzedV1VPazqskg6jjhpAVENkbF+UTrp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723513338; c=relaxed/simple;
	bh=G5AkxutU2DOYGwO0lVd7hWxl3Aq0SOimEzSb/j2VCVM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=urUmgPFX8yDuMF5fKPP8C8wXr1RFedhnIB3jcNXUGEaZwSNL6AIjEdz2w9skwPkLyzWyp2kweklL+tyy/fx46XfyOf3/Zk6QSezTr4KfA7xzC1Ei+pxcz8ep/JKH/u7NJhUzjXRFUaFWtGq9auQD2r4cpC8FKuhXcOFdagSuyxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mqH1/MQD; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7a1d81dc0beso321307385a.2;
        Mon, 12 Aug 2024 18:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723513336; x=1724118136; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Ww2OO5tIPyL84Y0z6LseSJ0bYuPP8GrV/a/JIqWeQI=;
        b=mqH1/MQDKuKAEDojCpW5thRaQ853zykXDDcbVckv5pqa6DqE26vchvsVocgU/+JI2V
         Gl2i6y8w1wc419cIdjXAOqixzPlhRzO1WH40JMGopz9dAtWh+rIgLfOKShXVALAg30Id
         8pyLBTurpN984CHXvS2QCYuujVqsC6agUi6lexlmRpL3MiwEdtwUwOsLce2hW9n6yJoh
         Llzt01I8I/JxCQGUVUhkFI35W8woV8XoCXjIYRtS+OFB0U6hOpLKcFz+ew6VPvgtDBDO
         2qREnMgpldSgjiB/mo49xyyMk735kAA7uvva7uVZ2IeAwKraZvEBSJruBV+0DUghI1Tk
         5/Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723513336; x=1724118136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Ww2OO5tIPyL84Y0z6LseSJ0bYuPP8GrV/a/JIqWeQI=;
        b=k26QoJO8nc+Agg4rqv6fsCDmuEE5gOEak6wrm+91k9I3xzVOK3NO1+nZqZZn52Ktvd
         mmvWz8nhkKXda/qx5kTDYWpKcq5voBxzzDRjjoZ5ezAubELhO9+wKVDRlILPtVMFJMuO
         GgpKdijhZ5wAU6NSeGah1VW2GLHkObQze0cNMGXxXDcGWdj9zfwYz0YWeW9Xam+ocNZf
         K3s7W8h1u7LFwGOziB9P0r+xT+OmlQKwbsXEH/GPAoQuj+lohsHGtBiJdPBjXC1gtLx0
         TWMpXivIODBFZlhUEo/ZUh5TJGN+l+URIKLLV9JOhF2XQIQ98iyEaWDNBY1w+96w37yo
         H+eg==
X-Forwarded-Encrypted: i=1; AJvYcCU01k+wevaJMSYthnP3ED2U9rU9xX7MvJjGPf8OtOM/jCtW5IjevKuf86GB817ML0ZJC78kbq2/aKHGfjwDf85I9sVVDWdkFNL3ra9hJqFw0L4TcFKd51WZnMDNYDRuutPcnOpn1NsPmDv2JA==
X-Gm-Message-State: AOJu0YyO1WU5Ep79r48VrLWs05RY7k5V3sbjRUDlUUcaLMzYRMojx2St
	d6OwZYwR+dVvyH8f8OjbVOmmjbKM8d273GYoaXBbKH1JUYmk5TcJsJu4YjRFo2lpHMOUjnMBesh
	9z2nCxzPda+X41tdOb3kqs/tQVlU=
X-Google-Smtp-Source: AGHT+IGwmaJlr8xdDaiIiNrLMAwDn/PMzcx3oDMrDlcLdedRjCD/dH2JscLrU8H71vFcEJQsNWm/NiFErxjS5KXJXmE=
X-Received: by 2002:a05:620a:6404:b0:79e:ff5a:2da4 with SMTP id
 af79cd13be357-7a4e15ce3fcmr218932285a.66.1723513336167; Mon, 12 Aug 2024
 18:42:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808063648.255732-1-dongliang.cui@unisoc.com> <Zrn622M2F1x-fH3n@infradead.org>
In-Reply-To: <Zrn622M2F1x-fH3n@infradead.org>
From: dongliang cui <cuidongliang390@gmail.com>
Date: Tue, 13 Aug 2024 09:42:05 +0800
Message-ID: <CAPqOJe0shhTkZN=ybpQP_h79BYACKdAzipxS4Q=1PAB6H1hZBA@mail.gmail.com>
Subject: Re: [PATCH v4] exfat: check disk status during buffer write
To: Christoph Hellwig <hch@infradead.org>
Cc: Dongliang Cui <dongliang.cui@unisoc.com>, linkinjeon@kernel.org, sj1557.seo@samsung.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	niuzhiguo84@gmail.com, hao_hao.wang@unisoc.com, ke.wang@unisoc.com, 
	Zhiguo Niu <zhiguo.niu@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 8:06=E2=80=AFPM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> > Apart from generic/622, all other shutdown-related cases can pass.
> >
> > generic/622 fails the test after the shutdown ioctl implementation, but
> > when it's not implemented, this case will be skipped.
> >
> > This case designed to test the lazytime mount option, based on the test
> > results, it appears that the atime and ctime of files cannot be
> > synchronized to the disk through interfaces such as sync or fsync.
> > It seems that it has little to do with the implementation of shutdown
> > itself.
> >
> > If you need detailed information about generic/622, I can upload it.
>
> generic/622 tests that file systems implement at least lazytime
> semantics.  If exfat fails that it probably has timestamp handling
> issue which are unrelated to the shutdown support, but which are only
> exposed by this test that requires shutdown support.  It would be great
> if someone could look into that, but that's not a precondition for
> your patch.
>
Thank you for your help. I will pay attention to the timestamp issue later.

