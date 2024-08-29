Return-Path: <linux-fsdevel+bounces-27778-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35114963E2E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 10:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF7811F215F1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 08:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8017C18A92C;
	Thu, 29 Aug 2024 08:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="aqQsQk0p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571B8189B82
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Aug 2024 08:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724919363; cv=none; b=JLtrKinTufUbJEBXNay5lUOr8N3ZTPQDYjBKdTLN9vioo7+kmr6Zl3rV21rgh556LVXzJwygEcpU4WGMFEG7JX9NqDEIkDdyo2r6FCgH0dCz3svAKRwCF/C40HYVQNavKYXoJOscwcNWSa3bEElZo9Br7ZFHURFm7Obc6xQy2N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724919363; c=relaxed/simple;
	bh=hgfPFlygVsmSFU8MWVbrkM+wiYsy1kjSdCReS4KohoQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dafwmh94AkFMOQTncJY8HjUnKGFx8dhFRWgH6MEzEF9cMHKar6vDMDud5DYURv82cXlmMPkySa6RWAj7TvecmCv/ckCxQFRxOppj7FmAoL2sHDMSZ+Vek3Z0lPUfy7NonFJd3LRqzp7jbV24TxDWCuRgWH1xbHgSkZUXluc5coc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=aqQsQk0p; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-53345dcd377so484584e87.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Aug 2024 01:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1724919360; x=1725524160; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hgfPFlygVsmSFU8MWVbrkM+wiYsy1kjSdCReS4KohoQ=;
        b=aqQsQk0p9Nab8BUKB75HE+esk41HM5t2XSaJumkuHRagsJCuwC1wty3l2nZYo0RGQh
         EkdyWy1j5nbcuGWm3jIugjK3xce7gPlKBe4zootSVCLUN6RSNzx7J7bCL24lABWoAQ1j
         xc6y0iYsxE2UMMNRXMTSJfkr6O5vb9zTVu/L0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724919360; x=1725524160;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hgfPFlygVsmSFU8MWVbrkM+wiYsy1kjSdCReS4KohoQ=;
        b=URGQqTZMaTw68bV76MzioTyta7AE7/p6xNJKpJlE6quKHCulgBzSGQuxxM1nVnGkO3
         L3BuAN7wHJKAO5soGK7Ao5bUkAulMEuHdpFj3gu5GuExDmtmcdQE1RujD6ccABnaElAj
         biqkHQY36ZBLaEVTCIR6qjaB9rtM6QcJHHQ0vFXTRnV5yLlQldZJ4iVazMYDFVGafJgs
         XTlOqiR9/87WddEvbLguTD6mqsdOjis+8aOFCbR8O9Iz177N9MbZviMCl9Jg3s+dX21b
         eow6tPgTJQPm5Py7HLWFzVv40eCtK3nmE3pbku7Ug5y3563DBQ8cDJZpTQUe/z7bBrYN
         DMdg==
X-Forwarded-Encrypted: i=1; AJvYcCW/8yk0/3DyVF8eDEKlUpF+IXqOTcyZNNDWVdiMfuk6xKeFreg8aSuCEs9XcNqUsfS1D3LZC1sZ9HM/L40E@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9Mya9DnhYKznwFA8SmI1OMA4EoMOo2AQBmkumt0BmFUDffHBj
	DlblQqDbStS7e26UlwBaiwmOAwSp2L30X3OJzTWmFGppjnsfXg2QxXP8U/vLqfriIHdi6UAsjAm
	4kOlgvxroJg6sFjd+HtN/rkZAuedC50J3NtZ1mQ==
X-Google-Smtp-Source: AGHT+IGWS0LzVgGYASD5Jl73txQdZXI+e7fJCODjI9BM0dxAVFMbrbV6HBv0du/zkBXGadfSyri58PzSUbwtmzXp02k=
X-Received: by 2002:a05:6512:b06:b0:533:4b38:3983 with SMTP id
 2adb3069b0e04-5353e54d9bamr1037899e87.20.1724919360260; Thu, 29 Aug 2024
 01:16:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240105152129.196824-1-aleksandr.mikhalitsyn@canonical.com>
 <20240105152129.196824-3-aleksandr.mikhalitsyn@canonical.com>
 <CAJfpegsttFdeZnahAFQS=jG_uaw6XMHFfw7WKgAhujLaNszcsw@mail.gmail.com> <CAEivzxc4=p63Wgp_i+J7YVw=LrKTt_HfC5fAL=vGT9AXjUgqaw@mail.gmail.com>
In-Reply-To: <CAEivzxc4=p63Wgp_i+J7YVw=LrKTt_HfC5fAL=vGT9AXjUgqaw@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 29 Aug 2024 10:15:48 +0200
Message-ID: <CAJfpegu2=ozU9LdceA+NP9gmaLFdx9TbhOAqAsN=1SNihu=PyA@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] fuse: use GFP_KERNEL_ACCOUNT for allocations in fuse_dev_alloc
To: Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc: mszeredi@redhat.com, Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>
Content-Type: text/plain; charset="UTF-8"

On Thu, 18 Jul 2024 at 12:01, Aleksandr Mikhalitsyn
<aleksandr.mikhalitsyn@canonical.com> wrote:

> I have also added Christian because he might be interested in
> accounting for struct super_block.

IMO doing it in the VFS as well makes much more sense than just the
fuse specific parts.

Thanks,
Miklos

