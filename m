Return-Path: <linux-fsdevel+bounces-50445-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36CBFACC449
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 12:28:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD4DA1708D7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 10:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB6C223704;
	Tue,  3 Jun 2025 10:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="b9KS/Be9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04BF1DE4C2
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Jun 2025 10:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748946489; cv=none; b=K6fqOddk+PqCR5xOWTlZ8pK3I+6+70mRHOSwrKf5VCbctKk73WOy86+NFXCP5MUZ9H8tZUAHhqcCo6eUbJ7o7MvuAxrHDdpBUFbxeELcNjaPI3t4j/TkSycE4CqEMR8WxMjCcY+FF4mNueWE/QtBiYxKjkxAwkHKgT9HjE+eRcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748946489; c=relaxed/simple;
	bh=NqZddVCVJU/pv09IR4A6CrG5yZeWaojhzJvlGvi8C/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BYwsYbtvtQWuYpgJUNSCvVdvrpVEaYGFxOwplos9EjTd00R4wcyg3/2igJz1uruYuB7OTL8rN58SjTevw8ADo4U6iUwZjdBjSh228+jfig7PX5dVRDy2BoO4iPbfL+1JFpRpZNzLauJWIpSpbsC2NbUAQVPzWaJpGvALCIpJowI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=b9KS/Be9; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ad8a6c202ffso1051803166b.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Jun 2025 03:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1748946485; x=1749551285; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RkpDFfZ5i7HOcQGzQzekKRtKGEewYp9impWw2CyWJbU=;
        b=b9KS/Be92yKj06AYZtXcR1bx/I449hONd5kETY5kh8J02PSJ05RW9b4fsoiY8ro0Sb
         nhw2BpZS62JJKB8kYu+7NZNqZGiLaxHHWS+aOtlptfqn8h067XsLXYQ2KwGDYnRNITWa
         5N/7i7RJ4cw/vmK13XMwiT6UIrjCrwtpXNg852c5BVTFweLU/xeGUaXN5vgbwfiJRHlq
         8MOyBtBHgEu7qTBOMCtlpKjWnaM+pr0JZ8PcrY0NJCSfy0D0mJPBzhzGx3p5v9FYAL/w
         3MDoKlKZYJjzF54Nh6x9fBztw8C2WgjBrh1ENjTCkXnXaCRJxpNgNe3+WLf7+FDj9OwN
         ZjJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748946485; x=1749551285;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RkpDFfZ5i7HOcQGzQzekKRtKGEewYp9impWw2CyWJbU=;
        b=k3qfNyhHGEo87wLaW0wu1nv9AezZ04QumlIHbLdQoTqmrerV8vGaSfKOEyVEcH6PoN
         npZdUZw1zsYk6R/X1QEPtLA4VMgXvaKVbUYr2hfYUqxcFpQhkxhGIIMyEhO9xDw2iF1m
         KRSN1V3lnGE6mT9kRHcRTIN7zP0hm0nFEoYZjBigCkIJU/+k2I9pno4WP6cMofcZCA+4
         q5kkKjBK6qPEWfhtTCzP6kD4Iy/gM2cgs/FSfVLjMvFzDZ6xXVvFiGpwtJoyayLJed73
         iFyEOSN6OOfUvo2FJx7/4GlmKZ8BYPrZIRRgITUmipGQQ0H7ORLhFFppA5Bni19Z5TzZ
         Qh7w==
X-Forwarded-Encrypted: i=1; AJvYcCUtvgkWZxPqj7YnHdUD+YRE2wRalgwY2G54vkjSaBqaUmqRjrZABag4qMoQC3BUBAFk/nDxQWN910QOJZB/@vger.kernel.org
X-Gm-Message-State: AOJu0YxNSO6lJlhqMLzi03coyxcYHbaGuwM6xiCvysWTmUrjo+XOYXwr
	QYgRUPzroSAOb03WFkMCdekZiIz7PpxE6KwsgPzfozcsqUqaXXNqOFpQbOPL4BGhUZM=
X-Gm-Gg: ASbGncuMRgl1eEhIhjwYzOPseJ5fd6yj5VymLQplxxa61jvxwFLr4w2RgQMDsdEKIqb
	uCiRu+d9egNx+r2lQL/8sHxBDJYP3hZaEOujky/38DzrJmu43JrSOwzWoO7Doki4QRHcQC+zjTp
	/koYT9MYQY6EZMfpNn3rgW93saq94x1kR1UtrdJ73Vidmxp8O8eIUypIJM3iHlsnTbljvKuv4Xe
	j83/rvUV7qxFqPhGK8p221C/w+UpgSkcGkAPwxOmW/oDXqc1MPcNwHwkXLgcGvzKpfeWs7cUSpF
	Yw0MJlUz5MQv/Y1ALXQS8kna3O0qeg0/0rQ34p4muVNbikxBuHhu5+K7moUQzq7q
X-Google-Smtp-Source: AGHT+IG04Ee/QV805aMBgvuJh4sGVhSL2Bzx/FAjKhiAOV0XyyL256xfcGp+5HFVq2BopoUl+KthNg==
X-Received: by 2002:a17:907:96a2:b0:adb:335b:decb with SMTP id a640c23a62f3a-adb493e14d1mr1116718066b.24.1748946484834;
        Tue, 03 Jun 2025 03:28:04 -0700 (PDT)
Received: from localhost (109-81-89-112.rct.o2.cz. [109.81.89.112])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ada6ad6ac28sm924861566b.164.2025.06.03.03.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 03:28:04 -0700 (PDT)
Date: Tue, 3 Jun 2025 12:28:03 +0200
From: Michal Hocko <mhocko@suse.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, david@redhat.com,
	shakeel.butt@linux.dev, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
	surenb@google.com, donettom@linux.ibm.com, aboorvad@linux.ibm.com,
	sj@kernel.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: fix the inaccurate memory statistics issue for users
Message-ID: <aD7OM5Mrg5jnEnBc@tiehlicka>
References: <4f0fd51eb4f48c1a34226456b7a8b4ebff11bf72.1748051851.git.baolin.wang@linux.alibaba.com>
 <20250529205313.a1285b431bbec2c54d80266d@linux-foundation.org>
 <aDm1GCV8yToFG1cq@tiehlicka>
 <72f0dc8c-def3-447c-b54e-c390705f8c26@linux.alibaba.com>
 <aD6vHzRhwyTxBqcl@tiehlicka>
 <ef2c9e13-cb38-4447-b595-f461f3f25432@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef2c9e13-cb38-4447-b595-f461f3f25432@linux.alibaba.com>

On Tue 03-06-25 16:32:35, Baolin Wang wrote:
> 
> 
> On 2025/6/3 16:15, Michal Hocko wrote:
> > On Tue 03-06-25 16:08:21, Baolin Wang wrote:
> > > 
> > > 
> > > On 2025/5/30 21:39, Michal Hocko wrote:
> > > > On Thu 29-05-25 20:53:13, Andrew Morton wrote:
> > > > > On Sat, 24 May 2025 09:59:53 +0800 Baolin Wang <baolin.wang@linux.alibaba.com> wrote:
> > > > > 
> > > > > > On some large machines with a high number of CPUs running a 64K pagesize
> > > > > > kernel, we found that the 'RES' field is always 0 displayed by the top
> > > > > > command for some processes, which will cause a lot of confusion for users.
> > > > > > 
> > > > > >       PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND
> > > > > >    875525 root      20   0   12480      0      0 R   0.3   0.0   0:00.08 top
> > > > > >         1 root      20   0  172800      0      0 S   0.0   0.0   0:04.52 systemd
> > > > > > 
> > > > > > The main reason is that the batch size of the percpu counter is quite large
> > > > > > on these machines, caching a significant percpu value, since converting mm's
> > > > > > rss stats into percpu_counter by commit f1a7941243c1 ("mm: convert mm's rss
> > > > > > stats into percpu_counter"). Intuitively, the batch number should be optimized,
> > > > > > but on some paths, performance may take precedence over statistical accuracy.
> > > > > > Therefore, introducing a new interface to add the percpu statistical count
> > > > > > and display it to users, which can remove the confusion. In addition, this
> > > > > > change is not expected to be on a performance-critical path, so the modification
> > > > > > should be acceptable.
> > > > > > 
> > > > > > Fixes: f1a7941243c1 ("mm: convert mm's rss stats into percpu_counter")
> > > > > 
> > > > > Three years ago.
> > > > > 
> > > > > > Tested-by Donet Tom <donettom@linux.ibm.com>
> > > > > > Reviewed-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
> > > > > > Tested-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
> > > > > > Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
> > > > > > Acked-by: SeongJae Park <sj@kernel.org>
> > > > > > Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> > > > > 
> > > > > Thanks, I added cc:stable to this.
> > > > 
> > > > I have only noticed this new posting now. I do not think this is a
> > > > stable material. I am also not convinced that the impact of the pcp lock
> > > > exposure to the userspace has been properly analyzed and documented in
> > > > the changelog. I am not nacking the patch (yet) but I would like to see
> > > > a serious analyses that this has been properly thought through.
> > > 
> > > Good point. I did a quick measurement on my 32 cores Arm machine. I ran two
> > > workloads, one is the 'top' command: top -d 1 (updating every second).
> > > Another workload is kernel building (time make -j32).
> > > 
> > >  From the following data, I did not see any significant impact of the patch
> > > changes on the execution of the kernel building workload.
> > 
> > I do not think this is really representative of an adverse workload. I
> > believe you need to have a look which potentially sensitive kernel code
> > paths run with the lock held how would a busy loop over affected proc
> > files influence those in the worst case. Maybe there are none of such
> > kernel code paths to really worry about. This should be a part of the
> > changelog though.
> 
> IMO, kernel code paths usually have batch caching to avoid lock contention,
> so I think the impact on kernel code paths is not that obvious.

This is a very generic statement. Does this refer to the existing pcp
locking usage in the kernel? Have you evaluated existing users?

> Therefore, I
> also think it's hard to find an adverse workload.
> 
> How about adding the following comments in the commit log?
> "
> I did a quick measurement on my 32 cores Arm machine. I ran two workloads,
> one is the 'top' command: top -d 1 (updating every second). Another workload
> is kernel building (time make -j32).

This test doesn't really do much to trigger an actual lock contention as
already mentioned.

-- 
Michal Hocko
SUSE Labs

