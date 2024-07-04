Return-Path: <linux-fsdevel+bounces-23125-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39CB7927689
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 14:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7FA91F22835
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 12:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2758F1AE847;
	Thu,  4 Jul 2024 12:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="spbv8AnV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280DF1ACE88
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Jul 2024 12:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720097794; cv=none; b=Cks+W9omImSqEYJohXzgfCl/F8hFQxNH4SKs3jZvHcIW7SK6EcmvWPbt/XmDwT0AcCdhu5vY1SK0IJd7ISyVuimsN2FrtAxAidNL6W7b/+CTpo6hZF1Hb4z4DnvD76qwUSRz16uu1zSGIRJaSDqyr/+GWtU8TPxls3Dyeb1uVGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720097794; c=relaxed/simple;
	bh=/9zLhHeUel9AqeBH7jq/R8SwhtzjDAix34n+9uznz9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sBtbZdNAxm0zP9hohGnnQRNoXyvYVBJwJCWatH/jlMYEOCQfgAFY5z5XZfx/6eReZUq176Bbv3MeYNLqDg/2eO55ULhp1GfrS6qt8YWgKllt83vbwfpBF4XyAAmtjYlwzJwZl1SWfyApHlpaA2nG8rKhi+p+ihtoKF5wdjIBKvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=spbv8AnV; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7021dd7ffebso353436a34.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Jul 2024 05:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1720097792; x=1720702592; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cjid4GTFzfR09h4v9US7cG+cmJ1miiJzUsalhJBWqP4=;
        b=spbv8AnV9FT9T0wVcvYbWI5jm9ZEFPsgAB8c2YRIzqCQIS7BQ+YUTWvwLv0RgsU+b1
         6lwhZv3+C8pKfcwkjRc4AEi8xUQMToSTW72wpoi1qRM55/qVRCKDDqu7acGCXFqxnp/s
         sOeiSBlN26RI/iuvHL/eN1+k0+0MnedrEH5W7/C8QjdUYA/c9RqBmgWktR9Fh1lki0dr
         kpOkFKu/xP3E5QpvdGdsVB2hL2v5WynkZ3+62Qg91BehL7ipMKUcMh66jf5mom2IYO0S
         syA3aXAaRyfu0N08c9mJM5ogA+KuqobkY90PszY+wM1ZKeSnaBvYccQxZQsFMifLuKZX
         9eDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720097792; x=1720702592;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cjid4GTFzfR09h4v9US7cG+cmJ1miiJzUsalhJBWqP4=;
        b=AEAp4p6rDbNkeMP7jORaBXH/H65ALbS7qh75fKiwVIr6uDIrCGGAlxJYv2QcpqgLGl
         agXzHP7lONCY667hSX19/b0/aRNmKu6avVsGJGEgsAVrY3cXB/6jE3OVNP2PY0C3fepP
         wjMzkYy9iW4i8h8JceHHrtyUS7LBGiRKxokUWuqaH+QEsfs/FyuFjdSEwCNv0h9L7LUk
         Sb7eshB5ddOFNcAAxI5pt9BKBp10mm8SEcv9759WgS+LYKSlVwwREBpsoQiOByTi4f+1
         N1bQQW3M2IsafJTpT2Z3TmQFLGfA0fQHI8Q/UPRkJczBd7tPUjpnP6ghKj7o8faaWqob
         MR6A==
X-Forwarded-Encrypted: i=1; AJvYcCVK1eaN3oQw7WbRb82I00rm+T2baVKCz7ysTwrgl2cimu0AVETdyFFNCcDOQ8VKzsKnk2ZBAvN3Kbo6stBhKRpAmFTppmS/1R33OpgQUw==
X-Gm-Message-State: AOJu0YyVAV1RpmZmVVblLfSxsQtEknRradM1fWPCRvd8XB7ZVEyL3eCn
	KVriMoI7onsWB+tc+hapDbO0B6uhdtW34+xlafuSP/tc/t5QCTdkBxmqoLJujz4=
X-Google-Smtp-Source: AGHT+IHHEKbhN34mmx22VmG12egb05zVh7bP1Nwrq7g2TDcyoxukSUTmEnpHf209XtQt5Suwgnd4Tg==
X-Received: by 2002:a05:6358:714:b0:1a1:f9fa:bb7a with SMTP id e5c5f4694b2df-1aa98c51e16mr116888355d.16.1720097792230;
        Thu, 04 Jul 2024 05:56:32 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-32-121.pa.nsw.optusnet.com.au. [49.179.32.121])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-76148ca3d12sm806521a12.33.2024.07.04.05.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 05:56:31 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sPM0j-003rAh-2f;
	Thu, 04 Jul 2024 22:56:29 +1000
Date: Thu, 4 Jul 2024 22:56:29 +1000
From: Dave Chinner <david@fromorbit.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Hongbo Li <lihongbo22@huawei.com>, muchun.song@linux.dev,
	rostedt@goodmis.org, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] hugetlbfs: support tracepoint
Message-ID: <Zoab/VXoPkUna7L2@dread.disaster.area>
References: <20240704030704.2289667-1-lihongbo22@huawei.com>
 <20240704030704.2289667-2-lihongbo22@huawei.com>
 <ZoYY-sfj5jvs8UpQ@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZoYY-sfj5jvs8UpQ@casper.infradead.org>

On Thu, Jul 04, 2024 at 04:37:30AM +0100, Matthew Wilcox wrote:
> On Thu, Jul 04, 2024 at 11:07:03AM +0800, Hongbo Li wrote:
> > +	TP_printk("dev = (%d,%d), ino = %lu, dir = %lu, mode = 0%o",
> > +		MAJOR(__entry->dev), MINOR(__entry->dev),
> > +		(unsigned long) __entry->ino,
> > +		(unsigned long) __entry->dir, __entry->mode)
> 
> erofs and f2fs are the only two places that print devices like this.
> 
> 	"dev=%d:%d inode=%lx"

"dev %d:%d inode %lx"

i.e. every token in the output should be space separated, and no
commas between values.

Any other format makes it difficult for post processing tracepoint
output with sed, grep, awk, python, etc. Every token then has to be
split into name and value parts, and then the value has to have the
comma stripped from it.

Having to do this is additional work when writing use-once scripts
that get thrown away when the tracepoint output analysis is done
is painful, and it's completely unnecessary if the tracepoint output
is completely space separated from the start.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

