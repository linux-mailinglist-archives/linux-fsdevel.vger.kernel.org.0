Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D90F27EC30
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Sep 2020 17:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728679AbgI3PSF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Sep 2020 11:18:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:14574 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725799AbgI3PSF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Sep 2020 11:18:05 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08UF3MFk094686;
        Wed, 30 Sep 2020 11:17:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=gp+WQ9ZEESIZMduD1c/QEJUgwqbbB7WxwcV1dg1RrNA=;
 b=GTNk/CkCAv8Qo5GFZrNEkX9tOKw5DaIu8rRYo+l9dGFjJ2UhDLmAbhff9Viw5MTvKmQS
 HhXE4TScz4/FbOYj0KrSBua1OE0Q4JHcYzQ4eP4qEl7wPgFMhEIzaY5h5/RKFjJVLKpZ
 P+oymzU4uwjVrMxsaCs5urUeI8oCtdeqsPAcudm72WEfn+cnCEo4RgpHYCBC9bEr7Wpt
 YqCO+/lRbY6ky/64BS7J6+KIrKyCLDyXEIYhC8VnsO6FvNz6hUZuuxoaKon+qApQVV2c
 mq/WI6NjDg7OG63/7oboppyBDscb0Myb6e/QbiPtc1ufBfPfgCZMolIVoIjVKMVBS23W Mg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33vv1q195j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Sep 2020 11:17:25 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08UF3VKV095830;
        Wed, 30 Sep 2020 11:17:25 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33vv1q194k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Sep 2020 11:17:24 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08UFDA0t032299;
        Wed, 30 Sep 2020 15:17:22 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma03dal.us.ibm.com with ESMTP id 33sw99qx7k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Sep 2020 15:17:22 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08UFHLxG41681302
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Sep 2020 15:17:21 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1C2B478064;
        Wed, 30 Sep 2020 15:17:21 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1A8C07805F;
        Wed, 30 Sep 2020 15:17:13 +0000 (GMT)
Received: from jarvis (unknown [9.85.129.253])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 30 Sep 2020 15:17:12 +0000 (GMT)
Message-ID: <ba7fbd31b37363c002318f633d7cc47d9ef46822.camel@linux.ibm.com>
Subject: Re: [PATCH v6 5/6] mm: secretmem: use PMD-size pages to amortize
 direct map fragmentation
From:   James Bottomley <jejb@linux.ibm.com>
Reply-To: jejb@linux.ibm.com
To:     David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Idan Yaniv <idan.yaniv@ibm.com>,
        Ingo Molnar <mingo@redhat.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Shuah Khan <shuah@kernel.org>, Tycho Andersen <tycho@tycho.ws>,
        Will Deacon <will@kernel.org>, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org,
        x86@kernel.org
Date:   Wed, 30 Sep 2020 08:17:11 -0700
In-Reply-To: <6568383f-4e43-2fe4-ecf1-8a55e306440b@redhat.com>
References: <20200924132904.1391-1-rppt@kernel.org>
         <20200924132904.1391-6-rppt@kernel.org>
         <20200925074125.GQ2628@hirez.programming.kicks-ass.net>
         <20200929130529.GE2142832@kernel.org>
         <20200929141216.GO2628@hirez.programming.kicks-ass.net>
         <20200929145813.GA3226834@linux.ibm.com>
         <20200929151552.GS2628@hirez.programming.kicks-ass.net>
         <20200930102745.GC3226834@linux.ibm.com>
         <371c27d97067654171e5c1019340b56cffadae7a.camel@linux.ibm.com>
         <6568383f-4e43-2fe4-ecf1-8a55e306440b@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-30_08:2020-09-30,2020-09-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=838 impostorscore=0 suspectscore=2 clxscore=1015 mlxscore=0
 spamscore=0 bulkscore=0 priorityscore=1501 adultscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009300121
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2020-09-30 at 16:45 +0200, David Hildenbrand wrote:
> On 30.09.20 16:39, James Bottomley wrote:
> > On Wed, 2020-09-30 at 13:27 +0300, Mike Rapoport wrote:
> > > On Tue, Sep 29, 2020 at 05:15:52PM +0200, Peter Zijlstra wrote:
> > > > On Tue, Sep 29, 2020 at 05:58:13PM +0300, Mike Rapoport wrote:
> > > > > On Tue, Sep 29, 2020 at 04:12:16PM +0200, Peter Zijlstra
> > > > > wrote:
> > > > > > It will drop them down to 4k pages. Given enough inodes,
> > > > > > and allocating only a single sekrit page per pmd, we'll
> > > > > > shatter the directmap into 4k.
> > > > > 
> > > > > Why? Secretmem allocates PMD-size page per inode and uses it
> > > > > as a pool of 4K pages for that inode. This way it ensures
> > > > > that __kernel_map_pages() is always called on PMD boundaries.
> > > > 
> > > > Oh, you unmap the 2m page upfront? I read it like you did the
> > > > unmap at the sekrit page alloc, not the pool alloc side of
> > > > things.
> > > > 
> > > > Then yes, but then you're wasting gobs of memory. Basically you
> > > > can pin 2M per inode while only accounting a single page.
> > > 
> > > Right, quite like THP :)
> > > 
> > > I considered using a global pool of 2M pages for secretmem and
> > > handing 4K pages to each inode from that global pool. But I've
> > > decided to waste memory in favor of simplicity.
> > 
> > I can also add that the user space consumer of this we wrote does
> > its user pool allocation at a 2M granularity, so nothing is
> > actually wasted.
> 
> ... for that specific user space consumer. (or am I missing
> something?)

I'm not sure I understand what you mean?  It's designed to be either
the standard wrapper or an example of how to do the standard wrapper
for the syscall.  It uses the same allocator system glibc uses for
malloc/free ... which pretty much everyone uses instead of calling
sys_brk directly.  If you look at the granularity glibc uses for
sys_brk, it's not 4k either.

James


