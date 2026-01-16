Return-Path: <linux-fsdevel+bounces-74205-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 11150D38504
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 19:59:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0DA21300E808
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 18:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4A73A0B3F;
	Fri, 16 Jan 2026 18:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jagalactic.com header.i=@jagalactic.com header.b="FTaInlOn";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="mKHNAEb6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from a8-40.smtp-out.amazonses.com (a8-40.smtp-out.amazonses.com [54.240.8.40])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE4D3491C8;
	Fri, 16 Jan 2026 18:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.8.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768589960; cv=none; b=PFkLyyUozE+F8B4vU/mU7WFtAlrlWl3jiYd1axnAuy3qWTmadLuXjtdV5vkVGVwJn75P2FJq3fz7uDr28Kc6c4glquxYegocb+tGl5W4nWZsAAWRWVQ8J/qQrIb+vsZtU/Q087Aq/5foO9HOk9qXR35AySkPS55PrkP13BfgZE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768589960; c=relaxed/simple;
	bh=0n7p/JWjkg8Avows68jZuSokwavjg+2RuDLE8HtYVl0=;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:In-Reply-To:
	 References:Message-ID; b=OiEmhrFAuBvS3mzmUuzVJCBJG5Wh4x+S8yzjtvRc6D80EACYLuJEf3lxPD/KpwzjdHWeiXxVFr+WMk6BX2DmKtKBq3SXnZ7hxFSCyp5VXnwWoZVm7wvICZ0fVSRSyboXuOjNOofzJ83m20kfBqv9Ot6k+FyKAM2x0pJKkbfbvFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jagalactic.com; spf=pass smtp.mailfrom=amazonses.com; dkim=pass (1024-bit key) header.d=jagalactic.com header.i=@jagalactic.com header.b=FTaInlOn; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=mKHNAEb6; arc=none smtp.client-ip=54.240.8.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jagalactic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazonses.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=o25mqk5iffcfzgc3wo2zjhkohcyjzsoq; d=jagalactic.com; t=1768589957;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References:Message-Id;
	bh=0n7p/JWjkg8Avows68jZuSokwavjg+2RuDLE8HtYVl0=;
	b=FTaInlOnC8deLXTIfeLXZUJUkKpZPET4l7RdMymjvhfACF78qiNMO9n0jrSTE3Xl
	RVzKKv4ELljMAyJ81uc7x40b3AW+eryXTX25FVmpLrt/f7qew9REAlgWcwqyETp5yXo
	TDGt3aTyJqdtU5YbkKjk4rzy0hEk63cBPCET3egU=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1768589957;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References:Message-Id:Feedback-ID;
	bh=0n7p/JWjkg8Avows68jZuSokwavjg+2RuDLE8HtYVl0=;
	b=mKHNAEb66hFKgqu5wAYJP5dNnSPro3o31WWKCbvHlfeyoP/PtaQ1VkC/80dL8HFw
	mn3fxLc8yCL37MUU1frMPGMA3K5qwao6G0sYUHmP1uqEuSsHgPyWO5LlnuMqV7hFkwk
	V3rYedYrQ3ZyqRc18WROwfQiexDx61HfdJ6X15o4=
Subject: [PATCH V5 00/19] famfs: port into fuse
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
	=?UTF-8?Q?linux-fsdevel=40vger=2Ekernel=2Eorg?= <linux-fsdevel@vger.kernel.org>
Date: Fri, 16 Jan 2026 18:59:17 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260116125831.953.compound@groves.net>
References: <20260116125831.953.compound@groves.net> 
 <20260116185911.1005-1-john@jagalactic.com>
X-Mailer: Amazon WorkMail
Thread-Index: AQHchxoe1VAe00deR0Sw2d725QhurgAABexr
Thread-Topic: [PATCH V5 00/19] famfs: port into fuse
X-Wm-Sent-Timestamp: 1768589956
X-Original-Mailer: git-send-email 2.52.0
Message-ID: <0100019bc82d18c8-5d82b58b-fc4e-4d93-a732-4c99c8f94bb6-000000@email.amazonses.com>
Feedback-ID: ::1.us-east-1.LF00NED762KFuBsfzrtoqw+Brn/qlF9OYdxWukAhsl8=:AmazonSES
X-SES-Outgoing: 2026.01.16-54.240.8.40

From: John Groves <john@groves.net>=0D=0A=0D=0AThis patch series is avail=
able as a git tag at [0].=0D=0A=0D=0AChanges v4 -> v5=0D=0A- None. Re-sen=
ding because gmail dropped some of the msgs in v4=0D=0A=0D=0AChanges v3 [=
9] -> v4=0D=0A- The patch "dax: prevent driver unbind while filesystem ho=
lds device"=0D=0A  has been dropped. Dan Williams indicated that the favo=
red behavior is=0D=0A  for a file system to stop working if an underlying=
 driver is unbound,=0D=0A  rather than preventing the unbind.=0D=0A- The =
patch "famfs_fuse: Famfs mount opt: -o shadow=3D<shadowpath>" has=0D=0A  =
been dropped. Found a way for the famfs user space to do without the=0D=0A=
  -o opt (via getxattr).=0D=0A- Squashed the fs/fuse/Kconfig patch into t=
he first subsequent patch=0D=0A  that needed the change=0D=0A  ("famfs_fu=
se: Basic fuse kernel ABI enablement for famfs")=0D=0A- Many review comme=
nts addressed.=0D=0A- Addressed minor kerneldoc infractions reported by t=
est robot.=0D=0A=0D=0ADescription:=0D=0A=0D=0AThis patch series introduce=
s famfs into the fuse file system framework.=0D=0AThis is really two patc=
h series concatenated.=0D=0A=0D=0A- The patches with the 'dax:' prefix in=
troduce necessary dax=0D=0A  functionality.=0D=0A- The patches with 'famf=
s_fuse:' introduce the famfs functionality into=0D=0A  fuse. The famfs_fu=
se patches depend on the dax patches.=0D=0A=0D=0AIn addition, there are r=
elated patch sets for libfuse and ndctl(daxctl).=0D=0A=0D=0ARelated patch=
es and code=0D=0A=0D=0A- Related patch to libfuse - posted under the same=
 cover=0D=0A- Related patch to ndctl/daxctl - posted under the same cover=
=0D=0A- The famfs user space code can be found at [1]=0D=0A=0D=0ADax Over=
view:=0D=0A=0D=0AThis series introduces a new "famfs mode" of devdax, who=
se driver is=0D=0Adrivers/dax/fsdev.c. This driver supports dax_iomap_rw(=
) and=0D=0Adax_iomap_fault() calls against a character dax instance. A da=
x device=0D=0Anow can be converted among three modes: 'system-ram', 'devd=
ax' and=0D=0A'famfs' via daxctl or sysfs (e.g. unbind devdax and bind fam=
fs instead).=0D=0A=0D=0AIn famfs mode, a dax device initializes its pages=
 consistent with the=0D=0Afsdaxmode of pmem. Raw read/write/mmap are not =
supported in this mode,=0D=0Abut famfs is happy in this mode - using dax_=
iomap_rw() for read/write and=0D=0Adax_iomap_fault() for mmap faults.=0D=0A=
=0D=0AFuse Overview:=0D=0A=0D=0AFamfs started as a standalone file system=
, but this series is intended to=0D=0Apermanently supersede that implemen=
tation. At a high level, famfs adds=0D=0Atwo new fuse server messages:=0D=
=0A=0D=0AGET_FMAP   - Retrieves a famfs fmap (the file-to-dax map for a f=
amfs=0D=0A=09     file)=0D=0AGET_DAXDEV - Retrieves the details of a part=
icular daxdev that was=0D=0A=09     referenced by an fmap=0D=0A=0D=0AFamf=
s Overview=0D=0A=0D=0AFamfs exposes shared memory as a file system. Famfs=
 consumes shared=0D=0Amemory from dax devices, and provides memory-mappab=
le files that map=0D=0Adirectly to the memory - no page cache involvement=
=2E Famfs differs from=0D=0Aconventional file systems in fs-dax mode, in =
that it handles in-memory=0D=0Ametadata in a sharable way (which begins w=
ith never caching dirty shared=0D=0Ametadata).=0D=0A=0D=0AFamfs started a=
s a standalone file system [2,3], but the consensus at=0D=0ALSFMM was tha=
t it should be ported into fuse [4,5].=0D=0A=0D=0AThe key performance req=
uirement is that famfs must resolve mapping faults=0D=0Awithout upcalls. =
This is achieved by fully caching the file-to-devdax=0D=0Ametadata for al=
l active files. This is done via two fuse client/server=0D=0Amessage/resp=
onse pairs: GET_FMAP and GET_DAXDEV.=0D=0A=0D=0AFamfs remains the first f=
s-dax file system that is backed by devdax=0D=0Arather than pmem in fs-da=
x mode (hence the need for the new dax mode).=0D=0A=0D=0ANotes=0D=0A=0D=0A=
- When a file is opened in a famfs mount, the OPEN is followed by a=0D=0A=
  GET_FMAP message and response. The "fmap" is the full file-to-dax=0D=0A=
  mapping, allowing the fuse/famfs kernel code to handle=0D=0A  read/writ=
e/fault without any upcalls.=0D=0A=0D=0A- After each GET_FMAP, the fmap i=
s checked for extents that reference=0D=0A  previously-unknown daxdevs. E=
ach such occurrence is handled with a=0D=0A  GET_DAXDEV message and respo=
nse.=0D=0A=0D=0A- Daxdevs are stored in a table (which might become an xa=
rray at some=0D=0A  point). When entries are added to the table, we acqui=
re exclusive=0D=0A  access to the daxdev via the fs_dax_get() call (model=
ed after how=0D=0A  fs-dax handles this with pmem devices). Famfs provide=
s=0D=0A  holder_operations to devdax, providing a notification path in th=
e=0D=0A  event of memory errors or forced reconfiguration.=0D=0A=0D=0A- I=
f devdax notifies famfs of memory errors on a dax device, famfs=0D=0A  cu=
rrently blocks all subsequent accesses to data on that device. The=0D=0A =
 recovery is to re-initialize the memory and file system. Famfs is=0D=0A =
 memory, not storage...=0D=0A=0D=0A- Because famfs uses backing (devdax) =
devices, only privileged mounts are=0D=0A  supported (i.e. the fuse serve=
r requires CAP_SYS_RAWIO).=0D=0A=0D=0A- The famfs kernel code never acces=
ses the memory directly - it only=0D=0A  facilitates read, write and mmap=
 on behalf of user processes, using=0D=0A  fmap metadata provided by its =
privileged fuse server. As such, the=0D=0A  RAS of the shared memory affe=
cts applications, but not the kernel.=0D=0A=0D=0A- Famfs has backing devi=
ce(s), but they are devdax (char) rather than=0D=0A  block. Right now the=
re is no way to tell the vfs layer that famfs has a=0D=0A  char backing d=
evice (unless we say it's block, but it's not). Currently=0D=0A  we use t=
he standard anonymous fuse fs_type - but I'm not sure that's=0D=0A  ultim=
ately optimal (thoughts=3F)=0D=0A=0D=0AChanges v2 [7] -> v3=0D=0A- Dax: C=
ompletely new fsdev driver (drivers/dax/fsdev.c) replaces the=0D=0A  dev_=
dax_iomap modifications to bus.c/device.c. Devdax devices can now=0D=0A  =
be switched among 'devdax', 'famfs' and 'system-ram' modes via daxctl=0D=0A=
  or sysfs.=0D=0A- Dax: fsdev uses MEMORY_DEVICE_FS_DAX type and leaves f=
olios at order-0=0D=0A  (no vmemmap_shift), allowing fs-dax to manage fol=
io lifecycles=0D=0A  dynamically like pmem does.=0D=0A- Dax: The "poisone=
d page" problem is properly fixed via=0D=0A  fsdev_clear_folio_state(), w=
hich clears stale mapping/compound state=0D=0A  when fsdev binds. The tem=
porary WARN_ON_ONCE workaround in fs/dax.c=0D=0A  has been removed.=0D=0A=
- Dax: Added dax_set_ops() so fsdev can set dax_operations at bind time=0D=
=0A  (and clear them on unbind), since the dax_device is created before w=
e=0D=0A  know which driver will bind.=0D=0A- Dax: Added custom bind/unbin=
d sysfs handlers; unbind return -EBUSY if a=0D=0A  filesystem holds the d=
evice, preventing unbind while famfs is mounted.=0D=0A- Fuse: Famfs mount=
s now require that the fuse server/daemon has=0D=0A  CAP_SYS_RAWIO becaus=
e they expose raw memory devices.=0D=0A- Fuse: Added DAX address_space_op=
erations with noop_dirty_folio since=0D=0A  famfs is memory-backed with n=
o writeback required.=0D=0A- Rebased to latest kernels, fully compatible =
with Alistair Popple=0D=0A  et. al's recent dax refactoring.=0D=0A- Ran t=
his series through Chris Mason's code review AI prompts to check=0D=0A  f=
or issues - several subtle problems found and fixed.=0D=0A- Dropped RFC s=
tatus - this version is intended to be mergeable.=0D=0A=0D=0AChanges v1 [=
8] -> v2:=0D=0A=0D=0A- The GET_FMAP message/response has been moved from =
LOOKUP to OPEN, as=0D=0A  was the pretty much unanimous consensus.=0D=0A-=
 Made the response payload to GET_FMAP variable sized (patch 12)=0D=0A- D=
odgy kerneldoc comments cleaned up or removed.=0D=0A- Fixed memory leak o=
f fc->shadow in patch 11 (thanks Joanne)=0D=0A- Dropped many pr_debug and=
 pr_notice calls=0D=0A=0D=0A=0D=0AReferences=0D=0A=0D=0A[0] - https://git=
hub.com/jagalactic/linux/tree/famfs-v4 (this patch set)=0D=0A[1] - https:=
//famfs.org (famfs user space)=0D=0A[2] - https://lore.kernel.org/linux-c=
xl/cover.1708709155.git.john@groves.net/=0D=0A[3] - https://lore.kernel.o=
rg/linux-cxl/cover.1714409084.git.john@groves.net/=0D=0A[4] - https://lwn=
=2Enet/Articles/983105/ (lsfmm 2024)=0D=0A[5] - https://lwn.net/Articles/=
1020170/ (lsfmm 2025)=0D=0A[6] - https://lore.kernel.org/linux-cxl/cover.=
8068ad144a7eea4a813670301f4d2a86a8e68ec4.1740713401.git-series.apopple@nv=
idia.com/=0D=0A[7] - https://lore.kernel.org/linux-fsdevel/20250703185032=
=2E46568-1-john@groves.net/ (famfs fuse v2)=0D=0A[8] - https://lore.kerne=
l.org/linux-fsdevel/20250421013346.32530-1-john@groves.net/ (famfs fuse v=
1)=0D=0A[9] - https://lore.kernel.org/linux-fsdevel/20260107153244.64703-=
1-john@groves.net/T/#mb2c868801be16eca82dab239a1d201628534aea7 (famfs fus=
e v3)=0D=0A=0D=0A=0D=0AJohn Groves (19):=0D=0A  dax: move dax_pgoff_to_ph=
ys from [drivers/dax/] device.c to bus.c=0D=0A  dax: Factor out dax_folio=
_reset_order() helper=0D=0A  dax: add fsdev.c driver for fs-dax on charac=
ter dax=0D=0A  dax: Save the kva from memremap=0D=0A  dax: Add dax_operat=
ions for use by fs-dax on fsdev dax=0D=0A  dax: Add dax_set_ops() for set=
ting dax_operations at bind time=0D=0A  dax: Add fs_dax_get() func to pre=
pare dax for fs-dax usage=0D=0A  dax: export dax_dev_get()=0D=0A  famfs_f=
use: magic.h: Add famfs magic numbers=0D=0A  famfs_fuse: Update macro s/F=
USE_IS_DAX/FUSE_IS_VIRTIO_DAX/=0D=0A  famfs_fuse: Basic fuse kernel ABI e=
nablement for famfs=0D=0A  famfs_fuse: Plumb the GET_FMAP message/respons=
e=0D=0A  famfs_fuse: Create files with famfs fmaps=0D=0A  famfs_fuse: GET=
_DAXDEV message and daxdev_table=0D=0A  famfs_fuse: Plumb dax iomap and f=
use read/write/mmap=0D=0A  famfs_fuse: Add holder_operations for dax noti=
fy_failure()=0D=0A  famfs_fuse: Add DAX address_space_operations with noo=
p_dirty_folio=0D=0A  famfs_fuse: Add famfs fmap metadata documentation=0D=
=0A  famfs_fuse: Add documentation=0D=0A=0D=0A Documentation/filesystems/=
famfs.rst |  142 ++++=0D=0A Documentation/filesystems/index.rst |    1 +=0D=
=0A MAINTAINERS                         |   18 +=0D=0A drivers/dax/Makefi=
le                |    6 +=0D=0A drivers/dax/bus.c                   |   =
30 +-=0D=0A drivers/dax/bus.h                   |    3 +=0D=0A drivers/da=
x/dax-private.h           |   10 +-=0D=0A drivers/dax/device.c           =
     |   23 -=0D=0A drivers/dax/fsdev.c                 |  339 ++++++++=0D=
=0A drivers/dax/super.c                 |   99 ++-=0D=0A fs/dax.c        =
                    |   61 +-=0D=0A fs/fuse/Kconfig                     |=
   14 +=0D=0A fs/fuse/Makefile                    |    1 +=0D=0A fs/fuse/=
dir.c                       |    2 +-=0D=0A fs/fuse/famfs.c              =
       | 1174 +++++++++++++++++++++++++++=0D=0A fs/fuse/famfs_kfmap.h    =
           |  167 ++++=0D=0A fs/fuse/file.c                      |   45 +=
-=0D=0A fs/fuse/fuse_i.h                    |  116 ++-=0D=0A fs/fuse/inod=
e.c                     |   34 +-=0D=0A fs/fuse/iomode.c                 =
   |    2 +-=0D=0A fs/namei.c                          |    1 +=0D=0A inc=
lude/linux/dax.h                 |   21 +-=0D=0A include/uapi/linux/fuse.=
h           |   88 ++=0D=0A include/uapi/linux/magic.h          |    2 +=0D=
=0A 24 files changed, 2334 insertions(+), 65 deletions(-)=0D=0A create mo=
de 100644 Documentation/filesystems/famfs.rst=0D=0A create mode 100644 dr=
ivers/dax/fsdev.c=0D=0A create mode 100644 fs/fuse/famfs.c=0D=0A create m=
ode 100644 fs/fuse/famfs_kfmap.h=0D=0A=0D=0A=0D=0Abase-commit: 0f61b1860c=
c3f52aef9036d7235ed1f017632193=0D=0A--=20=0D=0A2.52.0=0D=0A=0D=0A

