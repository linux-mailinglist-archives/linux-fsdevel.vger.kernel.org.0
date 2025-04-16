Return-Path: <linux-fsdevel+bounces-46530-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC598A8AF0D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 06:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D634D7A3C02
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Apr 2025 04:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B29229B1C;
	Wed, 16 Apr 2025 04:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y5nvrMgx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2A34A1A;
	Wed, 16 Apr 2025 04:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744777912; cv=none; b=bMZAC5xkUGe9YFZcFBiBJ1ftCXb3whS8VOAY+aS3w/JkCGldRXg1T5iBDpcofyiokV9klxbxxGBAzolQggyz+mwDKO6atG5r35j6fZpkdTAkxQDEKm2O5QpumYqLCvd7DqLu+a1jbX+U45vMWiqeQ7+dXix+enPoHgJBBbxdKLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744777912; c=relaxed/simple;
	bh=ID3mgG/yq3/csCj1uKnjg/LaU6bBse9jTIXuE9Q5spk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gn18l6V5mUDarXmwPpuPfVpNj7li+8M3TR+UfCZsq73stG2+5elCeoCY+Nyw/b4HBVKVsgROToNTAGGdKqlprJU84drVWC0Go4xx7M/K4pcTnhCd8lHTrEWdEB9uADD1PMTxXpSoL0rwgCUWfhYdkj+iuTtw+/RoWMQc8YgI3Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y5nvrMgx; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-736b98acaadso5780065b3a.1;
        Tue, 15 Apr 2025 21:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744777909; x=1745382709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=URvhPy/oV2vL/75NuZBpcrmjoqkq3rW0UHgJpR5E4JE=;
        b=Y5nvrMgx99J07RrP9Gs3rxrMEKMim6ywTAfoAI4iNV8xnhLDMwFZ94R5EY4j6p7Par
         r/FXTJXeMPKj0WfEonZp8Mah/wPT2s5vpzM4mqyUC6QgfkugHfrb3M9aEpPpxw68bLN1
         JMAVWIZxNBZq67nzcVBvEnad2dwIEEoeKEqRxCMiqyj6H+3i0KChagDaosiD4tz5AhTf
         ByFhlPb5wfXMaQHplneesbQkml3hZUGleDLBUCqECc6i47t5ka7yMgF51ifDdY2WGHK2
         jmQfOWQfJzLdN0pAtUiUl1ruKRJ1ZdNmBzS8IJfHl0A+iLayuroZg7nPoUeIXKdVJxxK
         v4fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744777909; x=1745382709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=URvhPy/oV2vL/75NuZBpcrmjoqkq3rW0UHgJpR5E4JE=;
        b=VECizaGHiion6hnnl6lTEqK6dduWpkBouIgO2XJln+elnyFrGOTRnH0+AFUVLGTVpN
         +TMsyWGJU3FiWSW+igwNfxE6LJp7M5TBHTRD7HTJ+01Sm5LalwX/uo0kZayCE+JjqcqW
         3ss/b0nN2Z1aSRgIiQ1+OLLsOhxGztPTPYGPT/YEe/q4dTasVcblG9FnR0hgbSwlRPCi
         GdRad7TjVIqB3BmpVWMxBurlrB2obv8RlJ3iQUeaKafZvqpjfI3fGvd8Ku/vV5TlAwtt
         xLOrz76uqFxm8PH6TcvJiU+gE9bq1HxW/C61AFRSRR7ENrjX/Pk6/NS8agCSWLdhrWiZ
         4DVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVz26c1mrzzY2gfh++kfcBZkuPAJDc8mOTbCq/XJG5pyZw4jea2PzlMPISv8CYo+4iS0ry1IZOt@vger.kernel.org, AJvYcCXmuEDzSwiJMjXxJ3pkOwt3cJixTdEvnHQ3T+WvIpGnXRoPHFYWg5V0yqS+rqO5OWoVOVmiFcUntjTogKPU@vger.kernel.org, AJvYcCXs8yJcqVN7loUm5tgduUYFVnKRUgrORTVvxDBYXhrQtazehNCb9oa05mS5aaXaGjkbkOubquyXM8jNFqdR@vger.kernel.org
X-Gm-Message-State: AOJu0YyDDE0mDlmacKGrKs56357A1K6dZs17JN/0dljbvZ5mlFgqvhkD
	aaNpshmuT+ZDr3UYofa6OSyX0mZPzMObUEJaBiGVYRa75jpaASrqQnOUtkHQ
X-Gm-Gg: ASbGncvwvMgyv8x7YVUo95aVIkBxQ632kVpmeIITt9BreEF8jxeC2rVn4S04TDuFWGU
	aNXBCtLlTEUKmddcHbNEhTNR/VuXat+/qPsFQDDVt06xgeO4iKigUvIeaTPOxDMrG04kui94kwA
	cFufMJcKB+dAz7usb1vd6Q0UC8U/jvVmsu9gYcw6iAyBqXzrSYsUPSEk1VGvV43U1o0slqK8UyJ
	gZc+SZHudAsyG8Ar1uzrV+JkKxqxGX7QSx13zW5BLeYjhcIXdGxW++Vbdgm30JEpHbd27ud4vZa
	COatst7cvHtRp48nZaHa1Mswe0KIVno6KkVm9geyEeR1OWtWTWCxe/ntBJAweQ==
X-Google-Smtp-Source: AGHT+IHFgMxReC+YG32Dd+BwllhMqIBI2ZO2sqm0vk18CB7ElHOpAOiE8Lq9VRJv61eZzLm7um2j+Q==
X-Received: by 2002:a05:6a21:789d:b0:1f3:345e:4054 with SMTP id adf61e73a8af0-203b3ea0252mr318052637.14.1744777909525;
        Tue, 15 Apr 2025 21:31:49 -0700 (PDT)
Received: from VM-16-38-fedora.. ([43.135.149.86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd230d697sm9396676b3a.123.2025.04.15.21.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 21:31:49 -0700 (PDT)
From: Jinliang Zheng <alexjlzheng@gmail.com>
X-Google-Original-From: Jinliang Zheng <alexjlzheng@tencent.com>
To: akpm@linux-foundation.org
Cc: alexjlzheng@gmail.com,
	alexjlzheng@tencent.com,
	andrea@betterlinux.com,
	fengguang.wu@intel.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	mengensun@tencent.com,
	stable@vger.kernel.org,
	willy@infradead.org
Subject: Re: [PATCH v2] mm: fix ratelimit_pages update error in dirty_ratio_handler()
Date: Wed, 16 Apr 2025 12:31:47 +0800
Message-ID: <20250416043147.31208-1-alexjlzheng@tencent.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250415185851.e8d632f60ec5049f734ac2a8@linux-foundation.org>
References: <20250415185851.e8d632f60ec5049f734ac2a8@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 15 Apr 2025 18:58:51 -0700, akpm@linux-foundation.org wrote:
> On Tue, 15 Apr 2025 17:02:32 +0800 alexjlzheng@gmail.com wrote:
> 
> > From: Jinliang Zheng <alexjlzheng@tencent.com>
> > 
> > In the dirty_ratio_handler() function, vm_dirty_bytes must be set to
> > zero before calling writeback_set_ratelimit(), as global_dirty_limits()
> > always prioritizes the value of vm_dirty_bytes.
> 
> Can you please tell us precisely where global_dirty_limits()
> prioritizes vm_dirty_bytes?  I spent a while chasing code and didn't
> see how global_dirty_limits() gets to node_dirty_ok()(?).

Thank you for your reply.

It's domain_dirty_limits() that's relevant here, not node_dirty_ok:

  dirty_ratio_handler
    writeback_set_ratelimit
      global_dirty_limits(&dirty_thresh)           <- ratelimit_pages based on dirty_thresh
        domain_dirty_limits
          if (bytes)                               <- bytes = vm_dirty_bytes <--------+
            thresh = f1(bytes)                     <- prioritizes vm_dirty_bytes      |
          else                                                                        |
            thresh = f2(ratio)                                                        |
      ratelimit_pages = f3(dirty_thresh)                                              |
    vm_dirty_bytes = 0                             <- it's late! ---------------------+

> 
> > That causes ratelimit_pages to still use the value calculated based on
> > vm_dirty_bytes, which is wrong now.
> > 
> > Fixes: 9d823e8f6b1b ("writeback: per task dirty rate limit")
> > Signed-off-by: Jinliang Zheng <alexjlzheng@tencent.com>
> > Reviewed-by: MengEn Sun <mengensun@tencent.com>
> > Cc: stable@vger.kernel.org
> 
> Please, as always, provide a description of the userspace-visible
> effects of this bug?

The impact visible to userspace is difficult to capture directly because there is no
procfs/sysfs interface exported to user space. However, it will have a real impact
on the balance of dirty pages.

For example:
1. On default, we have vm_dirty_ratio=40, vm_dirty_bytes=0
2. echo 8192 > dirty_bytes, then vm_dirty_bytes=8192, vm_dirty_ratio=0, and ratelimit_pages
   is calculated based on vm_dirty_bytes now.
3. echo 20 > dirty_ratio, then since vm_dirty_bytes is not reset to zero when
   writeback_set_ratelimit() -> global_dirty_limits() -> domain_dirty_limits() is called,
   reallimit_pages is still calculated based on vm_dirty_bytes instead of vm_dirty_ratio.
   This does not conform to the actual intention of the user.

thanks,
Jinliang Zheng :)

