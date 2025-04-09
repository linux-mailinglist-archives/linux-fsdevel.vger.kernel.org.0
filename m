Return-Path: <linux-fsdevel+bounces-46031-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED21A81A52
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 03:10:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C2D5884E08
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Apr 2025 01:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A881527B4;
	Wed,  9 Apr 2025 01:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="c8gdRIJv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B172FB2
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Apr 2025 01:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744161008; cv=none; b=WlyPGrP86fAzJgrqDSccUuOEs6MYL8wnJdmZzzR1zRhGZ1NYMJ3LVL039bRFiv8Cp+w/Zr4IejK6gPnv/grFnj08RxsA1pn8FGUg8IzxdkGMvSsYd9XV6GBXWfx/j9gAP9nWWZ8TRWkpQFpKV5JIfwvoW/ErQ1SPu47/0sqS8KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744161008; c=relaxed/simple;
	bh=vI+EfohMlWL16BIXX5jFk9OvrRypszgm43Q/E+JjCc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tfSnU7FkP+UtMAEN+B5V1Ka50/gJzC2bOAfrnn4WBuTiOnoEXMA7Wr5VHbVXaRZBJ/oQuS5OvYigwLkTpWBZd2Fg8weQvQFYG6H2YfS4CNHt1fG0px4Z3ntohR5XPEq2IvAQRdyd/ZY4aePwSXKFGhrL8DmMV5AlDQC4C+vxVMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=c8gdRIJv; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-af91fc1fa90so5231477a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Apr 2025 18:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1744161006; x=1744765806; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AWZtODb3GDxmRqlPxEa95doR8nCMt+btluf4lm5vvQs=;
        b=c8gdRIJvZeMwBH4qaL4YA0dEQJuFGwIxcoetD/abmnRjNx+oLpWPbVW9uNcDXV26Mk
         wKyxtf1sw4gTSO7qFlz5l8Ngsn8ewirQHwT5f7dEyViAaIVHInqIRggivblxIvXNorSC
         LEw2D87jxzu1RF2FSjZkUTZzWgnzerYLnzdmZ+415cWI40ddpH6nrr1rLnyMs58nfsim
         giQnbcaEshoOYouODwnv6lCnNus5Lz4SX417exXUo79yUP2oVYZ0rJLflGCGk55qrJMb
         8MyVnujDvXHhjJvOVg6gRKutE1Eb9Z5Z3qo9RdP8gSGVia+iNfiVz6vVun7XFXd59BeF
         +R2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744161006; x=1744765806;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AWZtODb3GDxmRqlPxEa95doR8nCMt+btluf4lm5vvQs=;
        b=aOshMUl1M95X7NedmQ8vS5oyU3+HLU2h5DynowRz3NtJPVR5g0iuvLlVUB7BWk61Ox
         T6pWGoGOlBAMIyuoPNNrWsJeb87VJGRbqESauonZ3Pu/mIoSwQcWuIRmGD+/zZjMVe9N
         RelYv0Qtk46mht80O7iInkxaK30ryRrDAAMMhMd325vXJJTAdQ3PwyOIw4O++GsCEVdt
         QysggL98UaX46Lx0+NofyKIe6Z3MsTo+GLCHT0DDiCNg9ePusO3W+x1U4kzQXl+MEnYP
         12LO5FVfYsnJijSc9qkubezm/fcnPR7RDrnTzo0hQMCiZN+isDBl6AiFc6TYh+2Aawsb
         LqiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWLnw5UGcB1y48Oqly+lnTcJVJMfHpizfxMMdvgZC/OwfcRENxbsBYt0DKhI0YcwCJOXYMpzfc4CU11Uem@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx/RqKGT1blh6c85UFZTi4AMaI9y+HHtzE72zkSDErvyWfLtEC
	gYtcYSJWVKE4paAxJ7IcJvCOBCyGII021ldN71HwT+d+63A299l+jHCWFWIxUdY=
X-Gm-Gg: ASbGnctUj4JyGr1GYBVNwOlPxztUtSAxYQznto7+0rJccR2bQoFJY/AdNc987BeJW7R
	8bQ+3is5hvlFv6dvI3ztdDhNfreNhWjhid6vhI87Lz94zBgUGF2Z75BLsTAdCBrvBoTX8l4Z+VX
	EqrZRGmmxR3zY1efCv48IkHqfhsHrENvSkKStrkNguR8LiebQ/1bc70EEYJXsjObgokhm6o8yKC
	4fPlKhyV1XtLvJrMo0llGzYwOCJCO4LouKvq59SNvSbWEF1To6BojlAoEck2/cua3gqqdCt824d
	xoZrUzukae7vUxUfxJIXUDYT/6/tmsRpRP9oyR2gjujhrf3ZWJMBWym0C0kqby8DZIN+anTNqHY
	KH802ojs=
X-Google-Smtp-Source: AGHT+IH6olDmv88J1IgkheSi1pM2o4dfy8Uoz/xoO8OH08Y/aWrC+qKgf76V1+82hvRhccrWZfieKA==
X-Received: by 2002:a05:6a21:3388:b0:1f5:8eec:e517 with SMTP id adf61e73a8af0-2015915180emr1510577637.9.1744161005828;
        Tue, 08 Apr 2025 18:10:05 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-60-96.pa.nsw.optusnet.com.au. [49.181.60.96])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b02a0cf2d9bsm74510a12.22.2025.04.08.18.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 18:10:05 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1u2Jx4-00000006Hcl-0fX6;
	Wed, 09 Apr 2025 11:10:02 +1000
Date: Wed, 9 Apr 2025 11:10:02 +1000
From: Dave Chinner <david@fromorbit.com>
To: Michal Hocko <mhocko@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Yafang Shao <laoar.shao@gmail.com>,
	Harry Yoo <harry.yoo@oracle.com>, Kees Cook <kees@kernel.org>,
	joel.granados@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
	linux-mm@kvack.org, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm: kvmalloc: make kmalloc fast path real fast path
Message-ID: <Z_XI6vBE8v_cIhjZ@dread.disaster.area>
References: <20250401073046.51121-1-laoar.shao@gmail.com>
 <3315D21B-0772-4312-BCFB-402F408B0EF6@kernel.org>
 <Z-y50vEs_9MbjQhi@harry>
 <CALOAHbBSvMuZnKF_vy3kGGNOCg5N2CgomLhxMxjn8RNwMTrw7A@mail.gmail.com>
 <Z-0gPqHVto7PgM1K@dread.disaster.area>
 <Z-0sjd8SEtldbxB1@tiehlicka>
 <zeuszr6ot5qdi46f5gvxa2c5efy4mc6eaea3au52nqnbhjek7o@l43ps2jtip7x>
 <Z-43Q__lSUta2IrM@tiehlicka>
 <Z-48K0OdNxZXcnkB@tiehlicka>
 <Z-7m0CjNWecCLDSq@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-7m0CjNWecCLDSq@tiehlicka>

On Thu, Apr 03, 2025 at 09:51:44PM +0200, Michal Hocko wrote:
> Add Andrew
> 
> Also, Dave do you want me to redirect xlog_cil_kvmalloc to kvmalloc or
> do you preffer to do that yourself?

I'll do it when the kvmalloc patches evntually land and I can do
back to back testing to determine if the new kvmalloc code behaves
as expected...

Please cc me on the new patches you send that modify the kvmalloc
behaviour.

-Dave.

-- 
Dave Chinner
david@fromorbit.com

