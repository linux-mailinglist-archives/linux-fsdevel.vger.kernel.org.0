Return-Path: <linux-fsdevel+bounces-42184-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 926DEA3E405
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2025 19:35:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 125F8420D49
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2025 18:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B24215190;
	Thu, 20 Feb 2025 18:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GxmdfoZg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE26257D;
	Thu, 20 Feb 2025 18:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740076480; cv=none; b=VFEGml/stOequypEL52NUeMK+Zf6t24FI90ubn6pPaPKiQD7UGmGkXEYpqjt0VMaknjTT971tl6m7m1SV9f7Ixt34G70V6wo4NXvt3qdAmk1OLeuGVkG56k4t85DubIYOYhpwSFwOpVqW3233ed8rqTfykAkp8Jh1GQ/sVtIi9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740076480; c=relaxed/simple;
	bh=/LnWcPRyXKEHQ3gAWHDyZ1PtFJgSTS4Ppsf/IrPzcsU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fyl4wST2PMYkXYhNCZ6m8qcwmfeNWP6/Q0GeBUg4AlKs5iXmbxfJ4BBVbjoRHBg8z6/vP/FyqporxoY5w0jbR1IXhSmZtilzLe7eTYjCsX3TO6heMWvZjGn+AVcNYBFx9SfdWO0zhW8tHaVf+JFYQv1eRO2wZO7jS1jrFwvXYYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GxmdfoZg; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51KH1cvh029326;
	Thu, 20 Feb 2025 18:33:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=FcxwqK
	Cj7AI2VdyyanA1j8RnG7hQzzrm45++xUtPV78=; b=GxmdfoZgDml6SEejBGbeZ+
	Y77j8DNOaz2mXRpM6AbAAxSet/c5sdfX/1F+tPUMHMSeX6v5qqnHjyZe/MPG8HLb
	QSM8SuFAYSIdcRkhO600xhqJEswznyYSspSBjplVbNhzQYWlzN49L/Hm5O0+2Hr6
	sgUKjsIO4Xyf9Aw1vOEh3fsdtvpk1bTuxU/L6UK2X9xS1211KKdtQr/bUyb18CiU
	p4CL3V0cC4kVkNzTOpw6ADR6na+EWrdSRTGaB3UfMctLCsaYEYOlmNRKk66melyb
	2rgHDW+6aPz3ncY3WbeRWlD9fmzwXTPGPuunqBnEAgu0duw9YNa9vhRSMxbCmsuQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44wx78kust-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 18:33:40 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51KISnU6023517;
	Thu, 20 Feb 2025 18:33:40 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44wx78kusk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 18:33:40 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51KIMhXj027077;
	Thu, 20 Feb 2025 18:33:38 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 44w025bjes-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 18:33:38 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51KIXbFU59965808
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Feb 2025 18:33:37 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0DE4220043;
	Thu, 20 Feb 2025 18:33:37 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6433720040;
	Thu, 20 Feb 2025 18:33:36 +0000 (GMT)
Received: from thinkpad-T15 (unknown [9.152.212.30])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 20 Feb 2025 18:33:36 +0000 (GMT)
Date: Thu, 20 Feb 2025 19:33:34 +0100
From: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
To: Alistair Popple <apopple@nvidia.com>
Cc: akpm@linux-foundation.org, dan.j.williams@intel.com, linux-mm@kvack.org,
        Alison Schofield <alison.schofield@intel.com>, lina@asahilina.net,
        zhang.lyra@gmail.com, vishal.l.verma@intel.com, dave.jiang@intel.com,
        logang@deltatee.com, bhelgaas@google.com, jack@suse.cz, jgg@ziepe.ca,
        catalin.marinas@arm.com, will@kernel.org, mpe@ellerman.id.au,
        npiggin@gmail.com, dave.hansen@linux.intel.com, ira.weiny@intel.com,
        willy@infradead.org, djwong@kernel.org, tytso@mit.edu,
        linmiaohe@huawei.com, david@redhat.com, peterx@redhat.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org, jhubbard@nvidia.com, hch@lst.de,
        david@fromorbit.com, chenhuacai@kernel.org, kernel@xen0n.name,
        loongarch@lists.linux.dev, vgoyal@redhat.com, stefanha@redhat.com
Subject: Re: [PATCH v8 20/20] device/dax: Properly refcount device dax pages
 when mapping
Message-ID: <20250220193334.0f7f4071@thinkpad-T15>
In-Reply-To: <9d9d33b418dd1aab9323203488305085389f62c1.1739850794.git-series.apopple@nvidia.com>
References: <cover.a782e309b1328f961da88abddbbc48e5b4579021.1739850794.git-series.apopple@nvidia.com>
	<9d9d33b418dd1aab9323203488305085389f62c1.1739850794.git-series.apopple@nvidia.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zuIWejWRNtbRCsuLFOLDp6zAMkoHhC6z
X-Proofpoint-ORIG-GUID: y5u7NXx-QaNlJj2myfsdElRbcx1OeQjd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_08,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 phishscore=0 malwarescore=0 mlxscore=0 clxscore=1011
 spamscore=0 suspectscore=0 mlxlogscore=999 lowpriorityscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502200128

On Tue, 18 Feb 2025 14:55:36 +1100
Alistair Popple <apopple@nvidia.com> wrote:

[...]
> diff --git a/mm/memremap.c b/mm/memremap.c
> index 9a8879b..532a52a 100644
> --- a/mm/memremap.c
> +++ b/mm/memremap.c
> @@ -460,11 +460,10 @@ void free_zone_device_folio(struct folio *folio)
>  {
>  	struct dev_pagemap *pgmap = folio->pgmap;
>  
> -	if (WARN_ON_ONCE(!pgmap->ops))
> -		return;
> -
> -	if (WARN_ON_ONCE(pgmap->type != MEMORY_DEVICE_FS_DAX &&
> -			 !pgmap->ops->page_free))
> +	if (WARN_ON_ONCE((!pgmap->ops &&
> +			  pgmap->type != MEMORY_DEVICE_GENERIC) ||
> +			 (pgmap->ops && !pgmap->ops->page_free &&
> +			  pgmap->type != MEMORY_DEVICE_FS_DAX)))

Playing around with dcssblk, adding devm_memremap_pages() and
pgmap.type = MEMORY_DEVICE_FS_DAX, similar to the other two existing
FS_DAX drivers drivers/nvdimm/pmem.c and fs/fuse/virtio_fs.c, I hit
this warning when executing binaries from DAX-mounted fs.

I do not set up pgmap->ops, similar to fs/fuse/virtio_fs.c, and I don't see
why they would be needed here anyway, at least for MEMORY_DEVICE_FS_DAX.
drivers/nvdimm/pmem.c does set up pgmap->ops, but only ->memory_failure,
which is still good enough to not trigger the warning here, probably just
by chance.

Now I wonder:
1) What is this check / warning good for, when this function only ever
   calls pgmap->ops->page_free(), but not for MEMORY_DEVICE_FS_DAX and
   not for MEMORY_DEVICE_GENERIC (the latter only after this patch)?
2) Is the warning also seen for virtio DAX mappings (added Vivek and
   Stefan on CC)? No pgmap->ops set up there, so I would guess "yes",
   and already before this series, with the old check / warning.
3) Could this be changed to only check / warn if pgmap->ops (or maybe
   rather pgmap->ops->page_free) is not set up, but not for
   MEMORY_DEVICE_GENERIC and MEMORY_DEVICE_FS_DAX where this is not
   being called?
4) Or is there any reason why pgmap->ops would be required for
   MEMORY_DEVICE_FS_DAX?

Apart from the warning, we would also miss out on the
wake_up_var(&folio->page) in the MEMORY_DEVICE_FS_DAX case, when no
pgmap->ops was set up. IIUC, even before this change / series (i.e.
for virtio DAX only, since dcssblk was not using ZONE_DEVICE before,
and pmem seems to work by chance because they have ops->memory_failure).

>  		return;
>  
>  	mem_cgroup_uncharge(folio);
> @@ -494,7 +493,8 @@ void free_zone_device_folio(struct folio *folio)
>  	 * zero which indicating the page has been removed from the file
>  	 * system mapping.
>  	 */
> -	if (pgmap->type != MEMORY_DEVICE_FS_DAX)
> +	if (pgmap->type != MEMORY_DEVICE_FS_DAX &&
> +	    pgmap->type != MEMORY_DEVICE_GENERIC)
>  		folio->mapping = NULL;
>  
>  	switch (pgmap->type) {
> @@ -509,7 +509,6 @@ void free_zone_device_folio(struct folio *folio)
>  		 * Reset the refcount to 1 to prepare for handing out the page
>  		 * again.
>  		 */
> -		pgmap->ops->page_free(folio_page(folio, 0));

Ok, this is probably the reason why you adjusted the check above, since
no more pgmap->ops needed for MEMORY_DEVICE_GENERIC.
Still, the MEMORY_DEVICE_FS_DAX case also does not seem to need
pgmap->ops, and at least the existing virtio DAX should already be
affected, and of course future dcssblk DAX.

But maybe that should be addressed in a separate patch, since your changes
here seem consistent, and not change or worsen anything wrt !pgmap->ops
and MEMORY_DEVICE_FS_DAX.

>  		folio_set_count(folio, 1);
>  		break;
>  

For reference, this is call trace I see when I hit the warning:

[  283.567945] ------------[ cut here ]------------
[  283.567947] WARNING: CPU: 12 PID: 878 at mm/memremap.c:436 free_zone_device_folio+0x6e/0x140
[  283.567959] Modules linked in:
[  283.567963] CPU: 12 UID: 0 PID: 878 Comm: ls Not tainted 6.14.0-rc3-next-20250220-00012-gd072dabf62e8-dirty #44
[  283.567968] Hardware name: IBM 3931 A01 704 (z/VM 7.4.0)
[  283.567971] Krnl PSW : 0704d00180000000 000001ec0548b44a (free_zone_device_folio+0x72/0x140)
[  283.567978]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:1 PM:0 RI:0 EA:3
[  283.567982] Krnl GPRS: 0000000000000038 0000000000000000 0000000000000003 000001ec06cc42e8
[  283.567986]            00000004cc38e400 0000000000000000 0000000000000003 0000000093eacd00
[  283.567990]            000000009a68413f 0000016614010940 000000009553a640 0000016614010940
[  283.567994]            0000000000000000 0000000000000000 000001ec0548b416 0000016c05da3bf8
[  283.568004] Krnl Code: 000001ec0548b43e: a70e0003		chi	%r0,3
                          000001ec0548b442: a7840006		brc	8,000001ec0548b44e
                         #000001ec0548b446: af000000		mc	0,0
                         >000001ec0548b44a: a7f4005f		brc	15,000001ec0548b508
                          000001ec0548b44e: c00400000008	brcl	0,000001ec0548b45e
                          000001ec0548b454: b904002b		lgr	%r2,%r11
                          000001ec0548b458: c0e5001dcd84	brasl	%r14,000001ec05844f60
                          000001ec0548b45e: 9101b01f		tm	31(%r11),1
[  283.568035] Call Trace:
[  283.568038]  [<000001ec0548b44a>] free_zone_device_folio+0x72/0x140 
[  283.568042] ([<000001ec0548b416>] free_zone_device_folio+0x3e/0x140)
[  283.568045]  [<000001ec057a4c1c>] wp_page_copy+0x34c/0x6e0 
[  283.568050]  [<000001ec057ac640>] __handle_mm_fault+0x220/0x4d0 
[  283.568054]  [<000001ec057ac97e>] handle_mm_fault+0x8e/0x160 
[  283.568057]  [<000001ec054ca006>] do_exception+0x1a6/0x450 
[  283.568061]  [<000001ec06264992>] __do_pgm_check+0x132/0x1e0 
[  283.568065]  [<000001ec0627057e>] pgm_check_handler+0x11e/0x170 
[  283.568069] Last Breaking-Event-Address:
[  283.568070]  [<000001ec0548b428>] free_zone_device_folio+0x50/0x140
[  283.568074] ---[ end trace 0000000000000000 ]---

