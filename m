Return-Path: <linux-fsdevel+bounces-17524-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B59B68AF316
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 17:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72C3F285F92
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 15:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9426C13CA86;
	Tue, 23 Apr 2024 15:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MjKYTsb7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0EBB136652;
	Tue, 23 Apr 2024 15:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713887802; cv=none; b=O4yFeHgDPT2JJmz/8yLoV8ETvWfepLsB0b6RGQACmK5n3h4AuPRMXucL6+TXIdU/2eswn7FbjUMoBXhtsYEm+o6A4nuWUAyjEdgs5fBmI62EP9bCYS4whecVInUKClbDrdJv8RizhUJ0Hl6Zrn/MoGQpqCPQpybGU807YuR1FGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713887802; c=relaxed/simple;
	bh=+WQoZCfvynzpRW6VnCCjpKF3zxAAd2n5DqdreZLhSBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G6ZM9Lm7cKa8Zza4xGF6Z2d3RHts1RC0SRpmXUkfqcVsivGmMRhd8HQK89n1cDYj/w24DXGWPqebpTKOEnr5b2qJEOkTfgIcVhvTeL3lMLZojoAIjq7GfL8k6lX6HERb6vVPpSmgO9MlyJi9xP5piRItdNMand4z3BAFQoKzz5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MjKYTsb7; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6ed2170d89fso4457836b3a.1;
        Tue, 23 Apr 2024 08:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713887800; x=1714492600; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TiXJwUhPMkjGHKs13WSq0NGz2KDz4IaigXpr6ZbxkHA=;
        b=MjKYTsb71fwZou2p4aMhS2LlO4+ZSDQvRmu/aZAZ0sFSRnzueGJfp6qIk30CCF3Nyn
         ME90yAMNodEr2uiPjAGV0OKP/5SJCiOvBN8bhDD/9LeHgYPP8ixbn9zcC/wV2kx16EMw
         LdD4zaPQgABL6RLAwKuKeby9pVaPhUHuSZv93W8BskSLL4dBtvi2hfLSsWFN+JA5DWdX
         hZHnNpd8bY6iS3xV0WFLUt6DwbDx7nrBOf4BgrsusCdXqLwL5idHl4JFtGUVSrKZ/GpW
         O7ed9xw4g1xkyQJuDUBh02AtO1IjM1j+mvj2IHDnqGw7kxbK+h+yROiVbiv8ct1/k2OG
         dyVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713887800; x=1714492600;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TiXJwUhPMkjGHKs13WSq0NGz2KDz4IaigXpr6ZbxkHA=;
        b=m5BM8yHerAKawoqDFqtXlYMTBnPrXXzA/6CIzchlLh/2uWhh0v7Oc1e0CTppTjTik7
         t61OmLAVzzc0UvEKgkMp6xP+p1j49Rujo11/l3gKKD2LEumvwuArIR3+YAvJLx1BNM5j
         a3Tcmu9v0wmehJpOMAZj4vYZc9jhQh54mIcNO78xszmifvs0QFdliZJBCSyN2Xizo0pd
         L9gQ/C6Y+v95LDLh1/N52ECr0BtG/ljYPK0TrMSIr3uzK3ACj6LU7fEYIIDGDn2x6pSI
         97WFiVwgdp9xA8HmKO1w+PHDvJtaFLSeIoyyWdYhMN7uxdLEJJ15ixpnh0DzlxgikPZq
         LnJg==
X-Forwarded-Encrypted: i=1; AJvYcCV2MmjmRU/kTtm2AVZwAr48fvSeCRuBNpzpiz8ELfDrLiZl4Ty1Vb9uODaWMc47laTC5vI68mAqlMNl49e9HMrTdR+SmyqHHR6Bjvsqv6YG8Wyow2qgQ4s3Gzlg0RE3JHxeWBlFzOSO8z0T46p2T4h4mA66f74njH9Gts8RD6Uf4Jlp3fc=
X-Gm-Message-State: AOJu0YwaLXFkjB9uycPERVQ0VCdh1Zy4DwazXyb15MIMhw19b35JgCL7
	MNeKV80Jfnmo2M0a0n6O3KhPVkEKLdmAjwDsyda4BuIfAKxg1uNf
X-Google-Smtp-Source: AGHT+IEjl28DHNnTcDOKcrrQgkmsbyO0K1hBgAt0eVjjLJ03dT44w2VLFfYWunJLIKjDEVbIXfLeGQ==
X-Received: by 2002:a05:6a21:2d8c:b0:1a3:a821:f297 with SMTP id ty12-20020a056a212d8c00b001a3a821f297mr4606950pzb.2.1713887799820;
        Tue, 23 Apr 2024 08:56:39 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:6f51])
        by smtp.gmail.com with ESMTPSA id gs9-20020a056a004d8900b006e694719fa0sm10119667pfb.147.2024.04.23.08.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 08:56:39 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 23 Apr 2024 05:56:38 -1000
From: Tejun Heo <tj@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Xiu Jianfeng <xiujianfeng@huawei.com>, viro@zeniv.linux.org.uk,
	brauner@kernel.org, lizefan.x@bytedance.com, hannes@cmpxchg.org,
	mhocko@kernel.org, roman.gushchin@linux.dev, shakeel.butt@linux.dev,
	muchun.song@linux.dev, akpm@linux-foundation.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH -next] cgroup: Introduce css_is_online() helper
Message-ID: <ZifaNsx9wFDp8m-_@slm.duckdns.org>
References: <20240420094428.1028477-1-xiujianfeng@huawei.com>
 <20240423134923.osuljlalsd27awz3@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240423134923.osuljlalsd27awz3@quack3>

Hello,

On Tue, Apr 23, 2024 at 03:49:23PM +0200, Jan Kara wrote:
> On Sat 20-04-24 09:44:28, Xiu Jianfeng wrote:
> > Introduce css_is_online() helper to test if whether the specified
> > css is online, avoid testing css.flags with CSS_ONLINE directly
> > outside of cgroup.c.
> > 
> > Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> 
> Looks good. Feel free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>

I'm a bit skeptical about these trivial helpers. If the test is something
more involved or has complications which need documentation (e.g. regarding
synchronization and what not), the helper would be useful even if it's just
as a place to centrally document what's going on. However, here, it's just
testing one flag and I'm not sure what benefits the helper brings.

Thanks.

-- 
tejun

