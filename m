Return-Path: <linux-fsdevel+bounces-52150-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EAB0ADFB74
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 04:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D8AA3AF994
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 02:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F0821D3F0;
	Thu, 19 Jun 2025 02:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FBTkXp/x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8DC21A43B
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Jun 2025 02:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750301506; cv=none; b=Aa+7K6ws3UE5GfOpEvhXA9TZnVDk6RD4nXFpBvFonFQkKPXMZDk9KRY2g/R1J0FqrkB67c4BxOj4yYfyymPatUR2k6ehJ0ESgxbzV/flqvin+ciqcqzD4j5shu+FG8gkwq29fYAF2k511t7Azeb718jFtNFklDoba+/c9K7JHl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750301506; c=relaxed/simple;
	bh=qvcnjQ+PsLVyZlnagd7L2hmtb5NKeyi4bcowbj1uSr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XxO8g50N979B4XuLaJwc43tUxQvbwyhvO/BpNhhYVE4fGqBvNJ6mC9l0tkC/bsgWG1sMP4wVCNzfYcgWAOaitTl2ZgDS4S6uBgMZddmgvmNTebUCxrfz20OVAVeoGOqTAJM57RR0xru4jpSpOOxilJ6wW7OQGh5fNS+KgfvfU6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FBTkXp/x; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2366e5e4dbaso2339515ad.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jun 2025 19:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1750301504; x=1750906304; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7luqjWXmKm6yGrwAC00VgJVZYDbCcThLXju7FcsbCbY=;
        b=FBTkXp/xKgT4e75go+uyF6RGALpKo6bvq3plNHlipN9mwIlp5x/nw0W96j+uH6oLVY
         AnXDNbV5G2ulrJPwCAeuulqhXhkD8Lju8N0nsrflyJd7Z6j22lK+WTlLBERlnuV44bGa
         7rrRraBTTg9Y1xhG23joexpJB/94j2FXXKvyg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750301504; x=1750906304;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7luqjWXmKm6yGrwAC00VgJVZYDbCcThLXju7FcsbCbY=;
        b=HBIeZdb8Yquf3ZvA6bC8U0RwMtYbR0D9eV6OUdQwgzoX5eB+br8Y1npepvGXajruvs
         FlMiQXqQK0JCvtd1ylhFdNcBdLdKUFOynhHN1h6pXo9q0lYUbJvAAuuDVR5bsnS/k2YR
         wtazMJ4H1h/Kmg1MPhe4jcXONbbsMCvrVd4c9L5Go8YNI4lriPda7fqP4U4hborpvab8
         /04ZVF3Y9f5HPxhAPgbGN435iaBMuGP4EqXmWJdoDGpChBlXUSSiLHebujYT9GboAyoa
         zfdPta+7utBTMslaDDxXy34dBWzl0iK+Tz9E9pmVDcwwJAWkZ+BMxc9bT/PLCG6ZqkXi
         hWsA==
X-Forwarded-Encrypted: i=1; AJvYcCWdOlVNjDYnyHDJoD+Z4bUPI7mAKZiL8rvlbdSSENfWI+bGMwTNLQvH0gEZSIRqzwkF4afuMcuZgYPjT9By@vger.kernel.org
X-Gm-Message-State: AOJu0YwQcWLz8NXdoaH+pg9E+VFQfiNmGE79keeZAh7hlxDaA5fRg3Rx
	oLWyJEFyIdkpYl9Fu4nlTGBC28ThwUFF16OPo/IZgeLXyBkdyT7RL+lgquhdal8zug==
X-Gm-Gg: ASbGncucbbE+Xu7rVCJeIAXvWXb7J9AtKgay5hI+VBHlnVofBoEQzmGBO2KS2Vgvkiv
	74H6gOsawlP42ecz5IlmJnDVaAr63VC3zGF50LgRiWRj2rmI50UwcNofmvms11lLg3cu9LQrFyb
	e1z5PpVB0YYRSyKpzGyi+/GW/lgpNKmDH/mMHrwBy5q2SQTRT9nzF1WinrztqwBBA6DlSNJ7L1x
	UKPRCEcLFIBUlAvLKzuMB9DEyWKdikhiZS5IpGnMLDhja8Jpr+aS3/CRY9szkdA4g1KnE/2GwT+
	KVl8Vt2dstzb4YPN3giY73U5ySHo0vwM9q6J4xkbw7ZtgNS4ybLVGEfBWjP+SuMh6tJLlbZdMT3
	S
X-Google-Smtp-Source: AGHT+IFbHqtRYblyKHnCUtjgxnbRWDa5q4RtTfoWxbt7Wol5AkAW2zsNXJDuDuPYnhNGYHTrb9+cAw==
X-Received: by 2002:a17:902:ce89:b0:235:f059:17de with SMTP id d9443c01a7336-237cbf8d549mr27843375ad.15.1750301504470;
        Wed, 18 Jun 2025 19:51:44 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:7cb6:ce70:9b77:ed3b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365e0d22absm109007455ad.255.2025.06.18.19.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 19:51:44 -0700 (PDT)
Date: Thu, 19 Jun 2025 11:51:38 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Tomasz Figa <tfiga@chromium.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCHv2 2/2] fuse: use freezable wait in fuse_get_req()
Message-ID: <aofjrqztimch5235rl2hy5y4u7imtqyqihexpejse7uilesrb5@w262yuqijncl>
References: <20250610045321.4030262-1-senozhatsky@chromium.org>
 <20250610045321.4030262-2-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250610045321.4030262-2-senozhatsky@chromium.org>

On (25/06/10 13:52), Sergey Senozhatsky wrote:
> Use freezable wait in fuse_get_req() so that it won't block
> the system from entering suspend:
> 
>  Freezing user space processes failed after 20.009 seconds
>  Call trace:
>   __switch_to+0xcc/0x168
>   schedule+0x57c/0x1138
>   fuse_get_req+0xd0/0x2b0
>   fuse_simple_request+0x120/0x620
>   fuse_getxattr+0xe4/0x158
>   fuse_xattr_get+0x2c/0x48
>   __vfs_getxattr+0x160/0x1d8
>   get_vfs_caps_from_disk+0x74/0x1a8
>   __audit_inode+0x244/0x4d8
>   user_path_at_empty+0x2e0/0x390
>   __arm64_sys_faccessat+0xdc/0x260
> 
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>

Miklos, are you fine with this?

