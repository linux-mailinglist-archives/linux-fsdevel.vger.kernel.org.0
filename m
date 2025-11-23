Return-Path: <linux-fsdevel+bounces-69512-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E2985C7E12E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 13:51:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 237994E3D95
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 12:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED1719DF8D;
	Sun, 23 Nov 2025 12:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JojBz4Fs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE68819DFA2;
	Sun, 23 Nov 2025 12:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763902288; cv=none; b=CgHAnLCLdy1I8NIS+UQaJsQbbbnV0WOSS9sWcq5FdPK1z7skkxAWv8Y5efZK8FS3+YcXETlfg/SrKCEF+PJMnC/95MehPoJQPitfDb1vio3lwMi/ooq+lwSqmPIQImClea1m50Jct/DEJQImHhq1hcze5t7aO8/Cp4RtCY1DiIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763902288; c=relaxed/simple;
	bh=tyDtejsqnX/IF8wlfcVY2P1i1OAzubkFgoZ4LxfBpfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aXplfqLEu5CJUlH/E8PBvQLbCdRrDUOxPMAesh9e4If6Pi/zXgx9Z7WQuRZX29LbDt30JTUc4a8jSf1ADmyWB5QCqXVyMR+YzAQWuNp9WqJoqqJ2ASPgHXyr4nndckeJTR2mvcTs5x/5SG2YXqyKZKBbvsx/ChLTbaDItbQJoa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JojBz4Fs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7ADBC113D0;
	Sun, 23 Nov 2025 12:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763902287;
	bh=tyDtejsqnX/IF8wlfcVY2P1i1OAzubkFgoZ4LxfBpfw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JojBz4FsM+uT15B4CmhM1JwSvB0i/Uh9Q12JjrtxcV6awjeCJ1lfC2aJ1NQc6Trv7
	 Sq6m3WspDCHTo3Qu1dIx3qAhCoVwep6K7d3Kw6oshGdR6tbHnhHQfHA17QVCLU13zs
	 dmS1TwIJ4bJ3LjDCIU4LfCjUwGdokSgdIOR22NKGtvTjEBMtO2uHgL9/6iDzxY3tkr
	 7MpkXs1NT788LUvAZPHQoFUj3VWDAVh8Z2NqH2u18mvcS7X42ZafE8AeDJg17IkwjO
	 04nLjsiw+IUtoxmtMLTKxM2EppBhgeTdmMoVyHu6cBSm7iD6j4VcvC3isd33WVBXY1
	 d0RYm2gzrjTwg==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id 415D61ACCCAB; Sun, 23 Nov 2025 12:51:24 +0000 (GMT)
Date: Sun, 23 Nov 2025 12:51:24 +0000
From: Mark Brown <broonie@kernel.org>
To: Andrei Vagin <avagin@google.com>
Cc: Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] fs/namespace: correctly handle errors returned by
 grab_requested_mnt_ns
Message-ID: <aSMDTEAih_QgdLBg@sirena.co.uk>
References: <20251111062815.2546189-1-avagin@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Q9wk31LSaiO1BkPa"
Content-Disposition: inline
In-Reply-To: <20251111062815.2546189-1-avagin@google.com>
X-Cookie: No other warranty expressed or implied.


--Q9wk31LSaiO1BkPa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2025 at 06:28:15AM +0000, Andrei Vagin wrote:
> grab_requested_mnt_ns was changed to return error codes on failure, but
> its callers were not updated to check for error pointers, still checking
> only for a NULL return value.

I'm seeing regressions in mainline in the LTP listmount04 test on some
arm64 platforms:

tst_test.c:1953: TINFO: LTP version: 20250530
tst_test.c:1956: TINFO: Tested kernel: 6.18.0-rc6-00270-g89edd36fd801 #1 SM=
P PREEMPT @1763835814 aarch64
tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
tst_test.c:1774: TINFO: Overall timeout per run is 0h 05m 24s
listmount04.c:128: TPASS: request points to unaccessible memory : EFAULT (1=
4)
listmount04.c:128: TPASS: mnt_ids points to unaccessible memory : EFAULT (1=
4)
listmount04.c:128: TPASS: invalid flags : EINVAL (22)
listmount04.c:128: TPASS: insufficient mnt_id_req.size : EINVAL (22)
listmount04.c:128: TFAIL: invalid mnt_id_req.spare expected EINVAL: EBADF (=
9)
listmount04.c:128: TPASS: invalid mnt_id_req.param : EINVAL (22)
listmount04.c:128: TPASS: invalid mnt_id_req.mnt_id : EINVAL (22)
listmount04.c:128: TPASS: non-existant mnt_id : ENOENT (2)

which bisect to this patch.  I'm not sure if the change in error code
here is actually a real issue or not, this feels like an overly
sensitive test, but perhaps there's some spec requirement or something
so it seemed reasonable to report.

Full log:

   https://lava.sirena.org.uk/scheduler/job/2127016#L6974

bisect log:

# bad: [89edd36fd801efdb3d2f38bbf7791a293c24bb45] Merge tag 'xfs-fixes-6.18=
-rc7' of git://git.kernel.org/pub/scm/fs/xfs/xfs-linux
# good: [e5f0a698b34ed76002dc5cff3804a61c80233a7a] Linux 6.17
# good: [1788ef30725da53face7e311cdf62ad65fababcd] drm/amd/display: Fix pbn=
 to kbps Conversion
# good: [c156c7f27ecdb7b89dbbeaaa1f40d9fadc3c1680] drm/amdgpu: Add sriov vf=
 check for VCN per queue reset support.
# good: [c97da4785b3bbc60c24cfd1ffea1d7c8b90ed743] drm/amd/display: Add an =
HPD filter for HDMI
# good: [e256f7b4e57d9f1149efd0e7745f77d8e615177b] Merge tag 'core-urgent-2=
025-11-15' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
# good: [1cc41c88ef00de0f3216c5f4b9cfab47de1c49d3] Merge tag 'nfs-for-6.18-=
3' of git://git.linux-nfs.org/projects/anna/linux-nfs
# good: [b82ebaf298643cad497ef8daf263c0652d486eec] Merge tag 'kvmarm-fixes-=
6.18-3' of git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm into=
 HEAD
# good: [8612badc331bcab2068baefa69e1458085ed89e3] drm/amd/display: Increas=
e DPCD read retries
# good: [5bab4c89390f32b2f491f49a151948cd226dd909] drm/amd/display: Clear t=
he CUR_ENABLE register on DCN20 on DPP5
# good: [6a23ae0a96a600d1d12557add110e0bb6e32730c] Linux 6.18-rc6
# good: [7a0892d2836e12cc61b6823f888629a3eb64e268] Merge tag 'pci-v6.18-fix=
es-5' of git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci
# good: [ccc0011804d406493da6d97f913c43de842f1abb] Merge tag 'mmc-v6.18-rc2=
' of git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc
# good: [d4f8cccc6230bd2f3aa28348a4c71f0dc3e89788] Merge tag 'block-6.18-20=
251114' of git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux
# good: [bb1a6ddcfaa54b156e6e2ac61a986c4f5f8cb841] Merge tag 'timers-urgent=
-2025-11-15' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
# good: [7254a2b52279091683e0228095118ee69ce9742f] Merge tag 'firewire-fixe=
s-6.18-rc6' of git://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux=
1394
# good: [f824272b6e3fe24950abc527136e8140f67b0b23] Merge tag 's390-6.18-4' =
of git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux
# good: [aecba2e013ab79dde441dfc81a32792ced229539] Merge tag 'pm-6.18-rc6' =
of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
# good: [2ccec5944606ee1389abc7ee41986825c6ceb574] Merge tag 'erofs-for-6.1=
8-rc6-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs
# good: [6fa9041b7177f6771817b95e83f6df17b147c8c6] Merge tag 'nfsd-6.18-3' =
of git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux
# good: [360b3730f8eab6c4467c6cca4cb0e30902174a63] ASoC: rsnd: fix OF node =
reference leak in rsnd_ssiu_probe()
# good: [6da43bbeb6918164f7287269881a5f861ae09d7e] Merge tag 'vfio-v6.18-rc=
6' of https://github.com/awilliam/linux-vfio
# good: [e927c520e1ba6b6a0b2022adf5ba455ee1553fc1] Merge tag 'loongarch-fix=
es-6.18-1' of git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linu=
x-loongson
# good: [7564f3543cf19b1232553ab10399c9fbf514b5f3] Merge branches 'acpi-cpp=
c' and 'acpi-tables'
# good: [9b9e43704d2b05514aeeaea36311addba2c72408] Merge tag 'slab-for-6.18=
-rc6' of git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab
# good: [a3f8f8662771285511ae26c4c8d3ba1cd22159b9] power: always freeze efi=
varfs
# good: [ebd4469e7af61019daaf904fdcba07a9ecd18440] entry: Fix ifndef around=
 arch_xfer_to_guest_mode_handle_work() stub
# good: [eb2d6774cc0d9d6ab8f924825695a85c14b2e0c2] ASoC: SDCA: bug fix whil=
e parsing mipi-sdca-control-cn-list
# good: [66e9feb03e7cf8983b1d0c540e2dad90d5146d48] spi: Add TODO comment ab=
out ACPI GPIO setup
# good: [4427259cc7f7571a157fbc9b5011e1ef6fe0a4a8] Merge tag 'riscv-for-lin=
us-6.18-rc6' of git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux
# good: [4ea7c1717f3f2344f7a1cdab4f5875cfa89c87a9] Merge tag 'for-linus' of=
 git://git.kernel.org/pub/scm/virt/kvm/kvm
# good: [24172e0d79900908cf5ebf366600616d29c9b417] Merge tag 'arm64-fixes' =
of git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux
# good: [da32d155f4a8937952ca6fd55d3270fec1c3799f] Merge tag 'gpio-fixes-fo=
r-v6.18-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux
# good: [439fc29dfd3b9c072dfff292d91cfa2f6cfb702b] Merge tag 'drm-fixes-202=
5-11-09' of https://gitlab.freedesktop.org/drm/kernel
# good: [e811c33b1f137be26a20444b79db8cbc1fca1c89] Merge tag 'drm-fixes-202=
5-11-08' of https://gitlab.freedesktop.org/drm/kernel
# good: [e9a6fb0bcdd7609be6969112f3fbfcce3b1d4a7c] Linux 6.18-rc5
# good: [0fce75870666b46b700cfbd3216380b422f975da] ACPI: CPPC: Limit perf c=
trs in PCC check only to online CPUs
# good: [8821c8e80a65bc4eb73daf63b34aac6b8ad69461] ACPI: CPPC: Perform fast=
 check switch only for online CPUs
# good: [f850568efe3a7a9ec4df357cfad1f997f0058924] Merge tag 'i2c-for-6.18-=
rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux
# good: [0d7bee10beeb59b1133bf5a4749b17a4ef3bbb01] Merge tag 'x86-urgent-20=
25-11-08' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
# good: [7bb4d6512545a792a6cd8d6c8be5718920b9b11a] Merge tag 'v6.18rc4-SMB-=
client-fixes' of git://git.samba.org/sfrench/cifs-2.6
# good: [4012abe8a78fbb8869634130024266eaef7081fe] smb: client: validate ch=
ange notify buffer before copy
# good: [0e5ba55750c1f7fb194a0022b8c887e6413da9b1] Merge tag 'kvm-x86-fixes=
-6.18-rc5' of https://github.com/kvm-x86/linux into HEAD
# good: [6f86d0534fddfbd08687fa0f01479d4226bc3c3d] mm/secretmem: fix use-af=
ter-free race in fault handler
# good: [4a0c9b3391999818e2c5b93719699b255be1f682] Merge tag 'probes-fixes-=
v6.18-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-tra=
ce
# good: [3dc8c73365d3ca25c99e7e1a0f493039d7291df5] ASoC: codecs: va-macro: =
fix resource leak in probe error path
# good: [a1388fcb52fcad3e0b06e2cdd0ed757a82a5be30] Merge tag 'libcrypto-for=
-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux
# good: [939edfaa10f1d22e6af6a84bf4bd96dc49c67302] spi: xilinx: increase nu=
mber of retries before declaring stall
# good: [29528c8e643bb0c54da01237a35010c6438423d2] ASoC: tas2781: fix getti=
ng the wrong device number
# good: [c2c2ccfd4ba72718266a56f3ecc34c989cb5b7a0] Merge tag 'net-6.18-rc5'=
 of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
# good: [84f5526e4dce0a44d050ceb1b1bf21d43016d91b] ASoC: tas2783A: Fix issu=
es in firmware parsing
# good: [86d57d9c07d54e8cb385ffe800930816ccdba0c1] spi: imx: keep dma reque=
st disabled before dma transfer setup
# good: [b540de9e3b4fab3b9e10f30714a6f5c1b2a50ec3] smb: client: fix refcoun=
t leak in smb2_set_path_attr
# good: [c9cfc122f03711a5124b4aafab3211cf4d35a2ac] Merge tag 'for-6.18-rc4-=
tag' of git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux
# good: [63b5aa01da0f38cdbd97d021477258e511631497] vfat: fix missing sb_min=
_blocksize() return value checks
# good: [284922f4c563aa3a8558a00f2a05722133237fe8] x86: uaccess: don't use =
runtime-const rewriting in modules
# good: [636f4618b1cd96f6b5a2b8c7c4f665c8533ecf13] regulator: fixed: fix GP=
IO descriptor leak on register failure
# good: [3cd2018e15b3d66d2187d92867e265f45ad79e6f] spi: Try to get ACPI GPI=
O IRQ earlier
# good: [1c353dc8d962de652bc7ad2ba2e63f553331391c] Merge tag 'media/v6.18-2=
' of git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media
# good: [249d96b492efb7a773296ab2c62179918301c146] ASoC: da7213: Use compon=
ent driver suspend/resume
# good: [dc77806cf3b4788d328fddf245e86c5b529f31a2] Merge tag 'rust-fixes-6.=
18' of git://git.kernel.org/pub/scm/linux/kernel/git/ojeda/linux
# good: [8637fa89e678422995301ddb20b74190dffcccee] block: add __must_check =
attribute to sb_min_blocksize()
# good: [17d85f33a83b84e7d36bc3356614ae06c90e7a08] Merge tag 'for-linus' of=
 git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma
# good: [5624d4c3781673da84e6144c359803ca31b66214] Merge tag 'platform-driv=
ers-x86-v6.18-3' of git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/pla=
tform-drivers-x86
# good: [6146a0f1dfae5d37442a9ddcba012add260bceb0] Linux 6.18-rc4
# good: [691d401c7e0e5ea34ac6f8151bc0696db1b2500a] Merge tag 'spi-fix-v6.18=
-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi
# good: [ec0b62ccc986c06552c57f54116171cfd186ef92] Merge tag 'drm-fixes-202=
5-10-31' of https://gitlab.freedesktop.org/drm/kernel
# good: [8da0efc3da9312b65f5cbf06e57d284f69222b2e] ASoC: doc: cs35l56: Upda=
te firmware filename description for B0 silicon
# good: [7f17ef0d47b9aa01b89a92b2514fbfe800d8aeca] perf symbols: Handle '1'=
 symbols in /proc/kallsyms
# good: [ba36dd5ee6fd4643ebbf6ee6eefcecf0b07e35c7] Merge tag 'bpf-fixes' of=
 git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf
# good: [43c2931a95e6b295bfe9e3b90dbe0f7596933e91] kconfig/nconf: Initializ=
e the default locale at startup
# good: [8bb886cb8f3a2811430ddb7d9838e245c57e7f7c] Merge tag 'edac_urgent_f=
or_v6.18_rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras
# good: [b4cd8f94ae7e5b0d83041b186258eba0c8f7c5f7] drm/imagination: Optiona=
lly depend on POWER_SEQUENCING
# good: [74131a0f1b9efc1364871a04b704e54309861668] Merge tag 'objtool-urgen=
t-2025-11-01' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
# good: [b909d77359b82821e1c6b6a3a8a51b355b06fdb5] Merge tag '6.18-rc3-smb-=
client-fixes' of git://git.samba.org/sfrench/cifs-2.6
# good: [47a0925ee4bd2689f0aef4dbd67dd46442fe1ca2] regulator: bd718x7: Fix =
voltages scaled by resistor divider
# good: [d127176862a93c4b3216bda533d2bee170af5e71] Merge tag 'linux_kselfte=
st-fixes-6.18-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/shuah/l=
inux-kselftest
# good: [f260c6aff0b8af236084012d14f9f1bf792ea883] btrfs: fix memory leak o=
f qgroup_list in btrfs_add_qgroup_relation
# good: [2618849f31e7cf51fadd4a5242458501a6d5b315] btrfs: ensure no dirty m=
etadata is written back for an fs with errors
# good: [45f5c9eec43a9bf448f46562f146810831916cc9] ASoC: soc_sdw_utils: rem=
ove cs42l43 component_name
# good: [e53642b87a4f4b03a8d7e5f8507fc3cd0c595ea6] Merge tag 'v6.18-rc3-smb=
-server-fixes' of git://git.samba.org/ksmbd
# good: [5e5c8aa73d99f1daa9f2ec1474b7fc1a6952764b] ASoC: dt-bindings: pm412=
5-sdw: correct number of soundwire ports
# good: [8eefed8f65cc17c31fdf4ab32292b794b34893ad] Merge tag 'nfsd-6.18-2' =
of git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux
# good: [48cbf50531d8eca15b8a811717afdebb8677de9b] regmap: irq: Correct doc=
umentation of wake_invert flag
# good: [e7dbfe6f15b4df34bb169d180bd10f1a3c043814] spi: intel: Add support =
for Oak Stream SPI serial flash
# good: [d2818517e3486d11c9bd55aca3e14059e4c69886] Merge tag 'block-6.18-20=
251023' of git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux
# good: [53abe3e1c154628cc74e33a1bfcd865656e433a5] sched: Remove never used=
 code in mm_cid_get()
# good: [dcb6fa37fd7bc9c3d2b066329b0d27dedf8becaa] Linux 6.18-rc3
# good: [72761a7e31225971d0b29d9195e0ffa986b77867] Merge tag 'driver-core-6=
=2E18-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/driver-core/dri=
ver-core
# good: [2e590d67c2d803d603ac00b85f2fab235df52a1b] Merge tag 'devicetree-fi=
xes-for-6.18-2' of git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux
# good: [fd57572253bc356330dbe5b233c2e1d8426c66fd] Merge tag 'sched_ext-for=
-6.18-rc3-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_=
ext
# good: [7df699c2132f36359f8f79e6a163c3b3fe0b0e3d] media: v4l2-subdev / pdx=
86: int3472: Use "privacy" as con_id for the privacy LED
# good: [5ff90d427ef841fa48608d0c19a81c48d6126d46] kbuild: install-extmod-b=
uild: Fix when given dir outside the build dir
# good: [d50f21091358b2b29dc06c2061106cdb0f030d03] kbuild: align modinfo se=
ction for Secureboot Authenticode EDK2 compat
# good: [975f05a7647720b6a82dac73463eaeca3067de71] smb: server: call smb_di=
rect_post_recv_credits() when the negotiation is done
# good: [566771afc7a81e343da9939f0bd848d3622e2501] Merge tag 'v6.18-rc2-smb=
-server-fixes' of git://git.samba.org/ksmbd
# good: [d914ec6f07548f7c13a231a4f526e043e736e82e] ASoC: rt721: fix prepare=
 clock stop failed
# good: [fe9622011f955e35ba84d3af7b2f2fed31cf8ca1] RDMA/hns: Fix wrong WQE =
data when QP wraps around
# good: [4bb1f7e19c4a1d6eeb52b80acff5ac63edd1b91d] Merge tag 'char-misc-6.1=
8-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc
# good: [dfab67879bed6800cc512e320167b969ebc6d5a9] MAINTAINERS: Update Kcon=
fig section
# good: [43e9ad0c55a369ecc84a4788d06a8a6bfa634f1c] Merge tag 'scsi-fixes' o=
f git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi
# good: [79a6f2da168543c0431ade57428f673c19c5b72f] ASoC: mediatek: Fix doub=
le pm_runtime_disable in remove functions
# good: [266ee584e55eed108583ab4f45b5de734522502d] Merge tag 'arm64-fixes' =
of git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux
# good: [ab431bc39741e9d9bd3102688439e1864c857a74] Merge tag 'net-6.18-rc3'=
 of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
# good: [ba3a5e1aeaa01ea67067d725710a839114214fc6] ASoC: fsl_micfil: correc=
t the endian format for DSD
# good: [64007ad3e2a0e0a0ded8b2c6a72c0bb7883d3a33] ASoC: Intel: avs: Use sn=
d_codec format when initializing probe
# good: [dd72c8fcf6d35de5d6d976f20dc1ae84ce7af08b] Merge tag 'platform-driv=
ers-x86-v6.18-2' of git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/pla=
tform-drivers-x86
# good: [6fab32bb6508abbb8b7b1c5498e44f0c32320ed5] MAINTAINERS: add Mark Br=
own as a linux-next maintainer
# good: [434f7349a1f00618a620b316f091bd13a12bc8d2] regmap: slimbus: fix bus=
_context pointer in regmap init calls
# good: [6f1cbf6d6fd13fc169dde14e865897924cdc4bbd] io_uring: fix buffer aut=
o-commit for multishot uring_cmd
# good: [ada7d45b568abe4f1fd9c53d66e05fbea300674b] btrfs: ref-verify: fix I=
S_ERR() vs NULL check in btrfs_build_ref_tree()
# good: [2e337dd278c6c38982b520c309f36e0f88696e6e] drm/panic: Fix divide by=
 0 if the screen width < font width
# good: [1b824134261d2db08fb6583ccbd05cb71861bd53] spi: dt-bindings: spi-ro=
ckchip: Add RK3506 compatible
# good: [552c50713f273b494ac6c77052032a49bc9255e2] Merge tag 'vfio-v6.18-rc=
3' of https://github.com/awilliam/linux-vfio
# good: [d63f0391d6c7b75e1a847e1a26349fa8cad0004d] net: hibmcge: select FIX=
ED_PHY
# good: [23437509a69476d4f896891032d62ac868731668] drm/panic: Fix 24bit pix=
el crossing page boundaries
# good: [3293d3d7b08872cf174bb768b890655f1b22526a] ASoC: sdw_utils: add nam=
e_prefix for rt1321 part id
# good: [f7e37affbc9085f2b77ccb6596521a44eabf7505] spi: intel-pci: Add supp=
ort for Intel Wildcat Lake SPI serial flash
# good: [1c64efcb083c48c85227cb4d72ab137feef2cdac] Merge tag 'rust-rustfmt'=
 of git://git.kernel.org/pub/scm/linux/kernel/git/ojeda/linux
# good: [8d158f47f1f33d8747e80c3afbea5aa337e59d41] RDMA/irdma: Fix SD index=
 calculation
# good: [d9043c79ba68a089f95bb4344ab0232c3585f9f1] Merge tag 'sched_urgent_=
for_v6.18_rc2' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
# good: [6548d364a3e850326831799d7e3ea2d7bb97ba08] Merge tag 'cgroup-for-6.=
18-rc2-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup
# good: [5575b7646b94c0afb0f4c0d86e00e13cf3397a62] RDMA/irdma: Set irdma_cq=
 cq_num field during CQ create
# good: [d303caf5caf453da2abfd84d249d210aaffe9873] Merge tag 'bpf-fixes' of=
 git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf
# good: [211ddde0823f1442e4ad052a2f30f050145ccada] Linux 6.18-rc2
# good: [fdbb53d318aa94a094434e5f226617f0eb1e8f22] ASoC: qdsp6: q6asm: do n=
ot sleep while atomic
# good: [248adfe32bfd75afbcb8f6d4b68f7e0a9fb2c438] ASoC: cs530x: Correct lo=
g message with expected variable
# good: [5801e65206b065b0b2af032f7f1eef222aa2fd83] drm/sched: Fix potential=
 double free in drm_sched_job_add_resv_dependencies
# good: [830d68f2cb8ab6fb798bb9555016709a9e012af0] drm/msm: Fix pgtable pre=
alloc error path
# good: [f406055cb18c6e299c4a783fc1effeb16be41803] Merge tag 'arm64-fixes' =
of git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux
# good: [98ac9cc4b4452ed7e714eddc8c90ac4ae5da1a09] Merge tag 'f2fs-fix-6.18=
-rc2' of git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs
# good: [b4789aac9d3441d9f830f0a4022d8dc122d6cab3] drm/msm/a6xx: Fix GMU fi=
rmware parser
# good: [0b7d9b25e4bc2e478c9d06281a65f930769fca09] spi: airoha: fix reading=
/writing of flashes with more than one plane per lun
# good: [6f3b6e91f7201e248d83232538db14d30100e9c7] Merge tag 'io_uring-6.18=
-20251016' of git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux
# good: [1fabe43b4e1a97597ec5d5ffcd2b7cf96e654b8f] btrfs: send: fix duplica=
ted rmdir operations when using extrefs
# good: [86404a9e3013d814a772ac407573be5d3cd4ee0d] drm/msm: make sure last_=
fence is always updated
# good: [d5cda96d0130effd4255f7c5e720a58760a032a4] ASoC: codecs: wcd938x-sd=
w: remove redundant runtime pm calls
# good: [7ea30958b3054f5e488fa0b33c352723f7ab3a2a] Merge tag 'vfs-6.18-rc2.=
fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs
# good: [5a6f65d1502551f84c158789e5d89299c78907c7] Merge tag 'bitmap-for-v6=
=2E18-rc2' of https://github.com/norov/linux
# good: [5726b68473f7153a7f6294185e5998b7e2a230a2] ASoC: amd/sdw_utils: avo=
id NULL deref when devm_kasprintf() fails
# good: [9b332cece987ee1790b2ed4c989e28162fa47860] Merge tag 'nfsd-6.18-1' =
of git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux
# good: [6b6e03106163458716c47df2baa9ad08ed4ddb0e] spi: amlogic: fix spifc =
build error
# good: [1f4a222b0e334540343fbb5d3eac4584a6bfe180] Remove long-stale ext3 d=
efconfig option
# good: [67029a49db6c1f21106a1b5fcdd0ea234a6e0711] Merge tag 'trace-v6.18-3=
' of git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace
# good: [8765f467912ff0d4832eeaf26ae573792da877e7] Merge tag 'irq_urgent_fo=
r_v6.18_rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
# good: [3a8660878839faadb4f1a6dd72c3179c1df56787] Linux 6.18-rc1
# good: [6370a996f308ea3276030769b7482b346e7cc7c1] ASoC: codecs: Fix gain s=
etting ranges for Renesas IDT821034 codec
# good: [f43579ef3500527649b1c233be7cf633806353aa] spi: spi-nxp-fspi: limit=
 the clock rate for different sample clock source selection
# good: [ee70bacef1c6050e4836409927294d744dbcfa72] ASoC: nau8821: Avoid unn=
ecessary blocking in IRQ handler
# good: [dee4ef0ebe4dee655657ead30892aeca16462823] ASoC: qcom: sc8280xp: Ad=
d support for QCS615
# good: [8735696acea24ac1f9d4490992418c71941ca68c] spi: cadence-quadspi: Fi=
x pm_runtime unbalance on dma EPROBE_DEFER
# good: [e0b5a7967dec05144bc98125f98c47f74fd1152b] KVM: arm64: nv: Use FGT =
write trap of MDSCR_EL1 when available
# good: [8bd9238e511d02831022ff0270865c54ccc482d6] Merge tag 'ceph-for-6.18=
-rc1' of https://github.com/ceph/ceph-client
# good: [9591fdb0611dccdeeeeacb99d89f0098737d209b] Merge tag 'x86_core_for_=
v6.18_rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
# good: [0739473694c4878513031006829f1030ec850bc2] Merge tag 'for-6.18/hpfs=
-changes' of git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/li=
nux-dm
# good: [98906f9d850e4882004749eccb8920649dc98456] Merge tag 'rtc-6.18' of =
git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux
# good: [cd5a0afbdf8033dc83786315d63f8b325bdba2fd] Merge tag 'mailbox-v6.18=
' of git://git.kernel.org/pub/scm/linux/kernel/git/jassibrar/mailbox
# good: [a8cdf51cda30f7461a98af821e8a28c5cb5f8878] Merge tag 'hardening-fix=
1-v6.18-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux
# good: [5472d60c129f75282d94ae5ad072ee6dfb7c7246] Merge tag 'trace-v6.18-2=
' of git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace
# good: [ec714e371f22f716a04e6ecb2a24988c92b26911] Merge tag 'perf-tools-fo=
r-v6.18-1-2025-10-08' of git://git.kernel.org/pub/scm/linux/kernel/git/perf=
/perf-tools
# good: [18a7e218cfcdca6666e1f7356533e4c988780b57] Merge tag 'net-6.18-rc1'=
 of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
# good: [0d97f2067c166eb495771fede9f7b73999c67f66] Merge tag 'for-linus' of=
 git://git.kernel.org/pub/scm/linux/kernel/git/rmk/linux
# good: [a27539810e1e61efcfdeb51777ed875dc61e9d49] ASoC: rt722: add setting=
s for rt722VB
# good: [c746c3b5169831d7fb032a1051d8b45592ae8d78] Merge tag 'for-6.18-tag'=
 of git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux
# good: [56019d4ff8dd5ef16915c2605988c4022a46019c] Merge tag 'thermal-6.18-=
rc1-2' of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
# good: [18a5f1af596e6ba22cd40ada449063041f3ce6d4] spi: dw-mmio: add error =
handling for reset_control_deassert()
# good: [c34e08ba6c0037a72a7433741225b020c989e4ae] drm/msm: Fix GEM free fo=
r imported dma-bufs
# good: [b41048485ee395edbbb69fc83491d314268f7bdb] Merge tag 'memblock-v6.1=
8-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock
# good: [ba9dac987319d4f3969691dcf366ef19c9ed8281] Merge tag 'libnvdimm-for=
-6.18' of git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
# good: [6a74422b9710e987c7d6b85a1ade7330b1e61626] Merge tag 'mips_6.18' of=
 git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux
# good: [d104e3d17f7bfc505281f57f8c1a5589fca6ffe4] Merge tag 'cxl-for-6.18'=
 of git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl
# good: [ee795e82e10197c070efd380dc9615c73dffad6c] spi: rockchip-sfc: Fix D=
MA-API usage
# good: [fd94619c43360eb44d28bd3ef326a4f85c600a07] Merge tag 'zonefs-6.18-r=
c1' of git://git.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs
# good: [7a405dbb0f036f8d1713ab9e7df0cd3137987b07] Merge tag 'mm-stable-202=
5-10-03-16-49' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
# good: [cbf33b8e0b360f667b17106c15d9e2aac77a76a1] Merge tag 'bpf-fixes' of=
 git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf
# good: [aaab61de1f1e44a2ab527e935474e2e03a0f6b08] ASoC: SOF: Intel: Read t=
he LLP via the associated Link DMA channel
# good: [d3479214c05dbd07bc56f8823e7bd8719fcd39a9] Merge tag 'backlight-nex=
t-6.18' of git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight
# good: [080ffb4bec4d49cdedca11810395f8cad812471e] Merge tag 'i3c/for-6.18'=
 of git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux
# good: [4092fc5f35cecb01d59b2cdf7740b203eac6948a] spi: dt-bindings: cadenc=
e: add soc-specific compatible strings for zynqmp and versal-net
# good: [bace10b59624e6bd8d68bc9304357f292f1b3dcf] ASoC: SOF: ipc4-pcm: fix=
 start offset calculation for chain DMA
# good: [45ad27d9a6f7c620d8bbc80be3bab1faf37dfa0a] ASoC: SOF: Intel: hda-pc=
m: Place the constraint on period time instead of buffer time
# good: [d5f74114114cb2cdbed75b91ca2fa4482c1d5611] Merge tag 'gpio-updates-=
for-v6.18-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux
# good: [50c19e20ed2ef359cf155a39c8462b0a6351b9fa] Merge tag 'nolibc-202509=
28-for-6.18-1' of git://git.kernel.org/pub/scm/linux/kernel/git/nolibc/linu=
x-nolibc
# good: [22bdd6e68bbe270a916233ec5f34a13ae5e80ed9] Merge tag 'x86_apic_for_=
v6.18_rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
# good: [4b81e2eb9e4db8f6094c077d0c8b27c264901c1b] Merge tag 'timers-vdso-2=
025-09-29' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
# good: [755fa5b4fb36627796af19932a432d343220ec63] Merge tag 'cgroup-for-6.=
18' of git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup
# good: [30d4efb2f5a515a60fe6b0ca85362cbebea21e2f] Merge tag 'for-linus-6.1=
8-rc1-tag' of git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip
# good: [1896ce8eb6c61824f6c1125d69d8fda1f44a22f8] Merge tag 'fsverity-for-=
linus' of git://git.kernel.org/pub/scm/fs/fsverity/linux
# good: [449c2b302c8e200558619821ced46cc13cdb9aa6] Merge tag 'vfs-6.18-rc1.=
async' of git://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs
# good: [f65dc3b1ab145c9b8b36301256d703c1dd153f71] ALSA: usb-audio: don't h=
ardcode gain for output channel of Presonus Studio
# good: [733a763dd8b3ac2858dd238a91bb3a2fdff4739e] ASoC: tlv320aic3x: Fix c=
lass-D initialization for tlv320aic3007
# good: [62bea0e1d5c71a3d9c953d4bbbae79428d0ba05c] Merge tag 'drm-habanalab=
s-next-2025-09-25' of https://github.com/HabanaAI/drivers.accel.habanalabs.=
kernel into drm-next
# good: [f8b9c819ea20d1101656a91ced843d9e47ba0630] ASoc: tas2783A: Fix an e=
rror code in probe()
# good: [e26387e950ee4486b4ed5728b5d3c1430c33ba67] ASoC: renesas: msiof: ig=
nore 1st FSERR
# good: [82fd5dc99d63f948c59ac3b08137ef49125938bc] ASoC: dt-binding: Conver=
t MediaTek mt8183-mt6358 to DT schema
# good: [6be988660b474564c77cb6ff60776dafcd850a18] ASoc: tas2783A: Fix spel=
ling mistake "Perifpheral" -> "Peripheral"
# good: [dc64b3d42cb361d4b39eb7cc73037fec52ef9676] ASoC: codecs: wcd-common=
: fix signedness bug in wcd_dt_parse_micbias_info()
# good: [abfbfb98acfe6fd603d48424e32f8d99922e70b9] Merge tag 'amlogic-arm64=
-dt-for-v6.18' of https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/l=
inux into soc/dt
# good: [5fa7d739f811bdffb5fc99696c2e821344fe0b88] regulator: dt-bindings: =
qcom,sdm845-refgen-regulator: document more platforms
# good: [4e65bda8273c938039403144730923e77916a3d7] ASoC: wcd934x: fix error=
 handling in wcd934x_codec_parse_data()
# good: [e609438851928381e39b5393f17156955a84122a] regulator: dt-bindings: =
qcom,sdm845-refgen-regulator: document more platforms
# good: [5890f504ef543190beae2a4e244bbfa7c3e0b57c] ns: add ns_debug()
# good: [46c8b4d2a693eca69a2191436cffa44f489e98c7] ASoC: cs35l41: Fallback =
to reading Subsystem ID property if not ACPI
# good: [878702702dbbd933a5da601c75b8e58eadeec311] spi: ljca: Remove Wenton=
g's e-mail address
# good: [e336ab509b43ea601801dfa05b4270023c3ed007] spi: rename SPI_CS_CNT_M=
AX =3D> SPI_DEVICE_CS_CNT_MAX
# good: [ad4728740bd68d74365a43acc25a65339a9b2173] spi: rpc-if: Add resume =
support for RZ/G3E
# good: [f98cabe3f6cf6396b3ae0264800d9b53d7612433] SPI: Add virtio SPI driv=
er
# good: [63b4c34635cf32af023796b64c855dd1ed0f0a4f] tas2783A: Add acpi match=
 changes for Intel MTL
# good: [87cab86925b7fa4c1c977bc191ac549a3b23f0ea] ASoC: Intel: sof_sdw: Pr=
event jump to NULL add_sidecar callback
# good: [2aa28b748fc967a2f2566c06bdad155fba8af7d8] ASoC: da7213: Convert to=
 DEFINE_RUNTIME_DEV_PM_OPS()
# good: [20253f806818e9a1657a832ebcf4141d0a08c02a] spi: atmel-quadspi: Add =
support for sama7d65 QSPI
# good: [0266f9541038b9b98ddd387132b5bdfe32a304e3] ASoC: codecs: wcd937x: g=
et regmap directly
# good: [2c618f361ae6b9da7fafafc289051728ef4c6ea3] ASoC: fsl: fsl_qmc_audio=
: Drop struct qmc_dai_chan
# good: [0f67557763accbdd56681f17ed5350735198c57b] spi: spi-nxp-fspi: Add O=
CT-DTR mode support
# good: [a24802b0a2a238eaa610b0b0e87a4500a35de64a] spi: spi-qpic-snand: sim=
plify clock handling by using devm_clk_get_enabled()
# good: [62a7b3bbb6b873fdcc85a37efbd0102d66c8a73e] ASoC: SOF: ipc4-pcm: Fix=
 incorrect comparison with number of tdm_slots
# good: [d64035a5a37741b25712fb9c2f6aca535c2967ea] cxl: Change sslbis handl=
er to only handle single dport
# good: [644685abc16b58b3afcc2feb0ac14e86476ca2ed] cxl/test: Adjust the moc=
k version of devm_cxl_switch_port_decoders_setup()
# good: [cb3c715d89607f8896c0f20fe528a08e7ebffea9] ASoC: soc-dapm: add snd_=
soc_dapm_set_idle_bias()
# good: [ab63e9910d2d3ea4b8e6c08812258a676defcb9c] spi: mt65xx: add dual an=
d quad mode for standard spi device
# good: [abe962346ef420998d47ba1c2fe591582f69e92e] regulator: Fix MAX77838 =
selection
# good: [8b84d712ad849172f6bbcad57534b284d942b0b5] regulator: spacemit: sup=
port SpacemiT P1 regulators
# good: [88d0d17192c5a850dc07bb38035b69c4cefde270] ASoC: dt-bindings: add b=
indings for pm4125 audio codec
# good: [8d7de4a014f589c1776959f7fdadbf7b12045aac] ASoC: dt-bindings: asahi=
-kasei,ak4458: Reference common DAI properties
# good: [6a1f303cba45fa3b612d5a2898b1b1b045eb74e3] regulator: max77838: add=
 max77838 regulator driver
# good: [afd77d2050c35aee0d51ab7fb5b36a0fcabd4eee] initramfs: Replace strcp=
y() with strscpy() in find_link()
# good: [8b184c34806e5da4d4847fabd3faeff38b47e70a] ASoC: Intel: hda-sdw-bpt=
: set persistent_buffer false
# good: [4d906371d1f9fc9ce47b2c8f37444680246557bc] nsfs: drop tautological =
ioctl() check
# good: [18dda9eb9e11b2aeec73cbe2a56ab2f862841ba4] spi: amlogic: Fix error =
checking on regmap_write call
# good: [f8527a29f4619f74bc30a9845ea87abb9a6faa1e] nsfs: validate extensibl=
e ioctls
# good: [2742d963e1dd7f4a3d0505044323b091daffcddc] arm64: dts: ti: k3-j784s=
4-ti-ipc-firmware: Refactor IPC cfg into new dtsi
# good: [59ba108806516adeaed51a536d55d4f5e9645881] ASoC: dt-bindings: linux=
,spdif: Add "port" node
# good: [30db1b21fa37a2f37c7f4d71864405a05e889833] spi: axi-spi-engine: use=
 adi_axi_pcore_ver_gteq()
# good: [1217b573978482ae7d21dc5c0bf5aa5007b24f90] ASoC: codecs: pcm1754: a=
dd pcm1754 dac driver
# good: [a22a9e1271fb505f2c85d526d05aad5dde2f50e1] ARM: dts: imx6ul-tx6ul: =
Switch away from deprecated `phy-reset-gpios`
# good: [29e087f31bb104c3ad71396e3a2f94982f2801d2] drm/msm/registers: Make =
TPL1_BICUBIC_WEIGHTS_TABLE an array
# good: [2e0fd4583d0efcdc260e61a22666c8368f505353] rust: regulator: add dev=
m_enable and devm_enable_optional
# good: [46961265bdfb9c237cb03ea6b640b8e7588a982a] arm64: dts: fsl-ls1046a:=
 Add default GIC address cells
# good: [b5bad77e1e3c7249e4c0c88f98477e1ee7669b63] drm/msm/registers: Sync =
GPU registers from mesa
# good: [4dfa64181f23079077c7c1f7e9c342661f66f1d5] Merge branch 'for-6.18/c=
xl-update-access-coordinates' into cxl-for-next
# good: [6a129b2ca5c533aec89fbeb58470811cc4102642] MAINTAINERS: Add an entr=
y for Amlogic spifc driver
# good: [d9e33b38c89f4cf8c32b8481dbcf3a6cdbba4595] spi: cadence-quadspi: Us=
e BIT() macros where possible
# good: [e5b4ad2183f7ab18aaf7c73a120d17241ee58e97] ASoC: cs-amp-lib-test: A=
dd test for getting cal data from HP EFI
# good: [4336efb59ef364e691ef829a73d9dbd4d5ed7c7b] ASoC: Intel: bytcr_rt565=
1: Fix invalid quirk input mapping
# good: [5bad16482c2a7e788c042d98f3e97d3b2bbc8cc5] regulator: dt-bindings: =
rpi-panel: Split 7" Raspberry Pi 720x1280 v2 binding
# good: [7d083666123a425ba9f81dff1a52955b1f226540] ASoC: renesas: rz-ssi: U=
se guard() for spin locks
# good: [2c625f0fe2db4e6a58877ce2318df3aa312eb791] spi: dt-bindings: samsun=
g: Drop S3C2443
# good: [1cf87861a2e02432fb68f8bcc8f20a8e42acde59] ASoC: codecs: tlv320dac3=
3: Convert to use gpiod api
# good: [365075b7d0b95c737284d6970769e964c7e7052d] drm/msm: Add support for=
 IFPC
# good: [b497e1a1a2b10c4ddb28064fba229365ae03311a] regulator: pf530x: Add a=
 driver for the NXP PF5300 Regulator
# good: [9e5eb8b49ffe3c173bf7b8c338a57dfa09fb4634] ASoC: replace use of sys=
tem_unbound_wq with system_dfl_wq
# good: [7748328c2fd82efed24257b2bfd796eb1fa1d09b] ASoC: dt-bindings: qcom,=
lpass-va-macro: Update bindings for clocks to support ADSP
# good: [0ccc1eeda155c947d88ef053e0b54e434e218ee2] ASoC: dt-bindings: wlf,w=
m8960: Document routing strings (pin names)
# good: [dd7ae5b8b3c291c0206f127a564ae1e316705ca0] ASoC: cs42l43: Shutdown =
jack detection on suspend
# good: [5cc49b5a36b32a2dba41441ea13b93fb5ea21cfd] spi: spi-fsl-dspi: Repor=
t FIFO overflows as errors
# good: [ce1a46b2d6a8465a86f7a6f71beb4c6de83bce5c] ASoC: codecs: lpass-wsa-=
macro: add Codev version 2.9
# good: [94b39cb3ad6db935b585988b36378884199cd5fc] spi: mxs: fix "transfere=
d"->"transferred"
# good: [ce57b718006a069226b5e5d3afe7969acd59154e] ASoC: Intel: avs: ssm456=
7: Adjust platform name
# good: [3279052eab235bfb7130b1fabc74029c2260ed8d] ASoC: SOF: ipc4-topology=
: Fix a less than zero check on a u32
# good: [8f57dcf39fd0864f5f3e6701fe885e55f45d0d3a] ASoC: qcom: audioreach: =
convert to cpu endainess type before accessing
# good: [bdd235f2df6d5d6cf00cdf474970b1e6d177f2bd] arm64: dts: qcom: sm8550=
: move dp0 data-lanes to SoC dtsi
# good: [9d35d068fb138160709e04e3ee97fe29a6f8615b] regulator: scmi: Use int=
 type to store negative error codes
# good: [8a9772ec08f87c9e45ab1ad2c8d2b8c1763836eb] ASoC: soc-dapm: rename s=
nd_soc_kcontrol_component() to snd_soc_kcontrol_to_component()
# good: [3d439e1ec3368fae17db379354bd7a9e568ca0ab] ASoC: sof: ipc4-topology=
: Add support to sched_domain attribute
# good: [d57d27171c92e9049d5301785fb38de127b28fbf] ASoC: SOF: sof-client-pr=
obes: Add available points_info(), IPC4 only
# good: [f7c41911ad744177d8289820f01009dc93d8f91c] ASoC: SOF: ipc4-topology=
: Add support for float sample type
# good: [07752abfa5dbf7cb4d9ce69fa94dc3b12bc597d9] ASoC: SOF: sof-client: I=
ntroduce sof_client_dev_entry structure
# good: [f522da9ab56c96db8703b2ea0f09be7cdc3bffeb] ASoC: doc: Internally li=
nk to Writing an ALSA Driver docs
# good: [5c39bc498f5ff7ef016abf3f16698f3e8db79677] ASoC: SOF: Intel: only d=
etect codecs when HDA DSP probe
# good: [a37280daa4d583c7212681c49b285de9464a5200] ASoC: Intel: avs: Allow =
i2s test and non-test boards to coexist
# good: [b088b6189a4066b97cef459afd312fd168a76dea] ASoC: mediatek: common: =
Switch to for_each_available_child_of_node_scoped()
# good: [c42e36a488c7e01f833fc9f4814f735b66b2d494] spi: Drop dev_pm_domain_=
detach() call
# good: [f4672dc6e9c07643c8c755856ba8e9eb9ca95d0c] regmap: use int type to =
store negative error codes
# good: [ff9a7857b7848227788f113d6dc6a72e989084e0] spi: rb4xx: use devm for=
 clk_prepare_enable
# good: [5b4dcaf851df8c414bfc2ac3bf9c65fc942f3be4] ASoC: amd: acp: Remove (=
explicitly) unused header
# good: [e2ab5f600bb01d3625d667d97b3eb7538e388336] rust: regulator: use `to=
_result` for error handling
# good: [11f5c5f9e43e9020bae452232983fe98e7abfce0] ASoC: qcom: use int type=
 to store negative error codes
# good: [899fb38dd76dd3ede425bbaf8a96d390180a5d1c] regulator: core: Remove =
redundant ternary operators
# good: [07188450191da0e3cff6f6d0c42de74d6cdb3602] soc: hisilicon: kunpeng_=
hccs: Fix spelling mistake "decrese" -> "decrease"
# good: [edb5c1f885207d1d74e8a1528e6937e02829ee6e] ASoC: renesas: msiof: st=
art DMAC first
# good: [a12b74d2bd4724ee1883bc97ec93eac8fafc8d3c] ASoC: tlv320aic32x4: use=
 dev_err_probe() for regulators
# good: [f840737d1746398c2993be34bfdc80bdc19ecae2] ASoC: SOF: imx: Remove t=
he use of dev_err_probe()
# good: [ab6d91d141a801dadf9eed7860b2ea09c9268149] dt-bindings: clock: gcc-=
sdm660: Add LPASS/CDSP vote clocks/GDSCs
# good: [f12343013022a92fff0cf22cb7b22b9c909cdbf5] pds_fwctl: Remove the us=
e of dev_err_probe()
# good: [d78e48ebe04e9566f8ecbf51471e80da3adbceeb] ASoC: dt-bindings: Minor=
 whitespace cleanup in example
# good: [c232495d28ca092d0c39b10e35d3d613bd2414ab] ASoC: dt-bindings: omap-=
twl4030: convert to DT schema
# good: [96bcb34df55f7fee99795127c796315950c94fed] ASoC: test-component: Us=
e kcalloc() instead of kzalloc()
# good: [ec0be3cdf40b5302248f3fb27a911cc630e8b855] regulator: consumer.rst:=
 document bulk operations
# good: [c1dd310f1d76b4b13f1854618087af2513140897] spi: SPISG: Use devm_kca=
lloc() in aml_spisg_clk_init()
# good: [da9881d00153cc6d3917f6b74144b1d41b58338c] ASoC: qcom: audioreach: =
add support for SMECNS module
# good: [27848c082ba0b22850fd9fb7b185c015423dcdc7] spi: s3c64xx: Remove the=
 use of dev_err_probe()
# good: [cf65182247761f7993737b710afe8c781699356b] ASoC: codecs: wsa883x: H=
andle shared reset GPIO for WSA883x speakers
# good: [2a55135201d5e24b80b7624880ff42eafd8e320c] ASoC: Intel: avs: Stream=
line register-component function names
# good: [550bc517e59347b3b1af7d290eac4fb1411a3d4e] regulator: bd718x7: Use =
kcalloc() instead of kzalloc()
# good: [daf855f76a1210ceed9541f71ac5dd9be02018a6] ASoC: es8323: enable DAP=
M power widgets for playback DAC
# good: [0056b410355713556d8a10306f82e55b28d33ba8] spi: offload trigger: ad=
i-util-sigma-delta: clean up imports
# good: [90179609efa421b1ccc7d8eafbc078bafb25777c] spi: spl022: use min_t()=
 to improve code
# good: [6d068f1ae2a2f713d7f21a9a602e65b3d6b6fc6d] regulator: rt5133: Fix s=
pelling mistake "regualtor" -> "regulator"
# good: [a46e95c81e3a28926ab1904d9f754fef8318074d] ASoC: wl1273: Remove
# good: [258384d8ce365dddd6c5c15204de8ccd53a7ab0a] ASoC: es8323: enable DAP=
M power widgets for playback DAC and output
# good: [48124569bbc6bfda1df3e9ee17b19d559f4b1aa3] spi: remove unneeded 'fa=
st_io' parameter in regmap_config
# good: [0e62438e476494a1891a8822b9785bc6e73e9c3f] ASoC: Intel: sst: Remove=
 redundant semicolons
# good: [37533933bfe92cd5a99ef4743f31dac62ccc8de0] regulator: remove unneed=
ed 'fast_io' parameter in regmap_config
# good: [5c36b86d2bf68fbcad16169983ef7ee8c537db59] regmap: Remove superfluo=
us check for !config in __regmap_init()
# good: [714165e1c4b0d5b8c6d095fe07f65e6e7047aaeb] regulator: rt5133: Add R=
T5133 PMIC regulator Support
# good: [9c45f95222beecd6a284fd1284d54dd7a772cf59] spi: spi-qpic-snand: han=
dle 'use_ecc' parameter of qcom_spi_config_cw_read()
# good: [b832b19318534bb4f1673b24d78037fee339c679] spi: loopback-test: Don'=
t use %pK through printk
# good: [bab4ab484a6ca170847da9bffe86f1fa90df4bbe] ASoC: dt-bindings: Conve=
rt brcm,bcm2835-i2s to DT schema
# good: [8c02c8353460f8630313aef6810f34e134a3c1ee] ASoC: dt-bindings: realt=
ek,alc5623: convert to DT schema
# good: [ae014fbc99c7f986ee785233e7a5336834e39af4] arm64: dts: renesas: rzg=
2lc-smarc: Disable CAN-FD channel0
# good: [6b7e2aa50bdaf88cd4c2a5e2059a7bf32d85a8b1] spi: spi-qpic-snand: rem=
ove 'clr*status' members of struct 'qpic_ecc'
# good: [a54ef14188519a0994d0264f701f5771815fa11e] regulator: dt-bindings: =
Clean-up active-semi,act8945a duplication
# good: [2291a2186305faaf8525d57849d8ba12ad63f5e7] MAINTAINERS: Add entry f=
or FourSemi audio amplifiers
# good: [a1d0b0ae65ae3f32597edfbb547f16c75601cd87] spi: spi-qpic-snand: avo=
id double assignment in qcom_spi_probe()
# good: [3059067fd3378a5454e7928c08d20bf3ef186760] ASoC: cs48l32: Use PTR_E=
RR_OR_ZERO() to simplify code
# good: [162e23657e5379f07c6404dbfbf4367cb438ea7d] regulator: pf0900: Add P=
MIC PF0900 support
# good: [595b7f155b926460a00776cc581e4dcd01220006] ASoC: Intel: avs: Condit=
ional-path support
# good: [886f42ce96e7ce80545704e7168a9c6b60cd6c03] regmap: mmio: Add missin=
g MODULE_DESCRIPTION()
# good: [cf25eb8eae91bcae9b2065d84b0c0ba0f6d9dd34] ASoC: soc-component: unp=
ack snd_soc_component_init_bias_level()
# good: [9a200cbdb54349909a42b45379e792e4b39dd223] rust: regulator: impleme=
nt Send and Sync for Regulator<T>
# good: [2d86d2585ab929a143d1e6f8963da1499e33bf13] ASoC: pxa: add GPIOLIB_L=
EGACY dependency
git bisect start '89edd36fd801efdb3d2f38bbf7791a293c24bb45' 'e5f0a698b34ed7=
6002dc5cff3804a61c80233a7a' '1788ef30725da53face7e311cdf62ad65fababcd' 'c15=
6c7f27ecdb7b89dbbeaaa1f40d9fadc3c1680' 'c97da4785b3bbc60c24cfd1ffea1d7c8b90=
ed743' 'e256f7b4e57d9f1149efd0e7745f77d8e615177b' '1cc41c88ef00de0f3216c5f4=
b9cfab47de1c49d3' 'b82ebaf298643cad497ef8daf263c0652d486eec' '8612badc331bc=
ab2068baefa69e1458085ed89e3' '5bab4c89390f32b2f491f49a151948cd226dd909' '6a=
23ae0a96a600d1d12557add110e0bb6e32730c' '7a0892d2836e12cc61b6823f888629a3eb=
64e268' 'ccc0011804d406493da6d97f913c43de842f1abb' 'd4f8cccc6230bd2f3aa2834=
8a4c71f0dc3e89788' 'bb1a6ddcfaa54b156e6e2ac61a986c4f5f8cb841' '7254a2b52279=
091683e0228095118ee69ce9742f' 'f824272b6e3fe24950abc527136e8140f67b0b23' 'a=
ecba2e013ab79dde441dfc81a32792ced229539' '2ccec5944606ee1389abc7ee41986825c=
6ceb574' '6fa9041b7177f6771817b95e83f6df17b147c8c6' '360b3730f8eab6c4467c6c=
ca4cb0e30902174a63' '6da43bbeb6918164f7287269881a5f861ae09d7e' 'e927c520e1b=
a6b6a0b2022adf5ba455ee1553fc1' '7564f3543cf19b1232553ab10399c9fbf514b5f3' '=
9b9e43704d2b05514aeeaea36311addba2c72408' 'a3f8f8662771285511ae26c4c8d3ba1c=
d22159b9' 'ebd4469e7af61019daaf904fdcba07a9ecd18440' 'eb2d6774cc0d9d6ab8f92=
4825695a85c14b2e0c2' '66e9feb03e7cf8983b1d0c540e2dad90d5146d48' '4427259cc7=
f7571a157fbc9b5011e1ef6fe0a4a8' '4ea7c1717f3f2344f7a1cdab4f5875cfa89c87a9' =
'24172e0d79900908cf5ebf366600616d29c9b417' 'da32d155f4a8937952ca6fd55d3270f=
ec1c3799f' '439fc29dfd3b9c072dfff292d91cfa2f6cfb702b' 'e811c33b1f137be26a20=
444b79db8cbc1fca1c89' 'e9a6fb0bcdd7609be6969112f3fbfcce3b1d4a7c' '0fce75870=
666b46b700cfbd3216380b422f975da' '8821c8e80a65bc4eb73daf63b34aac6b8ad69461'=
 'f850568efe3a7a9ec4df357cfad1f997f0058924' '0d7bee10beeb59b1133bf5a4749b17=
a4ef3bbb01' '7bb4d6512545a792a6cd8d6c8be5718920b9b11a' '4012abe8a78fbb88696=
34130024266eaef7081fe' '0e5ba55750c1f7fb194a0022b8c887e6413da9b1' '6f86d053=
4fddfbd08687fa0f01479d4226bc3c3d' '4a0c9b3391999818e2c5b93719699b255be1f682=
' '3dc8c73365d3ca25c99e7e1a0f493039d7291df5' 'a1388fcb52fcad3e0b06e2cdd0ed7=
57a82a5be30' '939edfaa10f1d22e6af6a84bf4bd96dc49c67302' '29528c8e643bb0c54d=
a01237a35010c6438423d2' 'c2c2ccfd4ba72718266a56f3ecc34c989cb5b7a0' '84f5526=
e4dce0a44d050ceb1b1bf21d43016d91b' '86d57d9c07d54e8cb385ffe800930816ccdba0c=
1' 'b540de9e3b4fab3b9e10f30714a6f5c1b2a50ec3' 'c9cfc122f03711a5124b4aafab32=
11cf4d35a2ac' '63b5aa01da0f38cdbd97d021477258e511631497' '284922f4c563aa3a8=
558a00f2a05722133237fe8' '636f4618b1cd96f6b5a2b8c7c4f665c8533ecf13' '3cd201=
8e15b3d66d2187d92867e265f45ad79e6f' '1c353dc8d962de652bc7ad2ba2e63f55333139=
1c' '249d96b492efb7a773296ab2c62179918301c146' 'dc77806cf3b4788d328fddf245e=
86c5b529f31a2' '8637fa89e678422995301ddb20b74190dffcccee' '17d85f33a83b84e7=
d36bc3356614ae06c90e7a08' '5624d4c3781673da84e6144c359803ca31b66214' '6146a=
0f1dfae5d37442a9ddcba012add260bceb0' '691d401c7e0e5ea34ac6f8151bc0696db1b25=
00a' 'ec0b62ccc986c06552c57f54116171cfd186ef92' '8da0efc3da9312b65f5cbf06e5=
7d284f69222b2e' '7f17ef0d47b9aa01b89a92b2514fbfe800d8aeca' 'ba36dd5ee6fd464=
3ebbf6ee6eefcecf0b07e35c7' '43c2931a95e6b295bfe9e3b90dbe0f7596933e91' '8bb8=
86cb8f3a2811430ddb7d9838e245c57e7f7c' 'b4cd8f94ae7e5b0d83041b186258eba0c8f7=
c5f7' '74131a0f1b9efc1364871a04b704e54309861668' 'b909d77359b82821e1c6b6a3a=
8a51b355b06fdb5' '47a0925ee4bd2689f0aef4dbd67dd46442fe1ca2' 'd127176862a93c=
4b3216bda533d2bee170af5e71' 'f260c6aff0b8af236084012d14f9f1bf792ea883' '261=
8849f31e7cf51fadd4a5242458501a6d5b315' '45f5c9eec43a9bf448f46562f1468108319=
16cc9' 'e53642b87a4f4b03a8d7e5f8507fc3cd0c595ea6' '5e5c8aa73d99f1daa9f2ec14=
74b7fc1a6952764b' '8eefed8f65cc17c31fdf4ab32292b794b34893ad' '48cbf50531d8e=
ca15b8a811717afdebb8677de9b' 'e7dbfe6f15b4df34bb169d180bd10f1a3c043814' 'd2=
818517e3486d11c9bd55aca3e14059e4c69886' '53abe3e1c154628cc74e33a1bfcd865656=
e433a5' 'dcb6fa37fd7bc9c3d2b066329b0d27dedf8becaa' '72761a7e31225971d0b29d9=
195e0ffa986b77867' '2e590d67c2d803d603ac00b85f2fab235df52a1b' 'fd57572253bc=
356330dbe5b233c2e1d8426c66fd' '7df699c2132f36359f8f79e6a163c3b3fe0b0e3d' '5=
ff90d427ef841fa48608d0c19a81c48d6126d46' 'd50f21091358b2b29dc06c2061106cdb0=
f030d03' '975f05a7647720b6a82dac73463eaeca3067de71' '566771afc7a81e343da993=
9f0bd848d3622e2501' 'd914ec6f07548f7c13a231a4f526e043e736e82e' 'fe9622011f9=
55e35ba84d3af7b2f2fed31cf8ca1' '4bb1f7e19c4a1d6eeb52b80acff5ac63edd1b91d' '=
dfab67879bed6800cc512e320167b969ebc6d5a9' '43e9ad0c55a369ecc84a4788d06a8a6b=
fa634f1c' '79a6f2da168543c0431ade57428f673c19c5b72f' '266ee584e55eed108583a=
b4f45b5de734522502d' 'ab431bc39741e9d9bd3102688439e1864c857a74' 'ba3a5e1aea=
a01ea67067d725710a839114214fc6' '64007ad3e2a0e0a0ded8b2c6a72c0bb7883d3a33' =
'dd72c8fcf6d35de5d6d976f20dc1ae84ce7af08b' '6fab32bb6508abbb8b7b1c5498e44f0=
c32320ed5' '434f7349a1f00618a620b316f091bd13a12bc8d2' '6f1cbf6d6fd13fc169dd=
e14e865897924cdc4bbd' 'ada7d45b568abe4f1fd9c53d66e05fbea300674b' '2e337dd27=
8c6c38982b520c309f36e0f88696e6e' '1b824134261d2db08fb6583ccbd05cb71861bd53'=
 '552c50713f273b494ac6c77052032a49bc9255e2' 'd63f0391d6c7b75e1a847e1a26349f=
a8cad0004d' '23437509a69476d4f896891032d62ac868731668' '3293d3d7b08872cf174=
bb768b890655f1b22526a' 'f7e37affbc9085f2b77ccb6596521a44eabf7505' '1c64efcb=
083c48c85227cb4d72ab137feef2cdac' '8d158f47f1f33d8747e80c3afbea5aa337e59d41=
' 'd9043c79ba68a089f95bb4344ab0232c3585f9f1' '6548d364a3e850326831799d7e3ea=
2d7bb97ba08' '5575b7646b94c0afb0f4c0d86e00e13cf3397a62' 'd303caf5caf453da2a=
bfd84d249d210aaffe9873' '211ddde0823f1442e4ad052a2f30f050145ccada' 'fdbb53d=
318aa94a094434e5f226617f0eb1e8f22' '248adfe32bfd75afbcb8f6d4b68f7e0a9fb2c43=
8' '5801e65206b065b0b2af032f7f1eef222aa2fd83' '830d68f2cb8ab6fb798bb9555016=
709a9e012af0' 'f406055cb18c6e299c4a783fc1effeb16be41803' '98ac9cc4b4452ed7e=
714eddc8c90ac4ae5da1a09' 'b4789aac9d3441d9f830f0a4022d8dc122d6cab3' '0b7d9b=
25e4bc2e478c9d06281a65f930769fca09' '6f3b6e91f7201e248d83232538db14d30100e9=
c7' '1fabe43b4e1a97597ec5d5ffcd2b7cf96e654b8f' '86404a9e3013d814a772ac40757=
3be5d3cd4ee0d' 'd5cda96d0130effd4255f7c5e720a58760a032a4' '7ea30958b3054f5e=
488fa0b33c352723f7ab3a2a' '5a6f65d1502551f84c158789e5d89299c78907c7' '5726b=
68473f7153a7f6294185e5998b7e2a230a2' '9b332cece987ee1790b2ed4c989e28162fa47=
860' '6b6e03106163458716c47df2baa9ad08ed4ddb0e' '1f4a222b0e334540343fbb5d3e=
ac4584a6bfe180' '67029a49db6c1f21106a1b5fcdd0ea234a6e0711' '8765f467912ff0d=
4832eeaf26ae573792da877e7' '3a8660878839faadb4f1a6dd72c3179c1df56787' '6370=
a996f308ea3276030769b7482b346e7cc7c1' 'f43579ef3500527649b1c233be7cf6338063=
53aa' 'ee70bacef1c6050e4836409927294d744dbcfa72' 'dee4ef0ebe4dee655657ead30=
892aeca16462823' '8735696acea24ac1f9d4490992418c71941ca68c' 'e0b5a7967dec05=
144bc98125f98c47f74fd1152b' '8bd9238e511d02831022ff0270865c54ccc482d6' '959=
1fdb0611dccdeeeeacb99d89f0098737d209b' '0739473694c4878513031006829f1030ec8=
50bc2' '98906f9d850e4882004749eccb8920649dc98456' 'cd5a0afbdf8033dc83786315=
d63f8b325bdba2fd' 'a8cdf51cda30f7461a98af821e8a28c5cb5f8878' '5472d60c129f7=
5282d94ae5ad072ee6dfb7c7246' 'ec714e371f22f716a04e6ecb2a24988c92b26911' '18=
a7e218cfcdca6666e1f7356533e4c988780b57' '0d97f2067c166eb495771fede9f7b73999=
c67f66' 'a27539810e1e61efcfdeb51777ed875dc61e9d49' 'c746c3b5169831d7fb032a1=
051d8b45592ae8d78' '56019d4ff8dd5ef16915c2605988c4022a46019c' '18a5f1af596e=
6ba22cd40ada449063041f3ce6d4' 'c34e08ba6c0037a72a7433741225b020c989e4ae' 'b=
41048485ee395edbbb69fc83491d314268f7bdb' 'ba9dac987319d4f3969691dcf366ef19c=
9ed8281' '6a74422b9710e987c7d6b85a1ade7330b1e61626' 'd104e3d17f7bfc505281f5=
7f8c1a5589fca6ffe4' 'ee795e82e10197c070efd380dc9615c73dffad6c' 'fd94619c433=
60eb44d28bd3ef326a4f85c600a07' '7a405dbb0f036f8d1713ab9e7df0cd3137987b07' '=
cbf33b8e0b360f667b17106c15d9e2aac77a76a1' 'aaab61de1f1e44a2ab527e935474e2e0=
3a0f6b08' 'd3479214c05dbd07bc56f8823e7bd8719fcd39a9' '080ffb4bec4d49cdedca1=
1810395f8cad812471e' '4092fc5f35cecb01d59b2cdf7740b203eac6948a' 'bace10b596=
24e6bd8d68bc9304357f292f1b3dcf' '45ad27d9a6f7c620d8bbc80be3bab1faf37dfa0a' =
'd5f74114114cb2cdbed75b91ca2fa4482c1d5611' '50c19e20ed2ef359cf155a39c8462b0=
a6351b9fa' '22bdd6e68bbe270a916233ec5f34a13ae5e80ed9' '4b81e2eb9e4db8f6094c=
077d0c8b27c264901c1b' '755fa5b4fb36627796af19932a432d343220ec63' '30d4efb2f=
5a515a60fe6b0ca85362cbebea21e2f' '1896ce8eb6c61824f6c1125d69d8fda1f44a22f8'=
 '449c2b302c8e200558619821ced46cc13cdb9aa6' 'f65dc3b1ab145c9b8b36301256d703=
c1dd153f71' '733a763dd8b3ac2858dd238a91bb3a2fdff4739e' '62bea0e1d5c71a3d9c9=
53d4bbbae79428d0ba05c' 'f8b9c819ea20d1101656a91ced843d9e47ba0630' 'e26387e9=
50ee4486b4ed5728b5d3c1430c33ba67' '82fd5dc99d63f948c59ac3b08137ef49125938bc=
' '6be988660b474564c77cb6ff60776dafcd850a18' 'dc64b3d42cb361d4b39eb7cc73037=
fec52ef9676' 'abfbfb98acfe6fd603d48424e32f8d99922e70b9' '5fa7d739f811bdffb5=
fc99696c2e821344fe0b88' '4e65bda8273c938039403144730923e77916a3d7' 'e609438=
851928381e39b5393f17156955a84122a' '5890f504ef543190beae2a4e244bbfa7c3e0b57=
c' '46c8b4d2a693eca69a2191436cffa44f489e98c7' '878702702dbbd933a5da601c75b8=
e58eadeec311' 'e336ab509b43ea601801dfa05b4270023c3ed007' 'ad4728740bd68d743=
65a43acc25a65339a9b2173' 'f98cabe3f6cf6396b3ae0264800d9b53d7612433' '63b4c3=
4635cf32af023796b64c855dd1ed0f0a4f' '87cab86925b7fa4c1c977bc191ac549a3b23f0=
ea' '2aa28b748fc967a2f2566c06bdad155fba8af7d8' '20253f806818e9a1657a832ebcf=
4141d0a08c02a' '0266f9541038b9b98ddd387132b5bdfe32a304e3' '2c618f361ae6b9da=
7fafafc289051728ef4c6ea3' '0f67557763accbdd56681f17ed5350735198c57b' 'a2480=
2b0a2a238eaa610b0b0e87a4500a35de64a' '62a7b3bbb6b873fdcc85a37efbd0102d66c8a=
73e' 'd64035a5a37741b25712fb9c2f6aca535c2967ea' '644685abc16b58b3afcc2feb0a=
c14e86476ca2ed' 'cb3c715d89607f8896c0f20fe528a08e7ebffea9' 'ab63e9910d2d3ea=
4b8e6c08812258a676defcb9c' 'abe962346ef420998d47ba1c2fe591582f69e92e' '8b84=
d712ad849172f6bbcad57534b284d942b0b5' '88d0d17192c5a850dc07bb38035b69c4cefd=
e270' '8d7de4a014f589c1776959f7fdadbf7b12045aac' '6a1f303cba45fa3b612d5a289=
8b1b1b045eb74e3' 'afd77d2050c35aee0d51ab7fb5b36a0fcabd4eee' '8b184c34806e5d=
a4d4847fabd3faeff38b47e70a' '4d906371d1f9fc9ce47b2c8f37444680246557bc' '18d=
da9eb9e11b2aeec73cbe2a56ab2f862841ba4' 'f8527a29f4619f74bc30a9845ea87abb9a6=
faa1e' '2742d963e1dd7f4a3d0505044323b091daffcddc' '59ba108806516adeaed51a53=
6d55d4f5e9645881' '30db1b21fa37a2f37c7f4d71864405a05e889833' '1217b57397848=
2ae7d21dc5c0bf5aa5007b24f90' 'a22a9e1271fb505f2c85d526d05aad5dde2f50e1' '29=
e087f31bb104c3ad71396e3a2f94982f2801d2' '2e0fd4583d0efcdc260e61a22666c8368f=
505353' '46961265bdfb9c237cb03ea6b640b8e7588a982a' 'b5bad77e1e3c7249e4c0c88=
f98477e1ee7669b63' '4dfa64181f23079077c7c1f7e9c342661f66f1d5' '6a129b2ca5c5=
33aec89fbeb58470811cc4102642' 'd9e33b38c89f4cf8c32b8481dbcf3a6cdbba4595' 'e=
5b4ad2183f7ab18aaf7c73a120d17241ee58e97' '4336efb59ef364e691ef829a73d9dbd4d=
5ed7c7b' '5bad16482c2a7e788c042d98f3e97d3b2bbc8cc5' '7d083666123a425ba9f81d=
ff1a52955b1f226540' '2c625f0fe2db4e6a58877ce2318df3aa312eb791' '1cf87861a2e=
02432fb68f8bcc8f20a8e42acde59' '365075b7d0b95c737284d6970769e964c7e7052d' '=
b497e1a1a2b10c4ddb28064fba229365ae03311a' '9e5eb8b49ffe3c173bf7b8c338a57dfa=
09fb4634' '7748328c2fd82efed24257b2bfd796eb1fa1d09b' '0ccc1eeda155c947d88ef=
053e0b54e434e218ee2' 'dd7ae5b8b3c291c0206f127a564ae1e316705ca0' '5cc49b5a36=
b32a2dba41441ea13b93fb5ea21cfd' 'ce1a46b2d6a8465a86f7a6f71beb4c6de83bce5c' =
'94b39cb3ad6db935b585988b36378884199cd5fc' 'ce57b718006a069226b5e5d3afe7969=
acd59154e' '3279052eab235bfb7130b1fabc74029c2260ed8d' '8f57dcf39fd0864f5f3e=
6701fe885e55f45d0d3a' 'bdd235f2df6d5d6cf00cdf474970b1e6d177f2bd' '9d35d068f=
b138160709e04e3ee97fe29a6f8615b' '8a9772ec08f87c9e45ab1ad2c8d2b8c1763836eb'=
 '3d439e1ec3368fae17db379354bd7a9e568ca0ab' 'd57d27171c92e9049d5301785fb38d=
e127b28fbf' 'f7c41911ad744177d8289820f01009dc93d8f91c' '07752abfa5dbf7cb4d9=
ce69fa94dc3b12bc597d9' 'f522da9ab56c96db8703b2ea0f09be7cdc3bffeb' '5c39bc49=
8f5ff7ef016abf3f16698f3e8db79677' 'a37280daa4d583c7212681c49b285de9464a5200=
' 'b088b6189a4066b97cef459afd312fd168a76dea' 'c42e36a488c7e01f833fc9f4814f7=
35b66b2d494' 'f4672dc6e9c07643c8c755856ba8e9eb9ca95d0c' 'ff9a7857b784822778=
8f113d6dc6a72e989084e0' '5b4dcaf851df8c414bfc2ac3bf9c65fc942f3be4' 'e2ab5f6=
00bb01d3625d667d97b3eb7538e388336' '11f5c5f9e43e9020bae452232983fe98e7abfce=
0' '899fb38dd76dd3ede425bbaf8a96d390180a5d1c' '07188450191da0e3cff6f6d0c42d=
e74d6cdb3602' 'edb5c1f885207d1d74e8a1528e6937e02829ee6e' 'a12b74d2bd4724ee1=
883bc97ec93eac8fafc8d3c' 'f840737d1746398c2993be34bfdc80bdc19ecae2' 'ab6d91=
d141a801dadf9eed7860b2ea09c9268149' 'f12343013022a92fff0cf22cb7b22b9c909cdb=
f5' 'd78e48ebe04e9566f8ecbf51471e80da3adbceeb' 'c232495d28ca092d0c39b10e35d=
3d613bd2414ab' '96bcb34df55f7fee99795127c796315950c94fed' 'ec0be3cdf40b5302=
248f3fb27a911cc630e8b855' 'c1dd310f1d76b4b13f1854618087af2513140897' 'da988=
1d00153cc6d3917f6b74144b1d41b58338c' '27848c082ba0b22850fd9fb7b185c015423dc=
dc7' 'cf65182247761f7993737b710afe8c781699356b' '2a55135201d5e24b80b7624880=
ff42eafd8e320c' '550bc517e59347b3b1af7d290eac4fb1411a3d4e' 'daf855f76a1210c=
eed9541f71ac5dd9be02018a6' '0056b410355713556d8a10306f82e55b28d33ba8' '9017=
9609efa421b1ccc7d8eafbc078bafb25777c' '6d068f1ae2a2f713d7f21a9a602e65b3d6b6=
fc6d' 'a46e95c81e3a28926ab1904d9f754fef8318074d' '258384d8ce365dddd6c5c1520=
4de8ccd53a7ab0a' '48124569bbc6bfda1df3e9ee17b19d559f4b1aa3' '0e62438e476494=
a1891a8822b9785bc6e73e9c3f' '37533933bfe92cd5a99ef4743f31dac62ccc8de0' '5c3=
6b86d2bf68fbcad16169983ef7ee8c537db59' '714165e1c4b0d5b8c6d095fe07f65e6e704=
7aaeb' '9c45f95222beecd6a284fd1284d54dd7a772cf59' 'b832b19318534bb4f1673b24=
d78037fee339c679' 'bab4ab484a6ca170847da9bffe86f1fa90df4bbe' '8c02c8353460f=
8630313aef6810f34e134a3c1ee' 'ae014fbc99c7f986ee785233e7a5336834e39af4' '6b=
7e2aa50bdaf88cd4c2a5e2059a7bf32d85a8b1' 'a54ef14188519a0994d0264f701f577181=
5fa11e' '2291a2186305faaf8525d57849d8ba12ad63f5e7' 'a1d0b0ae65ae3f32597edfb=
b547f16c75601cd87' '3059067fd3378a5454e7928c08d20bf3ef186760' '162e23657e53=
79f07c6404dbfbf4367cb438ea7d' '595b7f155b926460a00776cc581e4dcd01220006' '8=
86f42ce96e7ce80545704e7168a9c6b60cd6c03' 'cf25eb8eae91bcae9b2065d84b0c0ba0f=
6d9dd34' '9a200cbdb54349909a42b45379e792e4b39dd223' '2d86d2585ab929a143d1e6=
f8963da1499e33bf13'
# test job: [1788ef30725da53face7e311cdf62ad65fababcd] https://lava.sirena.=
org.uk/scheduler/job/2125157
# test job: [c156c7f27ecdb7b89dbbeaaa1f40d9fadc3c1680] https://lava.sirena.=
org.uk/scheduler/job/2125015
# test job: [c97da4785b3bbc60c24cfd1ffea1d7c8b90ed743] https://lava.sirena.=
org.uk/scheduler/job/2125498
# test job: [e256f7b4e57d9f1149efd0e7745f77d8e615177b] https://lava.sirena.=
org.uk/scheduler/job/2090343
# test job: [1cc41c88ef00de0f3216c5f4b9cfab47de1c49d3] https://lava.sirena.=
org.uk/scheduler/job/2088283
# test job: [b82ebaf298643cad497ef8daf263c0652d486eec] https://lava.sirena.=
org.uk/scheduler/job/2105426
# test job: [8612badc331bcab2068baefa69e1458085ed89e3] https://lava.sirena.=
org.uk/scheduler/job/2125331
# test job: [5bab4c89390f32b2f491f49a151948cd226dd909] https://lava.sirena.=
org.uk/scheduler/job/2125442
# test job: [6a23ae0a96a600d1d12557add110e0bb6e32730c] https://lava.sirena.=
org.uk/scheduler/job/2092523
# test job: [7a0892d2836e12cc61b6823f888629a3eb64e268] https://lava.sirena.=
org.uk/scheduler/job/2088831
# test job: [ccc0011804d406493da6d97f913c43de842f1abb] https://lava.sirena.=
org.uk/scheduler/job/2088444
# test job: [d4f8cccc6230bd2f3aa28348a4c71f0dc3e89788] https://lava.sirena.=
org.uk/scheduler/job/2087845
# test job: [bb1a6ddcfaa54b156e6e2ac61a986c4f5f8cb841] https://lava.sirena.=
org.uk/scheduler/job/2090311
# test job: [7254a2b52279091683e0228095118ee69ce9742f] https://lava.sirena.=
org.uk/scheduler/job/2091656
# test job: [f824272b6e3fe24950abc527136e8140f67b0b23] https://lava.sirena.=
org.uk/scheduler/job/2090218
# test job: [aecba2e013ab79dde441dfc81a32792ced229539] https://lava.sirena.=
org.uk/scheduler/job/2085197
# test job: [2ccec5944606ee1389abc7ee41986825c6ceb574] https://lava.sirena.=
org.uk/scheduler/job/2081903
# test job: [6fa9041b7177f6771817b95e83f6df17b147c8c6] https://lava.sirena.=
org.uk/scheduler/job/2080505
# test job: [360b3730f8eab6c4467c6cca4cb0e30902174a63] https://lava.sirena.=
org.uk/scheduler/job/2079475
# test job: [6da43bbeb6918164f7287269881a5f861ae09d7e] https://lava.sirena.=
org.uk/scheduler/job/2084861
# test job: [e927c520e1ba6b6a0b2022adf5ba455ee1553fc1] https://lava.sirena.=
org.uk/scheduler/job/2079734
# test job: [7564f3543cf19b1232553ab10399c9fbf514b5f3] https://lava.sirena.=
org.uk/scheduler/job/2085235
# test job: [9b9e43704d2b05514aeeaea36311addba2c72408] https://lava.sirena.=
org.uk/scheduler/job/2083453
# test job: [a3f8f8662771285511ae26c4c8d3ba1cd22159b9] https://lava.sirena.=
org.uk/scheduler/job/2100628
# test job: [ebd4469e7af61019daaf904fdcba07a9ecd18440] https://lava.sirena.=
org.uk/scheduler/job/2090437
# test job: [eb2d6774cc0d9d6ab8f924825695a85c14b2e0c2] https://lava.sirena.=
org.uk/scheduler/job/2069878
# test job: [66e9feb03e7cf8983b1d0c540e2dad90d5146d48] https://lava.sirena.=
org.uk/scheduler/job/2069530
# test job: [4427259cc7f7571a157fbc9b5011e1ef6fe0a4a8] https://lava.sirena.=
org.uk/scheduler/job/2072202
# test job: [4ea7c1717f3f2344f7a1cdab4f5875cfa89c87a9] https://lava.sirena.=
org.uk/scheduler/job/2070515
# test job: [24172e0d79900908cf5ebf366600616d29c9b417] https://lava.sirena.=
org.uk/scheduler/job/2075863
# test job: [da32d155f4a8937952ca6fd55d3270fec1c3799f] https://lava.sirena.=
org.uk/scheduler/job/2059711
# test job: [439fc29dfd3b9c072dfff292d91cfa2f6cfb702b] https://lava.sirena.=
org.uk/scheduler/job/2063760
# test job: [e811c33b1f137be26a20444b79db8cbc1fca1c89] https://lava.sirena.=
org.uk/scheduler/job/2060638
# test job: [e9a6fb0bcdd7609be6969112f3fbfcce3b1d4a7c] https://lava.sirena.=
org.uk/scheduler/job/2065786
# test job: [0fce75870666b46b700cfbd3216380b422f975da] https://lava.sirena.=
org.uk/scheduler/job/2085969
# test job: [8821c8e80a65bc4eb73daf63b34aac6b8ad69461] https://lava.sirena.=
org.uk/scheduler/job/2085427
# test job: [f850568efe3a7a9ec4df357cfad1f997f0058924] https://lava.sirena.=
org.uk/scheduler/job/2065351
# test job: [0d7bee10beeb59b1133bf5a4749b17a4ef3bbb01] https://lava.sirena.=
org.uk/scheduler/job/2062325
# test job: [7bb4d6512545a792a6cd8d6c8be5718920b9b11a] https://lava.sirena.=
org.uk/scheduler/job/2062970
# test job: [4012abe8a78fbb8869634130024266eaef7081fe] https://lava.sirena.=
org.uk/scheduler/job/2063895
# test job: [0e5ba55750c1f7fb194a0022b8c887e6413da9b1] https://lava.sirena.=
org.uk/scheduler/job/2070692
# test job: [6f86d0534fddfbd08687fa0f01479d4226bc3c3d] https://lava.sirena.=
org.uk/scheduler/job/2076088
# test job: [4a0c9b3391999818e2c5b93719699b255be1f682] https://lava.sirena.=
org.uk/scheduler/job/2056603
# test job: [3dc8c73365d3ca25c99e7e1a0f493039d7291df5] https://lava.sirena.=
org.uk/scheduler/job/2054783
# test job: [a1388fcb52fcad3e0b06e2cdd0ed757a82a5be30] https://lava.sirena.=
org.uk/scheduler/job/2055942
# test job: [939edfaa10f1d22e6af6a84bf4bd96dc49c67302] https://lava.sirena.=
org.uk/scheduler/job/2058065
# test job: [29528c8e643bb0c54da01237a35010c6438423d2] https://lava.sirena.=
org.uk/scheduler/job/2058004
# test job: [c2c2ccfd4ba72718266a56f3ecc34c989cb5b7a0] https://lava.sirena.=
org.uk/scheduler/job/2054520
# test job: [84f5526e4dce0a44d050ceb1b1bf21d43016d91b] https://lava.sirena.=
org.uk/scheduler/job/2053701
# test job: [86d57d9c07d54e8cb385ffe800930816ccdba0c1] https://lava.sirena.=
org.uk/scheduler/job/2053456
# test job: [b540de9e3b4fab3b9e10f30714a6f5c1b2a50ec3] https://lava.sirena.=
org.uk/scheduler/job/2063128
# test job: [c9cfc122f03711a5124b4aafab3211cf4d35a2ac] https://lava.sirena.=
org.uk/scheduler/job/2042213
# test job: [63b5aa01da0f38cdbd97d021477258e511631497] https://lava.sirena.=
org.uk/scheduler/job/2100423
# test job: [284922f4c563aa3a8558a00f2a05722133237fe8] https://lava.sirena.=
org.uk/scheduler/job/2046475
# test job: [636f4618b1cd96f6b5a2b8c7c4f665c8533ecf13] https://lava.sirena.=
org.uk/scheduler/job/2048692
# test job: [3cd2018e15b3d66d2187d92867e265f45ad79e6f] https://lava.sirena.=
org.uk/scheduler/job/2049152
# test job: [1c353dc8d962de652bc7ad2ba2e63f553331391c] https://lava.sirena.=
org.uk/scheduler/job/2048325
# test job: [249d96b492efb7a773296ab2c62179918301c146] https://lava.sirena.=
org.uk/scheduler/job/2043872
# test job: [dc77806cf3b4788d328fddf245e86c5b529f31a2] https://lava.sirena.=
org.uk/scheduler/job/2050965
# test job: [8637fa89e678422995301ddb20b74190dffcccee] https://lava.sirena.=
org.uk/scheduler/job/2100546
# test job: [17d85f33a83b84e7d36bc3356614ae06c90e7a08] https://lava.sirena.=
org.uk/scheduler/job/2045220
# test job: [5624d4c3781673da84e6144c359803ca31b66214] https://lava.sirena.=
org.uk/scheduler/job/2051288
# test job: [6146a0f1dfae5d37442a9ddcba012add260bceb0] https://lava.sirena.=
org.uk/scheduler/job/2035512
# test job: [691d401c7e0e5ea34ac6f8151bc0696db1b2500a] https://lava.sirena.=
org.uk/scheduler/job/2033134
# test job: [ec0b62ccc986c06552c57f54116171cfd186ef92] https://lava.sirena.=
org.uk/scheduler/job/2031008
# test job: [8da0efc3da9312b65f5cbf06e57d284f69222b2e] https://lava.sirena.=
org.uk/scheduler/job/2038266
# test job: [7f17ef0d47b9aa01b89a92b2514fbfe800d8aeca] https://lava.sirena.=
org.uk/scheduler/job/2056719
# test job: [ba36dd5ee6fd4643ebbf6ee6eefcecf0b07e35c7] https://lava.sirena.=
org.uk/scheduler/job/2031514
# test job: [43c2931a95e6b295bfe9e3b90dbe0f7596933e91] https://lava.sirena.=
org.uk/scheduler/job/2033335
# test job: [8bb886cb8f3a2811430ddb7d9838e245c57e7f7c] https://lava.sirena.=
org.uk/scheduler/job/2040974
# test job: [b4cd8f94ae7e5b0d83041b186258eba0c8f7c5f7] https://lava.sirena.=
org.uk/scheduler/job/2047652
# test job: [74131a0f1b9efc1364871a04b704e54309861668] https://lava.sirena.=
org.uk/scheduler/job/2033290
# test job: [b909d77359b82821e1c6b6a3a8a51b355b06fdb5] https://lava.sirena.=
org.uk/scheduler/job/2030064
# test job: [47a0925ee4bd2689f0aef4dbd67dd46442fe1ca2] https://lava.sirena.=
org.uk/scheduler/job/2025638
# test job: [d127176862a93c4b3216bda533d2bee170af5e71] https://lava.sirena.=
org.uk/scheduler/job/2028149
# test job: [f260c6aff0b8af236084012d14f9f1bf792ea883] https://lava.sirena.=
org.uk/scheduler/job/2042481
# test job: [2618849f31e7cf51fadd4a5242458501a6d5b315] https://lava.sirena.=
org.uk/scheduler/job/2043045
# test job: [45f5c9eec43a9bf448f46562f146810831916cc9] https://lava.sirena.=
org.uk/scheduler/job/2015512
# test job: [e53642b87a4f4b03a8d7e5f8507fc3cd0c595ea6] https://lava.sirena.=
org.uk/scheduler/job/2018626
# test job: [5e5c8aa73d99f1daa9f2ec1474b7fc1a6952764b] https://lava.sirena.=
org.uk/scheduler/job/2021336
# test job: [8eefed8f65cc17c31fdf4ab32292b794b34893ad] https://lava.sirena.=
org.uk/scheduler/job/2017745
# test job: [48cbf50531d8eca15b8a811717afdebb8677de9b] https://lava.sirena.=
org.uk/scheduler/job/2016865
# test job: [e7dbfe6f15b4df34bb169d180bd10f1a3c043814] https://lava.sirena.=
org.uk/scheduler/job/2020362
# test job: [d2818517e3486d11c9bd55aca3e14059e4c69886] https://lava.sirena.=
org.uk/scheduler/job/2001234
# test job: [53abe3e1c154628cc74e33a1bfcd865656e433a5] https://lava.sirena.=
org.uk/scheduler/job/2001685
# test job: [dcb6fa37fd7bc9c3d2b066329b0d27dedf8becaa] https://lava.sirena.=
org.uk/scheduler/job/2006075
# test job: [72761a7e31225971d0b29d9195e0ffa986b77867] https://lava.sirena.=
org.uk/scheduler/job/2003256
# test job: [2e590d67c2d803d603ac00b85f2fab235df52a1b] https://lava.sirena.=
org.uk/scheduler/job/2000834
# test job: [fd57572253bc356330dbe5b233c2e1d8426c66fd] https://lava.sirena.=
org.uk/scheduler/job/2011662
# test job: [7df699c2132f36359f8f79e6a163c3b3fe0b0e3d] https://lava.sirena.=
org.uk/scheduler/job/2048812
# test job: [5ff90d427ef841fa48608d0c19a81c48d6126d46] https://lava.sirena.=
org.uk/scheduler/job/2033426
# test job: [d50f21091358b2b29dc06c2061106cdb0f030d03] https://lava.sirena.=
org.uk/scheduler/job/2033349
# test job: [975f05a7647720b6a82dac73463eaeca3067de71] https://lava.sirena.=
org.uk/scheduler/job/2018931
# test job: [566771afc7a81e343da9939f0bd848d3622e2501] https://lava.sirena.=
org.uk/scheduler/job/2002165
# test job: [d914ec6f07548f7c13a231a4f526e043e736e82e] https://lava.sirena.=
org.uk/scheduler/job/2008313
# test job: [fe9622011f955e35ba84d3af7b2f2fed31cf8ca1] https://lava.sirena.=
org.uk/scheduler/job/2045482
# test job: [4bb1f7e19c4a1d6eeb52b80acff5ac63edd1b91d] https://lava.sirena.=
org.uk/scheduler/job/2005162
# test job: [dfab67879bed6800cc512e320167b969ebc6d5a9] https://lava.sirena.=
org.uk/scheduler/job/2033450
# test job: [43e9ad0c55a369ecc84a4788d06a8a6bfa634f1c] https://lava.sirena.=
org.uk/scheduler/job/1993713
# test job: [79a6f2da168543c0431ade57428f673c19c5b72f] https://lava.sirena.=
org.uk/scheduler/job/1998361
# test job: [266ee584e55eed108583ab4f45b5de734522502d] https://lava.sirena.=
org.uk/scheduler/job/1997813
# test job: [ab431bc39741e9d9bd3102688439e1864c857a74] https://lava.sirena.=
org.uk/scheduler/job/1997333
# test job: [ba3a5e1aeaa01ea67067d725710a839114214fc6] https://lava.sirena.=
org.uk/scheduler/job/1995930
# test job: [64007ad3e2a0e0a0ded8b2c6a72c0bb7883d3a33] https://lava.sirena.=
org.uk/scheduler/job/1995845
# test job: [dd72c8fcf6d35de5d6d976f20dc1ae84ce7af08b] https://lava.sirena.=
org.uk/scheduler/job/1992254
# test job: [6fab32bb6508abbb8b7b1c5498e44f0c32320ed5] https://lava.sirena.=
org.uk/scheduler/job/1998716
# test job: [434f7349a1f00618a620b316f091bd13a12bc8d2] https://lava.sirena.=
org.uk/scheduler/job/1996299
# test job: [6f1cbf6d6fd13fc169dde14e865897924cdc4bbd] https://lava.sirena.=
org.uk/scheduler/job/2001363
# test job: [ada7d45b568abe4f1fd9c53d66e05fbea300674b] https://lava.sirena.=
org.uk/scheduler/job/2042687
# test job: [2e337dd278c6c38982b520c309f36e0f88696e6e] https://lava.sirena.=
org.uk/scheduler/job/1991031
# test job: [1b824134261d2db08fb6583ccbd05cb71861bd53] https://lava.sirena.=
org.uk/scheduler/job/1991917
# test job: [552c50713f273b494ac6c77052032a49bc9255e2] https://lava.sirena.=
org.uk/scheduler/job/1988604
# test job: [d63f0391d6c7b75e1a847e1a26349fa8cad0004d] https://lava.sirena.=
org.uk/scheduler/job/1998546
# test job: [23437509a69476d4f896891032d62ac868731668] https://lava.sirena.=
org.uk/scheduler/job/1992779
# test job: [3293d3d7b08872cf174bb768b890655f1b22526a] https://lava.sirena.=
org.uk/scheduler/job/1992754
# test job: [f7e37affbc9085f2b77ccb6596521a44eabf7505] https://lava.sirena.=
org.uk/scheduler/job/1979036
# test job: [1c64efcb083c48c85227cb4d72ab137feef2cdac] https://lava.sirena.=
org.uk/scheduler/job/1970751
# test job: [8d158f47f1f33d8747e80c3afbea5aa337e59d41] https://lava.sirena.=
org.uk/scheduler/job/2045644
# test job: [d9043c79ba68a089f95bb4344ab0232c3585f9f1] https://lava.sirena.=
org.uk/scheduler/job/1972042
# test job: [6548d364a3e850326831799d7e3ea2d7bb97ba08] https://lava.sirena.=
org.uk/scheduler/job/1981450
# test job: [5575b7646b94c0afb0f4c0d86e00e13cf3397a62] https://lava.sirena.=
org.uk/scheduler/job/2045599
# test job: [d303caf5caf453da2abfd84d249d210aaffe9873] https://lava.sirena.=
org.uk/scheduler/job/1970080
# test job: [211ddde0823f1442e4ad052a2f30f050145ccada] https://lava.sirena.=
org.uk/scheduler/job/1976582
# test job: [fdbb53d318aa94a094434e5f226617f0eb1e8f22] https://lava.sirena.=
org.uk/scheduler/job/1974265
# test job: [248adfe32bfd75afbcb8f6d4b68f7e0a9fb2c438] https://lava.sirena.=
org.uk/scheduler/job/1973366
# test job: [5801e65206b065b0b2af032f7f1eef222aa2fd83] https://lava.sirena.=
org.uk/scheduler/job/2001855
# test job: [830d68f2cb8ab6fb798bb9555016709a9e012af0] https://lava.sirena.=
org.uk/scheduler/job/1993578
# test job: [f406055cb18c6e299c4a783fc1effeb16be41803] https://lava.sirena.=
org.uk/scheduler/job/1967112
# test job: [98ac9cc4b4452ed7e714eddc8c90ac4ae5da1a09] https://lava.sirena.=
org.uk/scheduler/job/1963422
# test job: [b4789aac9d3441d9f830f0a4022d8dc122d6cab3] https://lava.sirena.=
org.uk/scheduler/job/2018428
# test job: [0b7d9b25e4bc2e478c9d06281a65f930769fca09] https://lava.sirena.=
org.uk/scheduler/job/1962174
# test job: [6f3b6e91f7201e248d83232538db14d30100e9c7] https://lava.sirena.=
org.uk/scheduler/job/1965566
# test job: [1fabe43b4e1a97597ec5d5ffcd2b7cf96e654b8f] https://lava.sirena.=
org.uk/scheduler/job/1984394
# test job: [86404a9e3013d814a772ac407573be5d3cd4ee0d] https://lava.sirena.=
org.uk/scheduler/job/1991433
# test job: [d5cda96d0130effd4255f7c5e720a58760a032a4] https://lava.sirena.=
org.uk/scheduler/job/1959441
# test job: [7ea30958b3054f5e488fa0b33c352723f7ab3a2a] https://lava.sirena.=
org.uk/scheduler/job/1960951
# test job: [5a6f65d1502551f84c158789e5d89299c78907c7] https://lava.sirena.=
org.uk/scheduler/job/1959660
# test job: [5726b68473f7153a7f6294185e5998b7e2a230a2] https://lava.sirena.=
org.uk/scheduler/job/1959635
# test job: [9b332cece987ee1790b2ed4c989e28162fa47860] https://lava.sirena.=
org.uk/scheduler/job/1956048
# test job: [6b6e03106163458716c47df2baa9ad08ed4ddb0e] https://lava.sirena.=
org.uk/scheduler/job/1959349
# test job: [1f4a222b0e334540343fbb5d3eac4584a6bfe180] https://lava.sirena.=
org.uk/scheduler/job/1959268
# test job: [67029a49db6c1f21106a1b5fcdd0ea234a6e0711] https://lava.sirena.=
org.uk/scheduler/job/1941803
# test job: [8765f467912ff0d4832eeaf26ae573792da877e7] https://lava.sirena.=
org.uk/scheduler/job/1942940
# test job: [3a8660878839faadb4f1a6dd72c3179c1df56787] https://lava.sirena.=
org.uk/scheduler/job/1944012
# test job: [6370a996f308ea3276030769b7482b346e7cc7c1] https://lava.sirena.=
org.uk/scheduler/job/1946094
# test job: [f43579ef3500527649b1c233be7cf633806353aa] https://lava.sirena.=
org.uk/scheduler/job/1948301
# test job: [ee70bacef1c6050e4836409927294d744dbcfa72] https://lava.sirena.=
org.uk/scheduler/job/1948151
# test job: [dee4ef0ebe4dee655657ead30892aeca16462823] https://lava.sirena.=
org.uk/scheduler/job/1946101
# test job: [8735696acea24ac1f9d4490992418c71941ca68c] https://lava.sirena.=
org.uk/scheduler/job/1948372
# test job: [e0b5a7967dec05144bc98125f98c47f74fd1152b] https://lava.sirena.=
org.uk/scheduler/job/1979914
# test job: [8bd9238e511d02831022ff0270865c54ccc482d6] https://lava.sirena.=
org.uk/scheduler/job/1939543
# test job: [9591fdb0611dccdeeeeacb99d89f0098737d209b] https://lava.sirena.=
org.uk/scheduler/job/1941216
# test job: [0739473694c4878513031006829f1030ec850bc2] https://lava.sirena.=
org.uk/scheduler/job/1939904
# test job: [98906f9d850e4882004749eccb8920649dc98456] https://lava.sirena.=
org.uk/scheduler/job/1941512
# test job: [cd5a0afbdf8033dc83786315d63f8b325bdba2fd] https://lava.sirena.=
org.uk/scheduler/job/1934674
# test job: [a8cdf51cda30f7461a98af821e8a28c5cb5f8878] https://lava.sirena.=
org.uk/scheduler/job/1932387
# test job: [5472d60c129f75282d94ae5ad072ee6dfb7c7246] https://lava.sirena.=
org.uk/scheduler/job/1937109
# test job: [ec714e371f22f716a04e6ecb2a24988c92b26911] https://lava.sirena.=
org.uk/scheduler/job/1935620
# test job: [18a7e218cfcdca6666e1f7356533e4c988780b57] https://lava.sirena.=
org.uk/scheduler/job/1936903
# test job: [0d97f2067c166eb495771fede9f7b73999c67f66] https://lava.sirena.=
org.uk/scheduler/job/1932861
# test job: [a27539810e1e61efcfdeb51777ed875dc61e9d49] https://lava.sirena.=
org.uk/scheduler/job/1930636
# test job: [c746c3b5169831d7fb032a1051d8b45592ae8d78] https://lava.sirena.=
org.uk/scheduler/job/1929204
# test job: [56019d4ff8dd5ef16915c2605988c4022a46019c] https://lava.sirena.=
org.uk/scheduler/job/1931777
# test job: [18a5f1af596e6ba22cd40ada449063041f3ce6d4] https://lava.sirena.=
org.uk/scheduler/job/1930444
# test job: [c34e08ba6c0037a72a7433741225b020c989e4ae] https://lava.sirena.=
org.uk/scheduler/job/1993674
# test job: [b41048485ee395edbbb69fc83491d314268f7bdb] https://lava.sirena.=
org.uk/scheduler/job/1922988
# test job: [ba9dac987319d4f3969691dcf366ef19c9ed8281] https://lava.sirena.=
org.uk/scheduler/job/1928672
# test job: [6a74422b9710e987c7d6b85a1ade7330b1e61626] https://lava.sirena.=
org.uk/scheduler/job/1925164
# test job: [d104e3d17f7bfc505281f57f8c1a5589fca6ffe4] https://lava.sirena.=
org.uk/scheduler/job/1923425
# test job: [ee795e82e10197c070efd380dc9615c73dffad6c] https://lava.sirena.=
org.uk/scheduler/job/1927702
# test job: [fd94619c43360eb44d28bd3ef326a4f85c600a07] https://lava.sirena.=
org.uk/scheduler/job/1926338
# test job: [7a405dbb0f036f8d1713ab9e7df0cd3137987b07] https://lava.sirena.=
org.uk/scheduler/job/1925608
# test job: [cbf33b8e0b360f667b17106c15d9e2aac77a76a1] https://lava.sirena.=
org.uk/scheduler/job/1921720
# test job: [aaab61de1f1e44a2ab527e935474e2e03a0f6b08] https://lava.sirena.=
org.uk/scheduler/job/1916372
# test job: [d3479214c05dbd07bc56f8823e7bd8719fcd39a9] https://lava.sirena.=
org.uk/scheduler/job/1910137
# test job: [080ffb4bec4d49cdedca11810395f8cad812471e] https://lava.sirena.=
org.uk/scheduler/job/1910602
# test job: [4092fc5f35cecb01d59b2cdf7740b203eac6948a] https://lava.sirena.=
org.uk/scheduler/job/1911646
# test job: [bace10b59624e6bd8d68bc9304357f292f1b3dcf] https://lava.sirena.=
org.uk/scheduler/job/1911714
# test job: [45ad27d9a6f7c620d8bbc80be3bab1faf37dfa0a] https://lava.sirena.=
org.uk/scheduler/job/1912614
# test job: [d5f74114114cb2cdbed75b91ca2fa4482c1d5611] https://lava.sirena.=
org.uk/scheduler/job/1909587
# test job: [50c19e20ed2ef359cf155a39c8462b0a6351b9fa] https://lava.sirena.=
org.uk/scheduler/job/1908314
# test job: [22bdd6e68bbe270a916233ec5f34a13ae5e80ed9] https://lava.sirena.=
org.uk/scheduler/job/1906827
# test job: [4b81e2eb9e4db8f6094c077d0c8b27c264901c1b] https://lava.sirena.=
org.uk/scheduler/job/1907422
# test job: [755fa5b4fb36627796af19932a432d343220ec63] https://lava.sirena.=
org.uk/scheduler/job/1906277
# test job: [30d4efb2f5a515a60fe6b0ca85362cbebea21e2f] https://lava.sirena.=
org.uk/scheduler/job/1902811
# test job: [1896ce8eb6c61824f6c1125d69d8fda1f44a22f8] https://lava.sirena.=
org.uk/scheduler/job/1901838
# test job: [449c2b302c8e200558619821ced46cc13cdb9aa6] https://lava.sirena.=
org.uk/scheduler/job/1900822
# test job: [f65dc3b1ab145c9b8b36301256d703c1dd153f71] https://lava.sirena.=
org.uk/scheduler/job/1899252
# test job: [733a763dd8b3ac2858dd238a91bb3a2fdff4739e] https://lava.sirena.=
org.uk/scheduler/job/1889790
# test job: [62bea0e1d5c71a3d9c953d4bbbae79428d0ba05c] https://lava.sirena.=
org.uk/scheduler/job/2028693
# test job: [f8b9c819ea20d1101656a91ced843d9e47ba0630] https://lava.sirena.=
org.uk/scheduler/job/1890790
# test job: [e26387e950ee4486b4ed5728b5d3c1430c33ba67] https://lava.sirena.=
org.uk/scheduler/job/1888698
# test job: [82fd5dc99d63f948c59ac3b08137ef49125938bc] https://lava.sirena.=
org.uk/scheduler/job/1880553
# test job: [6be988660b474564c77cb6ff60776dafcd850a18] https://lava.sirena.=
org.uk/scheduler/job/1880009
# test job: [dc64b3d42cb361d4b39eb7cc73037fec52ef9676] https://lava.sirena.=
org.uk/scheduler/job/1881577
# test job: [abfbfb98acfe6fd603d48424e32f8d99922e70b9] https://lava.sirena.=
org.uk/scheduler/job/1885006
# test job: [5fa7d739f811bdffb5fc99696c2e821344fe0b88] https://lava.sirena.=
org.uk/scheduler/job/1868334
# test job: [4e65bda8273c938039403144730923e77916a3d7] https://lava.sirena.=
org.uk/scheduler/job/1868062
# test job: [e609438851928381e39b5393f17156955a84122a] https://lava.sirena.=
org.uk/scheduler/job/1868298
# test job: [5890f504ef543190beae2a4e244bbfa7c3e0b57c] https://lava.sirena.=
org.uk/scheduler/job/1885602
# test job: [46c8b4d2a693eca69a2191436cffa44f489e98c7] https://lava.sirena.=
org.uk/scheduler/job/1862020
# test job: [878702702dbbd933a5da601c75b8e58eadeec311] https://lava.sirena.=
org.uk/scheduler/job/1863785
# test job: [e336ab509b43ea601801dfa05b4270023c3ed007] https://lava.sirena.=
org.uk/scheduler/job/1862904
# test job: [ad4728740bd68d74365a43acc25a65339a9b2173] https://lava.sirena.=
org.uk/scheduler/job/1862573
# test job: [f98cabe3f6cf6396b3ae0264800d9b53d7612433] https://lava.sirena.=
org.uk/scheduler/job/1862338
# test job: [63b4c34635cf32af023796b64c855dd1ed0f0a4f] https://lava.sirena.=
org.uk/scheduler/job/1863533
# test job: [87cab86925b7fa4c1c977bc191ac549a3b23f0ea] https://lava.sirena.=
org.uk/scheduler/job/1850962
# test job: [2aa28b748fc967a2f2566c06bdad155fba8af7d8] https://lava.sirena.=
org.uk/scheduler/job/1848330
# test job: [20253f806818e9a1657a832ebcf4141d0a08c02a] https://lava.sirena.=
org.uk/scheduler/job/1848543
# test job: [0266f9541038b9b98ddd387132b5bdfe32a304e3] https://lava.sirena.=
org.uk/scheduler/job/1848801
# test job: [2c618f361ae6b9da7fafafc289051728ef4c6ea3] https://lava.sirena.=
org.uk/scheduler/job/1850254
# test job: [0f67557763accbdd56681f17ed5350735198c57b] https://lava.sirena.=
org.uk/scheduler/job/1848729
# test job: [a24802b0a2a238eaa610b0b0e87a4500a35de64a] https://lava.sirena.=
org.uk/scheduler/job/1847555
# test job: [62a7b3bbb6b873fdcc85a37efbd0102d66c8a73e] https://lava.sirena.=
org.uk/scheduler/job/1847961
# test job: [d64035a5a37741b25712fb9c2f6aca535c2967ea] https://lava.sirena.=
org.uk/scheduler/job/1919902
# test job: [644685abc16b58b3afcc2feb0ac14e86476ca2ed] https://lava.sirena.=
org.uk/scheduler/job/1919733
# test job: [cb3c715d89607f8896c0f20fe528a08e7ebffea9] https://lava.sirena.=
org.uk/scheduler/job/1847548
# test job: [ab63e9910d2d3ea4b8e6c08812258a676defcb9c] https://lava.sirena.=
org.uk/scheduler/job/1838208
# test job: [abe962346ef420998d47ba1c2fe591582f69e92e] https://lava.sirena.=
org.uk/scheduler/job/1840595
# test job: [8b84d712ad849172f6bbcad57534b284d942b0b5] https://lava.sirena.=
org.uk/scheduler/job/1834038
# test job: [88d0d17192c5a850dc07bb38035b69c4cefde270] https://lava.sirena.=
org.uk/scheduler/job/1833988
# test job: [8d7de4a014f589c1776959f7fdadbf7b12045aac] https://lava.sirena.=
org.uk/scheduler/job/1833226
# test job: [6a1f303cba45fa3b612d5a2898b1b1b045eb74e3] https://lava.sirena.=
org.uk/scheduler/job/1830431
# test job: [afd77d2050c35aee0d51ab7fb5b36a0fcabd4eee] https://lava.sirena.=
org.uk/scheduler/job/1886080
# test job: [8b184c34806e5da4d4847fabd3faeff38b47e70a] https://lava.sirena.=
org.uk/scheduler/job/1829207
# test job: [4d906371d1f9fc9ce47b2c8f37444680246557bc] https://lava.sirena.=
org.uk/scheduler/job/1832438
# test job: [18dda9eb9e11b2aeec73cbe2a56ab2f862841ba4] https://lava.sirena.=
org.uk/scheduler/job/1829155
# test job: [f8527a29f4619f74bc30a9845ea87abb9a6faa1e] https://lava.sirena.=
org.uk/scheduler/job/1832502
# test job: [2742d963e1dd7f4a3d0505044323b091daffcddc] https://lava.sirena.=
org.uk/scheduler/job/1884218
# test job: [59ba108806516adeaed51a536d55d4f5e9645881] https://lava.sirena.=
org.uk/scheduler/job/1809987
# test job: [30db1b21fa37a2f37c7f4d71864405a05e889833] https://lava.sirena.=
org.uk/scheduler/job/1811004
# test job: [1217b573978482ae7d21dc5c0bf5aa5007b24f90] https://lava.sirena.=
org.uk/scheduler/job/1809957
# test job: [a22a9e1271fb505f2c85d526d05aad5dde2f50e1] https://lava.sirena.=
org.uk/scheduler/job/1883508
# test job: [29e087f31bb104c3ad71396e3a2f94982f2801d2] https://lava.sirena.=
org.uk/scheduler/job/1900486
# test job: [2e0fd4583d0efcdc260e61a22666c8368f505353] https://lava.sirena.=
org.uk/scheduler/job/1806809
# test job: [46961265bdfb9c237cb03ea6b640b8e7588a982a] https://lava.sirena.=
org.uk/scheduler/job/1884880
# test job: [b5bad77e1e3c7249e4c0c88f98477e1ee7669b63] https://lava.sirena.=
org.uk/scheduler/job/1993320
# test job: [4dfa64181f23079077c7c1f7e9c342661f66f1d5] https://lava.sirena.=
org.uk/scheduler/job/1919620
# test job: [6a129b2ca5c533aec89fbeb58470811cc4102642] https://lava.sirena.=
org.uk/scheduler/job/1805765
# test job: [d9e33b38c89f4cf8c32b8481dbcf3a6cdbba4595] https://lava.sirena.=
org.uk/scheduler/job/1806672
# test job: [e5b4ad2183f7ab18aaf7c73a120d17241ee58e97] https://lava.sirena.=
org.uk/scheduler/job/1799495
# test job: [4336efb59ef364e691ef829a73d9dbd4d5ed7c7b] https://lava.sirena.=
org.uk/scheduler/job/1795901
# test job: [5bad16482c2a7e788c042d98f3e97d3b2bbc8cc5] https://lava.sirena.=
org.uk/scheduler/job/1795963
# test job: [7d083666123a425ba9f81dff1a52955b1f226540] https://lava.sirena.=
org.uk/scheduler/job/1794830
# test job: [2c625f0fe2db4e6a58877ce2318df3aa312eb791] https://lava.sirena.=
org.uk/scheduler/job/1794545
# test job: [1cf87861a2e02432fb68f8bcc8f20a8e42acde59] https://lava.sirena.=
org.uk/scheduler/job/1795064
# test job: [365075b7d0b95c737284d6970769e964c7e7052d] https://lava.sirena.=
org.uk/scheduler/job/1900400
# test job: [b497e1a1a2b10c4ddb28064fba229365ae03311a] https://lava.sirena.=
org.uk/scheduler/job/1780236
# test job: [9e5eb8b49ffe3c173bf7b8c338a57dfa09fb4634] https://lava.sirena.=
org.uk/scheduler/job/1779444
# test job: [7748328c2fd82efed24257b2bfd796eb1fa1d09b] https://lava.sirena.=
org.uk/scheduler/job/1773396
# test job: [0ccc1eeda155c947d88ef053e0b54e434e218ee2] https://lava.sirena.=
org.uk/scheduler/job/1773056
# test job: [dd7ae5b8b3c291c0206f127a564ae1e316705ca0] https://lava.sirena.=
org.uk/scheduler/job/1773239
# test job: [5cc49b5a36b32a2dba41441ea13b93fb5ea21cfd] https://lava.sirena.=
org.uk/scheduler/job/1769271
# test job: [ce1a46b2d6a8465a86f7a6f71beb4c6de83bce5c] https://lava.sirena.=
org.uk/scheduler/job/1768996
# test job: [94b39cb3ad6db935b585988b36378884199cd5fc] https://lava.sirena.=
org.uk/scheduler/job/1768632
# test job: [ce57b718006a069226b5e5d3afe7969acd59154e] https://lava.sirena.=
org.uk/scheduler/job/1768710
# test job: [3279052eab235bfb7130b1fabc74029c2260ed8d] https://lava.sirena.=
org.uk/scheduler/job/1762434
# test job: [8f57dcf39fd0864f5f3e6701fe885e55f45d0d3a] https://lava.sirena.=
org.uk/scheduler/job/1760117
# test job: [bdd235f2df6d5d6cf00cdf474970b1e6d177f2bd] https://lava.sirena.=
org.uk/scheduler/job/1884384
# test job: [9d35d068fb138160709e04e3ee97fe29a6f8615b] https://lava.sirena.=
org.uk/scheduler/job/1758668
# test job: [8a9772ec08f87c9e45ab1ad2c8d2b8c1763836eb] https://lava.sirena.=
org.uk/scheduler/job/1758573
# test job: [3d439e1ec3368fae17db379354bd7a9e568ca0ab] https://lava.sirena.=
org.uk/scheduler/job/1753483
# test job: [d57d27171c92e9049d5301785fb38de127b28fbf] https://lava.sirena.=
org.uk/scheduler/job/1752640
# test job: [f7c41911ad744177d8289820f01009dc93d8f91c] https://lava.sirena.=
org.uk/scheduler/job/1752282
# test job: [07752abfa5dbf7cb4d9ce69fa94dc3b12bc597d9] https://lava.sirena.=
org.uk/scheduler/job/1752234
# test job: [f522da9ab56c96db8703b2ea0f09be7cdc3bffeb] https://lava.sirena.=
org.uk/scheduler/job/1751874
# test job: [5c39bc498f5ff7ef016abf3f16698f3e8db79677] https://lava.sirena.=
org.uk/scheduler/job/1751941
# test job: [a37280daa4d583c7212681c49b285de9464a5200] https://lava.sirena.=
org.uk/scheduler/job/1746913
# test job: [b088b6189a4066b97cef459afd312fd168a76dea] https://lava.sirena.=
org.uk/scheduler/job/1746192
# test job: [c42e36a488c7e01f833fc9f4814f735b66b2d494] https://lava.sirena.=
org.uk/scheduler/job/1746243
# test job: [f4672dc6e9c07643c8c755856ba8e9eb9ca95d0c] https://lava.sirena.=
org.uk/scheduler/job/1747888
# test job: [ff9a7857b7848227788f113d6dc6a72e989084e0] https://lava.sirena.=
org.uk/scheduler/job/1746337
# test job: [5b4dcaf851df8c414bfc2ac3bf9c65fc942f3be4] https://lava.sirena.=
org.uk/scheduler/job/1747668
# test job: [e2ab5f600bb01d3625d667d97b3eb7538e388336] https://lava.sirena.=
org.uk/scheduler/job/1746591
# test job: [11f5c5f9e43e9020bae452232983fe98e7abfce0] https://lava.sirena.=
org.uk/scheduler/job/1747485
# test job: [899fb38dd76dd3ede425bbaf8a96d390180a5d1c] https://lava.sirena.=
org.uk/scheduler/job/1747385
# test job: [07188450191da0e3cff6f6d0c42de74d6cdb3602] https://lava.sirena.=
org.uk/scheduler/job/2099423
# test job: [edb5c1f885207d1d74e8a1528e6937e02829ee6e] https://lava.sirena.=
org.uk/scheduler/job/1746128
# test job: [a12b74d2bd4724ee1883bc97ec93eac8fafc8d3c] https://lava.sirena.=
org.uk/scheduler/job/1734043
# test job: [f840737d1746398c2993be34bfdc80bdc19ecae2] https://lava.sirena.=
org.uk/scheduler/job/1727325
# test job: [ab6d91d141a801dadf9eed7860b2ea09c9268149] https://lava.sirena.=
org.uk/scheduler/job/1884076
# test job: [f12343013022a92fff0cf22cb7b22b9c909cdbf5] https://lava.sirena.=
org.uk/scheduler/job/1900737
# test job: [d78e48ebe04e9566f8ecbf51471e80da3adbceeb] https://lava.sirena.=
org.uk/scheduler/job/1706193
# test job: [c232495d28ca092d0c39b10e35d3d613bd2414ab] https://lava.sirena.=
org.uk/scheduler/job/1699583
# test job: [96bcb34df55f7fee99795127c796315950c94fed] https://lava.sirena.=
org.uk/scheduler/job/1699558
# test job: [ec0be3cdf40b5302248f3fb27a911cc630e8b855] https://lava.sirena.=
org.uk/scheduler/job/1694320
# test job: [c1dd310f1d76b4b13f1854618087af2513140897] https://lava.sirena.=
org.uk/scheduler/job/1692987
# test job: [da9881d00153cc6d3917f6b74144b1d41b58338c] https://lava.sirena.=
org.uk/scheduler/job/1693374
# test job: [27848c082ba0b22850fd9fb7b185c015423dcdc7] https://lava.sirena.=
org.uk/scheduler/job/1693115
# test job: [cf65182247761f7993737b710afe8c781699356b] https://lava.sirena.=
org.uk/scheduler/job/1687545
# test job: [2a55135201d5e24b80b7624880ff42eafd8e320c] https://lava.sirena.=
org.uk/scheduler/job/1685795
# test job: [550bc517e59347b3b1af7d290eac4fb1411a3d4e] https://lava.sirena.=
org.uk/scheduler/job/1685911
# test job: [daf855f76a1210ceed9541f71ac5dd9be02018a6] https://lava.sirena.=
org.uk/scheduler/job/1685505
# test job: [0056b410355713556d8a10306f82e55b28d33ba8] https://lava.sirena.=
org.uk/scheduler/job/1685609
# test job: [90179609efa421b1ccc7d8eafbc078bafb25777c] https://lava.sirena.=
org.uk/scheduler/job/1686053
# test job: [6d068f1ae2a2f713d7f21a9a602e65b3d6b6fc6d] https://lava.sirena.=
org.uk/scheduler/job/1673136
# test job: [a46e95c81e3a28926ab1904d9f754fef8318074d] https://lava.sirena.=
org.uk/scheduler/job/1673781
# test job: [258384d8ce365dddd6c5c15204de8ccd53a7ab0a] https://lava.sirena.=
org.uk/scheduler/job/1673374
# test job: [48124569bbc6bfda1df3e9ee17b19d559f4b1aa3] https://lava.sirena.=
org.uk/scheduler/job/1670178
# test job: [0e62438e476494a1891a8822b9785bc6e73e9c3f] https://lava.sirena.=
org.uk/scheduler/job/1669548
# test job: [37533933bfe92cd5a99ef4743f31dac62ccc8de0] https://lava.sirena.=
org.uk/scheduler/job/1668972
# test job: [5c36b86d2bf68fbcad16169983ef7ee8c537db59] https://lava.sirena.=
org.uk/scheduler/job/1668601
# test job: [714165e1c4b0d5b8c6d095fe07f65e6e7047aaeb] https://lava.sirena.=
org.uk/scheduler/job/1667730
# test job: [9c45f95222beecd6a284fd1284d54dd7a772cf59] https://lava.sirena.=
org.uk/scheduler/job/1667595
# test job: [b832b19318534bb4f1673b24d78037fee339c679] https://lava.sirena.=
org.uk/scheduler/job/1659221
# test job: [bab4ab484a6ca170847da9bffe86f1fa90df4bbe] https://lava.sirena.=
org.uk/scheduler/job/1664669
# test job: [8c02c8353460f8630313aef6810f34e134a3c1ee] https://lava.sirena.=
org.uk/scheduler/job/1659272
# test job: [ae014fbc99c7f986ee785233e7a5336834e39af4] https://lava.sirena.=
org.uk/scheduler/job/1883688
# test job: [6b7e2aa50bdaf88cd4c2a5e2059a7bf32d85a8b1] https://lava.sirena.=
org.uk/scheduler/job/1656576
# test job: [a54ef14188519a0994d0264f701f5771815fa11e] https://lava.sirena.=
org.uk/scheduler/job/1656018
# test job: [2291a2186305faaf8525d57849d8ba12ad63f5e7] https://lava.sirena.=
org.uk/scheduler/job/1655765
# test job: [a1d0b0ae65ae3f32597edfbb547f16c75601cd87] https://lava.sirena.=
org.uk/scheduler/job/1654219
# test job: [3059067fd3378a5454e7928c08d20bf3ef186760] https://lava.sirena.=
org.uk/scheduler/job/1653991
# test job: [162e23657e5379f07c6404dbfbf4367cb438ea7d] https://lava.sirena.=
org.uk/scheduler/job/1652988
# test job: [595b7f155b926460a00776cc581e4dcd01220006] https://lava.sirena.=
org.uk/scheduler/job/1653110
# test job: [886f42ce96e7ce80545704e7168a9c6b60cd6c03] https://lava.sirena.=
org.uk/scheduler/job/1654309
# test job: [cf25eb8eae91bcae9b2065d84b0c0ba0f6d9dd34] https://lava.sirena.=
org.uk/scheduler/job/1654803
# test job: [9a200cbdb54349909a42b45379e792e4b39dd223] https://lava.sirena.=
org.uk/scheduler/job/1654737
# test job: [2d86d2585ab929a143d1e6f8963da1499e33bf13] https://lava.sirena.=
org.uk/scheduler/job/1655874
# test job: [2eba5e05d9bcf4cdea995ed51b0f07ba0275794a] https://lava.sirena.=
org.uk/scheduler/job/2123881
# bad: [2eba5e05d9bcf4cdea995ed51b0f07ba0275794a] Merge tag 'loongarch-fixe=
s-6.18-2' of git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux=
-loongson
git bisect bad 2eba5e05d9bcf4cdea995ed51b0f07ba0275794a
# test job: [23cb64fb76257309e396ea4cec8396d4a1dbae68] https://lava.sirena.=
org.uk/scheduler/job/2108751
# bad: [23cb64fb76257309e396ea4cec8396d4a1dbae68] Merge tag 'soc-fixes-6.18=
-3' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
git bisect bad 23cb64fb76257309e396ea4cec8396d4a1dbae68
# test job: [8b690556d8fe074b4f9835075050fba3fb180e93] https://lava.sirena.=
org.uk/scheduler/job/2104943
# bad: [8b690556d8fe074b4f9835075050fba3fb180e93] Merge tag 'for-linus' of =
git://git.kernel.org/pub/scm/virt/kvm/kvm
git bisect bad 8b690556d8fe074b4f9835075050fba3fb180e93
# test job: [89edd36fd801efdb3d2f38bbf7791a293c24bb45] https://lava.sirena.=
org.uk/scheduler/job/2127016
# bad: [89edd36fd801efdb3d2f38bbf7791a293c24bb45] Merge tag 'xfs-fixes-6.18=
-rc7' of git://git.kernel.org/pub/scm/fs/xfs/xfs-linux
git bisect bad 89edd36fd801efdb3d2f38bbf7791a293c24bb45
# test job: [fd95357fd8c6778ac7dea6c57a19b8b182b6e91f] https://lava.sirena.=
org.uk/scheduler/job/2115951
# bad: [fd95357fd8c6778ac7dea6c57a19b8b182b6e91f] Merge tag 'sched_ext-for-=
6.18-rc6-fixes-2' of git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched=
_ext
git bisect bad fd95357fd8c6778ac7dea6c57a19b8b182b6e91f
# test job: [8e621c9a337555c914cf1664605edfaa6f839774] https://lava.sirena.=
org.uk/scheduler/job/2115222
# bad: [8e621c9a337555c914cf1664605edfaa6f839774] Merge tag 'net-6.18-rc7' =
of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
git bisect bad 8e621c9a337555c914cf1664605edfaa6f839774
# test job: [2c26574cc4ea41266d9a09441d0e05a9f09192de] https://lava.sirena.=
org.uk/scheduler/job/2124642
# bad: [2c26574cc4ea41266d9a09441d0e05a9f09192de] Merge tag 'gpio-fixes-for=
-v6.18-rc7' of git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux
git bisect bad 2c26574cc4ea41266d9a09441d0e05a9f09192de
# test job: [e7c375b181600caf135cfd03eadbc45eb530f2cb] https://lava.sirena.=
org.uk/scheduler/job/2099961
# bad: [e7c375b181600caf135cfd03eadbc45eb530f2cb] Merge tag 'vfs-6.18-rc7.f=
ixes' of gitolite.kernel.org:pub/scm/linux/kernel/git/vfs/vfs
git bisect bad e7c375b181600caf135cfd03eadbc45eb530f2cb
# test job: [5bebe8de19264946d398ead4e6c20c229454a552] https://lava.sirena.=
org.uk/scheduler/job/2103898
# bad: [5bebe8de19264946d398ead4e6c20c229454a552] mm/huge_memory: Fix initi=
alization of huge zero folio
git bisect bad 5bebe8de19264946d398ead4e6c20c229454a552
# test job: [78f0e33cd6c939a555aa80dbed2fec6b333a7660] https://lava.sirena.=
org.uk/scheduler/job/2100992
# bad: [78f0e33cd6c939a555aa80dbed2fec6b333a7660] fs/namespace: correctly h=
andle errors returned by grab_requested_mnt_ns
git bisect bad 78f0e33cd6c939a555aa80dbed2fec6b333a7660
# first bad commit: [78f0e33cd6c939a555aa80dbed2fec6b333a7660] fs/namespace=
: correctly handle errors returned by grab_requested_mnt_ns
# test job: [12741624645e098b2234a5ae341045a97473caf1] https://lava.sirena.=
org.uk/scheduler/job/2099888
# bad: [12741624645e098b2234a5ae341045a97473caf1] fs: add iput_not_last()
git bisect bad 12741624645e098b2234a5ae341045a97473caf1
# test job: [3cd1548a278c7d6a9bdef1f1866e7cf66bfd3518] https://lava.sirena.=
org.uk/scheduler/job/2100724
# bad: [3cd1548a278c7d6a9bdef1f1866e7cf66bfd3518] shmem: fix tmpfs reconfig=
uration (remount) when noswap is set
git bisect bad 3cd1548a278c7d6a9bdef1f1866e7cf66bfd3518
# test job: [78f0e33cd6c939a555aa80dbed2fec6b333a7660] https://lava.sirena.=
org.uk/scheduler/job/2100992
# bad: [78f0e33cd6c939a555aa80dbed2fec6b333a7660] fs/namespace: correctly h=
andle errors returned by grab_requested_mnt_ns
git bisect bad 78f0e33cd6c939a555aa80dbed2fec6b333a7660
# first bad commit: [78f0e33cd6c939a555aa80dbed2fec6b333a7660] fs/namespace=
: correctly handle errors returned by grab_requested_mnt_ns

--Q9wk31LSaiO1BkPa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmkjA0sACgkQJNaLcl1U
h9Ad2Af/fsRtIay4F35Chwoig5vyoa7xCz4gYNEbCHYrTUCnTap6OFJKssq+/65w
aZAO97NYVWfeuvgX0X/NLr12pzXOahZEs49JclK42jn+YgbPc+25tg5CbV/FmoQ4
T1OevNhH26A4XRlapb5BICYxc/5feVT3a2ntx6oc7shR6Xt5dLW08K1XnHSwDxtW
x28qbIUEnN9Eqxrcyi0R/Zngfgce+0vB3/QOpgsTmG1OXUx2NOfqdkkIpixMEss9
Fv6+2WyVuOGyr2FbL19s/Q8nMn/oiTp1gczZlHUJ9sDLtuOyA4v4Tl7bknIIrLsC
SVwMBb2OSYPU+xti2nj3eQvMYwamUg==
=msvU
-----END PGP SIGNATURE-----

--Q9wk31LSaiO1BkPa--

