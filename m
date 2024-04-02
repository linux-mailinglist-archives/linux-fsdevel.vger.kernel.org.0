Return-Path: <linux-fsdevel+bounces-15875-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F5B895423
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 14:59:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82E051F22A6F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Apr 2024 12:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D117FBA2;
	Tue,  2 Apr 2024 12:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="O+kh+0Xh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331FE7EF10
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Apr 2024 12:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712062764; cv=none; b=B1EwMmwHZPj/moio0xOX3Pc8Ey5aHzxlb2W9igexbRAejBx/Nf2cqrlyJ/bSylNZ479A7hgD8kE/6D3SDH38MxXL9S+GLCduWd2LgNzlpm+mmCaXTvJwnwY/rNRBwh6CAbrwdNv4qWZXbDrTs4WxevXqx2qTs6eYbZbMOxJmFdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712062764; c=relaxed/simple;
	bh=tiK9jKJ2+xXuH8WXQGbb0XpXEfM+vM67ITuCAXHE0dU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=adSQV5cDDafCn05ZFTpqNbU35UkeTeQFRYkJDnHa/tyca3SLwekjlOi45+WfDGxNL/R3ROL7WNs/pjyKcW2dlhdGyI3MnPF2yR2VRiLRokrOUjhGqmCluLLahf5Cx52uPpDScAezGGLuckccEd91N9nOmt1q2My96NGdg/G2dhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=O+kh+0Xh; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6e696233f44so576227b3a.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Apr 2024 05:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712062760; x=1712667560; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WFjYmEuWTIY3JaRPL6EesdmjDFY5OtvnQu536kNTjd4=;
        b=O+kh+0XhqBpGCeoXVeckb1hbaHVwLb4M9W+YqjkdbUmlRgO9m4ZV34KC7CRHVC7Ol9
         Ewv/KWd5HHm5sMl9X3hlXA01e0GxswykkoydUYb/pOO1wcLO69meyZF7r+CYoMJBcKLJ
         jzx8iO0e9wJq9I09xl95slJzz+9vPZiNI1CEcCSsLGePCTek1A+e2sx306lUFfUS0XIL
         ixNwuwRZSo7y61mnnWwySyMM3y/XvqFfrlZY1vA9/ju9v1p+xHDfF9Xx1JAWny4F68XP
         TOzOPUKf0WeEenBNcJuDpSWCRluMnbUGja2P45KPV1/hjNbxczQwJ8Wjb16h/+9lak/l
         Oq/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712062760; x=1712667560;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WFjYmEuWTIY3JaRPL6EesdmjDFY5OtvnQu536kNTjd4=;
        b=Pjr6/1efPRu3n1C/2Gxd5UrOhPBxfrE4GiC21UR4l4H+BjpYuvNCWxmScX4PMLOB2I
         B5tUWegmlzFUXGmT79CAofthHx0+F9xEii+PkmwjxxsFvXQ6xngRe9chy6+GpZG1MP/9
         jR7HnfYmsvHTtipZwrAFdjfsrtZ5320YYOCbX8rULv0ldmQZ1d6GXe63s+PYDp5Mm9Rt
         z2unEKXDPDDPRPQdfJayCb331gKz+L7iGlmV2zyQrGm3gdqlO1898Hp2MApfZKSR9rU8
         192YpWVQstEnANXO0w7Z7cFMWa/PWTtmQPPvDXV6oY25JOAtDUL3K7+JDZgFAUgUDrbh
         rClg==
X-Forwarded-Encrypted: i=1; AJvYcCUoZDzUgkOgvlR3BUCtv8er7mwKPvFZvU9DwFcMd0hbFoiijRbKVzo42AJJq/+4hSSuJJff7HO4HYworJTv26xE40daR13jCt7CYrZ2Vw==
X-Gm-Message-State: AOJu0YxAD2MV24ySxjjMEvE4369MpOAG0tUCs3neQmfTcmISsZ59Jh4/
	z+dsEumR/RzR0F/xRD/bPwM3nAA/9UxnPRmtNuEAJDZWmxJ7GRGvyqhTbyTjzGc=
X-Google-Smtp-Source: AGHT+IH0ArF1jhsbGRi1BzERtUavmZVX4yVdDKAX/YHZKuB0EYztAUiFcsrm/vEfhvOSnaPo5K25Xg==
X-Received: by 2002:a05:6a21:a5a3:b0:1a3:b0a8:fbe9 with SMTP id gd35-20020a056a21a5a300b001a3b0a8fbe9mr16248531pzc.1.1712062760425;
        Tue, 02 Apr 2024 05:59:20 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id bw28-20020a056a02049c00b005dcaa45d87esm8474183pgb.42.2024.04.02.05.59.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Apr 2024 05:59:19 -0700 (PDT)
Message-ID: <65e9d205-5ba7-4cfe-ac28-bb0494cc61b9@kernel.dk>
Date: Tue, 2 Apr 2024 06:59:18 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fs: claw back a few FMODE_* bits
Content-Language: en-US
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Dave Chinner
 <david@fromorbit.com>, io-uring@vger.kernel.org
References: <20240328-gewendet-spargel-aa60a030ef74@brauner>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240328-gewendet-spargel-aa60a030ef74@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/28/24 6:27 AM, Christian Brauner wrote:
> There's a bunch of flags that are purely based on what the file
> operations support while also never being conditionally set or unset.
> IOW, they're not subject to change for individual files. Imho, such
> flags don't need to live in f_mode they might as well live in the fops
> structs itself. And the fops struct already has that lonely
> mmap_supported_flags member. We might as well turn that into a generic
> fop_flags member and move a few flags from FMODE_* space into FOP_*
> space. That gets us four FMODE_* bits back and the ability for new
> static flags that are about file ops to not have to live in FMODE_*
> space but in their own FOP_* space. It's not the most beautiful thing
> ever but it gets the job done. Yes, there'll be an additional pointer
> chase but hopefully that won't matter for these flags.
> 
> I suspect there's a few more we can move into there and that we can also
> redirect a bunch of new flag suggestions that follow this pattern into
> the fop_flags field instead of f_mode.
> 
> (Fwiw, FMODE_NOACCOUNT and FMODE_BACKING could live in fop_flags as
>  well because they're also completely static but they aren't really
>  about file operations so they're better suited for FMODE_* imho.)

Reviewed-by: Jens Axboe <axboe@kernel.dk>

As you know, this is going to cause conflicts. Wondering if it's worth
doing anything about that...

-- 
Jens Axboe


