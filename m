Return-Path: <linux-fsdevel+bounces-21332-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD69902147
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jun 2024 14:09:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69DB8289316
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jun 2024 12:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 304D87E782;
	Mon, 10 Jun 2024 12:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="laOP8BrV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3049154650;
	Mon, 10 Jun 2024 12:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718021346; cv=none; b=N8ItAHhP89KRx+VX4OwVHevdQUZcLjDD584QLLTq0AABXdslCMTmGeax9kq2oF00EQVvmhIsSKN4WG5VaQtXC6nZPNPhMh5n9t21DNUa77LcgM+5SXEEFwGczdm/VdA7P2QIdkbtc6Dx/N3AAE+O8RRtdJW6Ht5DIcMWjgEMJuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718021346; c=relaxed/simple;
	bh=EkPqiitp/s+o/EIHQRHjGKUfe24uDcHdHqJVwdJjMIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XyWHKsvDFiIPDGtlA+ix+LGHbhF/xihbuWYmsnGSE1Y5CK+/yY7veO2m/OUevb4da2CPXaRPwBxUdI2d+uERBQgEgpg49XDpK6xpNQFYao0kiapdgEadu6Lq8k4UxQW9+IWWKNlp3sbUpIjcJfjB3JTNJD/cVdb4SPZXYP0vtyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=laOP8BrV; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42172ed3487so20280375e9.0;
        Mon, 10 Jun 2024 05:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718021343; x=1718626143; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=apVqcXL9lrOzuOLGQh5x40UV8pu0NEr96vpgIcVU4iE=;
        b=laOP8BrVOvSko+itgoI137lAEBsb76GvpqDdHXeZaMDUVCS00wBpk7PpCCUGVmUoGw
         2OuctTVa+fQerbCzD4ivCseJcFj8O6vKGL1EeX9sMKydhf8/x9pxHJWv+NSYOqRcZ4l9
         Z1OJygklxII/x9cTb8W17pFu1CDTCvnSuGiB9bCWmHLedtNwVUnxORW5t+m0H0NehOh1
         Qsj0Bpwptrmv3L7o1SzLRru5rmjMUWTls4gK0zkozgaRcD5tAPxKgBvprjmvKAsE7BnM
         hPP/68H/Nh08Ny3DNBjoNEB6sfWqsIHwpe/PW6Dm1ucayn55h1wp+UDIyNSyiqFZVIwS
         P2Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718021343; x=1718626143;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=apVqcXL9lrOzuOLGQh5x40UV8pu0NEr96vpgIcVU4iE=;
        b=aydycfW3yDjWNBskR9vYSTJvr3hrDB8l6iBgt98cgnPW5+ppHJwZmerbe6MSkLqh7o
         8uPEk4WQPT35JEflivrxsqSDBzyECMGCNcF37oQva/GIWQSEZII49LLAK/gWYjBLsFI1
         gq2I96IjjH3dpZyMDgQ6SuHouHx7X/iu+05dxAGWMK7FBxAqhWDmYcW9z6LQByNuAzWT
         +CWubVExtuJeTUFHKuqsT68i7cr/jLakvMrFb1cyuSXjVT38AKCmhtRM8lxO9dXXFoer
         rI66JGduLwPDbVv7H9NMMzY6D+yu6p4JzRG1C6nJcpzRMlee1rWVzf7T5d0NnO5kYqLw
         YLJA==
X-Forwarded-Encrypted: i=1; AJvYcCXs+TPznGq20Qi9ImFGD32vX4Rju0LQ9ktLBLRFpxGpGKYfsw8v20rQq6DEA5+hJo9SQDZDXzB0n9lVszStESzGqkkPDPCnerJj14uy+bVXvK2va1vBM8Y9C6KQ0dV/NWg533gjUEzrIRf+Oq2DEOPfVoIpZPaG2MUA+Chjx4OjbA==
X-Gm-Message-State: AOJu0Ywai3yQKYznctjb/Vrp8zRz/AEG1U4hHYadR6ItQ/e+SxMZlktF
	0borWzHbZyVnKzyh8YmJ8rurzOA+it+2DktdNmTGsI7KhK4arvaL
X-Google-Smtp-Source: AGHT+IFS34cqEsQzbUKkcie6x+4KgzOo9PFp7UFbb1ysTHKUIHpW5eU9L97m8xY99U5A2y3erqxQBQ==
X-Received: by 2002:a05:600c:1d04:b0:421:7435:88d7 with SMTP id 5b1f17b1804b1-42174359fe8mr58915745e9.26.1718021343326;
        Mon, 10 Jun 2024 05:09:03 -0700 (PDT)
Received: from localhost ([2a00:23cc:d20f:ba01:bb66:f8b2:a0e8:6447])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421c9d24b6csm37552125e9.30.2024.06.10.05.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 05:09:02 -0700 (PDT)
Date: Mon, 10 Jun 2024 13:09:01 +0100
From: Lorenzo Stoakes <lstoakes@gmail.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Suren Baghdasaryan <surenb@google.com>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Vlastimil Babka <vbabka@suse.cz>, sidhartha.kumar@oracle.com,
	Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org,
	bpf@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/5] mm/mmap: Correctly position vma_iterator in
 __split_vma()
Message-ID: <119b01ac-a57a-43cf-90ca-093e850c4b7e@lucifer.local>
References: <20240531163217.1584450-1-Liam.Howlett@oracle.com>
 <20240531163217.1584450-2-Liam.Howlett@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531163217.1584450-2-Liam.Howlett@oracle.com>

On Fri, May 31, 2024 at 12:32:13PM -0400, Liam R. Howlett wrote:
> The vma iterator may be left pointing to the newly created vma.  This
> happens when inserting the new vma at the end of the old vma
> (!new_below).
>
> The incorrect position in the vma iterator is not exposed currently
> since the vma iterator is repositioned in the munmap path and is not
> reused in any of the other paths.
>
> This has limited impact in the current code, but is required for future
> changes.
>
> Fixes: b2b3b886738f ("mm: don't use __vma_adjust() in __split_vma()")
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> ---
>  mm/mmap.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 83b4682ec85c..31d464e6a656 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -2442,6 +2442,9 @@ static int __split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  	/* Success. */
>  	if (new_below)
>  		vma_next(vmi);
> +	else
> +		vma_prev(vmi);
> +
>  	return 0;
>
>  out_free_mpol:
> --
> 2.43.0
>

Looks good to me.

As Suren alludes to, I agree that it's important to comment to indicate
that you want to move the iterator to point to the VMA that's been
shrunk rather than the newly inserted VMA.

Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>

