Return-Path: <linux-fsdevel+bounces-65061-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EDFEBFA7CA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 09:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB4AA567144
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 07:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B3D32F5498;
	Wed, 22 Oct 2025 07:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="COLcNWdn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3792F39B1
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Oct 2025 07:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761117232; cv=none; b=B8SIRDFRCNv5pa+rLZO3n61HunFHVoP7vl0S+LqGCyeT3VmRHYNNXrToLsKsLQ+hoG6Oe+k66XVcT6q0YtDuVBVbu4AQ5A0pT3fpdrxBP+SO51hP4IuaRwCqDM4/5z8FbfQ7ENk1Jp0NKl6MoswJku9/IUiyVutEEM1AA0iI8QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761117232; c=relaxed/simple;
	bh=GFk25FyWkR2PK2GtgENMZnxIVRPhxbKh6/48P/XqkdI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mMEORkyvAUALumkHd70EBUC6wMYQndsZRh//bC4vjdK+msfNF+PeReVm7KztrmgAOWUnfryCRKMoaznMPlC9l9zSACq0ZV96qeosk+MIHTSqmifzlGrWE7OCOk0/8oZnciVhqy1yKM1f23BT4uzPLh2HWEX7C9ul+0AfElE5owQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=COLcNWdn; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-63c1413dbeeso10302967a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Oct 2025 00:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1761117227; x=1761722027; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Y9zwPnIO3NVOP/cmDlK60nRyQdcjIpG1DboYa2VeDdU=;
        b=COLcNWdnwI0b5sEGt/LYp+rk0hugU/i818wCTPcodoa6ZdaJFmVj2BlFLQbQ2lokcL
         +2AsaZ/+VACu0QyhTwkegzIMEaAWxlXVwqjcnMY5wAYMFAG8sH/ziV48hSSaWsalaEje
         Ie8LKe36OztylFBf8nIlGQR37zy2ONnU6SK8g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761117227; x=1761722027;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y9zwPnIO3NVOP/cmDlK60nRyQdcjIpG1DboYa2VeDdU=;
        b=t9+Z+Zqss2Nq7ZqIrvBxwaxkfyQLqI7f9VHi0xkYUP56IhO4MfljxV0KyNNI+9Ps1l
         wp0nouSK/+pH2z/4IW9CaOGrJCWRxLq7DEpDQaSf6ZuNaLZdcQ0WynnbeCGI5Y1PXUSh
         YgZ63y0TvcXPuMH8NzL0UFmSWijkn5Fg6K/N0GyrANd9imKdi8UkJSVUWIYle4G74uU6
         OYgADTLu3W0Bw2IxIiRKQfc8wPYexcA5Nc4i3Pd+aft8Pr2XSqPaArRSp2aidbqwMxEQ
         u0GY42PO4EnJ7WFvci3D9EVHpNQom6vvNQbWvitoH36qVOvdHW4gjOALcGYSQh0J//cm
         A07A==
X-Forwarded-Encrypted: i=1; AJvYcCW/X/TWcy6XGXMwzKUGtSmPXajyiLDEDVfABrwXYNYBCyXqBMVP646WqulJITDDTmGjzb7kvI3AtrNlnyl4@vger.kernel.org
X-Gm-Message-State: AOJu0YzYwVqXQXK3xxHS3FgK0Kdzo+Dkmp4tBtTeAmGk7TwgLAIw/ZeW
	de71eOfcXqRk9osOSRMD2CfSdtmX6PL1Ebnpl9YG9iuqQr+sl4X/7WjgYRaHY+HIF5zoHWuo76L
	9mOcsLH2tHA==
X-Gm-Gg: ASbGncseTKktFE7hVcUOR/EXqk7dsLjrCx6jR8bVOQZRTmWOy0wnrb1CeGoAY8kbhzt
	6AIvKnutE24QIJiyJFIp47I9ncHJtIDfh6XcPyVeOMcluaTxW+dWch08kkLm+9mQrN8ipyZe33L
	O6+3ZT3wzz/u8I+i8CvnsvPV+XdYwtzaU/uZM0GMVcfIVyD79EW7OCAOXp3MZWILzo5jDyL5K91
	sUBDfHcjx2Ds631zzduQgn2634HoJmGbp8XiwsecHB7hU+JbIchVkQ4l6wTK0m3zt9mu4nnhswK
	vXFp3fFwiJ5voHdZZIl/iILKOmRT8Nw2ZJGnxf9/PQEhn42GvphnHdM9ZtISM2jdn9wdWPVehr1
	I0DKs7u0TczjXSFlKovKlFc9PSQBsGC4xBtX4aEnR1mYxdF6EtXw7uqDDKqWE+SWBwX1jLJQLWF
	GJgJ/uItSepfMKIyDYuLsAG63Z1NjRTkT7F58PHGBW6XoxhTWXqg==
X-Google-Smtp-Source: AGHT+IEnTzbsmuFwx1g5/K191EOpufPTiK/uHUhtQq1HstSP+wF8R0/m5T6idupO7CiNnErr+t/azg==
X-Received: by 2002:a05:6402:d09:b0:638:d495:50a7 with SMTP id 4fb4d7f45d1cf-63c1f636794mr19846210a12.16.1761117226895;
        Wed, 22 Oct 2025 00:13:46 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63c4943015bsm11387913a12.21.2025.10.22.00.13.45
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 00:13:45 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-63c523864caso9519657a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Oct 2025 00:13:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWrK6NlXsKlYL7eozs/Aqi/Rvnb9KXdDqlP4KiY3dN48LzXEMQt/Lc+HPK/snAwz7Y1+tPntjQaKswdNQb0@vger.kernel.org
X-Received: by 2002:a05:6402:2706:b0:63c:3efe:d986 with SMTP id
 4fb4d7f45d1cf-63c3efeedb0mr16580891a12.35.1761117225052; Wed, 22 Oct 2025
 00:13:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017141536.577466-1-kirill@shutemov.name> <zuzs6ucmgxujim4fb67tw5izp3w2t5k6dzk2ktntqyuwjva73d@tqgwkk6stpgz>
In-Reply-To: <zuzs6ucmgxujim4fb67tw5izp3w2t5k6dzk2ktntqyuwjva73d@tqgwkk6stpgz>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 21 Oct 2025 21:13:28 -1000
X-Gmail-Original-Message-ID: <CAHk-=wgw8oZwA6k8rVuzczkZUP26P2MAtFmM4k8TqdtfDr9eTg@mail.gmail.com>
X-Gm-Features: AS18NWCVkJF1NOqKWFU0gaSGK8tjMxXG8WT0XdrBzJSO5Q7qcLLOOQSVewmJNPE
Message-ID: <CAHk-=wgw8oZwA6k8rVuzczkZUP26P2MAtFmM4k8TqdtfDr9eTg@mail.gmail.com>
Subject: Re: [PATCH] mm/filemap: Implement fast short reads
To: Pedro Falcato <pfalcato@suse.de>
Cc: Kiryl Shutsemau <kirill@shutemov.name>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Kiryl Shutsemau <kas@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 21 Oct 2025 at 21:08, Pedro Falcato <pfalcato@suse.de> wrote:
>
> I think we may still have a problematic (rare, possibly theoretical) race here where:
>
>    T0                                           T1                                              T3
> filemap_read_fast_rcu()    |                                                    |
>   folio = xas_load(&xas);  |                                                    |
>   /* ... */                |  /* truncate or reclaim frees folio, bumps delete  |
>                            |     seq */                                         |       folio_alloc() from e.g secretmem
>                            |                                                    |       set_direct_map_invalid_noflush(!!)
> memcpy_from_file_folio()   |                                                    |
>
> We may have to use copy_from_kernel_nofault() here? Or is something else stopping this from happening?

Explain how the sequence count doesn't catch this?

We read the sequence count before we do the xas_load(), and we verify
it after we've done the memcpy_from_folio.

The whole *point* is that the copy itself is not race-free. That's
*why* we do the sequence count.

And only after the sequence count has been verified do we then copy
the result to user space.

So the "maybe this buffer content is garbage" happens, but it only
happens in the temporary kernel on-stack buffer, not visibly to the
user.

             Linus

