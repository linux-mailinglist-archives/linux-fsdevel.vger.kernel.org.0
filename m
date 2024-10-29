Return-Path: <linux-fsdevel+bounces-33108-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B279B9B45BA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Oct 2024 10:28:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 768DC281941
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Oct 2024 09:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D88F2038A3;
	Tue, 29 Oct 2024 09:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XXfxrvZt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50691DED7D;
	Tue, 29 Oct 2024 09:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730194073; cv=none; b=Zz8gD0P+MhdGudNm+kjSm+jdZDJy7gzfASjhUAeYp6lZs6jZ32sMhvUVQpZop02M+W7pOY5hzYjRGT1N6oQAvcB1ZVdoJ7JGfUJq0BWOF9cX6DYUJaJ9xINtnFLKCyXUtTMPE86wSRsaXjA9A4w0znzf1Fs11H0zxPi97ipf1i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730194073; c=relaxed/simple;
	bh=ESGppA5bJxqOzigf8fGK5hjk07t5fMAGh12Krkr8luE=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=ElGEGBmx0VFZLQhGpY05ksoj3nyC4ixbuZclUGoC3ADadLo/oMjURb3b4ChYWu2xX5HmUnwqo6HJB8caURrMT9q/CAVgSRkB4Hsaq4ESa3AMlcbSxmQVDnZc+yyaXGJHrtcfZylaGjGu9iOEhOvJXRGEGYZf8H74OGlSFMDFQbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XXfxrvZt; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20caccadbeeso56395565ad.2;
        Tue, 29 Oct 2024 02:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730194070; x=1730798870; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QBG0+3vCp3Mx5LE+gQt9yK/wvvsHKfKt1BI1a2BcVi4=;
        b=XXfxrvZt1+563/kn0TuRj/g5+CxxrmldeXA63FOVDyzU5rW1dh5gKp9g15g6+gXVrz
         bklpZCKOG9NtFMRvumnj8/S5ISLOjp+jzing6iiLISO20CaGka5Gnl61JrTC8z5pK1w+
         a8h9Wn2pavz/cKxixvdlI1R2JtVU+ordvMxu01i9/l5JY9UNC3jMwOhh9fN4+9FVsPAY
         R868JVHs5gS5r3x1c1ZBSFFfp2N9XpTP29MPw1fY567Zb4Dr0PP2Xh+ywvuRr8ZJv41M
         kVUIlg2TPQy1/MqGVmrbAyRHmHeyGRndloxn9x3UQwt3Anmm3HUPujJlKnIdvlMN2ZOi
         2eZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730194070; x=1730798870;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QBG0+3vCp3Mx5LE+gQt9yK/wvvsHKfKt1BI1a2BcVi4=;
        b=AI3SCJo64zEVZbEH9D6BF0+2QwBbWYCTpTrF4920wOijxh9JZLJaHp0qkYimdf8Ple
         zxqAPHpCABUi0NVZgngKq+FP/garGAolWqJrhqtrYi8fjSEznP92OcNy1pITzNb1DA6N
         eiJUKPu3ZvNwQdu649/E1Jx+kVhrochbZFhD01Qhdw+LPHDcWN8xJE1ugKD7YF/xgbj5
         kvi3bBUDqwnDk/MHrlgPzvfkzvEP0ONR+V/U0afDfSMAzxiFwi9EJyeX2UnXkG8eabLV
         x8zlKhDwj1iADVOBy++3FNhQ8BEdAt27C6Kuje9vFfOq9uY1M/nxIDeJlqSFD+D5wiZx
         mh+A==
X-Forwarded-Encrypted: i=1; AJvYcCUb4pbQCJRGYU9aY6Ezu+kvxPpQQdbCoqR+ERAGpGtqugUmreusGBceXMpiXukpS1XDW0gkOsliGRuTQX4jkw==@vger.kernel.org, AJvYcCV1t/U3Na2a5qxrwQjREyh3Dtmzwewdd8wCprMu58j6Y4032AUpQ8Rdyir1afpGe5AdvzITGJLr0tIK@vger.kernel.org, AJvYcCX7x7FuS2H3jktZXay/PAqpoYazKuob9LdYRjHiRClfYmUz197W9OhLsIElJlmIMl0g/nOIOeOiqOyp@vger.kernel.org, AJvYcCXNVO52dgpDW/TZUeAKdMdYTzQmJcBr/68uXHd68mYOzHjIdea9UHmT9EbK4IsHSiC+cvwBlHX/vCmbHyUN@vger.kernel.org
X-Gm-Message-State: AOJu0YxvGzOdcYWEb9EiqFKLibRHtbJokd8+oJziXiAbKuqEhBJXzNQr
	pVXWbKAC91uiRJIhjPhGeyaUdRQ1HOUfOSVn4eBMGqHpCYRK4vxGCvYRJQ==
X-Google-Smtp-Source: AGHT+IEQPjaOFOdcE0OCXofDTADjPw0zTTXnGKUJoCxqll0WlQHDFbZIyZfq8kqv0jqWol6C5VoBnA==
X-Received: by 2002:a17:902:c943:b0:205:709e:1949 with SMTP id d9443c01a7336-210c6d4450cmr135520975ad.57.1730194069886;
        Tue, 29 Oct 2024 02:27:49 -0700 (PDT)
Received: from dw-tp ([49.205.218.89])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bc02e97asm62438475ad.195.2024.10.29.02.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 02:27:49 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: John Garry <john.g.garry@oracle.com>, linux-ext4@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>, "Darrick J . Wong" <djwong@kernel.org>, Christoph Hellwig <hch@infradead.org>, Ojaswin Mujoo <ojaswin@linux.ibm.com>, Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] ext4: Do not fallback to buffered-io for DIO atomic write
In-Reply-To: <fff46380-1e01-473d-860e-19d5a02a7d1c@oracle.com>
Date: Tue, 29 Oct 2024 14:52:27 +0530
Message-ID: <875xpbmffw.fsf@gmail.com>
References: <cover.1729944406.git.ritesh.list@gmail.com> <80da397c359adaf54b87999eff6a63b331cfbcfc.1729944406.git.ritesh.list@gmail.com> <fff46380-1e01-473d-860e-19d5a02a7d1c@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

John Garry <john.g.garry@oracle.com> writes:

> On 27/10/2024 18:17, Ritesh Harjani (IBM) wrote:
>> iomap can return -ENOTBLK if pagecache invalidation fails.
>> Let's make sure if -ENOTBLK is ever returned for atomic
>> writes than we fail the write request (-EIO) instead of
>> fallback to buffered-io.
>> 
>> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
>> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>
> I am not sure if you plan on dropping this patch...
>

As discussed in the other thread, EXT4 has got a fallback to buffered-io
logic at certain places including during short DIO writes unlike XFS
which never fallsback to buffered-io in case of short DIO writes.
Let me send another patch for this one.

Thanks for the review. 

-ritesh

