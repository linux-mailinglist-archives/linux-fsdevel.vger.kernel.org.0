Return-Path: <linux-fsdevel+bounces-30001-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 178FD984C9B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 23:13:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97AB41F249B8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 21:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A60C13D296;
	Tue, 24 Sep 2024 21:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B53A4ngf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761827F460;
	Tue, 24 Sep 2024 21:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727212429; cv=none; b=K0nNXsLWxGASdwP5EdHgD0MlRbfRTpnuYKu+A6xO12fPpZFst5sGAx8G7FUf6v/0f1JVQy2ABBmym/es9fSZ/ocGbueVB4hkkVsOUA1OSSbCa4UXwiNSY7TeUVR1xSGkDLEgq1d9ubiJjRfqL9fUPBzc2/F+lNPurIVaYGaZ00k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727212429; c=relaxed/simple;
	bh=Pgo8TG6M4lhbu67myeMwVxKQyK9zLxeOQB60zE8nQlw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HvVdXrW5/5XqX44uePyvxTtsFSWtcI5Dtmcx1jrUwkJerb27UU2eMTFTxUWdmZ1vIqiXyK5qDroB05m1MIQJWtEXIPewFkdiTYNPfYAIoGlpHYdhwut4Agqo3knj5ejoYUe4Vjv9kJRIbwyAijBUPIb3aySu00T4Gi7B6Xz46i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B53A4ngf; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727212428; x=1758748428;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=Pgo8TG6M4lhbu67myeMwVxKQyK9zLxeOQB60zE8nQlw=;
  b=B53A4ngfSrdAQ8yb7djfG8sLXJ4UxPXmQHALRae8jsd0r30ryCBXZBTU
   EcKmXCRHxePi+/nCXxr2RNqEs8CZ8clZgORhU9T6iEiP9JrcbstKEDjSy
   HJD324GRGjiARsWxB3+1EkDolsKk/1W1YJivad3gUMJLRFVw0V/TRJD9W
   kYPlYSiUa3K+uxW/85hESizD94z9kCLtjnRhJGH73ia2QCP9ZKAUEocHY
   xd5U9utf45cdDw9K5G0SZFK5fT3tKVBrC48po/g1iLmoOUis/xOMs3kUd
   mH9CnVoDyfUZwGjAylR3nc82xfnyBa0vUkzjpgYiWNB9uvLWM215PUUvc
   w==;
X-CSE-ConnectionGUID: 9cDnKMtKQgOfhO/MPiCQPA==
X-CSE-MsgGUID: P4SMd1VQR82UdG5+J9D1gg==
X-IronPort-AV: E=McAfee;i="6700,10204,11205"; a="25709390"
X-IronPort-AV: E=Sophos;i="6.10,255,1719903600"; 
   d="scan'208";a="25709390"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 14:13:46 -0700
X-CSE-ConnectionGUID: pmPTL3QCR5aBWiIdWzftPg==
X-CSE-MsgGUID: CFjmXJLOTA6UB8bV1P4s5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,255,1719903600"; 
   d="scan'208";a="76306329"
Received: from philliph-desk.amr.corp.intel.com (HELO vcostago-mobl3) ([10.124.221.65])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 14:13:43 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: brauner@kernel.org, amir73il@gmail.com, hu1.chen@intel.com,
 malini.bhandaru@intel.com, tim.c.chen@intel.com, mikko.ylinen@intel.com,
 lizhen.you@intel.com, linux-unionfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/16] overlayfs: Document critical override_creds()
 operations
In-Reply-To: <87wmk2lx3s.fsf@intel.com>
References: <20240822012523.141846-1-vinicius.gomes@intel.com>
 <20240822012523.141846-5-vinicius.gomes@intel.com>
 <CAJfpegvx2nyVpp4kHaxt=VwBb3U4=7GM-pjW_8bu+fm_N8diHQ@mail.gmail.com>
 <87wmk2lx3s.fsf@intel.com>
Date: Tue, 24 Sep 2024 18:13:39 -0300
Message-ID: <87h6a43gcc.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Vinicius Costa Gomes <vinicius.gomes@intel.com> writes:

> Miklos Szeredi <miklos@szeredi.hu> writes:
>
>> On Thu, 22 Aug 2024 at 03:25, Vinicius Costa Gomes
>> <vinicius.gomes@intel.com> wrote:
>>>
>>> Add a comment to these operations that cannot use the _light version
>>> of override_creds()/revert_creds(), because during the critical
>>> section the struct cred .usage counter might be modified.
>>
>> Why is it a problem if the usage counter is modified?  Why is the
>> counter modified in each of these cases?
>>
>
> Working on getting some logs from the crash that I get when I convert
> the remaining cases to use the _light() functions.
>

See the log below.

> Perhaps I was wrong on my interpretation of the crash.
>

What I am seeing is that ovl_setup_cred_for_create() has a "side
effect", it creates another set of credentials, runs the security hooks
with this new credentials, and the side effect is that when it returns,
by design, 'current->cred' is this new credentials (a third set of
credentials).

And this implies that refcounting for this is somewhat tricky, as said
in commit d0e13f5bbe4b ("ovl: fix uid/gid when creating over whiteout").

I see two ways forward:

1. Keep using the non _light() versions in functions that call
   ovl_setup_cred_for_create().
2. Change ovl_setup_cred_for_create() so it doesn't drop the "extra"
   refcount.

I went with (1), and it still sounds to me like the best way, but I
agree that my explanation was not good enough, will add the information
I just learned to the commit message and to the code.

Do you see another way forward? Or do you think that I should go with
(2)?

> Thanks for raising this, I should have added more information about this.
>
>
> Cheers,
> -- 
> Vinicius

[    4.646955] [touch 1512] commit_creds(0000000009e62474{1})
[    4.648637] [touch 1512] __put_cred(00000000200a9944{0})
[    4.648844] [virtm 1502] prepare_creds() alloc 0000000050563530
[    4.651631] [virtm 1513] prepare_creds() alloc 00000000da716e80
[    4.652515] [mktem 1513] commit_creds(00000000da716e80{1})
[    4.654056] ovl_create_or_link: [override] cred 0000000007112f42
[    4.654108] ovl_override_creds_light: new cred 0000000007112f42{1}
[    4.654155] ovl_override_creds_light: old cred 00000000da716e80{3}
[    4.654199] [mktem 1513] prepare_creds() alloc 000000003c8d17b7
[    4.654246] [mktem 1513] override_creds(000000003c8d17b7{1})
[    4.654292] [mktem 1513] override_creds() = 0000000007112f42{1}
[    4.654337] [mktem 1513] __put_cred(0000000007112f42{0})
[    4.654388] [mktem 1513] __put_cred(0000000007112f42{0})
[    4.654431] ------------[ cut here ]------------
[    4.654470] ODEBUG: activate active (active state 1) object: 00000000ad88840d object type: rcu_head hint: 0x0
[    4.654484] [swapp    0] exit_creds(1507,00000000efafcffd,00000000efafcffd,{2})
[    4.654575] WARNING: CPU: 23 PID: 1513 at lib/debugobjects.c:515 debug_print_object+0x7d/0xb0
[    4.654596] [swapp    0] __put_cred(00000000efafcffd{0})
[    4.654674] Modules linked in: sha512_ssse3(E) isst_if_common(E-) crct10dif_pclmul(E) sha256_ssse3(E) skx_edac_common(E) nfit(E) virtio_net(E) net_failover(E) i2c_piix4(E) input_leds(E) psmouse(E) serio_raw(E) failover(E) i2c_smbus(E) pata_acpi(E) floppy(E) qemu_fw_cfg(E) mac_hid(E) overlay(E) 9pnet_virtio(E) virtiofs(E) 9p(E) 9pnet(E) netfs(E)
[    4.654686] CPU: 23 UID: 0 PID: 1513 Comm: mktemp Tainted: G            E      6.11.0-rc5+ #4
[    4.654689] Tainted: [E]=UNSIGNED_MODULE
[    4.654689] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
[    4.654690] RIP: 0010:debug_print_object+0x7d/0xb0
[    4.654692] Code: 01 8b 4b 14 48 c7 c7 d8 ce 3a 99 89 15 ec 53 77 02 8b 53 10 50 4c 8b 4d 00 48 8b 14 d5 80 32 e8 98 4c 8b 43 18 e8 73 fb a0 ff <0f> 0b 58 83 05 dd 35 c6 01 01 48 83 c4 08 5b 5d c3 cc cc cc cc 83
[    4.654693] RSP: 0018:ff5fa086c391bd28 EFLAGS: 00010282
[    4.654695] RAX: 0000000000000000 RBX: ff5fa086c391bd60 RCX: 0000000000140017
[    4.654696] RDX: 0000000000000001 RSI: 0000000000000000 RDI: 0000000000000001
[    4.654697] RBP: ffffffff98e28c40 R08: 0000000000000000 R09: ff4deb8a8531a0a8
[    4.654697] R10: 0000000000000000 R11: 0000000000000001 R12: ff4deb8a87d29de8
[    4.654698] R13: ffffffff98e28c40 R14: 0000000000000202 R15: ffffffff9aa64e58
[    4.654699] FS:  00007ff8543af740(0000) GS:ff4deb8ab8580000(0000) knlGS:0000000000000000
[    4.654700] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    4.654701] CR2: 00007ff8540ec040 CR3: 0000000005784002 CR4: 0000000000771ef0
[    4.654704] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    4.654705] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
[    4.654706] PKRU: 55555554
[    4.654707] Call Trace:
[    4.654709]  <TASK>
[    4.654710]  ? __warn+0x83/0x130
[    4.654725]  ? debug_print_object+0x7d/0xb0
[    4.654726]  ? report_bug+0x18e/0x1a0
[    4.654773] [swapp    0] exit_creds(1508,00000000b957e777,00000000b957e777,{2})


Cheers,
-- 
Vinicius

