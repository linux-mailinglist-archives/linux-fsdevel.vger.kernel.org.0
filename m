Return-Path: <linux-fsdevel+bounces-65373-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B2BC02C51
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 19:42:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9EB81892C5B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 17:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B96E34A777;
	Thu, 23 Oct 2025 17:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SORH4oPG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54423347BD7
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Oct 2025 17:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761241333; cv=none; b=PdyThh6yK+sLBoghksC1sjW5eCtzGNYEmEQEqoKxOSjuHHyN9LIqnJ8d5I5cWnm0CfPatMFWKKXuwEaDyLxtkC/xYJd2nlFOG57PTQOaF1P9t243uMh4+q098s2AN/boylB6by/1rbIP7CGpJ+go7E98Ev06+uGkxnikH+VozKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761241333; c=relaxed/simple;
	bh=PYcQKEYaNNgr4v4S9nNndeYvxlEoxFnd8ONcOz503ao=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vg50O02W8T3H9QBE0G7AEzvitqAc4KdVeZP4tXlrOV21VmPiaKqCOT7d7Oxi+BESo0kiSO02YQy6vZLVvr7nCs1elq8mhq6OafMPtq/dpazslZ00vRxsK8GcUPQPL02a7ls4s3eSfOl+U98oxGyZ70yTJ5Z5IiAesNv6zZBe8mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SORH4oPG; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4e88ed3a132so14729671cf.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Oct 2025 10:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761241331; x=1761846131; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4seA+HI4M9DYT+ZaTto7qe0lK31pOsptA4eC1KcJc3Y=;
        b=SORH4oPG22ZoX4HVwYEyktVOGheKE4NrJhxlPbk+7nyN98RRt0uVUgKa0bNvs395PG
         1bGoVg8On5FZYbrjrmdnbGa/1mt7y+aiFWmpaY+qUiAQND+Z9EVS0oQqfNIPW05F2miX
         4q9SDMtbrGNtx+gVGjyyZzuzg0V2jU4OZbF2J941i0jfabSR5WP6BGL27Xl1kuXo9k85
         F7erBR4TZOTjcQk0KqkscebdOWqEcpyNWlZ+jdY0HDDE2xR9y+h6bEdcDHARR/VFO7+n
         jcIPTr3d2+xZUMwheY8/zZ4xNNDmcfUt1X1r9MAHrsbRx14jydM9jkWENBYXReVz+1AJ
         2Jhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761241331; x=1761846131;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4seA+HI4M9DYT+ZaTto7qe0lK31pOsptA4eC1KcJc3Y=;
        b=StABYkr+u+ZGDZjeahfF9qxm8kk3cJclPMELydvu2bM5DtQ+ihPM3zSksdLzhqLK/P
         i4fB5VYdnY2VthSQd1Uqymunh4JGyuFsxyvIKpGBrCyWd6rPhDtV37BwGtE0fKLCRztN
         CnrSumY4IfSmaSCwNRFvVPckil9270LGfyqxr8N3iXnWOvhvsLBtlwxvdPA0H6JhtiZ+
         D56oCuFwnOu9pRuBY3HVbsxfZCcVYe5HNIm3VEFAJYxYSUtE+ireHuPXF76OMSHTr0OL
         gFqLDUIm81YKqhN3toXxTaSICaQJ+Hrw0j6ydU6+Bqxt64bPTnLb2kZmyxFGc0L1YrTa
         eVqg==
X-Forwarded-Encrypted: i=1; AJvYcCUty6ShlcCu3toltzftU32arv6OAru5O8JbiAfjiQt1RnlPxE81CickMzOwqqjtPsTJ2kNu3ugf4uPthdYX@vger.kernel.org
X-Gm-Message-State: AOJu0YzuBUPL7vmu3IP2Mcno3bV+HGZwXwyQuUVxSGFumNqZuCngl3OS
	xaX+tKuLMGuKb4SX6v4DatS5CqRHDOVEdELEgN/NlE7lxM0NVva89S4chavqMhGwKeNPnXLBReg
	ykfMmOSX3fI6bZL4i4ZX83CHb52ghmEc=
X-Gm-Gg: ASbGnctXoB0s152ni5Eoe5VmY0R7/fk+q1iFEXpq7txwWlCjWY4JA9NZodkHaqBSdy0
	+WOw5kPAt6Gviodt465O1loCTI/sgeM/eJIO+rxOXDYOkfg60EqQjPqdzRmTTjFWGX9oOBMiBmd
	dw1NtWVOEIQRXBd+DaHYOd8IkLF7YQjUtLVt9mtGJos7Kmp2CTuMWvvMuKJGyLf02A2mL2LfZWD
	eMPNUm5RekiuoX4/B5I/cz4mVG36bQCgXWqoG+GwsnAxG9tlpyCM4CF6TdWH1gJNgjnk9Db5ae7
	7+NLvswoqcLp314=
X-Google-Smtp-Source: AGHT+IGYUuso1wFbBlLzlxrBDhKNZB5fvUBjAyfkvZne5zRw/oAvLVqArsWiIODnGqRp88IRvA204zsjZ+T3SghE1I4=
X-Received: by 2002:a05:622a:1392:b0:4d6:c73f:de88 with SMTP id
 d75a77b69052e-4eb732d317emr110436861cf.3.1761241331136; Thu, 23 Oct 2025
 10:42:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022202021.3649586-3-joannelkoong@gmail.com> <202510232038.LOpSOOQa-lkp@intel.com>
In-Reply-To: <202510232038.LOpSOOQa-lkp@intel.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 23 Oct 2025 10:42:00 -0700
X-Gm-Features: AS18NWA9peuK7QugY6JLjKXBNkxaqO8WfrQsHaG3gveX1ZXIjyuXAfTMF8nltv0
Message-ID: <CAJnrk1Z-FzeXhse762dV7NpSexCcP-xcUSQ+2uviG81HWFdjZQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] fuse: support io-uring registered buffers
To: kernel test robot <lkp@intel.com>
Cc: miklos@szeredi.hu, axboe@kernel.dk, llvm@lists.linux.dev, 
	oe-kbuild-all@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	bschubert@ddn.com, asml.silence@gmail.com, io-uring@vger.kernel.org, 
	xiaobing.li@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 6:23=E2=80=AFAM kernel test robot <lkp@intel.com> w=
rote:
>
> Hi Joanne,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on mszeredi-fuse/for-next]
> [also build test ERROR on linus/master v6.18-rc2 next-20251023]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Joanne-Koong/io-ur=
ing-add-io_uring_cmd_get_buffer_info/20251023-042601
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git=
 for-next
> patch link:    https://lore.kernel.org/r/20251022202021.3649586-3-joannel=
koong%40gmail.com
> patch subject: [PATCH v1 2/2] fuse: support io-uring registered buffers
> config: i386-buildonly-randconfig-002-20251023 (https://download.01.org/0=
day-ci/archive/20251023/202510232038.LOpSOOQa-lkp@intel.com/config)
> compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0=
227cb60147a26a1eeb4fb06e3b505e9c7261)
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20251023/202510232038.LOpSOOQa-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202510232038.LOpSOOQa-lkp=
@intel.com/
>
> All errors (new ones prefixed by >>):
>
>    In file included from fs/fuse/dev.c:9:
> >> fs/fuse/dev_uring_i.h:51:20: error: field has incomplete type 'struct =
iov_iter'
>       51 |                         struct iov_iter payload_iter;
>          |                                         ^
>    include/linux/fs.h:74:8: note: forward declaration of 'struct iov_iter=
'
>       74 | struct iov_iter;
>          |        ^
>    In file included from fs/fuse/dev.c:9:
>    fs/fuse/dev_uring_i.h:52:20: error: field has incomplete type 'struct =
iov_iter'
>       52 |                         struct iov_iter headers_iter;

Ahh okay, I tried building with the linked config
(i386-buildonly-randconfig-002-20251023) and it indeed fails :(

It needs a "#include <linux/uio.h>" added to the dev_uring_i.h file.
I'll add that in for v2.

Thanks,
Joanne

