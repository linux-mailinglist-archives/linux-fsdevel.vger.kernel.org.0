Return-Path: <linux-fsdevel+bounces-52615-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 624EAAE4866
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 17:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D298C3A972D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 15:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739FE28AB07;
	Mon, 23 Jun 2025 15:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mjsgMC/x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B668287519
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jun 2025 15:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750692153; cv=none; b=rSNtpaSQMb3U7HIdMRONfmrq0K3GmHOH7vt8yOyUv/iA1Hgf8Ddo8gcdG1KcqMQvz/++Zq6ekKxrwx4WObmbT6jF+T2Nu153XvJeF/hHI1dlPDQt8Cdd/wnULHVpbvsqu/xbV2R6C1drcm8czXg0bVdHDu2oI3C2J5h8ZjAFIcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750692153; c=relaxed/simple;
	bh=hC9peFQk5TvNNRSqpIuY+epye1/M+kNum1ROmrB5xQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f42W7HyPAiZ90y8lQT0qtF0mO1lrKb3ag1U90vpSWjtsu5ZJOhRSWgl37ekOpVYgm/dsawbaizik0Z7XeMhB5zGAlUXt/oU/OmTW5dziW8uHCt0g7D+0YFVjSIvr1qEzIrVdySfYbPt/LH+taGpZmIVKQS453jZigE6wamifOfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mjsgMC/x; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-6116d9bb6ecso1087183eaf.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jun 2025 08:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750692151; x=1751296951; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bTZ19GRi4KU0H2wNqBnaKkKrv7m6rpdyKuL2QkFh6uQ=;
        b=mjsgMC/xD/7Nu42Lgf44FhzejT4T/f/JDGVCRMV/3hizQOfqv7Nmnrf3s4Rh8gb/Pw
         CSExBLuoDGt4qh+QwFjy6n+w8gZHLhfIZ+085HpT06uJXGwug8J5FM0ialJCKFEblggE
         kd/2/mOPQrPieF6u53cs3Z39hf4GQBu5a6f8JhvMjLATQ6dy+WLiMfyS+zqZCR/c4K2f
         pH+1R5JQxEi+SbAdVLFp2Z5dkaHoRGMRs+fN8sPYHgVEB+49h6TWu+TJ6ncozrliVymC
         LmJli29nXUns52jR4ZM6KmXDAeA6TtEhO1MGsL9ikZCuXSJGzfSZW2DPDyNdUbc7a5II
         g/gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750692151; x=1751296951;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bTZ19GRi4KU0H2wNqBnaKkKrv7m6rpdyKuL2QkFh6uQ=;
        b=f4t4Xe5z+PyIYAlXHMDCqIWx5MKpLFFXPSuPlSsC7og2DSNeyIzQNQMZBeaagxDeSB
         5A2G9Q7N3eKS75t2YQo2p4eFQ/a0saBhdl7uDbYHMYP5FnE3l1wCXpNW4Ib9v5KmWEET
         X8S04+3zumhzvvxezX1wYMLCQHkQmhhDkIif8517gMdI4o2XFF8GvaFSuy0Fr1E1Vu/5
         GMha02svqByKWUiqzVi/UKSriKLyRG1i+ItzOCGR6WLEM3a0S4cGwdvUkymGJZVValyp
         71XC4G7cO7yWEby8lIpnhr9siQO6GP0UO4BmUELkF0WF4iZemXkvcamxFQXQxuA7uXRo
         ZuQA==
X-Forwarded-Encrypted: i=1; AJvYcCXp3tFPrNqDfDtFdxmRrkiXFm4BjYAqW6neECmP2+tBeLTAccOzyYrxzb1/WO+XbXlN1fL7v2HyTGb2dLki@vger.kernel.org
X-Gm-Message-State: AOJu0YyFHzaIiDgy1MtUx3ykdWf2m8RJ8e9wnOlxRHtcT35A4MLZCFWm
	Ul8I/lZrwfoBEmJmUxCn11jL6RJkoZwdXJn18vU7kCY2+avgnb0aBO9LjHN+HLwuDCx6zFSfUvO
	gHojy
X-Gm-Gg: ASbGncvWtlXuJZ8m6jNVg28ufZpMJevZazjDmzOVDCAqC/vyH/fuZBD/t7j0P9EzNHV
	MRGF7ZY9KwpAobgoRhGhx+MJblLS8+FnQ5tuWrOjpBXzS8x3vPHwz66eO54WK2G9vgV5EC4wZDF
	GnA3luZLJIzsxwluB3qkNsk6Zyy5TaaXJIBJdPEowpYoDR7fs8M0BpK3NruCYN5+iIDwDjAt+Xe
	mY0onMPGREo35lM1k0H62xmhWIi9xuzPf0hEl22ibOdcJeaXta90ed2XHE1c+MM3gmb+2F0xU67
	k94FQynfC7lvTgm/Y9k82CGce2YbOgd9c10/93AobmY9XnrczB5tmqcF7xcuDrgRq3ZgOw==
X-Google-Smtp-Source: AGHT+IFkGyVDoc+8SQ8rASYfcEKGGB/Oc5hw+KdWNqGCuf0XX49CDwKCA3KtlNIgbDKU0n0iNbw/gw==
X-Received: by 2002:a05:6870:392c:b0:2ea:8091:41f2 with SMTP id 586e51a60fabf-2eeee55c8cemr8102044fac.19.1750692151278;
        Mon, 23 Jun 2025 08:22:31 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:8c3f:8b5f:5c74:76a9])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2ee8a8e5eb3sm1697426fac.32.2025.06.23.08.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 08:22:29 -0700 (PDT)
Date: Mon, 23 Jun 2025 18:22:25 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Baoquan He <bhe@redhat.com>
Cc: Su Hui <suhui@nfschina.com>, akpm@linux-foundation.org,
	vgoyal@redhat.com, dyoung@redhat.com, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] fs/proc/vmcore: a few cleanups for vmcore_add_device_dump
Message-ID: <d60db71a-0b4f-4e7d-8c06-7493934aa507@suswa.mountain>
References: <20250623104704.3489471-1-suhui@nfschina.com>
 <aFlmfdajTOP5Ik9f@MiWiFi-R3L-srv>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aFlmfdajTOP5Ik9f@MiWiFi-R3L-srv>

On Mon, Jun 23, 2025 at 10:36:45PM +0800, Baoquan He wrote:
> On 06/23/25 at 06:47pm, Su Hui wrote:
> > There are three cleanups for vmcore_add_device_dump(). Adjust data_size's
> > type from 'size_t' to 'unsigned int' for the consistency of data->size.
> 
> It's unclear to me why size_t is not suggested here. Isn't it assigned
> a 'sizeof() + data->size' in which size_t should be used?

Yeah...  That's a good point.  People should generally default to size_t
for sizes.  It really does prevent a lot of integer overflow bugs.  In
this case data->size is not controlled by the user, but if it were
then that would be an integer overflow on 32bit systems and not on
64bit systems, until we start declaring sizes as unsigned int and
then all the 32bit bugs start affecting everyone.

regards,
dan carpenter


