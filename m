Return-Path: <linux-fsdevel+bounces-60261-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C29F9B4391D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 12:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F31F1712A2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 10:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E15A2EFDB4;
	Thu,  4 Sep 2025 10:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NcZXvVZQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37AB313B5AE;
	Thu,  4 Sep 2025 10:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756982760; cv=none; b=nR4l0RNhtxvJCWHv/NK0V3MLlN3z+QStdBDvSXklKnNRxhyY61qCbinxTvca2AVETzkGj4+esGbxwtstGCLMp+8+GrGclQltyFJ1BrO+zHlblBeXiYh6U1Gh4N5VHX5CauccY0xZnbilv2aEyJkngmX/gMq6bgNPf3t8PnztdDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756982760; c=relaxed/simple;
	bh=MPUjHFlTdbieZ7QdRWGUV5AExD6awTtz6i3IwwWE+LA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G+hzBhV4AwSCWzkUKUg1oyMi7fgJAfigNjYBxcksOAhItY68K22+k8if6kExNFLgPux8GZYmWn63UcjAKv9Df8U4FiIn+pG1XvUUmF9Bp/pcS1pEqyGXrJmqY/DPPTMaRGdrxLiAa/EOsJzCYvRV4eiVeJExLY7jaJQr9DiDQAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NcZXvVZQ; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7725fb32e1bso1020967b3a.1;
        Thu, 04 Sep 2025 03:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756982758; x=1757587558; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1SCRhDwaQOzRQIc0c0iIQrCD/f9DriLrJWRg8T3EfRk=;
        b=NcZXvVZQLpzCa/Uv24QmqicgMrCA2NRXAjaBl1wzguxX1tFhUsksDI7AivcIeul+kQ
         L/W+d5wcxZ3IojAlRSLFdnm15djb4CkGdLavD3zIaootMYuXcgXYz8e0+Lylnxg69ALy
         duJA4Vyy39MvPqwlRO7IaKbS9bFZzyxlUnzUzyHeUzVFhr/mr11KhAMhmvJHK8iJgB0e
         +1Z6kSyO32BsEF8Eeg8GS8fulH+Q/fzgewcAe2kzbTCWPy666d5x+z4uhOjGzIp8G1mG
         po0Z4ZDQ7Ui5KjKpgIleOPbnaWLjXJ6joisBDjx7zjzQL2gE0VEWPAXVfzIsbPNt2XK6
         kNZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756982758; x=1757587558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1SCRhDwaQOzRQIc0c0iIQrCD/f9DriLrJWRg8T3EfRk=;
        b=WHubvV0Mds3bUYG7Iuh2S6LgBIfA4j8+qIPzv0n/4BRsvGBcvTC0pwo7/Xq0wpJFut
         6u+fwsbTqkDJHRlhuLNJBz9rzrfrDX0HurqbLtGLq44t8fmCrI5POmr8JeeULbpX2VAr
         8fbvT6xiuLUPD/6FbxQJ7BV6zTwc5bmpwK0Z+uBRdqP7B7DdtHdWGJkIouoW0+nFMFw3
         30UE2Kggw2nLL4swZQz3YRX+zEO4kSfVLbqYlLI6ndyO+2jHv0Mkw/X7hLLgEy1YMfzq
         VgQQH9t5/l9GzJu9/540ZHkR3P6FPRTv32XFtvhkOVaTQsAOlDkWSGQ67X/vy0WP1wal
         sBsA==
X-Forwarded-Encrypted: i=1; AJvYcCWP3No6Qxsz04iokxZLfsw6T9vudhNDxP16SUgC8FS5micdEIjChvkrJYkk7PxcpfyDu2eVzJvcO3nDbYBk@vger.kernel.org
X-Gm-Message-State: AOJu0YwFPuHHMUlhaIBRxH3UC/TtcKv3ol6iu9y3uytDOXqzdXqZbhch
	45GvQKUB02kdg9MlGWZEsZmo4O2wHyBFggrTcZhAGndb8chl7jQz4FXQXu24huP6YIS5z9qgBys
	GK5+Yj14CLyz9EFaDluUpGN/i5LFOlpf9+iUb
X-Gm-Gg: ASbGncunvtB6jRHta7y+dDgLhFhKDKYnwpDO8J5IUHJGTomUa8tFrmJe7CsVFrHh25Q
	V3ll0aBLI56gyv5Rst/nzR4ztw+/XoF3Ke7noBDkDC49qSC2Ff82J7ekmvoPBc3Md5aXVzHj1BK
	ppRpF1oaE6DUDoBxXj58I+etDRCSNJ0JuJ84yDJWzo8gnBjIyeUKNPzJJJjWKQEW1ODuMsNNi/D
	5Ozpx0=
X-Google-Smtp-Source: AGHT+IF59zH2WgDB6HBgQikxu9GD5try7UuoPGvAebnaHS8rgS5yy68P60dU4XI8CDcYUG0rfwwma1dQ2XO7O3vFKzQ=
X-Received: by 2002:a05:6300:8002:b0:243:f86b:3868 with SMTP id
 adf61e73a8af0-243f87ac2cfmr16515853637.48.1756982758482; Thu, 04 Sep 2025
 03:45:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902200957.126211-2-slava@dubeyko.com>
In-Reply-To: <20250902200957.126211-2-slava@dubeyko.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Thu, 4 Sep 2025 12:45:46 +0200
X-Gm-Features: Ac12FXz0QF7y-TvbkxXiUkz2-PTO1-BpZKSlHWRWC5zYF7UDv-zJABChXGAPvcg
Message-ID: <CAOi1vP8Og5phUw3LO3Fv3yfnSSx3FhuSmj7j4pHrF00t-MGS9w@mail.gmail.com>
Subject: Re: [PATCH] ceph: add in MAINTAINERS bug tracking system info
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	pdonnell@redhat.com, amarkuze@redhat.com, Slava.Dubeyko@ibm.com, 
	vdubeyko@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 10:10=E2=80=AFPM Viacheslav Dubeyko <slava@dubeyko.c=
om> wrote:
>
> From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
>
> CephFS kernel client depends on declaractions in
> include/linux/ceph/. So, this folder with Ceph
> declarations should be mentioned for CephFS kernel
> client. Also, this patch adds information about

Hi Slava,

This argument can be extended to everything that falls under CEPH
COMMON CODE (LIBCEPH) entry and then be applied to RBD as well.
Instead of duplicating include/linux/ceph/ path, I'd suggest replacing
Xiubo with yourself and/or Alex under LIBCEPH and CEPH entries so that
you get CCed on all patches.  That would appropriately reflect the
status quo IMO.

> Ceph bug tracking system.
>
> Signed-off-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
> cc: Alex Markuze <amarkuze@redhat.com>
> cc: Ilya Dryomov <idryomov@gmail.com>
> cc: Ceph Development <ceph-devel@vger.kernel.org>
> ---
>  MAINTAINERS | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6dcfbd11efef..70fc6435f784 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5625,6 +5625,7 @@ M:        Xiubo Li <xiubli@redhat.com>
>  L:     ceph-devel@vger.kernel.org
>  S:     Supported
>  W:     http://ceph.com/
> +B:     https://tracker.ceph.com/

Let's add this for RADOS BLOCK DEVICE (RBD) entry too.

Thanks,

                Ilya

