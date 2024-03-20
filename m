Return-Path: <linux-fsdevel+bounces-14907-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F568881460
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Mar 2024 16:20:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 389A9283C62
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Mar 2024 15:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66483524C0;
	Wed, 20 Mar 2024 15:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GMDjmRV4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBBF50A7C;
	Wed, 20 Mar 2024 15:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710948016; cv=none; b=BVHPK41rwnt26ZXdvpxaz4Ay+TofbfDKqaA8Swd5ga49RVOmHtyqSHK+X29MCcTMzs8seixDkb7umV7FQS59bUHyhgAuCo6i6NgkICyrtud9ResQoFC5qi7uelsgy46zZbngOMlh501Xzh04/qNv0X1fdyj/fkEAwyLc+z2WCZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710948016; c=relaxed/simple;
	bh=jbAviVdG5PYU68VheCEt3+P0Ti55y9JXBqGzLplMOd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OMX3sKuorBVDzlv8EEcNyiM0GSeqKL24EGhJQKKbdFEABAI+oOwXOmRo7KxeV3XCror+TSmvhjmrlfSQIsxDS3ZAdxv65VAH89Y5oNNkCOLhrDS07L6sUH0G2BVgnmyolHBmp0DACSc1AYuypkZhiv0u0TS473PmQrqXU7YtwWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GMDjmRV4; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-609f4155b76so71725837b3.1;
        Wed, 20 Mar 2024 08:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710948014; x=1711552814; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fkCsEo4Bf7snePHiuEg/lPMrLlUywl5gBYIKxRVm4qE=;
        b=GMDjmRV4trfl1zWad40gmwKzxPcq+G89Dpr1h34IGOYccjgkk/ULHRyZy7TrfBQe0o
         2luhwhCO4IA+LsQO+2EuPT50OgDDNFAM8xBVDMNrIBaxv8O3itDAlJPpPKcuNqz/bcrj
         AdChJTc+kXdtic+pXsdwPWMs7oJR5t3/BzR/jlgyfCAWgh9Q+6jQVUA1myazgmG3ANld
         bSfEnW6CAHZOQNlVnwK6FcVuMHoOfR3RzsYe8/dNUQVhDe/I2r+1pxK9ZoI0E/JcWMUk
         e1DSXsJXppIJWkwYqBiaAS+CpDVSoaaPECXRvX+OrJ+RkOKzY30di0ecgS7XMb96v0hi
         lmTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710948014; x=1711552814;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fkCsEo4Bf7snePHiuEg/lPMrLlUywl5gBYIKxRVm4qE=;
        b=kATt1O0HFtIp7mkyh32odZhN8Ivtm3c3srXycnXa6ISsbtrx0kxU3UDrDxhkWNTaf8
         TqjNp5Wm88IyHgrQjcmDvxkoRowpZbXKcxXcnQmR5Dy7EoKJxkIpr78GInLuXstPrt2Q
         NRUW+Gv2mDYNhBoob0UMAVQDL6cDD5df62odATaQiQ32mMGP3iRPMfaY6FRLL8wEI9qE
         U2kor83qq1H7DFzZJZf1Olt6ili45YcM9XfRa7XRLx1TNNsGC7Vgyjwo4i28b16D3jiN
         +uFWHRWWd9Ni/ITioxvWDfWpGMl3Ou3pzi0zkXR+a+onse1NCe4Uv2mWkoocYEewZ2Zl
         b63Q==
X-Forwarded-Encrypted: i=1; AJvYcCXFivLaeFTWhApzc2fMiDGzVW/HJBAD8Tx0yUK+YFShJmm8lZ+RLVaSJMd+dhHnkxEIoXyQdX87YP1W5+Uz9cXteDL6HglQXKfuBjSxzg2beuQdUc0CW9S+GM+qGlxkUwc9EwD5dNvPNJfbpQ==
X-Gm-Message-State: AOJu0Yxv64O+0OiQjJLye29VGUHu1NeZ/z5vEhdK6lDtBl6C9glLHUEw
	0K6TmE27a8ywIvIG1JqxMNDMWq4N/Zrm2DqO+Jvsc7nuTIvLtbzo
X-Google-Smtp-Source: AGHT+IHanjX8/lQ8OxvojHk6r0sfMoxcnrCz64hpQd43RbD8WGd14eKvB9R6pdt3kBfrQOp21ELD9Q==
X-Received: by 2002:a0d:dd12:0:b0:60c:f1b0:1eb1 with SMTP id g18-20020a0ddd12000000b0060cf1b01eb1mr5934741ywe.43.1710948014198;
        Wed, 20 Mar 2024 08:20:14 -0700 (PDT)
Received: from localhost ([2600:1700:2ec0:58c0::44])
        by smtp.gmail.com with ESMTPSA id v3-20020a81b703000000b00610cfeb2718sm1226060ywh.80.2024.03.20.08.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 08:20:13 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 20 Mar 2024 08:20:12 -0700
From: Tejun Heo <tj@kernel.org>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	willy@infradead.org, bfoster@redhat.com, jack@suse.cz,
	dsterba@suse.com, mjguzik@gmail.com, dhowells@redhat.com,
	peterz@infradead.org
Subject: Re: [PATCH 0/6] Improve visibility of writeback
Message-ID: <Zfr-rFdN6v87ZDmT@mtj.duckdns.org>
References: <20240320110222.6564-1-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240320110222.6564-1-shikemeng@huaweicloud.com>

Hello,

On Wed, Mar 20, 2024 at 07:02:16PM +0800, Kemeng Shi wrote:
> /* all writeback info of bdi is successfully collected */
> # cat /sys/kernel/debug/bdi/252:16/stats:
> BdiWriteback:              448 kB
...
> 
> /* per wb writeback info is collected */
> # cat /sys/kernel/debug/bdi/252:16/wb_stats:
> cat wb_stats
> WbCgIno:                    1
...
> 
> /* monitor writeback info */
> # ./wb_monitor.py 252:16 -c
>                   writeback  reclaimable   dirtied   written    avg_bw
> 252:16_1                  0            0         0         0    102400
> 252:16_4284             672       820064   9230368   8410304    685612
> 252:16_4325             896       819840  10491264   9671648    652348
> 252:16                 1568      1639904  19721632  18081952   1440360
> 
> 
>                   writeback  reclaimable   dirtied   written    avg_bw
> 252:16_1                  0            0         0         0    102400
> 252:16_4284             672       820064   9230368   8410304    685612
> 252:16_4325             896       819840  10491264   9671648    652348
> 252:16                 1568      1639904  19721632  18081952   1440360
> ...

Ah you have the example outputs here. It'd be nice to have these in the
commit messages too.

I'm not sure about the last patch but patchset looks good to me otherwise. I
don't feel particularly enthusiastic about adding more debugfs files
especially given that some distros disable debugfs completely, but no harm
in adding them either.

Thanks.

-- 
tejun

