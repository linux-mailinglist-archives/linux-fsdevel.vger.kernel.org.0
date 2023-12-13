Return-Path: <linux-fsdevel+bounces-5800-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B43588108DB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 04:58:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14768281EB1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 03:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 831C4BE48;
	Wed, 13 Dec 2023 03:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="bYYRLl0j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [IPv6:2a00:1098:ed:100::25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB1B2BC
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Dec 2023 19:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1702439898;
	bh=11blm8HJnQ9+FMdEFOr+A0pNMEFB7Ju+WMZoc5kI8rI=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=bYYRLl0jzzJ/ry5xSjKpPL3Ta4LRbgeYJx3Vgef71CF0GIHSmOPdE+YzqWjksBsGW
	 d7D6bFX9jKH/NKYYgsHD+Hx61y+8aPtGJxa6ftQOA3QNawyzS7/2OT0cIKohk7KXNp
	 Ta0Z7jytlPEm/dv4XB9uu3kZ01TwCcxFvk3s0Ze97Vs4v5Ymo687c6GBYiBUjusNxM
	 4AOPIQ8M5YIedSlhMujT/VRpw91eaObFkbTObneLptFPAsgiB+2uvpkrAcskIWlrGP
	 BneWrr9+wgMp1N0R+bLRE/Nh9xaP4mOWhjbsACvzgCMSli8o+QnXqTMCRcAy/AVDaa
	 4oW120hXsVqSA==
Received: from [100.96.234.34] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 9787637813F2;
	Wed, 13 Dec 2023 03:58:09 +0000 (UTC)
Message-ID: <2e4a719b-f2b3-48db-99db-d96040d78b12@collabora.com>
Date: Wed, 13 Dec 2023 08:58:06 +0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 David Hildenbrand <david@redhat.com>, Suren Baghdasaryan
 <surenb@google.com>, akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
 brauner@kernel.org, shuah@kernel.org, aarcange@redhat.com,
 lokeshgidra@google.com, peterx@redhat.com, ryan.roberts@arm.com,
 hughd@google.com, mhocko@suse.com, axelrasmussen@google.com,
 rppt@kernel.org, willy@infradead.org, Liam.Howlett@oracle.com,
 jannh@google.com, zhangpeng362@huawei.com, bgeffon@google.com,
 kaleshsingh@google.com, ngeoffray@google.com, jdduke@google.com,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kernel-team@android.com, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v6 5/5] selftests/mm: add UFFDIO_MOVE ioctl test
Content-Language: en-US
To: John Hubbard <jhubbard@nvidia.com>, Mark Brown <broonie@kernel.org>
References: <CAJuCfpFbWeycjvjAFryuugXuiv5ggm=cXG+Y1jfaCD9kJ6KWqQ@mail.gmail.com>
 <CAJuCfpHRYi4S9c+KKQqtE6Faw1e0E0ENMMRE17zXsqv_CftTGw@mail.gmail.com>
 <b93b29e9-c176-4111-ae0e-d4922511f223@sirena.org.uk>
 <50385948-5eb4-47ea-87f8-add4265933d6@redhat.com>
 <6a34b0c9-e084-4928-b239-7af01c8d4479@sirena.org.uk>
 <CAJuCfpEcbcO0d5WPDHMqiEJws9k_5c30pE-J+E_VxO_fpTf_mw@mail.gmail.com>
 <3240f4b5-081b-4075-851a-7d1cd86f4333@redhat.com>
 <3eadd79c-c02a-495f-92c0-0315046ef59f@nvidia.com>
 <3d22f342-280f-4a44-87f4-8cca291cfce7@sirena.org.uk>
 <e3048458-726e-4b98-b2bf-908ea9066959@nvidia.com>
 <0f97db9c-5b86-4f56-8463-2520fe79f709@sirena.org.uk>
 <f1b0b80a-1cc6-48c4-8a53-0222b3e59c7f@nvidia.com>
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <f1b0b80a-1cc6-48c4-8a53-0222b3e59c7f@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/13/23 7:14 AM, John Hubbard wrote:
> On 12/12/23 07:12, Mark Brown wrote:
>> On Mon, Dec 11, 2023 at 12:29:58PM -0800, John Hubbard wrote:
>>> On 12/11/23 12:21, Mark Brown wrote:
> ...
>>> Or maybe there is an innovative way to do all of this, that we have
>>> yet to think of.
>>
>> We do copy files into tools/include at random times which makes sense
>> for things that aren't uapi, and we are putting bits of uapi there
>> already so we could just expand the set of files copied there.  AFAICT
>> the only reason we're copying the uapi files at all is that they're
>> directly in the same include/ directories as everything else and are
>> always referenced with their uapi/ prefix.
> 
> Oh, this sounds like it would work nicely. No more "make headers"
> required (hooray!). Instead, the new approach would be "selftests are
> allowed to include from tools/include", and then we can just start
> copying the files that we need to that location, and gradually fix up
> all the selftests.
No, this wouldn't work.
* The selftests are applications which include default header files. The
application don't care from where the header files are picked up at compile
time. We should be able to build the application on normal system with
latest headers installed without any changes.
* The header files cannot be included directly as they need to be processed
first which is done by `make headers`. Here is a diff between kernel fs.h
and processed header file to be used by applications:

--- include/uapi/linux/fs.h	2023-12-12 14:45:22.857409660 +0500
+++ usr/include/linux/fs.h	2023-12-12 14:49:23.469733573 +0500
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef _UAPI_LINUX_FS_H
-#define _UAPI_LINUX_FS_H
+#ifndef _LINUX_FS_H
+#define _LINUX_FS_H

 /*
  * This file has definitions for some important file table structures
@@ -13,14 +13,10 @@
 #include <linux/limits.h>
 #include <linux/ioctl.h>
 #include <linux/types.h>
-#ifndef __KERNEL__
 #include <linux/fscrypt.h>
-#endif

 /* Use of MS_* flags within the kernel is restricted to core mount(2) code. */
-#if !defined(__KERNEL__)
 #include <linux/mount.h>
-#endif

 /*
  * It's silly to have NR_OPEN bigger than NR_FILE, but you can change
@@ -287,19 +283,19 @@
 typedef int __bitwise __kernel_rwf_t;

 /* high priority request, poll if possible */
-#define RWF_HIPRI	((__force __kernel_rwf_t)0x00000001)
+#define RWF_HIPRI	((__kernel_rwf_t)0x00000001)

 /* per-IO O_DSYNC */
-#define RWF_DSYNC	((__force __kernel_rwf_t)0x00000002)
+#define RWF_DSYNC	((__kernel_rwf_t)0x00000002)

 /* per-IO O_SYNC */
-#define RWF_SYNC	((__force __kernel_rwf_t)0x00000004)
+#define RWF_SYNC	((__kernel_rwf_t)0x00000004)

 /* per-IO, return -EAGAIN if operation would block */
-#define RWF_NOWAIT	((__force __kernel_rwf_t)0x00000008)
+#define RWF_NOWAIT	((__kernel_rwf_t)0x00000008)

 /* per-IO O_APPEND */
-#define RWF_APPEND	((__force __kernel_rwf_t)0x00000010)
+#define RWF_APPEND	((__kernel_rwf_t)0x00000010)

 /* mask of flags supported by the kernel */
 #define RWF_SUPPORTED	(RWF_HIPRI | RWF_DSYNC | RWF_SYNC | RWF_NOWAIT |\
@@ -364,4 +360,4 @@
 	__u64 return_mask;
 };

-#endif /* _UAPI_LINUX_FS_H */
+#endif /* _LINUX_FS_H */

> 
> I really like this, at first reading anyway.
> 
> Muhammad, Shuah, others, what do you think?
> 
> +Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>
> 
> 
> thanks,

-- 
BR,
Muhammad Usama Anjum

