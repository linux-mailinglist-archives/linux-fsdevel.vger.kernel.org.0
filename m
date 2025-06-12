Return-Path: <linux-fsdevel+bounces-51526-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF13CAD7DF1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 23:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98E471888E48
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 21:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 325A32D8765;
	Thu, 12 Jun 2025 21:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DMxmVs58"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E439155322
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Jun 2025 21:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749765430; cv=none; b=gbZVcKoKvHTHKudg69vFXHJ5EemzQvCm3iVIH6/ZpfdYSBCNjz0omantgQxnQVftkXY0A6uBqktWUvYzIGKjdASrCVJfYILDzDCwv739h4vdU6J9lZdep4CUjFmQY5G/5HGe9GdqgQM04kHsoz1BvKEPvd2JmkPYxihuGsmBPd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749765430; c=relaxed/simple;
	bh=7ZiFHh1zORdyWhtXg9K57RBxliX/vykJMImzo7uKrqU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=osHLYQhe1wLywS2McYwQ2LvInxIcK/YyicZn0DEirOukYLF+mDbBx23EzkHYSWaYa8B5IRdCSio7T4zQUfXhWkBO6x0ETFuERxfBHRfaBXkvUZd0nGX83/9ztN0BWxSkeCfU/VmBoVDRNNLy0r5/tJTv9FcmqpWUcmwW8FFNe6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DMxmVs58; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4a43d2d5569so19642461cf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Jun 2025 14:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749765428; x=1750370228; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nLLRuN2XUZfkS430wOEKJfr2x9vVX7rXO1EJCW2clF8=;
        b=DMxmVs58Q2k3GkaA358PwdvK917dho/eW6AVA62Py+BB8JOccDi0dQrw2D7RYNAQnw
         IvunavWXLaU7OLCtEVwJupXTVSJRXrrG9kU3h2e1f3xIJgtev0a6QGoByjmYu1h8Buvy
         TPo/i7/HWq+RwPQpMxsJmOtVDWdIeiRxSNRNNsfbPm7hoPK5qTrSfpLvWbaTKI2Udfc4
         Dnd2Adz+E/ziwewHvOOdWdUuk23eTOgw5BKOY7rReEEv4mi0qBO0YnbSt1u9TDt8AC2d
         qDFjL5wKtcaWvBh3s5Y+QSFdOz0R+f9FBk9ktO2PZzlZyXmZKNEj+4KXgBEfh6W9ZmLF
         uM5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749765428; x=1750370228;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nLLRuN2XUZfkS430wOEKJfr2x9vVX7rXO1EJCW2clF8=;
        b=ofvT9zThT3Al0y+FqYeOZVwMHEDd+8K/i1evmXO8sSGPHnwLd6mPfW1Z5YEZgDyRrn
         CCTVxSOdfcU67kNuoVy7SGS41MyvdxlPq089+XZkslXYK+Fl5NpQCSiEyvzlO7xH9g9J
         4JTVjZpEk1Q/ekTz15/iunFt/rp9D1CDIj8c5JBSm5EztiRTg3ysHzz5ycDvFN/V/oQn
         oRoGS0Yopr0m1Nbt+OBXV38nmCXwhny1oCW/lCNqAiVNXTqQohHuSO+2nBDN+xNbQ2Zy
         4sIbM/B6WJNRaCBvTRgvVC1PnYt/QKi93DxOsOqeI6WsE6rY7McxOeW8nFCn3QPO/7vo
         3f8Q==
X-Gm-Message-State: AOJu0Yx68/EhnLw5uWhfToNQwlSuT03xpIdjvdT+O7GFTuO+1X1zFYH6
	4l+/fcV2qDa6ngrip0mcQPx8GOFrdPyWQC1HxG2BVQhAMF3Mdh3Fk4ByHdcJRe91R07F+GhhS1P
	nOCw34YIxMKPNUWAIqSf+iX3GHZblM+SZJv6T75o=
X-Gm-Gg: ASbGnctxyK6g7Rt3R/dayMyLM/imwVHUWgX/lXzxx4w+RvX0hCP8zgt7lWg01E3z/9s
	N9WN9dXwhgnc8ur8+/M9LH0sxkzK0UIOWyVlGgETmvc2LCotBdy+XS5KKLeclwPI0Ixv1FT9cLF
	ght0RYc2xFXrwIcO5/IutFvJS3yS58fw1sSdJzqXpp2jilqieEzr34SNExHn0=
X-Google-Smtp-Source: AGHT+IGsWl6P3br6CdlCW2z8L28PBg899kREZHzKrhK0Ds+bWEqd9MWslbraMJBFPlFj9t+u7rig0HnAgdBfjkQ1BeU=
X-Received: by 2002:a05:622a:4d96:b0:4a4:3b2f:cc30 with SMTP id
 d75a77b69052e-4a72fe80f67mr16741411cf.11.1749765427706; Thu, 12 Jun 2025
 14:57:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aEq4haEQScwHIWK6@bfoster>
In-Reply-To: <aEq4haEQScwHIWK6@bfoster>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 12 Jun 2025 14:56:56 -0700
X-Gm-Features: AX0GCFt5aQQSzfSS_Jik3io4W3tN37u4-TWFd5V7W8MVybBlWzRmKBM1jJdnG-8
Message-ID: <CAJnrk1aD_N6zX_htAgto_Bzo+1S-dmvgGRHaT_icbnwpVoDGsg@mail.gmail.com>
Subject: Re: [BUG] fuse/virtiofs: kernel module build fail
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <mszeredi@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2025 at 4:19=E2=80=AFAM Brian Foster <bfoster@redhat.com> w=
rote:
>
> Hi folks,
>
> I run kernel compiles quite a bit over virtiofs in some of my local test
> setups and recently ran into an issue building xfs.ko once I had a
> v6.16-rc kernel installed in my guest. The test case is a simple:
>
>   make -j N M=3Dfs/xfs clean; make -j N M=3Dfs/xfs

Hi Brian,

If I'm understanding your setup correctly, basically you have the
v6.16-rc kernel running on a VM, on that VM you mounted a virtiofs
directory that references a linux repo that's on your host OS, and
then from your VM you are compiling the fs/xfs module in that shared
linux repo?

I tried this on my local setup but I'm seeing some other issues:

make[1]: Entering directory '/home/vmuser/linux/linux/fs/xfs'
  LD [M]  xfs.o
xfs.o: warning: objtool: __traceiter_xfs_attr_list_sf+0x23:
unannotated intra-function call
make[3]: *** [/home/vmuser/linux/linux/scripts/Makefile.build:501:
xfs.o] Error 255
make[3]: *** Deleting file 'xfs.o'
make[2]: *** [/home/vmuser/linux/linux/Makefile:2006: .] Error 2
make[1]: *** [/home/vmuser/linux/linux/Makefile:248: __sub-make] Error 2
make[1]: Leaving directory '/home/vmuser/linux/linux/fs/xfs'
make: *** [Makefile:248: __sub-make] Error 2

Did you also run into these issues when you were compiling?

Taking a look at what 63c69ad3d18a ("fuse: refactor
fuse_fill_write_pages()") does, it seems odd to me that the changes in
that commit would lead to the issues you're seeing - that commit
doesn't alter structs or memory layouts in any way. I'll keep trying
to repro the issue you're seeing.

>
> ... and ends up spitting out link time errors like this as of commit
> 63c69ad3d18a ("fuse: refactor fuse_fill_write_pages()"):
>
> ...
>   CC [M]  xfs.mod.o
>   CC [M]  .module-common.o
>   LD [M]  xfs.ko
>   BTF [M] xfs.ko
> die__process: DW_TAG_compile_unit, DW_TAG_type_unit, DW_TAG_partial_unit =
or DW_TAG_skeleton_unit expected got subprogram (0x2e) @ ed957!
> error decoding cu i_mmap_rwsem
> error decoding cu
> ...
> error decoding cu
> pahole: xfs.ko: Invalid argument
> make[3]: *** [/root/repos/linux/scripts/Makefile.modfinal:57: xfs.ko] Err=
or 1
> make[3]: *** Deleting file 'xfs.ko'
> make[2]: *** [/root/repos/linux/Makefile:1937: modules] Error 2
> make[1]: *** [/root/repos/linux/Makefile:248: __sub-make] Error 2
> make[1]: Leaving directory '/root/repos/linux/fs/xfs'
> make: *** [Makefile:248: __sub-make] Error 2
>
> ... or this on latest master:
>
> ...
>   LD [M]  fs/xfs/xfs.o
> fs/xfs/xfs.o: error: objtool: can't find reloc entry symbol 2145964924 fo=
r .rela.text
> make[4]: *** [scripts/Makefile.build:501: fs/xfs/xfs.o] Error 1
> make[4]: *** Deleting file 'fs/xfs/xfs.o'
> make[3]: *** [scripts/Makefile.build:554: fs/xfs] Error 2
> make[2]: *** [scripts/Makefile.build:554: fs] Error 2
> make[1]: *** [/root/repos/linux/Makefile:2006: .] Error 2
> make: *** [Makefile:248: __sub-make] Error 2
>
> The latter failure is what I saw through most of a bisect so I suspect
> one of the related followon commits alters the failure characteristic
> from the former, but I've not confirmed that. Also note out of
> convenience my test was to just recompile xfs.ko out of the same tree I
> was bisecting from because the failures were consistent and seemed to be
> a runtime kernel issue and not a source tree issue.
>
> I haven't had a chance to dig any further than this (and JFYI I'm
> probably not going to be responsive through the rest of today). I just
> completed the bisect and wanted to get it on list sooner rather than
> later..
>
> Brian
>

