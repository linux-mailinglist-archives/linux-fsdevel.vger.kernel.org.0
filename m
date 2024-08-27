Return-Path: <linux-fsdevel+bounces-27275-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 521FA95FFD4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 05:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFB2D1F234B1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 03:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B56D1B977;
	Tue, 27 Aug 2024 03:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OQdrtPdk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1247518052;
	Tue, 27 Aug 2024 03:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724729571; cv=none; b=LEv7iu9AVgLCvcfrkn+I/LB6ZVEyMbRF4nrIJ85BWDPCBqEdhk9YyyIdAbveci96cHAUMKuaS//JX4C6P3/Mm6Ub8+N2WTpevCrEtMZPOZEFtn6AvuyJ+R2EoTlYVQGP/fhY+9+/Vf2uH/hsagzZcphY7HhVQGaalgocz3Wxt4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724729571; c=relaxed/simple;
	bh=4vgGJ/I77/7/F8MH5TlN3hIe1E8PB0zznMpQ11UTzCw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KcnfauLBRu06JDEJxGKjux19s4Rw+ymP3mW0DIYWDK3hr1aTijpwxpUr2LAUX64unxBdUC+5TdPK1o1xE86UV7xd+5v/5ZpsRTGNnTSwyekPdpHOjowQBGHgXzHwiptyIu5KTgFAGWVkoPN4iZN+Cef0T6eAohInU1wmo8h6Moc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OQdrtPdk; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5334adf7249so5895086e87.3;
        Mon, 26 Aug 2024 20:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724729567; x=1725334367; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2xbzKRYt6Qy3ZNV+HFmoHf+KHGRhq2St3sDinQito6s=;
        b=OQdrtPdkb9OWu8/gSfCo/HwJ1STN0mRG12t9Xi+fwrHGf9bwGTjL+Id6b+pAVWUQcu
         wVKNKUDq/4j24952AFxbUi8I4uUEScFl856JqOican3NOoJP7jpFzcAkoX34Eawewlro
         i6KAcp0k/QTHieLuQgM9yVZxq7iy+zwsF7rqDK2VLTXJAn2Lvpl1Fofu2s1+Eg2GTcz9
         4awmVBUtceRrdSAkg9/vUeduMSw4m1j0BDaVr35nG5BCdf3Eo3HnbBDbyvhRqJ8ldH7/
         NuYn5d9+JHLie15beamxZkhDBl1X8hIVGGwunR7o7sTqXzAEAXau3STQVgr2IhJhjabH
         icdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724729567; x=1725334367;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2xbzKRYt6Qy3ZNV+HFmoHf+KHGRhq2St3sDinQito6s=;
        b=Z7+4k2otTbEkPGOJx8OMakOMIGhyoq9USZpaw3Ej/5Q4//QR3RzbD/ZEE+kMR+GHyV
         LefZk0ZMUxSZXWP92Zii9/K0EZjgW7PD02ZGQrJ/fNy4sd//H1pF3/WYrx5xbn9cHbap
         rtwqH/pe5G2qi86i+mhaLe9wdiyMXTgYK+WNMKbReQQHgI4fktCoT4g0a8UQxR0irH2b
         ck9/hVM3qkREVQzoqd+mGGkYrxMN4kSYuZiglMXiN1WDLcCTvXRa1O1MwDR6wPlWkSkk
         pBW9UwnMYJcQXBtGAeNqHSHkj1pjcZWpGG4sDhbM8yll/2uo0TlUecC+FkwsLUFYvFBU
         x23A==
X-Forwarded-Encrypted: i=1; AJvYcCXoX2AI1a2uWQz0APtRx2GdkU3rUUZ2WrXHz4b01Ufb0zwIS+wRtP8FkM7osGxpaVeeHRBO4ZTVGMgD@vger.kernel.org, AJvYcCXrk3FctHlap4msM098zdbTbIEQu8kT1l6l/VTrhzyeZ6504u6DC4g3WdK0q9N6fsHuf2LfD2LkHc8q1BzPxQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwPeQZVIyzngPcwJRrH9SHKIHGU65aaLz0ePa1BDd2/dYrS4AMT
	SLcKAL0Fj2+FwU4hdkgBzMKaqK41S0ImBiKYBCLDE909u+A3Li80Q3wC48cNVif3TimS4B/gAZc
	trdsktCt6KKPSHm2w+qDIwwD1AcA=
X-Google-Smtp-Source: AGHT+IGlOWGqqXh1+AAccZrVim+pgf7gaTU+IPPNG2QORVDEu9THbJF91fyJWwiE2/xBAQh6UFqMh3R4jhgIzDZyGwA=
X-Received: by 2002:a05:6512:230a:b0:52b:9c8a:734f with SMTP id
 2adb3069b0e04-5344e500664mr813134e87.50.1724729566569; Mon, 26 Aug 2024
 20:32:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <37fncjpgsq45becdf2pdju0idf3hj3dtmb@sonic.net>
In-Reply-To: <37fncjpgsq45becdf2pdju0idf3hj3dtmb@sonic.net>
From: Steve French <smfrench@gmail.com>
Date: Mon, 26 Aug 2024 22:32:35 -0500
Message-ID: <CAH2r5mtZAGg4kC8ERMog=X8MRoup3Wcp1YC7j+d08pXsifXCCg@mail.gmail.com>
Subject: Re: [REGRESSION] cifs: Subreq overread in dmesg, invalid argument &
 no data available in apps
To: Forest <forestix@nom.one>
Cc: David Howells <dhowells@redhat.com>, Steve French <sfrench@samba.org>, 
	Shyam Prasad N <nspmangalore@gmail.com>, Rohith Surabattula <rohiths.msft@gmail.com>, 
	Jeff Layton <jlayton@kernel.org>, linux-cifs@vger.kernel.org, netfs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yes - thanks for reporting this.  I can reproduce this (although
slightly different error on "cat foo" with 6.11-rc5 vs. later patches
in for-next - I get ""No data available" now with some of David's
additional patches instead of "Invalid argument" which you get on
6.11-rc5).

This problem looks related to something that David has discussed
earlier - on the wire (with 6.11-rc5) we see SMB3 READ with the server
returning  "STATUS_INVALID_PARAMETER" - there are actually two reads
in a row that are similar (1MB at offset 0), the first succeeds, the
second request  has a "credit charge" of 1 (instead of 16 which is
what I would have expected)  which is likely related to the cause of
the problem (and the second read fails).

It looks like some of this is fixed with David's patch:

https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/commi=
t/?h=3Dnetfs-fixes&id=3D78d0d91398ad7bc37e73cdda65602ac8b6d675bb

0014-cifs-Fix-lack-of-credit-renegotiation-on-read-retry.patch

It is possible that the second part of this is fixed with:

https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/commi=
t/?h=3Dnetfs-fixes&id=3De81de4d9db1c25dc3e9feb21548fc5f3e2b3ad8e

Is there an easy way for you to retry with those two patches?

On Sun, Aug 25, 2024 at 6:26=E2=80=AFPM Forest <forestix@nom.one> wrote:
>
> #regzbot introduced: e3786b29c54c
>
> Dear maintainers,
>
> Recent kernel release candidates have a cifs regression that produces
> unexpected errors in userspace and a WARNING (with stack trace) in dmesg.
>
> I can consistently reproduce it with these commands on a mounted Samba
> share:
>
>
> $ echo hello > foo
> $ ls -l foo
> -rw-r----- 1 user user 6 Aug 25 15:41 foo
> $ cat foo
> cat: foo: Invalid argument
> $ xxd foo
> 00000000: 6865 6c6c 6f0a 0000 0000 0000 0000 0000  hello...........
> 00000010: 0000 0000 0000 0000 0000 0000 0000 0000  ................
> (...more null bytes...)
> 00001fe0: 0000 0000 0000 0000 0000 0000 0000 0000  ................
> 00001ff0: 0000 0000 0000 0000 0000 0000 0000 0000  ................
> xxd: No data available
>
>
> The xxd command above also triggers these kernel log messages...
>
>   Subreq overread: R3[1] 312 > 8192 - 7956
>   WARNING: CPU: 30 PID: 421 at fs/netfs/io.c:495
>
> ...followed by the usual module list and stack trace.
>
>
> The bug is present in kernel v6.11-rc5, but not the 6.10 series.
>
> Git bisect says:
>
> e3786b29c54cdae3490b07180a54e2461f42144c is the first bad commit
> commit e3786b29c54cdae3490b07180a54e2461f42144c
> Author: Dominique Martinet <asmadeus@codewreck.org>
> Date:   Thu Aug 8 14:29:38 2024 +0100
>     9p: Fix DIO read through netfs
>
>
> Here's the full dmesg output when I run xxd on kernel v6.11-rc5:
>
> [   48.137018] ------------[ cut here ]------------
> [   48.137021] Subreq overread: R3[1] 312 > 8192 - 7956
> [   48.137029] WARNING: CPU: 30 PID: 421 at fs/netfs/io.c:495 netfs_subre=
q_terminated+0x276/0x2d0 [netfs]
> [   48.137046] Modules linked in: rfcomm algif_hash algif_skcipher af_alg=
 cmac nls_utf8 cifs cifs_arc4 nls_ucs2_utils cifs_md4 dns_resolver netfs nf=
t_masq nft_chain_nat nf_nat
> nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 bridge stp llc nf_tables nfnet=
link nvme_fabrics essiv authenc crypto_null snd_seq_dummy snd_hrtimer snd_s=
eq snd_seq_device qrtr zstd
> zram bnep binfmt_misc nls_ascii nls_cp437 vfat fat mt7921e snd_hda_codec_=
realtek mt7921_common snd_hda_codec_generic mt792x_lib snd_hda_scodec_compo=
nent mt76_connac_lib
> snd_hda_codec_hdmi mt76 btusb snd_hda_intel amd_atl btrtl intel_rapl_msr =
snd_intel_dspcfg intel_rapl_common snd_intel_sdw_acpi btintel amd64_edac ed=
ac_mce_amd mac80211 btbcm
> snd_hda_codec asus_nb_wmi eeepc_wmi btmtk asus_wmi kvm_amd snd_hda_core s=
parse_keymap bluetooth libarc4 snd_hwdep platform_profile kvm cfg80211 snd_=
pcm battery wmi_bmof rapl
> snd_timer sp5100_tco ccp pcspkr watchdog snd k10temp rfkill soundcore joy=
dev sg evdev nct6775 nct6775_core hwmon_vid msr parport_pc ppdev lp parport=
 loop efi_pstore
> [   48.137103]  configfs ip_tables x_tables autofs4 ext4 mbcache jbd2 btr=
fs dm_crypt dm_mod efivarfs raid10 raid456 async_raid6_recov async_memcpy a=
sync_pq async_xor async_tx
> xor raid6_pq libcrc32c crc32c_generic raid1 raid0 md_mod hid_generic usbh=
id hid amdgpu amdxcp drm_exec gpu_sched drm_buddy i2c_algo_bit drm_suballoc=
_helper drm_display_helper
> sd_mod cec crct10dif_pclmul rc_core crc32_pclmul xhci_pci drm_ttm_helper =
crc32c_intel ttm ahci xhci_hcd drm_kms_helper libahci r8169 ghash_clmulni_i=
ntel libata sha512_ssse3
> realtek nvme mdio_devres sha256_ssse3 drm usbcore scsi_mod sha1_ssse3 i2c=
_piix4 libphy video nvme_core i2c_smbus usb_common scsi_common crc16 wmi gp=
io_amdpt gpio_generic button
> aesni_intel gf128mul crypto_simd cryptd
> [   48.137148] CPU: 30 UID: 0 PID: 421 Comm: kworker/30:1 Not tainted 6.1=
1.0-rc5 #3
> [   48.137150] Hardware name: ASUS System XXXXXXXXXX
> [   48.137151] Workqueue: cifsiod smb2_readv_worker [cifs]
> [   48.137176] RIP: 0010:netfs_subreq_terminated+0x276/0x2d0 [netfs]
> [   48.137182] Code: 66 ff ff ff 0f 1f 44 00 00 e9 5c ff ff ff 48 89 f1 0=
f b7 93 86 00 00 00 8b b5 ac 01 00 00 48 c7 c7 78 81 7a c2 e8 ba 68 2f da <=
0f> 0b 48 8b 43 70 31 d2 4c
> 8d ab 98 00 00 00 66 89 93 84 00 00 00
> [   48.137183] RSP: 0018:ffffad8942637e58 EFLAGS: 00010282
> [   48.137185] RAX: 0000000000000000 RBX: ffff9d09639a7200 RCX: 000000000=
0000027
> [   48.137186] RDX: ffff9d107e721788 RSI: 0000000000000001 RDI: ffff9d107=
e721780
> [   48.137187] RBP: ffff9d094bf38a00 R08: 0000000000000000 R09: 000000000=
0000003
> [   48.137187] R10: ffffad8942637ce8 R11: ffff9d109de3cfe8 R12: 000000000=
0000001
> [   48.137188] R13: ffff9d095fcf6000 R14: ffff9d09639a7208 R15: 000000000=
0000000
> [   48.137189] FS:  0000000000000000(0000) GS:ffff9d107e700000(0000) knlG=
S:0000000000000000
> [   48.137190] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   48.137191] CR2: 000055d1a3402760 CR3: 00000006b0222000 CR4: 000000000=
0750ef0
> [   48.137192] PKRU: 55555554
> [   48.137193] Call Trace:
> [   48.137194]  <TASK>
> [   48.137197]  ? __warn+0x80/0x120
> [   48.137201]  ? netfs_subreq_terminated+0x276/0x2d0 [netfs]
> [   48.137207]  ? report_bug+0x164/0x190
> [   48.137210]  ? prb_read_valid+0x1b/0x30
> [   48.137213]  ? handle_bug+0x41/0x70
> [   48.137215]  ? exc_invalid_op+0x17/0x70
> [   48.137216]  ? asm_exc_invalid_op+0x1a/0x20
> [   48.137220]  ? netfs_subreq_terminated+0x276/0x2d0 [netfs]
> [   48.137225]  ? netfs_subreq_terminated+0x276/0x2d0 [netfs]
> [   48.137230]  process_one_work+0x179/0x390
> [   48.137233]  worker_thread+0x249/0x350
> [   48.137235]  ? __pfx_worker_thread+0x10/0x10
> [   48.137237]  kthread+0xcf/0x100
> [   48.137240]  ? __pfx_kthread+0x10/0x10
> [   48.137242]  ret_from_fork+0x31/0x50
> [   48.137244]  ? __pfx_kthread+0x10/0x10
> [   48.137246]  ret_from_fork_asm+0x1a/0x30
> [   48.137250]  </TASK>
> [   48.137251] ---[ end trace 0000000000000000 ]---
>


--=20
Thanks,

Steve

