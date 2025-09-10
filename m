Return-Path: <linux-fsdevel+bounces-60827-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB76BB51DFC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 18:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EFFB1888DDD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 16:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2DC279792;
	Wed, 10 Sep 2025 16:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="RHS/O7Wp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744FD27145F
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Sep 2025 16:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757522390; cv=none; b=ri4hjxL4O23e+Fz/gX8be3gHG7puAYpnyrhS4zTVOyaTVArOY39EjHfCRE/pyjt8HGcNq50p7eLgNnz7yfKhYRklcxr9ShYcVICJmG4qeBbvDdWBHS0oddBKFhtiP6fLvO4+VlkoKKKPEiOAnBDvC797b2FVr5VYYcfTA5Qs8dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757522390; c=relaxed/simple;
	bh=hbjFWc/M1u0JtUeGDfraCyEfZ1LuYrMt6ic+SN3g7Vs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tVvSAWZyRqYUc8M2BLim/f+14qLZWs5I1iwWNDRRuWyZgyDcI1xpDls+ds1t0u9g1otclLJxPQuds83DhHWyU1OxNhK5iNGlKBAbn9qH7lNpkOoLiDm6iM3pVOe9613YcBhkhQpzDVweTPKQp4Ga9L28Tctrv1AXf43fiH7dbgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=RHS/O7Wp; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-40c8ed6a07aso27395815ab.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Sep 2025 09:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1757522387; x=1758127187; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/+f5haOvY7V5aJLRvqMe+OKgyMJap2D1kg9AHRnXBFo=;
        b=RHS/O7WpW2bKu3dkD3GuvUB5YTGA6gb7LyRfu04M+JBfGeQSuhkT/9v/nk/R+dCoyX
         mZsi1sKflT/XdZwHcNBieE1AylK3Qix8qUwrzhYZBj750TLxjVeOdcOWZXYvcj2GenBj
         MSoClkJ/PsF+80kRfPRItEj7Tm8QePGqSzJ+QsmXJFA9doy+ahyquicL0MG8caYp2OlB
         12byJ3aQN9mNWsdieeNi/AazOX86gv6oqRz8IP9rkgCUTTxmZp3BM2oUxPZN3vW0lahe
         xvDFzSbVRTFzXeitmxBk2z2OUGa+MHihFvw3YurqqUNqs94s3BNYsz99KAOAQOFDWNFA
         OV0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757522387; x=1758127187;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/+f5haOvY7V5aJLRvqMe+OKgyMJap2D1kg9AHRnXBFo=;
        b=G+KhMo40vHtxvl/t8D7AjgkXKm+rO7FxSYmNpQ6m3Z+SvaomqBFN6FZYmupcgvT566
         UQmD2x6CcM9o8yCnJRbP5qkXr+iKaKjq00krbUvqztspRjlyEP0OcNM+rg7lcIwrHkbD
         hcuzcpAFyKRjP6hZ9kEpXlanNP2qm3Ys6240xW9pjsAWuAsrRiTpEyqf39H7eRydQWH8
         oICFZ1yVqLrC0GsWhVZG/z1ottSeY5hnna4CaifbS2PQskynb87NCuWZgeMO8ieEIJzr
         x13Nbenzx4uRE/8r7MT2pITwpvkvhMeCU+l6Pj253lVgkEcsm/YUU/CMPTFr+9m2eCdg
         po5g==
X-Forwarded-Encrypted: i=1; AJvYcCWhEkV3dDDMXnAn/Bac0lFXCU/kZuAFXlVC34b9TBaR+00dG0fRNSPDJHSUdAsFm1sxdoqpPhUJ7Oh1a1r7@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx7Ewdsd/z6qeY6LWKcvUBY3hNuvRbSuJVQikGs31jKxBi/t06
	V00qwcdQCEt3KX7wQKBoax9NJB2sSVpt7wreLnnE5vekTSx1/r5IFhaduipXmV70NPs=
X-Gm-Gg: ASbGnctxMODxwQG7G/PuNzf29475Tzbtv7yHEhRzPfwirVyes9ytdK/2CU+UFKyJOVY
	WvEYg4HMrHctgKC4IxbWSDRIHfW9Uxd8Gu2q10YJwkQmowVqmvqbakI6whDtc8vpSwSxztIHv2b
	ALxlePKp3T7q1iVdwhIl9JdBInJVMG9MIGgRHK5he1lk+X1ISokSMPkXriFmGyp4rejYmGK2Bas
	O82UHCidHzBECaxkehGccWR2qWBy+/MP2np7wyHD9jAsNXM7rgj65eKtDMqHu/CjyuLMboLi0+2
	guetrH7XkKR20QI74n8v7HRbsCMMyv3aLoQJ+9592k54QRpuOgTujlzo9l4MLiIf5OYob9oTDsn
	PGfGr7J1idFFkQ6jXOAs=
X-Google-Smtp-Source: AGHT+IEb5WYlYRXj9KAGrUB6b6ycfigzKegEaHb0jkZarvr/Z/Q5oCi/e4o3PHKyP6WP+mXNVGSbxw==
X-Received: by 2002:a05:6e02:1a69:b0:3fd:1d2e:2e5f with SMTP id e9e14a558f8ab-3fd86264465mr231635655ab.21.1757522387509;
        Wed, 10 Sep 2025 09:39:47 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-417c8f03f9csm8607825ab.43.2025.09.10.09.39.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 09:39:47 -0700 (PDT)
Message-ID: <a2d770aa-737b-43f5-8d1e-0c139c09dc0c@kernel.dk>
Date: Wed, 10 Sep 2025 10:39:45 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/32] block: use extensible_ioctl_valid()
To: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>,
 Mike Yuan <me@yhndnzj.com>, =?UTF-8?Q?Zbigniew_J=C4=99drzejewski-Szmek?=
 <zbyszek@in.waw.pl>, Lennart Poettering <mzxreary@0pointer.de>,
 Daan De Meyer <daan.j.demeyer@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
 linux-nfs@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, netdev@vger.kernel.org
References: <20250910-work-namespace-v1-0-4dd56e7359d8@kernel.org>
 <20250910-work-namespace-v1-3-4dd56e7359d8@kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <20250910-work-namespace-v1-3-4dd56e7359d8@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

