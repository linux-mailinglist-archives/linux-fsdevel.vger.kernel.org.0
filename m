Return-Path: <linux-fsdevel+bounces-29042-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D2B973D95
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 18:45:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 166171F28ED0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 16:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24D11A2564;
	Tue, 10 Sep 2024 16:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k57BnT05"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529DF1A2550;
	Tue, 10 Sep 2024 16:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725986713; cv=none; b=OSOJyJCkv/9Q1xyMdzKekuAD1RVVs7RS2tMJda61QUTmAIJ+/BdFaskI34f9aEorYlAnxm/VGWhPeTP1+wa1JgtdMTLUibYA9Kbrv2NT++mpmN79mphD5EEJzAbQ976VXeRCHCzBg9k5kqmcNgSFC9ssc/G8tPrCoQlFbg+Qw2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725986713; c=relaxed/simple;
	bh=ySgXm6bMqTKIL9j5OpL3gGZ6nEzzIP+bWQqAR3qS8i8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ABUsXhhg2UZB0YNfF0nABZ9erSAu2faeEBtUBXA94h7nS76Kw/rnWM0DVvOSX8O1rreCDXD9W9XQyNqoXgG9doMXO9XdRKII+XyHKKPuoNHyTt/UW2Rs/nQYMeGq5nAjZWu8PK4xHW51Mn/utHMYDWKdOzWLfWoBICD8o+UyDr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k57BnT05; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 979E6C4CEC3;
	Tue, 10 Sep 2024 16:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725986712;
	bh=ySgXm6bMqTKIL9j5OpL3gGZ6nEzzIP+bWQqAR3qS8i8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k57BnT05yKjyTzka1Ttsba/W3TuoGwJuuIIrRqDVKNDOXjj4ZU6As7sbhUbo35L2p
	 ZwP8ixy2iGE/ST0R5O/dbqbdWREp8gd65SpckSTZ5EuZo6hB+2pRDFJYR94OqQlnma
	 cLWhn7oX8QLA/fR1kC6lQt6VS7VbjO4EafFPNBChoNIAYD+8tFt5xbIr4QbnvK6SrX
	 P5LrlJtreK/tuaigNfGu0o5WyXBDHqNl/4TWmYSu71hdfRwwn93VSshigZNeEC4+B0
	 zq5LoW0WCZYQTlrtttESx3jSuJg7T+eWl7ft7SeXihQUq7OMOR9XR0nog43ead/dBY
	 ck1ehyIC/uxFw==
Date: Tue, 10 Sep 2024 12:45:11 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Anna Schumaker <anna.schumaker@oracle.com>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v15 00/26] nfs/nfsd: add support for LOCALIO
Message-ID: <ZuB3l71L_Gu1Xsrn@kernel.org>
References: <20240831223755.8569-1-snitzer@kernel.org>
 <66ab4e72-2d6e-4b78-a0ea-168e1617c049@oracle.com>
 <ZttnSndjMaU1oObp@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ZttnSndjMaU1oObp@kernel.org>

On Fri, Sep 06, 2024 at 04:34:18PM -0400, Mike Snitzer wrote:
> On Fri, Sep 06, 2024 at 03:31:41PM -0400, Anna Schumaker wrote:
> > Hi Mike,
> >=20
> > On 8/31/24 6:37 PM, Mike Snitzer wrote:
> > > Hi,
> > >=20
> > > Happy Labor Day weekend (US holiday on Monday)!  Seems apropos to send
> > > what I hope the final LOCALIO patchset this weekend: its my birthday
> > > this coming Tuesday, so _if_ LOCALIO were to get merged for 6.12
> > > inclusion sometime next week: best b-day gift in a while! ;)
> > >=20
> > > Anyway, I've been busy incorporating all the review feedback from v14
> > > _and_ working closely with NeilBrown to address some lingering net-ns
> > > refcounting and nfsd modules refcounting issues, and more (Chnagelog
> > > below):
> > >=20
> >=20
> > I've been running tests on localio this afternoon after finishing up go=
ing through v15 of the patches (I was most of the way through when you post=
ed v16, so I haven't updated yet!). Cthon tests passed on all NFS versions,=
 and xfstests passed on NFS v4.x. However, I saw this crash from xfstests w=
ith NFS v3:
> >=20
> > [ 1502.440896] run fstests generic/633 at 2024-09-06 14:04:17
> > [ 1502.694356] process 'vfstest' launched '/dev/fd/4/file1' with NULL a=
rgv: empty string added
> > [ 1502.699514] Oops: general protection fault, probably for non-canonic=
al address 0x6c616e69665f6140: 0000 [#1] PREEMPT SMP NOPTI
> > [ 1502.700970] CPU: 3 UID: 0 PID: 513 Comm: nfsd Not tainted 6.11.0-rc6=
-g0c79a48cd64d-dirty+ #42323 70d41673e6cbf8e3437eb227e0a9c3c46ed3b289
> > [ 1502.702506] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS=
 unknown 2/2/2022
> > [ 1502.703593] RIP: 0010:nfsd_cache_lookup+0x2b3/0x840 [nfsd]
> > [ 1502.704474] Code: 8d bb 30 02 00 00 bb 01 00 00 00 eb 12 49 8d 46 10=
 48 8b 08 ff c3 48 85 c9 0f 84 9c 00 00 00 49 89 ce 4c 8d 61 c8 41 8b 45 00=
 <3b> 41 c8 75 1f 41 8b 45 04 41 3b 46 cc 74 15 8b 15 2c c6 b8 f2 be
> > [ 1502.706931] RSP: 0018:ffffc27ac0a2fd18 EFLAGS: 00010206
> > [ 1502.707547] RAX: 00000000b95691f7 RBX: 0000000000000002 RCX: 6c616e6=
9665f6178
> > [ 1502.708311] RDX: 0000000000000034 RSI: ffffa0f8a652a780 RDI: ffffa0f=
8c04cfb00
> > [ 1502.709055] RBP: ffffa0f8827b2ba0 R08: 0000000000000000 R09: ffffa0f=
8c04cfb00
> > [ 1502.709728] R10: 000000000000009c R11: ffffffffc0c77ef0 R12: 6c616e6=
9665f6140
> > [ 1502.710382] R13: ffffa0f8c04cfb00 R14: 6c616e69665f6178 R15: ffffa0f=
883d4e230
> > [ 1502.710982] FS:  0000000000000000(0000) GS:ffffa0f8fbd80000(0000) kn=
lGS:0000000000000000
> > [ 1502.711645] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [ 1502.712087] CR2: 00007f2c4d1ed640 CR3: 0000000117a1e000 CR4: 0000000=
000750ef0
> > [ 1502.712615] PKRU: 55555554
> > [ 1502.712804] Call Trace:
> > [ 1502.712979]  <TASK>
> > [ 1502.713131]  ? __die_body+0x6a/0xb0
> > [ 1502.713372]  ? die_addr+0xa4/0xd0
> > [ 1502.713583]  ? exc_general_protection+0x16c/0x210
> > [ 1502.713880]  ? asm_exc_general_protection+0x26/0x30
> > [ 1502.714164]  ? __pfx_nfs3svc_decode_sattrargs+0x10/0x10 [nfsd a9c12e=
0cc9647b021c55f7745e60fc1cbe54674a]
> > [ 1502.714700]  ? nfsd_cache_lookup+0x2b3/0x840 [nfsd a9c12e0cc9647b021=
c55f7745e60fc1cbe54674a]
> > [ 1502.715156]  ? nfsd_cache_lookup+0x2e7/0x840 [nfsd a9c12e0cc9647b021=
c55f7745e60fc1cbe54674a]
> > [ 1502.715590]  nfsd_dispatch+0x93/0x210 [nfsd a9c12e0cc9647b021c55f774=
5e60fc1cbe54674a]
> > [ 1502.715997]  svc_process_common+0x324/0x680 [sunrpc 2f7328527f188558=
dea7880294960ba75bb09c81]
> > [ 1502.716439]  ? __pfx_nfsd_dispatch+0x10/0x10 [nfsd a9c12e0cc9647b021=
c55f7745e60fc1cbe54674a]
> > [ 1502.716873]  svc_process+0x117/0x1c0 [sunrpc 2f7328527f188558dea7880=
294960ba75bb09c81]
> > [ 1502.717276]  svc_recv+0xabf/0xc00 [sunrpc 2f7328527f188558dea7880294=
960ba75bb09c81]
> > [ 1502.717674]  nfsd+0xc5/0x100 [nfsd a9c12e0cc9647b021c55f7745e60fc1cb=
e54674a]
> > [ 1502.718225]  ? __pfx_nfsd+0x10/0x10 [nfsd a9c12e0cc9647b021c55f7745e=
60fc1cbe54674a]
> > [ 1502.718641]  kthread+0xe9/0x110
> > [ 1502.718798]  ? __pfx_kthread+0x10/0x10
> > [ 1502.718979]  ret_from_fork+0x37/0x50
> > [ 1502.719154]  ? __pfx_kthread+0x10/0x10
> > [ 1502.719335]  ret_from_fork_asm+0x1a/0x30
> > [ 1502.719525]  </TASK>
> > [ 1502.719636] Modules linked in: nfsv3 overlay cbc cts rpcsec_gss_krb5=
 nfsv4 nfs rpcrdma rdma_cm iw_cm ib_cm cfg80211 ib_core rfkill 8021q garp s=
tp mrp llc vfat fat intel_rapl_msr intel_rapl_common intel_uncore_frequency=
_common intel_pmc_core intel_vsec pmt_telemetry pmt_class kvm_intel kvm snd=
_hda_codec_generic snd_hda_intel snd_intel_dspcfg crct10dif_pclmul crc32_pc=
lmul snd_hda_codec polyval_clmulni polyval_generic ghash_clmulni_intel snd_=
hwdep sha512_ssse3 snd_hda_core sha256_ssse3 sha1_ssse3 iTCO_wdt snd_pcm in=
tel_pmc_bxt iTCO_vendor_support aesni_intel snd_timer gf128mul snd psmouse =
crypto_simd i2c_i801 cryptd joydev pcspkr rapl lpc_ich i2c_smbus soundcore =
mousedev mac_hid nfsd nfs_acl lockd auth_rpcgss grace nfs_localio sunrpc us=
bip_host dm_mod usbip_core loop nfnetlink vsock_loopback vmw_vsock_virtio_t=
ransport_common vmw_vsock_vmci_transport vmw_vmci vsock qemu_fw_cfg ip_tabl=
es x_tables hid_generic usbhid xfs libcrc32c crc32c_generic serio_raw atkbd=
 libps2 virtio_net vivaldi_fmap virtio_gpu virtio_console
> > [ 1502.719684]  net_failover virtio_blk crc32c_intel i8042 failover vir=
tio_rng xhci_pci intel_agp virtio_balloon xhci_pci_renesas virtio_dma_buf s=
erio intel_gtt
> > [ 1502.724436] ---[ end trace 0000000000000000 ]---
> >=20
> > Please let me know if there are any other details you need about my set=
up to help debug this!
>=20
> Hmm, I haven't seen this issue, my runs of xfstests with LOCALIO
> enabled look solid:
> https://evilpiepirate.org/~testdashboard/ci?user=3Dsnitzer&branch=3Dsnitm=
-nfs-next&test=3D^fs.nfs.fstests.generic.633$
>=20
> And I know Chuck has been testing xfstests and more with the patches
> applied but LOCALIO disabled in his kernel config.
>=20
> The stack seems to indicate nfsd is just handling a request (so it
> isn't using LOCALIO, at least not for this op).
>=20
> Probably best if you do try v16.  v15 has issues v16 addressed.  If
> you can reproduce with v16 please share your kernel .config and
> xfstests config.=20
>=20
> Note that I've only really tested my changes against v6.11-rc4.  But I
> can rebase on v6.11-rc6 if you find v16 still fails for you.

Hi Anna,

Just checking back, how is LOCALIO for you at this point?  Anything
you're continuing to see as an issue or need from me?

Thanks,
Mike

