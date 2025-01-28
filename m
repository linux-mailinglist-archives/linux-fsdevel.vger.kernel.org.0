Return-Path: <linux-fsdevel+bounces-40223-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D25CA20945
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 12:10:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA55F16919E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 11:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C3519F133;
	Tue, 28 Jan 2025 11:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="hUVWDsEh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53845192B96
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jan 2025 11:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738062618; cv=none; b=ZSdC75mFPSRS1iRDzLG13bzkdpSJSj+pOpGaplqhJvKKqlduqoL3ClW06R+cYO35pKdDGX6e9Sbg9kFvS29lv0EpyiYHMU4Xn2U1yYwiSJwkK5UT8OKmPi5YIVHZME31y7u6uo3ng3fk4SbRfgib4U0+j9LomiNwN/8y9Di9MZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738062618; c=relaxed/simple;
	bh=3oULPZbl6SYi+kh54HeGfCc84Epi14tEzErsX5vxNd4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nAqBQMeFYvuUOHOwPzBV48MI03N4I9fNX0Cud00lGHdnvo+FN+aBdXnNJBKnnl6NU/odTpWqdWSTNeOT0mKOsFa091rhcYIZp4e0pZ9zpiQTkWgy/ZT9NSQc7+E50NxxLFDYuc5IQrVOWP0qIvSuRfST5o+H8zmj9DbxyNZiPus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=hUVWDsEh; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-467b74a1754so75199641cf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jan 2025 03:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1738062615; x=1738667415; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aXfcJSbYIEXHvis+eDtYUcwI9MKzdFKCQdMTtghttUE=;
        b=hUVWDsEhvj48HfStvpvFykLEL4OJO6gBmNqPjat+H6Ed8VLlb3vdBHcnM4T+JPrgWr
         QdE/kABiD4qwLw9Bfx42v95un7Ui7qMGGeIBSoOcicflxFm4senGIkq5HQn2pHtuwC35
         SeIKrOWt/CzKh+AceuJHqx8v0rrZdevlsY5xI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738062615; x=1738667415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aXfcJSbYIEXHvis+eDtYUcwI9MKzdFKCQdMTtghttUE=;
        b=gUK74wVCGwsh5cKG8TJ2m1VkqYZOa0ev8Ra+s53Wa9E/S9hIGG6GYONqzIAEEEueri
         eD7jtX6+N9o6EcclbolTyQ6C5JcDb6zEJA8Y/sxcfqznqj6uHpSMOfgHPe8Rg6WsLNst
         Ws7K9MKwjHlQhcTVzRfgp2INs/WCVhOQFlwH4ugEMbidHzLT1PdU48cPB5608Xww6Ky4
         UcSovW54Xvj4bh5uIR10JoHxFrmuClmlVmCVLLgk/tend6m8ypRloPpsgjWwfOpkrVRg
         1AiL8GoOBWybe/tbpn5o3+D5knrWCKCLx56lKudYsjPJHnSaPe3NtF/CTC9Juxd0EWja
         YM5g==
X-Forwarded-Encrypted: i=1; AJvYcCVJNiKeREam//NUzvDa6Yi6g573iJM5Av5IgBJ4OBBYQMI/Nyfqfmu4qjXveBZPdtNpBO4v4BCWhECkZlof@vger.kernel.org
X-Gm-Message-State: AOJu0YwsCsx6CW4iP2HUSQUeqbWcjxZWXF7jikhcnKx42v0fHbWn+UVV
	mDWqyhISsKsSKDF1TFTTq89Kkf2VTUZ+MDD+FmWNs9Tf736gkjwbcOQKZgEPQ6KAVyFfpDAyo26
	nhsnYez8E/Paq/pjrwgfV3UWY1ByY0mAcZF1QeQ==
X-Gm-Gg: ASbGncuKcux+UOuTIuN4TkOhqm0liwAnFC90r5Lgflvcr8KR93wcbCNFTg5gTsstoXc
	MVdrAJOKcs7+WXxRK0tiIgsLCi/bx2JHWQ7rXlKiuZKEax6rWp4c8gl8aRrNtANsQixqr0tw=
X-Google-Smtp-Source: AGHT+IG0X5eZAjYfHNcC0rTaJ2o5BIVw20eNeFDkW5RJ6OIA73cZlJ5HaJWsBE9kPV6U1o+SVrDIyyD6osB7Qjok7bQ=
X-Received: by 2002:a05:622a:15c8:b0:45d:8be9:b0e6 with SMTP id
 d75a77b69052e-46e12bdc8bemr722253051cf.43.1738062614970; Tue, 28 Jan 2025
 03:10:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJnrk1ZCgff6ZWmqKzBXFq5uAEbms46OexA1axWS5v-PCZFqJg@mail.gmail.com>
In-Reply-To: <CAJnrk1ZCgff6ZWmqKzBXFq5uAEbms46OexA1axWS5v-PCZFqJg@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 28 Jan 2025 12:10:04 +0100
X-Gm-Features: AWEUYZlou_HSj_vIwGYfmdUvl5vdt3G3Z8bQbbfrklXlKMzbTqhlXB-VzrRMYdw
Message-ID: <CAJfpegsDkQL3-zP9dhMEYGmaQQ7STBgpLtkB3S=V2=PqDe9k-w@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Removing writeback temp pages in FUSE
To: Joanne Koong <joannelkoong@gmail.com>
Cc: lsf-pc@lists.linux-foundation.org, Shakeel Butt <shakeel.butt@linux.dev>, 
	David Hildenbrand <david@redhat.com>, Bernd Schubert <bernd.schubert@fastmail.fm>, Zi Yan <ziy@nvidia.com>, 
	Jingbo Xu <jefflexu@linux.alibaba.com>, Jeff Layton <jlayton@kernel.org>, 
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 27 Jan 2025 at 22:44, Joanne Koong <joannelkoong@gmail.com> wrote:
>
> Hi all,
>
> Recently, there was a long discussion upstream [1] on a patchset that
> removes temp pages when handling writeback in FUSE. Temp pages are the
> main bottleneck for write performance in FUSE and local benchmarks
> showed approximately a 20% and 45% improvement in throughput for 4K
> and 1M block size writes respectively when temp pages were removed.
> More information on how FUSE uses temp pages can be found here [2].
>
> In the discussion, there were concerns from mm regarding the
> possibility of untrusted malicious or buggy fuse servers never
> completing writeback, which would impede migration for those pages.
>
> It would be great to continue this discussion at LSF/MM and align on a
> solution that removes FUSE temp pages altogether while satisfying mm=E2=
=80=99s
> expectations for page migration. These are the most promising options
> so far:

This is more than just temp pages.  The same issue exists for
->readahead().  This needs to be approached from both directions.

This year I'll skip LSF but definitely interested in the discussion.
So I'll watch LWN for any updates :)

Thanks,
Miklos

