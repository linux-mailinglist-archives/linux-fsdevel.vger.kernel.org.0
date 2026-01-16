Return-Path: <linux-fsdevel+bounces-74204-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 816B1D38501
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 19:58:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E47530F9E8F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 18:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A7323A0B12;
	Fri, 16 Jan 2026 18:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jagalactic.com header.i=@jagalactic.com header.b="vbM2yGdh";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="Gi3fQs7h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from a11-17.smtp-out.amazonses.com (a11-17.smtp-out.amazonses.com [54.240.11.17])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193BD25EF9C;
	Fri, 16 Jan 2026 18:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.11.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768589921; cv=none; b=MlBMRBqgvg49ViAkAqM9Q8oJCaOnRfhc6zmxDoX+XhapgfacJtywBP6U+D28NwhWXgSfgl7IR5aUvSKxbU2OZuaYJBEayVEpiRdxc9Go7peez2V1Pua0ArqnjkogMwC84Qn/Hjq6RdGG3A5TNDA+RsAAcTdH4/T99qqBLplV7QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768589921; c=relaxed/simple;
	bh=/sdS7vCqUmKEDV/vd52LKO+j8MFS84EvHhb0gGdQDwc=;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:References:
	 Message-ID; b=nRQC4vtkbyhGyEHOQjPjoSPQCHCZv33FllrM3iW3HZmNDLgAIp5bz4o3PGQiMNxbvGb/h8kkHqnf5kPoVCsRNaGigZWhpVE8Ai7XOO3zgbSTSXhWvlrqBN/tsLQOxNuXjccBe9iY6oVboOHjWbwgOCemTvuo+i/d5s5JJ7AVLto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jagalactic.com; spf=pass smtp.mailfrom=amazonses.com; dkim=pass (1024-bit key) header.d=jagalactic.com header.i=@jagalactic.com header.b=vbM2yGdh; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=Gi3fQs7h; arc=none smtp.client-ip=54.240.11.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jagalactic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazonses.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=o25mqk5iffcfzgc3wo2zjhkohcyjzsoq; d=jagalactic.com; t=1768589918;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:References:Message-Id;
	bh=/sdS7vCqUmKEDV/vd52LKO+j8MFS84EvHhb0gGdQDwc=;
	b=vbM2yGdht11ynf/u8mt/KOSSO0U7IPP3becv9FkadYYpv3BjWy9k+fQ41gh+kH4a
	TXLIhNOXGpuNR8Ixn+/aNFpG0CF+9s+dpeFX8I/oj26Qvr3osKxJoG+w4DED8YdubiL
	QQtjWBmqo+wRTUXsl4+rEoDSU+cGiPVwl2DamDGQ=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1768589918;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:References:Message-Id:Feedback-ID;
	bh=/sdS7vCqUmKEDV/vd52LKO+j8MFS84EvHhb0gGdQDwc=;
	b=Gi3fQs7hCnsefMtyCRe+XM2nw4AuLKsPKtVV2gh0HGgEYJdZ5EIK/xYvUVuc8iXo
	5EqocsV/3VoknsUhiLXdzXMIZ6PBkmEtczmPs9Ki0mYOuNASMLFw1sh90CJh1CCefAl
	YAtFVweklAfa09Lo8jZuQnISww58RSusxmfsZiJc=
Subject: [PATCH BUNDLE v3] famfs: Fabric-Attached Memory File System
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
Date: Fri, 16 Jan 2026 18:58:38 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <20260116125831.953.compound@groves.net>
X-Mailer: Amazon WorkMail
Thread-Index: AQHchxoe1VAe00deR0Sw2d725Qhurg==
Thread-Topic: [PATCH BUNDLE v3] famfs: Fabric-Attached Memory File System
X-Wm-Sent-Timestamp: 1768589916
X-Original-Mailer: git-send-email 2.52.0
Message-ID: <0100019bc82c7f86-fa3e7ed1-6abc-40b2-b73c-d3021ea16342-000000@email.amazonses.com>
Feedback-ID: ::1.us-east-1.LF00NED762KFuBsfzrtoqw+Brn/qlF9OYdxWukAhsl8=:AmazonSES
X-SES-Outgoing: 2026.01.16-54.240.11.17

[no change since last version - gmail dropped some of those messages]=0D=0A=
=0D=0AThis is a coordinated patch submission for famfs (Fabric-Attached M=
emory=0D=0AFile System) across three repositories:=0D=0A=0D=0A  1. Linux =
kernel (21 patches) - dax fsdev driver + fuse/famfs integration=0D=0A  2.=
 libfuse (4 patches) - famfs protocol support for fuse servers=0D=0A  3. =
ndctl/daxctl (2 patches) - support for the new "famfs" devdax mode=0D=0A =
    (this is unchanged, but marked V2 to keep the "bundle" together)=0D=0A=
=0D=0AEach series is posted as a reply to this cover message, with indivi=
dual=0D=0Apatches replying to their respective series cover.=0D=0A=0D=0AO=
verview=0D=0A--------=0D=0AFamfs exposes shared memory as a file system. =
It consumes shared memory=0D=0Afrom dax devices and provides memory-mappa=
ble files that map directly to=0D=0Athe memory with no page cache involve=
ment. Famfs differs from conventional=0D=0Afile systems in fs-dax mode in=
 that it handles in-memory metadata in a=0D=0Asharable way (which begins =
with never caching dirty shared metadata).=0D=0A=0D=0AFamfs started as a =
standalone file system [1,2], but the consensus at=0D=0ALSFMM 2024 and 20=
25 [3,4] was that it should be ported into fuse.=0D=0A=0D=0AThe key perfo=
rmance requirement is that famfs must resolve mapping faults=0D=0Awithout=
 upcalls. This is achieved by fully caching the file-to-devdax=0D=0Ametad=
ata for all active files via two fuse client/server message/response=0D=0A=
pairs: GET_FMAP and GET_DAXDEV.=0D=0A=0D=0APatch Series Summary=0D=0A----=
----------------=0D=0A=0D=0ALinux Kernel (V3, 21 patches):=0D=0A  - dax: =
New fsdev driver (drivers/dax/fsdev.c) providing a devdax mode=0D=0A    c=
ompatible with fs-dax. Devices can be switched among 'devdax', 'fsdev'=0D=
=0A    and 'system-ram' modes via daxctl or sysfs.=0D=0A  - fuse: Famfs i=
ntegration adding GET_FMAP and GET_DAXDEV messages for=0D=0A    caching f=
ile-to-dax mappings in the kernel.=0D=0A=0D=0Alibfuse (V2, 4 patches):=0D=
=0A  - Updates fuse_kernel.h to kernel 6.19 baseline=0D=0A  - Adds famfs =
DAX fmap protocol definitions=0D=0A  - Implements famfs DAX fmap support =
for fuse servers=0D=0A=0D=0Andctl/daxctl (2 patches):=0D=0A  - Adds daxct=
l support for the new "famfs" mode of devdax=0D=0A  - Adds test/daxctl-fa=
mfs.sh for testing mode transitions=0D=0A=0D=0AChanges Since V2 (kernel)=0D=
=0A-------------------------=0D=0A- Dax: Completely new fsdev driver repl=
aces the dev_dax_iomap modifications.=0D=0A  Uses MEMORY_DEVICE_FS_DAX ty=
pe with order-0 folios for fs-dax compatibility.=0D=0A- Dax: The "poisone=
d page" problem is properly fixed via fsdev_clear_folio_state()=0D=0A  wh=
ich clears stale mapping/compound state when fsdev binds.=0D=0A- Dax: Add=
ed dax_set_ops() and driver unbind protection while filesystem mounted.=0D=
=0A- Fuse: Famfs mounts require CAP_SYS_RAWIO (exposing raw memory device=
s).=0D=0A- Fuse: Added DAX address_space_operations with noop_dirty_folio=
=2E=0D=0A- Rebased to latest kernels, compatible with recent dax refactor=
ing.=0D=0A=0D=0ATesting=0D=0A-------=0D=0AThe famfs user space [5] includ=
es comprehensive smoke and unit tests that=0D=0Aexercise all three compon=
ents together. The ndctl series includes a=0D=0Adedicated test for famfs =
mode transitions.=0D=0A=0D=0AReferences=0D=0A----------=0D=0A[1] https://=
lore.kernel.org/linux-cxl/cover.1708709155.git.john@groves.net/=0D=0A[2] =
https://lore.kernel.org/linux-cxl/cover.1714409084.git.john@groves.net/=0D=
=0A[3] https://lwn.net/Articles/983105/ (LSFMM 2024)=0D=0A[4] https://lwn=
=2Enet/Articles/1020170/ (LSFMM 2025)=0D=0A[5] https://famfs.org (famfs u=
ser space)=0D=0A[6] https://lore.kernel.org/linux-cxl/20250703185032.4656=
8-1-john@groves.net/ (V2)=0D=0A[7] https://lore.kernel.org/linux-fsdevel/=
20260107153244.64703-1-john@groves.net/T/#m0000d8c00290f48c086b8b176c7525=
e410f8508c (related ndctl series)=0D=0A--=0D=0AJohn Groves=0D=0A

