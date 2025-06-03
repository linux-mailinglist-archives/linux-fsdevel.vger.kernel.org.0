Return-Path: <linux-fsdevel+bounces-50432-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF375ACC202
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 10:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA31B16F13E
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 08:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07EA4189BB0;
	Tue,  3 Jun 2025 08:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="SHgnknrD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD422C327A
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Jun 2025 08:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748938537; cv=none; b=iQF1EUKAHT7HBj0s1yKrpgRxIKi+h1Uo1ajrDMnWlaaiXmWKwTGipkNqNkttmW9zgodr3TbFyQBqvrfy2XUY+n0h1RM0BTLNfjRdYETzhpCElaf9dszeMLzozatLUhB6o2K+6QDTl7zm9zSMECbbPeCojeIsyutqaWoAirW2/jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748938537; c=relaxed/simple;
	bh=9Osa9RoJKx/1U3bThDLTdrVvx3XeTLv3ASk/Y/yABrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ex3YBZIcpAKWjIYhE7JkP7G5XtlzTkCE1yb+37o8R2WGmSd6eaAwXcRnLd3/JzDPHmbOda/ztUZBVDFFAv3xYMHlB0ppNyoQUV4aM2psl2fzoifBvDNiZMP7OMMlRh7VE/R6O3ePQTuJdRUi0TyvBBOEVcweAaR7xASIjZ5oQ08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=SHgnknrD; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ad89c32a7b5so858732166b.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Jun 2025 01:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1748938533; x=1749543333; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7JtWNL9wmv8FUs8JMPyk0qjLcGIi53aG/txZlPwoIlQ=;
        b=SHgnknrDRl8dgCWb6tr/rDrtDmxoM1BNxgCROH9jf1KNMlvOMWRqnD7gkJEC7GsWi9
         tKDcrpa+aDflRDotFpNDtLc5PcZkA5F0suXBVJ7ztIB0m6Z/bbXMXBLW9KZz0chpvWUK
         7zQgRfjFgXAG0rzWDcfvBghnhSEGon7XrYFOxrGtvQ4hD9hKACk5w/iZm0dja633AKLf
         TXzOOr5nEQDieNjkOvfuj1m7IzQMgeIK4TN+QygQuor4PWnVn2rTnsW5mc/LdHVIlvfJ
         KaeR5dQwt/TCdAhGAzarTbOL90t25/Ap2gKTuWNaD1UbFprm+rRelkVzamwE7AFCfJH+
         7TPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748938533; x=1749543333;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7JtWNL9wmv8FUs8JMPyk0qjLcGIi53aG/txZlPwoIlQ=;
        b=dxUmPSp/Sediej7Gq1XX6Mt5e0lRW6kr0yM9l3KYku1fVgSac29nSW/uIDi15dhIMe
         88b/5jmq5XqCqxM0/ohFcMiYP/1ftlY1jkSvP7DsqlPrgsX3N6sSSwl5K2Ckrpl42B+h
         F4ujxki+1/QUkGGWbgrxTlVIYvzbJFLLFxDSw4SSCxt1rPgxp4P0odly3nFYtu0xgN6g
         0Kk/hQ8qRG0n+NIK+VDykhqA1fUr+JuBwq/JnNXKEpUFmk/EfxkWEsQt6BFjS/EZV3zj
         4e8VFRCpX1Lm3YxOWYyEPdPXUgqa7V5LJRfxoIx1K6HSMhQibzRLOFs2A0rUVzyjYij2
         GmEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUaLoQEnOy9puj83P2iDX5SYs0lTXCbM+YHre5fO1IOlQh0cXARpUPWpEIeCm79k9qPi1eGpOODI7pXBte@vger.kernel.org
X-Gm-Message-State: AOJu0YyNa6jPtW2ldVAV4V3sFrf+AH76IqUeVivQ/DSScwv+vkRYqyBZ
	GmBFytskd1il2ZMuJoMQ2wP2vJ5Q9qbMZb66aoQ6Sb1XFdXQcwNx4iEG0wg/IgKP68g=
X-Gm-Gg: ASbGncsKcKhFNP8kDTru+WpNxezBtAlRAqgiODgMiIfhs8GtVFOtwgcRl7MyhNdu7ib
	iqvA/l7uM2pi8B7/m8MLoYbfoLpCidpmxDi2+4QtOfCSL8nJi4v3Y2HJABwH4KKRnJqdX96mBW1
	tH9Gq4oPCyc8Au7CA7Ew0qXcGTr5RMbdu1MD4OJP4+W1gu2u43UvsXCuK8YSdQTXsepDgip4ta4
	k2/aO87L+lvMuGFQXcdqfk3O0xX1y94WqkZXlufU7oP4hZ1pwV/Sa41oV6k0HlkbjbWYl0QpdnB
	IfGxx8tqOkyD0ZnAQj3xGaMgFBJNq1NB2GwO/PHszF0/uGMo80Ue18nkdvkaa4Im
X-Google-Smtp-Source: AGHT+IHgWu4IdI3gzh2/uscswRF8XgnFv7trP/TcuTZpl+j7x5yq2ZjYIyS4GD1EWC37yt76MfBT0w==
X-Received: by 2002:a17:907:3f99:b0:ad8:8efe:3201 with SMTP id a640c23a62f3a-adb325838ffmr1676986366b.43.1748938533445;
        Tue, 03 Jun 2025 01:15:33 -0700 (PDT)
Received: from localhost (109-81-89-112.rct.o2.cz. [109.81.89.112])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ada5e2bf0b3sm914953866b.112.2025.06.03.01.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 01:15:32 -0700 (PDT)
Date: Tue, 3 Jun 2025 10:15:27 +0200
From: Michal Hocko <mhocko@suse.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, david@redhat.com,
	shakeel.butt@linux.dev, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
	surenb@google.com, donettom@linux.ibm.com, aboorvad@linux.ibm.com,
	sj@kernel.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: fix the inaccurate memory statistics issue for users
Message-ID: <aD6vHzRhwyTxBqcl@tiehlicka>
References: <4f0fd51eb4f48c1a34226456b7a8b4ebff11bf72.1748051851.git.baolin.wang@linux.alibaba.com>
 <20250529205313.a1285b431bbec2c54d80266d@linux-foundation.org>
 <aDm1GCV8yToFG1cq@tiehlicka>
 <72f0dc8c-def3-447c-b54e-c390705f8c26@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72f0dc8c-def3-447c-b54e-c390705f8c26@linux.alibaba.com>

On Tue 03-06-25 16:08:21, Baolin Wang wrote:
> 
> 
> On 2025/5/30 21:39, Michal Hocko wrote:
> > On Thu 29-05-25 20:53:13, Andrew Morton wrote:
> > > On Sat, 24 May 2025 09:59:53 +0800 Baolin Wang <baolin.wang@linux.alibaba.com> wrote:
> > > 
> > > > On some large machines with a high number of CPUs running a 64K pagesize
> > > > kernel, we found that the 'RES' field is always 0 displayed by the top
> > > > command for some processes, which will cause a lot of confusion for users.
> > > > 
> > > >      PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND
> > > >   875525 root      20   0   12480      0      0 R   0.3   0.0   0:00.08 top
> > > >        1 root      20   0  172800      0      0 S   0.0   0.0   0:04.52 systemd
> > > > 
> > > > The main reason is that the batch size of the percpu counter is quite large
> > > > on these machines, caching a significant percpu value, since converting mm's
> > > > rss stats into percpu_counter by commit f1a7941243c1 ("mm: convert mm's rss
> > > > stats into percpu_counter"). Intuitively, the batch number should be optimized,
> > > > but on some paths, performance may take precedence over statistical accuracy.
> > > > Therefore, introducing a new interface to add the percpu statistical count
> > > > and display it to users, which can remove the confusion. In addition, this
> > > > change is not expected to be on a performance-critical path, so the modification
> > > > should be acceptable.
> > > > 
> > > > Fixes: f1a7941243c1 ("mm: convert mm's rss stats into percpu_counter")
> > > 
> > > Three years ago.
> > > 
> > > > Tested-by Donet Tom <donettom@linux.ibm.com>
> > > > Reviewed-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
> > > > Tested-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
> > > > Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
> > > > Acked-by: SeongJae Park <sj@kernel.org>
> > > > Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> > > 
> > > Thanks, I added cc:stable to this.
> > 
> > I have only noticed this new posting now. I do not think this is a
> > stable material. I am also not convinced that the impact of the pcp lock
> > exposure to the userspace has been properly analyzed and documented in
> > the changelog. I am not nacking the patch (yet) but I would like to see
> > a serious analyses that this has been properly thought through.
> 
> Good point. I did a quick measurement on my 32 cores Arm machine. I ran two
> workloads, one is the 'top' command: top -d 1 (updating every second).
> Another workload is kernel building (time make -j32).
> 
> From the following data, I did not see any significant impact of the patch
> changes on the execution of the kernel building workload.

I do not think this is really representative of an adverse workload. I
believe you need to have a look which potentially sensitive kernel code
paths run with the lock held how would a busy loop over affected proc
files influence those in the worst case. Maybe there are none of such
kernel code paths to really worry about. This should be a part of the
changelog though.

Thanks!
-- 
Michal Hocko
SUSE Labs

