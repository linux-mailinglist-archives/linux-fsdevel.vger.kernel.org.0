Return-Path: <linux-fsdevel+bounces-47368-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA1BBA9CBB6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 16:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA2177B6C5B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 14:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146992580CE;
	Fri, 25 Apr 2025 14:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RxOyhFHH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319E949625
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Apr 2025 14:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745591429; cv=none; b=Mlo1IJOSdpTG6a+1do/DBwaY/7/zy9cfF1JWhV66nh8CLEjHCU/D1njGIgE77f1Iga1TS5dL3U1oiBkOEsjwHnlpizC+Gc6SEa5tHDF4mHLohEd91C07RCuB0YCwYra/CtcAL6cNuPkdUBY8yXir4Hwr0+GywFnMm1umI693+XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745591429; c=relaxed/simple;
	bh=tbbWX6HQudcj6WllaqRV4e2ZqySM05yb5u5Fj7YkR2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mjjB0HZFcePerk0gURRoGWItMgUB/FIFLhknbZOfx/Mid0LWG+D+7BS1zE8YtJda/pR8Y1bqCRofKhbOt97bLMLKp686DM28NNVdzfIq2s6iFu5iReVUrRWvCc87jbZ9y9bCzs0Na5SVSSIazlW8xaTS+m42wQg9fZ6KvqaNa24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RxOyhFHH; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5e5deb6482cso6084022a12.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Apr 2025 07:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1745591425; x=1746196225; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j74g0URpy2yWvecE4j67oIUdAbRXvhX28LV7KaTwwlo=;
        b=RxOyhFHHySLNjORdLYc6UfcdIpClx2swY6+xTSzICrPogGFlZH77oUnpHUVsHkx5bL
         pYc4PFtgMZVBHkd52DSN2siVAkFZDv45h9MHwfcJKRewD1THfJZvGDKwogJeeGizRcxX
         QkyKII/kKL27RGC9FhapcZe8LjjeeehrgaUAHCD9OsHIB4LeiriBkYO56dXmgCXf8Y3T
         FyyiS1qoN4pPivLRTXCy2gdxyqfmrNmvLQB7aqP8okQFtYXSLknYDnG3wFltBSh2y867
         nWmRWpA1rPPrIjBUuIAzg7qafd/c/IqZUwKzinqqlu7btCmZ5iWxbKC0AsviMSBis4aF
         Z8/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745591425; x=1746196225;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j74g0URpy2yWvecE4j67oIUdAbRXvhX28LV7KaTwwlo=;
        b=n265Pmjp3JA2vIbi90g5v3Gas8OAl8g658m/XdqlU4JRYsNXNoIvk4dNjVS5T9vmms
         wNfKXizoftklFJDsyfjDhTNKWHlXAWdTPq0470IXq7ve3uJ2Rt7ZRn39QGG9B5E+R5dk
         dbmusCqzGERp1EthLYDlihmMeGqLrWnDGFFVrPV1G4Chk/6qaAgZnI64ZLZC2449z1Hg
         SgxeVVDiXW1ZJ/2NXpWl4M28WgAk/kqMunFzBFhhPcbWFqJzYiZhLz3LRzohHvNdmpCt
         OMNPxp4hjludp8NdLub7BfepO9djYcLmgPotwDKXKBuJC/eqal4U6DO7SbsJn1smKKN/
         cfKw==
X-Forwarded-Encrypted: i=1; AJvYcCWAGpiTmAV5vMD38pzake5Sabm1aYuxLTt8LqtVB4Xmu+O639IQQWK4hY6lFdBhQkE9qO8BfwHdZ+hQilQq@vger.kernel.org
X-Gm-Message-State: AOJu0YzoXvgT46batkqxR0hmNeEXCGoidqF2fj9ePPSlOoqNMSVGv06G
	7pTe3WdOssSNGLIrjXwPSSmCBlWAW8DSFtBR3ZX8s6bekgYx9LVsLeeYj+9Ye6Q=
X-Gm-Gg: ASbGnctjGc2rcZpJ8SxBk2agHvt1NghzM9txjQVWfIUBnPFpfia9jGEyySEgcdIz1O9
	yd+jAw8+kTFGFm5phDi4C8zYkGWC1qzh9CNtuX55371akCl/c82zplgqCqFffOO1MAxU8nPZ6r+
	wh1dmU88DRN0uUEopKvJCuwH0YPfILmv8c0ZulVvCQTcBKShHDfRmhsU+XduNbZyhVu5l64L8nf
	wtEqJPNh79LBqpwKU8vQHy5N5sZ5vhIZP2i8ReySJlC3KDHk9/mWtS99xQvMgnPR5COc2orOuSL
	9b2WMThUg2zcSjvp9XCEvlK+EXiXzuYxK3VjKgtgytd0EAOyh/Y4GQ==
X-Google-Smtp-Source: AGHT+IGDm9pL00HKU1hLSaiCp/68Y35OaNOhMktC6eooWXoNrwjpnl1XGdDL2ZIbCvWzDzDf7s8gLw==
X-Received: by 2002:a17:907:1c98:b0:aca:aeb4:938e with SMTP id a640c23a62f3a-ace733d15ebmr228127466b.8.1745591422471;
        Fri, 25 Apr 2025 07:30:22 -0700 (PDT)
Received: from localhost (109-81-85-148.rct.o2.cz. [109.81.85.148])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ace6ecfa375sm143163866b.121.2025.04.25.07.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 07:30:22 -0700 (PDT)
Date: Fri, 25 Apr 2025 16:30:21 +0200
From: Michal Hocko <mhocko@suse.com>
To: xu xin <xu.xin.sc@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>, xu.xin16@zte.com.cn,
	david@redhat.com, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	wang.yaxin@zte.com.cn, yang.yang29@zte.com.cn
Subject: Re: [PATCH RESEND 1/6] memcontrol: rename mem_cgroup_scan_tasks()
Message-ID: <aAucfUFeqHBaHfKs@tiehlicka>
References: <20250422191407770210-193JBD0Fgeu5zqE2K@zte.com.cn>
 <20250422111919.3231273-1-xu.xin16@zte.com.cn>
 <20250422162952.19be32aa8cead5854a7699a8@linux-foundation.org>
 <aAjbb1fBR-tq1h93@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aAjbb1fBR-tq1h93@casper.infradead.org>

On Wed 23-04-25 13:22:07, Matthew Wilcox wrote:
> On Tue, Apr 22, 2025 at 04:29:52PM -0700, Andrew Morton wrote:
> > Patchset looks nice to me, thanks.  I'll await reviewer feedback before
> > proceeding.
> 
> I thought we had a policy against adding new features to memcg-v1?
> Certainly adding the feature to memcg-v2 would be a requirement before
> it could be added to v1.

Completely agreed! Is there any reason why v2 was not the first choice?
-- 
Michal Hocko
SUSE Labs

