Return-Path: <linux-fsdevel+bounces-53236-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 345DCAED030
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Jun 2025 21:59:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3D2A3B5356
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Jun 2025 19:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1BD023ABB5;
	Sun, 29 Jun 2025 19:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BMoRsDEy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED1E1ACEA6;
	Sun, 29 Jun 2025 19:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751227157; cv=none; b=aMYyKBCTrAU7dr7c5P1FHpCNfMpjWhReGAZbh030x3iROdac0idRtmWyuRvJCs4vOajnS9McnahxuEDEKQHM/AYQ5AwvQpgUPwRXbngFXxtu4Lt1sP4pvYUXYABrb8GbS/ipqqxC5fUOgndDDfI9sIPYNsYVHRFoxqvpb/WXzG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751227157; c=relaxed/simple;
	bh=YSB+Jw4yQavEAlt77gEe2Hn5XpKfayLR2Hpo2rDJsqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h/GiHIb1jF2ABJ6yTdlxDVhcaVzRMzXD/O6FLvq48Y0mCApQSV0mCh/urFfbfNfz7W2fOAVXhCAAP1wG74IFmcrdXf35ZSPcJ60alSGq0QSkjpWiZRM3BaAQq8U13i4ytbvxAjxQBoG2GqxY3IxI+VKZ7GNE23IkGaVQOsta0Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BMoRsDEy; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ae0b6532345so937647266b.1;
        Sun, 29 Jun 2025 12:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751227154; x=1751831954; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lGeg19ztG5/Ct6qCePoKYtSXFaG6WumjLw9hnwsrIYM=;
        b=BMoRsDEymo7GihB0U2GG7666X7g2usiOq7m7kAtJOBttgetwePR/zASLSDXFBY672U
         OuUUEPBepVJQsSB6YJ3e5m7G2CbbfKfoziNQq3r6j6f7lHjDW6sL+nccyhcjwHFB/aKP
         J4X8ZWYGmqFM8e1rvSv/Lr52gGHZPjIUTEIUhRe3RutyT6Yywe1crmCOW3uoU+FfT6lc
         yB69hyocunwxAW/vTU30e6VP6f7UPGlIgtZcxaZKTaneergS45pyU9PkD08wAVhdQGOQ
         m5YFL5tA6Jcma9CXOWNP6EWwzlPL3gYoDnAe1p7nmLsDrmUUCz+tFyDHqCmeQ6ipCDBd
         O9tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751227154; x=1751831954;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lGeg19ztG5/Ct6qCePoKYtSXFaG6WumjLw9hnwsrIYM=;
        b=DNx9x0rXnT5Nl2kbOyLB7OlrKWnm6tj5922zwF5QARePB/3MJt2X/1mF0hx4VM/P3F
         x/3Z2LLnK0GnC7wa9zVZ8p+UxPWji0442raK8uR37LNT8sZufG2qm3CBosOLrcdCq4tn
         DhEnOhy4Bt9djEZgU8xRcuRoKJ4EjDJ9aB8l7h1R62wKVHVHbfY1KrDMol51ZsnClvO+
         aT02vDyp0w75eMXRkJnraSg/u62l/RufZYg1kQERsocNdrfd8Qbfp1xKx6tNZl31UT3G
         7KL/YLQeHHLc0AY+7iN+KebZYvRLF8lbZWLjpotKZEL3QpTC69yXCfc0XnbUzr2Vabch
         VYKA==
X-Forwarded-Encrypted: i=1; AJvYcCVkGnQkO4xOW0IhcVtumHtFb3u5kt6m4xk5gU+LXr0D30tJFwtvvKc6X+Hff0tVgmsnqG1CHNwBUbxQ7aip@vger.kernel.org, AJvYcCXM+rssDKLVxiLIWrQjGR7SHO/OSiSe02/bh7WQizgplcy8MV00QkLB7P08YDxWj8JpqaspGHiQlwN8qJpM@vger.kernel.org, AJvYcCXmGfIj1rfPo6wZH7nMFaEVGTfuHzXrfm4+/pXKLRgGD8MWrYcd175ZYEJsceIwa64VClBk1Ho+@vger.kernel.org
X-Gm-Message-State: AOJu0YwvHDoQ5mUQrdEviQUUqVivz6SNj6+h6zSs7l8gwJV8EAwOgtY4
	Xr4ANZkahZW20VGYep4YgnKRC6Q8OOyZaSrYYdcgDoCdz/l4I/wpIEHI
X-Gm-Gg: ASbGncu6+odcsk/oVt9kiQpUzCNEasjCI59fa1WaaieDpUSaxSctLxDk9HW9/MjHvOT
	h1DEmctpH3ZQ896hun6+Q33DjIREAHm+jbEnw4t1KW9Puvh33L4VrEgkcUbxsHTD3cl065FnN3X
	LVcusTyzt7x7pZRNgJICAbRLsbs5GShZnQ1BTBV3n+LsELFX0I1CMSWvkMXAATRc3x6a1Rp3vKq
	YyQvbQ2cR9wW9oXsmDmyA1pb82LcvUP4XQ/TrNvcnno2lpX5C+p1Pxsz1BP47wPpsqWpK7+JiLU
	7v/S/nCavJELucPGOqv2nYbv72+rxNKGg92LDZoRmA04M3KZRhE7G+iS9zVT2qJs9ia/f9APAHA
	=
X-Google-Smtp-Source: AGHT+IH/vrS2jxq/LNNcuJwiTfewiwznnBJeIJBCOh8Xn4PYgpnPEPL0ckbbGBr7ScIju2hHbDzS5Q==
X-Received: by 2002:a17:907:94c8:b0:ae0:6621:2f69 with SMTP id a640c23a62f3a-ae0d262937emr1696362466b.13.1751227153403;
        Sun, 29 Jun 2025 12:59:13 -0700 (PDT)
Received: from f (cst-prg-65-92.cust.vodafone.cz. [46.135.65.92])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae353c6bea1sm540029766b.146.2025.06.29.12.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jun 2025 12:59:12 -0700 (PDT)
Date: Sun, 29 Jun 2025 21:58:12 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: Sasha Levin <sashal@kernel.org>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	akpm@linux-foundation.org, dada1@cosmosbay.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] fs: Prevent file descriptor table allocations exceeding
 INT_MAX
Message-ID: <i3l4wxfnnnqfg76yg22zfjwzluog2buvc7rtpp67nnxtbslsb3@sggjxvhv7j2h>
References: <20250629074021.1038845-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250629074021.1038845-1-sashal@kernel.org>

On Sun, Jun 29, 2025 at 03:40:21AM -0400, Sasha Levin wrote:
> When sysctl_nr_open is set to a very high value (for example, 1073741816
> as set by systemd), processes attempting to use file descriptors near
> the limit can trigger massive memory allocation attempts that exceed
> INT_MAX, resulting in a WARNING in mm/slub.c:
> 
>   WARNING: CPU: 0 PID: 44 at mm/slub.c:5027 __kvmalloc_node_noprof+0x21a/0x288
> 
> This happens because kvmalloc_array() and kvmalloc() check if the
> requested size exceeds INT_MAX and emit a warning when the allocation is
> not flagged with __GFP_NOWARN.
> 
> Specifically, when nr_open is set to 1073741816 (0x3ffffff8) and a
> process calls dup2(oldfd, 1073741880), the kernel attempts to allocate:
> - File descriptor array: 1073741880 * 8 bytes = 8,589,935,040 bytes
> - Multiple bitmaps: ~400MB
> - Total allocation size: > 8GB (exceeding INT_MAX = 2,147,483,647)
> 
> Reproducer:
> 1. Set /proc/sys/fs/nr_open to 1073741816:
>    # echo 1073741816 > /proc/sys/fs/nr_open
> 
> 2. Run a program that uses a high file descriptor:
>    #include <unistd.h>
>    #include <sys/resource.h>
> 
>    int main() {
>        struct rlimit rlim = {1073741824, 1073741824};
>        setrlimit(RLIMIT_NOFILE, &rlim);
>        dup2(2, 1073741880);  // Triggers the warning
>        return 0;
>    }
> 
> 3. Observe WARNING in dmesg at mm/slub.c:5027
> 
> systemd commit a8b627a introduced automatic bumping of fs.nr_open to the
> maximum possible value. The rationale was that systems with memory
> control groups (memcg) no longer need separate file descriptor limits
> since memory is properly accounted. However, this change overlooked
> that:
> 
> 1. The kernel's allocation functions still enforce INT_MAX as a maximum
>    size regardless of memcg accounting
> 2. Programs and tests that legitimately test file descriptor limits can
>    inadvertently trigger massive allocations
> 3. The resulting allocations (>8GB) are impractical and will always fail
> 

alloc_fdtable() seems like the wrong place to do it.

If there is an explicit de facto limit, the machinery which alters
fs.nr_open should validate against it.

I understand this might result in systemd setting a new value which
significantly lower than what it uses now which technically is a change
in behavior, but I don't think it's a big deal.

I'm assuming the kernel can't just set the value to something very high
by default.

But in that case perhaps it could expose the max settable value? Then
systemd would not have to guess.

