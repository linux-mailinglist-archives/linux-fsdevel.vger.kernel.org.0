Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DDF43079D0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 16:34:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232233AbhA1Pb1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 10:31:27 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:13668 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232453AbhA1Pa7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 10:30:59 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 10SFLNHs039731;
        Thu, 28 Jan 2021 10:29:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=BVjEY1aLHVWHgW1JrF/80HMLKbeNHJOxCddk5Vowny0=;
 b=Yevp9Xe/XpYW7upEtY53faLYNKGYJRhwMIPFh60FKc4taK+WYZNlt9DuMlv50W+vD8ly
 2Rgn1wAtfZ67UHGAQox0ckGTHb2oqn8IRLrq6uji204LoWnlpRR/NJvaQoNMZAYuZoRB
 xq5g9FnHp3LeVO8cdzrK3YGMvO7FDRvmLBEO3Bozb/XQOHQ2DzX+6rnoqWjwTMEhZddr
 OSY1Bqpso6OHC3FRHlTJDvMjoEa7jrOfz6jrQpvjF8wk8FaCtw52sLccAjFbJMIFQoQE
 6XeEX2cRqytx0yaPYDFC9xg51JYkA/RXWVyaAqGSpVtCTzcEu1fQc+RJ2y/rtgp7FeAK Lg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36by8ysn02-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Jan 2021 10:29:12 -0500
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 10SFLgJY041664;
        Thu, 28 Jan 2021 10:29:11 -0500
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36by8ysmyf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Jan 2021 10:29:11 -0500
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 10SFNCCV013626;
        Thu, 28 Jan 2021 15:29:09 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma04dal.us.ibm.com with ESMTP id 36agvf5abj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Jan 2021 15:29:09 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 10SFT8Om25821540
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Jan 2021 15:29:08 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5C0D67805C;
        Thu, 28 Jan 2021 15:29:08 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 707E67805F;
        Thu, 28 Jan 2021 15:28:59 +0000 (GMT)
Received: from jarvis.int.hansenpartnership.com (unknown [9.85.133.159])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 28 Jan 2021 15:28:59 +0000 (GMT)
Message-ID: <2b6a5f22f0b062432186b89eeef58e2ba45e09c1.camel@linux.ibm.com>
Subject: Re: [PATCH v16 07/11] secretmem: use PMD-size pages to amortize
 direct map fragmentation
From:   James Bottomley <jejb@linux.ibm.com>
Reply-To: jejb@linux.ibm.com
To:     Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org,
        x86@kernel.org, Hagen Paul Pfeifer <hagen@jauu.net>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Date:   Thu, 28 Jan 2021 07:28:57 -0800
In-Reply-To: <YBK1kqL7JA7NePBQ@dhcp22.suse.cz>
References: <20210121122723.3446-1-rppt@kernel.org>
         <20210121122723.3446-8-rppt@kernel.org>
         <20210126114657.GL827@dhcp22.suse.cz>
         <303f348d-e494-e386-d1f5-14505b5da254@redhat.com>
         <20210126120823.GM827@dhcp22.suse.cz> <20210128092259.GB242749@kernel.org>
         <YBK1kqL7JA7NePBQ@dhcp22.suse.cz>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-28_08:2021-01-28,2021-01-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 suspectscore=0 impostorscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999
 phishscore=0 clxscore=1011 adultscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101280074
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2021-01-28 at 14:01 +0100, Michal Hocko wrote:
> On Thu 28-01-21 11:22:59, Mike Rapoport wrote:
[...]
> > One of the major pushbacks on the first RFC [1] of the concept was
> > about the direct map fragmentation. I tried really hard to find
> > data that shows what is the performance difference with different
> > page sizes in the direct map and I didn't find anything.
> > 
> > So presuming that large pages do provide advantage the first
> > implementation of secretmem used PMD_ORDER allocations to amortise
> > the effect of the direct map fragmentation and then handed out 4k
> > pages at each fault. In addition there was an option to reserve a
> > finite pool at boot time and limit secretmem allocations only to
> > that pool.
> > 
> > At some point David suggested to use CMA to improve overall
> > flexibility [3], so I switched secretmem to use CMA.
> > 
> > Now, with the data we have at hand (my benchmarks and Intel's
> > report David mentioned) I'm even not sure this whole pooling even
> > required.
> 
> I would still like to understand whether that data is actually
> representative. With some underlying reasoning rather than I have run
> these XYZ benchmarks and numbers do not look terrible.

My theory, and the reason I made Mike run the benchmarks, is that our
fear of TLB miss has been alleviated by CPU speculation advances over
the years.  You can appreciate this if you think that both Intel and
AMD have increased the number of levels in the page table to
accommodate larger virtual memory size 5 instead of 3.  That increases
the length of the page walk nearly 2x in a physical system and even
more in a virtual system.  Unless this were massively optimized,
systems would have slowed down significantly.  Using 2M pages only
eliminates one level and 2G pages eliminates 2, so I theorized that
actually fragmentation wouldn't be the significant problem we once
thought it was and asked Mike to benchmark it.

The benchmarks show that indeed, it isn't a huge change in the data TLB
miss time, I suspect because data is nicely continuous nowadays and the
prediction that goes into the CPU optimizations quite easy.  ITLB
fragmentation actually seems to be quite a bit worse, likely because we
still don't have branch prediction down to an exact science.

James


