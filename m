Return-Path: <linux-fsdevel+bounces-28372-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 464A4969F0D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 15:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F269B2864EB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 13:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD5C65684;
	Tue,  3 Sep 2024 13:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EVOzdubp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D77E15C3
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Sep 2024 13:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725370262; cv=none; b=sPgIvAmjedJ/UvhUX+860pmBPo5d4YmO/YQ7K0HokRkeQSje42opBCxeklKpvs4yF5AE0JJXSLhDuy2CE+BWS7FyMJi8NRKNKcVPf642nMVfNl72O+S+7YUlsRaiOZfPNvyTYiduJpXOSA0nZx46RI8O7ouFsrsPSEwg2VQB2h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725370262; c=relaxed/simple;
	bh=appp5oPZveuQA0YNu3dHi+i2nzCQggrq2dYcNrVzcuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mgvTw8FR8LlsrWXuH1Fjsi0add8CYwQJqIqcphIrgZV1l+pfjAOcSApuARfPQi6/zjlOkfYqMy78rKRdoJXfXpCJHBXXQknXEAEoQwbIOFUoDVvDjve4olkwgm4HTtHS5P90j61p+vBQLEsimmBav5y72bg8LnY9oPliZzex5Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EVOzdubp; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a86910caf9cso1096430366b.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Sep 2024 06:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725370258; x=1725975058; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Kktsjhgg2t8wZvNqOBe4kVpKivr6aFxzWI5uzU3G4jY=;
        b=EVOzdubpfPlVaxy5UBjJoylh+UifFZzBwDJn4X1Fm1g3u1gRdYrSxGTKaznPi0fHXm
         tsHSKjganJS421mhDRgtMAE36igcfeJ8AkfTl1lKHvYgmBsu5SYn1y3gocG/L53MR8zO
         S8fCLp2qfC/qWI2QPTJmuuDeeNFEi3y5DDIdUnKxGgeJWV6EQZL+vn0RW7etq4kB+mfh
         6RUxpMiYNhHncfkO1L1hr+sFVyWmgoqGX3GSQO5Q0yRkcE3ENImECFXliL72N09bfRXB
         ZEKkJ6tiaS/c5rIB2parvsaLj44eq/LesslKh774lUevUo7+p7igcYB/zVTfxvza+HDV
         Lp/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725370258; x=1725975058;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kktsjhgg2t8wZvNqOBe4kVpKivr6aFxzWI5uzU3G4jY=;
        b=cj+yDV+ZNeSW8rW0qkGXveITFBVpCrtV5SJWlhdqfJwwp7Ev93CwzC4osDJy/+HDFj
         wnQr+rMiuSTxrYGrzywpvd0v0zmKm1GaC3a5Sko+9P+ruK2zyS4jOz7DatpNDUq26Ksh
         vWQ8ofQRhEH+RUmWdWQ/fRgLQUAcuIsIhHnqeWQDE9gGQQXF/K+Yx4e4pYKHaXnx7UWI
         ifnxg3bCZaLaBJvFY2XPoeS+W5dTOHBB4MhY2zv7xaH149cftRbUf9i8ouxLYpHTAY1H
         LBYq63W1//hnejLr3+lvcQQWWwBwHZnROm4s6Xlo1FJx0mFyiD3Nb1OZfl+O/qmThAP8
         pNxQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9qP6h2jLE3kWs9HlRKIQ538aFMHWdrQIgudUFWL/Fd+05CrjiGqYVv/Qrhx/qN/tohX0sVDnvn4hO/54B@vger.kernel.org
X-Gm-Message-State: AOJu0Yzpfw0jvyVQg/nP0xrJ/aeYZMlzopFj7gLMxjVGUV31GBR6U2FQ
	jKkT3ECpGAAyXY7Df+OhZuW6MvG50fnLfwkhP6X2Q6Ov6bCOfY6cOipfy0sZkfM=
X-Google-Smtp-Source: AGHT+IHnuu8zcNVorEycrG3KrlDXU05SQYlVYNfC+byPIiJdWhVTn2IFVlBjt9GH76DTYU2WVkVU2Q==
X-Received: by 2002:a17:906:ee8c:b0:a75:1923:eb2e with SMTP id a640c23a62f3a-a89823ca0afmr1882078166b.14.1725370252922;
        Tue, 03 Sep 2024 06:30:52 -0700 (PDT)
Received: from localhost ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a898900f079sm683327166b.66.2024.09.03.06.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 06:30:52 -0700 (PDT)
Date: Tue, 3 Sep 2024 15:30:52 +0200
From: Michal Hocko <mhocko@suse.com>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Yafang Shao <laoar.shao@gmail.com>, Dave Chinner <david@fromorbit.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Dave Chinner <dchinner@redhat.com>
Subject: Re: [PATCH] bcachefs: Switch to memalloc_flags_do() for vmalloc
 allocations
Message-ID: <ZtcPjBeF9TjCe8Sl@tiehlicka>
References: <wjfubyrzk4ovtuae5uht7uhhigkrym2anmo5w5vp7xgq3zss76@s2uy3qindie4>
 <ZtCFP5w6yv/aykui@dread.disaster.area>
 <CALOAHbCssCSb7zF6VoKugFjAQcMACmOTtSCzd7n8oGfXdsxNsg@mail.gmail.com>
 <ZtPhAdqZgq6s4zmk@dread.disaster.area>
 <CALOAHbBEF=i7e+Zet-L3vEyQRcwmOn7b6vmut0-ae8_DQipOAw@mail.gmail.com>
 <ZtVzP2wfQoJrBXjF@tiehlicka>
 <CALOAHbAbzJL31jeGfXnbXmbXMpPv-Ak3o3t0tusjs-N-NHisiQ@mail.gmail.com>
 <ZtWArlHgX8JnZjFm@tiehlicka>
 <CALOAHbD=mzSBoNqCVf5TTOge4oTZq7Foxdv4H2U1zfBwjNoVKA@mail.gmail.com>
 <20240903124416.GE424729@mit.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903124416.GE424729@mit.edu>

On Tue 03-09-24 08:44:16, Theodore Ts'o wrote:
> On Tue, Sep 03, 2024 at 02:34:05PM +0800, Yafang Shao wrote:
> >
> > When setting GFP_NOFAIL, it's important to not only enable direct
> > reclaim but also the OOM killer. In scenarios where swap is off and
> > there is minimal page cache, setting GFP_NOFAIL without __GFP_FS can
> > result in an infinite loop. In other words, GFP_NOFAIL should not be
> > used with GFP_NOFS. Unfortunately, many call sites do combine them.
> > For example:
> > 
> > XFS:
> > 
> > fs/xfs/libxfs/xfs_exchmaps.c: GFP_NOFS | __GFP_NOFAIL
> > fs/xfs/xfs_attr_item.c: GFP_NOFS | __GFP_NOFAIL
> > 
> > EXT4:
> > 
> > fs/ext4/mballoc.c: GFP_NOFS | __GFP_NOFAIL
> > fs/ext4/extents.c: GFP_NOFS | __GFP_NOFAIL
> > 
> > This seems problematic, but I'm not an FS expert. Perhaps Dave or Ted
> > could provide further insight.
> 
> GFP_NOFS is needed because we need to signal to the mm layer to avoid
> recursing into file system layer --- for example, to clean a page by
> writing it back to the FS.  Since we may have taken various file
> system locks, recursing could lead to deadlock, which would make the
> system (and the user) sad.
> 
> If the mm layer wants to OOM kill a process, that should be fine as
> far as the file system is concerned --- this could reclaim anonymous
> pages that don't need to be written back, for example.  And we don't
> need to write back dirty pages before the process killed.  So I'm a
> bit puzzled why (as you imply; I haven't dug into the mm code in
> question) GFP_NOFS implies disabling the OOM killer?

Yes, because there might be a lot of fs pages pinned while performing
NOFS allocation and that could fire the OOM killer way too prematurely.
This has been quite some time ago since this was introduced but I do
remember workloads hitting that. Also there is usually kswapd making
sufficient progress to move forward. There are cases where kswapd is
completely stuck and other __GFP_FS allocations triggering full direct
reclaim or background kworkers freeing some memory and OOM killer
doesn't have good enough picture to make an educated guess the oom
killer is the only available way forward.

A typical example would be a workload that would care is trashing but
still making a slow progress which is acceptable which is acceptable
because the most important workload makes a decent progress (the working
set fits in or is mlocked) and rebuilding the state is more harmfull
than a slow IO.

-- 
Michal Hocko
SUSE Labs

