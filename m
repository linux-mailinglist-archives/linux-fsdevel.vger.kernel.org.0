Return-Path: <linux-fsdevel+bounces-47788-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14BD5AA57A5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 23:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 717824C1D41
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 21:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5485C2192E5;
	Wed, 30 Apr 2025 21:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RZWfQ+VK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCD0145A03
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Apr 2025 21:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746049725; cv=none; b=S9FR4C2BU6mhKg6Jr76NoupszEs8ytY7WdHPmg8IHTyg8s1kqJ+gTjekO4hSgeYDM8FebqRftJxRxpJ/+NqIcBOECpYjcTVsrFn9EXxRDhx3Z16B1Wx0pRQVu5QqUUKofeDF0rj/wrQcC+z6G0nrQkK9cOWflfXTexdlsXWzCIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746049725; c=relaxed/simple;
	bh=r2WABLEuZyHUwCiahvJp0zP2KImsIy0b9P7RjRfXqkI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=s+S26lBYeWCMespBJJXIm8NteTLEEnuxgnBVs1a5+lgovfB/hd4CfkLHivR1oaOz3q0IpqUmIyXmXVIFiiBrTkvRU7MltX1Fi2NBGdqhtd3U3w5vMiOo9i55r2nY6w2AkuhqqVfxAM47mZHAma8wsIKL/OQz6nf6wrnlzscWSXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RZWfQ+VK; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5f5bef591d6so723980a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Apr 2025 14:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746049722; x=1746654522; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iLrK3qQxyLdijWdeWucV48zovTzOQ4wbSqZM9lRGQ88=;
        b=RZWfQ+VKUpvKlhfYdRPt01AyqCGbCuLQ2BdAmCJlGdQCnhAYIj7qtThGMEFHdnCuUV
         quBc6z9aNHD6F9s0A5Dn+nF9vLpkTlwZ2JtpJ2+qCAStgv0h93cECES9wZdeVw1tN6uw
         SpvhnK1M4jUAPmr6vNKkwGujLk5TtbRCsw25aVKsnhC2+YRvLodajyWYTAOdv3DTn5it
         Ql+U8FD76SanF+pSshoK39Gj50UOCFa13wM1fnS0QV2WHAVEyKxGNoKtzZbDyx7dMInz
         R+YN9UY5s35IFVCqnUo9f1Cntc/Fwb3zVqhGAXhW/CXVBlsOnTCtS6Y40BFUPsa1l5hd
         0oGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746049722; x=1746654522;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iLrK3qQxyLdijWdeWucV48zovTzOQ4wbSqZM9lRGQ88=;
        b=PTVAC2Csa/8HgjoM8xqT68s3NAV+cnfVM5xL36FyxG4GOhSFRGcyk6AqgX1JRiZcSj
         gTVwHk1PmuuKY1V8my4MNFzxWNLNYwCNeHbsJEv0HgxmjwHAFaNx80SAuTJEpTu+kFi3
         C4GlstQDH6Li8mt6fNSabpBOJmNnoYSUQ4UoIr4GafHxAHvs7EASzDEVhttcG5MyeLos
         vik2SPiKQFUY0myNrVktmlIUdppp/xe07UJo92qT9QQ8ftor0h6L1b9CGFSVcWn4Mwu3
         DcItFK/egUl7pTKllHHfUFr8y9NZm50YR+k11KymHJ6t1tOxYKI6t7+oSqSIUGOcKF3a
         VsFg==
X-Forwarded-Encrypted: i=1; AJvYcCWNsCdFLxwOg7rT7/EDC2veITSI8KrDg/9KDPbcgbNM7N1kdPBSJrnWFh4k0QfVzWxe5ttdLRM63KKTRNKh@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+CcZmauO0eDEglIkKX2bjZkKFnFv0QGLE/ZhhUZFszmrN+zak
	tczkrrWJ1f4HSYELLCl74z99xULGJ9JRGSstn37xLfRi2Paq41TiKwnolmclMf3ziIc4kKjRuHh
	HHKocqkAQVkA7WQCLu0cxQnjotmU=
X-Gm-Gg: ASbGnctG08WPq+l2TgzDamCrX9bZbdg4OUtNswMkikXbZAogwrzU8sJAa/4xvIUI/G1
	j4PVF5g4o7BjOtmP2rfRsFlDaFfpgh53Eg5KrKZbv4kyk1VE7Kmirc+X/Vd/T56LQ8BtpYLLrI4
	x9JCwV3M5eP5Ny/ZeXKpM=
X-Google-Smtp-Source: AGHT+IHTsdTt9LALqBG3i/SbJaN3GWItsxOu8RbeFJmm2R8t+GXV4ekLCOkPyYr4EbVZPRmJ+ukRJxHPSoalY+Tf0+s=
X-Received: by 2002:a05:6402:845:b0:5ed:2a1b:fd7d with SMTP id
 4fb4d7f45d1cf-5f9193dfad3mr158908a12.19.1746049722140; Wed, 30 Apr 2025
 14:48:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 30 Apr 2025 23:48:30 +0200
X-Gm-Features: ATxdqUF4RUxRrk_BZWwzEaeKIBOfKUOktntHKomW8_c0-mVOO8Ue4zafRpubKTk
Message-ID: <CAGudoHGyj=pXR9PHURdSpyqmpsTa6NNGfrunWt1M0TNPXJEA3Q@mail.gmail.com>
Subject: concerning struct path handling
To: Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

This is not something I intend to work on, but I'm throwing it out
there given the recent refcount bug. Perhaps someone(tm) will pick it
up. Given that I'm offering 0 effort, I'm not going to argue about it
either. ;)

I believe the current handling is highly error prone and it does not
have to be like that, albeit I fully admit I have no idea how much
work is needed to redo things the way I'm describing here.

The key problem is that path_put can't do anything about pointers
stored in the obj and consequently can't help detect bad consumers.

two key notions to combat the problem:
1. an invariant that a populated struct path holds exactly one ref on
a dentry and one ref a mount point
2. path is invalid to access in any capacity after path_put (other
than reinitialization of course) -- no null checks, no nothing

This implies that path_get() goes away.

Opening a file has a spurious path_get/put trip I already complained
about, that goes away as a side effect.

A dedicated routine can be added for consumers which need to copy a path.

For example the following in get_path_from_fd():
                spin_lock(&fs->lock);
                *root = fs->pwd;
                path_get(root);
                spin_unlock(&fs->lock);

can become:
                spin_lock(&fs->lock);
                path_clone(fs->pwd, root);
                spin_unlock(&fs->lock);

There are legitimate reasons for multiple threads to share one path
obj, for example like it happens in struct file -- this remains
unaffected.

One idea how to implement path_put():
- if sanitizers are available, the dentry and mount pointers are
marked as poisoned -- it is illegal to even read them
- otherwise the pointers are set to a known bad address (for example a
non-canonical address on amd64) -- this does not prevent loads, but it
does guarantee trapping on deref ; this can be conditional on
CONFIG_DEBUG_VFS to not affect prod runtime

Personally I would go even a step further and make unpopulated path
invalid to pass to path_put().

path_put() is a kind of a bad name as it implies reference handling. I
would change it to path_destroy() or similar.

My $0,03.
-- 
Mateusz Guzik <mjguzik gmail.com>

