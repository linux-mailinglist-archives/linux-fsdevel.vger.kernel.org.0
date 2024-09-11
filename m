Return-Path: <linux-fsdevel+bounces-29087-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A9AD974F94
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2024 12:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 168AB1F251A8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2024 10:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F793185929;
	Wed, 11 Sep 2024 10:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rsXjj1Q6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0849F184532
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Sep 2024 10:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726050113; cv=none; b=Xp9qeLtwNiYMoD9pZlVpW1lUxobJGzJaKwTiCYttFBRjzyiJN9AjQRxys3uaiwVRu55ulLeseAgSbtPWkCzVDmBSWcmrnHquAI/y3QNiJhi/JWbFCahAbaKKzsiK5gsfCtmU0hJc0ShqLy0OO5fsqpaI/0H4g7gZ8x1PbhxuukI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726050113; c=relaxed/simple;
	bh=mr0gz1FSc1K2UXU4kEG9zILcUyo3Tq0Kk043zF608MI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=AqIvVPxqORYYlQeug1tMKJ1O4wPy0mzsoRbtNrHShx912Lx24/dzc9CNCQMiW2TRddQTHECg3ZUVDZvnzo3m89XvAJsqyhVy5hIcqXPGGtPGxkRPta5cLRosqRe2Mo2ESBsnlzQzaQPEtLWPW/ALV7iYGGr/kEYSpf1fLcMd/5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rsXjj1Q6; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42ca6ba750eso4603205e9.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Sep 2024 03:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726050110; x=1726654910; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6BuTh53TE9K9HCjvvYs/rolmKouQpt1tPRtQPMElXlo=;
        b=rsXjj1Q6Y5vW+ja11nv9xa2F3TFE7ZR3QOWS5oheF47Gwkn4Bl+L3lMS9BVi9F8dwp
         NtuOLfztkK4tfbrJqZs1/wPS1tVeXrHizYSxQh1RDVL7BVZxw8uHbC2sZcezV+oo0x+J
         J8OUC9/1rUYjznOEJ0UrBnrcr5pwTaj9QbM5Qhz+bDEbSKhONzcml7JWX1s7UqH4PMHS
         p0DhR/UX4I4q0ksGvcz4R3aT/wiHSczChtRIbtVAMtJlVd2uYwV7GjI7riW8D5efOHPO
         T2CzowqwRerb6uGTk75bs0D1LtiNKndGrVdZwiif9zjes3RCDMboKRpUFp1qX2iS+c4z
         hc4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726050110; x=1726654910;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6BuTh53TE9K9HCjvvYs/rolmKouQpt1tPRtQPMElXlo=;
        b=nUZg2tNsJypOe3Kq694tItj0fguAELBvZzl9k39goPG1kotwFQSy/YUSne5Xi2wV7U
         FTqOyUxXpkSEKyg2V0V4MXYl33j5TkxWw7hxWyKh0U8bSS/2JQ1ZMJfz9ZJKhpT6s/Gd
         sPGXo7cW2/JeJlqjPFolzLVzVM7DRd/yXkdRkpq1IfSA3w9aJvEU5ypOX8kEro4N344I
         CnWNtvXozLssclbzsjyb9QlO9UQCL3ZSH+vC8FN7cW7Di19UAoxjF/Capf4dZbfqOUZY
         +goJ5LWpsn9p6xthUbs5PbgLR9a10FRWT9GmaB1aRNhJ2bTuFU3HkW8yYZaUBnQ4TEj5
         xieg==
X-Gm-Message-State: AOJu0Ywe3L+o85qTg4fnk8uo4OMxPqSFYzfs0M0sNbPUlvp6uKjNWw7T
	KiyCeSB6oWd1EPhrFd5Bgv2Ep2+E3z/L1CGZWHnx6kGSIdJs/kB982c4MjJm9bU=
X-Google-Smtp-Source: AGHT+IETZ/bkOH0t8yV6R9XtBPjzeIuwvds/lqaOJNdrRjZxe9OxYZvnt3qYUq8l9sTMRAABmPoXuQ==
X-Received: by 2002:a05:600c:310e:b0:42c:b68f:38fb with SMTP id 5b1f17b1804b1-42cbddd6d0amr38226705e9.7.1726050110307;
        Wed, 11 Sep 2024 03:21:50 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42caeb81ac0sm139538645e9.34.2024.09.11.03.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 03:21:49 -0700 (PDT)
Date: Wed, 11 Sep 2024 13:21:45 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: linux-fsdevel@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: [bug report] fs/proc/task_mmu: implement IOCTL to get and optionally
 clear info about PTEs
Message-ID: <3a4e2a3e-b395-41e6-807d-0e6ad8722c7d@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Muhammad Usama Anjum,

Commit 52526ca7fdb9 ("fs/proc/task_mmu: implement IOCTL to get and
optionally clear info about PTEs") from Aug 21, 2023 (linux-next),
leads to the following Smatch static checker warning:

	fs/proc/task_mmu.c:2664 pagemap_scan_get_args()
	warn: potential user controlled sizeof overflow 'arg->vec_len * 24' '0-u64max * 24' type='ullong'

fs/proc/task_mmu.c
    2637 static int pagemap_scan_get_args(struct pm_scan_arg *arg,
    2638                                  unsigned long uarg)
    2639 {
    2640         if (copy_from_user(arg, (void __user *)uarg, sizeof(*arg)))

arg comes from the user

    2641                 return -EFAULT;
    2642 
    2643         if (arg->size != sizeof(struct pm_scan_arg))
    2644                 return -EINVAL;
    2645 
    2646         /* Validate requested features */
    2647         if (arg->flags & ~PM_SCAN_FLAGS)
    2648                 return -EINVAL;
    2649         if ((arg->category_inverted | arg->category_mask |
    2650              arg->category_anyof_mask | arg->return_mask) & ~PM_SCAN_CATEGORIES)
    2651                 return -EINVAL;
    2652 
    2653         arg->start = untagged_addr((unsigned long)arg->start);
    2654         arg->end = untagged_addr((unsigned long)arg->end);
    2655         arg->vec = untagged_addr((unsigned long)arg->vec);
    2656 
    2657         /* Validate memory pointers */
    2658         if (!IS_ALIGNED(arg->start, PAGE_SIZE))
    2659                 return -EINVAL;

We should probably check ->end here as well.

    2660         if (!access_ok((void __user *)(long)arg->start, arg->end - arg->start))

Otherwise we're checking access_ok() and then making ->end larger.  Maybe move
the arg->end = ALIGN(arg->end, PAGE_SIZE) before the access_ok() check?

    2661                 return -EFAULT;
    2662         if (!arg->vec && arg->vec_len)
    2663                 return -EINVAL;
--> 2664         if (arg->vec && !access_ok((void __user *)(long)arg->vec,
    2665                               arg->vec_len * sizeof(struct page_region)))

This "arg->vec_len * sizeof(struct page_region)" multiply could have an integer
overflow.

arg->vec_len is a u64 so size_add() won't work on a 32bit system.  I wonder if
size_add() should check for sizes larger than SIZE_MAX?

    2666                 return -EFAULT;
    2667 
    2668         /* Fixup default values */
    2669         arg->end = ALIGN(arg->end, PAGE_SIZE);
    2670         arg->walk_end = 0;
    2671         if (!arg->max_pages)
    2672                 arg->max_pages = ULONG_MAX;
    2673 
    2674         return 0;
    2675 }

regards,
dan carpenter

