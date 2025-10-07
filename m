Return-Path: <linux-fsdevel+bounces-63542-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D345ABC1192
	for <lists+linux-fsdevel@lfdr.de>; Tue, 07 Oct 2025 13:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F5F43B2FBA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Oct 2025 11:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6075A2D94B8;
	Tue,  7 Oct 2025 11:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=imp.ch header.i=@imp.ch header.b="dC3oAYGx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from thor.imp.ch (thor.imp.ch [157.161.4.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E932135C5;
	Tue,  7 Oct 2025 11:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.161.4.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759835456; cv=none; b=gPqf2aMV2gXL8hyF8cnmjL+/xN64YqAdlCFAp27qiXtZWumVOITI8ARxEH3ARC4+mMGnAqfhQiZd8C7swUnzWoxZyFtjN8cL5mVwW4VqouYioQT0syfFxA5Z21VOwUfFMWXnN3SlpwIP08S8IVVh5YR4RYGX7MlG3HgiM71A+e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759835456; c=relaxed/simple;
	bh=2W2yWEGbBMmupctI/z+HyX+1qJxWGAY6E3Fc30AVGgA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ENYdb+VbwlDySezBOU/QPD304dNB71RDtFdUhjBRx0mVQBx2duYpGoHJuD+41xQcK9I/l+1V0ZujgU3kyKhDcHpOKfRik98q3Hw/dfPOB21/KESMmZGrz+PWi1hEeCB5uyKaHyG/EvCWHIfnaHZbJgyJdglmfMWbhCLeaStKHM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imp.ch; spf=pass smtp.mailfrom=imp.ch; dkim=pass (1024-bit key) header.d=imp.ch header.i=@imp.ch header.b=dC3oAYGx; arc=none smtp.client-ip=157.161.4.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imp.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=imp.ch
Received: from go.imp.ch (go.imp.ch [IPv6:2001:4060:1:4133:f8d3:e3ff:fee7:5808])
	by thor.imp.ch (8.18.1/8.13.3) with ESMTPS id 597BAA3t073771
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Tue, 7 Oct 2025 13:10:11 +0200 (CEST)
	(envelope-from benoit.panizzon@imp.ch)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=imp.ch; s=mail;
	t=1759835411; bh=2W2yWEGbBMmupctI/z+HyX+1qJxWGAY6E3Fc30AVGgA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dC3oAYGxNSnwFHIFZRK2rYuonFudX6gULUhNokmSPVDtzv/BBX5YkHl0MX+tqt5Ob
	 MdVnDx9NqyEab/c9/EZVNq3NvTD92nEM1ITvbWs4kaeYJ/CcU7Uek2Hkq3KtUSIExg
	 jNWLoVUzAF5DQpcmA7B/JjwqUG8FIZW/ogTNDlvc=
Date: Tue, 7 Oct 2025 13:10:10 +0200
From: Benoit Panizzon <benoit.panizzon@imp.ch>
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: 1111455-quiet@bugs.debian.org, 1111455@bugs.debian.org,
        1111455-submitter@bugs.debian.org, Benoit Panizzon <bp@imp.ch>,
        Max
 Kellermann <max.kellermann@ionos.com>,
        David Howells <dhowells@redhat.com>,
        Paulo Alcantara <pc@manguebit.org>, netfs@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: Bug#1111455: [bp@imp.ch: Bug#1111455:
 linux-image-6.12.41+deb13-amd64: kernel BUG at fs/netfs/read_collect.c:316
 netfs: Can't donate prior to front]
Message-ID: <20251007131010.46873a4d@go.imp.ch>
In-Reply-To: <aM-kMVtUhnqrcwrc@eldamar.lan>
References: <175550547264.3745.5845128440223069497.reportbug@go.imp.ch>
	<aKMdIgkSWw9koCPC@eldamar.lan>
	<175550547264.3745.5845128440223069497.reportbug@go.imp.ch>
	<aM-kMVtUhnqrcwrc@eldamar.lan>
Organization: ImproWare AG
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Salvatore

> Can you still reproduce this with a more current 6.12.y version? Can
> you test as well the newest version of the 6.16.y version (even there
> was a major refactoring to see if it affects only the 6.12.y series)?

Sorry for the delay.

6.16 from experimental is working finde.

Just booted into:

6.12.48+deb13-amd64

/home on nfs - claws-mail / chromium so lots of small i/o

NFS server is: FreeBSD 13.2-RELEASE-p1

nfshome:/home on /home type nfs (rw,relatime,vers=3D3,rsize=3D8192,wsize=3D=
8192,namlen=3D255,hard,proto=3Dtcp,timeo=3D600,retrans=3D2,sec=3Dsys,mounta=
ddr=3Dx.x.x.x,mountvers=3D3,mountport=3D689,mountproto=3Dtcp,fsc,local_lock=
=3Dnone,addr=3Dx.x.x.x)


And after a couple of minutes I get:

[Di Okt  7 13:03:30 2025] netfs: Can't donate prior to front
[Di Okt  7 13:03:30 2025] R=3D000017d2[10] s=3Dda000-dbfff 0/2000/2000
[Di Okt  7 13:03:30 2025] folio: d8000-dbfff
[Di Okt  7 13:03:30 2025] donated: prev=3D0 next=3D0
[Di Okt  7 13:03:30 2025] s=3Dda000 av=3D2000 part=3D2000
[Di Okt  7 13:03:30 2025] ------------[ cut here ]------------
[Di Okt  7 13:03:30 2025] kernel BUG at fs/netfs/read_collect.c:316!
[Di Okt  7 13:03:30 2025] Oops: invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
[Di Okt  7 13:03:30 2025] CPU: 14 UID: 0 PID: 121 Comm: kworker/u64:7 Not t=
ainted 6.12.48+deb13-amd64 #1  Debian 6.12.48-1
[Di Okt  7 13:03:30 2025] Hardware name: LENOVO 11JN000JGE/32E4, BIOS M47KT=
26A 11/23/2022
[Di Okt  7 13:03:30 2025] Workqueue: nfsiod rpc_async_release [sunrpc]
[Di Okt  7 13:03:30 2025] RIP: 0010:netfs_consume_read_data.isra.0+0xb79/0x=
b80 [netfs]
[Di Okt  7 13:03:30 2025] Code: 48 89 ea 31 f6 48 c7 c7 96 d5 61 c2 e8 30 8=
e 7f d2 48 8b 4c 24 10 4c 89 fe 48 8b 54 24 20 48 c7 c7 b2 d5 61 c2 e8 17 8=
e 7f d2 <0f> 0b 90 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
[Di Okt  7 13:03:30 2025] RSP: 0018:ffff97b3c05abd58 EFLAGS: 00010246
[Di Okt  7 13:03:30 2025] RAX: 0000000000000019 RBX: ffff8c071b60cfc0 RCX: =
0000000000000027
[Di Okt  7 13:03:30 2025] RDX: 0000000000000000 RSI: 0000000000000001 RDI: =
ffff8c098e921780
[Di Okt  7 13:03:30 2025] RBP: 0000000000000000 R08: 0000000000000000 R09: =
ffff97b3c05abbe8
[Di Okt  7 13:03:30 2025] R10: ffffffff95eb43a8 R11: 0000000000000003 R12: =
ffff8c06c6c23168
[Di Okt  7 13:03:30 2025] R13: 0000000000004000 R14: ffff8c06c6c23168 R15: =
00000000000da000
[Di Okt  7 13:03:30 2025] FS:  0000000000000000(0000) GS:ffff8c098e900000(0=
000) knlGS:0000000000000000
[Di Okt  7 13:03:30 2025] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[Di Okt  7 13:03:30 2025] CR2: 00007efd8421a000 CR3: 000000019b756000 CR4: =
0000000000f50ef0
[Di Okt  7 13:03:30 2025] PKRU: 55555554
[Di Okt  7 13:03:30 2025] Call Trace:
[Di Okt  7 13:03:30 2025]  <TASK>
[Di Okt  7 13:03:30 2025]  netfs_read_subreq_terminated+0x2ab/0x3e0 [netfs]
[Di Okt  7 13:03:30 2025]  nfs_netfs_read_completion+0x9c/0xc0 [nfs]
[Di Okt  7 13:03:30 2025]  nfs_read_completion+0xf6/0x130 [nfs]
[Di Okt  7 13:03:30 2025]  rpc_free_task+0x39/0x60 [sunrpc]
[Di Okt  7 13:03:30 2025]  rpc_async_release+0x2f/0x40 [sunrpc]
[Di Okt  7 13:03:30 2025]  process_one_work+0x177/0x330
[Di Okt  7 13:03:30 2025]  worker_thread+0x251/0x390
[Di Okt  7 13:03:30 2025]  ? __pfx_worker_thread+0x10/0x10
[Di Okt  7 13:03:30 2025]  kthread+0xd2/0x100
[Di Okt  7 13:03:30 2025]  ? __pfx_kthread+0x10/0x10
[Di Okt  7 13:03:30 2025]  ret_from_fork+0x34/0x50
[Di Okt  7 13:03:30 2025]  ? __pfx_kthread+0x10/0x10
[Di Okt  7 13:03:30 2025]  ret_from_fork_asm+0x1a/0x30
[Di Okt  7 13:03:30 2025]  </TASK>
[Di Okt  7 13:03:30 2025] Modules linked in: cachefiles nfsv3 rpcsec_gss_kr=
b5 nfsv4 dns_resolver nfs netfs nft_chain_nat xt_MASQUERADE nf_nat nf_connt=
rack nf_defrag_ipv6 nf_defrag_ipv4 nft_compat nf_tables libcrc32c wireguard=
 libchacha20poly1305 chacha_x86_64 poly1305_x86_64 curve25519_x86_64 libcur=
ve25519_generic libchacha vxlan ip6_udp_tunnel udp_tunnel bridge stp llc bt=
usb btrtl btintel btbcm btmtk bluetooth joydev qrtr nfsd auth_rpcgss binfmt=
_misc nfs_acl lockd grace nls_ascii nls_cp437 sunrpc vfat fat amd_atl intel=
_rapl_msr intel_rapl_common rtw88_8822ce rtw88_8822c edac_mce_amd rtw88_pci=
 snd_sof_amd_rembrandt rtw88_core kvm_amd snd_sof_amd_acp snd_sof_pci snd_s=
of_xtensa_dsp mac80211 snd_hda_codec_realtek snd_sof kvm snd_hda_codec_gene=
ric snd_sof_utils snd_hda_scodec_component snd_hda_codec_hdmi snd_soc_core =
snd_hda_intel snd_intel_dspcfg libarc4 snd_compress irqbypass snd_intel_sdw=
_acpi snd_pcm_dmaengine crct10dif_pclmul snd_hda_codec snd_pci_ps ghash_clm=
ulni_intel snd_rpl_pci_acp6x cfg80211 sha512_ssse3 snd_hda_core
[Di Okt  7 13:03:30 2025]  snd_acp_pci snd_acp_legacy_common sha256_ssse3 s=
nd_hwdep snd_pci_acp6x sha1_ssse3 snd_pcm aesni_intel ee1004 gf128mul wmi_b=
mof snd_pci_acp5x crypto_simd think_lmi snd_timer snd_rn_pci_acp3x cryptd f=
irmware_attributes_class snd_acp_config rapl snd snd_soc_acpi k10temp ccp p=
cspkr snd_pci_acp3x rfkill soundcore evdev parport_pc ppdev lp parport efi_=
pstore configfs nfnetlink efivarfs ip_tables x_tables autofs4 ext4 mbcache =
jbd2 crc32c_generic hid_plantronics hid_generic usbhid hid amdgpu dm_mod am=
dxcp drm_exec gpu_sched drm_buddy i2c_algo_bit drm_suballoc_helper drm_disp=
lay_helper cec rc_core drm_ttm_helper xhci_pci ttm xhci_hcd drm_kms_helper =
drm r8169 nvme usbcore realtek nvme_core sp5100_tco mdio_devres watchdog vi=
deo libphy crc32_pclmul i2c_piix4 crc16 usb_common nvme_auth crc32c_intel i=
2c_smbus wmi button
[Di Okt  7 13:03:30 2025] ---[ end trace 0000000000000000 ]---
[Di Okt  7 13:03:30 2025] RIP: 0010:netfs_consume_read_data.isra.0+0xb79/0x=
b80 [netfs]
[Di Okt  7 13:03:30 2025] Code: 48 89 ea 31 f6 48 c7 c7 96 d5 61 c2 e8 30 8=
e 7f d2 48 8b 4c 24 10 4c 89 fe 48 8b 54 24 20 48 c7 c7 b2 d5 61 c2 e8 17 8=
e 7f d2 <0f> 0b 90 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
[Di Okt  7 13:03:30 2025] RSP: 0018:ffff97b3c05abd58 EFLAGS: 00010246
[Di Okt  7 13:03:30 2025] RAX: 0000000000000019 RBX: ffff8c071b60cfc0 RCX: =
0000000000000027
[Di Okt  7 13:03:30 2025] RDX: 0000000000000000 RSI: 0000000000000001 RDI: =
ffff8c098e921780
[Di Okt  7 13:03:30 2025] RBP: 0000000000000000 R08: 0000000000000000 R09: =
ffff97b3c05abbe8
[Di Okt  7 13:03:30 2025] R10: ffffffff95eb43a8 R11: 0000000000000003 R12: =
ffff8c06c6c23168
[Di Okt  7 13:03:30 2025] R13: 0000000000004000 R14: ffff8c06c6c23168 R15: =
00000000000da000
[Di Okt  7 13:03:30 2025] FS:  0000000000000000(0000) GS:ffff8c098e900000(0=
000) knlGS:0000000000000000
[Di Okt  7 13:03:30 2025] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[Di Okt  7 13:03:30 2025] CR2: 00007efd8421a000 CR3: 000000019b756000 CR4: =
0000000000f50ef0
[Di Okt  7 13:03:30 2025] PKRU: 55555554
[Di Okt  7 13:03:35 2025] netfs: Can't donate prior to front
[Di Okt  7 13:03:35 2025] R=3D00001e80[4] s=3D6000-7fff 0/2000/2000
[Di Okt  7 13:03:35 2025] folio: 4000-7fff
[Di Okt  7 13:03:35 2025] donated: prev=3D0 next=3D0
[Di Okt  7 13:03:35 2025] s=3D6000 av=3D2000 part=3D2000
[Di Okt  7 13:03:35 2025] ------------[ cut here ]------------
[Di Okt  7 13:03:35 2025] kernel BUG at fs/netfs/read_collect.c:316!
[Di Okt  7 13:03:35 2025] Oops: invalid opcode: 0000 [#2] PREEMPT SMP NOPTI
[Di Okt  7 13:03:35 2025] CPU: 6 UID: 0 PID: 3979 Comm: kworker/u64:17 Tain=
ted: G      D            6.12.48+deb13-amd64 #1  Debian 6.12.48-1
[Di Okt  7 13:03:35 2025] Tainted: [D]=3DDIE
[Di Okt  7 13:03:35 2025] Hardware name: LENOVO 11JN000JGE/32E4, BIOS M47KT=
26A 11/23/2022
[Di Okt  7 13:03:35 2025] Workqueue: nfsiod rpc_async_release [sunrpc]
[Di Okt  7 13:03:35 2025] RIP: 0010:netfs_consume_read_data.isra.0+0xb79/0x=
b80 [netfs]
[Di Okt  7 13:03:35 2025] Code: 48 89 ea 31 f6 48 c7 c7 96 d5 61 c2 e8 30 8=
e 7f d2 48 8b 4c 24 10 4c 89 fe 48 8b 54 24 20 48 c7 c7 b2 d5 61 c2 e8 17 8=
e 7f d2 <0f> 0b 90 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
[Di Okt  7 13:03:35 2025] RSP: 0018:ffff97b3c76e7d58 EFLAGS: 00010246
[Di Okt  7 13:03:35 2025] RAX: 0000000000000018 RBX: ffff8c068b3dc3c0 RCX: =
0000000000000027
[Di Okt  7 13:03:35 2025] RDX: 0000000000000000 RSI: 0000000000000001 RDI: =
ffff8c098e521780
[Di Okt  7 13:03:35 2025] RBP: 0000000000000000 R08: 0000000000000000 R09: =
ffff97b3c76e7be8
[Di Okt  7 13:03:35 2025] R10: ffffffff95eb43a8 R11: 0000000000000003 R12: =
ffff8c0686c24468
[Di Okt  7 13:03:35 2025] R13: 0000000000004000 R14: ffff8c0686c24468 R15: =
0000000000006000
[Di Okt  7 13:03:35 2025] FS:  0000000000000000(0000) GS:ffff8c098e500000(0=
000) knlGS:0000000000000000
[Di Okt  7 13:03:35 2025] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[Di Okt  7 13:03:35 2025] CR2: 00003394003da080 CR3: 000000010c8d8000 CR4: =
0000000000f50ef0
[Di Okt  7 13:03:35 2025] PKRU: 55555554
[Di Okt  7 13:03:35 2025] Call Trace:
[Di Okt  7 13:03:35 2025]  <TASK>
[Di Okt  7 13:03:35 2025]  netfs_read_subreq_terminated+0x2ab/0x3e0 [netfs]
[Di Okt  7 13:03:35 2025]  nfs_netfs_read_completion+0x9c/0xc0 [nfs]
[Di Okt  7 13:03:35 2025]  nfs_read_completion+0xf6/0x130 [nfs]
[Di Okt  7 13:03:35 2025]  rpc_free_task+0x39/0x60 [sunrpc]
[Di Okt  7 13:03:35 2025]  rpc_async_release+0x2f/0x40 [sunrpc]
[Di Okt  7 13:03:35 2025]  process_one_work+0x177/0x330
[Di Okt  7 13:03:35 2025]  worker_thread+0x251/0x390
[Di Okt  7 13:03:35 2025]  ? __pfx_worker_thread+0x10/0x10
[Di Okt  7 13:03:35 2025]  kthread+0xd2/0x100
[Di Okt  7 13:03:35 2025]  ? __pfx_kthread+0x10/0x10
[Di Okt  7 13:03:35 2025]  ret_from_fork+0x34/0x50
[Di Okt  7 13:03:35 2025]  ? __pfx_kthread+0x10/0x10
[Di Okt  7 13:03:35 2025]  ret_from_fork_asm+0x1a/0x30
[Di Okt  7 13:03:35 2025]  </TASK>
[Di Okt  7 13:03:35 2025] Modules linked in: cachefiles nfsv3 rpcsec_gss_kr=
b5 nfsv4 dns_resolver nfs netfs nft_chain_nat xt_MASQUERADE nf_nat nf_connt=
rack nf_defrag_ipv6 nf_defrag_ipv4 nft_compat nf_tables libcrc32c wireguard=
 libchacha20poly1305 chacha_x86_64 poly1305_x86_64 curve25519_x86_64 libcur=
ve25519_generic libchacha vxlan ip6_udp_tunnel udp_tunnel bridge stp llc bt=
usb btrtl btintel btbcm btmtk bluetooth joydev qrtr nfsd auth_rpcgss binfmt=
_misc nfs_acl lockd grace nls_ascii nls_cp437 sunrpc vfat fat amd_atl intel=
_rapl_msr intel_rapl_common rtw88_8822ce rtw88_8822c edac_mce_amd rtw88_pci=
 snd_sof_amd_rembrandt rtw88_core kvm_amd snd_sof_amd_acp snd_sof_pci snd_s=
of_xtensa_dsp mac80211 snd_hda_codec_realtek snd_sof kvm snd_hda_codec_gene=
ric snd_sof_utils snd_hda_scodec_component snd_hda_codec_hdmi snd_soc_core =
snd_hda_intel snd_intel_dspcfg libarc4 snd_compress irqbypass snd_intel_sdw=
_acpi snd_pcm_dmaengine crct10dif_pclmul snd_hda_codec snd_pci_ps ghash_clm=
ulni_intel snd_rpl_pci_acp6x cfg80211 sha512_ssse3 snd_hda_core
[Di Okt  7 13:03:35 2025]  snd_acp_pci snd_acp_legacy_common sha256_ssse3 s=
nd_hwdep snd_pci_acp6x sha1_ssse3 snd_pcm aesni_intel ee1004 gf128mul wmi_b=
mof snd_pci_acp5x crypto_simd think_lmi snd_timer snd_rn_pci_acp3x cryptd f=
irmware_attributes_class snd_acp_config rapl snd snd_soc_acpi k10temp ccp p=
cspkr snd_pci_acp3x rfkill soundcore evdev parport_pc ppdev lp parport efi_=
pstore configfs nfnetlink efivarfs ip_tables x_tables autofs4 ext4 mbcache =
jbd2 crc32c_generic hid_plantronics hid_generic usbhid hid amdgpu dm_mod am=
dxcp drm_exec gpu_sched drm_buddy i2c_algo_bit drm_suballoc_helper drm_disp=
lay_helper cec rc_core drm_ttm_helper xhci_pci ttm xhci_hcd drm_kms_helper =
drm r8169 nvme usbcore realtek nvme_core sp5100_tco mdio_devres watchdog vi=
deo libphy crc32_pclmul i2c_piix4 crc16 usb_common nvme_auth crc32c_intel i=
2c_smbus wmi button
[Di Okt  7 13:03:35 2025] ---[ end trace 0000000000000000 ]---
[Di Okt  7 13:03:35 2025] RIP: 0010:netfs_consume_read_data.isra.0+0xb79/0x=
b80 [netfs]
[Di Okt  7 13:03:35 2025] Code: 48 89 ea 31 f6 48 c7 c7 96 d5 61 c2 e8 30 8=
e 7f d2 48 8b 4c 24 10 4c 89 fe 48 8b 54 24 20 48 c7 c7 b2 d5 61 c2 e8 17 8=
e 7f d2 <0f> 0b 90 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
[Di Okt  7 13:03:35 2025] RSP: 0018:ffff97b3c05abd58 EFLAGS: 00010246
[Di Okt  7 13:03:35 2025] RAX: 0000000000000019 RBX: ffff8c071b60cfc0 RCX: =
0000000000000027
[Di Okt  7 13:03:35 2025] RDX: 0000000000000000 RSI: 0000000000000001 RDI: =
ffff8c098e921780
[Di Okt  7 13:03:35 2025] RBP: 0000000000000000 R08: 0000000000000000 R09: =
ffff97b3c05abbe8
[Di Okt  7 13:03:35 2025] R10: ffffffff95eb43a8 R11: 0000000000000003 R12: =
ffff8c06c6c23168
[Di Okt  7 13:03:35 2025] R13: 0000000000004000 R14: ffff8c06c6c23168 R15: =
00000000000da000
[Di Okt  7 13:03:35 2025] FS:  0000000000000000(0000) GS:ffff8c098e500000(0=
000) knlGS:0000000000000000
[Di Okt  7 13:03:35 2025] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[Di Okt  7 13:03:35 2025] CR2: 00003394003da080 CR3: 000000010c8d8000 CR4: =
0000000000f50ef0
[Di Okt  7 13:03:35 2025] PKRU: 55555554
[Di Okt  7 13:03:47 2025] netfs: Can't donate prior to front
[Di Okt  7 13:03:47 2025] R=3D00002f1f[4] s=3D6000-7fff 0/2000/2000
[Di Okt  7 13:03:47 2025] folio: 4000-7fff
[Di Okt  7 13:03:47 2025] donated: prev=3D0 next=3D0
[Di Okt  7 13:03:47 2025] s=3D6000 av=3D2000 part=3D2000
[Di Okt  7 13:03:47 2025] ------------[ cut here ]------------
[Di Okt  7 13:03:47 2025] kernel BUG at fs/netfs/read_collect.c:316!
[Di Okt  7 13:03:47 2025] Oops: invalid opcode: 0000 [#3] PREEMPT SMP NOPTI
[Di Okt  7 13:03:47 2025] CPU: 4 UID: 0 PID: 127 Comm: kworker/u64:13 Taint=
ed: G      D            6.12.48+deb13-amd64 #1  Debian 6.12.48-1
[Di Okt  7 13:03:47 2025] Tainted: [D]=3DDIE
[Di Okt  7 13:03:47 2025] Hardware name: LENOVO 11JN000JGE/32E4, BIOS M47KT=
26A 11/23/2022
[Di Okt  7 13:03:47 2025] Workqueue: nfsiod rpc_async_release [sunrpc]
[Di Okt  7 13:03:47 2025] RIP: 0010:netfs_consume_read_data.isra.0+0xb79/0x=
b80 [netfs]
[Di Okt  7 13:03:47 2025] Code: 48 89 ea 31 f6 48 c7 c7 96 d5 61 c2 e8 30 8=
e 7f d2 48 8b 4c 24 10 4c 89 fe 48 8b 54 24 20 48 c7 c7 b2 d5 61 c2 e8 17 8=
e 7f d2 <0f> 0b 90 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
[Di Okt  7 13:03:47 2025] RSP: 0018:ffff97b3c05dbd58 EFLAGS: 00010246
[Di Okt  7 13:03:47 2025] RAX: 0000000000000018 RBX: ffff8c0686b7b140 RCX: =
0000000000000027
[Di Okt  7 13:03:47 2025] RDX: 0000000000000000 RSI: 0000000000000001 RDI: =
ffff8c098e421780
[Di Okt  7 13:03:47 2025] RBP: 0000000000000000 R08: 0000000000000000 R09: =
ffff97b3c05dbbe8
[Di Okt  7 13:03:47 2025] R10: ffffffff95eb43a8 R11: 0000000000000003 R12: =
ffff8c0686baeee8
[Di Okt  7 13:03:47 2025] R13: 0000000000004000 R14: ffff8c0686baeee8 R15: =
0000000000006000
[Di Okt  7 13:03:47 2025] FS:  0000000000000000(0000) GS:ffff8c098e400000(0=
000) knlGS:0000000000000000
[Di Okt  7 13:03:47 2025] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[Di Okt  7 13:03:47 2025] CR2: 00000be400a7b020 CR3: 00000001cee22000 CR4: =
0000000000f50ef0
[Di Okt  7 13:03:47 2025] PKRU: 55555554
[Di Okt  7 13:03:47 2025] Call Trace:
[Di Okt  7 13:03:47 2025]  <TASK>
[Di Okt  7 13:03:47 2025]  netfs_read_subreq_terminated+0x2ab/0x3e0 [netfs]
[Di Okt  7 13:03:47 2025]  nfs_netfs_read_completion+0x9c/0xc0 [nfs]
[Di Okt  7 13:03:47 2025]  nfs_read_completion+0xf6/0x130 [nfs]
[Di Okt  7 13:03:47 2025]  rpc_free_task+0x39/0x60 [sunrpc]
[Di Okt  7 13:03:47 2025]  rpc_async_release+0x2f/0x40 [sunrpc]
[Di Okt  7 13:03:47 2025]  process_one_work+0x177/0x330
[Di Okt  7 13:03:47 2025]  worker_thread+0x251/0x390
[Di Okt  7 13:03:47 2025]  ? __pfx_worker_thread+0x10/0x10
[Di Okt  7 13:03:47 2025]  kthread+0xd2/0x100
[Di Okt  7 13:03:47 2025]  ? __pfx_kthread+0x10/0x10
[Di Okt  7 13:03:47 2025]  ret_from_fork+0x34/0x50
[Di Okt  7 13:03:47 2025]  ? __pfx_kthread+0x10/0x10
[Di Okt  7 13:03:47 2025]  ret_from_fork_asm+0x1a/0x30
[Di Okt  7 13:03:47 2025]  </TASK>
[Di Okt  7 13:03:47 2025] Modules linked in: cachefiles nfsv3 rpcsec_gss_kr=
b5 nfsv4 dns_resolver nfs netfs nft_chain_nat xt_MASQUERADE nf_nat nf_connt=
rack nf_defrag_ipv6 nf_defrag_ipv4 nft_compat nf_tables libcrc32c wireguard=
 libchacha20poly1305 chacha_x86_64 poly1305_x86_64 curve25519_x86_64 libcur=
ve25519_generic libchacha vxlan ip6_udp_tunnel udp_tunnel bridge stp llc bt=
usb btrtl btintel btbcm btmtk bluetooth joydev qrtr nfsd auth_rpcgss binfmt=
_misc nfs_acl lockd grace nls_ascii nls_cp437 sunrpc vfat fat amd_atl intel=
_rapl_msr intel_rapl_common rtw88_8822ce rtw88_8822c edac_mce_amd rtw88_pci=
 snd_sof_amd_rembrandt rtw88_core kvm_amd snd_sof_amd_acp snd_sof_pci snd_s=
of_xtensa_dsp mac80211 snd_hda_codec_realtek snd_sof kvm snd_hda_codec_gene=
ric snd_sof_utils snd_hda_scodec_component snd_hda_codec_hdmi snd_soc_core =
snd_hda_intel snd_intel_dspcfg libarc4 snd_compress irqbypass snd_intel_sdw=
_acpi snd_pcm_dmaengine crct10dif_pclmul snd_hda_codec snd_pci_ps ghash_clm=
ulni_intel snd_rpl_pci_acp6x cfg80211 sha512_ssse3 snd_hda_core
[Di Okt  7 13:03:47 2025]  snd_acp_pci snd_acp_legacy_common sha256_ssse3 s=
nd_hwdep snd_pci_acp6x sha1_ssse3 snd_pcm aesni_intel ee1004 gf128mul wmi_b=
mof snd_pci_acp5x crypto_simd think_lmi snd_timer snd_rn_pci_acp3x cryptd f=
irmware_attributes_class snd_acp_config rapl snd snd_soc_acpi k10temp ccp p=
cspkr snd_pci_acp3x rfkill soundcore evdev parport_pc ppdev lp parport efi_=
pstore configfs nfnetlink efivarfs ip_tables x_tables autofs4 ext4 mbcache =
jbd2 crc32c_generic hid_plantronics hid_generic usbhid hid amdgpu dm_mod am=
dxcp drm_exec gpu_sched drm_buddy i2c_algo_bit drm_suballoc_helper drm_disp=
lay_helper cec rc_core drm_ttm_helper xhci_pci ttm xhci_hcd drm_kms_helper =
drm r8169 nvme usbcore realtek nvme_core sp5100_tco mdio_devres watchdog vi=
deo libphy crc32_pclmul i2c_piix4 crc16 usb_common nvme_auth crc32c_intel i=
2c_smbus wmi button
[Di Okt  7 13:03:47 2025] ---[ end trace 0000000000000000 ]---
[Di Okt  7 13:03:49 2025] RIP: 0010:netfs_consume_read_data.isra.0+0xb79/0x=
b80 [netfs]
[Di Okt  7 13:03:49 2025] Code: 48 89 ea 31 f6 48 c7 c7 96 d5 61 c2 e8 30 8=
e 7f d2 48 8b 4c 24 10 4c 89 fe 48 8b 54 24 20 48 c7 c7 b2 d5 61 c2 e8 17 8=
e 7f d2 <0f> 0b 90 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
[Di Okt  7 13:03:49 2025] RSP: 0018:ffff97b3c05abd58 EFLAGS: 00010246
[Di Okt  7 13:03:49 2025] RAX: 0000000000000019 RBX: ffff8c071b60cfc0 RCX: =
0000000000000027
[Di Okt  7 13:03:49 2025] RDX: 0000000000000000 RSI: 0000000000000001 RDI: =
ffff8c098e921780
[Di Okt  7 13:03:49 2025] RBP: 0000000000000000 R08: 0000000000000000 R09: =
ffff97b3c05abbe8
[Di Okt  7 13:03:49 2025] R10: ffffffff95eb43a8 R11: 0000000000000003 R12: =
ffff8c06c6c23168
[Di Okt  7 13:03:49 2025] R13: 0000000000004000 R14: ffff8c06c6c23168 R15: =
00000000000da000
[Di Okt  7 13:03:49 2025] FS:  0000000000000000(0000) GS:ffff8c098e400000(0=
000) knlGS:0000000000000000
[Di Okt  7 13:03:49 2025] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[Di Okt  7 13:03:49 2025] CR2: 00000be400a7b020 CR3: 0000000210e8c000 CR4: =
0000000000f50ef0
[Di Okt  7 13:03:49 2025] PKRU: 55555554
[Di Okt  7 13:03:51 2025] netfs: Can't donate prior to front
[Di Okt  7 13:03:51 2025] R=3D0000300a[e] s=3D72000-77fff 0/6000/6000
[Di Okt  7 13:03:51 2025] folio: 70000-77fff
[Di Okt  7 13:03:51 2025] donated: prev=3D0 next=3D0
[Di Okt  7 13:03:51 2025] s=3D72000 av=3D6000 part=3D6000
[Di Okt  7 13:03:51 2025] ------------[ cut here ]------------
[Di Okt  7 13:03:51 2025] kernel BUG at fs/netfs/read_collect.c:316!
[Di Okt  7 13:03:51 2025] Oops: invalid opcode: 0000 [#4] PREEMPT SMP NOPTI
[Di Okt  7 13:03:51 2025] CPU: 5 UID: 0 PID: 118 Comm: kworker/u64:4 Tainte=
d: G      D            6.12.48+deb13-amd64 #1  Debian 6.12.48-1
[Di Okt  7 13:03:51 2025] Tainted: [D]=3DDIE
[Di Okt  7 13:03:51 2025] Hardware name: LENOVO 11JN000JGE/32E4, BIOS M47KT=
26A 11/23/2022
[Di Okt  7 13:03:51 2025] Workqueue: nfsiod rpc_async_release [sunrpc]
[Di Okt  7 13:03:51 2025] RIP: 0010:netfs_consume_read_data.isra.0+0xb79/0x=
b80 [netfs]
[Di Okt  7 13:03:51 2025] Code: 48 89 ea 31 f6 48 c7 c7 96 d5 61 c2 e8 30 8=
e 7f d2 48 8b 4c 24 10 4c 89 fe 48 8b 54 24 20 48 c7 c7 b2 d5 61 c2 e8 17 8=
e 7f d2 <0f> 0b 90 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
[Di Okt  7 13:03:51 2025] RSP: 0018:ffff97b3c0593d58 EFLAGS: 00010246
[Di Okt  7 13:03:51 2025] RAX: 0000000000000019 RBX: ffff8c069193a480 RCX: =
0000000000000027
[Di Okt  7 13:03:51 2025] RDX: 0000000000000000 RSI: 0000000000000001 RDI: =
ffff8c098e4a1780
[Di Okt  7 13:03:51 2025] RBP: 0000000000000000 R08: 0000000000000000 R09: =
ffff97b3c0593be8
[Di Okt  7 13:03:51 2025] R10: ffffffff95eb43a8 R11: 0000000000000003 R12: =
ffff8c068246a4e8
[Di Okt  7 13:03:51 2025] R13: 0000000000008000 R14: ffff8c068246a4e8 R15: =
0000000000072000
[Di Okt  7 13:03:51 2025] FS:  0000000000000000(0000) GS:ffff8c098e480000(0=
000) knlGS:0000000000000000
[Di Okt  7 13:03:51 2025] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[Di Okt  7 13:03:51 2025] CR2: 00007f62f83d2000 CR3: 00000001ba55a000 CR4: =
0000000000f50ef0
[Di Okt  7 13:03:51 2025] PKRU: 55555554
[Di Okt  7 13:03:51 2025] Call Trace:
[Di Okt  7 13:03:51 2025]  <TASK>
[Di Okt  7 13:03:51 2025]  netfs_read_subreq_terminated+0x2ab/0x3e0 [netfs]
[Di Okt  7 13:03:51 2025]  nfs_netfs_read_completion+0x9c/0xc0 [nfs]
[Di Okt  7 13:03:51 2025]  nfs_read_completion+0xf6/0x130 [nfs]
[Di Okt  7 13:03:51 2025]  rpc_free_task+0x39/0x60 [sunrpc]
[Di Okt  7 13:03:51 2025]  rpc_async_release+0x2f/0x40 [sunrpc]
[Di Okt  7 13:03:51 2025]  process_one_work+0x177/0x330
[Di Okt  7 13:03:51 2025]  worker_thread+0x251/0x390
[Di Okt  7 13:03:51 2025]  ? __pfx_worker_thread+0x10/0x10
[Di Okt  7 13:03:51 2025]  kthread+0xd2/0x100
[Di Okt  7 13:03:51 2025]  ? __pfx_kthread+0x10/0x10
[Di Okt  7 13:03:51 2025]  ret_from_fork+0x34/0x50
[Di Okt  7 13:03:51 2025]  ? __pfx_kthread+0x10/0x10
[Di Okt  7 13:03:51 2025]  ret_from_fork_asm+0x1a/0x30
[Di Okt  7 13:03:51 2025]  </TASK>
[Di Okt  7 13:03:51 2025] Modules linked in: cachefiles nfsv3 rpcsec_gss_kr=
b5 nfsv4 dns_resolver nfs netfs nft_chain_nat xt_MASQUERADE nf_nat nf_connt=
rack nf_defrag_ipv6 nf_defrag_ipv4 nft_compat nf_tables libcrc32c wireguard=
 libchacha20poly1305 chacha_x86_64 poly1305_x86_64 curve25519_x86_64 libcur=
ve25519_generic libchacha vxlan ip6_udp_tunnel udp_tunnel bridge stp llc bt=
usb btrtl btintel btbcm btmtk bluetooth joydev qrtr nfsd auth_rpcgss binfmt=
_misc nfs_acl lockd grace nls_ascii nls_cp437 sunrpc vfat fat amd_atl intel=
_rapl_msr intel_rapl_common rtw88_8822ce rtw88_8822c edac_mce_amd rtw88_pci=
 snd_sof_amd_rembrandt rtw88_core kvm_amd snd_sof_amd_acp snd_sof_pci snd_s=
of_xtensa_dsp mac80211 snd_hda_codec_realtek snd_sof kvm snd_hda_codec_gene=
ric snd_sof_utils snd_hda_scodec_component snd_hda_codec_hdmi snd_soc_core =
snd_hda_intel snd_intel_dspcfg libarc4 snd_compress irqbypass snd_intel_sdw=
_acpi snd_pcm_dmaengine crct10dif_pclmul snd_hda_codec snd_pci_ps ghash_clm=
ulni_intel snd_rpl_pci_acp6x cfg80211 sha512_ssse3 snd_hda_core
[Di Okt  7 13:03:51 2025]  snd_acp_pci snd_acp_legacy_common sha256_ssse3 s=
nd_hwdep snd_pci_acp6x sha1_ssse3 snd_pcm aesni_intel ee1004 gf128mul wmi_b=
mof snd_pci_acp5x crypto_simd think_lmi snd_timer snd_rn_pci_acp3x cryptd f=
irmware_attributes_class snd_acp_config rapl snd snd_soc_acpi k10temp ccp p=
cspkr snd_pci_acp3x rfkill soundcore evdev parport_pc ppdev lp parport efi_=
pstore configfs nfnetlink efivarfs ip_tables x_tables autofs4 ext4 mbcache =
jbd2 crc32c_generic hid_plantronics hid_generic usbhid hid amdgpu dm_mod am=
dxcp drm_exec gpu_sched drm_buddy i2c_algo_bit drm_suballoc_helper drm_disp=
lay_helper cec rc_core drm_ttm_helper xhci_pci ttm xhci_hcd drm_kms_helper =
drm r8169 nvme usbcore realtek nvme_core sp5100_tco mdio_devres watchdog vi=
deo libphy crc32_pclmul i2c_piix4 crc16 usb_common nvme_auth crc32c_intel i=
2c_smbus wmi button
[Di Okt  7 13:03:51 2025] ---[ end trace 0000000000000000 ]---
[Di Okt  7 13:03:51 2025] netfs: Can't donate prior to front
[Di Okt  7 13:03:51 2025] R=3D00003014[e] s=3D52000-57fff 0/6000/6000
[Di Okt  7 13:03:51 2025] folio: 50000-57fff
[Di Okt  7 13:03:51 2025] donated: prev=3D0 next=3D0
[Di Okt  7 13:03:51 2025] s=3D52000 av=3D6000 part=3D6000
[Di Okt  7 13:03:51 2025] ------------[ cut here ]------------
[Di Okt  7 13:03:51 2025] kernel BUG at fs/netfs/read_collect.c:316!
[Di Okt  7 13:03:51 2025] Oops: invalid opcode: 0000 [#5] PREEMPT SMP NOPTI
[Di Okt  7 13:03:51 2025] CPU: 8 UID: 0 PID: 129 Comm: kworker/u64:15 Taint=
ed: G      D            6.12.48+deb13-amd64 #1  Debian 6.12.48-1
[Di Okt  7 13:03:51 2025] Tainted: [D]=3DDIE
[Di Okt  7 13:03:51 2025] Hardware name: LENOVO 11JN000JGE/32E4, BIOS M47KT=
26A 11/23/2022
[Di Okt  7 13:03:51 2025] Workqueue: nfsiod rpc_async_release [sunrpc]
[Di Okt  7 13:03:51 2025] RIP: 0010:netfs_consume_read_data.isra.0+0xb79/0x=
b80 [netfs]
[Di Okt  7 13:03:51 2025] Code: 48 89 ea 31 f6 48 c7 c7 96 d5 61 c2 e8 30 8=
e 7f d2 48 8b 4c 24 10 4c 89 fe 48 8b 54 24 20 48 c7 c7 b2 d5 61 c2 e8 17 8=
e 7f d2 <0f> 0b 90 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
[Di Okt  7 13:03:51 2025] RSP: 0018:ffff97b3c05ebd58 EFLAGS: 00010246
[Di Okt  7 13:03:51 2025] RAX: 0000000000000019 RBX: ffff8c068a065140 RCX: =
0000000000000027
[Di Okt  7 13:03:51 2025] RDX: 0000000000000000 RSI: 0000000000000001 RDI: =
ffff8c098e621780
[Di Okt  7 13:03:51 2025] RBP: 0000000000000000 R08: 0000000000000000 R09: =
ffff97b3c05ebbe8
[Di Okt  7 13:03:51 2025] R10: ffffffff95eb43a8 R11: 0000000000000003 R12: =
ffff8c0686c273e8
[Di Okt  7 13:03:51 2025] R13: 0000000000008000 R14: ffff8c0686c273e8 R15: =
0000000000052000
[Di Okt  7 13:03:51 2025] FS:  0000000000000000(0000) GS:ffff8c098e600000(0=
000) knlGS:0000000000000000
[Di Okt  7 13:03:51 2025] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[Di Okt  7 13:03:51 2025] CR2: 00000be403e34fe0 CR3: 000000015a2c2000 CR4: =
0000000000f50ef0
[Di Okt  7 13:03:51 2025] PKRU: 55555554
[Di Okt  7 13:03:51 2025] Call Trace:
[Di Okt  7 13:03:51 2025]  <TASK>
[Di Okt  7 13:03:51 2025]  netfs_read_subreq_terminated+0x2ab/0x3e0 [netfs]
[Di Okt  7 13:03:51 2025]  nfs_netfs_read_completion+0x9c/0xc0 [nfs]
[Di Okt  7 13:03:51 2025]  nfs_read_completion+0xf6/0x130 [nfs]
[Di Okt  7 13:03:51 2025]  rpc_free_task+0x39/0x60 [sunrpc]
[Di Okt  7 13:03:51 2025]  rpc_async_release+0x2f/0x40 [sunrpc]
[Di Okt  7 13:03:51 2025]  process_one_work+0x177/0x330
[Di Okt  7 13:03:51 2025]  worker_thread+0x251/0x390
[Di Okt  7 13:03:51 2025]  ? __pfx_worker_thread+0x10/0x10
[Di Okt  7 13:03:51 2025]  kthread+0xd2/0x100
[Di Okt  7 13:03:51 2025]  ? __pfx_kthread+0x10/0x10
[Di Okt  7 13:03:51 2025]  ret_from_fork+0x34/0x50
[Di Okt  7 13:03:51 2025]  ? __pfx_kthread+0x10/0x10
[Di Okt  7 13:03:51 2025]  ret_from_fork_asm+0x1a/0x30
[Di Okt  7 13:03:51 2025]  </TASK>
[Di Okt  7 13:03:51 2025] Modules linked in: cachefiles nfsv3 rpcsec_gss_kr=
b5 nfsv4 dns_resolver nfs netfs nft_chain_nat xt_MASQUERADE nf_nat nf_connt=
rack nf_defrag_ipv6 nf_defrag_ipv4 nft_compat nf_tables libcrc32c wireguard=
 libchacha20poly1305 chacha_x86_64 poly1305_x86_64 curve25519_x86_64 libcur=
ve25519_generic libchacha vxlan ip6_udp_tunnel udp_tunnel bridge stp llc bt=
usb btrtl btintel btbcm btmtk bluetooth joydev qrtr nfsd auth_rpcgss binfmt=
_misc nfs_acl lockd grace nls_ascii nls_cp437 sunrpc vfat fat amd_atl intel=
_rapl_msr intel_rapl_common rtw88_8822ce rtw88_8822c edac_mce_amd rtw88_pci=
 snd_sof_amd_rembrandt rtw88_core kvm_amd snd_sof_amd_acp snd_sof_pci snd_s=
of_xtensa_dsp mac80211 snd_hda_codec_realtek snd_sof kvm snd_hda_codec_gene=
ric snd_sof_utils snd_hda_scodec_component snd_hda_codec_hdmi snd_soc_core =
snd_hda_intel snd_intel_dspcfg libarc4 snd_compress irqbypass snd_intel_sdw=
_acpi snd_pcm_dmaengine crct10dif_pclmul snd_hda_codec snd_pci_ps ghash_clm=
ulni_intel snd_rpl_pci_acp6x cfg80211 sha512_ssse3 snd_hda_core
[Di Okt  7 13:03:51 2025]  snd_acp_pci snd_acp_legacy_common sha256_ssse3 s=
nd_hwdep snd_pci_acp6x sha1_ssse3 snd_pcm aesni_intel ee1004 gf128mul wmi_b=
mof snd_pci_acp5x crypto_simd think_lmi snd_timer snd_rn_pci_acp3x cryptd f=
irmware_attributes_class snd_acp_config rapl snd snd_soc_acpi k10temp ccp p=
cspkr snd_pci_acp3x rfkill soundcore evdev parport_pc ppdev lp parport efi_=
pstore configfs nfnetlink efivarfs ip_tables x_tables autofs4 ext4 mbcache =
jbd2 crc32c_generic hid_plantronics hid_generic usbhid hid amdgpu dm_mod am=
dxcp drm_exec gpu_sched drm_buddy i2c_algo_bit drm_suballoc_helper drm_disp=
lay_helper cec rc_core drm_ttm_helper xhci_pci ttm xhci_hcd drm_kms_helper =
drm r8169 nvme usbcore realtek nvme_core sp5100_tco mdio_devres watchdog vi=
deo libphy crc32_pclmul i2c_piix4 crc16 usb_common nvme_auth crc32c_intel i=
2c_smbus wmi button
[Di Okt  7 13:03:51 2025] ---[ end trace 0000000000000000 ]---
[Di Okt  7 13:03:51 2025] RIP: 0010:netfs_consume_read_data.isra.0+0xb79/0x=
b80 [netfs]
[Di Okt  7 13:03:51 2025] Code: 48 89 ea 31 f6 48 c7 c7 96 d5 61 c2 e8 30 8=
e 7f d2 48 8b 4c 24 10 4c 89 fe 48 8b 54 24 20 48 c7 c7 b2 d5 61 c2 e8 17 8=
e 7f d2 <0f> 0b 90 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
[Di Okt  7 13:03:51 2025] RSP: 0018:ffff97b3c05abd58 EFLAGS: 00010246
[Di Okt  7 13:03:51 2025] RAX: 0000000000000019 RBX: ffff8c071b60cfc0 RCX: =
0000000000000027
[Di Okt  7 13:03:51 2025] RDX: 0000000000000000 RSI: 0000000000000001 RDI: =
ffff8c098e921780
[Di Okt  7 13:03:51 2025] RBP: 0000000000000000 R08: 0000000000000000 R09: =
ffff97b3c05abbe8
[Di Okt  7 13:03:51 2025] R10: ffffffff95eb43a8 R11: 0000000000000003 R12: =
ffff8c06c6c23168
[Di Okt  7 13:03:51 2025] R13: 0000000000004000 R14: ffff8c06c6c23168 R15: =
00000000000da000
[Di Okt  7 13:03:51 2025] FS:  0000000000000000(0000) GS:ffff8c098e480000(0=
000) knlGS:0000000000000000
[Di Okt  7 13:03:51 2025] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[Di Okt  7 13:03:51 2025] CR2: 00007f62f83d2000 CR3: 00000001ba55a000 CR4: =
0000000000f50ef0
[Di Okt  7 13:03:51 2025] PKRU: 55555554
[Di Okt  7 13:03:51 2025] RIP: 0010:netfs_consume_read_data.isra.0+0xb79/0x=
b80 [netfs]
[Di Okt  7 13:03:51 2025] Code: 48 89 ea 31 f6 48 c7 c7 96 d5 61 c2 e8 30 8=
e 7f d2 48 8b 4c 24 10 4c 89 fe 48 8b 54 24 20 48 c7 c7 b2 d5 61 c2 e8 17 8=
e 7f d2 <0f> 0b 90 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
[Di Okt  7 13:03:51 2025] RSP: 0018:ffff97b3c05abd58 EFLAGS: 00010246
[Di Okt  7 13:03:51 2025] RAX: 0000000000000019 RBX: ffff8c071b60cfc0 RCX: =
0000000000000027
[Di Okt  7 13:03:51 2025] RDX: 0000000000000000 RSI: 0000000000000001 RDI: =
ffff8c098e921780
[Di Okt  7 13:03:51 2025] RBP: 0000000000000000 R08: 0000000000000000 R09: =
ffff97b3c05abbe8
[Di Okt  7 13:03:51 2025] R10: ffffffff95eb43a8 R11: 0000000000000003 R12: =
ffff8c06c6c23168
[Di Okt  7 13:03:51 2025] R13: 0000000000004000 R14: ffff8c06c6c23168 R15: =
00000000000da000
[Di Okt  7 13:03:51 2025] FS:  0000000000000000(0000) GS:ffff8c098e600000(0=
000) knlGS:0000000000000000
[Di Okt  7 13:03:51 2025] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[Di Okt  7 13:03:51 2025] CR2: 00000be403e34fe0 CR3: 000000015a2c2000 CR4: =
0000000000f50ef0
[Di Okt  7 13:03:51 2025] PKRU: 55555554


Mit freundlichen Gr=C3=BCssen

-Beno=C3=AEt Panizzon-
--=20
I m p r o W a r e   A G    -    Leiter Commerce Kunden
______________________________________________________

Zurlindenstrasse 29             Tel  +41 61 826 93 00
CH-4133 Pratteln                Fax  +41 61 826 93 01
Schweiz                         Web  http://www.imp.ch
______________________________________________________

