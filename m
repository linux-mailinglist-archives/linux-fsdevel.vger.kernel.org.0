Return-Path: <linux-fsdevel+bounces-15087-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D82886E79
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 15:26:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 699AD281E13
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 14:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDFBA481B7;
	Fri, 22 Mar 2024 14:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bLcBL/ob"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7AC47A6F
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Mar 2024 14:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711117576; cv=none; b=WbZ3QCihcZKD8LGS9eUhVSTKzfI8xFMs7K37eesTmWZiFlHixWNdRmgB2qWEQ88/TFMPzJ6yqerOYuJ0IhQIe+hpXOVtQ15VyLHk0OsUJ8lhmskvqx6Gip7wZ/mrAvKO83a2sK5+n7K7hx8HzSZBOoF1GfQlKAlvq/eqmdWzNPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711117576; c=relaxed/simple;
	bh=nSU7Us69HjcGfMbnFoTnP50Z6345s8XT/n87H31Yw/4=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=Pj2DrdMRMM6y+SpEhg2VFmnYPneJsh4tC1BS0OChvTbKU3CLjEF9J1odj5o+AJXf6rAGC5YOa/RwS7iozpSeo8eC4foDV2mirAqG76CQBlWnvMIfdI4Ucwr4aYWzVQs/rzd6Nohb/erwrs1ked41SH50WKZigofyBBGt3DdcmpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bLcBL/ob; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711117571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rNKWKSvBYXyFmKH07lb65pWFdnTMZ8/LLL+0AQv8eO4=;
	b=bLcBL/obbWtDCzqCO3PPbrtR4uBJqRvJ9isSCYkkQzvmeOpM7HYPwrHRtlBpachPQ0RyLd
	pVYF0eKPaX4UzpEj/vz0wtlb+5aYl5mwwgiLSbYoyuQpfLYlg0MBgn/rt5CuMO05gsmDGy
	M30mRDjb5vDuINRUcVBYiQM1w5UjR5I=
Date: Fri, 22 Mar 2024 14:26:07 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Eric Van Hensbergen" <eric.vanhensbergen@linux.dev>
Message-ID: <ada13e85bf2ceed91052fa20adb02c4815953e26@linux.dev>
TLS-Required: No
Subject: Re: [PATCH next] fs/9p: fix uaf in in v9fs_stat2inode_dotl
To: "Jakub Kicinski" <kuba@kernel.org>, asmadeus@codewreck.org
Cc: "Lizhi Xu" <lizhi.xu@windriver.com>,
 syzbot+7a3d75905ea1a830dbe5@syzkaller.appspotmail.com,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux_oss@crudebyte.com, lucho@ionkov.net,
 syzkaller-bugs@googlegroups.com, v9fs@lists.linux.dev,
 regressions@lists.linux.dev, netdev@vger.kernel.org
In-Reply-To: <20240321182824.6f303e38@kernel.org>
References: <00000000000055ecb906105ed669@google.com>
 <20240202121531.2550018-1-lizhi.xu@windriver.com>
 <ZeXGZS1-X8_CYCUz@codewreck.org>
 <20240321182824.6f303e38@kernel.org>
X-Migadu-Flow: FLOW_OUT

Patch is in the unapplied portion of my for-next tree along with another =
one.  I was hoping to hear some feedback on the other one before i did a =
pull request and was torn on whether or not I wait on -rc1 to send since =
we are so close.

       -eric


March 21, 2024 at 8:28 PM, "Jakub Kicinski" <kuba@kernel.org> wrote:
>=20
>=20On Mon, 4 Mar 2024 22:02:29 +0900 asmadeus@codewreck.org wrote:
>=20
>=20>=20
>=20> Lizhi Xu wrote on Fri, Feb 02, 2024 at 08:15:31PM +0800:
> >=20
>=20>  The incorrect logical order of accessing the st object code in v9f=
s_fid_iget_dotl
> >=20
>=20>  is causing this uaf.=20
>=20>=20
>=20>=20=20
>=20>=20
>=20>  Thanks for the fix!
> >=20
>=20>=20=20
>=20>=20
>=20>  Eric, this is also for your tree.
> >=20
>=20>=20=20
>=20>=20
>=20>  Fixes: 724a08450f74 ("fs/9p: simplify iget to remove unnecessary p=
aths")=20
>=20>=20
>=20>=20=20
>=20>=20
>=20>  (careful if you rebase your tree as this commit isn't merged yet)
> >=20
>=20>=20=20
>=20>=20
>=20>  Reported-and-tested-by: syzbot+7a3d75905ea1a830dbe5@syzkaller.apps=
potmail.com
> >=20
>=20>  Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>=20
>=20>=20
>=20>=20=20
>=20>=20
>=20>  Reviewed-by: Dominique Martinet <asmadeus@codewreck.org>
> >=20
>=20
> Looks like this UAF is in Linus's tree now, and possibly getting hit
>=20
>=20by anyone using virtme to test the kernel? I can't vouch for the
>=20
>=20correctness of the fix but it does make the KASAN splat go away for m=
e.
>=20
>=20[ 12.474676][ T1] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
>=20
>=20[ 12.474870][ T1] BUG: KASAN: slab-use-after-free in v9fs_stat2inode_=
dotl+0x9d6/0xb80
>=20
>=20[ 12.475060][ T1] Read of size 8 at addr ffff888002bdbad8 by task swa=
pper/0/1
>=20
>=20[ 12.475248][ T1]=20
>=20
> [ 12.475314][ T1] CPU: 3 PID: 1 Comm: swapper/0 Not tainted 6.8.0-virtm=
e #1
>=20
>=20[ 12.475503][ T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 199=
6), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
>=20
>=20[ 12.475811][ T1] Call Trace:
>=20
>=20[ 12.475908][ T1] <TASK>
>=20
>=20[ 12.475976][ T1] dump_stack_lvl+0x82/0xd0
>=20
>=20[ 12.476133][ T1] print_address_description.constprop.0+0x2c/0x3b0
>=20
>=20[ 12.476295][ T1] ? v9fs_stat2inode_dotl+0x9d6/0xb80
>=20
>=20[ 12.476425][ T1] print_report+0xb4/0x270
>=20
>=20[ 12.476552][ T1] ? kasan_addr_to_slab+0x4e/0x90
>=20
>=20[ 12.476679][ T1] kasan_report+0xbd/0xf0
>=20
>=20[ 12.476775][ T1] ? v9fs_stat2inode_dotl+0x9d6/0xb80
>=20
>=20[ 12.476903][ T1] v9fs_stat2inode_dotl+0x9d6/0xb80
>=20
>=20[ 12.477053][ T1] v9fs_fid_iget_dotl+0x18c/0x210
>=20
>=20[ 12.477180][ T1] v9fs_mount+0x3fe/0x7d0
>=20
>=20[ 12.477281][ T1] ? __pfx_v9fs_mount+0x10/0x10
>=20
>=20[ 12.477406][ T1] ? vfs_parse_fs_string+0xdb/0x130
>=20
>=20[ 12.477533][ T1] ? __pfx_vfs_parse_fs_string+0x10/0x10
>=20
>=20[ 12.477660][ T1] ? __pfx_v9fs_mount+0x10/0x10
>=20
>=20[ 12.477786][ T1] legacy_get_tree+0x107/0x200
>=20
>=20[ 12.477912][ T1] vfs_get_tree+0x8a/0x2e0
>=20
>=20[ 12.478042][ T1] do_new_mount+0x27d/0x5e0
>=20
>=20[ 12.478170][ T1] ? __pfx_do_new_mount+0x10/0x10
>=20
>=20[ 12.478294][ T1] ? __pfx___debug_check_no_obj_freed+0x10/0x10
>=20
>=20[ 12.478453][ T1] ? __virt_addr_valid+0x227/0x420
>=20
>=20[ 12.478583][ T1] path_mount+0x271/0x14f0
>=20
>=20[ 12.478713][ T1] ? __pfx_path_mount+0x10/0x10
>=20
>=20[ 12.478840][ T1] ? kmem_cache_free+0xd7/0x220
>=20
>=20[ 12.478970][ T1] ? kern_path+0x3d/0x50
>=20
>=20[ 12.479068][ T1] init_mount+0x9d/0xf0
>=20
>=20[ 12.479164][ T1] ? __pfx_init_mount+0x10/0x10
>=20
>=20[ 12.479292][ T1] do_mount_root+0xbc/0x330
>=20
>=20[ 12.479419][ T1] mount_root_generic+0x22c/0x470
>=20
>=20[ 12.479550][ T1] ? __pfx_mount_root_generic+0x10/0x10
>=20
>=20[ 12.479680][ T1] ? mount_root+0x25b/0x2f0
>=20
>=20[ 12.479807][ T1] prepare_namespace+0xa5/0x2d0
>=20
>=20[ 12.479933][ T1] ? __pfx_prepare_namespace+0x10/0x10
>=20
>=20[ 12.480061][ T1] ? __pfx_kernel_init+0x10/0x10
>=20
>=20[ 12.480188][ T1] kernel_init+0x20/0x200
>=20
>=20[ 12.480285][ T1] ? __pfx_kernel_init+0x10/0x10
>=20
>=20[ 12.480410][ T1] ret_from_fork+0x31/0x70
>=20
>=20[ 12.480543][ T1] ? __pfx_kernel_init+0x10/0x10
>=20
>=20[ 12.480670][ T1] ret_from_fork_asm+0x1a/0x30
>=20
>=20[ 12.480807][ T1] </TASK>
>=20
>=20[ 12.480904][ T1]=20
>=20
> [ 12.480969][ T1] Allocated by task 1:
>=20
>=20[ 12.481063][ T1] kasan_save_stack+0x24/0x50
>=20
>=20[ 12.481191][ T1] kasan_save_track+0x14/0x30
>=20
>=20[ 12.481323][ T1] __kasan_kmalloc+0x7f/0x90
>=20
>=20[ 12.481449][ T1] p9_client_getattr_dotl+0x4c/0x1a0
>=20
>=20[ 12.481576][ T1] v9fs_fid_iget_dotl+0xca/0x210
>=20
>=20[ 12.481706][ T1] v9fs_mount+0x3fe/0x7d0
>=20
>=20[ 12.481801][ T1] legacy_get_tree+0x107/0x200
>=20
>=20[ 12.481927][ T1] vfs_get_tree+0x8a/0x2e0
>=20
>=20[ 12.482053][ T1] do_new_mount+0x27d/0x5e0
>=20
>=20[ 12.482178][ T1] path_mount+0x271/0x14f0
>=20
>=20[ 12.482303][ T1] init_mount+0x9d/0xf0
>=20
>=20[ 12.482397][ T1] do_mount_root+0xbc/0x330
>=20
>=20[ 12.482523][ T1] mount_root_generic+0x22c/0x470
>=20
>=20[ 12.482649][ T1] prepare_namespace+0xa5/0x2d0
>=20
>=20[ 12.482779][ T1] kernel_init+0x20/0x200
>=20
>=20[ 12.482876][ T1] ret_from_fork+0x31/0x70
>=20
>=20[ 12.483002][ T1] ret_from_fork_asm+0x1a/0x30
>=20
>=20[ 12.483128][ T1]=20
>=20
> [ 12.483191][ T1] Freed by task 1:
>=20
>=20[ 12.483283][ T1] kasan_save_stack+0x24/0x50
>=20
>=20[ 12.483409][ T1] kasan_save_track+0x14/0x30
>=20
>=20[ 12.483535][ T1] kasan_save_free_info+0x3b/0x60
>=20
>=20[ 12.483662][ T1] __kasan_slab_free+0xf4/0x180
>=20
>=20[ 12.483788][ T1] kfree+0xd3/0x230
>=20
>=20[ 12.483886][ T1] v9fs_fid_iget_dotl+0x15e/0x210
>=20
>=20[ 12.484017][ T1] v9fs_mount+0x3fe/0x7d0
>=20
>=20[ 12.484112][ T1] legacy_get_tree+0x107/0x200
>=20
>=20[ 12.484238][ T1] vfs_get_tree+0x8a/0x2e0
>=20
>=20[ 12.484365][ T1] do_new_mount+0x27d/0x5e0
>=20
>=20[ 12.484492][ T1] path_mount+0x271/0x14f0
>=20
>=20[ 12.484619][ T1] init_mount+0x9d/0xf0
>=20
>=20[ 12.484713][ T1] do_mount_root+0xbc/0x330
>=20
>=20[ 12.484846][ T1] mount_root_generic+0x22c/0x470
>=20
>=20[ 12.484974][ T1] prepare_namespace+0xa5/0x2d0
>=20
>=20[ 12.485100][ T1] kernel_init+0x20/0x200
>=20
>=20[ 12.485196][ T1] ret_from_fork+0x31/0x70
>=20
>=20[ 12.485324][ T1] ret_from_fork_asm+0x1a/0x30
>=20
>=20[ 12.485449][ T1]=20
>=20
> [ 12.485512][ T1] The buggy address belongs to the object at ffff888002=
bdbad8
>=20
>=20[ 12.485512][ T1] which belongs to the cache kmalloc-192 of size 192
>=20
>=20[ 12.485825][ T1] The buggy address is located 0 bytes inside of
>=20
>=20[ 12.485825][ T1] freed 192-byte region [ffff888002bdbad8, ffff888002=
bdbb98)
>=20
>=20[ 12.486131][ T1]=20
>=20
> [ 12.486194][ T1] The buggy address belongs to the physical page:
>=20
>=20[ 12.486347][ T1] page: refcount:1 mapcount:0 mapping:000000000000000=
0 index:0xffff888002bdbc10 pfn:0x2bda
>=20
>=20[ 12.486600][ T1] head: order:1 entire_mapcount:0 nr_pages_mapped:0 p=
incount:0
>=20
>=20[ 12.486795][ T1] flags: 0x80000000000a40(workingset|slab|head|node=
=3D0|zone=3D1)
>=20
>=20[ 12.486989][ T1] page_type: 0xffffffff()
>=20
>=20[ 12.487088][ T1] raw: 0080000000000a40 ffff888001042c40 ffff88800104=
0a88 ffff888001040a88
>=20
>=20[ 12.487315][ T1] raw: ffff888002bdbc10 00000000001a0017 00000001ffff=
ffff 0000000000000000
>=20
>=20[ 12.487538][ T1] head: 0080000000000a40 ffff888001042c40 ffff8880010=
40a88 ffff888001040a88
>=20
>=20[ 12.487765][ T1] head: ffff888002bdbc10 00000000001a0017 00000001fff=
fffff 0000000000000000
>=20
>=20[ 12.487992][ T1] head: 0080000000000001 ffffea00000af681 dead0000000=
00122 00000000ffffffff
>=20
>=20[ 12.488213][ T1] head: 0000000200000000 0000000000000000 00000000fff=
fffff 0000000000000000
>=20
>=20[ 12.488436][ T1] page dumped because: kasan: bad access detected
>=20
>=20[ 12.488590][ T1]=20
>=20
> [ 12.488653][ T1] Memory state around the buggy address:
>=20
>=20[ 12.488797][ T1] ffff888002bdb980: fc fc fc fc 00 00 00 00 00 00 00 =
00 00 00 00 00
>=20
>=20[ 12.488986][ T1] ffff888002bdba00: 00 00 00 00 00 00 00 00 00 00 fc =
fc fc fc fc fc
>=20
>=20[ 12.489168][ T1] >ffff888002bdba80: fc fc fc fc fc fc fc fc fc fc fc=
 fa fb fb fb fb
>=20
>=20[ 12.489353][ T1] ^
>=20
>=20[ 12.489506][ T1] ffff888002bdbb00: fb fb fb fb fb fb fb fb fb fb fb =
fb fb fb fb fb
>=20
>=20[ 12.489688][ T1] ffff888002bdbb80: fb fb fb fc fc fc fc fc fc fc fc =
fc fc fc fc fc
>=20
>=20[ 12.489873][ T1] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
>

