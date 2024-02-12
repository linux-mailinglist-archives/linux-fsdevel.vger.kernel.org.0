Return-Path: <linux-fsdevel+bounces-11245-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 140188521B1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 23:46:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46B771C223A0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 22:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E9C4EB44;
	Mon, 12 Feb 2024 22:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PtdQpm+C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E364DA1F
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Feb 2024 22:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707777944; cv=none; b=dV8T2hDI8s6txrT4iMAp6sdejkkZcsZwhAxsJlzDRodT5nWKtuQaYy45HU5a1Vcy1/lz0HGjvfrhcrUpeaWuStwU6JMqTZBpXFr75yXfJ7w0HKOCPi3Ktuncaok6zQBhyEcei0bpIfshkDA8q+iRFFbAk4TOrkM5dJlDiZf/FGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707777944; c=relaxed/simple;
	bh=Lqi+dtaPDt0Cdp8tkYw4ZeZ7cvsn7QQVayGZiang7cg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LZ1hf3MGRRnm4OV+UdW65XW1XmZVopLcqeDvwC/bkQZMIm5YZXUgOePRYaZ7QBSRzOP5HovbQZvj99Rh9k5WjFYfRGWqiyjkvxhWeGYCnL6OrwI4hCJMiK/uazi5e2VYmjxdLRE+zhtOH9PJqDTuC8e31f87T67vI4i2N9PzBec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PtdQpm+C; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2184133da88so221489fac.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Feb 2024 14:45:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707777941; x=1708382741; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M9x0GXj1drWEZHiTvKM8aFvDBLB5BYp9bLGNurXOzwk=;
        b=PtdQpm+C24YhPzBvsh4VLhtbz8qSZM4nDhdlXlO50cL5rfoNWIYqmLDMQUi8bh3gJI
         vZU3wGoBksl9jBMgito711zFJUdjiHzzWt2DDz5m5suZxamdPBHvpa+T8tsZhOnFB63Y
         SKAl+YwD51kRDmRfiRrR6Vb+Ic02/lX/R0LOo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707777941; x=1708382741;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M9x0GXj1drWEZHiTvKM8aFvDBLB5BYp9bLGNurXOzwk=;
        b=HsDwgg/v2OpXuKJePnqXfvIAEVQpHc8PtyOpIG147rue3VYFBz5+2TUbQ10eTcT+Si
         ko1AFexJH+0MYyB3qP5A/XIv2SbCx/o+4Pp84WYKGBU9yFUTmIxC2dhHW7z9xGoig4UA
         wE7GW7A8QUqdQDYsrHmN8ukiHPKtEW4faZeWgMAbLVxeCQxADD1o9+7yxGEZdTGSIste
         tdjSM0W4Qqd0ft7BIIpPCFoy17WNfPWXxpY2Xes0siPw7mbOOUYS7EJ5aMfa092j69Rm
         T394b3yCiiAsaVqUN53Eyx6TEhS1CjolI0OFFrSZqwRtHPhIssjFku6Np3OmYp+Sawn9
         N2dw==
X-Gm-Message-State: AOJu0YxJRmUx5oBAMudx6mpL5VlD8lh5RbsivKDhlfD9en6efriScwzv
	SWOmzN3reSfn/s5aILWcED3xFeOdDKje4lSosiQpEkNoKc3B0IAD3AHKf9loGA==
X-Google-Smtp-Source: AGHT+IGuY9FmZ07bxpDu9dvbVIeyQS0ooYEchWwZGi6xaPkWpNmcABhEn8slFi/ITrVyu8oP/VENLw==
X-Received: by 2002:a05:6871:521f:b0:21a:43e6:9479 with SMTP id ht31-20020a056871521f00b0021a43e69479mr6494394oac.25.1707777941191;
        Mon, 12 Feb 2024 14:45:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU5F04iljKWgIhFX67fz6I0jBA29fs1KValNbI20GQ721akFaZZswko9rHZyanWImombY2MRxlAp7+1vnmOqFP7q3t71cIchW8bu03KW0mwMJ09EDhrMyT10XPJaH9Bzb53bFzuM4BfNnrmZpnY5B+/fkfb74fuUtg23PbdKoYURrf6KUG8I3oX19u7Tt+W5BZUjko7u4hrdj9G7NJMAZUxEfnlfmwQybY2KYzaip7/GPxsca5fxpskYZOzkyWm7W5EXnVeqie8w9GlyWjw+1HLCFKyvdODwZ1IAzj8OJmSifxvqrB+SJgeRE6+2anrYiQ5CQ3OjrlZ9MbV4U+AsezFTvbF6SHAGsCB9zkYD6wuU10oKJx6qhY3nZcIWpFrTI0zoVY91oEChX9Ilp0TaOpzYN6r/7qCg0nZllRlWzOLnsd/YEQdhMMJ6gLqwfDgNp2YRYlwnaQXK0Pw/BArGG70FUDSnkDDzFfQyOMSqoQNMuO+6IPIGk7ltANLWIORmwbgcT2nIrOcqp01sEzZA0WJvdCTUITvforW3LWpoZE0x07bDes7lpFpCZanVON8HwRF9g5REXHwY5BM3xpjm9HkhaLKOuRcm0MVmwEXk+H3VpM0Mv5NVf91BClEFo+/4ig+2QwEfLffPJ1oQuLBUNtltszsmR2I850mAt2Cr1muh7xK43zUA2hQPHmJRY2OSYWwRbDxjUCzVMOxgXPe2IHMYsDVzu6vfog4TBGWlcB6TbpX8ZqcbQ==
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id t16-20020a63b250000000b005cfbf96c733sm987037pgo.30.2024.02.12.14.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 14:45:40 -0800 (PST)
Date: Mon, 12 Feb 2024 14:45:40 -0800
From: Kees Cook <keescook@chromium.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, mhocko@suse.com,
	vbabka@suse.cz, hannes@cmpxchg.org, roman.gushchin@linux.dev,
	mgorman@suse.de, dave@stgolabs.net, willy@infradead.org,
	liam.howlett@oracle.com, corbet@lwn.net, void@manifault.com,
	peterz@infradead.org, juri.lelli@redhat.com,
	catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
	tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, peterx@redhat.com, david@redhat.com,
	axboe@kernel.dk, mcgrof@kernel.org, masahiroy@kernel.org,
	nathan@kernel.org, dennis@kernel.org, tj@kernel.org,
	muchun.song@linux.dev, rppt@kernel.org, paulmck@kernel.org,
	pasha.tatashin@soleen.com, yosryahmed@google.com, yuzhao@google.com,
	dhowells@redhat.com, hughd@google.com, andreyknvl@gmail.com,
	ndesaulniers@google.com, vvvvvv@google.com,
	gregkh@linuxfoundation.org, ebiggers@google.com, ytcoode@gmail.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
	vschneid@redhat.com, cl@linux.com, penberg@kernel.org,
	iamjoonsoo.kim@lge.com, 42.hyeyoo@gmail.com, glider@google.com,
	elver@google.com, dvyukov@google.com, shakeelb@google.com,
	songmuchun@bytedance.com, jbaron@akamai.com, rientjes@google.com,
	minchan@google.com, kaleshsingh@google.com, kernel-team@android.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, linux-arch@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-modules@vger.kernel.org, kasan-dev@googlegroups.com,
	cgroups@vger.kernel.org
Subject: Re: [PATCH v3 33/35] codetag: debug: mark codetags for reserved
 pages as empty
Message-ID: <202402121445.B6EDB95@keescook>
References: <20240212213922.783301-1-surenb@google.com>
 <20240212213922.783301-34-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212213922.783301-34-surenb@google.com>

On Mon, Feb 12, 2024 at 01:39:19PM -0800, Suren Baghdasaryan wrote:
> To avoid debug warnings while freeing reserved pages which were not
> allocated with usual allocators, mark their codetags as empty before
> freeing.

How do these get their codetags to begin with? Regardless:

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

