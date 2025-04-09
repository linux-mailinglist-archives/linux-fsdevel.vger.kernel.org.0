Return-Path: <linux-fsdevel+bounces-46081-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9977FA8258E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 15:05:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D3764628C7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 13:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C59261581;
	Wed,  9 Apr 2025 13:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OauyPCFu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E3215689A;
	Wed,  9 Apr 2025 13:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744203898; cv=none; b=qzl7IT4Bse9lmTTKzsOzUeUWxt3pkn3juBGM0Ixw6CWXMQW1RbWpsRa6WFwXD4+frIqcvfjw8Gw0ALkJFqU4m19QR7/rw3MWpRnrkL4LgZ7hJDWNw87r7hply7gJ2OWi2qFlNSD76gFtmBcr+rjIPqbEWeDyVlAhR+I9xY4aMv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744203898; c=relaxed/simple;
	bh=366rSGqKDSaNaqnzuXgMVPDEcnVkkx0y3VLfHOXvzWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i8AdsBBzl4xj/9ckwPH2MoL4RbA9zt35WQrKKqGMAYPEObcGx/xQS/iouKNd05xyoBXnxJVjkePjpt8NF9Hn61W5/QGCYb0Jgur0KkkMqLnuNhW1EaSKvm/ZJD4lEYjXxDpr6ghybCh9ikP26tjHN178fCxija1egGCg+CZUfwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OauyPCFu; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43cfebc343dso44997845e9.2;
        Wed, 09 Apr 2025 06:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744203895; x=1744808695; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2cS0lrW0iOQVVCSI2Cp6NCF74CvixMtSANH/SVtlGds=;
        b=OauyPCFuqu+RY2Th9IWlnhOrCZ/fa3LMlbUn/FVyFJG+AjKa2PS6qk8X4cU44OAT/S
         VDJpcTSZJBvwMY8EZqXfeNGhUe9m7BDyzBPdSBsO+S2MNlzVxoipOVSZHedmp9K8/cmN
         OrWy5lhdEzvFocCa8aU9WkhzcUGyh4FPT6vqH4x+e2AnnyJZ4I+QN0PNQ2yNlVShT9TW
         Jpmi9HHyMSAOzOJWPSRCJPex9aRN6k01GDV6ErVou0z/VScLtYlExIMeP0gmQCtwC4dc
         tvl2Q9cJbsXqjrHyolN772f+19qsm/DcDs9eW6vtqvWCrWu/Hk70atZ9X8Ks32l3DcD1
         zQ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744203895; x=1744808695;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2cS0lrW0iOQVVCSI2Cp6NCF74CvixMtSANH/SVtlGds=;
        b=fszFiUzaqqofXRbuMplmkuyh3Og+MO7cnJbISrcUJJ/u0sXHRMF2qvVm+1F+ln6Gtw
         CKHcUKRFvDaM0iL7R6WW99+e+VQm0TE/iG0c7gtHvq1F5RsfmszoGRRNnTsf8nwITlw+
         gtis9xWtvNtvs9rOcgX6dbTHJ8i7sYUsDPUpmu2NMGGo3/wI9P2rofhwmiNTwAexiVho
         5fa7WUWmx77yNn3fLLaWG4ytsoGU+5j78WtlZvJ8tQiFesL2qHMGy7YZd82r91243lPi
         gCZdKN5M7IOC/n5hZG22neSQr/v1R5vfEMbzcTaTwlOQwx6kyBfJ93UOZbht0FFTcca3
         E1EQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJ92ISC8pVbVeczQFkRtDpFoOIsH+cBZxHcfvKWqhxfjnfygsP/0SZh1oLOD91P27g6zKuA8DccPKguALl@vger.kernel.org, AJvYcCWh8ycx4+pW6D6IVFm9ZWIYamUAITxAmIgXqvuSPpLqOG+FDE6V9mO+h4dhWhZK5dtCreQ4gliuwvForHob@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8f5D+5ajYnVH6ZvimFxV3FSJoNbYQC4Z3oipP8bf2Huk33TtZ
	+k/y+EAVkUTYH6Od5zC5oEnaTYvOc81R4RG9RG7kQS11FoXdPOK1
X-Gm-Gg: ASbGnculn7HbRqQeMTKxDOu1/hmsj7lF1HOTse7ABh/et7HM4rGugU9uCixyYZGiZxT
	Q//p/6aG39ncwjMSNEkEXywMm31iGhZS+etXt/zhFhAisGh11K9KNTa6GOdkbcorudEeudoX37v
	9e2Rl0IBJ2joVZCctMu1NfKhY64eYM8qYUXLHy6Krh8INOZmGQ5jjm6sopbNmZbYXY+aXp3t54R
	tdv6DViT9bOTWotWmYJeNWIMFCcSbUhl3lQgU3+VuKRTZJUm79FReX8d2BeOYJXNbNbc4TwPczr
	fyxWZbDlqW/Z8hZGfyQm8k63s5OcW62HC5wxCZ+dbH6le1I+a8xDg7+7
X-Google-Smtp-Source: AGHT+IHze8vgtp89EBfanMiJMagv6hp47UulZJ9+q1wuQnRxXIQjwicF431hKSZALOTX5DVhgOYcig==
X-Received: by 2002:a05:600c:1d86:b0:43d:7588:66a5 with SMTP id 5b1f17b1804b1-43f1ed671d7mr29495825e9.31.1744203894700;
        Wed, 09 Apr 2025 06:04:54 -0700 (PDT)
Received: from f (cst-prg-17-207.cust.vodafone.cz. [46.135.17.207])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f207aeaccsm19257355e9.33.2025.04.09.06.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 06:04:53 -0700 (PDT)
Date: Wed, 9 Apr 2025 15:04:43 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: Eric Chanudet <echanude@redhat.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Ian Kent <ikent@redhat.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	Alexander Larsson <alexl@redhat.com>, Lucas Karpinski <lkarpins@redhat.com>
Subject: Re: [PATCH v4] fs/namespace: defer RCU sync for MNT_DETACH umount
Message-ID: <mey7l4rm7r5fxndlg72jfjjwwctyoimjg35jetrnv5gbee4qll@w5ldyvm6h22a>
References: <20250408210350.749901-12-echanude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250408210350.749901-12-echanude@redhat.com>

On Tue, Apr 08, 2025 at 04:58:34PM -0400, Eric Chanudet wrote:
> Defer releasing the detached file-system when calling namespace_unlock()
> during a lazy umount to return faster.
> 
> When requesting MNT_DETACH, the caller does not expect the file-system
> to be shut down upon returning from the syscall. Calling
> synchronize_rcu_expedited() has a significant cost on RT kernel that
> defaults to rcupdate.rcu_normal_after_boot=1. Queue the detached struct
> mount in a separate list and put it on a workqueue to run post RCU
> grace-period.
> 
> w/o patch, 6.15-rc1 PREEMPT_RT:
> perf stat -r 10 --null --pre 'mount -t tmpfs tmpfs mnt' -- umount mnt
>     0.02455 +- 0.00107 seconds time elapsed  ( +-  4.36% )
> perf stat -r 10 --null --pre 'mount -t tmpfs tmpfs mnt' -- umount -l mnt
>     0.02555 +- 0.00114 seconds time elapsed  ( +-  4.46% )
> 
> w/ patch, 6.15-rc1 PREEMPT_RT:
> perf stat -r 10 --null --pre 'mount -t tmpfs tmpfs mnt' -- umount mnt
>     0.026311 +- 0.000869 seconds time elapsed  ( +-  3.30% )
> perf stat -r 10 --null --pre 'mount -t tmpfs tmpfs mnt' -- umount -l mnt
>     0.003194 +- 0.000160 seconds time elapsed  ( +-  5.01% )
> 

Christian wants the patch done differently and posted his diff, so I'm
not going to comment on it.

I do have some feedback about the commit message though.

In v1 it points out a real user which runs into it, while this one does
not. So I would rewrite this and put in bench results from the actual
consumer -- as it is one is left to wonder why patching up lazy unmount
is of any significance.

I had to look up what rcupdate.rcu_normal_after_boot=1 is. Docs claim it
makes everyone use normal grace-periods, which explains the difference.
But without that one is left to wonder if perhaps there is a perf bug in
RCU instead where this is taking longer than it should despite the
option. Thus I would also denote how the delay shows up.

v1 for reference:
> v1: https://lore.kernel.org/all/20230119205521.497401-1-echanude@redhat.com/

