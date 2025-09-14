Return-Path: <linux-fsdevel+bounces-61234-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C4CB5660D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Sep 2025 06:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33B2C175BF6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Sep 2025 04:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48FCB2749DA;
	Sun, 14 Sep 2025 04:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k1+rP4AQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE9E1DED64
	for <linux-fsdevel@vger.kernel.org>; Sun, 14 Sep 2025 04:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757822464; cv=none; b=c1bryE4j/8SBu1gnCtGPAAs3comnWN5PHPvr7nPG7FyAeo+bMOkeMCHstgV8NoGYbLyl9N28n3CNhVXIlz5JKjy6DkAlfpQFV5z8pxr+lufLURWYCRNzHa3AOHCxRo/Uc3hfvHnvKWHATxxPAFS3mmYv/3fb/5Xo+FpwiifP+vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757822464; c=relaxed/simple;
	bh=sbk1LO1muOWgN0bQgoTXkgDyU4S2f8FT146cKVOEQKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b42msAGvUjS+a9YGL7MPeervzjUj57g1Wl9eMmD3BEdbgJLTwMmqjeY9A8ZJxPk5flspXAsRDW6UQkeSCleznNeAbK9dDFzIK0c9vjeUtoGzYyAWVHygvSM4r3SdURnk2vaf8S51uujU99M4VpGGICvwvjWN6fdyBVNv6xQ9zR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k1+rP4AQ; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-afcb7ae6ed0so479188266b.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 13 Sep 2025 21:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757822445; x=1758427245; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E6jM9It4O6hvb9NXZp6mmdHXh5HjPMnw7IKUnHmweqA=;
        b=k1+rP4AQuLeYx8mbY0zO5KR0BS5hhG/jFhn3GPFX4qHeyrV/fkpPQH3f8gQiuKcda6
         DObxsWgbY2UDz3VZPzJaA4332yM3GH4Oy4SZa7W1WapHvjGBwola1lGmCfo21NNLfIr9
         9LPEMhS96hUzIR5CbrTQjFCMlrjn4bR+uwKa4sMl/o63QVUccvD6V0qMsGNzOYkN7HoW
         l1xyxT87dJKit0gbbi0w2qojk3svxLTVmVFe9lna+w6WshZGbc3XiAvJRDHJF3j+UZ83
         xlfBbnCX9EJKQaDAmMpbtwpBO2fhqmSdQxoWmkx9yF+uQHVsNmigRcm3mcFZG43E09Qm
         6UCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757822445; x=1758427245;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E6jM9It4O6hvb9NXZp6mmdHXh5HjPMnw7IKUnHmweqA=;
        b=WJr8EtqSPZl6iXSyFdPnpZT63XBVFQedsh1UQIg2zi9TfZbXs4tRXKL+7c5uG+C6aT
         NcNZIrPNXGDBIbr8LRdRQJNuooRe1O9ZZLsaHWI8MXzZfq2LTIYE6L/Ud89lpEzBrYBQ
         UnkSGDOoMwQOyndKmcADejdILH9qYtmlOCSqrHQ8TuOtmjPxSqKlKun5Eydu/1c1rMPF
         WKPSKxppPpwkD+HXZJ4wlLwcScFUSpgjQN8McTRbOr2Ex+pz9XMNRYWm/YoHPNgQ4OhU
         lepgZlrA8zfdWdxj6OMkAxabgR/R6D35tI7MeCc8Jyb6QkuudhRI4cO1BiTccdIVbW3W
         xomw==
X-Gm-Message-State: AOJu0Yw5Ew9FT7nQ9gByOc4KrrnUS833wQmNOX7b6xJ7IKESP00lsmww
	UdhWGAZxKUGeK0Qn9Qo26auBOO9a88TzJGTRTENAYrKvARGMnvvJApETufh3qGvU
X-Gm-Gg: ASbGncu5efOT4GrosSFQeL3b5CSTu2EmPY3enSC3cyMwHSDtNJci+Rl4TbLN/zV0dso
	/5z9t3NIG/kecok6TPzRkX46ZcrgEJV8A0RS84dMyKRrtuDZFLN0+8LiD2cvATzr4EEE4RwAI0F
	aS2SKc7jiJtX3st67laUb5awhA1SxmVBeVw49yz4K1b4yfPIB2lfYmssnWgwTCcZ5cnWpA3dFTh
	7AFMvxniRB9LIKKyqBRGBZ2J9okrwYAsRZuFYvXbOezdr8v0/Zj5f/ZA8eqZez6+4l+clcVVgKa
	AP1diXk6qXUq6YyPTD/XvGgnYj7WMUR5ZpukK/t3YmLABVOyUOL4rQlPNCsOzMs5q2sdeOi85YT
	NDyVQm5mNq52Z/gtGnGQ=
X-Google-Smtp-Source: AGHT+IGP97xyGdOg2fE8eVnO1V0ivUuM3GzpkAO9+MPS0TOTqHeEpCAaPAxlwrsJxsFl5r1d5F+ldA==
X-Received: by 2002:a17:907:db03:b0:b04:9854:981f with SMTP id a640c23a62f3a-b07c38404edmr839611366b.43.1757822443656;
        Sat, 13 Sep 2025 21:00:43 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b07c4043ec2sm505776366b.82.2025.09.13.21.00.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Sep 2025 21:00:42 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Aleksa Sarai <cyphar@cyphar.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Julian Stecklina <julian.stecklina@cyberus-technology.de>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Art Nikpal <email2tema@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Eric Curtin <ecurtin@redhat.com>,
	Alexander Graf <graf@amazon.com>,
	Rob Landley <rob@landley.net>,
	Lennart Poettering <mzxreary@0pointer.de>,
	linux-arch@vger.kernel.org,
	linux-alpha@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-um@lists.infradead.org,
	x86@kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	linux-block@vger.kernel.org,
	initramfs@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	"Theodore Y . Ts'o" <tytso@mit.edu>,
	linux-acpi@vger.kernel.org,
	Michal Simek <monstr@monstr.eu>,
	devicetree@vger.kernel.org,
	Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Heiko Carstens <hca@linux.ibm.com>,
	patches@lists.linux.dev
Subject: [PATCH RESEND 55/62] init: rename CONFIG_BLK_DEV_INITRD to CONFIG_INITRAMFS
Date: Sun, 14 Sep 2025 07:00:37 +0300
Message-ID: <20250914040037.3788082-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250913003842.41944-1-safinaskar@gmail.com>
References: <20250913003842.41944-1-safinaskar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Initrd support was removed, and CONFIG_BLK_DEV_INITRD has nothing
to do with initrd or block devices.

Update your configs

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 .../filesystems/ramfs-rootfs-initramfs.rst         |  2 +-
 Documentation/security/ipe.rst                     |  2 +-
 arch/alpha/kernel/core_irongate.c                  |  2 +-
 arch/alpha/kernel/proto.h                          |  2 +-
 arch/alpha/kernel/setup.c                          |  6 +++---
 arch/arc/configs/axs101_defconfig                  |  2 +-
 arch/arc/configs/axs103_defconfig                  |  2 +-
 arch/arc/configs/axs103_smp_defconfig              |  2 +-
 arch/arc/configs/haps_hs_defconfig                 |  2 +-
 arch/arc/configs/haps_hs_smp_defconfig             |  2 +-
 arch/arc/configs/hsdk_defconfig                    |  2 +-
 arch/arc/configs/nsim_700_defconfig                |  2 +-
 arch/arc/configs/nsimosci_defconfig                |  2 +-
 arch/arc/configs/nsimosci_hs_defconfig             |  2 +-
 arch/arc/configs/nsimosci_hs_smp_defconfig         |  2 +-
 arch/arc/configs/tb10x_defconfig                   |  2 +-
 arch/arc/configs/vdk_hs38_defconfig                |  2 +-
 arch/arc/configs/vdk_hs38_smp_defconfig            |  2 +-
 arch/arc/mm/init.c                                 |  4 ++--
 arch/arm/configs/aspeed_g4_defconfig               |  2 +-
 arch/arm/configs/aspeed_g5_defconfig               |  2 +-
 arch/arm/configs/assabet_defconfig                 |  2 +-
 arch/arm/configs/at91_dt_defconfig                 |  2 +-
 arch/arm/configs/axm55xx_defconfig                 |  2 +-
 arch/arm/configs/bcm2835_defconfig                 |  2 +-
 arch/arm/configs/clps711x_defconfig                |  2 +-
 arch/arm/configs/collie_defconfig                  |  2 +-
 arch/arm/configs/davinci_all_defconfig             |  2 +-
 arch/arm/configs/exynos_defconfig                  |  2 +-
 arch/arm/configs/footbridge_defconfig              |  2 +-
 arch/arm/configs/gemini_defconfig                  |  2 +-
 arch/arm/configs/h3600_defconfig                   |  2 +-
 arch/arm/configs/hisi_defconfig                    |  2 +-
 arch/arm/configs/imx_v4_v5_defconfig               |  2 +-
 arch/arm/configs/imx_v6_v7_defconfig               |  2 +-
 arch/arm/configs/integrator_defconfig              |  2 +-
 arch/arm/configs/ixp4xx_defconfig                  |  2 +-
 arch/arm/configs/keystone_defconfig                |  2 +-
 arch/arm/configs/lpc18xx_defconfig                 |  2 +-
 arch/arm/configs/lpc32xx_defconfig                 |  2 +-
 arch/arm/configs/milbeaut_m10v_defconfig           |  2 +-
 arch/arm/configs/multi_v4t_defconfig               |  2 +-
 arch/arm/configs/multi_v5_defconfig                |  2 +-
 arch/arm/configs/multi_v7_defconfig                |  2 +-
 arch/arm/configs/mvebu_v7_defconfig                |  2 +-
 arch/arm/configs/mxs_defconfig                     |  2 +-
 arch/arm/configs/neponset_defconfig                |  2 +-
 arch/arm/configs/nhk8815_defconfig                 |  2 +-
 arch/arm/configs/omap1_defconfig                   |  2 +-
 arch/arm/configs/omap2plus_defconfig               |  2 +-
 arch/arm/configs/pxa910_defconfig                  |  2 +-
 arch/arm/configs/pxa_defconfig                     |  2 +-
 arch/arm/configs/qcom_defconfig                    |  2 +-
 arch/arm/configs/rpc_defconfig                     |  2 +-
 arch/arm/configs/s3c6400_defconfig                 |  2 +-
 arch/arm/configs/s5pv210_defconfig                 |  2 +-
 arch/arm/configs/sama5_defconfig                   |  2 +-
 arch/arm/configs/sama7_defconfig                   |  2 +-
 arch/arm/configs/shmobile_defconfig                |  2 +-
 arch/arm/configs/socfpga_defconfig                 |  2 +-
 arch/arm/configs/spear13xx_defconfig               |  2 +-
 arch/arm/configs/spear3xx_defconfig                |  2 +-
 arch/arm/configs/spear6xx_defconfig                |  2 +-
 arch/arm/configs/stm32_defconfig                   |  2 +-
 arch/arm/configs/sunxi_defconfig                   |  2 +-
 arch/arm/configs/tegra_defconfig                   |  2 +-
 arch/arm/configs/u8500_defconfig                   |  2 +-
 arch/arm/configs/versatile_defconfig               |  2 +-
 arch/arm/configs/vexpress_defconfig                |  2 +-
 arch/arm/configs/vf610m4_defconfig                 |  2 +-
 arch/arm/configs/vt8500_v6_v7_defconfig            |  2 +-
 arch/arm/configs/wpcm450_defconfig                 |  2 +-
 arch/arm/mm/init.c                                 |  4 ++--
 arch/arm64/configs/defconfig                       |  2 +-
 arch/arm64/mm/init.c                               |  4 ++--
 arch/csky/kernel/setup.c                           |  4 ++--
 arch/hexagon/configs/comet_defconfig               |  2 +-
 arch/loongarch/configs/loongson3_defconfig         |  2 +-
 arch/m68k/configs/amiga_defconfig                  |  2 +-
 arch/m68k/configs/apollo_defconfig                 |  2 +-
 arch/m68k/configs/atari_defconfig                  |  2 +-
 arch/m68k/configs/bvme6000_defconfig               |  2 +-
 arch/m68k/configs/hp300_defconfig                  |  2 +-
 arch/m68k/configs/mac_defconfig                    |  2 +-
 arch/m68k/configs/multi_defconfig                  |  2 +-
 arch/m68k/configs/mvme147_defconfig                |  2 +-
 arch/m68k/configs/mvme16x_defconfig                |  2 +-
 arch/m68k/configs/q40_defconfig                    |  2 +-
 arch/m68k/configs/stmark2_defconfig                |  2 +-
 arch/m68k/configs/sun3_defconfig                   |  2 +-
 arch/m68k/configs/sun3x_defconfig                  |  2 +-
 arch/m68k/kernel/setup_mm.c                        |  4 ++--
 arch/m68k/kernel/setup_no.c                        |  4 ++--
 arch/m68k/kernel/uboot.c                           |  8 ++++----
 arch/microblaze/mm/init.c                          |  4 ++--
 arch/mips/ath79/prom.c                             |  2 +-
 arch/mips/configs/ath25_defconfig                  |  2 +-
 arch/mips/configs/ath79_defconfig                  |  2 +-
 arch/mips/configs/bcm47xx_defconfig                |  2 +-
 arch/mips/configs/bigsur_defconfig                 |  2 +-
 arch/mips/configs/bmips_be_defconfig               |  2 +-
 arch/mips/configs/bmips_stb_defconfig              |  2 +-
 arch/mips/configs/cavium_octeon_defconfig          |  2 +-
 arch/mips/configs/eyeq5_defconfig                  |  2 +-
 arch/mips/configs/eyeq6_defconfig                  |  2 +-
 arch/mips/configs/generic_defconfig                |  2 +-
 arch/mips/configs/gpr_defconfig                    |  2 +-
 arch/mips/configs/lemote2f_defconfig               |  2 +-
 arch/mips/configs/loongson2k_defconfig             |  2 +-
 arch/mips/configs/loongson3_defconfig              |  2 +-
 arch/mips/configs/malta_defconfig                  |  2 +-
 arch/mips/configs/mtx1_defconfig                   |  2 +-
 arch/mips/configs/rb532_defconfig                  |  2 +-
 arch/mips/configs/rbtx49xx_defconfig               |  2 +-
 arch/mips/configs/rt305x_defconfig                 |  2 +-
 arch/mips/configs/sb1250_swarm_defconfig           |  2 +-
 arch/mips/configs/xway_defconfig                   |  2 +-
 arch/mips/kernel/setup.c                           |  4 ++--
 arch/mips/sibyte/common/cfe.c                      | 14 +++++++-------
 arch/nios2/kernel/setup.c                          |  8 ++++----
 arch/openrisc/configs/or1klitex_defconfig          |  2 +-
 arch/openrisc/configs/or1ksim_defconfig            |  2 +-
 arch/openrisc/configs/simple_smp_defconfig         |  2 +-
 arch/openrisc/configs/virt_defconfig               |  2 +-
 arch/openrisc/kernel/setup.c                       |  6 +++---
 arch/openrisc/kernel/vmlinux.h                     |  2 +-
 arch/parisc/boot/compressed/misc.c                 |  2 +-
 arch/parisc/configs/generic-32bit_defconfig        |  2 +-
 arch/parisc/configs/generic-64bit_defconfig        |  2 +-
 arch/parisc/kernel/pdt.c                           |  2 +-
 arch/parisc/kernel/setup.c                         |  2 +-
 arch/parisc/mm/init.c                              |  4 ++--
 arch/powerpc/configs/44x/akebono_defconfig         |  2 +-
 arch/powerpc/configs/44x/arches_defconfig          |  2 +-
 arch/powerpc/configs/44x/bamboo_defconfig          |  2 +-
 arch/powerpc/configs/44x/bluestone_defconfig       |  2 +-
 arch/powerpc/configs/44x/canyonlands_defconfig     |  2 +-
 arch/powerpc/configs/44x/ebony_defconfig           |  2 +-
 arch/powerpc/configs/44x/eiger_defconfig           |  2 +-
 arch/powerpc/configs/44x/fsp2_defconfig            |  2 +-
 arch/powerpc/configs/44x/icon_defconfig            |  2 +-
 arch/powerpc/configs/44x/iss476-smp_defconfig      |  2 +-
 arch/powerpc/configs/44x/katmai_defconfig          |  2 +-
 arch/powerpc/configs/44x/rainier_defconfig         |  2 +-
 arch/powerpc/configs/44x/redwood_defconfig         |  2 +-
 arch/powerpc/configs/44x/sam440ep_defconfig        |  2 +-
 arch/powerpc/configs/44x/sequoia_defconfig         |  2 +-
 arch/powerpc/configs/44x/taishan_defconfig         |  2 +-
 arch/powerpc/configs/44x/warp_defconfig            |  2 +-
 arch/powerpc/configs/52xx/cm5200_defconfig         |  2 +-
 arch/powerpc/configs/52xx/lite5200b_defconfig      |  2 +-
 arch/powerpc/configs/52xx/motionpro_defconfig      |  2 +-
 arch/powerpc/configs/52xx/tqm5200_defconfig        |  2 +-
 arch/powerpc/configs/83xx/asp8347_defconfig        |  2 +-
 arch/powerpc/configs/83xx/mpc8313_rdb_defconfig    |  2 +-
 arch/powerpc/configs/83xx/mpc8315_rdb_defconfig    |  2 +-
 arch/powerpc/configs/83xx/mpc832x_rdb_defconfig    |  2 +-
 arch/powerpc/configs/83xx/mpc834x_itx_defconfig    |  2 +-
 arch/powerpc/configs/83xx/mpc834x_itxgp_defconfig  |  2 +-
 arch/powerpc/configs/83xx/mpc836x_rdk_defconfig    |  2 +-
 arch/powerpc/configs/83xx/mpc837x_rdb_defconfig    |  2 +-
 arch/powerpc/configs/85xx/ge_imp3a_defconfig       |  2 +-
 arch/powerpc/configs/85xx/ksi8560_defconfig        |  2 +-
 arch/powerpc/configs/85xx/socrates_defconfig       |  2 +-
 arch/powerpc/configs/85xx/stx_gp3_defconfig        |  2 +-
 arch/powerpc/configs/85xx/tqm8540_defconfig        |  2 +-
 arch/powerpc/configs/85xx/tqm8541_defconfig        |  2 +-
 arch/powerpc/configs/85xx/tqm8548_defconfig        |  2 +-
 arch/powerpc/configs/85xx/tqm8555_defconfig        |  2 +-
 arch/powerpc/configs/85xx/tqm8560_defconfig        |  2 +-
 arch/powerpc/configs/85xx/xes_mpc85xx_defconfig    |  2 +-
 arch/powerpc/configs/amigaone_defconfig            |  2 +-
 arch/powerpc/configs/cell_defconfig                |  2 +-
 arch/powerpc/configs/chrp32_defconfig              |  2 +-
 arch/powerpc/configs/fsl-emb-nonhw.config          |  2 +-
 arch/powerpc/configs/g5_defconfig                  |  2 +-
 arch/powerpc/configs/gamecube_defconfig            |  2 +-
 arch/powerpc/configs/holly_defconfig               |  2 +-
 arch/powerpc/configs/linkstation_defconfig         |  2 +-
 arch/powerpc/configs/mgcoge_defconfig              |  2 +-
 arch/powerpc/configs/microwatt_defconfig           |  2 +-
 arch/powerpc/configs/mpc512x_defconfig             |  2 +-
 arch/powerpc/configs/mpc5200_defconfig             |  2 +-
 arch/powerpc/configs/mpc83xx_defconfig             |  2 +-
 arch/powerpc/configs/pasemi_defconfig              |  2 +-
 arch/powerpc/configs/pmac32_defconfig              |  2 +-
 arch/powerpc/configs/powernv_defconfig             |  2 +-
 arch/powerpc/configs/ppc44x_defconfig              |  2 +-
 arch/powerpc/configs/ppc64_defconfig               |  2 +-
 arch/powerpc/configs/ppc64e_defconfig              |  2 +-
 arch/powerpc/configs/ppc6xx_defconfig              |  2 +-
 arch/powerpc/configs/ps3_defconfig                 |  2 +-
 arch/powerpc/configs/skiroot_defconfig             |  2 +-
 arch/powerpc/configs/wii_defconfig                 |  2 +-
 arch/powerpc/kernel/prom.c                         |  6 +++---
 arch/powerpc/kernel/prom_init.c                    |  4 ++--
 arch/powerpc/kernel/setup-common.c                 |  4 ++--
 arch/powerpc/platforms/powermac/setup.c            |  2 +-
 arch/riscv/configs/defconfig                       |  2 +-
 arch/riscv/configs/nommu_k210_defconfig            |  2 +-
 arch/riscv/configs/nommu_virt_defconfig            |  2 +-
 arch/s390/boot/startup.c                           |  4 ++--
 arch/s390/configs/zfcpdump_defconfig               |  2 +-
 arch/s390/kernel/setup.c                           |  2 +-
 arch/sh/configs/apsh4a3a_defconfig                 |  2 +-
 arch/sh/configs/apsh4ad0a_defconfig                |  2 +-
 arch/sh/configs/ecovec24-romimage_defconfig        |  2 +-
 arch/sh/configs/edosk7760_defconfig                |  2 +-
 arch/sh/configs/kfr2r09-romimage_defconfig         |  2 +-
 arch/sh/configs/kfr2r09_defconfig                  |  2 +-
 arch/sh/configs/magicpanelr2_defconfig             |  2 +-
 arch/sh/configs/migor_defconfig                    |  2 +-
 arch/sh/configs/rsk7201_defconfig                  |  2 +-
 arch/sh/configs/rsk7203_defconfig                  |  2 +-
 arch/sh/configs/sdk7786_defconfig                  |  2 +-
 arch/sh/configs/se7206_defconfig                   |  2 +-
 arch/sh/configs/se7705_defconfig                   |  2 +-
 arch/sh/configs/se7722_defconfig                   |  2 +-
 arch/sh/configs/se7751_defconfig                   |  2 +-
 arch/sh/configs/secureedge5410_defconfig           |  2 +-
 arch/sh/configs/sh03_defconfig                     |  2 +-
 arch/sh/configs/sh7757lcr_defconfig                |  2 +-
 arch/sh/configs/titan_defconfig                    |  2 +-
 arch/sh/configs/ul2_defconfig                      |  2 +-
 arch/sh/configs/urquell_defconfig                  |  2 +-
 arch/sh/kernel/setup.c                             |  2 +-
 arch/sparc/configs/sparc32_defconfig               |  2 +-
 arch/sparc/configs/sparc64_defconfig               |  2 +-
 arch/sparc/mm/init_32.c                            |  2 +-
 arch/sparc/mm/init_64.c                            |  4 ++--
 arch/um/kernel/Makefile                            |  2 +-
 arch/x86/Kconfig                                   |  2 +-
 arch/x86/boot/startup/sme.c                        |  2 +-
 arch/x86/configs/i386_defconfig                    |  2 +-
 arch/x86/configs/x86_64_defconfig                  |  2 +-
 arch/x86/kernel/cpu/microcode/core.c               |  4 ++--
 arch/x86/kernel/setup.c                            |  4 ++--
 arch/x86/mm/init.c                                 |  2 +-
 arch/xtensa/configs/audio_kc705_defconfig          |  2 +-
 arch/xtensa/configs/cadence_csp_defconfig          |  2 +-
 arch/xtensa/configs/generic_kc705_defconfig        |  2 +-
 arch/xtensa/configs/nommu_kc705_defconfig          |  2 +-
 arch/xtensa/configs/smp_lx200_defconfig            |  2 +-
 arch/xtensa/configs/virt_defconfig                 |  2 +-
 arch/xtensa/configs/xip_kc705_defconfig            |  2 +-
 arch/xtensa/kernel/setup.c                         |  8 ++++----
 drivers/acpi/Kconfig                               |  2 +-
 drivers/firmware/efi/efi.c                         |  2 +-
 drivers/firmware/efi/libstub/efi-stub-helper.c     |  2 +-
 drivers/gpu/drm/ci/arm.config                      |  2 +-
 drivers/gpu/drm/ci/arm64.config                    |  2 +-
 drivers/gpu/drm/ci/x86_64.config                   |  2 +-
 drivers/of/fdt.c                                   |  2 +-
 include/asm-generic/vmlinux.lds.h                  |  2 +-
 include/linux/initramfs.h                          |  2 +-
 init/.kunitconfig                                  |  2 +-
 init/Kconfig                                       |  8 ++++----
 init/Makefile                                      |  4 ++--
 init/main.c                                        |  4 ++--
 scripts/package/builddeb                           |  2 +-
 tools/testing/selftests/bpf/config.aarch64         |  2 +-
 tools/testing/selftests/bpf/config.ppc64el         |  2 +-
 tools/testing/selftests/bpf/config.riscv64         |  2 +-
 tools/testing/selftests/bpf/config.s390x           |  2 +-
 tools/testing/selftests/kho/vmtest.sh              |  2 +-
 tools/testing/selftests/nolibc/Makefile.nolibc     |  4 ++--
 tools/testing/selftests/vsock/config               |  2 +-
 .../testing/selftests/wireguard/qemu/kernel.config |  2 +-
 usr/Makefile                                       |  2 +-
 269 files changed, 311 insertions(+), 311 deletions(-)

diff --git a/Documentation/filesystems/ramfs-rootfs-initramfs.rst b/Documentation/filesystems/ramfs-rootfs-initramfs.rst
index 38a9cf11f547..8d85a353c7e6 100644
--- a/Documentation/filesystems/ramfs-rootfs-initramfs.rst
+++ b/Documentation/filesystems/ramfs-rootfs-initramfs.rst
@@ -224,7 +224,7 @@ use in place of the above config file::
 External initramfs images:
 --------------------------
 
-If the kernel has CONFIG_BLK_DEV_INITRD enabled, an external cpio.gz archive can also
+If the kernel has CONFIG_INITRAMFS enabled, an external cpio.gz archive can also
 be passed into a 2.6 kernel.  In this case, the kernel will extract the external cpio
 archive into rootfs before trying to run /init.
 
diff --git a/Documentation/security/ipe.rst b/Documentation/security/ipe.rst
index 4a7d953abcdc..05d3eb2e6901 100644
--- a/Documentation/security/ipe.rst
+++ b/Documentation/security/ipe.rst
@@ -432,7 +432,7 @@ IPE has KUnit Tests for the policy parser. Recommended kunitconfig::
   CONFIG_NET=y
   CONFIG_AUDIT=y
   CONFIG_AUDITSYSCALL=y
-  CONFIG_BLK_DEV_INITRD=y
+  CONFIG_INITRAMFS=y
 
   CONFIG_SECURITY_IPE=y
   CONFIG_IPE_PROP_DM_VERITY=y
diff --git a/arch/alpha/kernel/core_irongate.c b/arch/alpha/kernel/core_irongate.c
index 83b799848b39..24612c836225 100644
--- a/arch/alpha/kernel/core_irongate.c
+++ b/arch/alpha/kernel/core_irongate.c
@@ -224,7 +224,7 @@ albacore_init_arch(void)
 	IRONGATE0->pci_mem = pci_mem;
 	alpha_mv.min_mem_address = pci_mem;
 	if (memtop > pci_mem) {
-#ifdef CONFIG_BLK_DEV_INITRD
+#ifdef CONFIG_INITRAMFS
 		/* Move the initrd out of the way. */
 		if (virt_external_initramfs_end && __pa(virt_external_initramfs_end) > pci_mem) {
 			unsigned long size;
diff --git a/arch/alpha/kernel/proto.h b/arch/alpha/kernel/proto.h
index a8bc3ead776b..12bd14b6fc24 100644
--- a/arch/alpha/kernel/proto.h
+++ b/arch/alpha/kernel/proto.h
@@ -102,7 +102,7 @@ extern int boot_cpuid;
 #ifdef CONFIG_VERBOSE_MCHECK
 extern unsigned long alpha_verbose_mcheck;
 #endif
-#ifdef CONFIG_BLK_DEV_INITRD
+#ifdef CONFIG_INITRAMFS
 extern void * __init move_initrd(unsigned long);
 #endif
 extern struct screen_info vgacon_screen_info;
diff --git a/arch/alpha/kernel/setup.c b/arch/alpha/kernel/setup.c
index 809651206781..8d8e4936809e 100644
--- a/arch/alpha/kernel/setup.c
+++ b/arch/alpha/kernel/setup.c
@@ -261,7 +261,7 @@ get_mem_size_limit(char *s)
         return end >> PAGE_SHIFT; /* Return the PFN of the limit. */
 }
 
-#ifdef CONFIG_BLK_DEV_INITRD
+#ifdef CONFIG_INITRAMFS
 void * __init
 move_initrd(unsigned long mem_limit)
 {
@@ -346,7 +346,7 @@ setup_memory(void *kernel_end)
 	kernel_size = virt_to_phys(kernel_end) - KERNEL_START_PHYS;
 	memblock_reserve(KERNEL_START_PHYS, kernel_size);
 
-#ifdef CONFIG_BLK_DEV_INITRD
+#ifdef CONFIG_INITRAMFS
 	virt_external_initramfs_start = INITRD_START;
 	if (virt_external_initramfs_start) {
 		virt_external_initramfs_end = virt_external_initramfs_start+INITRD_SIZE;
@@ -364,7 +364,7 @@ setup_memory(void *kernel_end)
 					INITRD_SIZE);
 		}
 	}
-#endif /* CONFIG_BLK_DEV_INITRD */
+#endif /* CONFIG_INITRAMFS */
 }
 
 int page_is_ram(unsigned long pfn)
diff --git a/arch/arc/configs/axs101_defconfig b/arch/arc/configs/axs101_defconfig
index a7cd526dd7ca..a38d6c59fe02 100644
--- a/arch/arc/configs/axs101_defconfig
+++ b/arch/arc/configs/axs101_defconfig
@@ -8,7 +8,7 @@ CONFIG_IKCONFIG_PROC=y
 CONFIG_NAMESPACES=y
 # CONFIG_UTS_NS is not set
 # CONFIG_PID_NS is not set
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_EXPERT=y
 CONFIG_PERF_EVENTS=y
 # CONFIG_VM_EVENT_COUNTERS is not set
diff --git a/arch/arc/configs/axs103_defconfig b/arch/arc/configs/axs103_defconfig
index afa6a348f444..48eae5d99b21 100644
--- a/arch/arc/configs/axs103_defconfig
+++ b/arch/arc/configs/axs103_defconfig
@@ -8,7 +8,7 @@ CONFIG_IKCONFIG_PROC=y
 CONFIG_NAMESPACES=y
 # CONFIG_UTS_NS is not set
 # CONFIG_PID_NS is not set
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_EXPERT=y
 CONFIG_PERF_EVENTS=y
 # CONFIG_VM_EVENT_COUNTERS is not set
diff --git a/arch/arc/configs/axs103_smp_defconfig b/arch/arc/configs/axs103_smp_defconfig
index 2bfa6371953c..08f08c05683c 100644
--- a/arch/arc/configs/axs103_smp_defconfig
+++ b/arch/arc/configs/axs103_smp_defconfig
@@ -8,7 +8,7 @@ CONFIG_IKCONFIG_PROC=y
 CONFIG_NAMESPACES=y
 # CONFIG_UTS_NS is not set
 # CONFIG_PID_NS is not set
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_EXPERT=y
 CONFIG_PERF_EVENTS=y
 # CONFIG_VM_EVENT_COUNTERS is not set
diff --git a/arch/arc/configs/haps_hs_defconfig b/arch/arc/configs/haps_hs_defconfig
index 3a1577112078..4129d2396e81 100644
--- a/arch/arc/configs/haps_hs_defconfig
+++ b/arch/arc/configs/haps_hs_defconfig
@@ -10,7 +10,7 @@ CONFIG_IKCONFIG_PROC=y
 CONFIG_NAMESPACES=y
 # CONFIG_UTS_NS is not set
 # CONFIG_PID_NS is not set
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_EXPERT=y
 CONFIG_PERF_EVENTS=y
 # CONFIG_COMPAT_BRK is not set
diff --git a/arch/arc/configs/haps_hs_smp_defconfig b/arch/arc/configs/haps_hs_smp_defconfig
index a3cf940b1f5b..bd3eaef66a38 100644
--- a/arch/arc/configs/haps_hs_smp_defconfig
+++ b/arch/arc/configs/haps_hs_smp_defconfig
@@ -10,7 +10,7 @@ CONFIG_IKCONFIG_PROC=y
 CONFIG_NAMESPACES=y
 # CONFIG_UTS_NS is not set
 # CONFIG_PID_NS is not set
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_EXPERT=y
 CONFIG_PERF_EVENTS=y
 # CONFIG_VM_EVENT_COUNTERS is not set
diff --git a/arch/arc/configs/hsdk_defconfig b/arch/arc/configs/hsdk_defconfig
index 1558e8e87767..30e26d3fc18a 100644
--- a/arch/arc/configs/hsdk_defconfig
+++ b/arch/arc/configs/hsdk_defconfig
@@ -7,7 +7,7 @@ CONFIG_IKCONFIG_PROC=y
 CONFIG_NAMESPACES=y
 # CONFIG_UTS_NS is not set
 # CONFIG_PID_NS is not set
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_EXPERT=y
 CONFIG_PERF_EVENTS=y
diff --git a/arch/arc/configs/nsim_700_defconfig b/arch/arc/configs/nsim_700_defconfig
index f8b3235d9a65..8b455a18e01b 100644
--- a/arch/arc/configs/nsim_700_defconfig
+++ b/arch/arc/configs/nsim_700_defconfig
@@ -10,7 +10,7 @@ CONFIG_IKCONFIG_PROC=y
 CONFIG_NAMESPACES=y
 # CONFIG_UTS_NS is not set
 # CONFIG_PID_NS is not set
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_KALLSYMS_ALL=y
 CONFIG_EXPERT=y
 CONFIG_PERF_EVENTS=y
diff --git a/arch/arc/configs/nsimosci_defconfig b/arch/arc/configs/nsimosci_defconfig
index ee45dc0877fb..1a54febb68ab 100644
--- a/arch/arc/configs/nsimosci_defconfig
+++ b/arch/arc/configs/nsimosci_defconfig
@@ -9,7 +9,7 @@ CONFIG_IKCONFIG_PROC=y
 CONFIG_NAMESPACES=y
 # CONFIG_UTS_NS is not set
 # CONFIG_PID_NS is not set
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_KALLSYMS_ALL=y
 CONFIG_EXPERT=y
 CONFIG_PERF_EVENTS=y
diff --git a/arch/arc/configs/nsimosci_hs_defconfig b/arch/arc/configs/nsimosci_hs_defconfig
index e0a309970c20..2c471c5f6a3c 100644
--- a/arch/arc/configs/nsimosci_hs_defconfig
+++ b/arch/arc/configs/nsimosci_hs_defconfig
@@ -9,7 +9,7 @@ CONFIG_IKCONFIG_PROC=y
 CONFIG_NAMESPACES=y
 # CONFIG_UTS_NS is not set
 # CONFIG_PID_NS is not set
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_KALLSYMS_ALL=y
 CONFIG_EXPERT=y
 CONFIG_PERF_EVENTS=y
diff --git a/arch/arc/configs/nsimosci_hs_smp_defconfig b/arch/arc/configs/nsimosci_hs_smp_defconfig
index 88325b8b49cf..ff48c997e14a 100644
--- a/arch/arc/configs/nsimosci_hs_smp_defconfig
+++ b/arch/arc/configs/nsimosci_hs_smp_defconfig
@@ -7,7 +7,7 @@ CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 # CONFIG_UTS_NS is not set
 # CONFIG_PID_NS is not set
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_PERF_EVENTS=y
 # CONFIG_COMPAT_BRK is not set
 CONFIG_KPROBES=y
diff --git a/arch/arc/configs/tb10x_defconfig b/arch/arc/configs/tb10x_defconfig
index 865fbc19ef03..26a06eb336df 100644
--- a/arch/arc/configs/tb10x_defconfig
+++ b/arch/arc/configs/tb10x_defconfig
@@ -9,7 +9,7 @@ CONFIG_BSD_PROCESS_ACCT_V3=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=16
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_INITRAMFS_SOURCE="../tb10x-rootfs.cpio"
 CONFIG_INITRAMFS_ROOT_UID=2100
 CONFIG_INITRAMFS_ROOT_GID=501
diff --git a/arch/arc/configs/vdk_hs38_defconfig b/arch/arc/configs/vdk_hs38_defconfig
index 03d9ac20baa9..d02484817788 100644
--- a/arch/arc/configs/vdk_hs38_defconfig
+++ b/arch/arc/configs/vdk_hs38_defconfig
@@ -3,7 +3,7 @@
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_EXPERT=y
 CONFIG_PERF_EVENTS=y
 # CONFIG_VM_EVENT_COUNTERS is not set
diff --git a/arch/arc/configs/vdk_hs38_smp_defconfig b/arch/arc/configs/vdk_hs38_smp_defconfig
index c09488992f13..56bc91b20e45 100644
--- a/arch/arc/configs/vdk_hs38_smp_defconfig
+++ b/arch/arc/configs/vdk_hs38_smp_defconfig
@@ -3,7 +3,7 @@
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_EXPERT=y
 CONFIG_PERF_EVENTS=y
 # CONFIG_VM_EVENT_COUNTERS is not set
diff --git a/arch/arc/mm/init.c b/arch/arc/mm/init.c
index 00aaf1ed389f..9ba01fe378b2 100644
--- a/arch/arc/mm/init.c
+++ b/arch/arc/mm/init.c
@@ -6,7 +6,7 @@
 #include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/memblock.h>
-#ifdef CONFIG_BLK_DEV_INITRD
+#ifdef CONFIG_INITRAMFS
 #include <linux/initramfs.h>
 #endif
 #include <linux/of_fdt.h>
@@ -109,7 +109,7 @@ void __init setup_arch_memory(void)
 	memblock_reserve(CONFIG_LINUX_LINK_BASE,
 			 __pa(_end) - CONFIG_LINUX_LINK_BASE);
 
-#ifdef CONFIG_BLK_DEV_INITRD
+#ifdef CONFIG_INITRAMFS
 	if (phys_external_initramfs_size) {
 		memblock_reserve(phys_external_initramfs_start, phys_external_initramfs_size);
 		virt_external_initramfs_start = (unsigned long)__va(phys_external_initramfs_start);
diff --git a/arch/arm/configs/aspeed_g4_defconfig b/arch/arm/configs/aspeed_g4_defconfig
index 28b724d59e7e..f2abada5036a 100644
--- a/arch/arm/configs/aspeed_g4_defconfig
+++ b/arch/arm/configs/aspeed_g4_defconfig
@@ -8,7 +8,7 @@ CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=16
 CONFIG_CGROUPS=y
 CONFIG_NAMESPACES=y
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 # CONFIG_RD_BZIP2 is not set
 # CONFIG_RD_LZO is not set
 # CONFIG_RD_LZ4 is not set
diff --git a/arch/arm/configs/aspeed_g5_defconfig b/arch/arm/configs/aspeed_g5_defconfig
index 61cee1e7ebea..7098a09fefb8 100644
--- a/arch/arm/configs/aspeed_g5_defconfig
+++ b/arch/arm/configs/aspeed_g5_defconfig
@@ -8,7 +8,7 @@ CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=16
 CONFIG_CGROUPS=y
 CONFIG_NAMESPACES=y
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 # CONFIG_RD_BZIP2 is not set
 # CONFIG_RD_LZO is not set
 # CONFIG_RD_LZ4 is not set
diff --git a/arch/arm/configs/assabet_defconfig b/arch/arm/configs/assabet_defconfig
index 56fce6c08945..e579701d37b3 100644
--- a/arch/arm/configs/assabet_defconfig
+++ b/arch/arm/configs/assabet_defconfig
@@ -1,6 +1,6 @@
 CONFIG_SYSVIPC=y
 CONFIG_LOG_BUF_SHIFT=14
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_ARCH_MULTI_V4=y
 # CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_SA1100=y
diff --git a/arch/arm/configs/at91_dt_defconfig b/arch/arm/configs/at91_dt_defconfig
index b53c7906d317..93204658ef5a 100644
--- a/arch/arm/configs/at91_dt_defconfig
+++ b/arch/arm/configs/at91_dt_defconfig
@@ -4,7 +4,7 @@ CONFIG_NO_HZ_IDLE=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_CGROUPS=y
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_EXPERT=y
 CONFIG_KALLSYMS_ALL=y
diff --git a/arch/arm/configs/axm55xx_defconfig b/arch/arm/configs/axm55xx_defconfig
index 516689dc6cf1..dba5db27fd3a 100644
--- a/arch/arm/configs/axm55xx_defconfig
+++ b/arch/arm/configs/axm55xx_defconfig
@@ -20,7 +20,7 @@ CONFIG_NAMESPACES=y
 # CONFIG_NET_NS is not set
 CONFIG_SCHED_AUTOGROUP=y
 CONFIG_RELAY=y
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_EXPERT=y
 CONFIG_PROFILING=y
 CONFIG_ARCH_AXXIA=y
diff --git a/arch/arm/configs/bcm2835_defconfig b/arch/arm/configs/bcm2835_defconfig
index 27dc3bf6b124..58bb05fa46f7 100644
--- a/arch/arm/configs/bcm2835_defconfig
+++ b/arch/arm/configs/bcm2835_defconfig
@@ -15,7 +15,7 @@ CONFIG_CGROUP_PERF=y
 CONFIG_NAMESPACES=y
 CONFIG_SCHED_AUTOGROUP=y
 CONFIG_RELAY=y
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_EXPERT=y
 CONFIG_KALLSYMS_ALL=y
diff --git a/arch/arm/configs/clps711x_defconfig b/arch/arm/configs/clps711x_defconfig
index 6fa3477e6b02..4d71d227361f 100644
--- a/arch/arm/configs/clps711x_defconfig
+++ b/arch/arm/configs/clps711x_defconfig
@@ -1,7 +1,7 @@
 CONFIG_KERNEL_LZMA=y
 CONFIG_SYSVIPC=y
 CONFIG_LOG_BUF_SHIFT=14
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_RD_LZMA=y
 CONFIG_EXPERT=y
 CONFIG_JUMP_LABEL=y
diff --git a/arch/arm/configs/collie_defconfig b/arch/arm/configs/collie_defconfig
index 00dc8ae22824..6779f6e846ca 100644
--- a/arch/arm/configs/collie_defconfig
+++ b/arch/arm/configs/collie_defconfig
@@ -1,6 +1,6 @@
 CONFIG_SYSVIPC=y
 CONFIG_LOG_BUF_SHIFT=14
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 CONFIG_EXPERT=y
 CONFIG_BASE_SMALL=y
diff --git a/arch/arm/configs/davinci_all_defconfig b/arch/arm/configs/davinci_all_defconfig
index e2ddaca0f89d..929ac8251fd1 100644
--- a/arch/arm/configs/davinci_all_defconfig
+++ b/arch/arm/configs/davinci_all_defconfig
@@ -8,7 +8,7 @@ CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_CGROUPS=y
 CONFIG_CHECKPOINT_RESTORE=y
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_EXPERT=y
 CONFIG_ARCH_MULTIPLATFORM=y
 CONFIG_ARCH_MULTI_V5=y
diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
index 02a903816baa..5ec8e4f9f92b 100644
--- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@ -3,7 +3,7 @@ CONFIG_NO_HZ_IDLE=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_PREEMPT=y
 CONFIG_CGROUPS=y
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_PERF_EVENTS=y
 CONFIG_ARCH_EXYNOS=y
 CONFIG_CPU_ICACHE_MISMATCH_WORKAROUND=y
diff --git a/arch/arm/configs/footbridge_defconfig b/arch/arm/configs/footbridge_defconfig
index 5f6963687ee4..5df6c9c46aa2 100644
--- a/arch/arm/configs/footbridge_defconfig
+++ b/arch/arm/configs/footbridge_defconfig
@@ -1,7 +1,7 @@
 CONFIG_SYSVIPC=y
 CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_LOG_BUF_SHIFT=14
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_EXPERT=y
 # CONFIG_HOTPLUG is not set
 CONFIG_ARCH_MULTI_V4=y
diff --git a/arch/arm/configs/gemini_defconfig b/arch/arm/configs/gemini_defconfig
index 7b1daec630cb..a87bc109dead 100644
--- a/arch/arm/configs/gemini_defconfig
+++ b/arch/arm/configs/gemini_defconfig
@@ -6,7 +6,7 @@ CONFIG_PREEMPT=y
 CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_USER_NS=y
 CONFIG_RELAY=y
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_KEXEC=y
 CONFIG_ARCH_MULTI_V4=y
 # CONFIG_ARCH_MULTI_V7 is not set
diff --git a/arch/arm/configs/h3600_defconfig b/arch/arm/configs/h3600_defconfig
index 4e272875c797..3c5f3ecf490c 100644
--- a/arch/arm/configs/h3600_defconfig
+++ b/arch/arm/configs/h3600_defconfig
@@ -3,7 +3,7 @@ CONFIG_NO_HZ_IDLE=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_PREEMPT=y
 CONFIG_LOG_BUF_SHIFT=14
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_ARCH_MULTI_V4=y
 # CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_SA1100=y
diff --git a/arch/arm/configs/hisi_defconfig b/arch/arm/configs/hisi_defconfig
index e19c1039fb93..fe18af17b7cc 100644
--- a/arch/arm/configs/hisi_defconfig
+++ b/arch/arm/configs/hisi_defconfig
@@ -1,7 +1,7 @@
 CONFIG_NO_HZ_IDLE=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_PREEMPT=y
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_RD_LZMA=y
 CONFIG_ARCH_HISI=y
 CONFIG_ARCH_HI3xxx=y
diff --git a/arch/arm/configs/imx_v4_v5_defconfig b/arch/arm/configs/imx_v4_v5_defconfig
index 875c8cdbada7..3c0a09cfe1f2 100644
--- a/arch/arm/configs/imx_v4_v5_defconfig
+++ b/arch/arm/configs/imx_v4_v5_defconfig
@@ -5,7 +5,7 @@ CONFIG_HIGH_RES_TIMERS=y
 CONFIG_PREEMPT=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_CGROUPS=y
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_EXPERT=y
 CONFIG_PROFILING=y
 CONFIG_ARCH_MULTI_V4T=y
diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index b53ae2c052fc..35b086ae7d0b 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -9,7 +9,7 @@ CONFIG_LOG_BUF_SHIFT=18
 CONFIG_CGROUPS=y
 CONFIG_CGROUP_BPF=y
 CONFIG_RELAY=y
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_EXPERT=y
 CONFIG_PERF_EVENTS=y
 CONFIG_KEXEC=y
diff --git a/arch/arm/configs/integrator_defconfig b/arch/arm/configs/integrator_defconfig
index 61711d4bbf74..8d2deb5b3175 100644
--- a/arch/arm/configs/integrator_defconfig
+++ b/arch/arm/configs/integrator_defconfig
@@ -5,7 +5,7 @@ CONFIG_PREEMPT=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=14
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_ARCH_MULTI_V4T=y
 CONFIG_ARCH_MULTI_V5=y
 # CONFIG_ARCH_MULTI_V7 is not set
diff --git a/arch/arm/configs/ixp4xx_defconfig b/arch/arm/configs/ixp4xx_defconfig
index 3cb995b9616a..7f20548ffff4 100644
--- a/arch/arm/configs/ixp4xx_defconfig
+++ b/arch/arm/configs/ixp4xx_defconfig
@@ -3,7 +3,7 @@ CONFIG_SYSVIPC=y
 CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_CGROUPS=y
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_INITRAMFS_COMPRESSION_XZ=y
 CONFIG_EXPERT=y
 # CONFIG_ARCH_MULTI_V7 is not set
diff --git a/arch/arm/configs/keystone_defconfig b/arch/arm/configs/keystone_defconfig
index c1291ca290b2..69b1aea5539a 100644
--- a/arch/arm/configs/keystone_defconfig
+++ b/arch/arm/configs/keystone_defconfig
@@ -10,7 +10,7 @@ CONFIG_CGROUP_SCHED=y
 CONFIG_CGROUP_FREEZER=y
 CONFIG_CGROUP_DEVICE=y
 CONFIG_CGROUP_CPUACCT=y
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 # CONFIG_ELF_CORE is not set
 CONFIG_BASE_SMALL=y
 CONFIG_KALLSYMS_ALL=y
diff --git a/arch/arm/configs/lpc18xx_defconfig b/arch/arm/configs/lpc18xx_defconfig
index 2d489186e945..c8f7fa140225 100644
--- a/arch/arm/configs/lpc18xx_defconfig
+++ b/arch/arm/configs/lpc18xx_defconfig
@@ -1,6 +1,6 @@
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_PREEMPT=y
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 # CONFIG_RD_BZIP2 is not set
 # CONFIG_RD_LZMA is not set
 # CONFIG_RD_XZ is not set
diff --git a/arch/arm/configs/lpc32xx_defconfig b/arch/arm/configs/lpc32xx_defconfig
index a98d1125b9aa..bd1699e6d11d 100644
--- a/arch/arm/configs/lpc32xx_defconfig
+++ b/arch/arm/configs/lpc32xx_defconfig
@@ -5,7 +5,7 @@ CONFIG_PREEMPT=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=16
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_EXPERT=y
 # CONFIG_ARCH_MULTI_V7 is not set
diff --git a/arch/arm/configs/milbeaut_m10v_defconfig b/arch/arm/configs/milbeaut_m10v_defconfig
index a3be0b2ede09..048902c26337 100644
--- a/arch/arm/configs/milbeaut_m10v_defconfig
+++ b/arch/arm/configs/milbeaut_m10v_defconfig
@@ -2,7 +2,7 @@ CONFIG_SYSVIPC=y
 CONFIG_NO_HZ_IDLE=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_CGROUPS=y
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_EXPERT=y
 CONFIG_PERF_EVENTS=y
 CONFIG_ARCH_MILBEAUT=y
diff --git a/arch/arm/configs/multi_v4t_defconfig b/arch/arm/configs/multi_v4t_defconfig
index 1a86dc305523..b6ca7445d9fe 100644
--- a/arch/arm/configs/multi_v4t_defconfig
+++ b/arch/arm/configs/multi_v4t_defconfig
@@ -1,7 +1,7 @@
 CONFIG_KERNEL_LZMA=y
 CONFIG_SYSVIPC=y
 CONFIG_LOG_BUF_SHIFT=14
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_EXPERT=y
 CONFIG_ARCH_MULTI_V4T=y
 # CONFIG_ARCH_MULTI_V7 is not set
diff --git a/arch/arm/configs/multi_v5_defconfig b/arch/arm/configs/multi_v5_defconfig
index b523bc246c09..f268248cc108 100644
--- a/arch/arm/configs/multi_v5_defconfig
+++ b/arch/arm/configs/multi_v5_defconfig
@@ -4,7 +4,7 @@ CONFIG_HIGH_RES_TIMERS=y
 CONFIG_PREEMPT=y
 CONFIG_LOG_BUF_SHIFT=19
 CONFIG_CGROUPS=y
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_PROFILING=y
 # CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_ASPEED=y
diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index f2822eeefb95..1f82b6f570c8 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -2,7 +2,7 @@ CONFIG_SYSVIPC=y
 CONFIG_NO_HZ_IDLE=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_CGROUPS=y
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_EXPERT=y
 CONFIG_PERF_EVENTS=y
 CONFIG_KEXEC=y
diff --git a/arch/arm/configs/mvebu_v7_defconfig b/arch/arm/configs/mvebu_v7_defconfig
index 2d2a4dc8f379..65b0dae42f75 100644
--- a/arch/arm/configs/mvebu_v7_defconfig
+++ b/arch/arm/configs/mvebu_v7_defconfig
@@ -1,7 +1,7 @@
 CONFIG_SYSVIPC=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_LOG_BUF_SHIFT=14
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_EXPERT=y
 CONFIG_PERF_EVENTS=y
 CONFIG_ARCH_MVEBU=y
diff --git a/arch/arm/configs/mxs_defconfig b/arch/arm/configs/mxs_defconfig
index 3b08c63b6de4..676bff953987 100644
--- a/arch/arm/configs/mxs_defconfig
+++ b/arch/arm/configs/mxs_defconfig
@@ -13,7 +13,7 @@ CONFIG_CGROUPS=y
 # CONFIG_IPC_NS is not set
 # CONFIG_PID_NS is not set
 # CONFIG_NET_NS is not set
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_PERF_EVENTS=y
 # CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_MXS=y
diff --git a/arch/arm/configs/neponset_defconfig b/arch/arm/configs/neponset_defconfig
index a61eb27373a8..44cd383bb39f 100644
--- a/arch/arm/configs/neponset_defconfig
+++ b/arch/arm/configs/neponset_defconfig
@@ -1,6 +1,6 @@
 CONFIG_SYSVIPC=y
 CONFIG_LOG_BUF_SHIFT=14
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_ARCH_MULTI_V4=y
 # CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_SA1100=y
diff --git a/arch/arm/configs/nhk8815_defconfig b/arch/arm/configs/nhk8815_defconfig
index ea28ed8991b4..67e40d8cdf95 100644
--- a/arch/arm/configs/nhk8815_defconfig
+++ b/arch/arm/configs/nhk8815_defconfig
@@ -6,7 +6,7 @@ CONFIG_PREEMPT=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=14
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_EXPERT=y
 CONFIG_KALLSYMS_ALL=y
 # CONFIG_ARCH_MULTI_V7 is not set
diff --git a/arch/arm/configs/omap1_defconfig b/arch/arm/configs/omap1_defconfig
index 661e5d6894bd..4543660f033b 100644
--- a/arch/arm/configs/omap1_defconfig
+++ b/arch/arm/configs/omap1_defconfig
@@ -6,7 +6,7 @@ CONFIG_PREEMPT=y
 CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_IKCONFIG=y
 CONFIG_LOG_BUF_SHIFT=14
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_EXPERT=y
 # CONFIG_ELF_CORE is not set
 CONFIG_BASE_SMALL=y
diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 939913ed9a73..440897931240 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -19,7 +19,7 @@ CONFIG_CGROUP_DEVICE=y
 CONFIG_CGROUP_CPUACCT=y
 CONFIG_CGROUP_PERF=y
 CONFIG_NAMESPACES=y
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_EXPERT=y
 CONFIG_PROFILING=y
 CONFIG_ARCH_MULTI_V6=y
diff --git a/arch/arm/configs/pxa910_defconfig b/arch/arm/configs/pxa910_defconfig
index 49b59c600ae1..c06346f20f22 100644
--- a/arch/arm/configs/pxa910_defconfig
+++ b/arch/arm/configs/pxa910_defconfig
@@ -3,7 +3,7 @@ CONFIG_NO_HZ_IDLE=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_PREEMPT=y
 CONFIG_LOG_BUF_SHIFT=14
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_ARCH_MMP=y
 CONFIG_CMDLINE="root=/dev/nfs rootfstype=nfs nfsroot=192.168.2.100:/nfsroot/ ip=192.168.2.101:192.168.2.100::255.255.255.0::eth0:on console=ttyS0,115200 mem=128M earlyprintk"
 CONFIG_MODULES=y
diff --git a/arch/arm/configs/pxa_defconfig b/arch/arm/configs/pxa_defconfig
index 0c4b9389d4d6..2e902618ae2b 100644
--- a/arch/arm/configs/pxa_defconfig
+++ b/arch/arm/configs/pxa_defconfig
@@ -9,7 +9,7 @@ CONFIG_BSD_PROCESS_ACCT_V3=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=13
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_EXPERT=y
 CONFIG_KALLSYMS_ALL=y
 CONFIG_PROFILING=y
diff --git a/arch/arm/configs/qcom_defconfig b/arch/arm/configs/qcom_defconfig
index ec52ccece0ca..f527adaf3a8f 100644
--- a/arch/arm/configs/qcom_defconfig
+++ b/arch/arm/configs/qcom_defconfig
@@ -5,7 +5,7 @@ CONFIG_PREEMPT=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_CGROUPS=y
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_EXPERT=y
 CONFIG_KALLSYMS_ALL=y
 CONFIG_PROFILING=y
diff --git a/arch/arm/configs/rpc_defconfig b/arch/arm/configs/rpc_defconfig
index 24f1fa868230..4963d060df74 100644
--- a/arch/arm/configs/rpc_defconfig
+++ b/arch/arm/configs/rpc_defconfig
@@ -1,7 +1,7 @@
 # CONFIG_LOCALVERSION_AUTO is not set
 CONFIG_SYSVIPC=y
 CONFIG_LOG_BUF_SHIFT=14
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_ARCH_MULTI_V4=y
 # CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_RPC=y
diff --git a/arch/arm/configs/s3c6400_defconfig b/arch/arm/configs/s3c6400_defconfig
index a5018ce274ec..9935514bb22d 100644
--- a/arch/arm/configs/s3c6400_defconfig
+++ b/arch/arm/configs/s3c6400_defconfig
@@ -1,4 +1,4 @@
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_KALLSYMS_ALL=y
 CONFIG_ARCH_MULTI_V6=y
 # CONFIG_ARCH_MULTI_V7 is not set
diff --git a/arch/arm/configs/s5pv210_defconfig b/arch/arm/configs/s5pv210_defconfig
index 485dd5174c62..dc8fc5bc066b 100644
--- a/arch/arm/configs/s5pv210_defconfig
+++ b/arch/arm/configs/s5pv210_defconfig
@@ -3,7 +3,7 @@ CONFIG_NO_HZ_IDLE=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_PREEMPT=y
 CONFIG_CGROUPS=y
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_KALLSYMS_ALL=y
 CONFIG_ARCH_S5PV210=y
 CONFIG_VMSPLIT_2G=y
diff --git a/arch/arm/configs/sama5_defconfig b/arch/arm/configs/sama5_defconfig
index 0463ff84c06c..d7c361d0e473 100644
--- a/arch/arm/configs/sama5_defconfig
+++ b/arch/arm/configs/sama5_defconfig
@@ -4,7 +4,7 @@ CONFIG_NO_HZ_IDLE=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_CGROUPS=y
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_EXPERT=y
 CONFIG_KEXEC=y
 CONFIG_ARCH_AT91=y
diff --git a/arch/arm/configs/sama7_defconfig b/arch/arm/configs/sama7_defconfig
index e14720a9a5ac..30bb54b4881f 100644
--- a/arch/arm/configs/sama7_defconfig
+++ b/arch/arm/configs/sama7_defconfig
@@ -6,7 +6,7 @@ CONFIG_LOG_BUF_SHIFT=16
 CONFIG_CGROUPS=y
 CONFIG_CGROUP_DEBUG=y
 CONFIG_NAMESPACES=y
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_EXPERT=y
 # CONFIG_FHANDLE is not set
 # CONFIG_IO_URING is not set
diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index e4cb33b2bcee..d5dde4e1572d 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -3,7 +3,7 @@ CONFIG_NO_HZ_IDLE=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_CGROUPS=y
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_PERF_EVENTS=y
 CONFIG_KEXEC=y
diff --git a/arch/arm/configs/socfpga_defconfig b/arch/arm/configs/socfpga_defconfig
index 294906c8f16e..b817aa2bd0f2 100644
--- a/arch/arm/configs/socfpga_defconfig
+++ b/arch/arm/configs/socfpga_defconfig
@@ -6,7 +6,7 @@ CONFIG_LOG_BUF_SHIFT=14
 CONFIG_CGROUPS=y
 CONFIG_CPUSETS=y
 CONFIG_NAMESPACES=y
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_EXPERT=y
 CONFIG_PROFILING=y
 CONFIG_ARCH_INTEL_SOCFPGA=y
diff --git a/arch/arm/configs/spear13xx_defconfig b/arch/arm/configs/spear13xx_defconfig
index a8f992fdb30d..c7e67ab6027e 100644
--- a/arch/arm/configs/spear13xx_defconfig
+++ b/arch/arm/configs/spear13xx_defconfig
@@ -1,6 +1,6 @@
 CONFIG_SYSVIPC=y
 CONFIG_BSD_PROCESS_ACCT=y
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_PLAT_SPEAR=y
 CONFIG_ARCH_SPEAR13XX=y
 CONFIG_MACH_SPEAR1310=y
diff --git a/arch/arm/configs/spear3xx_defconfig b/arch/arm/configs/spear3xx_defconfig
index 8dc5a388759c..aa0643962e45 100644
--- a/arch/arm/configs/spear3xx_defconfig
+++ b/arch/arm/configs/spear3xx_defconfig
@@ -1,6 +1,6 @@
 CONFIG_SYSVIPC=y
 CONFIG_BSD_PROCESS_ACCT=y
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 # CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_PLAT_SPEAR=y
 CONFIG_ARCH_SPEAR3XX=y
diff --git a/arch/arm/configs/spear6xx_defconfig b/arch/arm/configs/spear6xx_defconfig
index 4e9e1a6ff381..3a5998a00f2d 100644
--- a/arch/arm/configs/spear6xx_defconfig
+++ b/arch/arm/configs/spear6xx_defconfig
@@ -1,6 +1,6 @@
 CONFIG_SYSVIPC=y
 CONFIG_BSD_PROCESS_ACCT=y
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 # CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_PLAT_SPEAR=y
 CONFIG_ARCH_SPEAR6XX=y
diff --git a/arch/arm/configs/stm32_defconfig b/arch/arm/configs/stm32_defconfig
index dcd9c316072e..00ab395b6241 100644
--- a/arch/arm/configs/stm32_defconfig
+++ b/arch/arm/configs/stm32_defconfig
@@ -2,7 +2,7 @@ CONFIG_NO_HZ_IDLE=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_PREEMPT=y
 CONFIG_LOG_BUF_SHIFT=16
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_EXPERT=y
 # CONFIG_UID16 is not set
diff --git a/arch/arm/configs/sunxi_defconfig b/arch/arm/configs/sunxi_defconfig
index a83d29fed175..70efc9a5d229 100644
--- a/arch/arm/configs/sunxi_defconfig
+++ b/arch/arm/configs/sunxi_defconfig
@@ -1,7 +1,7 @@
 CONFIG_NO_HZ_IDLE=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_CGROUPS=y
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_PERF_EVENTS=y
 CONFIG_ARCH_SUNXI=y
 CONFIG_SMP=y
diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra_defconfig
index ba863b445417..29339c5f0522 100644
--- a/arch/arm/configs/tegra_defconfig
+++ b/arch/arm/configs/tegra_defconfig
@@ -11,7 +11,7 @@ CONFIG_CGROUP_CPUACCT=y
 CONFIG_CGROUP_DEBUG=y
 CONFIG_NAMESPACES=y
 CONFIG_USER_NS=y
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_EXPERT=y
 # CONFIG_ELF_CORE is not set
 CONFIG_PERF_EVENTS=y
diff --git a/arch/arm/configs/u8500_defconfig b/arch/arm/configs/u8500_defconfig
index 510c760b0bc7..2baea78bf7ab 100644
--- a/arch/arm/configs/u8500_defconfig
+++ b/arch/arm/configs/u8500_defconfig
@@ -1,7 +1,7 @@
 CONFIG_SYSVIPC=y
 CONFIG_NO_HZ_IDLE=y
 CONFIG_HIGH_RES_TIMERS=y
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_KALLSYMS_ALL=y
 CONFIG_ARCH_U8500=y
 CONFIG_SMP=y
diff --git a/arch/arm/configs/versatile_defconfig b/arch/arm/configs/versatile_defconfig
index 849118cbbb44..72b63b446c3a 100644
--- a/arch/arm/configs/versatile_defconfig
+++ b/arch/arm/configs/versatile_defconfig
@@ -3,7 +3,7 @@ CONFIG_SYSVIPC=y
 CONFIG_NO_HZ_IDLE=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_LOG_BUF_SHIFT=14
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 # CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_VERSATILE=y
 CONFIG_AEABI=y
diff --git a/arch/arm/configs/vexpress_defconfig b/arch/arm/configs/vexpress_defconfig
index cdb6065e04fd..5880a6780c30 100644
--- a/arch/arm/configs/vexpress_defconfig
+++ b/arch/arm/configs/vexpress_defconfig
@@ -11,7 +11,7 @@ CONFIG_CPUSETS=y
 # CONFIG_IPC_NS is not set
 # CONFIG_PID_NS is not set
 # CONFIG_NET_NS is not set
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_PROFILING=y
 CONFIG_ARCH_VEXPRESS=y
 CONFIG_ARCH_VEXPRESS_TC2_PM=y
diff --git a/arch/arm/configs/vf610m4_defconfig b/arch/arm/configs/vf610m4_defconfig
index a5609cbfdfb3..b253d76e0d40 100644
--- a/arch/arm/configs/vf610m4_defconfig
+++ b/arch/arm/configs/vf610m4_defconfig
@@ -1,5 +1,5 @@
 CONFIG_NAMESPACES=y
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 # CONFIG_RD_BZIP2 is not set
 # CONFIG_RD_LZMA is not set
 # CONFIG_RD_XZ is not set
diff --git a/arch/arm/configs/vt8500_v6_v7_defconfig b/arch/arm/configs/vt8500_v6_v7_defconfig
index 41607a84abc8..3fcff0693f4c 100644
--- a/arch/arm/configs/vt8500_v6_v7_defconfig
+++ b/arch/arm/configs/vt8500_v6_v7_defconfig
@@ -1,6 +1,6 @@
 CONFIG_NO_HZ_IDLE=y
 CONFIG_HIGH_RES_TIMERS=y
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_ARCH_MULTI_V6=y
 CONFIG_ARCH_WM8750=y
 CONFIG_ARCH_WM8850=y
diff --git a/arch/arm/configs/wpcm450_defconfig b/arch/arm/configs/wpcm450_defconfig
index cd4b3e70ff68..0fce14de7dbf 100644
--- a/arch/arm/configs/wpcm450_defconfig
+++ b/arch/arm/configs/wpcm450_defconfig
@@ -6,7 +6,7 @@ CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=19
 CONFIG_CGROUPS=y
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_PROFILING=y
 # CONFIG_ARCH_MULTI_V7 is not set
diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 04ba9b385e24..ae08a14ca429 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -50,7 +50,7 @@ unsigned long __init __clear_cr(unsigned long mask)
 }
 #endif
 
-#ifdef CONFIG_BLK_DEV_INITRD
+#ifdef CONFIG_INITRAMFS
 static int __init parse_tag_initrd(const struct tag *tag)
 {
 	pr_warn("ATAG_INITRD is deprecated; "
@@ -436,7 +436,7 @@ void free_initmem(void)
 		free_initmem_default(-1);
 }
 
-#ifdef CONFIG_BLK_DEV_INITRD
+#ifdef CONFIG_INITRAMFS
 void free_initramfs_mem(unsigned long start, unsigned long end)
 {
 	if (start == virt_external_initramfs_start)
diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 58f87d09366c..baae6caf4401 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -27,7 +27,7 @@ CONFIG_CGROUP_PERF=y
 CONFIG_CGROUP_BPF=y
 CONFIG_USER_NS=y
 CONFIG_SCHED_AUTOGROUP=y
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_KALLSYMS_ALL=y
 CONFIG_PROFILING=y
 CONFIG_KEXEC=y
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index e50533faaece..db9b021e8947 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -246,7 +246,7 @@ void __init arm64_memblock_init(void)
 		memblock_add(__pa_symbol(_text), (u64)(_end - _text));
 	}
 
-	if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) && phys_external_initramfs_size) {
+	if (IS_ENABLED(CONFIG_INITRAMFS) && phys_external_initramfs_size) {
 		/*
 		 * Add back the memory we just removed if it results in the
 		 * initrd to become inaccessible via the linear mapping.
@@ -281,7 +281,7 @@ void __init arm64_memblock_init(void)
 	 * pagetables with memblock.
 	 */
 	memblock_reserve(__pa_symbol(_stext), _end - _stext);
-	if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) && phys_external_initramfs_size) {
+	if (IS_ENABLED(CONFIG_INITRAMFS) && phys_external_initramfs_size) {
 		/* the generic initrd code expects virtual addresses */
 		virt_external_initramfs_start = __phys_to_virt(phys_external_initramfs_start);
 		virt_external_initramfs_end = virt_external_initramfs_start + phys_external_initramfs_size;
diff --git a/arch/csky/kernel/setup.c b/arch/csky/kernel/setup.c
index 9feca38d4c47..04583140fda8 100644
--- a/arch/csky/kernel/setup.c
+++ b/arch/csky/kernel/setup.c
@@ -12,7 +12,7 @@
 #include <asm/mmu_context.h>
 #include <asm/pgalloc.h>
 
-#ifdef CONFIG_BLK_DEV_INITRD
+#ifdef CONFIG_INITRAMFS
 static void __init setup_initrd(void)
 {
 	unsigned long size;
@@ -79,7 +79,7 @@ static void __init csky_memblock_init(void)
 		max_low_pfn = min_low_pfn + sseg_size;
 	}
 
-#ifdef CONFIG_BLK_DEV_INITRD
+#ifdef CONFIG_INITRAMFS
 	setup_initrd();
 #endif
 
diff --git a/arch/hexagon/configs/comet_defconfig b/arch/hexagon/configs/comet_defconfig
index c6108f000288..9b05bbccc118 100644
--- a/arch/hexagon/configs/comet_defconfig
+++ b/arch/hexagon/configs/comet_defconfig
@@ -13,7 +13,7 @@ CONFIG_TASK_DELAY_ACCT=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=18
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_EXPERT=y
 # CONFIG_VM_EVENT_COUNTERS is not set
 # CONFIG_BLK_DEV_BSG is not set
diff --git a/arch/loongarch/configs/loongson3_defconfig b/arch/loongarch/configs/loongson3_defconfig
index 34eaee0384c9..184271a2df88 100644
--- a/arch/loongarch/configs/loongson3_defconfig
+++ b/arch/loongarch/configs/loongson3_defconfig
@@ -40,7 +40,7 @@ CONFIG_USER_NS=y
 CONFIG_CHECKPOINT_RESTORE=y
 CONFIG_SCHED_AUTOGROUP=y
 CONFIG_RELAY=y
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_EXPERT=y
 CONFIG_KALLSYMS_ALL=y
 CONFIG_PERF_EVENTS=y
diff --git a/arch/m68k/configs/amiga_defconfig b/arch/m68k/configs/amiga_defconfig
index 5171bb183967..1c2fe699ccfa 100644
--- a/arch/m68k/configs/amiga_defconfig
+++ b/arch/m68k/configs/amiga_defconfig
@@ -8,7 +8,7 @@ CONFIG_LOG_BUF_SHIFT=16
 # CONFIG_IPC_NS is not set
 # CONFIG_PID_NS is not set
 # CONFIG_NET_NS is not set
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_KEXEC=y
 CONFIG_BOOTINFO_PROC=y
diff --git a/arch/m68k/configs/apollo_defconfig b/arch/m68k/configs/apollo_defconfig
index 16f343ae48c6..81450d75a900 100644
--- a/arch/m68k/configs/apollo_defconfig
+++ b/arch/m68k/configs/apollo_defconfig
@@ -8,7 +8,7 @@ CONFIG_LOG_BUF_SHIFT=16
 # CONFIG_IPC_NS is not set
 # CONFIG_PID_NS is not set
 # CONFIG_NET_NS is not set
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_KEXEC=y
 CONFIG_BOOTINFO_PROC=y
diff --git a/arch/m68k/configs/atari_defconfig b/arch/m68k/configs/atari_defconfig
index c08788728ea9..0c315b683ad3 100644
--- a/arch/m68k/configs/atari_defconfig
+++ b/arch/m68k/configs/atari_defconfig
@@ -8,7 +8,7 @@ CONFIG_LOG_BUF_SHIFT=16
 # CONFIG_IPC_NS is not set
 # CONFIG_PID_NS is not set
 # CONFIG_NET_NS is not set
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_KEXEC=y
 CONFIG_BOOTINFO_PROC=y
diff --git a/arch/m68k/configs/bvme6000_defconfig b/arch/m68k/configs/bvme6000_defconfig
index 962497e7c53f..9dab3f18ba11 100644
--- a/arch/m68k/configs/bvme6000_defconfig
+++ b/arch/m68k/configs/bvme6000_defconfig
@@ -8,7 +8,7 @@ CONFIG_LOG_BUF_SHIFT=16
 # CONFIG_IPC_NS is not set
 # CONFIG_PID_NS is not set
 # CONFIG_NET_NS is not set
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_KEXEC=y
 CONFIG_BOOTINFO_PROC=y
diff --git a/arch/m68k/configs/hp300_defconfig b/arch/m68k/configs/hp300_defconfig
index ec28650189e4..64a445fd2d11 100644
--- a/arch/m68k/configs/hp300_defconfig
+++ b/arch/m68k/configs/hp300_defconfig
@@ -8,7 +8,7 @@ CONFIG_LOG_BUF_SHIFT=16
 # CONFIG_IPC_NS is not set
 # CONFIG_PID_NS is not set
 # CONFIG_NET_NS is not set
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_KEXEC=y
 CONFIG_BOOTINFO_PROC=y
diff --git a/arch/m68k/configs/mac_defconfig b/arch/m68k/configs/mac_defconfig
index 0afb3ad180de..f5d8e0c800b5 100644
--- a/arch/m68k/configs/mac_defconfig
+++ b/arch/m68k/configs/mac_defconfig
@@ -8,7 +8,7 @@ CONFIG_LOG_BUF_SHIFT=16
 # CONFIG_IPC_NS is not set
 # CONFIG_PID_NS is not set
 # CONFIG_NET_NS is not set
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_KEXEC=y
 CONFIG_BOOTINFO_PROC=y
diff --git a/arch/m68k/configs/multi_defconfig b/arch/m68k/configs/multi_defconfig
index b311e953995d..84fd59d68030 100644
--- a/arch/m68k/configs/multi_defconfig
+++ b/arch/m68k/configs/multi_defconfig
@@ -8,7 +8,7 @@ CONFIG_LOG_BUF_SHIFT=16
 # CONFIG_IPC_NS is not set
 # CONFIG_PID_NS is not set
 # CONFIG_NET_NS is not set
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_KEXEC=y
 CONFIG_BOOTINFO_PROC=y
diff --git a/arch/m68k/configs/mvme147_defconfig b/arch/m68k/configs/mvme147_defconfig
index f4e6224f137f..ef7423bfc3ab 100644
--- a/arch/m68k/configs/mvme147_defconfig
+++ b/arch/m68k/configs/mvme147_defconfig
@@ -8,7 +8,7 @@ CONFIG_LOG_BUF_SHIFT=16
 # CONFIG_IPC_NS is not set
 # CONFIG_PID_NS is not set
 # CONFIG_NET_NS is not set
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_KEXEC=y
 CONFIG_BOOTINFO_PROC=y
diff --git a/arch/m68k/configs/mvme16x_defconfig b/arch/m68k/configs/mvme16x_defconfig
index 498e167222f1..ae13dc57ba38 100644
--- a/arch/m68k/configs/mvme16x_defconfig
+++ b/arch/m68k/configs/mvme16x_defconfig
@@ -8,7 +8,7 @@ CONFIG_LOG_BUF_SHIFT=16
 # CONFIG_IPC_NS is not set
 # CONFIG_PID_NS is not set
 # CONFIG_NET_NS is not set
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_KEXEC=y
 CONFIG_BOOTINFO_PROC=y
diff --git a/arch/m68k/configs/q40_defconfig b/arch/m68k/configs/q40_defconfig
index 8c6b1eef8534..33cb51afc5ab 100644
--- a/arch/m68k/configs/q40_defconfig
+++ b/arch/m68k/configs/q40_defconfig
@@ -8,7 +8,7 @@ CONFIG_LOG_BUF_SHIFT=16
 # CONFIG_IPC_NS is not set
 # CONFIG_PID_NS is not set
 # CONFIG_NET_NS is not set
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_KEXEC=y
 CONFIG_BOOTINFO_PROC=y
diff --git a/arch/m68k/configs/stmark2_defconfig b/arch/m68k/configs/stmark2_defconfig
index 7787a4dd7c3c..fe4df7b37541 100644
--- a/arch/m68k/configs/stmark2_defconfig
+++ b/arch/m68k/configs/stmark2_defconfig
@@ -3,7 +3,7 @@ CONFIG_DEFAULT_HOSTNAME="stmark2"
 CONFIG_SYSVIPC=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_NAMESPACES=y
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 # CONFIG_FHANDLE is not set
 # CONFIG_AIO is not set
diff --git a/arch/m68k/configs/sun3_defconfig b/arch/m68k/configs/sun3_defconfig
index c34648f299ef..ecc343a1ddf7 100644
--- a/arch/m68k/configs/sun3_defconfig
+++ b/arch/m68k/configs/sun3_defconfig
@@ -8,7 +8,7 @@ CONFIG_LOG_BUF_SHIFT=16
 # CONFIG_IPC_NS is not set
 # CONFIG_PID_NS is not set
 # CONFIG_NET_NS is not set
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_KEXEC=y
 CONFIG_BOOTINFO_PROC=y
diff --git a/arch/m68k/configs/sun3x_defconfig b/arch/m68k/configs/sun3x_defconfig
index 73810d14660f..48dbab7923ee 100644
--- a/arch/m68k/configs/sun3x_defconfig
+++ b/arch/m68k/configs/sun3x_defconfig
@@ -8,7 +8,7 @@ CONFIG_LOG_BUF_SHIFT=16
 # CONFIG_IPC_NS is not set
 # CONFIG_PID_NS is not set
 # CONFIG_NET_NS is not set
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_KEXEC=y
 CONFIG_BOOTINFO_PROC=y
diff --git a/arch/m68k/kernel/setup_mm.c b/arch/m68k/kernel/setup_mm.c
index b9c9b2e3a150..458836f3a273 100644
--- a/arch/m68k/kernel/setup_mm.c
+++ b/arch/m68k/kernel/setup_mm.c
@@ -327,12 +327,12 @@ void __init setup_arch(char **cmdline_p)
 		panic("No configuration setup");
 	}
 
-	if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) && m68k_ramdisk.size)
+	if (IS_ENABLED(CONFIG_INITRAMFS) && m68k_ramdisk.size)
 		memblock_reserve(m68k_ramdisk.addr, m68k_ramdisk.size);
 
 	paging_init();
 
-	if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) && m68k_ramdisk.size) {
+	if (IS_ENABLED(CONFIG_INITRAMFS) && m68k_ramdisk.size) {
 		virt_external_initramfs_start = (unsigned long)phys_to_virt(m68k_ramdisk.addr);
 		virt_external_initramfs_end = virt_external_initramfs_start + m68k_ramdisk.size;
 		pr_info("initrd: %08lx - %08lx\n", virt_external_initramfs_start, virt_external_initramfs_end);
diff --git a/arch/m68k/kernel/setup_no.c b/arch/m68k/kernel/setup_no.c
index 6d3d5a299383..68090c9b4e1f 100644
--- a/arch/m68k/kernel/setup_no.c
+++ b/arch/m68k/kernel/setup_no.c
@@ -154,11 +154,11 @@ void __init setup_arch(char **cmdline_p)
 	min_low_pfn = PFN_DOWN(memory_start);
 	max_pfn = max_low_pfn = PFN_DOWN(memory_end);
 
-#if defined(CONFIG_UBOOT) && defined(CONFIG_BLK_DEV_INITRD)
+#if defined(CONFIG_UBOOT) && defined(CONFIG_INITRAMFS)
 	if ((virt_external_initramfs_start > 0) && (virt_external_initramfs_start < virt_external_initramfs_end) &&
 			(virt_external_initramfs_end < memory_end))
 		memblock_reserve(virt_external_initramfs_start, virt_external_initramfs_end - virt_external_initramfs_start);
-#endif /* if defined(CONFIG_BLK_DEV_INITRD) */
+#endif /* if defined(CONFIG_INITRAMFS) */
 
 	/*
 	 * Get kmalloc into gear.
diff --git a/arch/m68k/kernel/uboot.c b/arch/m68k/kernel/uboot.c
index 416e3f8f879d..43d7749867ed 100644
--- a/arch/m68k/kernel/uboot.c
+++ b/arch/m68k/kernel/uboot.c
@@ -64,9 +64,9 @@ static void __init parse_uboot_commandline(char *commandp, int size)
 	extern unsigned long _init_sp;
 	unsigned long *sp;
 	unsigned long uboot_cmd_start, uboot_cmd_end;
-#if defined(CONFIG_BLK_DEV_INITRD)
+#if defined(CONFIG_INITRAMFS)
 	unsigned long uboot_initrd_start, uboot_initrd_end;
-#endif /* if defined(CONFIG_BLK_DEV_INITRD) */
+#endif /* if defined(CONFIG_INITRAMFS) */
 
 	sp = (unsigned long *)_init_sp;
 	uboot_cmd_start = sp[4];
@@ -75,7 +75,7 @@ static void __init parse_uboot_commandline(char *commandp, int size)
 	if (uboot_cmd_start && uboot_cmd_end)
 		strscpy(commandp, (const char *)uboot_cmd_start, size);
 
-#if defined(CONFIG_BLK_DEV_INITRD)
+#if defined(CONFIG_INITRAMFS)
 	uboot_initrd_start = sp[2];
 	uboot_initrd_end = sp[3];
 
@@ -85,7 +85,7 @@ static void __init parse_uboot_commandline(char *commandp, int size)
 		virt_external_initramfs_end = uboot_initrd_end;
 		pr_info("initrd at 0x%lx:0x%lx\n", virt_external_initramfs_start, virt_external_initramfs_end);
 	}
-#endif /* if defined(CONFIG_BLK_DEV_INITRD) */
+#endif /* if defined(CONFIG_INITRAMFS) */
 }
 
 __init void process_uboot_commandline(char *commandp, int size)
diff --git a/arch/microblaze/mm/init.c b/arch/microblaze/mm/init.c
index f54d71160712..f6bc9d9a7f73 100644
--- a/arch/microblaze/mm/init.c
+++ b/arch/microblaze/mm/init.c
@@ -200,14 +200,14 @@ asmlinkage void __init mmu_init(void)
 	ksize = PAGE_ALIGN(((u32)_end - (u32)CONFIG_KERNEL_START));
 	memblock_reserve(kstart, ksize);
 
-#if defined(CONFIG_BLK_DEV_INITRD)
+#if defined(CONFIG_INITRAMFS)
 	/* Remove the init RAM disk from the available memory. */
 	if (virt_external_initramfs_start) {
 		unsigned long size;
 		size = virt_external_initramfs_end - virt_external_initramfs_start;
 		memblock_reserve(__virt_to_phys(virt_external_initramfs_start), size);
 	}
-#endif /* CONFIG_BLK_DEV_INITRD */
+#endif /* CONFIG_INITRAMFS */
 
 	/* Initialize the MMU hardware */
 	mmu_init_hw();
diff --git a/arch/mips/ath79/prom.c b/arch/mips/ath79/prom.c
index fcb45fe198a0..fe08038a1a70 100644
--- a/arch/mips/ath79/prom.c
+++ b/arch/mips/ath79/prom.c
@@ -23,7 +23,7 @@ void __init prom_init(void)
 {
 	fw_init_cmdline();
 
-#ifdef CONFIG_BLK_DEV_INITRD
+#ifdef CONFIG_INITRAMFS
 	/* Read the initrd address from the firmware environment */
 	virt_external_initramfs_start = fw_getenvl("initrd_start");
 	if (virt_external_initramfs_start) {
diff --git a/arch/mips/configs/ath25_defconfig b/arch/mips/configs/ath25_defconfig
index 1d939ba9738d..cb16a1f18db8 100644
--- a/arch/mips/configs/ath25_defconfig
+++ b/arch/mips/configs/ath25_defconfig
@@ -2,7 +2,7 @@
 CONFIG_SYSVIPC=y
 # CONFIG_CROSS_MEMORY_ATTACH is not set
 CONFIG_HIGH_RES_TIMERS=y
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 # CONFIG_RD_GZIP is not set
 # CONFIG_RD_BZIP2 is not set
 # CONFIG_RD_XZ is not set
diff --git a/arch/mips/configs/ath79_defconfig b/arch/mips/configs/ath79_defconfig
index cba0b85c6707..014bb1107b86 100644
--- a/arch/mips/configs/ath79_defconfig
+++ b/arch/mips/configs/ath79_defconfig
@@ -1,7 +1,7 @@
 # CONFIG_LOCALVERSION_AUTO is not set
 CONFIG_SYSVIPC=y
 CONFIG_HIGH_RES_TIMERS=y
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 # CONFIG_RD_GZIP is not set
 # CONFIG_AIO is not set
 # CONFIG_KALLSYMS is not set
diff --git a/arch/mips/configs/bcm47xx_defconfig b/arch/mips/configs/bcm47xx_defconfig
index f56e8db5da95..1eaf876e1be3 100644
--- a/arch/mips/configs/bcm47xx_defconfig
+++ b/arch/mips/configs/bcm47xx_defconfig
@@ -1,6 +1,6 @@
 CONFIG_SYSVIPC=y
 CONFIG_HIGH_RES_TIMERS=y
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_EXPERT=y
 CONFIG_BCM47XX=y
diff --git a/arch/mips/configs/bigsur_defconfig b/arch/mips/configs/bigsur_defconfig
index 97d2cd997285..176d4d852830 100644
--- a/arch/mips/configs/bigsur_defconfig
+++ b/arch/mips/configs/bigsur_defconfig
@@ -15,7 +15,7 @@ CONFIG_LOG_BUF_SHIFT=16
 CONFIG_NAMESPACES=y
 CONFIG_USER_NS=y
 CONFIG_RELAY=y
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_EXPERT=y
 CONFIG_SIBYTE_BIGSUR=y
 CONFIG_64BIT=y
diff --git a/arch/mips/configs/bmips_be_defconfig b/arch/mips/configs/bmips_be_defconfig
index daef132d000b..c12696b028bf 100644
--- a/arch/mips/configs/bmips_be_defconfig
+++ b/arch/mips/configs/bmips_be_defconfig
@@ -1,7 +1,7 @@
 # CONFIG_LOCALVERSION_AUTO is not set
 # CONFIG_SWAP is not set
 CONFIG_NO_HZ=y
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_EXPERT=y
 # CONFIG_VM_EVENT_COUNTERS is not set
 # CONFIG_SLUB_DEBUG is not set
diff --git a/arch/mips/configs/bmips_stb_defconfig b/arch/mips/configs/bmips_stb_defconfig
index cd0dc37c3d84..ed4d4be772be 100644
--- a/arch/mips/configs/bmips_stb_defconfig
+++ b/arch/mips/configs/bmips_stb_defconfig
@@ -2,7 +2,7 @@
 # CONFIG_SWAP is not set
 CONFIG_NO_HZ=y
 CONFIG_HZ=1000
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_EXPERT=y
 # CONFIG_VM_EVENT_COUNTERS is not set
 # CONFIG_SLUB_DEBUG is not set
diff --git a/arch/mips/configs/cavium_octeon_defconfig b/arch/mips/configs/cavium_octeon_defconfig
index 3f50e1d78894..99299b10adf3 100644
--- a/arch/mips/configs/cavium_octeon_defconfig
+++ b/arch/mips/configs/cavium_octeon_defconfig
@@ -7,7 +7,7 @@ CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_RELAY=y
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_EXPERT=y
 CONFIG_CAVIUM_OCTEON_SOC=y
 CONFIG_CAVIUM_CN63XXP1=y
diff --git a/arch/mips/configs/eyeq5_defconfig b/arch/mips/configs/eyeq5_defconfig
index 6688f56aba1c..051133d4665d 100644
--- a/arch/mips/configs/eyeq5_defconfig
+++ b/arch/mips/configs/eyeq5_defconfig
@@ -16,7 +16,7 @@ CONFIG_CGROUP_CPUACCT=y
 CONFIG_NAMESPACES=y
 CONFIG_USER_NS=y
 CONFIG_SCHED_AUTOGROUP=y
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_EXPERT=y
 CONFIG_EYEQ=y
 CONFIG_FIT_IMAGE_FDT_EPM5=y
diff --git a/arch/mips/configs/eyeq6_defconfig b/arch/mips/configs/eyeq6_defconfig
index 0a00a201937b..732f0ed7fef5 100644
--- a/arch/mips/configs/eyeq6_defconfig
+++ b/arch/mips/configs/eyeq6_defconfig
@@ -17,7 +17,7 @@ CONFIG_CGROUP_CPUACCT=y
 CONFIG_NAMESPACES=y
 CONFIG_USER_NS=y
 CONFIG_SCHED_AUTOGROUP=y
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_EXPERT=y
 CONFIG_EYEQ=y
 CONFIG_MACH_EYEQ6H=y
diff --git a/arch/mips/configs/generic_defconfig b/arch/mips/configs/generic_defconfig
index fa916407bdd4..05752c7edb43 100644
--- a/arch/mips/configs/generic_defconfig
+++ b/arch/mips/configs/generic_defconfig
@@ -13,7 +13,7 @@ CONFIG_CGROUP_CPUACCT=y
 CONFIG_NAMESPACES=y
 CONFIG_USER_NS=y
 CONFIG_SCHED_AUTOGROUP=y
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_BPF_SYSCALL=y
 CONFIG_USERFAULTFD=y
 CONFIG_EXPERT=y
diff --git a/arch/mips/configs/gpr_defconfig b/arch/mips/configs/gpr_defconfig
index 437ef6dc0b4c..cc7c44059f0b 100644
--- a/arch/mips/configs/gpr_defconfig
+++ b/arch/mips/configs/gpr_defconfig
@@ -6,7 +6,7 @@ CONFIG_PREEMPT_VOLUNTARY=y
 CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_BSD_PROCESS_ACCT_V3=y
 CONFIG_RELAY=y
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_EXPERT=y
 CONFIG_PROFILING=y
 CONFIG_MIPS_ALCHEMY=y
diff --git a/arch/mips/configs/lemote2f_defconfig b/arch/mips/configs/lemote2f_defconfig
index 5038a27d035f..9c94b66f6dc7 100644
--- a/arch/mips/configs/lemote2f_defconfig
+++ b/arch/mips/configs/lemote2f_defconfig
@@ -9,7 +9,7 @@ CONFIG_BSD_PROCESS_ACCT_V3=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=15
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_EXPERT=y
 CONFIG_PROFILING=y
 CONFIG_KEXEC=y
diff --git a/arch/mips/configs/loongson2k_defconfig b/arch/mips/configs/loongson2k_defconfig
index 0cc665d3ea34..9f4342894ed9 100644
--- a/arch/mips/configs/loongson2k_defconfig
+++ b/arch/mips/configs/loongson2k_defconfig
@@ -17,7 +17,7 @@ CONFIG_BLK_CGROUP=y
 CONFIG_SCHED_AUTOGROUP=y
 CONFIG_SYSFS_DEPRECATED=y
 CONFIG_RELAY=y
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_EXPERT=y
 CONFIG_MACH_LOONGSON64=y
 # CONFIG_CPU_LOONGSON3_CPUCFG_EMULATION is not set
diff --git a/arch/mips/configs/loongson3_defconfig b/arch/mips/configs/loongson3_defconfig
index 240efff37d98..51d67ac3ca94 100644
--- a/arch/mips/configs/loongson3_defconfig
+++ b/arch/mips/configs/loongson3_defconfig
@@ -25,7 +25,7 @@ CONFIG_NAMESPACES=y
 CONFIG_USER_NS=y
 CONFIG_SCHED_AUTOGROUP=y
 CONFIG_RELAY=y
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_EXPERT=y
 CONFIG_PERF_EVENTS=y
 CONFIG_KEXEC=y
diff --git a/arch/mips/configs/malta_defconfig b/arch/mips/configs/malta_defconfig
index 9fcbac829920..201295eff80e 100644
--- a/arch/mips/configs/malta_defconfig
+++ b/arch/mips/configs/malta_defconfig
@@ -4,7 +4,7 @@ CONFIG_HIGH_RES_TIMERS=y
 CONFIG_LOG_BUF_SHIFT=15
 CONFIG_NAMESPACES=y
 CONFIG_RELAY=y
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_EXPERT=y
 # CONFIG_COMPAT_BRK is not set
 CONFIG_MIPS_MALTA=y
diff --git a/arch/mips/configs/mtx1_defconfig b/arch/mips/configs/mtx1_defconfig
index 2707ab134639..0e7ab562059e 100644
--- a/arch/mips/configs/mtx1_defconfig
+++ b/arch/mips/configs/mtx1_defconfig
@@ -6,7 +6,7 @@ CONFIG_PREEMPT_VOLUNTARY=y
 CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_BSD_PROCESS_ACCT_V3=y
 CONFIG_RELAY=y
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_EXPERT=y
 CONFIG_PROFILING=y
 CONFIG_MIPS_ALCHEMY=y
diff --git a/arch/mips/configs/rb532_defconfig b/arch/mips/configs/rb532_defconfig
index 30d18b084cda..5e02919bb793 100644
--- a/arch/mips/configs/rb532_defconfig
+++ b/arch/mips/configs/rb532_defconfig
@@ -6,7 +6,7 @@ CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=14
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_EXPERT=y
 # CONFIG_ELF_CORE is not set
 # CONFIG_KALLSYMS is not set
diff --git a/arch/mips/configs/rbtx49xx_defconfig b/arch/mips/configs/rbtx49xx_defconfig
index 03a7bbe28a53..c446f389c0a2 100644
--- a/arch/mips/configs/rbtx49xx_defconfig
+++ b/arch/mips/configs/rbtx49xx_defconfig
@@ -4,7 +4,7 @@ CONFIG_HIGH_RES_TIMERS=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=14
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_EXPERT=y
 # CONFIG_EPOLL is not set
 CONFIG_MACH_TX49XX=y
diff --git a/arch/mips/configs/rt305x_defconfig b/arch/mips/configs/rt305x_defconfig
index 8f9701efef19..bf4dd5930876 100644
--- a/arch/mips/configs/rt305x_defconfig
+++ b/arch/mips/configs/rt305x_defconfig
@@ -2,7 +2,7 @@
 CONFIG_SYSVIPC=y
 # CONFIG_CROSS_MEMORY_ATTACH is not set
 CONFIG_HIGH_RES_TIMERS=y
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 # CONFIG_RD_GZIP is not set
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 # CONFIG_AIO is not set
diff --git a/arch/mips/configs/sb1250_swarm_defconfig b/arch/mips/configs/sb1250_swarm_defconfig
index ae2afff00e01..576421f8b669 100644
--- a/arch/mips/configs/sb1250_swarm_defconfig
+++ b/arch/mips/configs/sb1250_swarm_defconfig
@@ -7,7 +7,7 @@ CONFIG_CPUSETS=y
 CONFIG_CGROUP_CPUACCT=y
 CONFIG_NAMESPACES=y
 CONFIG_RELAY=y
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_EXPERT=y
 # CONFIG_COMPAT_BRK is not set
 CONFIG_SIBYTE_SWARM=y
diff --git a/arch/mips/configs/xway_defconfig b/arch/mips/configs/xway_defconfig
index aae8497b6872..41d0d7d8cb6c 100644
--- a/arch/mips/configs/xway_defconfig
+++ b/arch/mips/configs/xway_defconfig
@@ -2,7 +2,7 @@
 CONFIG_SYSVIPC=y
 # CONFIG_CROSS_MEMORY_ATTACH is not set
 CONFIG_HIGH_RES_TIMERS=y
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 # CONFIG_RD_GZIP is not set
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 # CONFIG_AIO is not set
diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 47dc7eb99ef7..b47bc52db75b 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -115,7 +115,7 @@ void __init detect_memory_region(phys_addr_t start, phys_addr_t sz_min, phys_add
 /*
  * Manage initrd
  */
-#ifdef CONFIG_BLK_DEV_INITRD
+#ifdef CONFIG_INITRAMFS
 
 static int __init rd_start_early(char *p)
 {
@@ -236,7 +236,7 @@ static void __init finalize_initrd(void)
 	virt_external_initramfs_end = 0;
 }
 
-#else  /* !CONFIG_BLK_DEV_INITRD */
+#else  /* !CONFIG_INITRAMFS */
 
 static unsigned long __init init_initrd(void)
 {
diff --git a/arch/mips/sibyte/common/cfe.c b/arch/mips/sibyte/common/cfe.c
index 642b7d615594..ee62bf0e0320 100644
--- a/arch/mips/sibyte/common/cfe.c
+++ b/arch/mips/sibyte/common/cfe.c
@@ -37,7 +37,7 @@
 
 int cfe_cons_handle;
 
-#ifdef CONFIG_BLK_DEV_INITRD
+#ifdef CONFIG_INITRAMFS
 extern unsigned long virt_external_initramfs_start, virt_external_initramfs_end;
 #endif
 
@@ -82,7 +82,7 @@ static __init void prom_meminit(void)
 	int mem_flags = 0;
 	unsigned int idx;
 	int rd_flag;
-#ifdef CONFIG_BLK_DEV_INITRD
+#ifdef CONFIG_INITRAMFS
 	unsigned long initrd_pstart;
 	unsigned long initrd_pend;
 
@@ -104,7 +104,7 @@ static __init void prom_meminit(void)
 			 * See if this block contains (any portion of) the
 			 * ramdisk
 			 */
-#ifdef CONFIG_BLK_DEV_INITRD
+#ifdef CONFIG_INITRAMFS
 			if (virt_external_initramfs_start) {
 				if ((initrd_pstart > addr) &&
 				    (initrd_pstart < (addr + size))) {
@@ -138,7 +138,7 @@ static __init void prom_meminit(void)
 			}
 		}
 	}
-#ifdef CONFIG_BLK_DEV_INITRD
+#ifdef CONFIG_INITRAMFS
 	if (virt_external_initramfs_start) {
 		memblock_add(initrd_pstart, initrd_pend - initrd_pstart);
 		memblock_reserve(initrd_pstart, initrd_pend - initrd_pstart);
@@ -146,7 +146,7 @@ static __init void prom_meminit(void)
 #endif
 }
 
-#ifdef CONFIG_BLK_DEV_INITRD
+#ifdef CONFIG_INITRAMFS
 static int __init initrd_setup(char *str)
 {
 	char rdarg[64];
@@ -266,7 +266,7 @@ void __init prom_init(void)
 		}
 	}
 
-#ifdef CONFIG_BLK_DEV_INITRD
+#ifdef CONFIG_INITRAMFS
 	{
 		char *ptr;
 		/* Need to find out early whether we've got an initrd.	So scan
@@ -285,7 +285,7 @@ void __init prom_init(void)
 			}
 		}
 	}
-#endif /* CONFIG_BLK_DEV_INITRD */
+#endif /* CONFIG_INITRAMFS */
 
 	/* Not sure this is needed, but it's the safe way. */
 	arcs_cmdline[COMMAND_LINE_SIZE-1] = 0;
diff --git a/arch/nios2/kernel/setup.c b/arch/nios2/kernel/setup.c
index d3d60c42df46..d4f5aa29be4e 100644
--- a/arch/nios2/kernel/setup.c
+++ b/arch/nios2/kernel/setup.c
@@ -107,12 +107,12 @@ asmlinkage void __init nios2_boot_init(unsigned r4, unsigned r5, unsigned r6,
 
 #if defined(CONFIG_NIOS2_PASS_CMDLINE)
 	if (r4 == 0x534f494e) { /* r4 is magic NIOS */
-#if defined(CONFIG_BLK_DEV_INITRD)
+#if defined(CONFIG_INITRAMFS)
 		if (r5) { /* initramfs */
 			virt_external_initramfs_start = r5;
 			virt_external_initramfs_end = r6;
 		}
-#endif /* CONFIG_BLK_DEV_INITRD */
+#endif /* CONFIG_INITRAMFS */
 		dtb_passed = r6;
 
 		if (r7)
@@ -160,12 +160,12 @@ void __init setup_arch(char **cmdline_p)
 	find_limits(&min_low_pfn, &max_low_pfn, &max_pfn);
 
 	memblock_reserve(__pa_symbol(_stext), _end - _stext);
-#ifdef CONFIG_BLK_DEV_INITRD
+#ifdef CONFIG_INITRAMFS
 	if (virt_external_initramfs_start) {
 		memblock_reserve(virt_to_phys((void *)virt_external_initramfs_start),
 				virt_external_initramfs_end - virt_external_initramfs_start);
 	}
-#endif /* CONFIG_BLK_DEV_INITRD */
+#endif /* CONFIG_INITRAMFS */
 
 	early_init_fdt_reserve_self();
 	early_init_fdt_scan_reserved_mem();
diff --git a/arch/openrisc/configs/or1klitex_defconfig b/arch/openrisc/configs/or1klitex_defconfig
index 3e849d25838a..2a1daa87af49 100644
--- a/arch/openrisc/configs/or1klitex_defconfig
+++ b/arch/openrisc/configs/or1klitex_defconfig
@@ -3,7 +3,7 @@ CONFIG_POSIX_MQUEUE=y
 CONFIG_CGROUPS=y
 CONFIG_NAMESPACES=y
 CONFIG_USER_NS=y
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_SGETMASK_SYSCALL=y
 CONFIG_EXPERT=y
diff --git a/arch/openrisc/configs/or1ksim_defconfig b/arch/openrisc/configs/or1ksim_defconfig
index 59fe33cefba2..96578bfb7159 100644
--- a/arch/openrisc/configs/or1ksim_defconfig
+++ b/arch/openrisc/configs/or1ksim_defconfig
@@ -1,6 +1,6 @@
 CONFIG_NO_HZ=y
 CONFIG_LOG_BUF_SHIFT=14
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 # CONFIG_RD_GZIP is not set
 CONFIG_EXPERT=y
 # CONFIG_KALLSYMS is not set
diff --git a/arch/openrisc/configs/simple_smp_defconfig b/arch/openrisc/configs/simple_smp_defconfig
index 6008e824d31c..f7c807b32d50 100644
--- a/arch/openrisc/configs/simple_smp_defconfig
+++ b/arch/openrisc/configs/simple_smp_defconfig
@@ -1,7 +1,7 @@
 CONFIG_LOCALVERSION="-simple-smp"
 CONFIG_NO_HZ=y
 CONFIG_LOG_BUF_SHIFT=14
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 # CONFIG_RD_GZIP is not set
 # CONFIG_RD_BZIP2 is not set
 # CONFIG_RD_LZMA is not set
diff --git a/arch/openrisc/configs/virt_defconfig b/arch/openrisc/configs/virt_defconfig
index c1b69166c500..d542c69075bf 100644
--- a/arch/openrisc/configs/virt_defconfig
+++ b/arch/openrisc/configs/virt_defconfig
@@ -3,7 +3,7 @@ CONFIG_POSIX_MQUEUE=y
 CONFIG_NO_HZ_IDLE=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_CGROUPS=y
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_OPENRISC_HAVE_INST_CMOV=y
 CONFIG_OPENRISC_HAVE_INST_ROR=y
 CONFIG_OPENRISC_HAVE_INST_RORI=y
diff --git a/arch/openrisc/kernel/setup.c b/arch/openrisc/kernel/setup.c
index 27ae87c09b0e..82e586881c89 100644
--- a/arch/openrisc/kernel/setup.c
+++ b/arch/openrisc/kernel/setup.c
@@ -75,7 +75,7 @@ static void __init setup_memory(void)
 	 */
 	memblock_reserve(__pa(_stext), _end - _stext);
 
-#ifdef CONFIG_BLK_DEV_INITRD
+#ifdef CONFIG_INITRAMFS
 	/* Then reserve the initrd, if any */
 	if (virt_external_initramfs_start && (virt_external_initramfs_end > virt_external_initramfs_start)) {
 		unsigned long aligned_start = ALIGN_DOWN(virt_external_initramfs_start, PAGE_SIZE);
@@ -83,7 +83,7 @@ static void __init setup_memory(void)
 
 		memblock_reserve(__pa(aligned_start), aligned_end - aligned_start);
 	}
-#endif /* CONFIG_BLK_DEV_INITRD */
+#endif /* CONFIG_INITRAMFS */
 
 	early_init_fdt_reserve_self();
 	early_init_fdt_scan_reserved_mem();
@@ -238,7 +238,7 @@ void __init setup_arch(char **cmdline_p)
 	/* process 1's initial memory region is the kernel code/data */
 	setup_initial_init_mm(_stext, _etext, _edata, _end);
 
-#ifdef CONFIG_BLK_DEV_INITRD
+#ifdef CONFIG_INITRAMFS
 	if (virt_external_initramfs_start == virt_external_initramfs_end) {
 		printk(KERN_INFO "Initial ramdisk not found\n");
 		virt_external_initramfs_start = 0;
diff --git a/arch/openrisc/kernel/vmlinux.h b/arch/openrisc/kernel/vmlinux.h
index bdea46c617c7..25c70ee6b930 100644
--- a/arch/openrisc/kernel/vmlinux.h
+++ b/arch/openrisc/kernel/vmlinux.h
@@ -2,7 +2,7 @@
 #ifndef __OPENRISC_VMLINUX_H_
 #define __OPENRISC_VMLINUX_H_
 
-#ifdef CONFIG_BLK_DEV_INITRD
+#ifdef CONFIG_INITRAMFS
 extern char __initrd_start, __initrd_end;
 #endif
 
diff --git a/arch/parisc/boot/compressed/misc.c b/arch/parisc/boot/compressed/misc.c
index 9c83bd06ef15..826daed4e8f3 100644
--- a/arch/parisc/boot/compressed/misc.c
+++ b/arch/parisc/boot/compressed/misc.c
@@ -323,7 +323,7 @@ asmlinkage unsigned long __visible decompress_kernel(unsigned int started_wide,
 	if (free_mem_end_ptr > ARTIFICIAL_LIMIT)
 		free_mem_end_ptr = ARTIFICIAL_LIMIT;
 
-#ifdef CONFIG_BLK_DEV_INITRD
+#ifdef CONFIG_INITRAMFS
 	/* if we have ramdisk this is at end of memory */
 	if (rd_start && rd_start < free_mem_end_ptr)
 		free_mem_end_ptr = rd_start;
diff --git a/arch/parisc/configs/generic-32bit_defconfig b/arch/parisc/configs/generic-32bit_defconfig
index 94928d114d4c..5523ff05b932 100644
--- a/arch/parisc/configs/generic-32bit_defconfig
+++ b/arch/parisc/configs/generic-32bit_defconfig
@@ -9,7 +9,7 @@ CONFIG_LOG_BUF_SHIFT=16
 CONFIG_CGROUPS=y
 CONFIG_NAMESPACES=y
 CONFIG_USER_NS=y
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_EXPERT=y
 CONFIG_PERF_EVENTS=y
 CONFIG_PA7100LC=y
diff --git a/arch/parisc/configs/generic-64bit_defconfig b/arch/parisc/configs/generic-64bit_defconfig
index d8cd7f858b2a..f631be899c75 100644
--- a/arch/parisc/configs/generic-64bit_defconfig
+++ b/arch/parisc/configs/generic-64bit_defconfig
@@ -18,7 +18,7 @@ CONFIG_CGROUP_PIDS=y
 CONFIG_CPUSETS=y
 CONFIG_USER_NS=y
 CONFIG_RELAY=y
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_SMP=y
 CONFIG_HPPB=y
diff --git a/arch/parisc/kernel/pdt.c b/arch/parisc/kernel/pdt.c
index 49982a48c92c..b11352e8e149 100644
--- a/arch/parisc/kernel/pdt.c
+++ b/arch/parisc/kernel/pdt.c
@@ -228,7 +228,7 @@ void __init pdc_pdt_init(void)
 		report_mem_err(pdt_entry[i]);
 
 		addr = pdt_entry[i] & PDT_ADDR_PHYS_MASK;
-		if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) &&
+		if (IS_ENABLED(CONFIG_INITRAMFS) &&
 			addr >= virt_external_initramfs_start && addr < virt_external_initramfs_end)
 			pr_crit("CRITICAL: initrd possibly broken "
 				"due to bad memory!\n");
diff --git a/arch/parisc/kernel/setup.c b/arch/parisc/kernel/setup.c
index 1e403c26070d..da4ffd7a5996 100644
--- a/arch/parisc/kernel/setup.c
+++ b/arch/parisc/kernel/setup.c
@@ -68,7 +68,7 @@ static void __init setup_cmdline(char **cmdline_p)
 	if (!strstr(p, "earlycon"))
 		strlcat(p, " earlycon=pdc", COMMAND_LINE_SIZE);
 
-#ifdef CONFIG_BLK_DEV_INITRD
+#ifdef CONFIG_INITRAMFS
 	/* did palo pass us a ramdisk? */
 	if (boot_args[2] != 0) {
 		virt_external_initramfs_start = (unsigned long)__va(boot_args[2]);
diff --git a/arch/parisc/mm/init.c b/arch/parisc/mm/init.c
index 5843f4a46e93..f6a4125e245e 100644
--- a/arch/parisc/mm/init.c
+++ b/arch/parisc/mm/init.c
@@ -297,7 +297,7 @@ static void __init setup_bootmem(void)
 	}
 #endif
 
-#ifdef CONFIG_BLK_DEV_INITRD
+#ifdef CONFIG_INITRAMFS
 	if (virt_external_initramfs_start) {
 		printk(KERN_INFO "initrd: %08lx-%08lx\n", virt_external_initramfs_start, virt_external_initramfs_end);
 		if (__pa(virt_external_initramfs_start) < mem_max) {
@@ -632,7 +632,7 @@ static void __init pagetable_init(void)
 			  size, PAGE_KERNEL, 0);
 	}
 
-#ifdef CONFIG_BLK_DEV_INITRD
+#ifdef CONFIG_INITRAMFS
 	if (virt_external_initramfs_end && virt_external_initramfs_end > mem_limit) {
 		printk(KERN_INFO "initrd: mapping %08lx-%08lx\n", virt_external_initramfs_start, virt_external_initramfs_end);
 		map_pages(virt_external_initramfs_start, __pa(virt_external_initramfs_start),
diff --git a/arch/powerpc/configs/44x/akebono_defconfig b/arch/powerpc/configs/44x/akebono_defconfig
index 1882eb2da354..db744569dc01 100644
--- a/arch/powerpc/configs/44x/akebono_defconfig
+++ b/arch/powerpc/configs/44x/akebono_defconfig
@@ -3,7 +3,7 @@ CONFIG_SMP=y
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
 CONFIG_LOG_BUF_SHIFT=14
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_EXPERT=y
 CONFIG_KALLSYMS_ALL=y
 # CONFIG_SLUB_CPU_PARTIAL is not set
diff --git a/arch/powerpc/configs/44x/arches_defconfig b/arch/powerpc/configs/44x/arches_defconfig
index 41d04e70d4fb..1732c9e22832 100644
--- a/arch/powerpc/configs/44x/arches_defconfig
+++ b/arch/powerpc/configs/44x/arches_defconfig
@@ -4,7 +4,7 @@ CONFIG_POSIX_MQUEUE=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_LOG_BUF_SHIFT=14
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_EXPERT=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
diff --git a/arch/powerpc/configs/44x/bamboo_defconfig b/arch/powerpc/configs/44x/bamboo_defconfig
index acbce718eaa8..b91d65645bd8 100644
--- a/arch/powerpc/configs/44x/bamboo_defconfig
+++ b/arch/powerpc/configs/44x/bamboo_defconfig
@@ -2,7 +2,7 @@ CONFIG_44x=y
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
 CONFIG_LOG_BUF_SHIFT=14
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_EXPERT=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
diff --git a/arch/powerpc/configs/44x/bluestone_defconfig b/arch/powerpc/configs/44x/bluestone_defconfig
index 37088f250c9e..bfa400e8e293 100644
--- a/arch/powerpc/configs/44x/bluestone_defconfig
+++ b/arch/powerpc/configs/44x/bluestone_defconfig
@@ -4,7 +4,7 @@ CONFIG_POSIX_MQUEUE=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_LOG_BUF_SHIFT=14
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_EXPERT=y
 # CONFIG_PCI_QUIRKS is not set
 # CONFIG_VM_EVENT_COUNTERS is not set
diff --git a/arch/powerpc/configs/44x/canyonlands_defconfig b/arch/powerpc/configs/44x/canyonlands_defconfig
index 61776ade572b..1c08d7a2a0e9 100644
--- a/arch/powerpc/configs/44x/canyonlands_defconfig
+++ b/arch/powerpc/configs/44x/canyonlands_defconfig
@@ -4,7 +4,7 @@ CONFIG_POSIX_MQUEUE=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_LOG_BUF_SHIFT=14
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_EXPERT=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
diff --git a/arch/powerpc/configs/44x/ebony_defconfig b/arch/powerpc/configs/44x/ebony_defconfig
index 93d2a4e64af9..55fc82c746da 100644
--- a/arch/powerpc/configs/44x/ebony_defconfig
+++ b/arch/powerpc/configs/44x/ebony_defconfig
@@ -2,7 +2,7 @@ CONFIG_44x=y
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
 CONFIG_LOG_BUF_SHIFT=14
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_EXPERT=y
 CONFIG_KALLSYMS_ALL=y
 CONFIG_MODULES=y
diff --git a/arch/powerpc/configs/44x/eiger_defconfig b/arch/powerpc/configs/44x/eiger_defconfig
index 509300f400e2..19a1c889e371 100644
--- a/arch/powerpc/configs/44x/eiger_defconfig
+++ b/arch/powerpc/configs/44x/eiger_defconfig
@@ -4,7 +4,7 @@ CONFIG_POSIX_MQUEUE=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_LOG_BUF_SHIFT=14
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_EXPERT=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
diff --git a/arch/powerpc/configs/44x/fsp2_defconfig b/arch/powerpc/configs/44x/fsp2_defconfig
index 5492537f4c6c..696f63bbc56e 100644
--- a/arch/powerpc/configs/44x/fsp2_defconfig
+++ b/arch/powerpc/configs/44x/fsp2_defconfig
@@ -8,7 +8,7 @@ CONFIG_HIGH_RES_TIMERS=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=16
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 # CONFIG_RD_LZMA is not set
 # CONFIG_RD_XZ is not set
 # CONFIG_RD_LZO is not set
diff --git a/arch/powerpc/configs/44x/icon_defconfig b/arch/powerpc/configs/44x/icon_defconfig
index fb9a15573546..2b255183a043 100644
--- a/arch/powerpc/configs/44x/icon_defconfig
+++ b/arch/powerpc/configs/44x/icon_defconfig
@@ -2,7 +2,7 @@ CONFIG_44x=y
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
 CONFIG_LOG_BUF_SHIFT=14
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_EXPERT=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
diff --git a/arch/powerpc/configs/44x/iss476-smp_defconfig b/arch/powerpc/configs/44x/iss476-smp_defconfig
index 0f6380e1e612..b467075f615d 100644
--- a/arch/powerpc/configs/44x/iss476-smp_defconfig
+++ b/arch/powerpc/configs/44x/iss476-smp_defconfig
@@ -3,7 +3,7 @@ CONFIG_SMP=y
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
 CONFIG_LOG_BUF_SHIFT=14
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_EXPERT=y
 CONFIG_KALLSYMS_ALL=y
 CONFIG_PROFILING=y
diff --git a/arch/powerpc/configs/44x/katmai_defconfig b/arch/powerpc/configs/44x/katmai_defconfig
index 1a0f1c3e0ee9..01ca50e54f78 100644
--- a/arch/powerpc/configs/44x/katmai_defconfig
+++ b/arch/powerpc/configs/44x/katmai_defconfig
@@ -2,7 +2,7 @@ CONFIG_44x=y
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
 CONFIG_LOG_BUF_SHIFT=14
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_EXPERT=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
diff --git a/arch/powerpc/configs/44x/rainier_defconfig b/arch/powerpc/configs/44x/rainier_defconfig
index 6dd67de06a0b..5e43c9cc19e0 100644
--- a/arch/powerpc/configs/44x/rainier_defconfig
+++ b/arch/powerpc/configs/44x/rainier_defconfig
@@ -2,7 +2,7 @@ CONFIG_44x=y
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
 CONFIG_LOG_BUF_SHIFT=14
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_EXPERT=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
diff --git a/arch/powerpc/configs/44x/redwood_defconfig b/arch/powerpc/configs/44x/redwood_defconfig
index e28d76416537..75d35213f171 100644
--- a/arch/powerpc/configs/44x/redwood_defconfig
+++ b/arch/powerpc/configs/44x/redwood_defconfig
@@ -4,7 +4,7 @@ CONFIG_POSIX_MQUEUE=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_LOG_BUF_SHIFT=14
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_EXPERT=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
diff --git a/arch/powerpc/configs/44x/sam440ep_defconfig b/arch/powerpc/configs/44x/sam440ep_defconfig
index 98221bda380d..b4bfbc3f9ed2 100644
--- a/arch/powerpc/configs/44x/sam440ep_defconfig
+++ b/arch/powerpc/configs/44x/sam440ep_defconfig
@@ -3,7 +3,7 @@ CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
 CONFIG_IKCONFIG=y
 CONFIG_LOG_BUF_SHIFT=14
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_EXPERT=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
diff --git a/arch/powerpc/configs/44x/sequoia_defconfig b/arch/powerpc/configs/44x/sequoia_defconfig
index b4984eab43eb..0f71035564eb 100644
--- a/arch/powerpc/configs/44x/sequoia_defconfig
+++ b/arch/powerpc/configs/44x/sequoia_defconfig
@@ -4,7 +4,7 @@ CONFIG_POSIX_MQUEUE=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_LOG_BUF_SHIFT=14
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_EXPERT=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
diff --git a/arch/powerpc/configs/44x/taishan_defconfig b/arch/powerpc/configs/44x/taishan_defconfig
index 3ea5932ab852..542711792c5c 100644
--- a/arch/powerpc/configs/44x/taishan_defconfig
+++ b/arch/powerpc/configs/44x/taishan_defconfig
@@ -2,7 +2,7 @@ CONFIG_44x=y
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
 CONFIG_LOG_BUF_SHIFT=14
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_EXPERT=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
diff --git a/arch/powerpc/configs/44x/warp_defconfig b/arch/powerpc/configs/44x/warp_defconfig
index 5757625469c4..8c014ef06789 100644
--- a/arch/powerpc/configs/44x/warp_defconfig
+++ b/arch/powerpc/configs/44x/warp_defconfig
@@ -5,7 +5,7 @@ CONFIG_SYSVIPC=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=14
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_EXPERT=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
diff --git a/arch/powerpc/configs/52xx/cm5200_defconfig b/arch/powerpc/configs/52xx/cm5200_defconfig
index 2412a6bf7ee6..41004a375d20 100644
--- a/arch/powerpc/configs/52xx/cm5200_defconfig
+++ b/arch/powerpc/configs/52xx/cm5200_defconfig
@@ -1,6 +1,6 @@
 CONFIG_SYSVIPC=y
 CONFIG_LOG_BUF_SHIFT=14
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_EXPERT=y
 # CONFIG_KALLSYMS is not set
 # CONFIG_EPOLL is not set
diff --git a/arch/powerpc/configs/52xx/lite5200b_defconfig b/arch/powerpc/configs/52xx/lite5200b_defconfig
index 7db479dcbc0c..ad7261b41c2c 100644
--- a/arch/powerpc/configs/52xx/lite5200b_defconfig
+++ b/arch/powerpc/configs/52xx/lite5200b_defconfig
@@ -2,7 +2,7 @@ CONFIG_SYSVIPC=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_LOG_BUF_SHIFT=14
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_EXPERT=y
 # CONFIG_KALLSYMS is not set
 # CONFIG_EPOLL is not set
diff --git a/arch/powerpc/configs/52xx/motionpro_defconfig b/arch/powerpc/configs/52xx/motionpro_defconfig
index 6186ead1e105..0b8a6dc46cf7 100644
--- a/arch/powerpc/configs/52xx/motionpro_defconfig
+++ b/arch/powerpc/configs/52xx/motionpro_defconfig
@@ -1,6 +1,6 @@
 CONFIG_SYSVIPC=y
 CONFIG_LOG_BUF_SHIFT=14
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_EXPERT=y
 # CONFIG_KALLSYMS is not set
 # CONFIG_EPOLL is not set
diff --git a/arch/powerpc/configs/52xx/tqm5200_defconfig b/arch/powerpc/configs/52xx/tqm5200_defconfig
index 688f703d8e22..c4e3705b1f22 100644
--- a/arch/powerpc/configs/52xx/tqm5200_defconfig
+++ b/arch/powerpc/configs/52xx/tqm5200_defconfig
@@ -1,6 +1,6 @@
 CONFIG_SYSVIPC=y
 CONFIG_LOG_BUF_SHIFT=14
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 # CONFIG_KALLSYMS is not set
 # CONFIG_EPOLL is not set
 CONFIG_EXPERT=y
diff --git a/arch/powerpc/configs/83xx/asp8347_defconfig b/arch/powerpc/configs/83xx/asp8347_defconfig
index 10192410b33c..2130a1edcc1a 100644
--- a/arch/powerpc/configs/83xx/asp8347_defconfig
+++ b/arch/powerpc/configs/83xx/asp8347_defconfig
@@ -3,7 +3,7 @@ CONFIG_SYSVIPC=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_LOG_BUF_SHIFT=14
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_EXPERT=y
 # CONFIG_KALLSYMS is not set
 CONFIG_MODULES=y
diff --git a/arch/powerpc/configs/83xx/mpc8313_rdb_defconfig b/arch/powerpc/configs/83xx/mpc8313_rdb_defconfig
index 16a42e2267fb..4d7a13903450 100644
--- a/arch/powerpc/configs/83xx/mpc8313_rdb_defconfig
+++ b/arch/powerpc/configs/83xx/mpc8313_rdb_defconfig
@@ -2,7 +2,7 @@ CONFIG_SYSVIPC=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_LOG_BUF_SHIFT=14
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_EXPERT=y
 # CONFIG_KALLSYMS is not set
 CONFIG_MODULES=y
diff --git a/arch/powerpc/configs/83xx/mpc8315_rdb_defconfig b/arch/powerpc/configs/83xx/mpc8315_rdb_defconfig
index 80d40ae668eb..673cdebbac42 100644
--- a/arch/powerpc/configs/83xx/mpc8315_rdb_defconfig
+++ b/arch/powerpc/configs/83xx/mpc8315_rdb_defconfig
@@ -2,7 +2,7 @@ CONFIG_SYSVIPC=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_LOG_BUF_SHIFT=14
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_EXPERT=y
 # CONFIG_KALLSYMS is not set
 CONFIG_MODULES=y
diff --git a/arch/powerpc/configs/83xx/mpc832x_rdb_defconfig b/arch/powerpc/configs/83xx/mpc832x_rdb_defconfig
index b99caba8724a..3ae1b474e546 100644
--- a/arch/powerpc/configs/83xx/mpc832x_rdb_defconfig
+++ b/arch/powerpc/configs/83xx/mpc832x_rdb_defconfig
@@ -2,7 +2,7 @@ CONFIG_SYSVIPC=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_LOG_BUF_SHIFT=14
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_EXPERT=y
 # CONFIG_KALLSYMS is not set
 CONFIG_MODULES=y
diff --git a/arch/powerpc/configs/83xx/mpc834x_itx_defconfig b/arch/powerpc/configs/83xx/mpc834x_itx_defconfig
index 11163052fdba..0dd939d938d7 100644
--- a/arch/powerpc/configs/83xx/mpc834x_itx_defconfig
+++ b/arch/powerpc/configs/83xx/mpc834x_itx_defconfig
@@ -2,7 +2,7 @@ CONFIG_SYSVIPC=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_LOG_BUF_SHIFT=14
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_EXPERT=y
 # CONFIG_KALLSYMS is not set
 CONFIG_MODULES=y
diff --git a/arch/powerpc/configs/83xx/mpc834x_itxgp_defconfig b/arch/powerpc/configs/83xx/mpc834x_itxgp_defconfig
index 312d39e4242c..33f4efeccb46 100644
--- a/arch/powerpc/configs/83xx/mpc834x_itxgp_defconfig
+++ b/arch/powerpc/configs/83xx/mpc834x_itxgp_defconfig
@@ -2,7 +2,7 @@ CONFIG_SYSVIPC=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_LOG_BUF_SHIFT=14
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_EXPERT=y
 # CONFIG_KALLSYMS is not set
 CONFIG_MODULES=y
diff --git a/arch/powerpc/configs/83xx/mpc836x_rdk_defconfig b/arch/powerpc/configs/83xx/mpc836x_rdk_defconfig
index 093df33f9455..6d000adec270 100644
--- a/arch/powerpc/configs/83xx/mpc836x_rdk_defconfig
+++ b/arch/powerpc/configs/83xx/mpc836x_rdk_defconfig
@@ -1,6 +1,6 @@
 CONFIG_SYSVIPC=y
 CONFIG_LOG_BUF_SHIFT=14
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_EXPERT=y
 # CONFIG_KALLSYMS is not set
 CONFIG_MODULES=y
diff --git a/arch/powerpc/configs/83xx/mpc837x_rdb_defconfig b/arch/powerpc/configs/83xx/mpc837x_rdb_defconfig
index ac27f99faab8..9d56002df3bc 100644
--- a/arch/powerpc/configs/83xx/mpc837x_rdb_defconfig
+++ b/arch/powerpc/configs/83xx/mpc837x_rdb_defconfig
@@ -1,6 +1,6 @@
 CONFIG_SYSVIPC=y
 CONFIG_LOG_BUF_SHIFT=14
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_EXPERT=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
diff --git a/arch/powerpc/configs/85xx/ge_imp3a_defconfig b/arch/powerpc/configs/85xx/ge_imp3a_defconfig
index 7beb36a41d45..04a770fb145d 100644
--- a/arch/powerpc/configs/85xx/ge_imp3a_defconfig
+++ b/arch/powerpc/configs/85xx/ge_imp3a_defconfig
@@ -15,7 +15,7 @@ CONFIG_IKCONFIG_PROC=y
 CONFIG_SYSFS_DEPRECATED=y
 CONFIG_SYSFS_DEPRECATED_V2=y
 CONFIG_RELAY=y
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_PERF_EVENTS=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
diff --git a/arch/powerpc/configs/85xx/ksi8560_defconfig b/arch/powerpc/configs/85xx/ksi8560_defconfig
index 9cb211fb6d1e..db06a4c4b80c 100644
--- a/arch/powerpc/configs/85xx/ksi8560_defconfig
+++ b/arch/powerpc/configs/85xx/ksi8560_defconfig
@@ -1,7 +1,7 @@
 CONFIG_PPC_85xx=y
 CONFIG_SYSVIPC=y
 CONFIG_LOG_BUF_SHIFT=14
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_EXPERT=y
 # CONFIG_BLK_DEV_BSG is not set
 CONFIG_PARTITION_ADVANCED=y
diff --git a/arch/powerpc/configs/85xx/socrates_defconfig b/arch/powerpc/configs/85xx/socrates_defconfig
index 7037a6d8018c..80f19738ac37 100644
--- a/arch/powerpc/configs/85xx/socrates_defconfig
+++ b/arch/powerpc/configs/85xx/socrates_defconfig
@@ -1,7 +1,7 @@
 CONFIG_PPC_85xx=y
 CONFIG_SYSVIPC=y
 CONFIG_LOG_BUF_SHIFT=16
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_EXPERT=y
 # CONFIG_KALLSYMS is not set
 # CONFIG_EPOLL is not set
diff --git a/arch/powerpc/configs/85xx/stx_gp3_defconfig b/arch/powerpc/configs/85xx/stx_gp3_defconfig
index 0a42072fa23c..8d0ccfbb7109 100644
--- a/arch/powerpc/configs/85xx/stx_gp3_defconfig
+++ b/arch/powerpc/configs/85xx/stx_gp3_defconfig
@@ -1,7 +1,7 @@
 CONFIG_PPC_85xx=y
 CONFIG_SYSVIPC=y
 CONFIG_LOG_BUF_SHIFT=14
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_EXPERT=y
 CONFIG_MODULES=y
 CONFIG_MODVERSIONS=y
diff --git a/arch/powerpc/configs/85xx/tqm8540_defconfig b/arch/powerpc/configs/85xx/tqm8540_defconfig
index bbf040aa1f9a..9c9c3b7c1147 100644
--- a/arch/powerpc/configs/85xx/tqm8540_defconfig
+++ b/arch/powerpc/configs/85xx/tqm8540_defconfig
@@ -1,7 +1,7 @@
 CONFIG_PPC_85xx=y
 CONFIG_SYSVIPC=y
 CONFIG_LOG_BUF_SHIFT=14
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_EXPERT=y
 # CONFIG_KALLSYMS is not set
 # CONFIG_EPOLL is not set
diff --git a/arch/powerpc/configs/85xx/tqm8541_defconfig b/arch/powerpc/configs/85xx/tqm8541_defconfig
index 523ad8dcfd9d..4acfa7cfb2fd 100644
--- a/arch/powerpc/configs/85xx/tqm8541_defconfig
+++ b/arch/powerpc/configs/85xx/tqm8541_defconfig
@@ -1,7 +1,7 @@
 CONFIG_PPC_85xx=y
 CONFIG_SYSVIPC=y
 CONFIG_LOG_BUF_SHIFT=14
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_EXPERT=y
 # CONFIG_KALLSYMS is not set
 # CONFIG_EPOLL is not set
diff --git a/arch/powerpc/configs/85xx/tqm8548_defconfig b/arch/powerpc/configs/85xx/tqm8548_defconfig
index afa1b9b633f8..7e4de11202bf 100644
--- a/arch/powerpc/configs/85xx/tqm8548_defconfig
+++ b/arch/powerpc/configs/85xx/tqm8548_defconfig
@@ -3,7 +3,7 @@ CONFIG_SYSVIPC=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_LOG_BUF_SHIFT=14
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_EXPERT=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
diff --git a/arch/powerpc/configs/85xx/tqm8555_defconfig b/arch/powerpc/configs/85xx/tqm8555_defconfig
index 0032ce1e8c9c..b3404fca620d 100644
--- a/arch/powerpc/configs/85xx/tqm8555_defconfig
+++ b/arch/powerpc/configs/85xx/tqm8555_defconfig
@@ -1,7 +1,7 @@
 CONFIG_PPC_85xx=y
 CONFIG_SYSVIPC=y
 CONFIG_LOG_BUF_SHIFT=14
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_EXPERT=y
 # CONFIG_KALLSYMS is not set
 # CONFIG_EPOLL is not set
diff --git a/arch/powerpc/configs/85xx/tqm8560_defconfig b/arch/powerpc/configs/85xx/tqm8560_defconfig
index a80b971f7d6e..61021a8406a8 100644
--- a/arch/powerpc/configs/85xx/tqm8560_defconfig
+++ b/arch/powerpc/configs/85xx/tqm8560_defconfig
@@ -1,7 +1,7 @@
 CONFIG_PPC_85xx=y
 CONFIG_SYSVIPC=y
 CONFIG_LOG_BUF_SHIFT=14
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_EXPERT=y
 # CONFIG_KALLSYMS is not set
 # CONFIG_EPOLL is not set
diff --git a/arch/powerpc/configs/85xx/xes_mpc85xx_defconfig b/arch/powerpc/configs/85xx/xes_mpc85xx_defconfig
index 488d03ae6d6c..0bab90e37f91 100644
--- a/arch/powerpc/configs/85xx/xes_mpc85xx_defconfig
+++ b/arch/powerpc/configs/85xx/xes_mpc85xx_defconfig
@@ -8,7 +8,7 @@ CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=14
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_EXPERT=y
 CONFIG_KALLSYMS_ALL=y
 CONFIG_MODULES=y
diff --git a/arch/powerpc/configs/amigaone_defconfig b/arch/powerpc/configs/amigaone_defconfig
index 69ef3dc31c4b..6de6f83c7cc0 100644
--- a/arch/powerpc/configs/amigaone_defconfig
+++ b/arch/powerpc/configs/amigaone_defconfig
@@ -7,7 +7,7 @@ CONFIG_HIGH_RES_TIMERS=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=15
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 # CONFIG_COMPAT_BRK is not set
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
diff --git a/arch/powerpc/configs/cell_defconfig b/arch/powerpc/configs/cell_defconfig
index 7a31b52e92e1..d32fc083b6fa 100644
--- a/arch/powerpc/configs/cell_defconfig
+++ b/arch/powerpc/configs/cell_defconfig
@@ -11,7 +11,7 @@ CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=15
 CONFIG_CGROUPS=y
 CONFIG_CPUSETS=y
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 # CONFIG_COMPAT_BRK is not set
 CONFIG_PROFILING=y
 CONFIG_MODULES=y
diff --git a/arch/powerpc/configs/chrp32_defconfig b/arch/powerpc/configs/chrp32_defconfig
index b799c95480ae..5bac7324a1d4 100644
--- a/arch/powerpc/configs/chrp32_defconfig
+++ b/arch/powerpc/configs/chrp32_defconfig
@@ -7,7 +7,7 @@ CONFIG_HIGH_RES_TIMERS=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=15
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 # CONFIG_COMPAT_BRK is not set
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
diff --git a/arch/powerpc/configs/fsl-emb-nonhw.config b/arch/powerpc/configs/fsl-emb-nonhw.config
index 2f81bc2d819e..fd097b99398b 100644
--- a/arch/powerpc/configs/fsl-emb-nonhw.config
+++ b/arch/powerpc/configs/fsl-emb-nonhw.config
@@ -5,7 +5,7 @@ CONFIG_BEFS_FS=m
 CONFIG_BFS_FS=m
 CONFIG_BINFMT_MISC=m
 # CONFIG_BLK_DEV_BSG is not set
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_NBD=y
 CONFIG_BLK_DEV_RAM_SIZE=131072
diff --git a/arch/powerpc/configs/g5_defconfig b/arch/powerpc/configs/g5_defconfig
index 428f17b45513..d6433a642f20 100644
--- a/arch/powerpc/configs/g5_defconfig
+++ b/arch/powerpc/configs/g5_defconfig
@@ -9,7 +9,7 @@ CONFIG_HIGH_RES_TIMERS=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_CGROUPS=y
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 # CONFIG_COMPAT_BRK is not set
 CONFIG_PROFILING=y
 CONFIG_MODULES=y
diff --git a/arch/powerpc/configs/gamecube_defconfig b/arch/powerpc/configs/gamecube_defconfig
index cdd99657b71b..387347db1782 100644
--- a/arch/powerpc/configs/gamecube_defconfig
+++ b/arch/powerpc/configs/gamecube_defconfig
@@ -3,7 +3,7 @@ CONFIG_SYSVIPC=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=14
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_EXPERT=y
 # CONFIG_ELF_CORE is not set
 CONFIG_PERF_EVENTS=y
diff --git a/arch/powerpc/configs/holly_defconfig b/arch/powerpc/configs/holly_defconfig
index 271daff47d1d..bffc07caa44f 100644
--- a/arch/powerpc/configs/holly_defconfig
+++ b/arch/powerpc/configs/holly_defconfig
@@ -2,7 +2,7 @@ CONFIG_SYSVIPC=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_LOG_BUF_SHIFT=14
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_EXPERT=y
 CONFIG_MODULES=y
 # CONFIG_BLK_DEV_BSG is not set
diff --git a/arch/powerpc/configs/linkstation_defconfig b/arch/powerpc/configs/linkstation_defconfig
index b564f9e33a0d..72df074540e4 100644
--- a/arch/powerpc/configs/linkstation_defconfig
+++ b/arch/powerpc/configs/linkstation_defconfig
@@ -5,7 +5,7 @@ CONFIG_HIGH_RES_TIMERS=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=14
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 # CONFIG_COMPAT_BRK is not set
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
diff --git a/arch/powerpc/configs/mgcoge_defconfig b/arch/powerpc/configs/mgcoge_defconfig
index f65001e7877f..1b782855c84a 100644
--- a/arch/powerpc/configs/mgcoge_defconfig
+++ b/arch/powerpc/configs/mgcoge_defconfig
@@ -5,7 +5,7 @@ CONFIG_HIGH_RES_TIMERS=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=14
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 # CONFIG_RD_GZIP is not set
 CONFIG_KALLSYMS_ALL=y
 # CONFIG_PCSPKR_PLATFORM is not set
diff --git a/arch/powerpc/configs/microwatt_defconfig b/arch/powerpc/configs/microwatt_defconfig
index a64fb1ef8c75..3094f90e2a03 100644
--- a/arch/powerpc/configs/microwatt_defconfig
+++ b/arch/powerpc/configs/microwatt_defconfig
@@ -5,7 +5,7 @@ CONFIG_PREEMPT_VOLUNTARY=y
 CONFIG_TICK_CPU_ACCOUNTING=y
 CONFIG_LOG_BUF_SHIFT=16
 CONFIG_CGROUPS=y
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_KALLSYMS_ALL=y
 CONFIG_EXPERT=y
diff --git a/arch/powerpc/configs/mpc512x_defconfig b/arch/powerpc/configs/mpc512x_defconfig
index d24457bc5791..c9a3820b2e60 100644
--- a/arch/powerpc/configs/mpc512x_defconfig
+++ b/arch/powerpc/configs/mpc512x_defconfig
@@ -2,7 +2,7 @@
 CONFIG_SYSVIPC=y
 CONFIG_NO_HZ=y
 CONFIG_LOG_BUF_SHIFT=16
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 # CONFIG_COMPAT_BRK is not set
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
diff --git a/arch/powerpc/configs/mpc5200_defconfig b/arch/powerpc/configs/mpc5200_defconfig
index c0fe5e76604a..26d92dc6a4c8 100644
--- a/arch/powerpc/configs/mpc5200_defconfig
+++ b/arch/powerpc/configs/mpc5200_defconfig
@@ -2,7 +2,7 @@ CONFIG_SYSVIPC=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_LOG_BUF_SHIFT=14
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
diff --git a/arch/powerpc/configs/mpc83xx_defconfig b/arch/powerpc/configs/mpc83xx_defconfig
index a815d9e5e3e8..0a100a5dbf4b 100644
--- a/arch/powerpc/configs/mpc83xx_defconfig
+++ b/arch/powerpc/configs/mpc83xx_defconfig
@@ -1,6 +1,6 @@
 CONFIG_SYSVIPC=y
 CONFIG_LOG_BUF_SHIFT=14
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_EXPERT=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
diff --git a/arch/powerpc/configs/pasemi_defconfig b/arch/powerpc/configs/pasemi_defconfig
index 8bbf51b38480..b062c064213b 100644
--- a/arch/powerpc/configs/pasemi_defconfig
+++ b/arch/powerpc/configs/pasemi_defconfig
@@ -5,7 +5,7 @@ CONFIG_NR_CPUS=2
 CONFIG_SYSVIPC=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_PROFILING=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
diff --git a/arch/powerpc/configs/pmac32_defconfig b/arch/powerpc/configs/pmac32_defconfig
index ae45f70b29f0..6691765bb50b 100644
--- a/arch/powerpc/configs/pmac32_defconfig
+++ b/arch/powerpc/configs/pmac32_defconfig
@@ -7,7 +7,7 @@ CONFIG_HIGH_RES_TIMERS=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=14
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 # CONFIG_COMPAT_BRK is not set
 CONFIG_PROFILING=y
 CONFIG_MODULES=y
diff --git a/arch/powerpc/configs/powernv_defconfig b/arch/powerpc/configs/powernv_defconfig
index d06388b0f66e..ac8b6132f69c 100644
--- a/arch/powerpc/configs/powernv_defconfig
+++ b/arch/powerpc/configs/powernv_defconfig
@@ -25,7 +25,7 @@ CONFIG_CGROUP_CPUACCT=y
 CONFIG_CGROUP_PERF=y
 CONFIG_CGROUP_BPF=y
 CONFIG_USER_NS=y
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_BPF_SYSCALL=y
 # CONFIG_COMPAT_BRK is not set
 CONFIG_PROFILING=y
diff --git a/arch/powerpc/configs/ppc44x_defconfig b/arch/powerpc/configs/ppc44x_defconfig
index 41c930f74ed4..e1aee17ef7d6 100644
--- a/arch/powerpc/configs/ppc44x_defconfig
+++ b/arch/powerpc/configs/ppc44x_defconfig
@@ -2,7 +2,7 @@ CONFIG_44x=y
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
 CONFIG_LOG_BUF_SHIFT=14
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_EXPERT=y
 CONFIG_KALLSYMS_ALL=y
 CONFIG_MODULES=y
diff --git a/arch/powerpc/configs/ppc64_defconfig b/arch/powerpc/configs/ppc64_defconfig
index ce34597e9f3e..164a182f0d80 100644
--- a/arch/powerpc/configs/ppc64_defconfig
+++ b/arch/powerpc/configs/ppc64_defconfig
@@ -35,7 +35,7 @@ CONFIG_CGROUP_MISC=y
 CONFIG_USER_NS=y
 CONFIG_CHECKPOINT_RESTORE=y
 CONFIG_SCHED_AUTOGROUP=y
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_PROFILING=y
 CONFIG_PPC64=y
 CONFIG_NR_CPUS=2048
diff --git a/arch/powerpc/configs/ppc64e_defconfig b/arch/powerpc/configs/ppc64e_defconfig
index 90247b2a0ab0..c538beda73fa 100644
--- a/arch/powerpc/configs/ppc64e_defconfig
+++ b/arch/powerpc/configs/ppc64e_defconfig
@@ -11,7 +11,7 @@ CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_CGROUPS=y
 CONFIG_CPUSETS=y
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 # CONFIG_COMPAT_BRK is not set
 CONFIG_PROFILING=y
 CONFIG_MODULES=y
diff --git a/arch/powerpc/configs/ppc6xx_defconfig b/arch/powerpc/configs/ppc6xx_defconfig
index b082c1fae13c..ef322cfda4b9 100644
--- a/arch/powerpc/configs/ppc6xx_defconfig
+++ b/arch/powerpc/configs/ppc6xx_defconfig
@@ -15,7 +15,7 @@ CONFIG_CGROUP_SCHED=y
 CONFIG_CGROUP_DEVICE=y
 CONFIG_CGROUP_CPUACCT=y
 CONFIG_USER_NS=y
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 # CONFIG_COMPAT_BRK is not set
 CONFIG_PROFILING=y
 CONFIG_KPROBES=y
diff --git a/arch/powerpc/configs/ps3_defconfig b/arch/powerpc/configs/ps3_defconfig
index 0b48d2b776c4..9899af6b73e1 100644
--- a/arch/powerpc/configs/ps3_defconfig
+++ b/arch/powerpc/configs/ps3_defconfig
@@ -1,7 +1,7 @@
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
 CONFIG_HIGH_RES_TIMERS=y
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_EXPERT=y
 # CONFIG_PERF_EVENTS is not set
diff --git a/arch/powerpc/configs/skiroot_defconfig b/arch/powerpc/configs/skiroot_defconfig
index 2b71a6dc399e..1611e15a72f3 100644
--- a/arch/powerpc/configs/skiroot_defconfig
+++ b/arch/powerpc/configs/skiroot_defconfig
@@ -9,7 +9,7 @@ CONFIG_HIGH_RES_TIMERS=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=20
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 # CONFIG_RD_GZIP is not set
 # CONFIG_RD_BZIP2 is not set
 # CONFIG_RD_LZMA is not set
diff --git a/arch/powerpc/configs/wii_defconfig b/arch/powerpc/configs/wii_defconfig
index 7c714a19221e..a7339767da4e 100644
--- a/arch/powerpc/configs/wii_defconfig
+++ b/arch/powerpc/configs/wii_defconfig
@@ -4,7 +4,7 @@ CONFIG_SYSVIPC=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=14
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_EXPERT=y
 # CONFIG_ELF_CORE is not set
 CONFIG_PERF_EVENTS=y
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index a2a1896f9e46..a1851246eab9 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -96,7 +96,7 @@ early_param("mem", early_parse_mem);
  */
 static inline int overlaps_initrd(unsigned long start, unsigned long size)
 {
-#ifdef CONFIG_BLK_DEV_INITRD
+#ifdef CONFIG_INITRAMFS
 	if (!virt_external_initramfs_start)
 		return 0;
 
@@ -684,14 +684,14 @@ static void __init early_reserve_mem(void)
 	/* Look for the new "reserved-regions" property in the DT */
 	early_reserve_mem_dt();
 
-#ifdef CONFIG_BLK_DEV_INITRD
+#ifdef CONFIG_INITRAMFS
 	/* Then reserve the initrd, if any */
 	if (virt_external_initramfs_start && (virt_external_initramfs_end > virt_external_initramfs_start)) {
 		memblock_reserve(ALIGN_DOWN(__pa(virt_external_initramfs_start), PAGE_SIZE),
 			ALIGN(virt_external_initramfs_end, PAGE_SIZE) -
 			ALIGN_DOWN(virt_external_initramfs_start, PAGE_SIZE));
 	}
-#endif /* CONFIG_BLK_DEV_INITRD */
+#endif /* CONFIG_INITRAMFS */
 
 	if (!IS_ENABLED(CONFIG_PPC32))
 		return;
diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index a0ac845eb504..f00a7639113c 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -3153,7 +3153,7 @@ static void __init prom_find_boot_cpu(void)
 
 static void __init prom_check_initrd(unsigned long r3, unsigned long r4)
 {
-#ifdef CONFIG_BLK_DEV_INITRD
+#ifdef CONFIG_INITRAMFS
 	if (r3 && r4 && r4 != 0xdeadbeef) {
 		__be64 val;
 
@@ -3173,7 +3173,7 @@ static void __init prom_check_initrd(unsigned long r3, unsigned long r4)
 		prom_debug("initrd_start=0x%lx\n", prom_initrd_start);
 		prom_debug("initrd_end=0x%lx\n", prom_initrd_end);
 	}
-#endif /* CONFIG_BLK_DEV_INITRD */
+#endif /* CONFIG_INITRAMFS */
 }
 
 #ifdef CONFIG_PPC_SVM
diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 53a416bc41ce..fe047ddc9ff4 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -359,7 +359,7 @@ const struct seq_operations cpuinfo_op = {
 
 void __init check_for_initrd(void)
 {
-#ifdef CONFIG_BLK_DEV_INITRD
+#ifdef CONFIG_INITRAMFS
 	DBG(" -> check_for_initrd()  virt_external_initramfs_start=0x%lx  virt_external_initramfs_end=0x%lx\n",
 	    virt_external_initramfs_start, virt_external_initramfs_end);
 
@@ -373,7 +373,7 @@ void __init check_for_initrd(void)
 		pr_info("Found initramfs at 0x%lx:0x%lx\n", virt_external_initramfs_start, virt_external_initramfs_end);
 
 	DBG(" <- check_for_initrd()\n");
-#endif /* CONFIG_BLK_DEV_INITRD */
+#endif /* CONFIG_INITRAMFS */
 }
 
 #ifdef CONFIG_SMP
diff --git a/arch/powerpc/platforms/powermac/setup.c b/arch/powerpc/platforms/powermac/setup.c
index ab0860868025..5d8c98eb02c3 100644
--- a/arch/powerpc/platforms/powermac/setup.c
+++ b/arch/powerpc/platforms/powermac/setup.c
@@ -295,7 +295,7 @@ static void __init pmac_setup_arch(void)
 	pmac_nvram_init();
 #endif
 #ifdef CONFIG_PPC32
-#ifdef CONFIG_BLK_DEV_INITRD
+#ifdef CONFIG_INITRAMFS
 	if (!virt_external_initramfs_start)
 #endif
 		ROOT_DEV = DEFAULT_ROOT_DEVICE;
diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index 7b5eed17611a..b6709cf90720 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -20,7 +20,7 @@ CONFIG_CGROUP_PERF=y
 CONFIG_CGROUP_BPF=y
 CONFIG_USER_NS=y
 CONFIG_CHECKPOINT_RESTORE=y
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_PROFILING=y
 CONFIG_ARCH_ANDES=y
 CONFIG_ARCH_MICROCHIP=y
diff --git a/arch/riscv/configs/nommu_k210_defconfig b/arch/riscv/configs/nommu_k210_defconfig
index ee18d1e333f2..7824f13e84f3 100644
--- a/arch/riscv/configs/nommu_k210_defconfig
+++ b/arch/riscv/configs/nommu_k210_defconfig
@@ -1,6 +1,6 @@
 # CONFIG_CPU_ISOLATION is not set
 CONFIG_LOG_BUF_SHIFT=13
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 # CONFIG_RD_GZIP is not set
 # CONFIG_RD_BZIP2 is not set
 # CONFIG_RD_LZMA is not set
diff --git a/arch/riscv/configs/nommu_virt_defconfig b/arch/riscv/configs/nommu_virt_defconfig
index d4b03dc3c2c0..d777e4a774bd 100644
--- a/arch/riscv/configs/nommu_virt_defconfig
+++ b/arch/riscv/configs/nommu_virt_defconfig
@@ -1,6 +1,6 @@
 # CONFIG_CPU_ISOLATION is not set
 CONFIG_LOG_BUF_SHIFT=16
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 # CONFIG_RD_BZIP2 is not set
 # CONFIG_RD_LZMA is not set
 # CONFIG_RD_XZ is not set
diff --git a/arch/s390/boot/startup.c b/arch/s390/boot/startup.c
index 93684a775716..c631955fb5a5 100644
--- a/arch/s390/boot/startup.c
+++ b/arch/s390/boot/startup.c
@@ -205,7 +205,7 @@ static void rescue_initrd(unsigned long min, unsigned long max)
 {
 	unsigned long old_addr, addr, size;
 
-	if (!IS_ENABLED(CONFIG_BLK_DEV_INITRD))
+	if (!IS_ENABLED(CONFIG_INITRAMFS))
 		return;
 	if (!get_physmem_reserved(RR_INITRD, &addr, &size))
 		return;
@@ -523,7 +523,7 @@ void startup_kernel(void)
 	 * (if KASLR is off or failed).
 	 */
 	physmem_reserve(RR_DECOMPRESSOR, 0, safe_addr);
-	if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) && parmarea.initrd_size)
+	if (IS_ENABLED(CONFIG_INITRAMFS) && parmarea.initrd_size)
 		physmem_reserve(RR_INITRD, parmarea.initrd_start, parmarea.initrd_size);
 	oldmem_data.start = parmarea.oldmem_base;
 	oldmem_data.size = parmarea.oldmem_size;
diff --git a/arch/s390/configs/zfcpdump_defconfig b/arch/s390/configs/zfcpdump_defconfig
index ed0b137353ad..b7409974b9c2 100644
--- a/arch/s390/configs/zfcpdump_defconfig
+++ b/arch/s390/configs/zfcpdump_defconfig
@@ -7,7 +7,7 @@ CONFIG_BPF_SYSCALL=y
 # CONFIG_TIME_NS is not set
 # CONFIG_PID_NS is not set
 # CONFIG_NET_NS is not set
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_KEXEC=y
 CONFIG_MARCH_Z13=y
diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
index 7ce009c2599d..062b6b6762df 100644
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -670,7 +670,7 @@ static void __init reserve_initrd(void)
 {
 	unsigned long addr, size;
 
-	if (!IS_ENABLED(CONFIG_BLK_DEV_INITRD) || !get_physmem_reserved(RR_INITRD, &addr, &size))
+	if (!IS_ENABLED(CONFIG_INITRAMFS) || !get_physmem_reserved(RR_INITRD, &addr, &size))
 		return;
 	virt_external_initramfs_start = (unsigned long)__va(addr);
 	virt_external_initramfs_end = virt_external_initramfs_start + size;
diff --git a/arch/sh/configs/apsh4a3a_defconfig b/arch/sh/configs/apsh4a3a_defconfig
index 9c2644443c4d..026c35567b23 100644
--- a/arch/sh/configs/apsh4a3a_defconfig
+++ b/arch/sh/configs/apsh4a3a_defconfig
@@ -5,7 +5,7 @@ CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_SYSFS_DEPRECATED=y
 CONFIG_SYSFS_DEPRECATED_V2=y
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_PROFILING=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
diff --git a/arch/sh/configs/apsh4ad0a_defconfig b/arch/sh/configs/apsh4ad0a_defconfig
index 137573610ec4..10ec215729e6 100644
--- a/arch/sh/configs/apsh4ad0a_defconfig
+++ b/arch/sh/configs/apsh4ad0a_defconfig
@@ -12,7 +12,7 @@ CONFIG_CGROUP_CPUACCT=y
 CONFIG_CGROUP_MEMCG=y
 CONFIG_BLK_CGROUP=y
 CONFIG_NAMESPACES=y
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_KALLSYMS_ALL=y
 # CONFIG_COMPAT_BRK is not set
 CONFIG_PROFILING=y
diff --git a/arch/sh/configs/ecovec24-romimage_defconfig b/arch/sh/configs/ecovec24-romimage_defconfig
index 13fec4338416..7ff9d8306d45 100644
--- a/arch/sh/configs/ecovec24-romimage_defconfig
+++ b/arch/sh/configs/ecovec24-romimage_defconfig
@@ -4,7 +4,7 @@ CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=14
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 # CONFIG_KALLSYMS is not set
 # CONFIG_BLK_DEV_BSG is not set
 CONFIG_CPU_SUBTYPE_SH7724=y
diff --git a/arch/sh/configs/edosk7760_defconfig b/arch/sh/configs/edosk7760_defconfig
index f427a95bcd21..e253d2cb1322 100644
--- a/arch/sh/configs/edosk7760_defconfig
+++ b/arch/sh/configs/edosk7760_defconfig
@@ -4,7 +4,7 @@ CONFIG_POSIX_MQUEUE=y
 CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_KALLSYMS_ALL=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
diff --git a/arch/sh/configs/kfr2r09-romimage_defconfig b/arch/sh/configs/kfr2r09-romimage_defconfig
index 88fbb65cb9f9..faca85dac22a 100644
--- a/arch/sh/configs/kfr2r09-romimage_defconfig
+++ b/arch/sh/configs/kfr2r09-romimage_defconfig
@@ -4,7 +4,7 @@ CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=14
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 # CONFIG_KALLSYMS is not set
 # CONFIG_BLOCK is not set
 CONFIG_CPU_SUBTYPE_SH7724=y
diff --git a/arch/sh/configs/kfr2r09_defconfig b/arch/sh/configs/kfr2r09_defconfig
index d80e83e7ec38..a80b76d12f10 100644
--- a/arch/sh/configs/kfr2r09_defconfig
+++ b/arch/sh/configs/kfr2r09_defconfig
@@ -4,7 +4,7 @@ CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=14
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 # CONFIG_KALLSYMS is not set
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
diff --git a/arch/sh/configs/magicpanelr2_defconfig b/arch/sh/configs/magicpanelr2_defconfig
index 93b9aa32dc7c..f2498f4f1950 100644
--- a/arch/sh/configs/magicpanelr2_defconfig
+++ b/arch/sh/configs/magicpanelr2_defconfig
@@ -5,7 +5,7 @@ CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_BSD_PROCESS_ACCT_V3=y
 CONFIG_AUDIT=y
 CONFIG_RELAY=y
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 CONFIG_KALLSYMS_ALL=y
 CONFIG_MODULES=y
diff --git a/arch/sh/configs/migor_defconfig b/arch/sh/configs/migor_defconfig
index 31dbd8888aaa..3b8449e4d3c4 100644
--- a/arch/sh/configs/migor_defconfig
+++ b/arch/sh/configs/migor_defconfig
@@ -2,7 +2,7 @@ CONFIG_SYSVIPC=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=14
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 CONFIG_PROFILING=y
 CONFIG_MODULES=y
diff --git a/arch/sh/configs/rsk7201_defconfig b/arch/sh/configs/rsk7201_defconfig
index 376e95fa77bc..525add70da17 100644
--- a/arch/sh/configs/rsk7201_defconfig
+++ b/arch/sh/configs/rsk7201_defconfig
@@ -8,7 +8,7 @@ CONFIG_UTS_NS=y
 CONFIG_IPC_NS=y
 CONFIG_USER_NS=y
 CONFIG_PID_NS=y
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 # CONFIG_AIO is not set
 CONFIG_SLUB=y
 CONFIG_SLUB_TINY=y
diff --git a/arch/sh/configs/rsk7203_defconfig b/arch/sh/configs/rsk7203_defconfig
index 1d5fd67a3949..8936458242db 100644
--- a/arch/sh/configs/rsk7203_defconfig
+++ b/arch/sh/configs/rsk7203_defconfig
@@ -9,7 +9,7 @@ CONFIG_UTS_NS=y
 CONFIG_IPC_NS=y
 CONFIG_USER_NS=y
 CONFIG_PID_NS=y
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_KALLSYMS_ALL=y
 CONFIG_SLUB=y
 CONFIG_SLUB_TINY=y
diff --git a/arch/sh/configs/sdk7786_defconfig b/arch/sh/configs/sdk7786_defconfig
index 07894f13441e..dd0ef63a0064 100644
--- a/arch/sh/configs/sdk7786_defconfig
+++ b/arch/sh/configs/sdk7786_defconfig
@@ -26,7 +26,7 @@ CONFIG_IPC_NS=y
 CONFIG_USER_NS=y
 CONFIG_PID_NS=y
 CONFIG_NET_NS=y
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_RD_BZIP2=y
 CONFIG_RD_LZMA=y
 CONFIG_RD_LZO=y
diff --git a/arch/sh/configs/se7206_defconfig b/arch/sh/configs/se7206_defconfig
index 64f9308ee586..2d9749464739 100644
--- a/arch/sh/configs/se7206_defconfig
+++ b/arch/sh/configs/se7206_defconfig
@@ -16,7 +16,7 @@ CONFIG_UTS_NS=y
 CONFIG_IPC_NS=y
 CONFIG_USER_NS=y
 CONFIG_PID_NS=y
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 # CONFIG_UID16 is not set
 CONFIG_KALLSYMS_ALL=y
 # CONFIG_ELF_CORE is not set
diff --git a/arch/sh/configs/se7705_defconfig b/arch/sh/configs/se7705_defconfig
index 1752ddc2694a..7ff345525c74 100644
--- a/arch/sh/configs/se7705_defconfig
+++ b/arch/sh/configs/se7705_defconfig
@@ -1,6 +1,6 @@
 # CONFIG_SWAP is not set
 CONFIG_LOG_BUF_SHIFT=14
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 # CONFIG_KALLSYMS is not set
 # CONFIG_HOTPLUG is not set
diff --git a/arch/sh/configs/se7722_defconfig b/arch/sh/configs/se7722_defconfig
index 5327a2f70980..0a0daf45aafa 100644
--- a/arch/sh/configs/se7722_defconfig
+++ b/arch/sh/configs/se7722_defconfig
@@ -3,7 +3,7 @@ CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=14
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_PROFILING=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
diff --git a/arch/sh/configs/se7751_defconfig b/arch/sh/configs/se7751_defconfig
index 8b5fe4ec16bc..5e4d15c3e1f5 100644
--- a/arch/sh/configs/se7751_defconfig
+++ b/arch/sh/configs/se7751_defconfig
@@ -1,7 +1,7 @@
 CONFIG_SYSVIPC=y
 CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_LOG_BUF_SHIFT=14
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 # CONFIG_HOTPLUG is not set
 CONFIG_MODULES=y
diff --git a/arch/sh/configs/secureedge5410_defconfig b/arch/sh/configs/secureedge5410_defconfig
index 2f77b60e9540..37e3e304f944 100644
--- a/arch/sh/configs/secureedge5410_defconfig
+++ b/arch/sh/configs/secureedge5410_defconfig
@@ -1,6 +1,6 @@
 # CONFIG_SWAP is not set
 CONFIG_LOG_BUF_SHIFT=14
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 # CONFIG_HOTPLUG is not set
 # CONFIG_BLK_DEV_BSG is not set
 CONFIG_CPU_SUBTYPE_SH7751R=y
diff --git a/arch/sh/configs/sh03_defconfig b/arch/sh/configs/sh03_defconfig
index 4d75c92cac10..375e0e9edb39 100644
--- a/arch/sh/configs/sh03_defconfig
+++ b/arch/sh/configs/sh03_defconfig
@@ -2,7 +2,7 @@ CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
 CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_LOG_BUF_SHIFT=14
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_PROFILING=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
diff --git a/arch/sh/configs/sh7757lcr_defconfig b/arch/sh/configs/sh7757lcr_defconfig
index 48a0f9beb116..710bf61ad328 100644
--- a/arch/sh/configs/sh7757lcr_defconfig
+++ b/arch/sh/configs/sh7757lcr_defconfig
@@ -7,7 +7,7 @@ CONFIG_TASK_DELAY_ACCT=y
 CONFIG_TASK_XACCT=y
 CONFIG_TASK_IO_ACCOUNTING=y
 CONFIG_LOG_BUF_SHIFT=14
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_KALLSYMS_ALL=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
diff --git a/arch/sh/configs/titan_defconfig b/arch/sh/configs/titan_defconfig
index 8ef72b8dbcd3..3da734d1ebc9 100644
--- a/arch/sh/configs/titan_defconfig
+++ b/arch/sh/configs/titan_defconfig
@@ -4,7 +4,7 @@ CONFIG_POSIX_MQUEUE=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=16
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
diff --git a/arch/sh/configs/ul2_defconfig b/arch/sh/configs/ul2_defconfig
index 103b81ec1ffb..16425409e46a 100644
--- a/arch/sh/configs/ul2_defconfig
+++ b/arch/sh/configs/ul2_defconfig
@@ -3,7 +3,7 @@ CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=14
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_PROFILING=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
diff --git a/arch/sh/configs/urquell_defconfig b/arch/sh/configs/urquell_defconfig
index 00ef62133b04..fbaf782169ce 100644
--- a/arch/sh/configs/urquell_defconfig
+++ b/arch/sh/configs/urquell_defconfig
@@ -16,7 +16,7 @@ CONFIG_CGROUP_CPUACCT=y
 CONFIG_CGROUP_MEMCG=y
 CONFIG_CGROUP_SCHED=y
 CONFIG_RT_GROUP_SCHED=y
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_PROFILING=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
diff --git a/arch/sh/kernel/setup.c b/arch/sh/kernel/setup.c
index 814866e35120..7e58bd242582 100644
--- a/arch/sh/kernel/setup.c
+++ b/arch/sh/kernel/setup.c
@@ -112,7 +112,7 @@ early_param("mem", early_parse_mem);
 
 void __init check_for_initrd(void)
 {
-#ifdef CONFIG_BLK_DEV_INITRD
+#ifdef CONFIG_INITRAMFS
 	unsigned long start, end;
 
 	/*
diff --git a/arch/sparc/configs/sparc32_defconfig b/arch/sparc/configs/sparc32_defconfig
index f6341b063b01..0a664c499b06 100644
--- a/arch/sparc/configs/sparc32_defconfig
+++ b/arch/sparc/configs/sparc32_defconfig
@@ -2,7 +2,7 @@ CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_SYSFS_DEPRECATED_V2=y
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
diff --git a/arch/sparc/configs/sparc64_defconfig b/arch/sparc/configs/sparc64_defconfig
index 7a7c4dec2925..9fbf5531a52f 100644
--- a/arch/sparc/configs/sparc64_defconfig
+++ b/arch/sparc/configs/sparc64_defconfig
@@ -3,7 +3,7 @@ CONFIG_64BIT=y
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
 CONFIG_LOG_BUF_SHIFT=18
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_PERF_EVENTS=y
 # CONFIG_COMPAT_BRK is not set
 CONFIG_PROFILING=y
diff --git a/arch/sparc/mm/init_32.c b/arch/sparc/mm/init_32.c
index f04dd1d6f382..236d17b4bc78 100644
--- a/arch/sparc/mm/init_32.c
+++ b/arch/sparc/mm/init_32.c
@@ -100,7 +100,7 @@ static unsigned long calc_max_low_pfn(void)
 
 static void __init find_ramdisk(unsigned long end_of_phys_memory)
 {
-#ifdef CONFIG_BLK_DEV_INITRD
+#ifdef CONFIG_INITRAMFS
 	unsigned long size;
 
 	/* Now have to check initial ramdisk, so that it won't pass
diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index b0fa82676e6f..0680bec325eb 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -875,7 +875,7 @@ do {	if (numa_debug) \
 
 static void __init find_ramdisk(unsigned long phys_base)
 {
-#ifdef CONFIG_BLK_DEV_INITRD
+#ifdef CONFIG_INITRAMFS
 	if (sparc_ramdisk_image || sparc_ramdisk_image64) {
 		unsigned long ramdisk_image;
 
@@ -2484,7 +2484,7 @@ int page_in_phys_avail(unsigned long paddr)
 	}
 	if (paddr >= kern_base && paddr < (kern_base + kern_size))
 		return 1;
-#ifdef CONFIG_BLK_DEV_INITRD
+#ifdef CONFIG_INITRAMFS
 	if (paddr >= __pa(virt_external_initramfs_start) &&
 	    paddr < __pa(PAGE_ALIGN(virt_external_initramfs_end)))
 		return 1;
diff --git a/arch/um/kernel/Makefile b/arch/um/kernel/Makefile
index b8f4e9281599..1e8fbe509bfb 100644
--- a/arch/um/kernel/Makefile
+++ b/arch/um/kernel/Makefile
@@ -20,7 +20,7 @@ obj-y = config.o exec.o exitcode.o irq.o ksyms.o mem.o \
 	um_arch.o umid.o kmsg_dump.o capflags.o skas/
 obj-y += load_file.o
 
-obj-$(CONFIG_BLK_DEV_INITRD) += initrd.o
+obj-$(CONFIG_INITRAMFS) += initrd.o
 obj-$(CONFIG_GPROF)	+= gprof_syms.o
 obj-$(CONFIG_OF) += dtb.o
 obj-$(CONFIG_EARLY_PRINTK) += early_printk.o
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 58d890fe2100..44805d01eff4 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1326,7 +1326,7 @@ config MICROCODE
 
 config MICROCODE_INITRD32
 	def_bool y
-	depends on MICROCODE && X86_32 && BLK_DEV_INITRD
+	depends on MICROCODE && X86_32 && INITRAMFS
 
 config MICROCODE_LATE_LOADING
 	bool "Late microcode loading (DANGEROUS)"
diff --git a/arch/x86/boot/startup/sme.c b/arch/x86/boot/startup/sme.c
index 70ea1748c0a7..983bded31ebb 100644
--- a/arch/x86/boot/startup/sme.c
+++ b/arch/x86/boot/startup/sme.c
@@ -322,7 +322,7 @@ void __head sme_encrypt_kernel(struct boot_params *bp)
 	initrd_start = 0;
 	initrd_end = 0;
 	initrd_len = 0;
-#ifdef CONFIG_BLK_DEV_INITRD
+#ifdef CONFIG_INITRAMFS
 	initrd_len = (unsigned long)bp->hdr.ramdisk_size |
 		     ((unsigned long)bp->ext_ramdisk_size << 32);
 	if (initrd_len) {
diff --git a/arch/x86/configs/i386_defconfig b/arch/x86/configs/i386_defconfig
index 79fa38ca954d..b345788090bb 100644
--- a/arch/x86/configs/i386_defconfig
+++ b/arch/x86/configs/i386_defconfig
@@ -24,7 +24,7 @@ CONFIG_CGROUP_CPUACCT=y
 CONFIG_CGROUP_PERF=y
 CONFIG_CGROUP_MISC=y
 CONFIG_CGROUP_DEBUG=y
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_KALLSYMS_ALL=y
 CONFIG_PROFILING=y
 CONFIG_KEXEC=y
diff --git a/arch/x86/configs/x86_64_defconfig b/arch/x86/configs/x86_64_defconfig
index 7d7310cdf8b0..8afc43c0742a 100644
--- a/arch/x86/configs/x86_64_defconfig
+++ b/arch/x86/configs/x86_64_defconfig
@@ -24,7 +24,7 @@ CONFIG_CGROUP_CPUACCT=y
 CONFIG_CGROUP_PERF=y
 CONFIG_CGROUP_MISC=y
 CONFIG_CGROUP_DEBUG=y
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_KALLSYMS_ALL=y
 CONFIG_PROFILING=y
 CONFIG_KEXEC=y
diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index b8169f14d175..a055e3bf0c1a 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -191,7 +191,7 @@ void load_ucode_ap(void)
 
 struct cpio_data __init find_microcode_in_initrd(const char *path)
 {
-#ifdef CONFIG_BLK_DEV_INITRD
+#ifdef CONFIG_INITRAMFS
 	unsigned long start = 0;
 	size_t size;
 
@@ -222,7 +222,7 @@ struct cpio_data __init find_microcode_in_initrd(const char *path)
 		start = virt_external_initramfs_start;
 
 	return find_cpio_data(path, (void *)start, size, NULL);
-#else /* !CONFIG_BLK_DEV_INITRD */
+#else /* !CONFIG_INITRAMFS */
 	return (struct cpio_data){ NULL, 0, "" };
 #endif
 }
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 65670e0f59c0..dc1c1e5dc557 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -288,7 +288,7 @@ static void __init reserve_brk(void)
 	_brk_start = 0;
 }
 
-#ifdef CONFIG_BLK_DEV_INITRD
+#ifdef CONFIG_INITRAMFS
 
 static u64 __init get_ramdisk_image(void)
 {
@@ -393,7 +393,7 @@ static void __init early_reserve_initrd(void)
 static void __init reserve_initrd(void)
 {
 }
-#endif /* CONFIG_BLK_DEV_INITRD */
+#endif /* CONFIG_INITRAMFS */
 
 static void __init add_early_ima_buffer(u64 phys_addr)
 {
diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index 51b632f7fd21..082faaf6e291 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -980,7 +980,7 @@ void __ref free_initmem(void)
 				&__init_begin, &__init_end);
 }
 
-#ifdef CONFIG_BLK_DEV_INITRD
+#ifdef CONFIG_INITRAMFS
 void __init free_initramfs_mem(unsigned long start, unsigned long end)
 {
 	/*
diff --git a/arch/xtensa/configs/audio_kc705_defconfig b/arch/xtensa/configs/audio_kc705_defconfig
index f2af1a32c9c7..41feb5a06616 100644
--- a/arch/xtensa/configs/audio_kc705_defconfig
+++ b/arch/xtensa/configs/audio_kc705_defconfig
@@ -14,7 +14,7 @@ CONFIG_MEMCG=y
 CONFIG_NAMESPACES=y
 CONFIG_SCHED_AUTOGROUP=y
 CONFIG_RELAY=y
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_EXPERT=y
 CONFIG_KALLSYMS_ALL=y
 CONFIG_PROFILING=y
diff --git a/arch/xtensa/configs/cadence_csp_defconfig b/arch/xtensa/configs/cadence_csp_defconfig
index 88ed5284e21c..788274247b03 100644
--- a/arch/xtensa/configs/cadence_csp_defconfig
+++ b/arch/xtensa/configs/cadence_csp_defconfig
@@ -12,7 +12,7 @@ CONFIG_CGROUP_DEBUG=y
 CONFIG_NAMESPACES=y
 CONFIG_SCHED_AUTOGROUP=y
 CONFIG_RELAY=y
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_INITRAMFS_SOURCE="$$KERNEL_INITRAMFS_SOURCE"
 # CONFIG_RD_BZIP2 is not set
 # CONFIG_RD_LZMA is not set
diff --git a/arch/xtensa/configs/generic_kc705_defconfig b/arch/xtensa/configs/generic_kc705_defconfig
index 4427907becca..30468c9e4407 100644
--- a/arch/xtensa/configs/generic_kc705_defconfig
+++ b/arch/xtensa/configs/generic_kc705_defconfig
@@ -14,7 +14,7 @@ CONFIG_MEMCG=y
 CONFIG_NAMESPACES=y
 CONFIG_SCHED_AUTOGROUP=y
 CONFIG_RELAY=y
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_EXPERT=y
 CONFIG_KALLSYMS_ALL=y
 CONFIG_PROFILING=y
diff --git a/arch/xtensa/configs/nommu_kc705_defconfig b/arch/xtensa/configs/nommu_kc705_defconfig
index 5828228522ba..5050b3e5e1be 100644
--- a/arch/xtensa/configs/nommu_kc705_defconfig
+++ b/arch/xtensa/configs/nommu_kc705_defconfig
@@ -14,7 +14,7 @@ CONFIG_MEMCG=y
 CONFIG_NAMESPACES=y
 CONFIG_SCHED_AUTOGROUP=y
 CONFIG_RELAY=y
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 # CONFIG_RD_BZIP2 is not set
 # CONFIG_RD_LZMA is not set
 # CONFIG_RD_XZ is not set
diff --git a/arch/xtensa/configs/smp_lx200_defconfig b/arch/xtensa/configs/smp_lx200_defconfig
index 326966ca7831..197fedacad03 100644
--- a/arch/xtensa/configs/smp_lx200_defconfig
+++ b/arch/xtensa/configs/smp_lx200_defconfig
@@ -14,7 +14,7 @@ CONFIG_MEMCG=y
 CONFIG_NAMESPACES=y
 CONFIG_SCHED_AUTOGROUP=y
 CONFIG_RELAY=y
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_EXPERT=y
 CONFIG_KALLSYMS_ALL=y
 CONFIG_PROFILING=y
diff --git a/arch/xtensa/configs/virt_defconfig b/arch/xtensa/configs/virt_defconfig
index e37048985b47..56acfc8886c0 100644
--- a/arch/xtensa/configs/virt_defconfig
+++ b/arch/xtensa/configs/virt_defconfig
@@ -13,7 +13,7 @@ CONFIG_CGROUP_DEBUG=y
 CONFIG_NAMESPACES=y
 CONFIG_SCHED_AUTOGROUP=y
 CONFIG_RELAY=y
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_EXPERT=y
 CONFIG_KALLSYMS_ALL=y
 CONFIG_PERF_EVENTS=y
diff --git a/arch/xtensa/configs/xip_kc705_defconfig b/arch/xtensa/configs/xip_kc705_defconfig
index ee47438f9b51..c151e1fc32bc 100644
--- a/arch/xtensa/configs/xip_kc705_defconfig
+++ b/arch/xtensa/configs/xip_kc705_defconfig
@@ -13,7 +13,7 @@ CONFIG_CGROUP_DEBUG=y
 CONFIG_NAMESPACES=y
 CONFIG_SCHED_AUTOGROUP=y
 CONFIG_RELAY=y
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_EXPERT=y
 CONFIG_KALLSYMS_ALL=y
 CONFIG_PROFILING=y
diff --git a/arch/xtensa/kernel/setup.c b/arch/xtensa/kernel/setup.c
index b86367178bce..e430e2680afa 100644
--- a/arch/xtensa/kernel/setup.c
+++ b/arch/xtensa/kernel/setup.c
@@ -48,7 +48,7 @@
 #include <asm/timex.h>
 #include <asm/traps.h>
 
-#ifdef CONFIG_BLK_DEV_INITRD
+#ifdef CONFIG_INITRAMFS
 extern unsigned long virt_external_initramfs_start;
 extern unsigned long virt_external_initramfs_end;
 extern int initramfs_below_start_ok;
@@ -100,7 +100,7 @@ static int __init parse_tag_mem(const bp_tag_t *tag)
 
 __tagtable(BP_TAG_MEMORY, parse_tag_mem);
 
-#ifdef CONFIG_BLK_DEV_INITRD
+#ifdef CONFIG_INITRAMFS
 
 static int __init parse_tag_initrd(const bp_tag_t* tag)
 {
@@ -114,7 +114,7 @@ static int __init parse_tag_initrd(const bp_tag_t* tag)
 
 __tagtable(BP_TAG_INITRD, parse_tag_initrd);
 
-#endif /* CONFIG_BLK_DEV_INITRD */
+#endif /* CONFIG_INITRAMFS */
 
 #ifdef CONFIG_USE_OF
 
@@ -289,7 +289,7 @@ void __init setup_arch(char **cmdline_p)
 
 	/* Reserve some memory regions */
 
-#ifdef CONFIG_BLK_DEV_INITRD
+#ifdef CONFIG_INITRAMFS
 	if (virt_external_initramfs_start < virt_external_initramfs_end &&
 	    !mem_reserve(__pa(virt_external_initramfs_start), __pa(virt_external_initramfs_end)))
 		initramfs_below_start_ok = 1;
diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index b594780a57d7..5bb21236e1b1 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -374,7 +374,7 @@ config ARCH_HAS_ACPI_TABLE_UPGRADE
 
 config ACPI_TABLE_UPGRADE
 	bool "Allow upgrading ACPI tables via initrd"
-	depends on BLK_DEV_INITRD && ARCH_HAS_ACPI_TABLE_UPGRADE
+	depends on INITRAMFS && ARCH_HAS_ACPI_TABLE_UPGRADE
 	default y
 	help
 	  This option provides functionality to upgrade arbitrary ACPI tables
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 1dcaaea1dcfb..cbe94aeca879 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -807,7 +807,7 @@ int __init efi_config_parse_tables(const efi_config_table_t *config_tables,
 		}
 	}
 
-	if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) &&
+	if (IS_ENABLED(CONFIG_INITRAMFS) &&
 	    initrd != EFI_INVALID_TABLE_ADDR && phys_external_initramfs_size == 0) {
 		struct linux_efi_initrd *tbl;
 
diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index 6d89bf941d57..32adbeab156b 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -611,7 +611,7 @@ efi_status_t efi_load_initrd(efi_loaded_image_t *image,
 	efi_status_t status = EFI_SUCCESS;
 	struct linux_efi_initrd initrd, *tbl;
 
-	if (!IS_ENABLED(CONFIG_BLK_DEV_INITRD))
+	if (!IS_ENABLED(CONFIG_INITRAMFS))
 		return EFI_SUCCESS;
 
 	status = efi_load_initrd_dev_path(&initrd, hard_limit);
diff --git a/drivers/gpu/drm/ci/arm.config b/drivers/gpu/drm/ci/arm.config
index 411e814819a8..71e986de8fb7 100644
--- a/drivers/gpu/drm/ci/arm.config
+++ b/drivers/gpu/drm/ci/arm.config
@@ -8,7 +8,7 @@ CONFIG_ZRAM=y
 CONFIG_ZSMALLOC_STAT=y
 
 # abootimg with a 'dummy' rootfs fails with root=/dev/nfs
-CONFIG_BLK_DEV_INITRD=n
+CONFIG_INITRAMFS=n
 
 CONFIG_DEVFREQ_GOV_PERFORMANCE=y
 CONFIG_DEVFREQ_GOV_POWERSAVE=y
diff --git a/drivers/gpu/drm/ci/arm64.config b/drivers/gpu/drm/ci/arm64.config
index fddfbd4d2493..488be9cade47 100644
--- a/drivers/gpu/drm/ci/arm64.config
+++ b/drivers/gpu/drm/ci/arm64.config
@@ -8,7 +8,7 @@ CONFIG_ZRAM=y
 CONFIG_ZSMALLOC_STAT=y
 
 # abootimg with a 'dummy' rootfs fails with root=/dev/nfs
-CONFIG_BLK_DEV_INITRD=n
+CONFIG_INITRAMFS=n
 
 CONFIG_DEVFREQ_GOV_PERFORMANCE=y
 CONFIG_DEVFREQ_GOV_POWERSAVE=y
diff --git a/drivers/gpu/drm/ci/x86_64.config b/drivers/gpu/drm/ci/x86_64.config
index 8eaba388b141..147bab7801f1 100644
--- a/drivers/gpu/drm/ci/x86_64.config
+++ b/drivers/gpu/drm/ci/x86_64.config
@@ -13,7 +13,7 @@ CONFIG_OF=y
 CONFIG_CROS_EC=y
 
 # abootimg with a 'dummy' rootfs fails with root=/dev/nfs
-CONFIG_BLK_DEV_INITRD=n
+CONFIG_INITRAMFS=n
 
 CONFIG_DEVFREQ_GOV_PERFORMANCE=y
 CONFIG_DEVFREQ_GOV_POWERSAVE=y
diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 2e73de8a1bbe..13a38d18f559 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -781,7 +781,7 @@ static void __init early_init_dt_check_for_initrd(unsigned long node)
 	int len;
 	const __be32 *prop;
 
-	if (!IS_ENABLED(CONFIG_BLK_DEV_INITRD))
+	if (!IS_ENABLED(CONFIG_INITRAMFS))
 		return;
 
 	pr_debug("Looking for initrd properties... ");
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index a6bd2ff46f7e..8268da2fe716 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -966,7 +966,7 @@ defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_PROPELLER_CLANG)
 		BOUNDED_SECTION_POST_LABEL(.kunit_init_test_suites, \
 				__kunit_init_suites, _start, _end)
 
-#ifdef CONFIG_BLK_DEV_INITRD
+#ifdef CONFIG_INITRAMFS
 #define INIT_RAM_FS							\
 	. = ALIGN(4);							\
 	__builtin_initramfs_start = .;						\
diff --git a/include/linux/initramfs.h b/include/linux/initramfs.h
index e9f523917a02..e5694c006b16 100644
--- a/include/linux/initramfs.h
+++ b/include/linux/initramfs.h
@@ -9,7 +9,7 @@ extern int initramfs_below_start_ok;
 extern unsigned long virt_external_initramfs_start, virt_external_initramfs_end;
 extern void free_initramfs_mem(unsigned long, unsigned long);
 
-#ifdef CONFIG_BLK_DEV_INITRD
+#ifdef CONFIG_INITRAMFS
 extern void __init reserve_initramfs_mem(void);
 extern void wait_for_initramfs(void);
 #else
diff --git a/init/.kunitconfig b/init/.kunitconfig
index acb906b1a5f9..ee36fbc94224 100644
--- a/init/.kunitconfig
+++ b/init/.kunitconfig
@@ -1,3 +1,3 @@
 CONFIG_KUNIT=y
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_INITRAMFS_TEST=y
diff --git a/init/Kconfig b/init/Kconfig
index 1c371dca7fd4..0e8352f611b6 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1434,7 +1434,7 @@ config RELAY
 
 	  If unsure, say N.
 
-config BLK_DEV_INITRD
+config INITRAMFS
 	bool "Initial RAM filesystem (initramfs) support"
 	help
 	  The initial RAM filesystem is a ramfs or tmpfs which is loaded by the
@@ -1445,7 +1445,7 @@ config BLK_DEV_INITRD
 
 	  If unsure say Y.
 
-if BLK_DEV_INITRD
+if INITRAMFS
 
 source "usr/Kconfig"
 
@@ -1453,7 +1453,7 @@ endif
 
 config BOOT_CONFIG
 	bool "Boot config support"
-	select BLK_DEV_INITRD if !BOOT_CONFIG_EMBED
+	select INITRAMFS if !BOOT_CONFIG_EMBED
 	help
 	  Extra boot config allows system admin to pass a config file as
 	  complemental extension of kernel cmdline when booting.
@@ -1507,7 +1507,7 @@ config INITRAMFS_PRESERVE_MTIME
 
 config INITRAMFS_TEST
 	bool "Test initramfs cpio archive extraction" if !KUNIT_ALL_TESTS
-	depends on BLK_DEV_INITRD && KUNIT=y
+	depends on INITRAMFS && KUNIT=y
 	default KUNIT_ALL_TESTS
 	help
 	  Build KUnit tests for initramfs. See Documentation/dev-tools/kunit
diff --git a/init/Makefile b/init/Makefile
index 09657c0274eb..6e5ca899b2a0 100644
--- a/init/Makefile
+++ b/init/Makefile
@@ -6,10 +6,10 @@
 ccflags-y := -fno-function-sections -fno-data-sections
 
 obj-y                          := main.o version.o mounts.o
-ifneq ($(CONFIG_BLK_DEV_INITRD),y)
+ifneq ($(CONFIG_INITRAMFS),y)
 obj-y                          += noinitramfs.o
 else
-obj-$(CONFIG_BLK_DEV_INITRD)   += initramfs.o
+obj-$(CONFIG_INITRAMFS)   += initramfs.o
 endif
 obj-$(CONFIG_GENERIC_CALIBRATE_DELAY) += calibrate.o
 obj-$(CONFIG_INITRAMFS_TEST)   += initramfs_test.o
diff --git a/init/main.c b/init/main.c
index 4212efb33e77..f2ac451dc5ee 100644
--- a/init/main.c
+++ b/init/main.c
@@ -263,7 +263,7 @@ static int __init loglevel(char *str)
 
 early_param("loglevel", loglevel);
 
-#ifdef CONFIG_BLK_DEV_INITRD
+#ifdef CONFIG_INITRAMFS
 static void * __init get_boot_config_from_initramfs(size_t *_size)
 {
 	u32 size, csum;
@@ -1046,7 +1046,7 @@ void start_kernel(void)
 	 */
 	locking_selftest();
 
-#ifdef CONFIG_BLK_DEV_INITRD
+#ifdef CONFIG_INITRAMFS
 	if (virt_external_initramfs_start && !initramfs_below_start_ok &&
 	    page_to_pfn(virt_to_page((void *)virt_external_initramfs_start)) < min_low_pfn) {
 		pr_crit("initramfs overwritten (0x%08lx < 0x%08lx) - disabling it.\n",
diff --git a/scripts/package/builddeb b/scripts/package/builddeb
index 3627ca227e5a..cb0e9cea223f 100755
--- a/scripts/package/builddeb
+++ b/scripts/package/builddeb
@@ -88,7 +88,7 @@ install_maint_scripts () {
 		export DEB_MAINT_PARAMS="\$*"
 
 		# Tell initramfs builder whether it's wanted
-		export INITRD=$(if_enabled_echo CONFIG_BLK_DEV_INITRD Yes No)
+		export INITRD=$(if_enabled_echo CONFIG_INITRAMFS Yes No)
 
 		# run-parts will error out if one of its directory arguments does not
 		# exist, so filter the list of hook directories accordingly.
diff --git a/tools/testing/selftests/bpf/config.aarch64 b/tools/testing/selftests/bpf/config.aarch64
index e1495a4bbc99..0cae14af2e1a 100644
--- a/tools/testing/selftests/bpf/config.aarch64
+++ b/tools/testing/selftests/bpf/config.aarch64
@@ -6,7 +6,7 @@ CONFIG_AUDIT=y
 CONFIG_BINFMT_MISC=y
 CONFIG_BLK_CGROUP=y
 CONFIG_BLK_DEV_BSGLIB=y
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_BLK_DEV_IO_TRACE=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_SD=y
diff --git a/tools/testing/selftests/bpf/config.ppc64el b/tools/testing/selftests/bpf/config.ppc64el
index 9acf389dc4ce..e04949103f02 100644
--- a/tools/testing/selftests/bpf/config.ppc64el
+++ b/tools/testing/selftests/bpf/config.ppc64el
@@ -1,7 +1,7 @@
 CONFIG_ALTIVEC=y
 CONFIG_AUDIT=y
 CONFIG_BLK_CGROUP=y
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BONDING=y
 CONFIG_BPF_JIT_ALWAYS_ON=y
diff --git a/tools/testing/selftests/bpf/config.riscv64 b/tools/testing/selftests/bpf/config.riscv64
index bb7043a80e1a..52b56ebe1f73 100644
--- a/tools/testing/selftests/bpf/config.riscv64
+++ b/tools/testing/selftests/bpf/config.riscv64
@@ -1,6 +1,6 @@
 CONFIG_AUDIT=y
 CONFIG_BLK_CGROUP=y
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BONDING=y
 CONFIG_BPF_JIT_ALWAYS_ON=y
diff --git a/tools/testing/selftests/bpf/config.s390x b/tools/testing/selftests/bpf/config.s390x
index 26c3bc2ce11d..db8ff885d0c2 100644
--- a/tools/testing/selftests/bpf/config.s390x
+++ b/tools/testing/selftests/bpf/config.s390x
@@ -1,7 +1,7 @@
 CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=y
 CONFIG_AUDIT=y
 CONFIG_BLK_CGROUP=y
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_BLK_DEV_IO_TRACE=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BONDING=y
diff --git a/tools/testing/selftests/kho/vmtest.sh b/tools/testing/selftests/kho/vmtest.sh
index ec70a17bd476..567e6936445d 100755
--- a/tools/testing/selftests/kho/vmtest.sh
+++ b/tools/testing/selftests/kho/vmtest.sh
@@ -58,7 +58,7 @@ function build_kernel() {
 
 	# enable initrd, KHO and KHO test in kernel configuration
 	tee "$kconfig" > "$kho_config" <<EOF
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_KEXEC_HANDOVER=y
 CONFIG_TEST_KEXEC_HANDOVER=y
 CONFIG_DEBUG_KERNEL=y
diff --git a/tools/testing/selftests/nolibc/Makefile.nolibc b/tools/testing/selftests/nolibc/Makefile.nolibc
index 0fb759ba992e..8d3e53406712 100644
--- a/tools/testing/selftests/nolibc/Makefile.nolibc
+++ b/tools/testing/selftests/nolibc/Makefile.nolibc
@@ -128,8 +128,8 @@ DEFCONFIG            = $(DEFCONFIG_$(XARCH))
 EXTRACONFIG_x32       = -e CONFIG_X86_X32_ABI
 EXTRACONFIG_arm       = -e CONFIG_NAMESPACES
 EXTRACONFIG_armthumb  = -e CONFIG_NAMESPACES
-EXTRACONFIG_m68k      = -e CONFIG_BLK_DEV_INITRD
-EXTRACONFIG_sh4       = -e CONFIG_BLK_DEV_INITRD -e CONFIG_CMDLINE_FROM_BOOTLOADER
+EXTRACONFIG_m68k      = -e CONFIG_INITRAMFS
+EXTRACONFIG_sh4       = -e CONFIG_INITRAMFS -e CONFIG_CMDLINE_FROM_BOOTLOADER
 EXTRACONFIG           = $(EXTRACONFIG_$(XARCH))
 
 # optional tests to run (default = all)
diff --git a/tools/testing/selftests/vsock/config b/tools/testing/selftests/vsock/config
index 5f0a4f17dfc9..57159a38229f 100644
--- a/tools/testing/selftests/vsock/config
+++ b/tools/testing/selftests/vsock/config
@@ -1,4 +1,4 @@
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_BPF=y
 CONFIG_BPF_SYSCALL=y
 CONFIG_BPF_JIT=y
diff --git a/tools/testing/selftests/wireguard/qemu/kernel.config b/tools/testing/selftests/wireguard/qemu/kernel.config
index 0a5381717e9f..d53d786ffe7c 100644
--- a/tools/testing/selftests/wireguard/qemu/kernel.config
+++ b/tools/testing/selftests/wireguard/qemu/kernel.config
@@ -69,7 +69,7 @@ CONFIG_TMPFS=y
 CONFIG_CONSOLE_LOGLEVEL_DEFAULT=15
 CONFIG_LOG_BUF_SHIFT=18
 CONFIG_PRINTK_TIME=y
-CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS=y
 CONFIG_LEGACY_VSYSCALL_NONE=y
 CONFIG_KERNEL_GZIP=y
 CONFIG_PANIC_ON_OOPS=y
diff --git a/usr/Makefile b/usr/Makefile
index f1779496bca7..d0cd88c26fd5 100644
--- a/usr/Makefile
+++ b/usr/Makefile
@@ -12,7 +12,7 @@ compress-$(CONFIG_INITRAMFS_COMPRESSION_LZO)	:= lzo
 compress-$(CONFIG_INITRAMFS_COMPRESSION_LZ4)	:= lz4
 compress-$(CONFIG_INITRAMFS_COMPRESSION_ZSTD)	:= zstd
 
-obj-$(CONFIG_BLK_DEV_INITRD) := initramfs_data.o
+obj-$(CONFIG_INITRAMFS) := initramfs_data.o
 
 $(obj)/initramfs_data.o: $(obj)/initramfs_inc_data
 
-- 
2.47.2


