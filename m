Return-Path: <linux-fsdevel+bounces-5288-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B69E80974A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 01:35:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 502631F211DA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 00:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42936FBD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Dec 2023 00:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="X0X1fXqR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AB7E1716
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Dec 2023 16:14:37 -0800 (PST)
Received: by mail-oo1-xc33.google.com with SMTP id 006d021491bc7-590711b416fso674530eaf.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Dec 2023 16:14:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1701994476; x=1702599276; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KsKHFVig8Dki2bHfANw8ALG7R64wuw23sFTNA9faAXw=;
        b=X0X1fXqRWoy6qOoBp9aurah2Yrh+xZ46bIT3VwdaXNnaYvNFpCZKcF7Qm35xz2jDzr
         OiSmbqH4RjXVLRCeld7zeoruhaNeNb7eqtnY/AMVNn/SFmF5YUAw+vJIB6MoX7jS4dX0
         5umK00RiKQClpNIZV5U4Zf9PJbmTBF8wZ5y36N1sML2/KGSZ4f/kf8u5uYT52BRTu7TO
         u4zM6/aMi+Q0htcn3gYITgg45GtOric04GqUnDfY82BALVurXtkifM6e/Wl5Su8Gfshl
         zd8eZ18GfLYcPcQnyITCpjuRm5qOlLMlsk7oAbj3/EzxsFZN5d3CmcbcKwkFySRKVKEF
         dvtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701994476; x=1702599276;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KsKHFVig8Dki2bHfANw8ALG7R64wuw23sFTNA9faAXw=;
        b=kWR53HVx+CM9KZWNI1q/zntrxFwY3nB5SvxudEz4aKDKRkvcHuIU+vXkGIaUBouCgg
         X7LMgObPi61/uOA2ACKlzZPkEbWbKBo4UpU99y0g+VCP6nCHUsIUTrlHgQqMI6oyJo7B
         qgnZ9Gt/Cd1ByZxgeGbvcJeByisztk/1kP+Fh6O6St/pdty8X/Fa7BSXmFiB1Ry7S4aJ
         RuHIoBeWEF3eD30kq70tdv7WMS9NtviXb7/g6Gxpj9nSaTbU61Q7ptS1DCwZlQ9puYso
         5wb8mVw0qnrAVw3cyb6De2xXVP1jS0TlUrcPp8hSQUIPs1GmwoZcWVRAewnOOcCByi6v
         zwHQ==
X-Gm-Message-State: AOJu0YxEvWLLSYncobYk6e1aRl5y35zfz1ookUskOc0fnL699Vf9HyVV
	q0Kiw9SDlR7tCbzNlFp+zx9Ifw==
X-Google-Smtp-Source: AGHT+IGFhFEyHaePLp7aaH5vRLf4K84ntlrQqetpr3FB57IuOrBgLtT6SPajR7cU26q5dujAxeqGOg==
X-Received: by 2002:a05:6358:4320:b0:170:b35:16fc with SMTP id r32-20020a056358432000b001700b3516fcmr3983467rwc.9.1701994475967;
        Thu, 07 Dec 2023 16:14:35 -0800 (PST)
Received: from dread.disaster.area (pa49-180-125-5.pa.nsw.optusnet.com.au. [49.180.125.5])
        by smtp.gmail.com with ESMTPSA id h11-20020a65638b000000b0059cc2f1b7basm293544pgv.11.2023.12.07.16.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 16:14:35 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rBOVk-005IDr-12;
	Fri, 08 Dec 2023 11:14:32 +1100
Date: Fri, 8 Dec 2023 11:14:32 +1100
From: Dave Chinner <david@fromorbit.com>
To: alexjlzheng@gmail.com
Cc: djwong@kernel.org, bfoster@redhat.com, linux-xfs@vger.kernel.org,
	raven@themaw.net, rcu@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: About the conflict between XFS inode recycle and VFS rcu-walk
Message-ID: <ZXJf6C0V1znU+ngP@dread.disaster.area>
References: <20231205113833.1187297-1-alexjlzheng@tencent.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231205113833.1187297-1-alexjlzheng@tencent.com>

On Tue, Dec 05, 2023 at 07:38:33PM +0800, alexjlzheng@gmail.com wrote:
> Hi, all
> 
> I would like to ask if the conflict between xfs inode recycle and vfs rcu-walk
> which can lead to null pointer references has been resolved?
> 
> I browsed through emails about the following patches and their discussions:
> - https://lore.kernel.org/linux-xfs/20220217172518.3842951-2-bfoster@redhat.com/
> - https://lore.kernel.org/linux-xfs/20220121142454.1994916-1-bfoster@redhat.com/
> - https://lore.kernel.org/linux-xfs/164180589176.86426.501271559065590169.stgit@mickey.themaw.net/
> 
> And then came to the conclusion that this problem has not been solved, am I
> right? Did I miss some patch that could solve this problem?

We fixed the known problems this caused by turning off the VFS
functionality that the rcu pathwalks kept tripping over. See commit
7b7820b83f23 ("xfs: don't expose internal symlink metadata buffers to
the vfs").

Apart from that issue, I'm not aware of any other issues that the
XFS inode recycling directly exposes.

> According to my understanding, the essence of this problem is that XFS reuses
> the inode evicted by VFS, but VFS rcu-walk assumes that this will not happen.

It assumes that the inode will not change identity during the RCU
grace period after the inode has been evicted from cache. We can
safely reinstantiate an evicted inode without waiting for an RCU
grace period as long as it is the same inode with the same content
and same state.

Problems *may* arise when we unlink the inode, then evict it, then a
new file is created and the old slab cache memory address is used
for the new inode. I describe the issue here:

https://lore.kernel.org/linux-xfs/20220118232547.GD59729@dread.disaster.area/

That said, we have exactly zero evidence that this is actually a
problem in production systems. We did get systems tripping over the
symlink issue, but there's no evidence that the
unlink->close->open(O_CREAT) issues are manifesting in the wild and
hence there hasn't been any particular urgency to address it.

> Are there any recommended workarounds until an elegant and efficient solution
> can be proposed? After all, causing a crash is extremely unacceptable in a
> production environment.

What crashes are you seeing in your production environment?

-Dave.
-- 
Dave Chinner
david@fromorbit.com

