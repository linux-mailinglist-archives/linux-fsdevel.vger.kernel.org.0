Return-Path: <linux-fsdevel+bounces-60625-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BEC7B4A555
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 10:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B26F54E2E7F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 08:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39025247284;
	Tue,  9 Sep 2025 08:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MyRChXSO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83C112CDA5;
	Tue,  9 Sep 2025 08:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757406736; cv=none; b=JuicuErZtwqlekG98vuDjuk0vjN3eYd+3Ob7usjlQU8sbTQQMZVG9p28p9RbzN8GDhXmW/6L9BcPT39QRfqGHJYhRXU/oMaHzCoAac1FjrOk5qb3et+dYUvLPNNx2EE3EK1to1te4xGnHe10UU02r1iDnEGM1tkwI6CDPpUU/Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757406736; c=relaxed/simple;
	bh=chaOOs5USlqwKtDpt9uxB5EYPmgbxumGlafSVydVen4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WOh88ysKfYLOORybCCnOuhrC1hn7WjoTRRfqYcb6V1MJOfzH4cGI8XkY3CEsC17pAaY9rOZILWfSAT7rfOZoRE2NO/wVun+PyKhAxeL5hdYzwtIfrlqK7q3bEpvrJsyGbGZc2689ou+l0qRWl410HOTt1Hj/4RbLtWjGHS+KhCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MyRChXSO; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 588JcNWG009190;
	Tue, 9 Sep 2025 08:31:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=XRGYRp9IpXgOlM6YrJRhvNTKdkbZq/
	NQnIfckf3EQjs=; b=MyRChXSONJ/VpRxUYGEWmZDaEUcUPfmlYMC94Ui/2NpXsW
	GAUyr1eXibKeDOBJAaM64v+14/xQd77CqidsGprubltQPBWv2P65ZUgh1Coc63qO
	RJtUvPK0HqZka742VdVR87OekHNVa0pW8eFyREJcPL9iQDumkUOzuZNxU6tKnLvy
	fCrd7DCOR44/awj4t/q821CuWAs3qWZZ0+bLaKZ2ojmM9vNnNgBy7YCN8v4Q3RO+
	mODGY6Hx2OmpypY7TPliZST8FLfVSKWF1LM4YBzfKrnLhOVuCn3y9CcyeJ4P2sWk
	oSoj+Tcgnq4IZvqDV/xeYwy9QoyoiSVDJeNosniQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490acqxe1c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Sep 2025 08:31:33 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5898Qk8A011618;
	Tue, 9 Sep 2025 08:31:32 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490acqxe14-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Sep 2025 08:31:32 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5895lhMj011435;
	Tue, 9 Sep 2025 08:31:31 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 490y9uacnj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Sep 2025 08:31:31 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5898VSmY44564752
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Sep 2025 08:31:28 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EA9D020043;
	Tue,  9 Sep 2025 08:31:27 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8E9C720040;
	Tue,  9 Sep 2025 08:31:25 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.87.149.210])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  9 Sep 2025 08:31:25 +0000 (GMT)
Date: Tue, 9 Sep 2025 10:31:24 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, Matthew Wilcox <willy@infradead.org>,
        Guo Ren <guoren@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, Nicolas Pitre <nico@fluxnic.net>,
        Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>, Tony Luck <tony.luck@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Dave Martin <Dave.Martin@arm.com>, James Morse <james.morse@arm.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Hugh Dickins <hughd@google.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org, linux-mm@kvack.org,
        ntfs3@lists.linux.dev, kexec@lists.infradead.org,
        kasan-dev@googlegroups.com, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH 00/16] expand mmap_prepare functionality, port more users
Message-ID: <4fbe6c51-69f4-455e-922f-acdc613108cb-agordeev@linux.ibm.com>
References: <cover.1757329751.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1757329751.git.lorenzo.stoakes@oracle.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3deOkNqrfHdLIv9wcUPHlUetDtdvUQWz
X-Authority-Analysis: v=2.4 cv=Mp1S63ae c=1 sm=1 tr=0 ts=68bfe5e5 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=yJojWOMRYYMA:10 a=rCdDL0ybDgsdDLvqgG0A:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: qA00adzFc2mr4mwvlzTl3c7SVFuwc24W
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAwMCBTYWx0ZWRfX9DH4SXGK5Ef2
 wejG4c7pX++RhbA1qSy6joL4Dc2oCsCOSPIhrBxt/QLkDiM3oF5S3fnf0a8rvaceAzUOg6WA1gQ
 Ir8I+yPvEyV1Im2S29dkEFwOqpdtLAPsWf2TTp0eyOgmPS+IVsDGdHQRHBjWiZ05r0xpu4su3dr
 m16Ho7NogpEOVcd3h6JEtyn5UfreBb3jlkItkjRqhI4JeeAIMcTnphkaB4l7pHKWbZxIqItt4g7
 VpspaOMhadlzbq6FrrwE54z2UGMx4eYQuRZiUQE2/EtFUQMQbKGs7KhlROQVEQLcoAhtD28WCFQ
 L6pd7Sw8hzkZH/lMoqL2zPGcZXWdwKNG36NITE6JE5TGdgh01ojrh+qdwWmxBmCjCCl7ztPlKTn
 wVjj1P8/
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 clxscore=1011 phishscore=0 spamscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060000

On Mon, Sep 08, 2025 at 12:10:31PM +0100, Lorenzo Stoakes wrote:

Hi Lorenzo,

I am getting this warning with this series applied:

[Tue Sep  9 10:25:34 2025] ------------[ cut here ]------------
[Tue Sep  9 10:25:34 2025] WARNING: CPU: 0 PID: 563 at mm/memory.c:2942 remap_pfn_range_internal+0x36e/0x420
[Tue Sep  9 10:25:34 2025] Modules linked in: diag288_wdt(E) watchdog(E) ghash_s390(E) des_generic(E) prng(E) aes_s390(E) des_s390(E) libdes(E) sha3_512_s390(E) sha3_256_s390(E) sha_common(E) vfio_ccw(E) mdev(E) vfio_iommu_type1(E) vfio(E) pkey(E) autofs4(E) overlay(E) squashfs(E) loop(E)
[Tue Sep  9 10:25:34 2025] Unloaded tainted modules: hmac_s390(E):1
[Tue Sep  9 10:25:34 2025] CPU: 0 UID: 0 PID: 563 Comm: makedumpfile Tainted: G            E       6.17.0-rc4-gcc-mmap-00410-g87e982e900f0 #288 PREEMPT 
[Tue Sep  9 10:25:34 2025] Tainted: [E]=UNSIGNED_MODULE
[Tue Sep  9 10:25:34 2025] Hardware name: IBM 8561 T01 703 (LPAR)
[Tue Sep  9 10:25:34 2025] Krnl PSW : 0704d00180000000 00007fffe07f5ef2 (remap_pfn_range_internal+0x372/0x420)
[Tue Sep  9 10:25:34 2025]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:1 PM:0 RI:0 EA:3
[Tue Sep  9 10:25:34 2025] Krnl GPRS: 0000000004044400 001c0f000188b024 0000000000000000 001c0f000188b022
[Tue Sep  9 10:25:34 2025]            000078000c458120 000078000a0ca800 00000f000188b022 0000000000000711
[Tue Sep  9 10:25:34 2025]            000003ffa6e05000 00000f000188b024 000003ffa6a05000 0000000004044400
[Tue Sep  9 10:25:34 2025]            000003ffa7aadfa8 00007fffe2c35ea0 001c000000000000 00007f7fe0faf000
[Tue Sep  9 10:25:34 2025] Krnl Code: 00007fffe07f5ee6: 47000700                bc      0,1792
                                      00007fffe07f5eea: af000000                mc      0,0
                                     #00007fffe07f5eee: af000000                mc      0,0
                                     >00007fffe07f5ef2: a7f4ff11                brc     15,00007fffe07f5d14
                                      00007fffe07f5ef6: b904002b                lgr     %r2,%r11
                                      00007fffe07f5efa: c0e5000918bb    brasl   %r14,00007fffe0919070
                                      00007fffe07f5f00: a7f4ff39                brc     15,00007fffe07f5d72
                                      00007fffe07f5f04: e320f0c80004    lg      %r2,200(%r15)
[Tue Sep  9 10:25:34 2025] Call Trace:
[Tue Sep  9 10:25:34 2025]  [<00007fffe07f5ef2>] remap_pfn_range_internal+0x372/0x420 
[Tue Sep  9 10:25:34 2025]  [<00007fffe07f5fd4>] remap_pfn_range_complete+0x34/0x70 
[Tue Sep  9 10:25:34 2025]  [<00007fffe019879e>] remap_oldmem_pfn_range+0x13e/0x1a0 
[Tue Sep  9 10:25:34 2025]  [<00007fffe0bd3550>] mmap_complete_vmcore+0x520/0x7b0 
[Tue Sep  9 10:25:34 2025]  [<00007fffe077b05a>] __compat_vma_mmap_prepare+0x3ea/0x550 
[Tue Sep  9 10:25:34 2025]  [<00007fffe0ba27f0>] pde_mmap+0x160/0x1a0 
[Tue Sep  9 10:25:34 2025]  [<00007fffe0ba3750>] proc_reg_mmap+0xd0/0x180 
[Tue Sep  9 10:25:34 2025]  [<00007fffe0859904>] __mmap_new_vma+0x444/0x1290 
[Tue Sep  9 10:25:34 2025]  [<00007fffe085b0b4>] __mmap_region+0x964/0x1090 
[Tue Sep  9 10:25:34 2025]  [<00007fffe085dc7e>] mmap_region+0xde/0x250 
[Tue Sep  9 10:25:34 2025]  [<00007fffe08065fc>] do_mmap+0x80c/0xc30 
[Tue Sep  9 10:25:34 2025]  [<00007fffe077c708>] vm_mmap_pgoff+0x218/0x370 
[Tue Sep  9 10:25:34 2025]  [<00007fffe080467e>] ksys_mmap_pgoff+0x2ee/0x400 
[Tue Sep  9 10:25:34 2025]  [<00007fffe0804a3a>] __s390x_sys_old_mmap+0x15a/0x1d0 
[Tue Sep  9 10:25:34 2025]  [<00007fffe29f1cd6>] __do_syscall+0x146/0x410 
[Tue Sep  9 10:25:34 2025]  [<00007fffe2a17e1e>] system_call+0x6e/0x90 
[Tue Sep  9 10:25:34 2025] 2 locks held by makedumpfile/563:
[Tue Sep  9 10:25:34 2025]  #0: 000078000a0caab0 (&mm->mmap_lock){++++}-{3:3}, at: vm_mmap_pgoff+0x16e/0x370
[Tue Sep  9 10:25:34 2025]  #1: 00007fffe3864f50 (vmcore_cb_srcu){.+.+}-{0:0}, at: mmap_complete_vmcore+0x20c/0x7b0
[Tue Sep  9 10:25:34 2025] Last Breaking-Event-Address:
[Tue Sep  9 10:25:34 2025]  [<00007fffe07f5d0e>] remap_pfn_range_internal+0x18e/0x420
[Tue Sep  9 10:25:34 2025] irq event stamp: 19113
[Tue Sep  9 10:25:34 2025] hardirqs last  enabled at (19121): [<00007fffe0391910>] __up_console_sem+0xe0/0x120
[Tue Sep  9 10:25:34 2025] hardirqs last disabled at (19128): [<00007fffe03918f2>] __up_console_sem+0xc2/0x120
[Tue Sep  9 10:25:34 2025] softirqs last  enabled at (4934): [<00007fffe021cb8e>] handle_softirqs+0x70e/0xed0
[Tue Sep  9 10:25:34 2025] softirqs last disabled at (3919): [<00007fffe021b670>] __irq_exit_rcu+0x2e0/0x380
[Tue Sep  9 10:25:34 2025] ---[ end trace 0000000000000000 ]---

Thanks!

