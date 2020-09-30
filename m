Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E28C227EB1E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Sep 2020 16:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730405AbgI3Okx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Sep 2020 10:40:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:7438 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728149AbgI3Okw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Sep 2020 10:40:52 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08UEXn0h002260;
        Wed, 30 Sep 2020 10:40:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=TOhFRkH6eBrNvZOnRv3vltvV9RWcAvaYO4zGgzF6rYA=;
 b=V6DwgTAKxpxWbmkbUs+va5rzIxR+lCshyKHzDJTztxt1Hk13G4unr60eZMYIJnN4V2nq
 /jEkjdRudg7CAzTYrBENRqt8sHleTLsYAiL8SdB1aCk1NfjtQWhrSGCd4WgBzHKX3W+/
 htaiTmMRRzk9Izsiz8TbNboGeepzjBW1wDZ4Rm4UDs6BeYGHkgijKGyl5/2Vc9dKgt5M
 joTxP4/HYR3U/jMJFF9VaYNuGVLX0x0CLFiJX90UgMw/ZTYxe7OSJhgvoG0dEbOCj/Uo
 JMtTSmu1uVj0Nyo/Cew9CAVzfjzQgDiHlHMhc76YsmWCR9xbt08JW2T2lE9OscEE5eMz hw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33vtprt807-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Sep 2020 10:40:14 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08UEY9wX003413;
        Wed, 30 Sep 2020 10:40:09 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33vtprt7wm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Sep 2020 10:40:08 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08UEcK6A011409;
        Wed, 30 Sep 2020 14:40:03 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma05wdc.us.ibm.com with ESMTP id 33sw99e3uh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Sep 2020 14:40:03 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08UEdweH34472466
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Sep 2020 14:39:58 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 45B5D78072;
        Wed, 30 Sep 2020 14:40:02 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3FEF578060;
        Wed, 30 Sep 2020 14:39:56 +0000 (GMT)
Received: from jarvis (unknown [9.85.129.253])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 30 Sep 2020 14:39:55 +0000 (GMT)
Message-ID: <371c27d97067654171e5c1019340b56cffadae7a.camel@linux.ibm.com>
Subject: Re: [PATCH v6 5/6] mm: secretmem: use PMD-size pages to amortize
 direct map fragmentation
From:   James Bottomley <jejb@linux.ibm.com>
Reply-To: jejb@linux.ibm.com
To:     Mike Rapoport <rppt@linux.ibm.com>,
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
        David Hildenbrand <david@redhat.com>,
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
Date:   Wed, 30 Sep 2020 07:39:54 -0700
In-Reply-To: <20200930102745.GC3226834@linux.ibm.com>
References: <20200924132904.1391-1-rppt@kernel.org>
         <20200924132904.1391-6-rppt@kernel.org>
         <20200925074125.GQ2628@hirez.programming.kicks-ass.net>
         <20200929130529.GE2142832@kernel.org>
         <20200929141216.GO2628@hirez.programming.kicks-ass.net>
         <20200929145813.GA3226834@linux.ibm.com>
         <20200929151552.GS2628@hirez.programming.kicks-ass.net>
         <20200930102745.GC3226834@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-30_07:2020-09-30,2020-09-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 malwarescore=0
 adultscore=0 bulkscore=0 mlxlogscore=690 spamscore=0 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009300112
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2020-09-30 at 13:27 +0300, Mike Rapoport wrote:
> On Tue, Sep 29, 2020 at 05:15:52PM +0200, Peter Zijlstra wrote:
> > On Tue, Sep 29, 2020 at 05:58:13PM +0300, Mike Rapoport wrote:
> > > On Tue, Sep 29, 2020 at 04:12:16PM +0200, Peter Zijlstra wrote:
> > > > It will drop them down to 4k pages. Given enough inodes, and
> > > > allocating only a single sekrit page per pmd, we'll shatter the
> > > > directmap into 4k.
> > > 
> > > Why? Secretmem allocates PMD-size page per inode and uses it as a
> > > pool of 4K pages for that inode. This way it ensures that
> > > __kernel_map_pages() is always called on PMD boundaries.
> > 
> > Oh, you unmap the 2m page upfront? I read it like you did the unmap
> > at the sekrit page alloc, not the pool alloc side of things.
> > 
> > Then yes, but then you're wasting gobs of memory. Basically you can
> > pin 2M per inode while only accounting a single page.
> 
> Right, quite like THP :)
> 
> I considered using a global pool of 2M pages for secretmem and
> handing 4K pages to each inode from that global pool. But I've
> decided to waste memory in favor of simplicity.

I can also add that the user space consumer of this we wrote does its
user pool allocation at a 2M granularity, so nothing is actually
wasted.

https://git.kernel.org/pub/scm/linux/kernel/git/jejb/secret-memory-preloader.git/

James


