Return-Path: <linux-fsdevel+bounces-68281-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A89FC57FD9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 15:40:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E3F10351383
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 14:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E05CD2D027F;
	Thu, 13 Nov 2025 14:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="W3Oogu5w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5420D2C326F
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Nov 2025 14:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763044840; cv=none; b=c9X7HC+LKibJC60ux6aQlzRih/C6arGVkxupbBZh0rwpzgEp+xrBZr+t1dLcbo+C3V+BWiDeWIkelVoUMfEJmZJrtnjCJhBTgPwQ7PWS9H4LFczJb0XTDZ+SUpAd2PYCGdddQRRZK1I5pqzsYQIn43Db1KIe3nfRhoiUsHzw/Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763044840; c=relaxed/simple;
	bh=VbRVFaBWB4rkILZm2zCuNmafX52Xy/nu3FKLbgmlQ48=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iLZ9dFc14u+WL44sPjVo6VH2iGVrAMG8kaHAzIB7hLCJucznHBfdBoCwaV3cQYdpqA0TyJA5T1vx0pJOaIpQssdVgL0cJoywaReoIvI4XM8CY3LK7GCYbYBUAFtrwMNg9FF/LF+9ML2lBG6alxfN+g66sFqRIY8ncf4/ca09nCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=W3Oogu5w; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8909f01bd00so83542485a.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 13 Nov 2025 06:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1763044837; x=1763649637; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ovAtTKaxr5GwcIh+q2BgMMVUjUMk4h0Zw7PA7eiEv3s=;
        b=W3Oogu5wOA6dZvWwwd3HH0KiEkTqIOdb1ig4T6y36hhhbW49wApa/OSePCeny49G9B
         Zsk/qJBoaMxuzQd+kLim62MTjL6sKzezjRgpnW0T0DX1gsiyMbchFhrke5chUOxYHKZL
         F8nJAJ45HYNtiN98FQAdR9VZ+l4O1UIQceMJk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763044837; x=1763649637;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ovAtTKaxr5GwcIh+q2BgMMVUjUMk4h0Zw7PA7eiEv3s=;
        b=DJlV8lDrB9NGE+zQmEtAI6xwSGGRJVB3+TR4LuXoV8rKcz3DiNCeYNjG6pVeTlk1i5
         lBj+ra0r+LvmgkcZiHtthZnY5NhZPeiOQnCq7TssX7jNAVUS9A3amYGr1ooFTGG1qS4d
         oQQRed5gXfCwIB/srPZeDK57g4bvjk3m5ksrgzAWPDCnyEHUdO4gpTZPGhWfG2KN3L8X
         quOP7EQNaCZNO++W1xktd1f6OL8Kv64anBADbXRHEwIm72MTeX3Bw4W/TQ8t3dd5DdMS
         A1G3zazO5BEevWc8OthPSgKU/93aAnv86fYAchLXA1ffBD02GjmDawCdO7ZvPwfx25Rx
         qTOw==
X-Gm-Message-State: AOJu0YwVAmq8Oa6m9b6yw0iRORDxZy9lPy44Ph4dIfZP964cT7etM9ky
	AbyOH/V8od63tvLUxebPZB0c91y/0APDybBoD+oW30TKsp3aM+UepfS3Te1vUS5GilPoW+c6wC5
	6Q1dVzekGA9vdLsW54k54HZlu2VChrNOcDy9XMxXg4Os6JjFm0QbF
X-Gm-Gg: ASbGncvaYUJbQrPxMaKKke/qrrOd7J72GuBJHlr3QFoqQcbtVvQkrVj9WcKfMCAQfJ8
	82bT91O+bmNItwGAVvbCLvaU0r1l6/AAjJDdJ10xaLyVNUeoLhKe/xyNRDXwTZ6ZOwm7G9FplS5
	0jgTFJCp9sNk4tXfuhCi6qppByqG1N9VEi7olBaAuZT117yD+qcU6V7kOfVOBPjylxQib1YbzM2
	uXlZ0SID9wN9J9B0TTl6K6y79IfiCu2AqbLNO19u6FYxCOtAgDRNqZxi0m8
X-Google-Smtp-Source: AGHT+IFJVHQ0Av3VsiDkj/7uY6vEjvy5/QQNVO5m8sXzNzFqEXXgmrZOrHRR/22Jk+KT1zvUOtzHptC7jIHtdh3v3uM=
X-Received: by 2002:a05:620a:4115:b0:8b2:6538:6b64 with SMTP id
 af79cd13be357-8b29b7cd2c8mr903091385a.45.1763044837016; Thu, 13 Nov 2025
 06:40:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023-fix-fopen-direct-io-post-invalidation-v1-0-3f93a411cd00@ddn.com>
In-Reply-To: <20251023-fix-fopen-direct-io-post-invalidation-v1-0-3f93a411cd00@ddn.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 13 Nov 2025 15:40:25 +0100
X-Gm-Features: AWmQ_bmrPnfTGdz33qlltYlCDFktQeg4dpVhIxqtwwtlX9wpXHAB7xC6MHAlA98
Message-ID: <CAJfpegsL2BiUnK+8a-rRE8gc8i=8SYY1KoiTiadKtscOVmgUZw@mail.gmail.com>
Subject: Re: [PATCH 0/2] fuse: Avoid reading stale page cache after competing
 DIO write
To: Bernd Schubert <bschubert@ddn.com>
Cc: linux-fsdevel@vger.kernel.org, Hao Xu <howeyxu@tencent.com>, 
	Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 23 Oct 2025 at 00:21, Bernd Schubert <bschubert@ddn.com> wrote:
>
> This is for FOPEN_DIRECT_IO only and and fixes xfstests generic/209,
> which tests direct-io and competing read-ahead.

This is stable material right?

> Also modified is the page cache invalidation before the write, the
> condition on allow_mmap is removed, as file might be opened multiple
> times - with and without FOPEN_DIRECT_IO.

I don't think the mixed use was considered previously and probably no
filesystem does this without NOTIFY_INVAL_INODE in between.   But I
agree that this is the correct thing to do.

I guess these are unlikely to have any performance impacts in the no
cached pages case, but maybe we should check?

Thanks,
Miklos

