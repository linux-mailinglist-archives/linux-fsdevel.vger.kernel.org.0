Return-Path: <linux-fsdevel+bounces-62323-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57061B8D67E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Sep 2025 09:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11A0C44097B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Sep 2025 07:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 497BA2D062E;
	Sun, 21 Sep 2025 07:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="kyIz7x0A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16F235965;
	Sun, 21 Sep 2025 07:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758439682; cv=none; b=Ku2EPd+v3KU7WQlPi5AWOO9YDXCc8u5Kgqq4H5LxGNsV2Kqr/BNho4KMxOelmvGNHII+T/3gO7tzqS3DnHG6bJnDdV7i7i3Y6T/igSP80anq2l7cP7oNKVoysNw25x/hs1BPY88xSW5tbbqjT+56wmKtGh5Z554PZpt7S9HFLzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758439682; c=relaxed/simple;
	bh=JqIb/MaIDNjBDV4Eq6eEGvX5RN5p2FW2Okcuox4xXAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CLcItc8aNHekNxrOePcM6g5BtKOxn1PwmDsJ8fMjyHTzQKUQWvM70ps4a2i0cTblZRIpoTWgYbqmQKrwt7vzjWQa1p+CzEYAVkrevDGHTXAGOgTJ9QJPhOoI7mUqvzmeJJvCs3zn86xVaelTUu0xzNutEopKi0QOxovXQgkp20I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=kyIz7x0A; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description;
	bh=BgXU7JpzOKWlJQQUnRd3cvmoQ2vgKa6/9nYZ7mnQ5bc=; b=kyIz7x0A58ISblrMPBugmQN27Y
	181yrLBrTCl0rUfD9f98dvdAoN/a16W0dHyKzk3RCfEy8twgPxHpgQDui49n9kLJj2PnIw/FPHdY0
	WI1k7TILk1N57TjQ9ubWD8ckymC2cx+R+LS0dTBka87j1PJwZfYLMfcJYklyH/6oafqoKviPiThPu
	cFVdBjF2PO7Upsglp7P0YLeKKSUFsXDlV0BpJF4jDRe+h1MzrWtR8RXwgqjaD3IH5ci+8qA0rnK+V
	3nf36FigU/QgNWT3K9kaRAb+SHdWLHheI2o2k6Xkcc0flBPyZ+rJ9zovHbYICF0S5n3DtWSNDgb0e
	yZ8eUokw==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <carnil@debian.org>)
	id 1v0EAU-00GikC-Ij; Sun, 21 Sep 2025 07:07:30 +0000
Received: by eldamar.lan (Postfix, from userid 1000)
	id 6735DBE2EE7; Sun, 21 Sep 2025 09:07:29 +0200 (CEST)
Date: Sun, 21 Sep 2025 09:07:29 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: 1111455@bugs.debian.org, 1111455-submitter@bugs.debian.org,
	Benoit Panizzon <bp@imp.ch>
Cc: Max Kellermann <max.kellermann@ionos.com>,
	David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>, netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: Bug#1111455: [bp@imp.ch: Bug#1111455:
 linux-image-6.12.41+deb13-amd64: kernel BUG at fs/netfs/read_collect.c:316
 netfs: Can't donate prior to front]
Message-ID: <aM-kMVtUhnqrcwrc@eldamar.lan>
References: <175550547264.3745.5845128440223069497.reportbug@go.imp.ch>
 <aKMdIgkSWw9koCPC@eldamar.lan>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <aKMdIgkSWw9koCPC@eldamar.lan>
X-Debian-User: carnil

Hi Benoit,

On Mon, Aug 18, 2025 at 02:31:30PM +0200, Salvatore Bonaccorso wrote:
> Hi,
>=20
> A user in Debian reported the following kernel oops when running on
> 6.12.41 (but apparently as well on older versions, though there were
> several netfs related similar issues, so including Max Kellermann as
> well in the recipients)
>=20
> The report from Benoit Panizzon is as follows:
>=20
> > From: Benoit Panizzon <bp@imp.ch>
> > Resent-From: Benoit Panizzon <bp@imp.ch>
> > Reply-To: Benoit Panizzon <bp@imp.ch>, 1111455@bugs.debian.org
> > X-Mailer: reportbug 13.2.0
> > Date: Mon, 18 Aug 2025 10:24:32 +0200
> > To: Debian Bug Tracking System <submit@bugs.debian.org>
> > Subject: Bug#1111455: linux-image-6.12.41+deb13-amd64: kernel BUG at fs=
/netfs/read_collect.c:316 netfs: Can't donate
> > 	prior to front
> > Delivered-To: lists-debian-kernel@bendel.debian.org
> > Delivered-To: submit@bugs.debian.org
> > Message-ID: <175550547264.3745.5845128440223069497.reportbug@go.imp.ch>
> >=20
> > Package: src:linux
> > Version: 6.12.41-1
> > Severity: grave
> > Justification: renders package unusable
> > X-Debbugs-Cc: debian-amd64@lists.debian.org
> > User: debian-amd64@lists.debian.org
> > Usertags: amd64
> >=20
> > Dear Maintainer,
> >=20
> > Updated my workstation from Bookworm to Trixie. /home on NFS
> >=20
> > Applications accessing data on NFS shares become unresponsive one after=
 the other after a couple of minutes.
> >=20
> > Especially affected:
> > * Claws-Mail
> > * Chromium
> >=20
> > Suspected cachefsd being the culpit and disabled - issue persists.
> >=20
> > It looks like an invalid opcode is being used. Fairly recent CPU in use:
> >=20
> > vendor_id	: AuthenticAMD
> > cpu family	: 25
> > model		: 80
> > model name	: AMD Ryzen 7 PRO 5750GE with Radeon Graphics
> > stepping	: 0
> > microcode	: 0xa500011
> >=20
> > Google found reports of others affected with similar kernel versions mo=
stly when accessing SMB shares.
> >=20
> > [Mo Aug 18 10:11:19 2025] netfs: Can't donate prior to front
> > [Mo Aug 18 10:11:19 2025] R=3D00001e07[4] s=3D6000-7fff 0/2000/2000
> > [Mo Aug 18 10:11:19 2025] folio: 4000-7fff
> > [Mo Aug 18 10:11:19 2025] donated: prev=3D0 next=3D0
> > [Mo Aug 18 10:11:19 2025] s=3D6000 av=3D2000 part=3D2000
> > [Mo Aug 18 10:11:19 2025] ------------[ cut here ]------------
> > [Mo Aug 18 10:11:19 2025] kernel BUG at fs/netfs/read_collect.c:316!
> > [Mo Aug 18 10:11:19 2025] Oops: invalid opcode: 0000 [#1] PREEMPT SMP N=
OPTI
> > [Mo Aug 18 10:11:19 2025] CPU: 5 UID: 0 PID: 115 Comm: kworker/u64:1 No=
t tainted 6.12.41+deb13-amd64 #1  Debian 6.12.41-1
> > [Mo Aug 18 10:11:19 2025] Hardware name: LENOVO 11JN000JGE/32E4, BIOS M=
47KT26A 11/23/2022
> > [Mo Aug 18 10:11:19 2025] Workqueue: nfsiod rpc_async_release [sunrpc]
> > [Mo Aug 18 10:11:19 2025] RIP: 0010:netfs_consume_read_data.isra.0+0xb7=
9/0xb80 [netfs]
> > [Mo Aug 18 10:11:19 2025] Code: 48 89 ea 31 f6 48 c7 c7 96 95 6f c2 e8 =
d0 8d a2 e1 48 8b 4c 24 10 4c 89 fe 48 8b 54 24 20 48 c7 c7 b2 95 6f c2 e8 =
b7 8d a2 e1 <0f> 0b 90 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90 9=
0 90
> > [Mo Aug 18 10:11:19 2025] RSP: 0018:ffffb4234057bd58 EFLAGS: 00010246
> > [Mo Aug 18 10:11:19 2025] RAX: 0000000000000018 RBX: ffff9aed62651ec0 R=
CX: 0000000000000027
> > [Mo Aug 18 10:11:19 2025] RDX: 0000000000000000 RSI: 0000000000000001 R=
DI: ffff9af04e4a1740
> > [Mo Aug 18 10:11:19 2025] RBP: 0000000000000000 R08: 0000000000000000 R=
09: ffffb4234057bbe8
> > [Mo Aug 18 10:11:19 2025] R10: ffffffffa50b43a8 R11: 0000000000000003 R=
12: ffff9aed6c9081e8
> > [Mo Aug 18 10:11:19 2025] R13: 0000000000004000 R14: ffff9aed6c9081e8 R=
15: 0000000000006000
> > [Mo Aug 18 10:11:19 2025] FS:  0000000000000000(0000) GS:ffff9af04e4800=
00(0000) knlGS:0000000000000000
> > [Mo Aug 18 10:11:19 2025] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005=
0033
> > [Mo Aug 18 10:11:19 2025] CR2: 00003d3407849020 CR3: 00000002f1822000 C=
R4: 0000000000f50ef0
> > [Mo Aug 18 10:11:19 2025] PKRU: 55555554
> > [Mo Aug 18 10:11:19 2025] Call Trace:
> > [Mo Aug 18 10:11:19 2025]  <TASK>
> > [Mo Aug 18 10:11:19 2025]  netfs_read_subreq_terminated+0x2ab/0x3e0 [ne=
tfs]
> > [Mo Aug 18 10:11:19 2025]  nfs_netfs_read_completion+0x9c/0xc0 [nfs]
> > [Mo Aug 18 10:11:19 2025]  nfs_read_completion+0xf6/0x130 [nfs]
> > [Mo Aug 18 10:11:19 2025]  rpc_free_task+0x39/0x60 [sunrpc]
> > [Mo Aug 18 10:11:19 2025]  rpc_async_release+0x2f/0x40 [sunrpc]
> > [Mo Aug 18 10:11:19 2025]  process_one_work+0x177/0x330
> > [Mo Aug 18 10:11:19 2025]  worker_thread+0x251/0x390
> > [Mo Aug 18 10:11:19 2025]  ? __pfx_worker_thread+0x10/0x10
> > [Mo Aug 18 10:11:19 2025]  kthread+0xd2/0x100
> > [Mo Aug 18 10:11:19 2025]  ? __pfx_kthread+0x10/0x10
> > [Mo Aug 18 10:11:19 2025]  ret_from_fork+0x34/0x50
> > [Mo Aug 18 10:11:19 2025]  ? __pfx_kthread+0x10/0x10
> > [Mo Aug 18 10:11:19 2025]  ret_from_fork_asm+0x1a/0x30
> > [Mo Aug 18 10:11:19 2025]  </TASK>
> > [Mo Aug 18 10:11:19 2025] Modules linked in: nfsv3 rpcsec_gss_krb5 nfsv=
4 dns_resolver nfs netfs nft_chain_nat xt_MASQUERADE nf_nat nf_conntrack nf=
_defrag_ipv6 nf_defrag_ipv4 nft_compat nf_tables libcrc32c wireguard libcha=
cha20poly1305 chacha_x86_64 poly1305_x86_64 curve25519_x86_64 libcurve25519=
_generic libchacha vxlan ip6_udp_tunnel udp_tunnel bridge stp llc btusb btr=
tl btintel btbcm btmtk bluetooth joydev qrtr nfsd auth_rpcgss binfmt_misc n=
fs_acl lockd grace nls_ascii nls_cp437 sunrpc vfat fat amd_atl intel_rapl_m=
sr intel_rapl_common rtw88_8822ce rtw88_8822c edac_mce_amd rtw88_pci snd_so=
f_amd_rembrandt snd_sof_amd_acp rtw88_core kvm_amd snd_sof_pci snd_sof_xten=
sa_dsp snd_sof snd_hda_codec_realtek mac80211 kvm snd_hda_codec_generic snd=
_sof_utils snd_hda_scodec_component snd_soc_core snd_hda_codec_hdmi snd_hda=
_intel snd_compress snd_intel_dspcfg libarc4 snd_pcm_dmaengine irqbypass sn=
d_intel_sdw_acpi snd_pci_ps crct10dif_pclmul snd_hda_codec ghash_clmulni_in=
tel snd_rpl_pci_acp6x cfg80211 snd_hda_core sha512_ssse3 snd_acp_pci
> > [Mo Aug 18 10:11:19 2025]  sha256_ssse3 snd_acp_legacy_common sha1_ssse=
3 snd_hwdep snd_pci_acp6x aesni_intel snd_pcm gf128mul snd_pci_acp5x crypto=
_simd think_lmi snd_timer snd_rn_pci_acp3x cryptd firmware_attributes_class=
 snd_acp_config wmi_bmof snd snd_soc_acpi ee1004 rapl snd_pci_acp3x pcspkr =
ccp k10temp rfkill soundcore evdev parport_pc ppdev lp parport configfs efi=
_pstore nfnetlink efivarfs ip_tables x_tables autofs4 ext4 mbcache jbd2 crc=
32c_generic hid_plantronics hid_generic usbhid hid amdgpu dm_mod amdxcp drm=
_exec gpu_sched drm_buddy i2c_algo_bit drm_suballoc_helper drm_display_help=
er cec rc_core drm_ttm_helper xhci_pci ttm xhci_hcd drm_kms_helper drm r816=
9 nvme usbcore realtek sp5100_tco nvme_core mdio_devres watchdog libphy crc=
32_pclmul i2c_piix4 video crc32c_intel usb_common nvme_auth i2c_smbus crc16=
 wmi button
> > [Mo Aug 18 10:11:19 2025] ---[ end trace 0000000000000000 ]---
>=20
> Any ideas here? Benoit can you please es well test the current 6.16.1
> ideally to verify if the problem persists there as well?

Can you still reproduce this with a more current 6.12.y version? Can
you test as well the newest version of the 6.16.y version (even there
was a major refactoring to see if it affects only the 6.12.y series)?

Regards,
Salvatore

