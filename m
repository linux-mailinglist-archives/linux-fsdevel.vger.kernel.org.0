Return-Path: <linux-fsdevel+bounces-57013-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC7EB1DCC4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 19:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB2707B1254
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 17:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107FD20766E;
	Thu,  7 Aug 2025 17:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="URmA9Lod"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F047920296A;
	Thu,  7 Aug 2025 17:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754589447; cv=none; b=lUhghSL+5XGVvymWAT1uUD1v1TQHXmO/t6CJ3/x1hOy4BGMhsT5yg2OQyTwBaJ/ytkc6N1MRNolPz54dh6YaNNPkw4oOtRFeCHzX3SPPffWLOwXlbAIf/sqcU/WKUuCc02dwk9pvtOqMyySK5Qz3jhVAQVfDUZRrJM+cpmOUdwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754589447; c=relaxed/simple;
	bh=pOZZXT5rTgutTEntQztiRRZTkdRwZnmAz5Y8JgWOcIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lem211f4WnpBJf4PPIuVuJivOnbvH2qUJ1AOw62x5SP6XAlX4xp2MhcSyRC6xHp3o8PgMV8wqrKbDRc5goX/x7IxtnOJbtOfWButx6BMxwe/RgFIyx9RYL75NJXvK2d1DnodhR7upLl2vjTcfei57QdlnqX+0AQLwXHht1yYrf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=URmA9Lod; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4byZcd1xLTz9sJ3;
	Thu,  7 Aug 2025 19:57:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1754589441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yrUBe0WEO5DSriumDMJXDNucOJxI3Vd1UZ4xtm4lGoY=;
	b=URmA9LodLToXsv8i7H+WjudbS9x8xwJp+9haubpv2Hx3iOXwqhgrEY8VaiWcgiiMA1MrNM
	Hatv1UJQNnLtL3H9YzxKbdNlxA00v41D1EOfRGlQuZ/yfeKa8EmHYHiK61Qx0B+YOKRfoR
	SO0sC653hTsfQUTs/3tOhnwm3T2pGmJI4jFYu6f1fLPtiKE23X0d/6zI5hurfoLn0k+42T
	AgzLReiny0zr8HHCJgotQmcfcxz6SUu1P1qLLujs4iJB1ThYLESAjkmO7pn/OtVwQFmiEO
	ACPubMPZJBCfOdiqodgew54uEbQA7qf4H+y1QCBvo+2bPL7Rmb6U6WA727RYZg==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of cyphar@cyphar.com designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=cyphar@cyphar.com
Date: Fri, 8 Aug 2025 03:57:09 +1000
From: Aleksa Sarai <cyphar@cyphar.com>
To: kernel test robot <lkp@intel.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, oe-kbuild-all@lists.linux.dev, 
	David Howells <dhowells@redhat.com>, linux-api@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] vfs: output mount_too_revealing() errors to
 fscontext
Message-ID: <2025-08-07.1754589415-related-cynic-passive-zombies-cute-jaybird-n5AIYt@cyphar.com>
References: <20250806-errorfc-mount-too-revealing-v2-2-534b9b4d45bb@cyphar.com>
 <202508071236.2BTGpdZx-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="i7alrrpfp2omshjq"
Content-Disposition: inline
In-Reply-To: <202508071236.2BTGpdZx-lkp@intel.com>
X-Rspamd-Queue-Id: 4byZcd1xLTz9sJ3


--i7alrrpfp2omshjq
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 2/2] vfs: output mount_too_revealing() errors to
 fscontext
MIME-Version: 1.0

On 2025-08-07, kernel test robot <lkp@intel.com> wrote:
> Hi Aleksa,
>=20
> kernel test robot noticed the following build errors:
>=20
> [auto build test ERROR on 66639db858112bf6b0f76677f7517643d586e575]

This really doesn't seem like a bug in my patch...

> url:    https://github.com/intel-lab-lkp/linux/commits/Aleksa-Sarai/fscon=
text-add-custom-prefix-log-helpers/20250806-141024
> base:   66639db858112bf6b0f76677f7517643d586e575
> patch link:    https://lore.kernel.org/r/20250806-errorfc-mount-too-revea=
ling-v2-2-534b9b4d45bb%40cyphar.com
> patch subject: [PATCH v2 2/2] vfs: output mount_too_revealing() errors to=
 fscontext
> config: riscv-randconfig-002-20250807 (https://download.01.org/0day-ci/ar=
chive/20250807/202508071236.2BTGpdZx-lkp@intel.com/config)
> compiler: riscv32-linux-gcc (GCC) 8.5.0
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20250807/202508071236.2BTGpdZx-lkp@intel.com/reproduce)
>=20
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202508071236.2BTGpdZx-lkp=
@intel.com/
>=20
> All errors (new ones prefixed by >>, old ones prefixed by <<):
>=20
> WARNING: modpost: vmlinux: section mismatch in reference: prp_dup_discard=
_out_of_sequence+0x266 (section: .text.prp_dup_discard_out_of_sequence) -> =
ili9486_spi_driver_exit (section: .exit.text)
> WARNING: modpost: vmlinux: section mismatch in reference: prp_dup_discard=
_out_of_sequence+0x2ae (section: .text.prp_dup_discard_out_of_sequence) -> =
ili9486_spi_driver_exit (section: .exit.text)
> WARNING: modpost: vmlinux: section mismatch in reference: prp_dup_discard=
_out_of_sequence+0x2f2 (section: .text.prp_dup_discard_out_of_sequence) -> =
mi0283qt_spi_driver_exit (section: .exit.text)
> WARNING: modpost: vmlinux: section mismatch in reference: prp_dup_discard=
_out_of_sequence+0x33e (section: .text.prp_dup_discard_out_of_sequence) -> =
mi0283qt_spi_driver_exit (section: .exit.text)
> WARNING: modpost: vmlinux: section mismatch in reference: ida_free+0xa0 (=
section: .text.ida_free) -> .L0  (section: .init.text)
> WARNING: modpost: vmlinux: section mismatch in reference: ida_free+0xba (=
section: .text.ida_free) -> .L0  (section: .init.text)
> WARNING: modpost: vmlinux: section mismatch in reference: ida_free+0xdc (=
section: .text.ida_free) -> devices_init (section: .init.text)
> WARNING: modpost: vmlinux: section mismatch in reference: ida_alloc_range=
+0x4c (section: .text.ida_alloc_range) -> devices_init (section: .init.text)
> WARNING: modpost: vmlinux: section mismatch in reference: ida_alloc_range=
+0x9c (section: .text.ida_alloc_range) -> .L0  (section: .init.text)
> WARNING: modpost: vmlinux: section mismatch in reference: ida_alloc_range=
+0x31a (section: .text.ida_alloc_range) -> devices_init (section: .init.tex=
t)
> WARNING: modpost: vmlinux: section mismatch in reference: kobj_kset_leave=
+0x2 (section: .text.kobj_kset_leave) -> save_async_options (section: .init=
=2Etext)
> WARNING: modpost: vmlinux: section mismatch in reference: __kobject_del+0=
x18 (section: .text.__kobject_del) -> .LVL39 (section: .init.text)
> WARNING: modpost: vmlinux: section mismatch in reference: mas_empty_area_=
rev+0x2aa (section: .text.mas_empty_area_rev) -> classes_init (section: .in=
it.text)
> WARNING: modpost: vmlinux: section mismatch in reference: mas_empty_area_=
rev+0x2ba (section: .text.mas_empty_area_rev) -> classes_init (section: .in=
it.text)
> WARNING: modpost: vmlinux: section mismatch in reference: mas_empty_area_=
rev+0x2c0 (section: .text.mas_empty_area_rev) -> classes_init (section: .in=
it.text)
> WARNING: modpost: vmlinux: section mismatch in reference: mas_empty_area_=
rev+0x2d0 (section: .text.mas_empty_area_rev) -> classes_init (section: .in=
it.text)
> WARNING: modpost: vmlinux: section mismatch in reference: mas_empty_area_=
rev+0x2da (section: .text.mas_empty_area_rev) -> classes_init (section: .in=
it.text)
> WARNING: modpost: vmlinux: section mismatch in reference: mas_empty_area_=
rev+0x2ec (section: .text.mas_empty_area_rev) -> .L0  (section: .init.text)
> WARNING: modpost: vmlinux: section mismatch in reference: mas_empty_area_=
rev+0x2fe (section: .text.mas_empty_area_rev) -> __platform_driver_probe (s=
ection: .init.text)
> WARNING: modpost: vmlinux: section mismatch in reference: mas_empty_area_=
rev+0x314 (section: .text.mas_empty_area_rev) -> __platform_driver_probe (s=
ection: .init.text)
> WARNING: modpost: vmlinux: section mismatch in reference: mas_empty_area_=
rev+0x328 (section: .text.mas_empty_area_rev) -> __platform_driver_probe (s=
ection: .init.text)
> WARNING: modpost: vmlinux: section mismatch in reference: mas_empty_area_=
rev+0x34c (section: .text.mas_empty_area_rev) -> __platform_driver_probe (s=
ection: .init.text)
> WARNING: modpost: vmlinux: section mismatch in reference: mas_empty_area_=
rev+0x398 (section: .text.mas_empty_area_rev) -> __platform_driver_probe (s=
ection: .init.text)
> WARNING: modpost: vmlinux: section mismatch in reference: mas_empty_area_=
rev+0x39e (section: .text.mas_empty_area_rev) -> __platform_driver_probe (s=
ection: .init.text)
> WARNING: modpost: vmlinux: section mismatch in reference: mas_empty_area_=
rev+0x3d4 (section: .text.mas_empty_area_rev) -> classes_init (section: .in=
it.text)
> WARNING: modpost: vmlinux: section mismatch in reference: mas_empty_area_=
rev+0x400 (section: .text.mas_empty_area_rev) -> classes_init (section: .in=
it.text)
> WARNING: modpost: vmlinux: section mismatch in reference: mas_empty_area_=
rev+0x42a (section: .text.mas_empty_area_rev) -> classes_init (section: .in=
it.text)
> WARNING: modpost: vmlinux: section mismatch in reference: mt_dump_node+0x=
230 (section: .text.mt_dump_node) -> classes_init (section: .init.text)
> WARNING: modpost: vmlinux: section mismatch in reference: mt_dump_node+0x=
24a (section: .text.mt_dump_node) -> __platform_driver_probe (section: .ini=
t.text)
> WARNING: modpost: vmlinux: section mismatch in reference: mt_dump+0x20 (s=
ection: .text.mt_dump) -> classes_init (section: .init.text)
> WARNING: modpost: vmlinux: section mismatch in reference: mt_dump+0x32 (s=
ection: .text.mt_dump) -> classes_init (section: .init.text)
> WARNING: modpost: vmlinux: section mismatch in reference: mt_dump+0x42 (s=
ection: .text.mt_dump) -> classes_init (section: .init.text)
> WARNING: modpost: vmlinux: section mismatch in reference: mt_dump+0x4c (s=
ection: .text.mt_dump) -> classes_init (section: .init.text)
> WARNING: modpost: vmlinux: section mismatch in reference: mt_dump+0x56 (s=
ection: .text.mt_dump) -> classes_init (section: .init.text)
> WARNING: modpost: vmlinux: section mismatch in reference: mt_dump+0x7c (s=
ection: .text.mt_dump) -> classes_init (section: .init.text)
> WARNING: modpost: vmlinux: section mismatch in reference: mt_dump+0xd4 (s=
ection: .text.mt_dump) -> __platform_driver_probe (section: .init.text)
> WARNING: modpost: vmlinux: section mismatch in reference: mas_empty_area+=
0x43e (section: .text.mas_empty_area) -> .L0  (section: .init.text)
> WARNING: modpost: vmlinux: section mismatch in reference: mas_empty_area+=
0x454 (section: .text.mas_empty_area) -> .L0  (section: .init.text)
> WARNING: modpost: vmlinux: section mismatch in reference: mas_empty_area+=
0x466 (section: .text.mas_empty_area) -> .L0  (section: .init.text)
> WARNING: modpost: vmlinux: section mismatch in reference: mas_empty_area+=
0x4b2 (section: .text.mas_empty_area) -> platform_bus_init (section: .init.=
text)
> WARNING: modpost: vmlinux: section mismatch in reference: mas_empty_area+=
0x4ba (section: .text.mas_empty_area) -> .L0  (section: .init.text)
> WARNING: modpost: vmlinux: section mismatch in reference: mas_empty_area+=
0x4d2 (section: .text.mas_empty_area) -> .L0  (section: .init.text)
> WARNING: modpost: vmlinux: section mismatch in reference: mas_empty_area+=
0x532 (section: .text.mas_empty_area) -> .L0  (section: .init.text)
> WARNING: modpost: vmlinux: section mismatch in reference: mas_empty_area+=
0x548 (section: .text.mas_empty_area) -> __platform_create_bundle (section:=
 .init.text)
> WARNING: modpost: vmlinux: section mismatch in reference: mas_empty_area+=
0x572 (section: .text.mas_empty_area) -> .L461 (section: .init.text)
> WARNING: modpost: vmlinux: section mismatch in reference: mas_empty_area+=
0x574 (section: .text.mas_empty_area) -> __platform_create_bundle (section:=
 .init.text)
> WARNING: modpost: vmlinux: section mismatch in reference: mas_empty_area+=
0x57a (section: .text.mas_empty_area) -> __platform_create_bundle (section:=
 .init.text)
> WARNING: modpost: vmlinux: section mismatch in reference: mas_empty_area+=
0x592 (section: .text.mas_empty_area) -> .L459 (section: .init.text)
> WARNING: modpost: vmlinux: section mismatch in reference: mas_empty_area+=
0x5de (section: .text.mas_empty_area) -> .L457 (section: .init.text)
> WARNING: modpost: vmlinux: section mismatch in reference: mas_empty_area+=
0x5e4 (section: .text.mas_empty_area) -> .L458 (section: .init.text)
> WARNING: modpost: vmlinux: section mismatch in reference: mas_empty_area+=
0x5f0 (section: .text.mas_empty_area) -> .L0  (section: .init.text)
> WARNING: modpost: vmlinux: section mismatch in reference: mas_root_expand=
+0x84 (section: .text.mas_root_expand) -> .L495 (section: .init.text)
> WARNING: modpost: vmlinux: section mismatch in reference: mas_root_expand=
+0x98 (section: .text.mas_root_expand) -> cpu_dev_init (section: .init.text)
> WARNING: modpost: vmlinux: section mismatch in reference: mas_prev_range+=
0x18 (section: .text.mas_prev_range) -> classes_init (section: .init.text)
> WARNING: modpost: vmlinux: section mismatch in reference: mas_prev+0x18 (=
section: .text.mas_prev) -> classes_init (section: .init.text)
> WARNING: modpost: vmlinux: section mismatch in reference: __rb_insert_aug=
mented+0xc8 (section: .text.__rb_insert_augmented) -> auxiliary_bus_init (s=
ection: .init.text)
> WARNING: modpost: vmlinux: section mismatch in reference: __rb_insert_aug=
mented+0xe8 (section: .text.__rb_insert_augmented) -> auxiliary_bus_init (s=
ection: .init.text)
> WARNING: modpost: vmlinux: section mismatch in reference: __rb_insert_aug=
mented+0xf8 (section: .text.__rb_insert_augmented) -> auxiliary_bus_init (s=
ection: .init.text)
> WARNING: modpost: vmlinux: section mismatch in reference: __rb_insert_aug=
mented+0x102 (section: .text.__rb_insert_augmented) -> auxiliary_bus_init (=
section: .init.text)
> WARNING: modpost: vmlinux: section mismatch in reference: __rb_insert_aug=
mented+0x114 (section: .text.__rb_insert_augmented) -> mount_param (section=
: .init.text)
> WARNING: modpost: vmlinux: section mismatch in reference: rb_first+0x8 (s=
ection: .text.rb_first) -> mount_param (section: .init.text)
> WARNING: modpost: vmlinux: section mismatch in reference: rb_first+0xa (s=
ection: .text.rb_first) -> mount_param (section: .init.text)
> WARNING: modpost: vmlinux: section mismatch in reference: rb_first+0x10 (=
section: .text.rb_first) -> mount_param (section: .init.text)
> WARNING: modpost: vmlinux: section mismatch in reference: rb_last+0x8 (se=
ction: .text.rb_last) -> mount_param (section: .init.text)
> WARNING: modpost: vmlinux: section mismatch in reference: rb_last+0xa (se=
ction: .text.rb_last) -> mount_param (section: .init.text)
> WARNING: modpost: vmlinux: section mismatch in reference: rb_last+0x10 (s=
ection: .text.rb_last) -> mount_param (section: .init.text)
> WARNING: modpost: vmlinux: section mismatch in reference: __rb_erase_colo=
r+0xda (section: .text.__rb_erase_color) -> auxiliary_bus_init (section: .i=
nit.text)
> WARNING: modpost: vmlinux: section mismatch in reference: __rb_erase_colo=
r+0xf8 (section: .text.__rb_erase_color) -> mount_param (section: .init.tex=
t)
> WARNING: modpost: vmlinux: section mismatch in reference: __rb_erase_colo=
r+0x188 (section: .text.__rb_erase_color) -> auxiliary_bus_init (section: .=
init.text)
> WARNING: modpost: vmlinux: section mismatch in reference: 0x15a8 (section=
: __ex_table) -> .LASF2568 (section: .debug_str)
> ERROR: modpost: __ex_table+0x15a8 references non-executable section '.deb=
ug_str'
> WARNING: modpost: vmlinux: section mismatch in reference: 0x15ac (section=
: __ex_table) -> .LASF2570 (section: .debug_str)
> ERROR: modpost: __ex_table+0x15ac references non-executable section '.deb=
ug_str'
> WARNING: modpost: vmlinux: section mismatch in reference: 0x15b4 (section=
: __ex_table) -> .LASF2572 (section: .debug_str)
> ERROR: modpost: __ex_table+0x15b4 references non-executable section '.deb=
ug_str'
> WARNING: modpost: vmlinux: section mismatch in reference: 0x15b8 (section=
: __ex_table) -> .LASF2574 (section: .debug_str)
> ERROR: modpost: __ex_table+0x15b8 references non-executable section '.deb=
ug_str'
> WARNING: modpost: vmlinux: section mismatch in reference: 0x15c0 (section=
: __ex_table) -> .LASF2576 (section: .debug_str)
> ERROR: modpost: __ex_table+0x15c0 references non-executable section '.deb=
ug_str'
> WARNING: modpost: vmlinux: section mismatch in reference: 0x15c4 (section=
: __ex_table) -> .LASF2578 (section: .debug_str)
> ERROR: modpost: __ex_table+0x15c4 references non-executable section '.deb=
ug_str'
> WARNING: modpost: vmlinux: section mismatch in reference: 0x15cc (section=
: __ex_table) -> .LASF2580 (section: .debug_str)
> ERROR: modpost: __ex_table+0x15cc references non-executable section '.deb=
ug_str'
> WARNING: modpost: vmlinux: section mismatch in reference: 0x15d0 (section=
: __ex_table) -> .LASF2574 (section: .debug_str)
> ERROR: modpost: __ex_table+0x15d0 references non-executable section '.deb=
ug_str'
> WARNING: modpost: vmlinux: section mismatch in reference: 0x15d8 (section=
: __ex_table) -> .LASF2583 (section: .debug_str)
> ERROR: modpost: __ex_table+0x15d8 references non-executable section '.deb=
ug_str'
> WARNING: modpost: vmlinux: section mismatch in reference: 0x15dc (section=
: __ex_table) -> .LASF2574 (section: .debug_str)
> ERROR: modpost: __ex_table+0x15dc references non-executable section '.deb=
ug_str'
> WARNING: modpost: vmlinux: section mismatch in reference: 0x15e4 (section=
: __ex_table) -> .LASF2586 (section: .debug_str)
> ERROR: modpost: __ex_table+0x15e4 references non-executable section '.deb=
ug_str'
> WARNING: modpost: vmlinux: section mismatch in reference: 0x15e8 (section=
: __ex_table) -> .LASF2588 (section: .debug_str)
> ERROR: modpost: __ex_table+0x15e8 references non-executable section '.deb=
ug_str'
> WARNING: modpost: vmlinux: section mismatch in reference: 0x15f0 (section=
: __ex_table) -> .L0  (section: __ex_table)
> ERROR: modpost: __ex_table+0x15f0 references non-executable section '__ex=
_table'
> WARNING: modpost: vmlinux: section mismatch in reference: 0x15f4 (section=
: __ex_table) -> .L0  (section: __ex_table)
> ERROR: modpost: __ex_table+0x15f4 references non-executable section '__ex=
_table'
> WARNING: modpost: vmlinux: section mismatch in reference: 0x15fc (section=
: __ex_table) -> .L0  (section: __ex_table)
> ERROR: modpost: __ex_table+0x15fc references non-executable section '__ex=
_table'
> WARNING: modpost: vmlinux: section mismatch in reference: 0x1600 (section=
: __ex_table) -> firsttime (section: .data.firsttime.60983)
> >> ERROR: modpost: __ex_table+0x1600 references non-executable section '.=
data.firsttime.60983'
> WARNING: modpost: vmlinux: section mismatch in reference: 0x1614 (section=
: __ex_table) -> .LASF230 (section: .debug_str)
> ERROR: modpost: __ex_table+0x1614 references non-executable section '.deb=
ug_str'
> WARNING: modpost: vmlinux: section mismatch in reference: 0x1618 (section=
: __ex_table) -> .LASF232 (section: .debug_str)
> ERROR: modpost: __ex_table+0x1618 references non-executable section '.deb=
ug_str'
> WARNING: modpost: vmlinux: section mismatch in reference: 0x1620 (section=
: __ex_table) -> .LASF234 (section: .debug_str)
> ERROR: modpost: __ex_table+0x1620 references non-executable section '.deb=
ug_str'
> WARNING: modpost: vmlinux: section mismatch in reference: 0x1624 (section=
: __ex_table) -> .LASF232 (section: .debug_str)
> ERROR: modpost: __ex_table+0x1624 references non-executable section '.deb=
ug_str'
> WARNING: modpost: vmlinux: section mismatch in reference: 0x162c (section=
: __ex_table) -> .LASF237 (section: .debug_str)
> ERROR: modpost: __ex_table+0x162c references non-executable section '.deb=
ug_str'
> WARNING: modpost: vmlinux: section mismatch in reference: 0x1630 (section=
: __ex_table) -> .LASF232 (section: .debug_str)
> ERROR: modpost: __ex_table+0x1630 references non-executable section '.deb=
ug_str'
> WARNING: modpost: vmlinux: section mismatch in reference: 0x1638 (section=
: __ex_table) -> .LASF240 (section: .debug_str)
> ERROR: modpost: __ex_table+0x1638 references non-executable section '.deb=
ug_str'
> WARNING: modpost: vmlinux: section mismatch in reference: 0x163c (section=
: __ex_table) -> .LASF232 (section: .debug_str)
> ERROR: modpost: __ex_table+0x163c references non-executable section '.deb=
ug_str'
> WARNING: modpost: vmlinux: section mismatch in reference: 0x1644 (section=
: __ex_table) -> .LASF243 (section: .debug_str)
> ERROR: modpost: __ex_table+0x1644 references non-executable section '.deb=
ug_str'
> WARNING: modpost: vmlinux: section mismatch in reference: 0x1648 (section=
: __ex_table) -> .LASF232 (section: .debug_str)
> ERROR: modpost: __ex_table+0x1648 references non-executable section '.deb=
ug_str'
> WARNING: modpost: vmlinux: section mismatch in reference: 0x1650 (section=
: __ex_table) -> .LASF246 (section: .debug_str)
> ERROR: modpost: __ex_table+0x1650 references non-executable section '.deb=
ug_str'
> WARNING: modpost: vmlinux: section mismatch in reference: 0x1654 (section=
: __ex_table) -> .LASF232 (section: .debug_str)
> ERROR: modpost: __ex_table+0x1654 references non-executable section '.deb=
ug_str'
> WARNING: modpost: vmlinux: section mismatch in reference: 0x165c (section=
: __ex_table) -> .LASF249 (section: .debug_str)
> ERROR: modpost: __ex_table+0x165c references non-executable section '.deb=
ug_str'
> WARNING: modpost: vmlinux: section mismatch in reference: 0x1660 (section=
: __ex_table) -> .LASF251 (section: .debug_str)
> ERROR: modpost: __ex_table+0x1660 references non-executable section '.deb=
ug_str'
> WARNING: modpost: vmlinux: section mismatch in reference: 0x1668 (section=
: __ex_table) -> .LASF253 (section: .debug_str)
> ERROR: modpost: __ex_table+0x1668 references non-executable section '.deb=
ug_str'
> WARNING: modpost: vmlinux: section mismatch in reference: 0x166c (section=
: __ex_table) -> .LASF255 (section: .debug_str)
> ERROR: modpost: __ex_table+0x166c references non-executable section '.deb=
ug_str'
> WARNING: modpost: vmlinux: section mismatch in reference: 0x1674 (section=
: __ex_table) -> .LASF257 (section: .debug_str)
> ERROR: modpost: __ex_table+0x1674 references non-executable section '.deb=
ug_str'
> WARNING: modpost: vmlinux: section mismatch in reference: 0x1678 (section=
: __ex_table) -> .LASF259 (section: .debug_str)
> ERROR: modpost: __ex_table+0x1678 references non-executable section '.deb=
ug_str'
> WARNING: modpost: vmlinux: section mismatch in reference: 0x1680 (section=
: __ex_table) -> .LASF261 (section: .debug_str)
> ERROR: modpost: __ex_table+0x1680 references non-executable section '.deb=
ug_str'
> WARNING: modpost: vmlinux: section mismatch in reference: 0x1684 (section=
: __ex_table) -> .LASF263 (section: .debug_str)
> ERROR: modpost: __ex_table+0x1684 references non-executable section '.deb=
ug_str'
> WARNING: modpost: vmlinux: section mismatch in reference: 0x168c (section=
: __ex_table) -> .LASF265 (section: .debug_str)
> ERROR: modpost: __ex_table+0x168c references non-executable section '.deb=
ug_str'
> WARNING: modpost: vmlinux: section mismatch in reference: 0x1690 (section=
: __ex_table) -> .LASF267 (section: .debug_str)
> ERROR: modpost: __ex_table+0x1690 references non-executable section '.deb=
ug_str'
> WARNING: modpost: vmlinux: section mismatch in reference: 0x1698 (section=
: __ex_table) -> .LASF269 (section: .debug_str)
> ERROR: modpost: __ex_table+0x1698 references non-executable section '.deb=
ug_str'
> WARNING: modpost: vmlinux: section mismatch in reference: 0x169c (section=
: __ex_table) -> .LASF271 (section: .debug_str)
> ERROR: modpost: __ex_table+0x169c references non-executable section '.deb=
ug_str'
> WARNING: modpost: vmlinux: section mismatch in reference: 0x16a4 (section=
: __ex_table) -> .LASF273 (section: .debug_str)
> ERROR: modpost: __ex_table+0x16a4 references non-executable section '.deb=
ug_str'
> WARNING: modpost: vmlinux: section mismatch in reference: 0x16a8 (section=
: __ex_table) -> .LASF275 (section: .debug_str)
> ERROR: modpost: __ex_table+0x16a8 references non-executable section '.deb=
ug_str'
> WARNING: modpost: vmlinux: section mismatch in reference: 0x16b0 (section=
: __ex_table) -> .LASF277 (section: .debug_str)
> ERROR: modpost: __ex_table+0x16b0 references non-executable section '.deb=
ug_str'
> WARNING: modpost: vmlinux: section mismatch in reference: 0x16b4 (section=
: __ex_table) -> .LASF279 (section: .debug_str)
> ERROR: modpost: __ex_table+0x16b4 references non-executable section '.deb=
ug_str'
> WARNING: modpost: vmlinux: section mismatch in reference: 0x16bc (section=
: __ex_table) -> .LASF281 (section: .debug_str)
> ERROR: modpost: __ex_table+0x16bc references non-executable section '.deb=
ug_str'
> WARNING: modpost: vmlinux: section mismatch in reference: 0x16c0 (section=
: __ex_table) -> .LASF283 (section: .debug_str)
> ERROR: modpost: __ex_table+0x16c0 references non-executable section '.deb=
ug_str'
> WARNING: modpost: vmlinux: section mismatch in reference: 0x16c8 (section=
: __ex_table) -> .LASF285 (section: .debug_str)
> ERROR: modpost: __ex_table+0x16c8 references non-executable section '.deb=
ug_str'
> WARNING: modpost: vmlinux: section mismatch in reference: 0x16cc (section=
: __ex_table) -> .LASF287 (section: .debug_str)
> ERROR: modpost: __ex_table+0x16cc references non-executable section '.deb=
ug_str'
> WARNING: modpost: vmlinux: section mismatch in reference: 0x16d4 (section=
: __ex_table) -> .LASF289 (section: .debug_str)
> ERROR: modpost: __ex_table+0x16d4 references non-executable section '.deb=
ug_str'
> WARNING: modpost: vmlinux: section mismatch in reference: 0x16d8 (section=
: __ex_table) -> .LASF291 (section: .debug_str)
> ERROR: modpost: __ex_table+0x16d8 references non-executable section '.deb=
ug_str'
> WARNING: modpost: vmlinux: section mismatch in reference: 0x16e4 (section=
: __ex_table) -> .LASF4984 (section: .debug_str)
> ERROR: modpost: __ex_table+0x16e4 references non-executable section '.deb=
ug_str'
> WARNING: modpost: vmlinux: section mismatch in reference: 0x16ec (section=
: __ex_table) -> .LASF4986 (section: .debug_str)
> ERROR: modpost: __ex_table+0x16ec references non-executable section '.deb=
ug_str'
> WARNING: modpost: vmlinux: section mismatch in reference: 0x16f0 (section=
: __ex_table) -> .LASF4984 (section: .debug_str)
> ERROR: modpost: __ex_table+0x16f0 references non-executable section '.deb=
ug_str'
> WARNING: modpost: vmlinux: section mismatch in reference: 0x16fc (section=
: __ex_table) -> .LASF4984 (section: .debug_str)
> ERROR: modpost: __ex_table+0x16fc references non-executable section '.deb=
ug_str'
> WARNING: modpost: vmlinux: section mismatch in reference: 0x1704 (section=
: __ex_table) -> .LLST20 (section: .debug_loc)
> ERROR: modpost: __ex_table+0x1704 references non-executable section '.deb=
ug_loc'
> WARNING: modpost: vmlinux: section mismatch in reference: 0x1708 (section=
: __ex_table) -> .LLST22 (section: .debug_loc)
> ERROR: modpost: __ex_table+0x1708 references non-executable section '.deb=
ug_loc'
> WARNING: modpost: vmlinux: section mismatch in reference: 0x1710 (section=
: __ex_table) -> .LLST23 (section: .debug_loc)
> ERROR: modpost: __ex_table+0x1710 references non-executable section '.deb=
ug_loc'
> WARNING: modpost: vmlinux: section mismatch in reference: 0x1714 (section=
: __ex_table) -> .LASF4984 (section: .debug_str)
> ERROR: modpost: __ex_table+0x1714 references non-executable section '.deb=
ug_str'
> WARNING: modpost: vmlinux: section mismatch in reference: 0x171c (section=
: __ex_table) -> .LASF270 (section: .debug_str)
> ERROR: modpost: __ex_table+0x171c references non-executable section '.deb=
ug_str'
> WARNING: modpost: vmlinux: section mismatch in reference: 0x1720 (section=
: __ex_table) -> .LASF272 (section: .debug_str)
> ERROR: modpost: __ex_table+0x1720 references non-executable section '.deb=
ug_str'
> WARNING: modpost: vmlinux: section mismatch in reference: 0x174c (section=
: __ex_table) -> .LASF1801 (section: .debug_str)
> ERROR: modpost: __ex_table+0x174c references non-executable section '.deb=
ug_str'
> WARNING: modpost: vmlinux: section mismatch in reference: 0x1750 (section=
: __ex_table) -> .LASF1803 (section: .debug_str)
> ERROR: modpost: __ex_table+0x1750 references non-executable section '.deb=
ug_str'
> WARNING: modpost: vmlinux: section mismatch in reference: 0x1758 (section=
: __ex_table) -> .LASF1805 (section: .debug_str)
> ERROR: modpost: __ex_table+0x1758 references non-executable section '.deb=
ug_str'
> WARNING: modpost: vmlinux: section mismatch in reference: 0x175c (section=
: __ex_table) -> .LASF1807 (section: .debug_str)
> ERROR: modpost: __ex_table+0x175c references non-executable section '.deb=
ug_str'
> WARNING: modpost: vmlinux: section mismatch in reference: 0x1764 (section=
: __ex_table) -> .LASF1809 (section: .debug_str)
> ERROR: modpost: __ex_table+0x1764 references non-executable section '.deb=
ug_str'
> WARNING: modpost: vmlinux: section mismatch in reference: 0x1768 (section=
: __ex_table) -> .LASF1807 (section: .debug_str)
> ERROR: modpost: __ex_table+0x1768 references non-executable section '.deb=
ug_str'
>=20
> --=20
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
https://www.cyphar.com/

--i7alrrpfp2omshjq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCaJTo9QAKCRAol/rSt+lE
bwgqAQCVC0v5FxkBe+2jPEBwZRlXTlmuI1ArctBWqwC0t43k9AD/ejC34nCU5gan
+bftxr8fFpH4ohkjk5a/O0JF4JhwowA=
=F8iA
-----END PGP SIGNATURE-----

--i7alrrpfp2omshjq--

