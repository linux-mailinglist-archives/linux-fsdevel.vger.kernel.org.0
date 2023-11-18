Return-Path: <linux-fsdevel+bounces-3124-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55CB17F02B8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Nov 2023 20:42:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 868201C2089B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Nov 2023 19:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2B71A70F;
	Sat, 18 Nov 2023 19:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="N9yWi3VR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3C1196
	for <linux-fsdevel@vger.kernel.org>; Sat, 18 Nov 2023 11:41:56 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-50797cf5b69so4163635e87.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 18 Nov 2023 11:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1700336514; x=1700941314; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=arrWkxXHqp3RBN6xKz1SeOK4wu0R/9RHSILdDDeQh8c=;
        b=N9yWi3VRtgxBKD2q079Y0mlUfEFGau81ikloMxHfXG1VGTTLVGYdA5LdyKCG/+lBp2
         u/pyy2g11k+G+xz9LBFQT46OpyScaw/PodLAt/X4qQFU0C3g2euznDidmQ+Ia+4bHQZp
         SdE0FSONEG6xkfqMUBfhO1zNbtzORglxvwufU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700336514; x=1700941314;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=arrWkxXHqp3RBN6xKz1SeOK4wu0R/9RHSILdDDeQh8c=;
        b=JzUn9bKUAb7QV/KR4ybZRgM0s6LcqAMuGFc20rmX0PiTqzLZWxlDkFyPOO8Ag4fqUK
         Rd0dRNKgWMgrnhFtkhS559JQnbBLxAJznRMm7pF9oKAZuQLNV3Seez/zrodEg/0zcjuf
         cK0rVj31xiT9Q8mKMpwtRF0SsU0RBZH7Wy60pfuF7YzG5Di5u17d9e5c+laA+vr5no+4
         IBJTU3QGqJHO27/SgHhMmg/hzR006ifRrnSBPMp6vQ6uE5/EZzqwGM9ckv3hUJGUKmva
         7H0u4zxXw11dSxBIXS50lcJWwiRfjPkO4ldA9cfXz3wY+h4QctsjT62y0HmjGX8uN2Ez
         oEGQ==
X-Gm-Message-State: AOJu0YyfhDyHrgcL3T2Q1YK5C2ndwVLy0yFEYteG9LzOW5uYXeD92K0K
	TFUGul/dmMJEyMMpjJffbWvsp55DRbLNMX4SuaQDWzky
X-Google-Smtp-Source: AGHT+IHR77hN/1VcNagp4mQw/Qlawl30afDRaU20w+h1pCXTlYujvxSiv7Zcgh3Ix2joa6fFmU/U/w==
X-Received: by 2002:a05:6512:aca:b0:50a:a9e1:6c58 with SMTP id n10-20020a0565120aca00b0050aa9e16c58mr945917lfu.32.1700336514696;
        Sat, 18 Nov 2023 11:41:54 -0800 (PST)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id w14-20020ac2598e000000b004fe3a8a9a0bsm650701lfn.202.2023.11.18.11.41.53
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Nov 2023 11:41:53 -0800 (PST)
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2c50cf61f6dso41027911fa.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 18 Nov 2023 11:41:53 -0800 (PST)
X-Received: by 2002:a19:6409:0:b0:507:a6e9:fbba with SMTP id
 y9-20020a196409000000b00507a6e9fbbamr2364600lfb.63.1700336513175; Sat, 18 Nov
 2023 11:41:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87zfzb31yl.fsf@debian-BULLSEYE-live-builder-AMD64>
In-Reply-To: <87zfzb31yl.fsf@debian-BULLSEYE-live-builder-AMD64>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 18 Nov 2023 11:41:36 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgC_nn_6d=G0ABjco5qMMZELGrUyCVQN3zB8+Yo5F8Drw@mail.gmail.com>
Message-ID: <CAHk-=wgC_nn_6d=G0ABjco5qMMZELGrUyCVQN3zB8+Yo5F8Drw@mail.gmail.com>
Subject: Re: [GIT PULL] xfs: bug fixes for 6.7
To: Chandan Babu R <chandanbabu@kernel.org>
Cc: ailiop@suse.com, dchinner@redhat.com, djwong@kernel.org, hch@lst.de, 
	holger@applied-asynchrony.com, leah.rumancik@gmail.com, leo.lilong@huawei.com, 
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, osandov@fb.com, 
	willy@infradead.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 18 Nov 2023 at 00:22, Chandan Babu R <chandanbabu@kernel.org> wrote:
>
> Matthew Wilcox (Oracle) (1):
>       XFS: Update MAINTAINERS to catch all XFS documentation

I have no complaints about this change, but I did have a reaction:
should that "Documentation/filesystems" directory hierarchy maybe be
cleaned up a bit?

IOW, instead of the "xfs-*" pattern, just do subdirectories for
filesystems that have enough documentation that they do multiple
files?

I see that ext4, smb and spufs already do exactly that. And a few
other filesystems maybe should move that way, and xfs would seem to be
the obvious next one.

Not a big deal, but that file pattern change did make me go "humm".

So particularly if somebody ends up (for example) splitting that big
online fsck doc up some day, please just give xfs a subdirectory of
its own at the same time?

            Linus

