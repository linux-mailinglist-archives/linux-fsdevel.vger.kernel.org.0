Return-Path: <linux-fsdevel+bounces-74324-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5267ED39A89
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Jan 2026 23:30:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B056D300B912
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Jan 2026 22:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4394D30EF83;
	Sun, 18 Jan 2026 22:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jagalactic.com header.i=@jagalactic.com header.b="ht5rEbuv";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="Nix05zN5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from a11-79.smtp-out.amazonses.com (a11-79.smtp-out.amazonses.com [54.240.11.79])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA803101DB;
	Sun, 18 Jan 2026 22:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.11.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768775433; cv=none; b=DDL6QKhl4d3W9IsXQvij7aKXMf1dmv+m25saQDitbYY9Ih43K2MXIX6cwiUDltgk9VxEF4Zqv4agNslM6bRN6gL/A3WRksOq0N7gIKHcZqZOgH8iVY7nbmTe6M/QV3BtK1AgmcuV16OLLbJD882JaCg115umYDqvSiw07/otuws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768775433; c=relaxed/simple;
	bh=g/tS9w4XY7HRbfPhELOCKivk71iA+SfVuXhGHpk5qeg=;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:In-Reply-To:
	 References:Message-ID; b=NlyGKi7ku6ktdIcPgPgYDPjoRvEDLpp91Ab1+142nEh8oRtFFSmTcgcZ7ARzbZVdreznk7U8d7dV+PtdB1J++e/Pe3Hl2LhAgek9mPhBtuZibXkRsRctQcKboj4etez6B/ZtA/iVKepHqAFzUF69CpX9Lfgg1WuSYaKE0X33KBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jagalactic.com; spf=pass smtp.mailfrom=amazonses.com; dkim=pass (1024-bit key) header.d=jagalactic.com header.i=@jagalactic.com header.b=ht5rEbuv; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=Nix05zN5; arc=none smtp.client-ip=54.240.11.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jagalactic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazonses.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=o25mqk5iffcfzgc3wo2zjhkohcyjzsoq; d=jagalactic.com; t=1768775426;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References:Message-Id;
	bh=g/tS9w4XY7HRbfPhELOCKivk71iA+SfVuXhGHpk5qeg=;
	b=ht5rEbuvR2BERl2o4nc6hv9kUfGimQ4XXYM2xyKVvMxo0gyOEvGotR3qomPpj4CK
	p/fpUhUOqcrHwob0TflDHkXYgugAn96kUoNkbHH2aiVnvC4Pk1f4SyUMCRS28k+grG2
	Rm2LApsLjvSYkEbQ2UjEMJ7fgy6+zcjLrgxQ6jmo=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1768775426;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References:Message-Id:Feedback-ID;
	bh=g/tS9w4XY7HRbfPhELOCKivk71iA+SfVuXhGHpk5qeg=;
	b=Nix05zN5ppzS7jDR/Pdq2xsIBenw5PG39cQMdtEM0H9vhCpmhp407ybUm18DqTxx
	L+Y8eutfIF0ocPhTVB0yJzV6NCCUBRyUS/jruw4w1Ymb7Jltn4RUtFP+hBbSbNtMqYl
	Tc4PXjU/jVcb/t5lJeyBRaF7/gKQLzaYIYUaI3yI=
Subject: [PATCH V7 00/19] famfs: port into fuse
From: =?UTF-8?Q?John_Groves?= <john@jagalactic.com>
To: =?UTF-8?Q?John_Groves?= <John@Groves.net>, 
	=?UTF-8?Q?Miklos_Szeredi?= <miklos@szeredi.hu>, 
	=?UTF-8?Q?Dan_Williams?= <dan.j.williams@intel.com>, 
	=?UTF-8?Q?Bernd_Schubert?= <bschubert@ddn.com>, 
	=?UTF-8?Q?Alison_Schofiel?= =?UTF-8?Q?d?= <alison.schofield@intel.com>
Cc: =?UTF-8?Q?John_Groves?= <jgroves@micron.com>, 
	=?UTF-8?Q?John_Groves?= <jgroves@fastmail.com>, 
	=?UTF-8?Q?Jonathan_Corbet?= <corbet@lwn.net>, 
	=?UTF-8?Q?Vishal_Verma?= <vishal.l.verma@intel.com>, 
	=?UTF-8?Q?Dave_Jiang?= <dave.jiang@intel.com>, 
	=?UTF-8?Q?Matthew_Wilcox?= <willy@infradead.org>, 
	=?UTF-8?Q?Jan_Kara?= <jack@suse.cz>, 
	=?UTF-8?Q?Alexander_Viro?= <viro@zeniv.linux.org.uk>, 
	=?UTF-8?Q?David_Hildenbrand?= <david@kernel.org>, 
	=?UTF-8?Q?Christian_Bra?= =?UTF-8?Q?uner?= <brauner@kernel.org>, 
	=?UTF-8?Q?Darrick_J_=2E_Wong?= <djwong@kernel.org>, 
	=?UTF-8?Q?Randy_Dunlap?= <rdunlap@infradead.org>, 
	=?UTF-8?Q?Jeff_Layton?= <jlayton@kernel.org>, 
	=?UTF-8?Q?Amir_Goldstein?= <amir73il@gmail.com>, 
	=?UTF-8?Q?Jonathan_Cameron?= <Jonathan.Cameron@huawei.com>, 
	=?UTF-8?Q?Stefan_Hajnoczi?= <shajnocz@redhat.com>, 
	=?UTF-8?Q?Joanne_Koong?= <joannelkoong@gmail.com>, 
	=?UTF-8?Q?Josef_Bacik?= <josef@toxicpanda.com>, 
	=?UTF-8?Q?Bagas_Sanjaya?= <bagasdotme@gmail.com>, 
	=?UTF-8?Q?James_Morse?= <james.morse@arm.com>, 
	=?UTF-8?Q?Fuad_Tabba?= <tabba@google.com>, 
	=?UTF-8?Q?Sean_Christopherson?= <seanjc@google.com>, 
	=?UTF-8?Q?Shivank_Garg?= <shivankg@amd.com>, 
	=?UTF-8?Q?Ackerley_Tng?= <ackerleytng@google.com>, 
	=?UTF-8?Q?Gregory_Pric?= =?UTF-8?Q?e?= <gourry@gourry.net>, 
	=?UTF-8?Q?Aravind_Ramesh?= <arramesh@micron.com>, 
	=?UTF-8?Q?Ajay_Joshi?= <ajayjoshi@micron.com>, 
	=?UTF-8?Q?venkataravis=40micron=2Ecom?= <venkataravis@micron.com>, 
	=?UTF-8?Q?linux-doc=40vger=2Ekernel=2Eorg?= <linux-doc@vger.kernel.org>, 
	=?UTF-8?Q?linux-kernel=40vger=2Ekernel=2Eorg?= <linux-kernel@vger.kernel.org>, 
	=?UTF-8?Q?nvdimm=40lists=2Elinux=2Edev?= <nvdimm@lists.linux.dev>, 
	=?UTF-8?Q?linux-cxl=40vger=2Ekernel=2Eorg?= <linux-cxl@vger.kernel.org>, 
	=?UTF-8?Q?linux-fsdevel=40vger=2Ekernel=2Eorg?= <linux-fsdevel@vger.kernel.org>, 
	=?UTF-8?Q?John_Groves?= <john@groves.net>
Date: Sun, 18 Jan 2026 22:30:25 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
In-Reply-To: 
 <0100019bd33a16b4-6da11a99-d883-4cfc-b561-97973253bc4a-000000@email.amazonses.com>
References: 
 <0100019bd33a16b4-6da11a99-d883-4cfc-b561-97973253bc4a-000000@email.amazonses.com> 
 <20260118223008.92258-1-john@jagalactic.com>
X-Mailer: Amazon WorkMail
Thread-Index: AQHciMnhcFkpAz6WTSKstYDfyF/cJQAACiwl
Thread-Topic: [PATCH V7 00/19] famfs: port into fuse
X-Wm-Sent-Timestamp: 1768775424
X-Original-Mailer: git-send-email 2.52.0
Message-ID: <0100019bd33b1f66-b835e86a-e8ae-443f-a474-02db88f7e6db-000000@email.amazonses.com>
Feedback-ID: ::1.us-east-1.LF00NED762KFuBsfzrtoqw+Brn/qlF9OYdxWukAhsl8=:AmazonSES
X-SES-Outgoing: 2026.01.18-54.240.11.79

From: John Groves <john@groves.net>=0D=0A=0D=0AThis patch series is avail=
able as a git tag at [0].=0D=0A=0D=0AChanges v6 -> v7=0D=0A- Fixed a regr=
ession in famfs_interleave_fileofs_to_daxofs() that=0D=0A  was reported b=
y Intel's kernel test robot=0D=0A- Added a check in __fsdev_dax_direct_ac=
cess() for negative return=0D=0A  from pgoff_to_phys(), which would indic=
ate an out-of-range offset=0D=0A- Fixed a bug in __famfs_meta_free(), whe=
re not all interleaved=0D=0A  extents were freed=0D=0A- Added chunksize a=
lignment checks in famfs_fuse_meta_alloc() and=0D=0A  famfs_interleave_fi=
leofs_to_daxofs() as interleaved chunks must=0D=0A  be PTE or PMD aligned=
=0D=0A- Simplified famfs_file_init_dax() a bit=0D=0A- Re-ran CM's kernel =
code review prompts on the entire series and=0D=0A  fixed several minor i=
ssues=0D=0A=0D=0AChanges v4 -> v5 -> v6=0D=0A- None. Re-sending due to te=
chnical difficulties=0D=0A=0D=0AChanges v3 [9] -> v4=0D=0A- The patch "da=
x: prevent driver unbind while filesystem holds device"=0D=0A  has been d=
ropped. Dan Williams indicated that the favored behavior is=0D=0A  for a =
file system to stop working if an underlying driver is unbound,=0D=0A  ra=
ther than preventing the unbind.=0D=0A- The patch "famfs_fuse: Famfs moun=
t opt: -o shadow=3D<shadowpath>" has=0D=0A  been dropped. Found a way for=
 the famfs user space to do without the=0D=0A  -o opt (via getxattr).=0D=0A=
- Squashed the fs/fuse/Kconfig patch into the first subsequent patch=0D=0A=
  that needed the change=0D=0A  ("famfs_fuse: Basic fuse kernel ABI enabl=
ement for famfs")=0D=0A- Many review comments addressed.=0D=0A- Addressed=
 minor kerneldoc infractions reported by test robot.=0D=0A=0D=0ADescripti=
on:=0D=0A=0D=0AThis patch series introduces famfs into the fuse file syst=
em framework.=0D=0AThis is really two patch series concatenated.=0D=0A=0D=
=0A- The patches with the 'dax:' prefix introduce necessary dax=0D=0A  fu=
nctionality.=0D=0A- The patches with 'famfs_fuse:' introduce the famfs fu=
nctionality into=0D=0A  fuse. The famfs_fuse patches depend on the dax pa=
tches.=0D=0A=0D=0AIn addition, there are related patch sets for libfuse a=
nd ndctl(daxctl).=0D=0A=0D=0ARelated patches and code=0D=0A=0D=0A- Relate=
d patch to libfuse - posted under the same cover=0D=0A- Related patch to =
ndctl/daxctl - posted under the same cover=0D=0A- The famfs user space co=
de can be found at [1]=0D=0A=0D=0ADax Overview:=0D=0A=0D=0AThis series in=
troduces a new "famfs mode" of devdax, whose driver is=0D=0Adrivers/dax/f=
sdev.c. This driver supports dax_iomap_rw() and=0D=0Adax_iomap_fault() ca=
lls against a character dax instance. A dax device=0D=0Anow can be conver=
ted among three modes: 'system-ram', 'devdax' and=0D=0A'famfs' via daxctl=
 or sysfs (e.g. unbind devdax and bind famfs instead).=0D=0A=0D=0AIn famf=
s mode, a dax device initializes its pages consistent with the=0D=0Afsdax=
mode of pmem. Raw read/write/mmap are not supported in this mode,=0D=0Abu=
t famfs is happy in this mode - using dax_iomap_rw() for read/write and=0D=
=0Adax_iomap_fault() for mmap faults.=0D=0A=0D=0AFuse Overview:=0D=0A=0D=0A=
Famfs started as a standalone file system, but this series is intended to=
=0D=0Apermanently supersede that implementation. At a high level, famfs a=
dds=0D=0Atwo new fuse server messages:=0D=0A=0D=0AGET_FMAP   - Retrieves =
a famfs fmap (the file-to-dax map for a famfs=0D=0A=09     file)=0D=0AGET=
_DAXDEV - Retrieves the details of a particular daxdev that was=0D=0A=09 =
    referenced by an fmap=0D=0A=0D=0AFamfs Overview=0D=0A=0D=0AFamfs expo=
ses shared memory as a file system. Famfs consumes shared=0D=0Amemory fro=
m dax devices, and provides memory-mappable files that map=0D=0Adirectly =
to the memory - no page cache involvement. Famfs differs from=0D=0Aconven=
tional file systems in fs-dax mode, in that it handles in-memory=0D=0Amet=
adata in a sharable way (which begins with never caching dirty shared=0D=0A=
metadata).=0D=0A=0D=0AFamfs started as a standalone file system [2,3], bu=
t the consensus at=0D=0ALSFMM was that it should be ported into fuse [4,5=
].=0D=0A=0D=0AThe key performance requirement is that famfs must resolve =
mapping faults=0D=0Awithout upcalls. This is achieved by fully caching th=
e file-to-devdax=0D=0Ametadata for all active files. This is done via two=
 fuse client/server=0D=0Amessage/response pairs: GET_FMAP and GET_DAXDEV.=
=0D=0A=0D=0AFamfs remains the first fs-dax file system that is backed by =
devdax=0D=0Arather than pmem in fs-dax mode (hence the need for the new d=
ax mode).=0D=0A=0D=0ANotes=0D=0A=0D=0A- When a file is opened in a famfs =
mount, the OPEN is followed by a=0D=0A  GET_FMAP message and response. Th=
e "fmap" is the full file-to-dax=0D=0A  mapping, allowing the fuse/famfs =
kernel code to handle=0D=0A  read/write/fault without any upcalls.=0D=0A=0D=
=0A- After each GET_FMAP, the fmap is checked for extents that reference=0D=
=0A  previously-unknown daxdevs. Each such occurrence is handled with a=0D=
=0A  GET_DAXDEV message and response.=0D=0A=0D=0A- Daxdevs are stored in =
a table (which might become an xarray at some=0D=0A  point). When entries=
 are added to the table, we acquire exclusive=0D=0A  access to the daxdev=
 via the fs_dax_get() call (modeled after how=0D=0A  fs-dax handles this =
with pmem devices). Famfs provides=0D=0A  holder_operations to devdax, pr=
oviding a notification path in the=0D=0A  event of memory errors or force=
d reconfiguration.=0D=0A=0D=0A- If devdax notifies famfs of memory errors=
 on a dax device, famfs=0D=0A  currently blocks all subsequent accesses t=
o data on that device. The=0D=0A  recovery is to re-initialize the memory=
 and file system. Famfs is=0D=0A  memory, not storage...=0D=0A=0D=0A- Bec=
ause famfs uses backing (devdax) devices, only privileged mounts are=0D=0A=
  supported (i.e. the fuse server requires CAP_SYS_RAWIO).=0D=0A=0D=0A- T=
he famfs kernel code never accesses the memory directly - it only=0D=0A  =
facilitates read, write and mmap on behalf of user processes, using=0D=0A=
  fmap metadata provided by its privileged fuse server. As such, the=0D=0A=
  RAS of the shared memory affects applications, but not the kernel.=0D=0A=
=0D=0A- Famfs has backing device(s), but they are devdax (char) rather th=
an=0D=0A  block. Right now there is no way to tell the vfs layer that fam=
fs has a=0D=0A  char backing device (unless we say it's block, but it's n=
ot). Currently=0D=0A  we use the standard anonymous fuse fs_type - but I'=
m not sure that's=0D=0A  ultimately optimal (thoughts=3F)=0D=0A=0D=0AChan=
ges v2 [7] -> v3=0D=0A- Dax: Completely new fsdev driver (drivers/dax/fsd=
ev.c) replaces the=0D=0A  dev_dax_iomap modifications to bus.c/device.c. =
Devdax devices can now=0D=0A  be switched among 'devdax', 'famfs' and 'sy=
stem-ram' modes via daxctl=0D=0A  or sysfs.=0D=0A- Dax: fsdev uses MEMORY=
_DEVICE_FS_DAX type and leaves folios at order-0=0D=0A  (no vmemmap_shift=
), allowing fs-dax to manage folio lifecycles=0D=0A  dynamically like pme=
m does.=0D=0A- Dax: The "poisoned page" problem is properly fixed via=0D=0A=
  fsdev_clear_folio_state(), which clears stale mapping/compound state=0D=
=0A  when fsdev binds. The temporary WARN_ON_ONCE workaround in fs/dax.c=0D=
=0A  has been removed.=0D=0A- Dax: Added dax_set_ops() so fsdev can set d=
ax_operations at bind time=0D=0A  (and clear them on unbind), since the d=
ax_device is created before we=0D=0A  know which driver will bind.=0D=0A-=
 Dax: Added custom bind/unbind sysfs handlers; unbind return -EBUSY if a=0D=
=0A  filesystem holds the device, preventing unbind while famfs is mounte=
d.=0D=0A- Fuse: Famfs mounts now require that the fuse server/daemon has=0D=
=0A  CAP_SYS_RAWIO because they expose raw memory devices.=0D=0A- Fuse: A=
dded DAX address_space_operations with noop_dirty_folio since=0D=0A  famf=
s is memory-backed with no writeback required.=0D=0A- Rebased to latest k=
ernels, fully compatible with Alistair Popple=0D=0A  et. al's recent dax =
refactoring.=0D=0A- Ran this series through Chris Mason's code review AI =
prompts to check=0D=0A  for issues - several subtle problems found and fi=
xed.=0D=0A- Dropped RFC status - this version is intended to be mergeable=
=2E=0D=0A=0D=0AChanges v1 [8] -> v2:=0D=0A=0D=0A- The GET_FMAP message/re=
sponse has been moved from LOOKUP to OPEN, as=0D=0A  was the pretty much =
unanimous consensus.=0D=0A- Made the response payload to GET_FMAP variabl=
e sized (patch 12)=0D=0A- Dodgy kerneldoc comments cleaned up or removed.=
=0D=0A- Fixed memory leak of fc->shadow in patch 11 (thanks Joanne)=0D=0A=
- Dropped many pr_debug and pr_notice calls=0D=0A=0D=0A=0D=0AReferences=0D=
=0A=0D=0A[0] - https://github.com/jagalactic/linux/tree/famfs-v7 (this pa=
tch set)=0D=0A[1] - https://famfs.org (famfs user space)=0D=0A[2] - https=
://lore.kernel.org/linux-cxl/cover.1708709155.git.john@groves.net/=0D=0A[=
3] - https://lore.kernel.org/linux-cxl/cover.1714409084.git.john@groves.n=
et/=0D=0A[4] - https://lwn.net/Articles/983105/ (lsfmm 2024)=0D=0A[5] - h=
ttps://lwn.net/Articles/1020170/ (lsfmm 2025)=0D=0A[6] - https://lore.ker=
nel.org/linux-cxl/cover.8068ad144a7eea4a813670301f4d2a86a8e68ec4.17407134=
01.git-series.apopple@nvidia.com/=0D=0A[7] - https://lore.kernel.org/linu=
x-fsdevel/20250703185032.46568-1-john@groves.net/ (famfs fuse v2)=0D=0A[8=
] - https://lore.kernel.org/linux-fsdevel/20250421013346.32530-1-john@gro=
ves.net/ (famfs fuse v1)=0D=0A[9] - https://lore.kernel.org/linux-fsdevel=
/20260107153244.64703-1-john@groves.net/T/#mb2c868801be16eca82dab239a1d20=
1628534aea7 (famfs fuse v3)=0D=0A=0D=0A=0D=0AJohn Groves (19):=0D=0A  dax=
: move dax_pgoff_to_phys from [drivers/dax/] device.c to bus.c=0D=0A  dax=
: Factor out dax_folio_reset_order() helper=0D=0A  dax: add fsdev.c drive=
r for fs-dax on character dax=0D=0A  dax: Save the kva from memremap=0D=0A=
  dax: Add dax_operations for use by fs-dax on fsdev dax=0D=0A  dax: Add =
dax_set_ops() for setting dax_operations at bind time=0D=0A  dax: Add fs_=
dax_get() func to prepare dax for fs-dax usage=0D=0A  dax: export dax_dev=
_get()=0D=0A  famfs_fuse: magic.h: Add famfs magic numbers=0D=0A  famfs_f=
use: Update macro s/FUSE_IS_DAX/FUSE_IS_VIRTIO_DAX/=0D=0A  famfs_fuse: Ba=
sic fuse kernel ABI enablement for famfs=0D=0A  famfs_fuse: Plumb the GET=
_FMAP message/response=0D=0A  famfs_fuse: Create files with famfs fmaps=0D=
=0A  famfs_fuse: GET_DAXDEV message and daxdev_table=0D=0A  famfs_fuse: P=
lumb dax iomap and fuse read/write/mmap=0D=0A  famfs_fuse: Add holder_ope=
rations for dax notify_failure()=0D=0A  famfs_fuse: Add DAX address_space=
_operations with noop_dirty_folio=0D=0A  famfs_fuse: Add famfs fmap metad=
ata documentation=0D=0A  famfs_fuse: Add documentation=0D=0A=0D=0A Docume=
ntation/filesystems/famfs.rst |  142 ++++=0D=0A Documentation/filesystems=
/index.rst |    1 +=0D=0A MAINTAINERS                         |   18 +=0D=
=0A drivers/dax/Makefile                |    6 +=0D=0A drivers/dax/bus.c =
                  |   30 +-=0D=0A drivers/dax/bus.h                   |  =
  3 +=0D=0A drivers/dax/dax-private.h           |    3 +=0D=0A drivers/da=
x/device.c                |   23 -=0D=0A drivers/dax/fsdev.c             =
    |  344 ++++++++=0D=0A drivers/dax/super.c                 |   99 ++-=0D=
=0A fs/dax.c                            |   61 +-=0D=0A fs/fuse/Kconfig  =
                   |   14 +=0D=0A fs/fuse/Makefile                    |  =
  1 +=0D=0A fs/fuse/dir.c                       |    2 +-=0D=0A fs/fuse/f=
amfs.c                     | 1184 +++++++++++++++++++++++++++=0D=0A fs/fu=
se/famfs_kfmap.h               |  167 ++++=0D=0A fs/fuse/file.c          =
            |   45 +-=0D=0A fs/fuse/fuse_i.h                    |  116 ++=
-=0D=0A fs/fuse/inode.c                     |   34 +-=0D=0A fs/fuse/iomod=
e.c                    |    2 +-=0D=0A fs/namei.c                        =
  |    1 +=0D=0A include/linux/dax.h                 |   21 +-=0D=0A incl=
ude/uapi/linux/fuse.h           |   88 ++=0D=0A include/uapi/linux/magic.=
h          |    2 +=0D=0A 24 files changed, 2344 insertions(+), 63 deleti=
ons(-)=0D=0A create mode 100644 Documentation/filesystems/famfs.rst=0D=0A=
 create mode 100644 drivers/dax/fsdev.c=0D=0A create mode 100644 fs/fuse/=
famfs.c=0D=0A create mode 100644 fs/fuse/famfs_kfmap.h=0D=0A=0D=0A=0D=0Ab=
ase-commit: 0f61b1860cc3f52aef9036d7235ed1f017632193=0D=0A--=20=0D=0A2.52=
=2E0=0D=0A=0D=0A

