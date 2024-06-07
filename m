Return-Path: <linux-fsdevel+bounces-21277-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C872C900E15
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Jun 2024 00:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3687BB22EF3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 22:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B69155723;
	Fri,  7 Jun 2024 22:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N3uP4yAK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE4BB64E;
	Fri,  7 Jun 2024 22:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717799480; cv=none; b=bjhXCemxdcW6VUDlgZzou0H8wR5u6+mN+BBqZHanB0N+Jovy4VdJckOpgSM1uNwsGyknVh73krM9EGeblzY/ormhs464uvuSRUS3N8+uPH/fXvRhQnuizsf5BOWN7Ircu4RtGGwfBa1T05gxXd+Fs7oNXxVrP70QuN4WxsZx9Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717799480; c=relaxed/simple;
	bh=kjMCCfEMnIyHsw2hSOp7vwwON9/MC/NR8qEp0t6lYxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pcg/yePT2uPJDJWtp0jEl+7Bc+3TTiDzEctC05zKPoFw1oepPxrbVpVoLD+YGeMeC3CBWNWH2X9tWAiFEpeZGxR82U1SKULN+06eyKr+CdQCfIRoZdH57c45iW4tCXWQqL0nmilemsW1OfftLl8qAK9uq9Q5CkTYep0FvLAINio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N3uP4yAK; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-704090c11easo1525646b3a.2;
        Fri, 07 Jun 2024 15:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717799478; x=1718404278; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=obfZVFisODphXwHU/3O5DPDvWPieNCLI3FYHc2yEtOk=;
        b=N3uP4yAKwKllKFEAbxyeVPuXA+OOKHzP/5JkMw0/mEqonjlpMd2BpwZdyHNXhsTpdU
         /Xhy0KD9WS4cIPVlAetra7aX7ywZPPRIWL10Q5YeSuH1ZW9JgLS6CTxNmJNw8ruNOXTE
         K+riMPWq4pJ8E6JKV4szP9lxIBHXa0qTDAGNkFvInQcOdqtseBXd8/PgvYSAGC7OdxFx
         oUI05GjlhK4jYSXY8Ds09ipdEQplrNiKLtjXV9H9GIborI/ceMTjPX3b60BuRaaifEUW
         8jH3tRa51yHd2J/XwmryMAnvNtautUAP+OK+eoLpHJr+6UeDo9SHEXPQJKWOhKgOOXNH
         9MtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717799478; x=1718404278;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=obfZVFisODphXwHU/3O5DPDvWPieNCLI3FYHc2yEtOk=;
        b=Ld7uBwjoNMfXmFgMp+MOcQQpqGBE6809kW6+uR48AlZKCouGgkx2f9nMw669kW+bfP
         /8cUNmHZngZdCik8TuCYn/0/Tt8Ntfvr5h5LP1gYjAIOb5GEXNEjMRgKsw8TnbdkILIn
         tm5CDXYiZ8h4Gr1Kjx2EROBvB58/tnGxQAGd1tIx7Yc+/Sc++wIYc1MmAF+WbOYnTPVz
         r+4AC3m4N9x9ZdTLKiaLRSlWXeUIqK6FZzsS1pRnrn/grGbi8CNKC3U8Up3E1u2eqK1M
         x1GR153/Tt12GJRSAVzDY8Si0hZ6UktXMIsOM4VgSCtO4/pwgEZsQttk8np8CUQz9KeH
         UoQw==
X-Forwarded-Encrypted: i=1; AJvYcCWmFAXzKLnu5KP3q2rjTrJEOm7uxrVTtqgQvPZ0ytMzKHNDNKsotCYv5iZAndnaAjZKzNlLX03pY0LcycvGOoqifO8u82tztK76iJk++5Ji+PDTrHfMFey24zRgqPMyd1ha
X-Gm-Message-State: AOJu0YwN4/lRADlUGE9ghibaRlfne3/u/F65mmuMYw/ZubZ/erS6UKvQ
	3vQo22ZPF8eOUvpukQankUCaKQvdCDpZlONba0165u9WtuDjFz+l
X-Google-Smtp-Source: AGHT+IGlQ0lxj1IEvcN59nlMqfLXuYCBh2oMVRoEcf266PGOYI1SSB4rfK1sXt2gLQisCPNFM0oxLQ==
X-Received: by 2002:a05:6a20:12ca:b0:1a7:878f:e9a3 with SMTP id adf61e73a8af0-1b2f9a297cfmr3908259637.22.1717799478325;
        Fri, 07 Jun 2024 15:31:18 -0700 (PDT)
Received: from gmail.com (c-67-171-50-164.hsd1.wa.comcast.net. [67.171.50.164])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-703fd3780absm3024193b3a.21.2024.06.07.15.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 15:31:17 -0700 (PDT)
Date: Fri, 7 Jun 2024 15:31:14 -0700
From: Andrei Vagin <avagin@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org,
	viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	gregkh@linuxfoundation.org, linux-mm@kvack.org,
	liam.howlett@oracle.com, surenb@google.com, rppt@kernel.org
Subject: Re: [PATCH v3 3/9] fs/procfs: implement efficient VMA querying API
 for /proc/<pid>/maps
Message-ID: <ZmOKMgZn_ki17UYM@gmail.com>
References: <20240605002459.4091285-1-andrii@kernel.org>
 <20240605002459.4091285-4-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20240605002459.4091285-4-andrii@kernel.org>

On Tue, Jun 04, 2024 at 05:24:48PM -0700, Andrii Nakryiko wrote:
> /proc/<pid>/maps file is extremely useful in practice for various tasks
> involving figuring out process memory layout, what files are backing any
> given memory range, etc. One important class of applications that
> absolutely rely on this are profilers/stack symbolizers (perf tool being one
> of them). Patterns of use differ, but they generally would fall into two
> categories.
> 
> In on-demand pattern, a profiler/symbolizer would normally capture stack
> trace containing absolute memory addresses of some functions, and would
> then use /proc/<pid>/maps file to find corresponding backing ELF files
> (normally, only executable VMAs are of interest), file offsets within
> them, and then continue from there to get yet more information (ELF
> symbols, DWARF information) to get human-readable symbolic information.
> This pattern is used by Meta's fleet-wide profiler, as one example.
> 
> In preprocessing pattern, application doesn't know the set of addresses
> of interest, so it has to fetch all relevant VMAs (again, probably only
> executable ones), store or cache them, then proceed with profiling and
> stack trace capture. Once done, it would do symbolization based on
> stored VMA information. This can happen at much later point in time.
> This patterns is used by perf tool, as an example.
> 
> In either case, there are both performance and correctness requirement
> involved. This address to VMA information translation has to be done as
> efficiently as possible, but also not miss any VMA (especially in the
> case of loading/unloading shared libraries). In practice, correctness
> can't be guaranteed (due to process dying before VMA data can be
> captured, or shared library being unloaded, etc), but any effort to
> maximize the chance of finding the VMA is appreciated.
> 
> Unfortunately, for all the /proc/<pid>/maps file universality and
> usefulness, it doesn't fit the above use cases 100%.
> 
> First, it's main purpose is to emit all VMAs sequentially, but in
> practice captured addresses would fall only into a smaller subset of all
> process' VMAs, mainly containing executable text. Yet, library would
> need to parse most or all of the contents to find needed VMAs, as there
> is no way to skip VMAs that are of no use. Efficient library can do the
> linear pass and it is still relatively efficient, but it's definitely an
> overhead that can be avoided, if there was a way to do more targeted
> querying of the relevant VMA information.
> 
> Second, it's a text based interface, which makes its programmatic use from
> applications and libraries more cumbersome and inefficient due to the
> need to handle text parsing to get necessary pieces of information. The
> overhead is actually payed both by kernel, formatting originally binary
> VMA data into text, and then by user space application, parsing it back
> into binary data for further use.

I was trying to solve all these issues in a more generic way:
https://lwn.net/Articles/683371/

We definitely interested in this new interface to use it in CRIU.

<snip>

> +
> +	if (karg.vma_name_size) {
> +		size_t name_buf_sz = min_t(size_t, PATH_MAX, karg.vma_name_size);
> +		const struct path *path;
> +		const char *name_fmt;
> +		size_t name_sz = 0;
> +
> +		get_vma_name(vma, &path, &name, &name_fmt);
> +
> +		if (path || name_fmt || name) {
> +			name_buf = kmalloc(name_buf_sz, GFP_KERNEL);
> +			if (!name_buf) {
> +				err = -ENOMEM;
> +				goto out;
> +			}
> +		}
> +		if (path) {
> +			name = d_path(path, name_buf, name_buf_sz);
> +			if (IS_ERR(name)) {
> +				err = PTR_ERR(name);
> +				goto out;

It always fails if a file path name is longer than PATH_MAX.

Can we add a flag to indicate whether file names are needed to be
resolved? In criu, we use special names like "vvar", "vdso", but we dump
files via /proc/pid/map_files.

> +			}
> +			name_sz = name_buf + name_buf_sz - name;
> +		} else if (name || name_fmt) {
> +			name_sz = 1 + snprintf(name_buf, name_buf_sz, name_fmt ?: "%s", name);
> +			name = name_buf;
> +		}
> +		if (name_sz > name_buf_sz) {
> +			err = -ENAMETOOLONG;
> +			goto out;
> +		}
> +		karg.vma_name_size = name_sz;
> +	}

Thanks,
Andrei

