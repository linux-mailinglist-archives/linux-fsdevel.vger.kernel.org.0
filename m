Return-Path: <linux-fsdevel+bounces-19457-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1B28C5926
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 17:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBA351F22238
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 May 2024 15:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD90317F37E;
	Tue, 14 May 2024 15:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="BEZfi27Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DE717EB87
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 May 2024 15:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715702220; cv=none; b=HBeZ6ngGudYg6jrXVvdX/qz/REPd24WhZ62ndhlMOt4qObKzFTTaB6GhxPDSUFuct34QU9F9hoKUP1IDAd83AcHrnR+McJuknLnAqKEgw0653zH++SwpB93Y/RqsMrF3lqnIk+W37lPHL/GAbiKpgXw8E4TegGyAfHUsmFITZzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715702220; c=relaxed/simple;
	bh=YA6pyQiLLslarUnTKZZJMUBTQqHbLA/4c4NUOUNEKQE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G3MdD6AIji2urKyz++uqhaRc/48Y49wZ/1gFZe1fir5f++sTHhCWc9vklKagpKDNAH0z6X50KWKsIhah/oOVoBOtYWQg5C9FNdbVarbB3pRgpXrdO+JeGmcGFPBGopvTzqpvuFOfZtOZCRdXAsHlzdIMEicUjzswK8vT3/0D7Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=BEZfi27Z; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-23f0d54c5ffso3726585fac.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 May 2024 08:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1715702218; x=1716307018; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e6MGF0tcuYUW8jKv8L9+C0X+Q6Jb+20y5kn9DK3CWgc=;
        b=BEZfi27ZDNKXrOlGC6H4b2KBKrmFzURdAkcRuh/XjsLwUc1u/nlgbuHz1XLw2voJs8
         gl1DyRl9q+MqTFU8WdiJwQitgc7JBW7qOdDnrqNK+Y3drR53XdeiODHqylIMO/GizBNx
         6Qjr8mB05vCGnwWxfu6D4tUt/Za8dNP2ahsacSmufIedPFfL18JkC9Ps9DjHuEMgndZc
         DIAbaA+JjLP65q3yxB/JSy/wY1fud3CtylOUudGF0Aw00l5vlsHgxSxMD6bvVi8ANvBS
         Xwh1OMp6EcqBxbK448NnZ/7iHF6dhq1j9+03QmiyK1N9TVfl5ZXRDXgUuk1rDGxm2Thh
         TwSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715702218; x=1716307018;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e6MGF0tcuYUW8jKv8L9+C0X+Q6Jb+20y5kn9DK3CWgc=;
        b=G4OfDz7lI5SGDrGL7jswi8QPPJsyGBJtS22Tq/bdYLXUPYd4k5yoEP+iXYtC3b5Rjc
         tagOQgJzeUc5LGYZwJ/uCZwHR0e3Jwd27oT0BwipDvPgV02RbZjJXpkz1yb4GsS0VWIJ
         +fhFLbmx6z3/X3k2WJ5Jg8tb4LhuTKzuWT+wbvpuu3Vbx09YgPK7tlhld1foaTNYsjLP
         8MbXwlUicIeORsEnk5CwUWyNehWC0fSaK4MH+4hNnNBRtN+afn6daplDeXsoZr+1tvbe
         KElUSAi/hB8KuVhRTrl9tMIJes1JGIH4o2yTmyBXdZ7FHfz6G6XsioSyk5luTPolh3hj
         OLVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZbgvfLwf1DBc/dWqnJtMBq7bbDoNSyebkqKD7IuipFWHkvB7Un8hZjwEGfgA702b1UQiIWDGA16m3azAVSWrWpDxTMrlWbyWnhi/vRw==
X-Gm-Message-State: AOJu0YzTXOo40pOR9D6IDEswM0NFimtryL8v6LsBOTTahRRoqwWyvsys
	ZxrBJ8/qrq936Llgwl6uY9EahcT4IR5bV3qbZjMUs7KXJtReNrLjgHTVTXyIC4nR7Xz5C93PSAx
	2ZzDNqyKGkK39RcBhiPpqaeWuHUiQoKHU6KH9pQ==
X-Google-Smtp-Source: AGHT+IEQ/4e3Xdlw5o+oGBoYc/qjPodJ1x+HDfCTQwbUcL2+yeysXxIOfH8cuC7q3IN5+SY5krebRZTNRqtrnD1+EdY=
X-Received: by 2002:a05:6870:9722:b0:22e:8ca0:36ba with SMTP id
 586e51a60fabf-24172bd7029mr15691437fac.22.1715702217977; Tue, 14 May 2024
 08:56:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240514153532.3622371-1-surenb@google.com>
In-Reply-To: <20240514153532.3622371-1-surenb@google.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 14 May 2024 09:56:20 -0600
Message-ID: <CA+CK2bCmy1PhDgDvEX2Pg=_HvLLD2msJmTV_rgMxifbd-y1wRA@mail.gmail.com>
Subject: Re: [PATCH 1/1] lib: add version into /proc/allocinfo output
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, vbabka@suse.cz, 
	keescook@chromium.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 9:35=E2=80=AFAM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> Add version string at the beginning of /proc/allocinfo to allow later
> format changes. Exampe output:
>
> > head /proc/allocinfo
> allocinfo - version: 1.0
>            0        0 init/main.c:1314 func:do_initcalls
>            0        0 init/do_mounts.c:353 func:mount_nodev_root
>            0        0 init/do_mounts.c:187 func:mount_root_generic
>            0        0 init/do_mounts.c:158 func:do_mount_root
>            0        0 init/initramfs.c:493 func:unpack_to_rootfs
>            0        0 init/initramfs.c:492 func:unpack_to_rootfs
>            0        0 init/initramfs.c:491 func:unpack_to_rootfs
>          512        1 arch/x86/events/rapl.c:681 func:init_rapl_pmus
>          128        1 arch/x86/events/rapl.c:571 func:rapl_cpu_online

It would be also useful to add a header line:

$ head /proc/allocinfo
allocinfo - version: 1.0
# <size> <calls> <tag>
            0        0 init/main.c:1314 func:do_initcalls
            0        0 init/do_mounts.c:353 func:mount_nodev_root
            0        0 init/do_mounts.c:187 func:mount_root_generic
            0        0 init/do_mounts.c:158 func:do_mount_root
...

This would be the same as in /proc/slabinfo:
$ sudo head /proc/slabinfo
slabinfo - version: 2.1
# name            <active_objs> <num_objs> <objsize> <objperslab>
<pagesperslab> : tunables <limit> <batchcount> <sharedfactor> :
slabdata <active_slabs> <num_slabs> <sharedavail>
pid_3               2730   2730    192   42    2 : tunables    0    0
  0 : slabdata     65     65      0
..

Pasha

