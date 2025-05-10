Return-Path: <linux-fsdevel+bounces-48671-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE886AB23DA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 May 2025 14:44:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D5247AAC3D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 May 2025 12:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6370B257AF1;
	Sat, 10 May 2025 12:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M7pWXx3P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB511E2823;
	Sat, 10 May 2025 12:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746881058; cv=none; b=KEvA26eHfLyrtkyGCYQPV5d/BjSxKVtnUQBJkL/T5So5vfuA2ZNW6TFKJMvRVMpp9BGZzREdrotTgZz02db/5KZ76Ms2L6eOfztm/+TJhA8qYckXhyg0v/EiUcUZ1vdC+lz2/Wl9byC6HI98ErjAX/hjjAoJDh5hyTRRS2fq+GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746881058; c=relaxed/simple;
	bh=xUnZrRumIWjSwNtFDMxrJAIXv6RamDfkmG2efjYupgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nWE6wuYKftqZVFSCqQnO51QOV/WLcJRA6I2LpF2JW902G6aCh2IOqR9nVtBDaQIxmbUWMz0gg/TyCNUJOqSU00bTwQKrNrSEms8NdkU8AUcUy3B6L45uzUMMcXduQsPCGeIYk68QHwL1avQJkKMobAMhYfodjrQnscPl+lDy7rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M7pWXx3P; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7399838db7fso2987311b3a.0;
        Sat, 10 May 2025 05:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746881056; x=1747485856; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eu31/aJJu8OERA5r5dU/7oH/7L1eXKv2jBwzYBTSj44=;
        b=M7pWXx3PHjl+kWq0jCJM4kdUC+0MBjkwc4RCxl9uE7HKadDGXXk5nsv+cU1q/fW1A9
         78/iNWKcW8UgbZER4Uv0CAng5jGb9n+I5Fnsr4NfpCxK9WHv6nRKyULG3nhBaSluFL3v
         B17hX3rAYWt8vsqOjVBSamBYxXvUCzMmu6x178sEB24uGMl58RhuMRytWJqzkJr/f3Wx
         aoZ52Sv8uqiychWZ9HGDqcyXz5ObotjVzloVF3TmFgiQYkgKttYadrWjuVWIDHNAw3Hz
         ascb9/Aj8Jdd9/NDzOaDqtIYlwjpVtfwhi0BxwMvAELp+n4jgj97eh/IgKqclrzuDzgB
         MhUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746881056; x=1747485856;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eu31/aJJu8OERA5r5dU/7oH/7L1eXKv2jBwzYBTSj44=;
        b=t0ipVBau8h7nTG6BuIAV5v4KiA+oux95UA5TuSEYat1tMkNhVCtJjbyjknAnyBwP+J
         fyCg32SyXJlvECZoAY0XWevK4THlDoRXm4UktEpYraXk35zPrMb9VcTylYbBcUGtglNc
         8rEkn8xZjUXZhS3tQ4NhChfXezzKoC8tUZFBoPSjzRIg2VEux51uVst650jy3sHG3Hr8
         PUNV+CP4Ev8HSmnXSOFCkCJxAstniK8G8clzRbcUYY5NPWJ1ltp1oXzBLekF4RzKi4oz
         Hd5YV9p5NfsQCPC0W8LmlfPimFRSkH1QBYboGkMsn2XgSbu1a00OqpHKMmpJa/Rxc8fW
         0RHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVLXGO9QzsjYt8DyESmRuzvLK/dfTfX1l7SfbRyh2iNN/eq/T72fMqG1+ZlEfmup8rL1LQda9Vgc2JM6PF@vger.kernel.org, AJvYcCXWiYi6nKELN41cWqP0IY6U3bVpkaA+TnwJXqEooH6FDmAokyn3TkVtDJVCKyRy1IBPYhw8MZ5CR1LW9cKG@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8QuWoQ9hxpf+DzzyM2gQSY2UE8Xj6VcfN6MEYs+Mdg3K7YhQp
	irXvtmEHVStdqy3YxPtz7cC7gqWp8jn9Jour/TKKQKMAJAnnSXfe
X-Gm-Gg: ASbGncu57qh/dMbJmiYisjjlS/2V8xXof/173wJvODfV2v/leuN2BARqZEb0Kmxc5nJ
	kWUF2dUU41w3hYU9JCaLKS1m8hhzbjs2mRfFG5Y6ca+vr7775nSk42iacuj+GQfZMWSUyYSlvWj
	ExHYlirSLIgCAsvAn4GoK1W2iNRPORlBy0mga6j0cIYAG7fQAKdSEDDxGwAo0+HeHoXeGcuYQXz
	T89h0O5tBO0bfxzS9aO56NAF7QCXjGLt3X+O/143leSiVDiZwDQxG/izv5PTjzZVfeBjWjGluH0
	KjqKqWYWoAWElOcdvepvzfLBAgrf7wZJrrZ/s8a48AFWuLRhJvsMztHaKy1IcX/NXZJy
X-Google-Smtp-Source: AGHT+IEqIrCBylsxkiW9S0K7wrfa55EBhlhJH7qiVLVyafg1jVuSDpo5/JGQWJXb1le+4eIM3gC2jA==
X-Received: by 2002:a05:6a00:ace:b0:736:b400:b58f with SMTP id d2e1a72fcca58-740a91d0efdmr19435665b3a.0.1746881056569;
        Sat, 10 May 2025 05:44:16 -0700 (PDT)
Received: from vaxr-BM6660-BM6360 ([2001:288:7001:2703:bea7:51b5:8c2a:f16a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74237a0d012sm3251660b3a.93.2025.05.10.05.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 May 2025 05:44:16 -0700 (PDT)
Date: Sat, 10 May 2025 20:44:12 +0800
From: I Hsin Cheng <richard120310@gmail.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH] fs: Fix typo in comment of link_path_walk()
Message-ID: <aB9KHNNBzWxMJ2_j@vaxr-BM6660-BM6360>
References: <20250510104632.480749-1-richard120310@gmail.com>
 <20250510120835.GY2023217@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250510120835.GY2023217@ZenIV>

On Sat, May 10, 2025 at 01:08:35PM +0100, Al Viro wrote:
> On Sat, May 10, 2025 at 06:46:32PM +0800, I Hsin Cheng wrote:
> > Fix "NUL" to "NULL".
> > 
> > Fixes: 200e9ef7ab51 ("vfs: split up name hashing in link_path_walk() into helper function")
> 
> Not a typo.  And think for a second about the meaning of
> so "fixed" sentence - NUL and '/' are mutually exclusive
> alternatives; both are characters.  NULL is a pointer and
> makes no sense whatsoever in that context.

Ohh thanks for the head up. I'll keep this in mind, really big thanks!

Best regards,
I Hsin Cheng

