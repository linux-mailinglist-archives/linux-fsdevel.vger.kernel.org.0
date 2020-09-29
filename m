Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49E8D27D215
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Sep 2020 17:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730705AbgI2PFM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Sep 2020 11:05:12 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38082 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725710AbgI2PFM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Sep 2020 11:05:12 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08TF1t5u035185;
        Tue, 29 Sep 2020 11:04:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=AcxqF9zuT07SMk68VH9TTwIsVwBQZKx3A9XD8taKU0I=;
 b=THFhKGR/HG1w1ws+RcsRfOZTeLPMNl9ug7Xzjdeud56WDuoOiEt4TF7UXS8NBnxi3VBe
 UrjMZzl2VKj2d2Fm1hUWVFFQUZpYSFJCKX4Nzmvbky1gfw+11cVTljASI7iWD+2RnFa4
 qQ1+H5rewDMqpBbEckZXFj8Rg4JPxOAjYdEVySYF0OTnvcdsnbOs2dc2371BgNO2Hzsr
 988rJpMOlxPqfoFYSYjL+MdrjzLReORVhOzro8sMtrW9dWCPJ5Z8tG5Mw7M0jvec+EBs
 bCOED8Z6vF4mKhjU/AsRHk8gYfyOT9Ed2/ahsbAmvAtDDMc66B3dCtiwa0Zhv1n3bXIy IA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33v5j5bc4t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Sep 2020 11:04:23 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08TF2cqK036825;
        Tue, 29 Sep 2020 11:03:56 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33v5j5bbgn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Sep 2020 11:03:55 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08TEl0KG032366;
        Tue, 29 Sep 2020 15:03:21 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma02wdc.us.ibm.com with ESMTP id 33sw9953h7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Sep 2020 15:03:21 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08TF3GOn50004314
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Sep 2020 15:03:16 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 935B178063;
        Tue, 29 Sep 2020 15:03:20 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C3CC878077;
        Tue, 29 Sep 2020 15:03:12 +0000 (GMT)
Received: from jarvis (unknown [9.85.129.253])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 29 Sep 2020 15:03:12 +0000 (GMT)
Message-ID: <491f8ff884de17d23e904d69454ec7a0862272f7.camel@linux.ibm.com>
Subject: Re: [PATCH v6 5/6] mm: secretmem: use PMD-size pages to amortize
 direct map fragmentation
From:   James Bottomley <jejb@linux.ibm.com>
Reply-To: jejb@linux.ibm.com
To:     Peter Zijlstra <peterz@infradead.org>,
        Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
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
        Mike Rapoport <rppt@linux.ibm.com>,
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
Date:   Tue, 29 Sep 2020 08:03:11 -0700
In-Reply-To: <20200929141216.GO2628@hirez.programming.kicks-ass.net>
References: <20200924132904.1391-1-rppt@kernel.org>
         <20200924132904.1391-6-rppt@kernel.org>
         <20200925074125.GQ2628@hirez.programming.kicks-ass.net>
         <20200929130529.GE2142832@kernel.org>
         <20200929141216.GO2628@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-29_07:2020-09-29,2020-09-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 priorityscore=1501 mlxscore=0
 bulkscore=0 adultscore=0 clxscore=1011 impostorscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009290130
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2020-09-29 at 16:12 +0200, Peter Zijlstra wrote:
> On Tue, Sep 29, 2020 at 04:05:29PM +0300, Mike Rapoport wrote:
> > On Fri, Sep 25, 2020 at 09:41:25AM +0200, Peter Zijlstra wrote:
> > > On Thu, Sep 24, 2020 at 04:29:03PM +0300, Mike Rapoport wrote:
> > > > From: Mike Rapoport <rppt@linux.ibm.com>
> > > > 
> > > > Removing a PAGE_SIZE page from the direct map every time such
> > > > page is allocated for a secret memory mapping will cause severe
> > > > fragmentation of the direct map. This fragmentation can be
> > > > reduced by using PMD-size pages as a pool for small pages for
> > > > secret memory mappings.
> > > > 
> > > > Add a gen_pool per secretmem inode and lazily populate this
> > > > pool with PMD-size pages.
> > > 
> > > What's the actual efficacy of this? Since the pmd is per inode,
> > > all I need is a lot of inodes and we're in business to destroy
> > > the directmap, no?
> > > 
> > > Afaict there's no privs needed to use this, all a process needs
> > > is to stay below the mlock limit, so a 'fork-bomb' that maps a
> > > single secret page will utterly destroy the direct map.
> > 
> > This indeed will cause 1G pages in the direct map to be split into
> > 2M chunks, but I disagree with 'destroy' term here. Citing the
> > cover letter of an earlier version of this series:
> 
> It will drop them down to 4k pages. Given enough inodes, and
> allocating only a single sekrit page per pmd, we'll shatter the
> directmap into 4k.

Since the only requirement is 2M, even if this happens, which I'm not
sure it does, it's fixable to only fragment down to 2M, right?

We could also enforce a global limit in the secretmem syscall, so the
fork bomb problem can be made to go away.

Lastly, we could go back to boot time allocation as the previous patch
did, so this isn't even a fundamental problem with the patch set.

That said, I think investigation of the importance of direct map tiling
is useful, since it does fragment for other reasons, and fixing or
proving that the fragmentation doesn't matter is also something we'll
keep on investigating.  But it would be useful in the meantime to
explore things which may be more fundamental issues with the approach.

Regards,

James




