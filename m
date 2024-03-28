Return-Path: <linux-fsdevel+bounces-15607-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 00803890991
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 20:46:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84118B20F4B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Mar 2024 19:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FCAE1386C0;
	Thu, 28 Mar 2024 19:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YaNiX4Qi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18EEA1384B6;
	Thu, 28 Mar 2024 19:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711655203; cv=none; b=NefvQHDoPc+C6GdTch6Q3/WUZLJ3oKgK4CE9khl4tpC7bW6zpMF1caSjhHFgFLwN5oaesop8evlLpQ2iK4jkSsRnFeBxCe5OEZ4YnME4rL+hDfBMKH65mS0VTPxKu5n35hWrYWHqcnf70iMkRO7uInD+mU91eaQd+Ra8bY+wl5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711655203; c=relaxed/simple;
	bh=JoHSfNWCuszTvS+sHkAQkYlMRsDabPUMrlciOUgvssg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bEyGoMiwmB0HwlS8tk9SPiNVv++15gsmfzuHi60KcODwfl3+LM4Igq51v1qRxPXiRPw7iJ6uv7n3Rh12knBuSYz2XY8x82KurlcNDgi3UglTKwmH6kzIGmz+4douYtjDou9plLgM6k0dQyQwqvZHRUZQtUQ+mT8gSO7whAOWl4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YaNiX4Qi; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6e703e0e5deso1176943b3a.3;
        Thu, 28 Mar 2024 12:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711655201; x=1712260001; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uT3+EvMk0DC3SU3LipXNa10bWu769Nw/MuJjqYhTZRY=;
        b=YaNiX4QidYQgPKY3Bwl/v+9WSLnEWSGmVRp/hv8Y37aXERbLIIgJ6vpr0yPE3ZGw+T
         X3I/YwhATfj5usEVVfSqbMg9xM4sMMTdfQzwflnUvpigw3ne1krXJ9VfJrYTRkC66ieW
         H77OkQ7tK2uk/iLltPqeMiJqqI3vL4n9bPjxINzsR/KtrXjVlPgNVm5LcneUZLgVMAKX
         6Hr5WxmbdOfggcNO622ks0gCNGA79s/6S8dzVj13PfoHHhKfZ4WH67U73lmg5OrZ+Fvq
         oo85l2JkbOV+e++P50pAQKcSwSJR+VIl7ryp0V8O/DU8en1C7r3yEAK/0eaaIHCAM9Xu
         CrLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711655201; x=1712260001;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uT3+EvMk0DC3SU3LipXNa10bWu769Nw/MuJjqYhTZRY=;
        b=LAZMEsuU1MAC1fGcb9/rHXxAraFVOOgO1WFF+PQyjgM1xf1iJTAUBNNTW1iYQ16fDy
         kT6pAFO55kHO0L1fl9mF4yQqeCiI73JwV3ggBNB8ryHRER7zFRVJqgcw74KF6YquXdzF
         Lx7pxZs2IRcKDMFIOVWlIhxgGpuhs4ntlJf7bDss+VZzm15YmB8u2AXouHgNc2oevd5N
         zN5uCrW6eF9pFJ58fvbg+MVSn5iq0whfoToBkYX/a0Jopn7PmOiWwiVTGJVroafBl+ef
         7MmB6smH7tl9n3amdLKWy0X38h7tdy//5eObLzqN9t6pbotJ3l2pUYHhuZFEljZ1dgD4
         2NUw==
X-Forwarded-Encrypted: i=1; AJvYcCX5iUGMxtU1e+5fCnCkB9WOGpESlAfh80SDLkWv/N+cjeHGSGgiNoq9nXZ1mQ2gxz4l6DiAXLugAVbIXOrFzVbz6Iktc5LpD6gp9m2k4+z+gCKhNigHimI7+QVENf41DIU4xAbbInzlMO1uHw==
X-Gm-Message-State: AOJu0Yzd6e4Rez6w4JU1KyQWjIZuXfG+sbbhPOuqh3DALVdQGeKhbFyP
	w/MS+kVKxVfTmpC/Zy5jpO+KLWJw1F3mJGbj8Y82nzxv4ood82+K
X-Google-Smtp-Source: AGHT+IF3eoTQgD9p1GZXsRa08ouQFunv1CReXF3z4bK+mnRZ/sst243Nva6MmFlH7Lv8JBr8KGEIyQ==
X-Received: by 2002:a05:6a00:10c7:b0:6ea:e2d8:473 with SMTP id d7-20020a056a0010c700b006eae2d80473mr303558pfu.6.1711655201451;
        Thu, 28 Mar 2024 12:46:41 -0700 (PDT)
Received: from localhost (dhcp-141-239-158-86.hawaiiantel.net. [141.239.158.86])
        by smtp.gmail.com with ESMTPSA id k7-20020aa790c7000000b006ea916eac02sm1753620pfk.42.2024.03.28.12.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 12:46:41 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 28 Mar 2024 09:46:39 -1000
From: Tejun Heo <tj@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Kemeng Shi <shikemeng@huaweicloud.com>, akpm@linux-foundation.org,
	willy@infradead.org, jack@suse.cz, bfoster@redhat.com,
	dsterba@suse.com, mjguzik@gmail.com, dhowells@redhat.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] Improve visibility of writeback
Message-ID: <ZgXJH9XQNqda7fpz@slm.duckdns.org>
References: <20240327155751.3536-1-shikemeng@huaweicloud.com>
 <qyzaompqkxwdquqtofmqghvpi4m3twkrawn26rxs56aw4n2j3o@kt32f47dkjtu>
 <ZgXFrabAqunDctVp@slm.duckdns.org>
 <n2znv2ioy62rrrzz4nl2x7x5uighuxf2fgozhpfdkj6ialdiqe@a3mnfez7mitl>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <n2znv2ioy62rrrzz4nl2x7x5uighuxf2fgozhpfdkj6ialdiqe@a3mnfez7mitl>

Hello,

On Thu, Mar 28, 2024 at 03:40:02PM -0400, Kent Overstreet wrote:
> Collecting latency numbers at various key places is _enormously_ useful.
> The hard part is deciding where it's useful to collect; that requires
> intimate knowledge of the code. Once you're defining those collection
> poitns statically, doing it with BPF is just another useless layer of
> indirection.

Given how much flexibility helps with debugging, claiming it useless is a
stretch.

> The time stats stuff I wrote is _really_ cheap, and you really want this
> stuff always on so that you've actually got the data you need when
> you're bughunting.

For some stats and some use cases, always being available is useful and
building fixed infra for them makes sense. For other stats and other use
cases, flexibility is pretty useful too (e.g. what if you want percentile
distribution which is filtered by some criteria?). They aren't mutually
exclusive and I'm not sure bdi wb instrumentation is on top of enough
people's minds.

As for overhead, BPF instrumentation can be _really_ cheap too. We often run
these programs per packet.

Thanks.

-- 
tejun

