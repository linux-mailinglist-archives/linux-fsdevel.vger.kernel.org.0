Return-Path: <linux-fsdevel+bounces-50225-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F4DAC906D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 15:40:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB4081882BF2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 13:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 290012236E9;
	Fri, 30 May 2025 13:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gRZv1CZI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE551E1DE3
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 May 2025 13:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748612381; cv=none; b=rumF4ZdJCrDJWMB6DCnkYKVWJqmg7DqXum2uD3Y+CtgZ3fRSFnpZewhTzJkkCsAqYQsezdZOvAGbUmk4sEp/24hNjRddky9vbtR+bmFISJ8YD9FOKSQ6tzxk/oLh9AToi+b8WVDazDGWGYy+q8QhQ86uzIMhdKZfUU9BiF5HRpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748612381; c=relaxed/simple;
	bh=uiPnWYUvBr2dZYGj5pih1313yI+zbVEDfWOn2toitH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lES96Bop3xLYSlkbuKlUCf+CtCvlhRQaEYVpmhVwF5pPOunQVoD+963ANHfJaVtx1zLSL3ntYlOY6C0Wr8/vdk6UGAZ8Sod/1dS8tG6L9lptgmwipxAVCMwpQ8uB5WVHqHrqBNf1w8+ose2nk0/UsNhl9zCQR/fiJG5FVfZO2yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gRZv1CZI; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a363d15c64so1363073f8f.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 May 2025 06:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1748612377; x=1749217177; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yRGPAlzvwqw6A1h+zbYAm+4VpblGusAQkDYaKOqoOyw=;
        b=gRZv1CZIaX9Fxcw+R4Tf0ekRuSPTNaLzyEAFo50pWgQOQhpdikQ6kL5n8i/oRcMNQw
         n3d3d//y8Qyfmm6CC/K6NBnJgeKaSo17W14tVHm4uGTF/3hPFdMvXqL7yZp3l8jxspmQ
         OIHOyw6OJVUoM6HQ9aIg6i4+kfLv0BmnGePFcEP+AEOTgYB571VmDN36l1qxUVdlLpHw
         DdAAlZEl7LIQJo6gdSgsbdV65kFGs6yVa56pzSqcy1ZV65lr6eVkkUL5HBtYEVL+siua
         my4PZrVr/pTkM3TZk27ZGBuTbwYyjeCYGfdHQ0TIkQs6LEqQRgXtuO89YCdOqBaVB5LS
         aDkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748612377; x=1749217177;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yRGPAlzvwqw6A1h+zbYAm+4VpblGusAQkDYaKOqoOyw=;
        b=e4ERFv40AHInjpzi5gdlaKe+7hq6YUSSpk4y5CxeEDq884qxPiqte/WCP5WAErFLfK
         iDalGl2xbLhEuIWGqzEERHxn8MJmSil1LYHxX3SLnsCoJWbzbAC/XSE/eiXZG1bgacam
         qybe3B9FC4ToU9gJAc/9kjxPHMlzEImbMRonnEuK/4CP41tub5SOK8rYc2+JIArHIYcT
         nvmGvSXttosl4eVW0dHlNyUA9/yjZTL9nmbCynCID5wj8Uodw1dXJ1i1JghcYr26Fq0Z
         bfjPH8aGhsBipz8UEGxpEY5Gn5tGJfLgY+5QTiTpgcrBPohRtL9+pPmW3HySE+PneGDY
         ouAg==
X-Forwarded-Encrypted: i=1; AJvYcCVVhARl5fKlc6UwvN058Hyh0Cvw4ajaizTxeJZLX+19scSUrNTrJHu8vbK7bIXT/jxSUYMCcxy0dZWr6bAl@vger.kernel.org
X-Gm-Message-State: AOJu0YxKXlhVK5063djCgQKic+aKINbiiqlWC2Nz5Lke+Xq+nDCwEtEJ
	0u1MHzQ6dspx7rrVocpzOiEAYDh1MQVWY06UHXnsmmD7eyFpyoKnJq1zUKigA+CtKYI=
X-Gm-Gg: ASbGncsMXSnuccqA8iK6gRb44xyw4kXfbIB8cQ3K1NY6JGrP6fkV1gAseOl1SyactVP
	F58l3DuYiz3iBpoeZT1uRfATwV/CGYJJxYfx0Fkttgg1lHT8oiQBtKGq4bA6FkcGfo5UrYhnQk9
	76RIS9/GFTByiYHQoGC3NJBNjwSzfXvRxc1PKL46ILLW6EvytTu/tkIT2x+RbT9oIal084unIjp
	ZnPwetGzfeydQxAFhEl5rdP2AeKH4BX95G+5Cf0zhasAkyUXRs36luQywDEkRNFgxVmXZJCx437
	tcyHnD4qK8WpQ8XGeJOEiK1ta1wJVrdDphFe6RW5SJ0t6+zdli3Sy88Kaqg/Id5n
X-Google-Smtp-Source: AGHT+IEo9kE2Be7pLGHE2XuA9AU0Ju3nckFIvGlZabjJ2oxMPb3m4OllHxVr60DZeTamXlijFKgeCA==
X-Received: by 2002:a05:6000:24c8:b0:3a3:55e6:eaaf with SMTP id ffacd0b85a97d-3a4f7a1cda7mr2695435f8f.24.1748612377483;
        Fri, 30 May 2025 06:39:37 -0700 (PDT)
Received: from localhost (109-81-89-112.rct.o2.cz. [109.81.89.112])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a4f009748fsm4788637f8f.80.2025.05.30.06.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 May 2025 06:39:37 -0700 (PDT)
Date: Fri, 30 May 2025 15:39:36 +0200
From: Michal Hocko <mhocko@suse.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>, david@redhat.com,
	shakeel.butt@linux.dev, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
	surenb@google.com, donettom@linux.ibm.com, aboorvad@linux.ibm.com,
	sj@kernel.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: fix the inaccurate memory statistics issue for users
Message-ID: <aDm1GCV8yToFG1cq@tiehlicka>
References: <4f0fd51eb4f48c1a34226456b7a8b4ebff11bf72.1748051851.git.baolin.wang@linux.alibaba.com>
 <20250529205313.a1285b431bbec2c54d80266d@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250529205313.a1285b431bbec2c54d80266d@linux-foundation.org>

On Thu 29-05-25 20:53:13, Andrew Morton wrote:
> On Sat, 24 May 2025 09:59:53 +0800 Baolin Wang <baolin.wang@linux.alibaba.com> wrote:
> 
> > On some large machines with a high number of CPUs running a 64K pagesize
> > kernel, we found that the 'RES' field is always 0 displayed by the top
> > command for some processes, which will cause a lot of confusion for users.
> > 
> >     PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND
> >  875525 root      20   0   12480      0      0 R   0.3   0.0   0:00.08 top
> >       1 root      20   0  172800      0      0 S   0.0   0.0   0:04.52 systemd
> > 
> > The main reason is that the batch size of the percpu counter is quite large
> > on these machines, caching a significant percpu value, since converting mm's
> > rss stats into percpu_counter by commit f1a7941243c1 ("mm: convert mm's rss
> > stats into percpu_counter"). Intuitively, the batch number should be optimized,
> > but on some paths, performance may take precedence over statistical accuracy.
> > Therefore, introducing a new interface to add the percpu statistical count
> > and display it to users, which can remove the confusion. In addition, this
> > change is not expected to be on a performance-critical path, so the modification
> > should be acceptable.
> > 
> > Fixes: f1a7941243c1 ("mm: convert mm's rss stats into percpu_counter")
> 
> Three years ago.
> 
> > Tested-by Donet Tom <donettom@linux.ibm.com>
> > Reviewed-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
> > Tested-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
> > Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
> > Acked-by: SeongJae Park <sj@kernel.org>
> > Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> 
> Thanks, I added cc:stable to this.

I have only noticed this new posting now. I do not think this is a
stable material. I am also not convinced that the impact of the pcp lock
exposure to the userspace has been properly analyzed and documented in
the changelog. I am not nacking the patch (yet) but I would like to see
a serious analyses that this has been properly thought through.

-- 
Michal Hocko
SUSE Labs

