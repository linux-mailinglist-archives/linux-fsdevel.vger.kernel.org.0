Return-Path: <linux-fsdevel+bounces-69759-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 083A8C8465C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 11:14:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACAA43AB866
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Nov 2025 10:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72DD2CA4E;
	Tue, 25 Nov 2025 10:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RKDGPsYn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBDA2EC54A
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Nov 2025 10:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764065637; cv=none; b=XW71GRwkZSq0muuKD8s0xxeQj64qoRn5op88db9+iohvbzLxc2ZCtL6yaTnY3xNM+Rrd4RPBcbiFsQCWFVbX+W01iMeu6iG/2XGO+MOxNy7RyzxqoIiVMv9pk1KFErUv8O1qToYiWEUhnmCBz8cPNBiBPibyD/V3AkEov81pJPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764065637; c=relaxed/simple;
	bh=FYWIni38RTzd1CvEvbvTzALDqCohw7fzt/zsirLe/pA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lOJ9g+SkiWfA0ZshHVXhFzuuQG82v18sibIhqrBGwX/ZPElL3CFyc0mJVAlQefw4zVaQ+prD3dByUqTs5v0/SSvDct8/oBn+jeKQ8FiifunDE1xXxveZFkjXBYuwwa/GmjAa6owqEgP+sVvqezU/aso7jQwBcXTb2cwgQEyoRu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RKDGPsYn; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47798ded6fcso32138285e9.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Nov 2025 02:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1764065634; x=1764670434; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=akkccM3IvNNQmmkmFRy2a+JX92ormoEOBN5rH1qdfnI=;
        b=RKDGPsYnUV2HWANrD3ovjKxAm31exrPuNP8AodnYQcyHx9CMwIGD9s/5gtzaH4rZiH
         6sfH6ahy5Jn8mbeg49xiTgzld7gBrvw7ukmrAAuo+/bPY7va7o81EHRprrUknucRZMLd
         wWxOpdtOIuNwBB3dmvtz3ziCSZCakN/Gl4ccMb7XhUl7ti5Gjskk+psVSrLZKIYiQuaN
         lEbSrk9frgl/EX49haUN+CJWDs2JqD/Uq1SflXtVh/L3VC+8TUD4QysEZue9FREtOfxo
         QkZe9CWc8VTrzUItjeVLlitNv7AANr/oVjtS7Lze2N9kG/Y84eMqOmNpwiT7wBcoPE4I
         tZbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764065634; x=1764670434;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=akkccM3IvNNQmmkmFRy2a+JX92ormoEOBN5rH1qdfnI=;
        b=kMPNbOVJAEGQkuc4urqKxqqvwwARSEo9IihwmnVvZ9+35ucPI3peCP2IIda2URvM+2
         ghSOiW2/hLB4vgOzfDzhRMycrMMLA9VV8C0IxVK9Tc3RUoqmXzBBsRr8NkyWea/Q3nTk
         OP5m+56/sjWAQy+LenFTpQgsRRLKI4m3jEtH6cvtTc+yZX5phLhNs0Gnx6UBfZkihztN
         3tioyrHhnLDfFVH5Bqa9PYRo/FDcHyFtZY0Ca4DAVbz50WYIX+iFD5uwC8sJR4gaouWL
         9WV1r8CJq86CEfjtM9Y2t2Tq3FFXSRdxJtKCvAjf/+b1guQ1GNTZBBrxdLWIXxHmWJsp
         f1eA==
X-Forwarded-Encrypted: i=1; AJvYcCXjJxzY7rBStjfMV27bVk1tA6XEIWdGfICxciXia7D8//szLJwLlHrl3h+Gq6+M0z8/joS1albfpLDq80k2@vger.kernel.org
X-Gm-Message-State: AOJu0YzzaMjl7KFTdQeNHvWW7V8uKzkISQNivAH9p9KURe+xRB3BHzmK
	9naFB/0b7OBz/eUQXtvj8o6iFLFtB/neaNniQV5DMMud7pbKl1mfd5HMu2ZrY8xP1A==
X-Gm-Gg: ASbGncspAlyRWVlTN0rj+Hr1T2HMhcdbE/4Fsp5b/P66oePnooj4JKqxnSyhpkyKHdX
	UcgGss7cDb7+QWAIA21cXfCXpp9Z7z4NINIIS56Fy3ZEsvE/LOcrOmLqq+R98YFCj8qTtbG8+N7
	ITIoFpbuN+v3WVizJvtuXFB+btcaocn7I4YTxsUOMYo4Wb83ugUTdo8sKEVEZJ8+Kc0vq7NQcxj
	VgMyHsNyLXCJ2L30yTmX2x1FINv4tdb8co1BJQ64bFAJsbiWZdDK1/+fmreYfiJdoND8SG/rMaP
	s690/jlXbP31jwy65wUtsWX45FOHZcpQTuCi17DFO+cBFtjERNRDv0N8LKqUGZ5yTBoiZLKG3AK
	Eyy8CcQMrbAY51Q/dRoiEO0pEFM7fsXt+gq464VMbx4IyFRvvgsLTvFVHgHc49pxJrmqJSYzb2/
	9oTJet86pGfJhrxjaoXYNF8AKg7+Uc
X-Google-Smtp-Source: AGHT+IEghEzgUX7Y0DHR7Corjv/jFDgAqklVg667PjjHhJI7QMm8NG+RfxT3xnDSPr2BmlCO19kDgg==
X-Received: by 2002:a05:600c:a08:b0:477:aed0:f401 with SMTP id 5b1f17b1804b1-477c11254damr147976645e9.23.1764065633880;
        Tue, 25 Nov 2025 02:13:53 -0800 (PST)
Received: from autotest-wegao.qe.prg2.suse.org ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fb8ff3sm35140056f8f.29.2025.11.25.02.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 02:13:53 -0800 (PST)
Date: Tue, 25 Nov 2025 10:13:51 +0000
From: Wei Gao <wegao@suse.com>
To: kernel test robot <oliver.sang@intel.com>
Cc: Andrei Vagin <avagin@google.com>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	lkp@intel.com, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, oe-lkp@lists.linux.dev,
	ltp@lists.linux.it
Subject: Re: [LTP] [linus:master] [fs/namespace] 78f0e33cd6:
 ltp.listmount04.fail
Message-ID: <aSWBX1urcixS1Fl8@autotest-wegao.qe.prg2.suse.org>
References: <202511251629.ccc5680d-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <202511251629.ccc5680d-lkp@intel.com>

On Tue, Nov 25, 2025 at 04:33:35PM +0800, kernel test robot wrote:
>=20
>=20
> Hello,
>=20
> kernel test robot noticed "ltp.listmount04.fail" on:
>=20
> commit: 78f0e33cd6c939a555aa80dbed2fec6b333a7660 ("fs/namespace: correctl=
y handle errors returned by grab_requested_mnt_ns")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>=20
> [test failed on      linus/master fd95357fd8c6778ac7dea6c57a19b8b182b6e91=
f]
> [test failed on linux-next/master d724c6f85e80a23ed46b7ebc6e38b527c09d64f=
5]
>=20
> in testcase: ltp
> version:=20
> with following parameters:
>=20
> 	disk: 1SSD
> 	fs: btrfs
> 	test: syscalls-06/listmount04
>=20
>=20
>=20
> config: x86_64-rhel-9.4-ltp
> compiler: gcc-14
> test machine: 4 threads 1 sockets Intel(R) Core(TM) i3-3220 CPU @ 3.30GHz=
 (Ivy Bridge) with 8G memory
>=20
> (please refer to attached dmesg/kmsg for entire log/backtrace)
>=20
>=20
>=20
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202511251629.ccc5680d-lkp@intel.=
com
>=20
> 2025-11-20 21:35:09 export LTP_RUNTIME_MUL=3D2
> 2025-11-20 21:35:09 export LTPROOT=3D/lkp/benchmarks/ltp
> 2025-11-20 21:35:09 kirk -U ltp -f temp_single_test -d /fs/sdb1/tmpdir
> Host information
>=20
> 	Hostname:   lkp-ivb-d04
> 	Python:     3.13.5 (main, Jun 25 2025, 18:55:22) [GCC 14.2.0]
> 	Directory:  /fs/sdb1/tmpdir/kirk.root/tmp9k8rfwr2
>=20
> Connecting to SUT: default
>=20
> Starting suite: temp_single_test
> ---------------------------------
> =1B[1;37mlistmount04: =1B[0m=1B[1;31mfail=1B[0m  (0.016s)
>                                                                          =
                                                      =20
> Execution time: 0.085s
>=20
> 	Suite:       temp_single_test
> 	Total runs:  1
> 	Runtime:     0.016s
> 	Passed:      7
> 	Failed:      1
> 	Skipped:     0
> 	Broken:      0
> 	Warnings:    0
> 	Kernel:      Linux 6.18.0-rc1-00119-g78f0e33cd6c9 #1 SMP PREEMPT_DYNAMIC=
 Fri Nov 21 04:59:36 CST 2025
> 	Machine:     unknown
> 	Arch:        x86_64
> 	RAM:         6900660 kB
> 	Swap:        0 kB
> 	Distro:      debian 13
>=20
> Disconnecting from SUT: default
> Session stopped
>=20
>=20
>=20
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20251125/202511251629.ccc5680d-lk=
p@intel.com
>=20
>=20
>=20
> --=20
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
>=20
>=20
> --=20
> Mailing list info: https://lists.linux.it/listinfo/ltp

I guess LTP failed message is "listmount04.c:128: TFAIL: invalid mnt_id_req=
=2Espare expected EINVAL: EBADF (9) " ?  Since i have not find LTP failure =
log in this email thread.

Base on kernel change remove spare and add new mnt_ns_fd but LTP listmount0=
4 still set spare.
I suppose LTP case need update base latest change of kernel?

Kernel:
  */
 struct mnt_id_req {
  __u32 size;
- __u32 spare;                                   <<<<<<<<
+ __u32 mnt_ns_fd;                          <<<<<<<<
  __u64 mnt_id;
  __u64 param;
  __u64 mnt_ns_id;

LTP case:
 {
=2Ereq_usage =3D 1,
=2Esize =3D MNT_ID_REQ_SIZE_VER0,
=2Espare =3D -1,                                              <<<<<<<
=2Emnt_id =3D LSMT_ROOT,
=2Emnt_ids =3D mnt_ids,
=2Enr_mnt_ids =3D MNT_SIZE,
=2Eexp_errno =3D EINVAL,
=2Emsg =3D "invalid mnt_id_req.spare",
},


