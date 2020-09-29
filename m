Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 626AC27D201
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Sep 2020 16:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729934AbgI2O7I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Sep 2020 10:59:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:15448 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728983AbgI2O7I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Sep 2020 10:59:08 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08TEX8Dk016644;
        Tue, 29 Sep 2020 10:58:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=esolzCLlTJEPeG6627hqWcv24P1GZzdpl1qowU+wiLA=;
 b=blMtUQ0t676Kma0/HQZ4K/xoewmRDbmMiDMRnwolwrmq0eLOO33nC1gr7BcmfqJPr3D8
 CAT+0MSu9Y3Qk/0cpLy/GrEB3baPQAqeZn/cDZ+0OzKo9mBcl0vbT4rmFchwut7ISJZa
 fQgwNK2lYd0i9yMnEMSnP+9Nas/BZi8HF3lyzkkbDrkqn4tFr9pKd/hKdrfFOA1TSMgO
 pS5DkH/PhjoJX7uRIwwAILmTZkQPX7TRM58d7bIbB/W6ZcsatSCovsvRZn1NgL9uJ401
 i5FM8ACSbSwRW44M2mQITd/5mjlEjlpe2ef7k+aNtYa/W79pxqU4aKM6ljbZGNT19oPG Og== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33v6mts9cd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Sep 2020 10:58:25 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08TEXjtF019149;
        Tue, 29 Sep 2020 10:58:24 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33v6mts9b8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Sep 2020 10:58:24 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08TEmKSF023163;
        Tue, 29 Sep 2020 14:58:22 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06ams.nl.ibm.com with ESMTP id 33v6mgr0yg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Sep 2020 14:58:21 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08TEwJVb28836272
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Sep 2020 14:58:19 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7078D11C058;
        Tue, 29 Sep 2020 14:58:19 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 17C1711C06E;
        Tue, 29 Sep 2020 14:58:15 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.79.47])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 29 Sep 2020 14:58:14 +0000 (GMT)
Date:   Tue, 29 Sep 2020 17:58:13 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>
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
        James Bottomley <jejb@linux.ibm.com>,
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
Subject: Re: [PATCH v6 5/6] mm: secretmem: use PMD-size pages to amortize
 direct map fragmentation
Message-ID: <20200929145813.GA3226834@linux.ibm.com>
References: <20200924132904.1391-1-rppt@kernel.org>
 <20200924132904.1391-6-rppt@kernel.org>
 <20200925074125.GQ2628@hirez.programming.kicks-ass.net>
 <20200929130529.GE2142832@kernel.org>
 <20200929141216.GO2628@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929141216.GO2628@hirez.programming.kicks-ass.net>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-29_07:2020-09-29,2020-09-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 mlxscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 clxscore=1011 mlxlogscore=999
 suspectscore=1 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009290129
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 29, 2020 at 04:12:16PM +0200, Peter Zijlstra wrote:
> On Tue, Sep 29, 2020 at 04:05:29PM +0300, Mike Rapoport wrote:
> > On Fri, Sep 25, 2020 at 09:41:25AM +0200, Peter Zijlstra wrote:
> > > On Thu, Sep 24, 2020 at 04:29:03PM +0300, Mike Rapoport wrote:
> > > > From: Mike Rapoport <rppt@linux.ibm.com>
> > > > 
> > > > Removing a PAGE_SIZE page from the direct map every time such page is
> > > > allocated for a secret memory mapping will cause severe fragmentation of
> > > > the direct map. This fragmentation can be reduced by using PMD-size pages
> > > > as a pool for small pages for secret memory mappings.
> > > > 
> > > > Add a gen_pool per secretmem inode and lazily populate this pool with
> > > > PMD-size pages.
> > > 
> > > What's the actual efficacy of this? Since the pmd is per inode, all I
> > > need is a lot of inodes and we're in business to destroy the directmap,
> > > no?
> > > 
> > > Afaict there's no privs needed to use this, all a process needs is to
> > > stay below the mlock limit, so a 'fork-bomb' that maps a single secret
> > > page will utterly destroy the direct map.
> > 
> > This indeed will cause 1G pages in the direct map to be split into 2M
> > chunks, but I disagree with 'destroy' term here. Citing the cover letter
> > of an earlier version of this series:
> 
> It will drop them down to 4k pages. Given enough inodes, and allocating
> only a single sekrit page per pmd, we'll shatter the directmap into 4k.

Why? Secretmem allocates PMD-size page per inode and uses it as a pool
of 4K pages for that inode. This way it ensures that
__kernel_map_pages() is always called on PMD boundaries.

-- 
Sincerely yours,
Mike.
