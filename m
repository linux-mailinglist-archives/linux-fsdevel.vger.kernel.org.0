Return-Path: <linux-fsdevel+bounces-34697-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70CDA9C7C25
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 20:30:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 215491F22CBB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 19:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B2A205AD0;
	Wed, 13 Nov 2024 19:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NNREe3i1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590C71FF605;
	Wed, 13 Nov 2024 19:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731526209; cv=none; b=BWR1P5l2N+Q44/4tmp9+b2AWXoQ/5AuirFvaZnDr1VnkDLcBlSqvlyK1wCpaZ5VkQ2CNc7yXrB2ThOI+6Z/6EeJZFSNaxBB1H4iJxN/IVNxoGUujrs621dImCB8ZB+aqABssDOF9Z88Pza7mKyJPe/ovEtxj7LJfnvPI5koldO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731526209; c=relaxed/simple;
	bh=REzJ/8eBcWZbPXa8/oIiWueasRT0yrE++fHYGSWs8iU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=su+yCfBFqvSDi/bOBbi1EgDluQncXQ/WbqQzLSBH1Dnad3iPENX/FOrZqTcXDtvafsX90KNI4S1kqNthbEm90aTWusqmAipjH+rH+W5xg5HdPHqDtOteKmXpoYJ8krTgg8ImPZ5kAju3lC7T5Z4xQSkuF8/4aw05+KF1rmHd4W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NNREe3i1; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731526207; x=1763062207;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=REzJ/8eBcWZbPXa8/oIiWueasRT0yrE++fHYGSWs8iU=;
  b=NNREe3i1qW5+xX1kgpjzQWizwmHccxzRq+ImAQSKT+CJHJzdhcGLzAMw
   89KjiMZaxCTnHV3/o6t4mXO5nlsyGUjNBvMXAfZWfo3zgpKdSfj0pMUqA
   21gjZDaqLhvcRfD1lSropFo29jCLO71VEtbz42c1EdwslOn1fmna9abBC
   wJheFb5cjw3dpk7yHoRgPp/ENpya93VkHsGjnOiHyLAASgNYwWfJk98oc
   /C589ZAL0Xmm2/5CdYEdgFi3hxSFO+4UR9QYlNeNmP9Fu0vN+jWThbwq0
   ZI1+Qub0Com6ay0HSZjR88YpffIbnEUhBJ8pFccRppuiNeUbOvyI8vQfK
   Q==;
X-CSE-ConnectionGUID: gzBPEwL3TkyFNQHdIiQ+0Q==
X-CSE-MsgGUID: v3X/EGlVSlGHKF6FcddQdA==
X-IronPort-AV: E=McAfee;i="6700,10204,11254"; a="35366612"
X-IronPort-AV: E=Sophos;i="6.12,151,1728975600"; 
   d="scan'208";a="35366612"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 11:30:04 -0800
X-CSE-ConnectionGUID: yywvZqwJRGeoFVwR09mL3A==
X-CSE-MsgGUID: HVkGbFr7QtCm89g/fHVLwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,151,1728975600"; 
   d="scan'208";a="92442738"
Received: from gargmani-mobl1.amr.corp.intel.com (HELO vcostago-mobl3) ([10.124.220.223])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 11:30:04 -0800
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Amir Goldstein <amir73il@gmail.com>, brauner@kernel.org, miklos@szeredi.hu
Cc: hu1.chen@intel.com, malini.bhandaru@intel.com, tim.c.chen@intel.com,
 mikko.ylinen@intel.com, linux-unionfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/4] ovl: Optimize override/revert creds
In-Reply-To: <CAOQ4uxgHwmAa4K3ca7i1G2gFQ1WBge855R19hgEk7BNy+EBqfg@mail.gmail.com>
References: <20241107005720.901335-1-vinicius.gomes@intel.com>
 <20241107005720.901335-5-vinicius.gomes@intel.com>
 <CAOQ4uxgHwmAa4K3ca7i1G2gFQ1WBge855R19hgEk7BNy+EBqfg@mail.gmail.com>
Date: Wed, 13 Nov 2024 11:30:03 -0800
Message-ID: <87ldxnrkxw.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Amir Goldstein <amir73il@gmail.com> writes:

> On Thu, Nov 7, 2024 at 1:57=E2=80=AFAM Vinicius Costa Gomes
> <vinicius.gomes@intel.com> wrote:

[...]

>
> Vinicius,
>
> While testing fanotify with LTP tests (some are using overlayfs),
> kmemleak consistently reports the problems below.
>
> Can you see the bug, because I don't see it.
> Maybe it is a false positive...

Hm, if the leak wasn't there before and we didn't touch anything related to
prepare_creds(), I think that points to the leak being real.

But I see your point, still not seeing it.

This code should be equivalent to the code we have now (just boot
tested):

----
diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 136a2c7fb9e5..7ebc2fd3097a 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -576,8 +576,7 @@ static int ovl_setup_cred_for_create(struct dentry *den=
try, struct inode *inode,
         * We must be called with creator creds already, otherwise we risk
         * leaking creds.
         */
-       WARN_ON_ONCE(override_creds(override_cred) !=3D ovl_creds(dentry->d=
_sb));
-       put_cred(override_cred);
+       WARN_ON_ONCE(override_creds_light(override_cred) !=3D ovl_creds(den=
try->d_sb));

        return 0;
 }
----

Does it change anything? (I wouldn't think so, just to try something)

>
> Christian, Miklos,
>
> Can you see a problem?
>
> Thanks,
> Amir.
>
>
> unreferenced object 0xffff888008ad8240 (size 192):
>   comm "fanotify06", pid 1803, jiffies 4294890084
>   hex dump (first 32 bytes):
>     01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace (crc ee6a93ea):
>     [<00000000ab4340a4>] __create_object+0x22/0x83
>     [<0000000053dcaf3b>] kmem_cache_alloc_noprof+0x156/0x1e6
>     [<00000000b4a08c1d>] prepare_creds+0x1d/0xf9
>     [<00000000c55dfb6c>] ovl_setup_cred_for_create+0x27/0x93
>     [<00000000f82af4ee>] ovl_create_or_link+0x73/0x1bd
>     [<0000000040a439db>] ovl_create_object+0xda/0x11d
>     [<00000000fbbadf17>] lookup_open.isra.0+0x3a0/0x3ff
>     [<0000000007a2faf0>] open_last_lookups+0x160/0x223
>     [<00000000e7d8243a>] path_openat+0x136/0x1b5
>     [<0000000004e51585>] do_filp_open+0x57/0xb8
>     [<0000000053871b92>] do_sys_openat2+0x6f/0xc0
>     [<000000004d76b8b7>] do_sys_open+0x3f/0x60
>     [<000000009b0be238>] do_syscall_64+0x96/0xf8
>     [<000000006ff466ad>] entry_SYSCALL_64_after_hwframe+0x76/0x7e


Cheers,
--=20
Vinicius

