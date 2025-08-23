Return-Path: <linux-fsdevel+bounces-58881-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00359B327B3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Aug 2025 10:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B272601598
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Aug 2025 08:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E795123B63F;
	Sat, 23 Aug 2025 08:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rqjg1Kiv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FAA1F0E3E
	for <linux-fsdevel@vger.kernel.org>; Sat, 23 Aug 2025 08:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755938608; cv=none; b=c7q4DrmJKbUJqR+/mGm4psxV4qINCEnlfSFOrDguwYBCm1s2xBOwvUx/PXgRoUaivHo7bHqcC6GuBBC3aTvOrJQNSxUk3F43WyUbuXfoN+TRcnLBCZbe9PQoyFoL+WXLoHcWYm17Ap0YQNpPQKzzVgGy13qJFbqg5RwxpWWSlaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755938608; c=relaxed/simple;
	bh=Sh7NYksVOg0+cEwI/9mvebfdXkAMbtmN9W/uuKG/FSA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uhG1KUcwEaXhhHtYh9HN9m331e7kmtYHRJxdPJpbHaevDYkqsg4IunxsdxVzFWG3QsYADIxEGFNrvyTmTAuuTtDT2zlBBXdCKAOSDrsQ/Iz73EwHvqOELf7N9oz5MwlqnVwLvQLHqmvCulZj5ZX00tkIshJC1QiFfI5XyHxM5tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rqjg1Kiv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755938603;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XBBXwHuqYsE3hHAIcEi+8debmVMKYcuEtsvPds49qLE=;
	b=Rqjg1KivAPkdm/iWXUkGw+V+JGoqbItMcUXJfIBAvM/lyJ0b69QNH7uIp+l+xzkIxhcrPU
	Bvczagu7PDjugUjewBqx1GtM+zSyQZn85uUH60y0CeIdE+zpdsm7o0csiv0t9yIefkLzs/
	lcwr9hnq/gowUbk5clBHPctbuq4muPU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-152--C0woyhWPeKC_UU1-sxQ3Q-1; Sat, 23 Aug 2025 04:43:19 -0400
X-MC-Unique: -C0woyhWPeKC_UU1-sxQ3Q-1
X-Mimecast-MFC-AGG-ID: -C0woyhWPeKC_UU1-sxQ3Q_1755938598
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45a1b0511b3so16921315e9.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 23 Aug 2025 01:43:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755938598; x=1756543398;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XBBXwHuqYsE3hHAIcEi+8debmVMKYcuEtsvPds49qLE=;
        b=pyaH9Ts8QulIBhL3R6kmg6/sodQ8/POr9eJplARGdJL/aSbG4+tZ8NFtw22BfbJtL9
         5aDfriBlZH3uvziyvd72kT9MAxSI8BFHh5bumTbtbenRUwVnFmWImbNO8T2cP4ldbNdH
         nwfjR8kYDwO8NSyd3dutJnZ93StkjPmgwPuPM9gFte/bCF4M+xVmXpT0LKupr074MOh3
         t/xhEuWHgKoxTg2aqp+iwzKtYCOwbumtIg4qlNkteRXU6coCaR3cUCVg3TKdgt2EZsZW
         pB7zHqpY+NmMt/FODZRBlcLWHsciMtHj/dTJ2gif+enOJfP5HYmwj5I+9V0FRBbVD44G
         oFtQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHGlWus8K70bh9W+ZYGT4llebb4vGgALJi2hmHQPt602vbVi9X54FzkR9pHtzq+ACyD2gvIje5ViTxX9HC@vger.kernel.org
X-Gm-Message-State: AOJu0YxZdFP3pFkrzHvxcoSTCKtkThSk1RYmow9ECT55E162BJIrhQG/
	w2fgdREO8A1S1OSm87JB8gb/Af9XXom/6tqTFaMW9TgLNq30IzT3UCKN/5eJEQfSt6eipRrmMtA
	Cobmzg5Sbp6R8eA/KAzEbYYpbntOFmxuoIvEVgyZoBJQQJyd2SA+iuKXzBPSA1wAjZtQ=
X-Gm-Gg: ASbGncsyr+i6qrdLNx54UzkUkW92LBfR6ACRkOyGMMSO4nB9xYEb0gwNwM0a7PsatoC
	QBASZe9choGU2NErtsbE2Rqugn7XrlVD0xvR58elWHZdBcIIJZ4KpVbMXNDcH6PraiTxKxfeBfV
	sJcKhVDRav7KP9NWPcrArjQ9zc7nkUOHHfd3xvo5Op6xm1WSilDrqUQTnhnfLFypyJleuKGzRa+
	a3JRj5/B4sfWTbHVqrT2TwoicbQQIbVfUMa68FuZg2P+VFAjbG/D6VHdMb6Svw9IYzRjFt0U+jk
	GwWoSvkR0fd/MQbxje4GRENp8KFLZvp7AiyfcwcUJhpt0c2uCjw=
X-Received: by 2002:a05:600c:1d20:b0:459:dc99:51bf with SMTP id 5b1f17b1804b1-45b56382171mr35465825e9.25.1755938598066;
        Sat, 23 Aug 2025 01:43:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGv+xyL1SrPU7/mPMky3/ADZJvuSN9B2wqb3s8vqHaurmc9XXiMDXRKUUTdrtSIewx9stHI2Q==
X-Received: by 2002:a05:600c:1d20:b0:459:dc99:51bf with SMTP id 5b1f17b1804b1-45b56382171mr35465645e9.25.1755938597690;
        Sat, 23 Aug 2025 01:43:17 -0700 (PDT)
Received: from maya.myfinge.rs (ifcgrfdd.trafficplex.cloud. [2a10:fc81:a806:d6a9::1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b57499143sm27193895e9.26.2025.08.23.01.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Aug 2025 01:43:17 -0700 (PDT)
Date: Sat, 23 Aug 2025 10:43:15 +0200
From: Stefano Brivio <sbrivio@redhat.com>
To: wangzijie <wangzijie1@honor.com>
Cc: <akpm@linux-foundation.org>, <brauner@kernel.org>,
 <viro@zeniv.linux.org.uk>, <adobriyan@gmail.com>,
 <rick.p.edgecombe@intel.com>, <ast@kernel.org>, <k.shutemov@gmail.com>,
 <jirislaby@kernel.org>, <linux-fsdevel@vger.kernel.org>,
 <polynomial-c@gmx.de>, <gregkh@linuxfoundation.org>,
 <stable@vger.kernel.org>, <regressions@lists.linux.dev>
Subject: Re: [PATCH v3] proc: fix missing pde_set_flags() for net proc files
Message-ID: <20250823104315.26060eba@elisabeth>
In-Reply-To: <20250821105806.1453833-1-wangzijie1@honor.com>
References: <20250821105806.1453833-1-wangzijie1@honor.com>
Organization: Red Hat
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 Aug 2025 18:58:06 +0800
wangzijie <wangzijie1@honor.com> wrote:

> To avoid potential UAF issues during module removal races, we use pde_set_flags()
> to save proc_ops flags in PDE itself before proc_register(), and then use
> pde_has_proc_*() helpers instead of directly dereferencing pde->proc_ops->*.
> 
> However, the pde_set_flags() call was missing when creating net related proc files.
> This omission caused incorrect behavior which FMODE_LSEEK was being cleared
> inappropriately in proc_reg_open() for net proc files. Lars reported it in this link[1].
> 
> Fix this by ensuring pde_set_flags() is called when register proc entry, and add
> NULL check for proc_ops in pde_set_flags().
> 
> [1]: https://lore.kernel.org/all/20250815195616.64497967@chagall.paradoxon.rec/
> 
> Fixes: ff7ec8dc1b64 ("proc: use the same treatment to check proc_lseek as ones for proc_read_iter et.al")
> Cc: stable@vger.kernel.org
> Reported-by: Lars Wendler <polynomial-c@gmx.de>
> Signed-off-by: wangzijie <wangzijie1@honor.com>

Tested-by: Stefano Brivio <sbrivio@redhat.com>

For the records, see also my report and obsolete patch at:

  https://lore.kernel.org/linux-fsdevel/20250822172335.3187858-1-sbrivio@redhat.com/

-- 
Stefano


