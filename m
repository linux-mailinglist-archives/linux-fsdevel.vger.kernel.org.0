Return-Path: <linux-fsdevel+bounces-63651-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1674FBC875F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 09 Oct 2025 12:23:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 166C61884D92
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Oct 2025 10:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4EA02DA76A;
	Thu,  9 Oct 2025 10:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b="U8II0m/C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C59275844
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Oct 2025 10:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760005385; cv=none; b=kLwRT+co2oOqOlj4mxevFwSbraFaOGKt2dBLXNAaHjKygr4Uc0gkgQOKAL3weCi8wTjEw/vfvgTPcwuo1/4LrXGyuUPw2LB16w1nKX1IHBRkG9YfJbunaVrB8hHNOeUrmTx+nkDket/nTfVHkoxy9hFjm6zIz+XiDecHkvualls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760005385; c=relaxed/simple;
	bh=l7QzGI7FmuzLiWBMITL6HLIWO89vnW9gY5iIdUxjrpQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=bDuapq0uBCtt0aTE6+gRL5zPcVVzdLngkOP4b/SttBLEyNU0ytPmX7u8YjcCgrj7/iylQMMertHirSIZBfyGMad6dViMS5Jk/J1eIjnuajA9IoxWJNIrV+VDOUUlAZpgFSwVTxSn3hklPDcjAsWAO13MNXeMu4osJjgC53GEM+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b=U8II0m/C; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-46b303f7469so4596735e9.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Oct 2025 03:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20230601.gappssmtp.com; s=20230601; t=1760005382; x=1760610182; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=h7QtmyaStV9Cg/SiLzcIFBH2QrCmrrCZZBI5xKAFZzk=;
        b=U8II0m/Cj5yciEwOhl+9+q2n1zL0VJ8txNNESrxpElyWHbpGGnwHprG6I+gMXghbhz
         GWFD+Sn4Fwwd/EzexRWS3+hwlBhwKpwkB7dOqzm+PeouxhNCYAwjjeUUAXsXc0YDeRqZ
         57Xdkk/gqHHmztstOKP+Qx8ypu+0Rr0Gp5W8by86jueg43t9OWW8Xqw7E0ELFFffO/XW
         af4hguikER5MQXTVRKziRjCADGg/ZIFtQd3i3e06rKm7NhumQgmozG96D8lWpKbDmMQw
         v66AL9eg9xh59Ov0hsJExWjrdJ4a7yjES9RPZH0aKyvMu+hXdWsPrURGNh8vI53ayfn+
         kHZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760005382; x=1760610182;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h7QtmyaStV9Cg/SiLzcIFBH2QrCmrrCZZBI5xKAFZzk=;
        b=tGND4v+VrsGS54TwY2BrndUj38ssMx1Op/G2s+RGT8sFJP3J9DUkY6bmwJtz53d125
         0BnyqYVjfROaTAUCMttEelzGo+l2Z+HwDFoyz5mv8WdbjQDcYrjgqLoSu8aHWoUy9vaU
         PddPvN0JZSlxUKydYCDHsaMSDaAwmFc97F4Kjq/54xwx+QCsUKcDBZgfhrgU15RQefuE
         /glZn44smtMxQmjJkwOyMBvEUSWDenFB9+62G1kuIGr2xr4zli55jvL5yZfEJbajayHp
         RS0YKPkH/y9f6G4xeUSHlkdzs9uNTrtB7WniWMmsSZjL6RvVbWH0s0zfnY6S9sxzeo0F
         qbDg==
X-Forwarded-Encrypted: i=1; AJvYcCXSIY4krSIxuoIwrtJPOHKa2GoKRlMbzjqp7nZWJ0Rd1iFM12w1kl4PtgiYZ4Py2+WywBMVfxEXMWjshcpf@vger.kernel.org
X-Gm-Message-State: AOJu0YxZzJUldLrjthNWgq5DVsY4dcXZKPa1Cnq1JJxl2gpfANLIYRot
	acVupS7HH9mYNCAvWfPDMiCpda6hv/NkrlDp6CykZeF012CeOp3uEyk4PLfQLZLSlTM=
X-Gm-Gg: ASbGncvI3AMqsCcl+xORbqLu7Br535upFc4LixkwRAu+fR5Ormnf4xJNQy4cXCxIxFs
	R3TzeCutB27AFdP8GsJuCS/G6v0o3VVE1HI0xzVo9DyUlCXC13a9RqkiMctaKykR47t20M9lvjg
	BuDWOFvQeCAUTGyfUZvcSezUfDHmhClG6DudsLIGYgFH6vRp2AemGj+2mNXB+gGr/uG1237rGhy
	PmgAb1SO3upEzSvc+d4MHh/iRRuwcEAUZU6o6hS6texw6uXpVw7Mp1jQPf46qfPup13UzBu9pma
	+UAuoBkYLWaRBmPeOBPsk1j7skcuQ2qlc12nVfXnKsNCqtKzUGg7x7v2EmKghG5CLPCRmWgidbt
	P4CPT+B4d+Q1O0iB6Gl3OAjyJkuVwKWAsDJFVWq0WEP6FQkwdFqjMX1pXuQ==
X-Google-Smtp-Source: AGHT+IEStIkragv6qCXCo8V3gHP7SZNoyJGu9SkTjAiRd/XZfLMJTPJ93VfbPipyaCKgSacW7ychVQ==
X-Received: by 2002:a05:600c:528b:b0:46e:6042:4667 with SMTP id 5b1f17b1804b1-46fa9b11b24mr49480295e9.33.1760005381887;
        Thu, 09 Oct 2025 03:23:01 -0700 (PDT)
Received: from matt-Precision-5490.. ([2a09:bac1:2880:f0::2e0:b5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fab4e22d8sm33204695e9.5.2025.10.09.03.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 03:23:01 -0700 (PDT)
From: Matt Fleming <matt@readmodwrite.com>
To: Theodore Ts'o <tytso@mit.edu>
Cc: adilger.kernel@dilger.ca,
	jack@suse.cz,
	kernel-team@cloudflare.com,
	libaokun1@huawei.com,
	linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	willy@infradead.org
Subject: Re: ext4 writeback performance issue in 6.12
Date: Thu,  9 Oct 2025 11:22:59 +0100
Message-Id: <20251009102259.529708-1-matt@readmodwrite.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251008162655.GB502448@mit.edu>
References: <20251006115615.2289526-1-matt@readmodwrite.com> <20251008150705.4090434-1-matt@readmodwrite.com> <20251008162655.GB502448@mit.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Oct 08, 2025 at 12:26:55PM -0400, Theodore Ts'o wrote:
> On Wed, Oct 08, 2025 at 04:07:05PM +0100, Matt Fleming wrote:
> > > 
> > > These machines are striped and are using noatime:
> > > 
> > > $ grep ext4 /proc/mounts
> > > /dev/md127 /state ext4 rw,noatime,stripe=1280 0 0
> > > 
> > > Is there some tunable or configuration option that I'm missing that
> > > could help here to avoid wasting time in
> > > ext4_mb_find_good_group_avg_frag_lists() when it's most likely going to
> > > fail an order 9 allocation anyway?
> 
> Can you try disabling stripe parameter?  If you are willing to try the
> latest mainline kernel, there are some changes that *might* make a
> different, but RAID stripe alignment has been causing problems.

Thanks Ted. I'm going to try disabling the stripe parameter now. I'll report
back shortly.

