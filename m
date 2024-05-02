Return-Path: <linux-fsdevel+bounces-18529-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D5E8BA319
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2024 00:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BCF11F21FEB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2024 22:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6D557CB5;
	Thu,  2 May 2024 22:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y6CY/FHc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928B957CA1;
	Thu,  2 May 2024 22:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714688740; cv=none; b=hoN6FMsbib7RrTEkrm4xTj929mtmSmvBFDHSF031V4bWjqczKOqOtRypkpmSo2bcKb31OxOkhvSJNAjilVQz+qIZ4BP8dK5Trm+IvdLY2VI/Uc1WGDYJwETdOTvMQFGFbars7lx2d1UpyCCALGxHfok/K1uNt6ty3S+ppiO2Wjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714688740; c=relaxed/simple;
	bh=eDGVsHioAAo/vf/7wBtnBG4uUJlX8jpAESzfNt3wp0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bTzVspEBP7WB1u7CyXoe3BsO5zMewyHONcYPpgrE57l8crYz52t3RaH34d65YyuuXGcKfR83sgerzP90hl0/rqFXkCwORo/fQGE3ATeoKE9bZ8mUa5NTfN2Z6oHInSz31qvsJOmKdkphU5sJnoh3nKR49vyMRgZrtPiL86PBXB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y6CY/FHc; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-23d4a841361so1284452fac.2;
        Thu, 02 May 2024 15:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714688737; x=1715293537; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cOKlIbmXyMNXTVDeqMbLyxE1OQ/hUFeaOYrKeFPij4M=;
        b=Y6CY/FHcdz5k8qVAdcvwqpaLu7oO6TskYq2UKCOXQhlaHFivMt/UZnaqwfr6lt/GxQ
         ahpz/SxWRUeqJabZOFmZtU2j7g6+dqs5/vP0YoXH4LdfNQ0QCZVjHaDVylfwxgUP51Ee
         DwmdKo7G7sHQY9Gstpj06p/2ZNbwb0PZZhseGRaOvyvsU1mC2crw/IRDtW4PWVzpyve9
         dNW0xnOfhOi6Ylk0G7BzY+ivTWqm05P2CtiVrXWUPj8RZ+qio7Zbtol8qiuhX7fvIULH
         tflHD43hFAvTowLo8jxvDwStYj1h4FS4nUm2TpkPRA9SxfzeCdv7l+om2EuEA0eTm/4/
         bJXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714688737; x=1715293537;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cOKlIbmXyMNXTVDeqMbLyxE1OQ/hUFeaOYrKeFPij4M=;
        b=uGW8FeCp2cBkFsZ0jjds80QWAnw64mKFP6vFgCbIjxPAtqBFgfxzkowEOuSUkKOgjo
         IIdHeRIsstHqDf6NwkUgQ//ZSpqjqlUmmZAgNRw/VnPqIp62J1oD353v8W/3paw+3/0X
         mxdGFW74J5/SqU0YJWVS9fiN4yHcJMJXL1KT0WVJG0cZZZ3q2lFjkxE9FPYWhRRwW4XT
         Spn7wdfYILFTvMVMlAOP0+F1Q+KRxsIODJPmz93DVsYfnPBcxsHOXVV/GkbM8sCkeNOJ
         oURWWrt496oJmTnDe1ADLFh/kqbtrQk9dPy0sWvikU1lwhJcAyvl//iudTn3ZSv24dIS
         3Usw==
X-Forwarded-Encrypted: i=1; AJvYcCVVpie8zwO/rgEZ7hSmxDr4/yCE5snnbywG0d1e8dvjZbkzb1lfIgzti8HrgIN6eIziM1EOqkWesww14Kl3V7r+4Nc/e8dQQeDshNmTbhMcn7QTz2hM05jLECxTi3NimGJl7z3a0spEkg==
X-Gm-Message-State: AOJu0YwdfVDcnisTJDoi9cM9JpLo8aJZNYQrhDXvDxtuCbrG5Mxsql2B
	m2zLU2QQlU44+tyVWZPZKgQNF6yaBhuo5QRy1iKLn0lwLdkp+7EA
X-Google-Smtp-Source: AGHT+IEwgDWoCry6Pq2qZp46Ox6bz4a0XeU+HDndM+eo6gMtEhnY+zVwPSwOIHNmTdAftkObEmqa/Q==
X-Received: by 2002:a05:6870:9346:b0:22e:c6b2:849e with SMTP id j6-20020a056870934600b0022ec6b2849emr1448527oak.9.1714688737537;
        Thu, 02 May 2024 15:25:37 -0700 (PDT)
Received: from Borg-10.local (syn-070-114-203-196.res.spectrum.com. [70.114.203.196])
        by smtp.gmail.com with ESMTPSA id el7-20020a056830718700b006eb92d716bdsm369993otb.15.2024.05.02.15.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 15:25:36 -0700 (PDT)
Sender: John Groves <grovesaustin@gmail.com>
Date: Thu, 2 May 2024 17:25:33 -0500
From: John Groves <John@groves.net>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Jonathan Corbet <corbet@lwn.net>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dan Williams <dan.j.williams@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>, 
	linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev, 
	John Groves <jgroves@micron.com>, john@jagalactic.com, Dave Chinner <david@fromorbit.com>, 
	Christoph Hellwig <hch@infradead.org>, dave.hansen@linux.intel.com, gregory.price@memverge.com, 
	Randy Dunlap <rdunlap@infradead.org>, Jerome Glisse <jglisse@google.com>, 
	Aravind Ramesh <arramesh@micron.com>, Ajay Joshi <ajayjoshi@micron.com>, 
	Eishan Mirakhur <emirakhur@micron.com>, Ravi Shankar <venkataravis@micron.com>, 
	Srinivasulu Thanneeru <sthanneeru@micron.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Chandan Babu R <chandanbabu@kernel.org>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, "Darrick J . Wong" <djwong@kernel.org>, 
	Kent Overstreet <kent.overstreet@linux.dev>, Steve French <stfrench@microsoft.com>, 
	Nathan Lynch <nathanl@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Julien Panis <jpanis@baylibre.com>, 
	Stanislav Fomichev <sdf@google.com>, Dongsheng Yang <dongsheng.yang@easystack.cn>
Subject: Re: [RFC PATCH v2 07/12] famfs prep: Add fs/super.c:kill_char_super()
Message-ID: <eiobix2ovov5gywodc4bqyhhv7mshe7bvbp2ekewrvpdlnz5gh@6ryuna2lfpt7>
References: <cover.1714409084.git.john@groves.net>
 <a702d42c922737c4f8278617db69ce2b6d813c5f.1714409084.git.john@groves.net>
 <20240502181716.GG2118490@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502181716.GG2118490@ZenIV>

On 24/05/02 07:17PM, Al Viro wrote:
> On Mon, Apr 29, 2024 at 12:04:23PM -0500, John Groves wrote:
> > Famfs needs a slightly different kill_super variant than already existed.
> > Putting it local to famfs would require exporting d_genocide(); this
> > seemed a bit cleaner.
> 
> What's wrong with kill_litter_super()?

I struggled with that, I don't have my head fully around the superblock
handling code.

But when I replace kill_char_super() with kill_litter_super()...

- first mount works
- first umount works
- second mount works
- second umount does this (which I don't properly understand):

May 02 17:21:58 f39-dev1 kernel: ------------[ cut here ]------------
May 02 17:21:58 f39-dev1 kernel: ida_free called for id=1 which is not allocated.
May 02 17:21:58 f39-dev1 kernel: WARNING: CPU: 1 PID: 1173 at lib/idr.c:525 ida_free+0xe3/0x140
May 02 17:21:58 f39-dev1 kernel: Modules linked in: famfs rpcsec_gss_krb5 auth_rpcgss nfsv4 dns_resolver nfs lockd grace netfs qrtr rfkill snd_hda_codec_generic intel_rapl_msr sunrpc snd_hda_intel snd_intel_dspcfg intel_rapl_common snd_intel_sdw_acpi snd_hda_codec kmem snd_hda_core device_dax kvm_intel snd_hwdep iTCO_wdt kvm intel_pmc_bxt snd_seq iTCO_vendor_support dax_hmem snd_seq_device cxl_acpi cxl_core rapl snd_pcm snd_timer snd einj pcspkr soundcore i2c_i801 lpc_ich i2c_smbus vfat fat virtio_balloon joydev fuse loop zram xfs crct10dif_pclmul crc32_pclmul crc32c_intel polyval_clmulni polyval_generic ghash_clmulni_intel sha512_ssse3 sha256_ssse3 sha1_ssse3 virtio_net virtio_console net_failover virtio_gpu failover virtio_blk virtio_dma_buf serio_raw scsi_dh_rdac scsi_dh_emc scsi_dh_alua dm_multipath qemu_fw_cfg
May 02 17:21:58 f39-dev1 kernel: CPU: 1 PID: 1173 Comm: umount Tainted: G        W          6.9.0-rc5+ #266
May 02 17:21:58 f39-dev1 kernel: Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS edk2-20230301gitf80f052277c8-26.fc38 03/01/2023
May 02 17:21:58 f39-dev1 kernel: RIP: 0010:ida_free+0xe3/0x140
May 02 17:21:58 f39-dev1 kernel: Code: 8d 7d a0 e8 9f 2e 02 00 eb 62 41 83 fe 3e 76 3c 48 8b 7d a0 4c 89 ee e8 5b 73 04 00 89 de 48 c7 c7 60 51 be 82 e8 3d 03 0b ff <0f> 0b 48 8b 45 d8 65 48 2b 04 25 28 00 00 00 75 3f 48 83 c4 40 5b
May 02 17:21:58 f39-dev1 kernel: RSP: 0018:ffffc90000c37c50 EFLAGS: 00010286
May 02 17:21:58 f39-dev1 kernel: RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
May 02 17:21:58 f39-dev1 kernel: RDX: 0000000000000002 RSI: 0000000000000027 RDI: 00000000ffffffff
May 02 17:21:58 f39-dev1 kernel: RBP: ffffc90000c37cb0 R08: 0000000000000000 R09: 0000000000000003
May 02 17:21:58 f39-dev1 kernel: R10: ffffc90000c37aa0 R11: ffffffff82f3c3a8 R12: 00c7fffffffffffc
May 02 17:21:58 f39-dev1 kernel: R13: 0000000000000202 R14: 0000000000000001 R15: 0000000000000000
May 02 17:21:58 f39-dev1 kernel: FS:  00007f0ff81c0800(0000) GS:ffff88886fc80000(0000) knlGS:0000000000000000
May 02 17:21:58 f39-dev1 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
May 02 17:21:58 f39-dev1 kernel: CR2: 00007f6b841c95a8 CR3: 00000001254c8001 CR4: 0000000000170ef0
May 02 17:21:58 f39-dev1 kernel: Call Trace:
May 02 17:21:58 f39-dev1 kernel:  <TASK>
May 02 17:21:58 f39-dev1 kernel:  ? show_regs+0x64/0x70
May 02 17:21:58 f39-dev1 kernel:  ? __warn+0x88/0x130
May 02 17:21:58 f39-dev1 kernel:  ? ida_free+0xe3/0x140
May 02 17:21:58 f39-dev1 kernel:  ? report_bug+0x192/0x1c0
May 02 17:21:58 f39-dev1 kernel:  ? handle_bug+0x44/0x90
May 02 17:21:58 f39-dev1 kernel:  ? exc_invalid_op+0x18/0x70
May 02 17:21:58 f39-dev1 kernel:  ? asm_exc_invalid_op+0x1b/0x20
May 02 17:21:58 f39-dev1 kernel:  ? ida_free+0xe3/0x140
May 02 17:21:58 f39-dev1 kernel:  kill_litter_super+0x4c/0x60
May 02 17:21:58 f39-dev1 kernel:  famfs_kill_sb+0x57/0x60 [famfs]
May 02 17:21:58 f39-dev1 kernel:  deactivate_locked_super+0x35/0xb0
May 02 17:21:58 f39-dev1 kernel:  deactivate_super+0x40/0x50
May 02 17:21:58 f39-dev1 kernel:  cleanup_mnt+0xc3/0x160
May 02 17:21:58 f39-dev1 kernel:  __cleanup_mnt+0x12/0x20
May 02 17:21:58 f39-dev1 kernel:  task_work_run+0x60/0x90
May 02 17:21:58 f39-dev1 kernel:  syscall_exit_to_user_mode+0x21a/0x220
May 02 17:21:58 f39-dev1 kernel:  do_syscall_64+0x8d/0x180
May 02 17:21:58 f39-dev1 kernel:  ? do_faccessat+0x1b8/0x2e0
May 02 17:21:58 f39-dev1 kernel:  ? syscall_exit_to_user_mode+0x7c/0x220
May 02 17:21:58 f39-dev1 kernel:  ? do_syscall_64+0x8d/0x180
May 02 17:21:58 f39-dev1 kernel:  ? syscall_exit_to_user_mode+0x7c/0x220
May 02 17:21:58 f39-dev1 kernel:  ? do_syscall_64+0x8d/0x180
May 02 17:21:58 f39-dev1 kernel:  ? do_syscall_64+0x8d/0x180
May 02 17:21:58 f39-dev1 kernel:  ? do_user_addr_fault+0x315/0x6e0
May 02 17:21:58 f39-dev1 kernel:  ? irqentry_exit_to_user_mode+0x71/0x220
May 02 17:21:58 f39-dev1 kernel:  ? irqentry_exit+0x3b/0x50
May 02 17:21:58 f39-dev1 kernel:  ? exc_page_fault+0x90/0x190
May 02 17:21:58 f39-dev1 kernel:  entry_SYSCALL_64_after_hwframe+0x76/0x7e
May 02 17:21:58 f39-dev1 kernel: RIP: 0033:0x7f0ff83df41b
May 02 17:21:58 f39-dev1 kernel: Code: c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 f3 0f 1e fa 31 f6 e9 05 00 00 00 0f 1f 44 00 00 f3 0f 1e fa b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 05 c3 0f 1f 40 00 48 8b 15 e1 19 0c 00 f7 d8
May 02 17:21:58 f39-dev1 kernel: RSP: 002b:00007fffe039cfd8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
May 02 17:21:58 f39-dev1 kernel: RAX: 0000000000000000 RBX: 0000555ad6c2fb90 RCX: 00007f0ff83df41b
May 02 17:21:58 f39-dev1 kernel: RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000555ad6c34ba0
May 02 17:21:58 f39-dev1 kernel: RBP: 00007fffe039d0b0 R08: 0000000000000020 R09: 0000000000000001
May 02 17:21:58 f39-dev1 kernel: R10: 0000000000000004 R11: 0000000000000246 R12: 0000555ad6c2fc90
May 02 17:21:58 f39-dev1 kernel: R13: 0000000000000000 R14: 0000555ad6c34ba0 R15: 0000555ad6c2ffa0
May 02 17:21:58 f39-dev1 kernel:  </TASK>
May 02 17:21:58 f39-dev1 kernel: ---[ end trace 0000000000000000 ]---


With kill_char_super(), it can mount and dismount for days with no
issues that I have seen.

Thanks,
John



