Return-Path: <linux-fsdevel+bounces-52954-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E778AE8AE9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 19:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78ADF16F1C7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 16:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D8C2D877F;
	Wed, 25 Jun 2025 16:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dSEG5L3d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304F428ECE0;
	Wed, 25 Jun 2025 16:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750870109; cv=none; b=BomGuaQPF4LKMz1xN1mKcxG4ILYxo9LUEZWJOl7hCBoXEDqp12uypBSXCOIqZnQwQ4XjzMJsKpn7zPfwNZwHCsB6gkfFS+/VPH31wOA/Bz1Dp4uyl4aUdlE0OndcXwjKAonzdSY+nf0ph3V+ETGxRPNL+Ehg1fRDplP2VF5fULg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750870109; c=relaxed/simple;
	bh=cag+c+glbVM6ZrhblGmUpscg8NGo2h1Nshc6TntvkuA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S2oVeVuQNDlaX0nW+kVJ/OEi8+ipCn5FKajVMU+8wF0JIgXKVcrdvz9zRhAVJcpir/O/ryvIiRVdI5wxkE6GjRcIwPWsx7ge9FEOs3SehYiKGsYfQlQFxy8399JvNdA1MIHA6a3uXejCgkHuQXNcid+DR50NvaxYNOJ69zllFak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dSEG5L3d; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4a58e0b26c4so2164161cf.3;
        Wed, 25 Jun 2025 09:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750870107; x=1751474907; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BfZQtxZ5A/V3eeXnba2r1tOxiy9yY9dau/NzMZf1604=;
        b=dSEG5L3diaToXs047BX4IMUYwNwcfabydR/i6Q3THKhaVd2UV9959TUO/EmVcnlOt9
         xp6U7r9naGPRg7MJ5UCCOI2KDroEYOKgiGtEyLjiWml05Khc4zYBqB2hQVQXN0NgV8QR
         jWzRSMC5qYczEd4oVr8WVUME+Q+xdqGwAHqz0C2j8BM7N6I8zJs6olk3jDZP8RL86b3j
         s46E2rNAMgFzPq940E5igq1k9weGxcnKnNOIHT7I/hxrGR3sT+PjAN1sP1627K+OLRRd
         MOQGGpAJAmzOGicRAc7siXws+PuEl6fdpdBCfsR9emP9ODzgktQu2IxGcp9QyfmN89ih
         4b7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750870107; x=1751474907;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BfZQtxZ5A/V3eeXnba2r1tOxiy9yY9dau/NzMZf1604=;
        b=Bf1AwYmrWhVEsbqvrfz66L8MQU8pS7HYkT3Fj8Una0oi7ICwHVRHB+ZzGuvyg7I/EY
         vsngKzM4N1F3jpr/zvyY72yBdGOc95+xtmIXSAi/0EXT4RkDqZYUDxV/wp6OVpWuA45h
         1/hxZTWtudR7EeYR13WQwNQmDL/bFg1No8qTAE8DGnKtRVBzDhg2ByGmXxybPGWWVI+l
         Sgu+mLNaSTk2Qi2YjACY2pFyk6KOEIirTt2FP+qK2dSagDRujR9MKc4EHYcHbkWXXLkw
         IMhRRdpabFaVlCq4lTsejVKUtAbX+effV8O/PDRfuAij+FGB93wcFsMcIdM10TFOMmly
         fAIg==
X-Forwarded-Encrypted: i=1; AJvYcCU/2Rtd8UEH/EryEU71Hu1Ehwz0k1idaPic/Bw6icwqQ02+sKxr8gSD/DE1q+q5v2V+fIybsA6MaCmi@vger.kernel.org, AJvYcCXGpIvikLUkSPF2BtXaVHXt/rHbejACqYie9I7XTou9uqiKeiZAxSrgIKNRJhFs89CljejSol7znhfr@vger.kernel.org, AJvYcCXOY5coz4mtRgRF9OTMGVyJ535epedFHLXUWCV3RklImrjfUTOlICvbpkGTScXSZ9cAPZg7XWDVulRuXw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd1+zZXW/An7vpTtSo8Mj4sdMO+2iI/axnsYZbs3P5DyDWlVDI
	KBZU1eTGhEZyI+Q67RfcwvbqWkUmC7LjhmS8jViZES3IT9QFwnVkdCHEH0Npgzblt/OLrB94rkm
	1+nV5kRbqXSlnSOhf7pQ3Uf6s1q03zMtccbx1P3A=
X-Gm-Gg: ASbGncvTs4kVEcGhn7S4QPMBQAfmMSx+vFIk8MheNOa5R2Lvd81IGWbTvZhRn0jeNod
	gl3gTms5HsrPX8GHouDzbbimZM09+5z5jnq4gCiiolv3Ud5C/IeVNhQ7cFPHEZoBnb3Sd9VFoFu
	tagwShbE1lmqZagJr/TMZMmVF7ZEENbpHH3sqglvkq7H0QQSs8Hk2NvDAQNMs=
X-Google-Smtp-Source: AGHT+IHnGZf+fu9SeiyuF9kQmAOEZke0m2LllwCuXdhfFxesY+uAABRJJM6WKD41IneEOxIBlU5CuC7+Lj6KgvDsH4g=
X-Received: by 2002:ac8:5fce:0:b0:476:74de:81e2 with SMTP id
 d75a77b69052e-4a7c08b05f0mr65981621cf.43.1750870106629; Wed, 25 Jun 2025
 09:48:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624022135.832899-14-joannelkoong@gmail.com> <202506252117.9V3HTO0i-lkp@intel.com>
In-Reply-To: <202506252117.9V3HTO0i-lkp@intel.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 25 Jun 2025 09:48:15 -0700
X-Gm-Features: AX0GCFu4lcNCxXc2Rv_TbdgF3DX477vRtHysoV5-7omwd5WacfSbp3GjvkDuyaU
Message-ID: <CAJnrk1Z5NZ0_f=OMMam9hf0xJwM=SsmgFpyfbnKE7MT_i_kZMQ@mail.gmail.com>
Subject: Re: [PATCH v3 13/16] fuse: use iomap for writeback
To: kernel test robot <lkp@intel.com>
Cc: linux-fsdevel@vger.kernel.org, oe-kbuild-all@lists.linux.dev, hch@lst.de, 
	miklos@szeredi.hu, brauner@kernel.org, djwong@kernel.org, 
	anuj20.g@samsung.com, linux-xfs@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-block@vger.kernel.org, gfs2@lists.linux.dev, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 25, 2025 at 7:18=E2=80=AFAM kernel test robot <lkp@intel.com> w=
rote:
>
> Hi Joanne,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on brauner-vfs/vfs.all]
> [also build test ERROR on xfs-linux/for-next linus/master v6.16-rc3 next-=
20250625]
> [cannot apply to gfs2/for-next mszeredi-fuse/for-next]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Joanne-Koong/iomap=
-pass-more-arguments-using-struct-iomap_writepage_ctx/20250624-102709
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.a=
ll
> patch link:    https://lore.kernel.org/r/20250624022135.832899-14-joannel=
koong%40gmail.com
> patch subject: [PATCH v3 13/16] fuse: use iomap for writeback
> config: arm64-randconfig-003-20250625 (https://download.01.org/0day-ci/ar=
chive/20250625/202506252117.9V3HTO0i-lkp@intel.com/config)
> compiler: aarch64-linux-gcc (GCC) 12.3.0
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20250625/202506252117.9V3HTO0i-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202506252117.9V3HTO0i-lkp=
@intel.com/
>
> All errors (new ones prefixed by >>):
>
>    aarch64-linux-ld: fs/fuse/file.o: in function `fuse_writepages':
> >> file.c:(.text+0xa30): undefined reference to `iomap_writepages'
> >> file.c:(.text+0xa30): relocation truncated to fit: R_AARCH64_CALL26 ag=
ainst undefined symbol `iomap_writepages'
>    aarch64-linux-ld: fs/fuse/file.o: in function `fuse_writepage_finish':
> >> file.c:(.text+0x1fd8): undefined reference to `iomap_finish_folio_writ=
e'
> >> file.c:(.text+0x1fd8): relocation truncated to fit: R_AARCH64_CALL26 a=
gainst undefined symbol `iomap_finish_folio_write'
>    aarch64-linux-ld: fs/fuse/file.o: in function `fuse_cache_write_iter':
>    file.c:(.text+0x888c): undefined reference to `iomap_file_buffered_wri=
te'
>    file.c:(.text+0x888c): relocation truncated to fit: R_AARCH64_CALL26 a=
gainst undefined symbol `iomap_file_buffered_write'
>    aarch64-linux-ld: fs/fuse/file.o: in function `fuse_iomap_writeback_ra=
nge':
> >> file.c:(.text+0x9258): undefined reference to `iomap_start_folio_write=
'
> >> file.c:(.text+0x9258): relocation truncated to fit: R_AARCH64_CALL26 a=
gainst undefined symbol `iomap_start_folio_write'
> >> aarch64-linux-ld: fs/fuse/file.o:(.rodata+0x370): undefined reference =
to `iomap_dirty_folio'
>    aarch64-linux-ld: fs/fuse/file.o:(.rodata+0x3a0): undefined reference =
to `iomap_release_folio'
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

As noted in the cover letter [1]

   Please note the following:
   * this patchset version temporarily drops the CONFIG_BLOCK iomap refacto=
ring
     patches that will be needed to merge in the series. As of now, this br=
eaks
     compilation for environments where CONFIG_BLOCK is not set, but the
     CONFIG_BLOCK iomap changes will be re-added back in once the core chan=
ges
     in this patchset are ready to go.


These errors will be fixed in later versions when the CONFIG_BLOCK
patches get added in.


Thanks,
Joanne

[1] https://lore.kernel.org/linux-fsdevel/20250624022135.832899-1-joannelko=
ong@gmail.com/

