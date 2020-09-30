Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8B5727E6A0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Sep 2020 12:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729352AbgI3K2m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Sep 2020 06:28:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:7390 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728500AbgI3K2l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Sep 2020 06:28:41 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08UACrbo033738;
        Wed, 30 Sep 2020 06:27:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=YLMZRYhLxXYowrAZOtKzuR/O6QgcBOt/bbAeTvAVLYk=;
 b=DMFFWxWQQQ/dOUDvmOcVNiZFPAqDQ+snKuj9I6y9e7JHxF4bBih3sAFH5XZIn/4WPNpW
 gyMRwSGnThr/oC4YT6P+4JGsCQA/nOuSjX7YuhpWz46EXu65qVfgIz2hFfaGewFvSaoS
 L0gg9kNhzz5iwXCb22/7peTMmvDQaTyxwsYgmt7chFrzDHZMvHLEMmD5TvagNiMShquq
 vw8E4ePr5a9XSW1nrzo4fHkmXkMVeMNJU2a2YlPEySk58tXJVrLzC+um0RhsN8HafEyD
 LJfK1Zy1eWk6G7U5hrspZWnWHBA5T90SHU1OjQWl9PYBFWCWxXH2Ha9j9c3iVKR3pYxn fQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 33vr2hgdas-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Sep 2020 06:27:57 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08UADAG4034594;
        Wed, 30 Sep 2020 06:27:56 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 33vr2hgd9x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Sep 2020 06:27:56 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08UAMX6f004141;
        Wed, 30 Sep 2020 10:27:54 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06ams.nl.ibm.com with ESMTP id 33v6mgruss-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Sep 2020 10:27:54 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08UARpio24969710
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Sep 2020 10:27:51 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C1F85AE053;
        Wed, 30 Sep 2020 10:27:51 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B2A9AAE045;
        Wed, 30 Sep 2020 10:27:47 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.79.47])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 30 Sep 2020 10:27:47 +0000 (GMT)
Date:   Wed, 30 Sep 2020 13:27:45 +0300
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
Message-ID: <20200930102745.GC3226834@linux.ibm.com>
References: <20200924132904.1391-1-rppt@kernel.org>
 <20200924132904.1391-6-rppt@kernel.org>
 <20200925074125.GQ2628@hirez.programming.kicks-ass.net>
 <20200929130529.GE2142832@kernel.org>
 <20200929141216.GO2628@hirez.programming.kicks-ass.net>
 <20200929145813.GA3226834@linux.ibm.com>
 <20200929151552.GS2628@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929151552.GS2628@hirez.programming.kicks-ass.net>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-30_05:2020-09-29,2020-09-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=950 malwarescore=0 phishscore=0 mlxscore=0 clxscore=1015
 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 suspectscore=1 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009300075
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 29, 2020 at 05:15:52PM +0200, Peter Zijlstra wrote:
> On Tue, Sep 29, 2020 at 05:58:13PM +0300, Mike Rapoport wrote:
> > On Tue, Sep 29, 2020 at 04:12:16PM +0200, Peter Zijlstra wrote:
> 
> > > It will drop them down to 4k pages. Given enough inodes, and allocating
> > > only a single sekrit page per pmd, we'll shatter the directmap into 4k.
> > 
> > Why? Secretmem allocates PMD-size page per inode and uses it as a pool
> > of 4K pages for that inode. This way it ensures that
> > __kernel_map_pages() is always called on PMD boundaries.
> 
> Oh, you unmap the 2m page upfront? I read it like you did the unmap at
> the sekrit page alloc, not the pool alloc side of things.
> 
> Then yes, but then you're wasting gobs of memory. Basically you can pin
> 2M per inode while only accounting a single page.

Right, quite like THP :)

I considered using a global pool of 2M pages for secretmem and handing
4K pages to each inode from that global pool. But I've decided to waste
memory in favor of simplicity.

The prevoius version of this set included additional patch that allowed
reserving chunk of the physical memory for a global secretmem pool at
boot time. We didn't reach an agreement with David H. about whether this
pool should be allocated directly from memblock or from CMA and I've
dropped the boot time reservation patch because it can always be added on
top. 

-- 
Sincerely yours,
Mike.
