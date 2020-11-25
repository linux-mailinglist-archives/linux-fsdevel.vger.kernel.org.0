Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3041A2C3FA6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Nov 2020 13:13:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729109AbgKYMMd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Nov 2020 07:12:33 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47644 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728976AbgKYMMc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Nov 2020 07:12:32 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0APC1MRH068941;
        Wed, 25 Nov 2020 07:11:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=tJZHC6137uQUG8RKPb1dol8HSxgZMOUWtark59mf2wI=;
 b=Dz5WMozo2vUGDh7A4Gjbkl4xbnkyJNqtzWYBzd6hnalu9/HdWbkTyWG46xEGCKwANBYD
 n9UVHcO/5rlx2RFcs5DdcygFL5C9TlEL28hYlAKY2m3rutu+rur3Cv0/LgdAAN++jrst
 Xhs88kRph/l7UY0/rCv70Rt7gXs5YjtnmxBp9lmYTwn7EYFsANP/3fKwIO3QGDnz3Igz
 akoVFnMZtzsic6aSz7PqLvUuXEOihVJdzL+Lj340Pt5nqDKR+S9PD0SPJMwfgMXAM/HM
 u7YarQUsM05nyGFrBxB9eBtEwBimmwzq/BapYj3b5vMMkFJ0aPRcQ0JMHVDg4aEb0Z5B Sw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 351nr6k6xd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Nov 2020 07:11:49 -0500
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0APC1Q7i069152;
        Wed, 25 Nov 2020 07:11:49 -0500
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com with ESMTP id 351nr6k6wg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Nov 2020 07:11:48 -0500
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0APC8Z10008030;
        Wed, 25 Nov 2020 12:11:46 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04fra.de.ibm.com with ESMTP id 34xth8acey-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Nov 2020 12:11:46 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0APCBiZO2097800
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Nov 2020 12:11:44 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4B669A4040;
        Wed, 25 Nov 2020 12:11:44 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7A075A405E;
        Wed, 25 Nov 2020 12:11:40 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.183.229])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 25 Nov 2020 12:11:40 +0000 (GMT)
Date:   Wed, 25 Nov 2020 14:11:38 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     David Hildenbrand <david@redhat.com>
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
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Roman Gushchin <guro@fb.com>, Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org,
        x86@kernel.org
Subject: Re: [PATCH v12 04/10] set_memory: allow querying whether
 set_direct_map_*() is actually enabled
Message-ID: <20201125121138.GJ123287@linux.ibm.com>
References: <20201125092208.12544-1-rppt@kernel.org>
 <20201125092208.12544-5-rppt@kernel.org>
 <5ea6eacd-79e8-0645-da39-d3461f60e627@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ea6eacd-79e8-0645-da39-d3461f60e627@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-25_06:2020-11-25,2020-11-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1011
 suspectscore=1 phishscore=0 priorityscore=1501 adultscore=0 spamscore=0
 impostorscore=0 bulkscore=0 mlxscore=0 mlxlogscore=852 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011250072
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 25, 2020 at 12:22:52PM +0100, David Hildenbrand wrote:
> >  #include <asm-generic/cacheflush.h>
> >  
> >  #endif /* __ASM_CACHEFLUSH_H */
> > diff --git a/arch/arm64/include/asm/set_memory.h b/arch/arm64/include/asm/set_memory.h
> > new file mode 100644
> > index 000000000000..ecb6b0f449ab
> > --- /dev/null
> > +++ b/arch/arm64/include/asm/set_memory.h
> > @@ -0,0 +1,17 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +
> > +#ifndef _ASM_ARM64_SET_MEMORY_H
> > +#define _ASM_ARM64_SET_MEMORY_H
> > +
> > +#include <asm-generic/set_memory.h>
> > +
> > +bool can_set_direct_map(void);
> > +#define can_set_direct_map can_set_direct_map
> 
> Well, that looks weird.
> [...]

We have a lot of those e.g. in linux/pgtable.h

> >  }
> > +#else /* CONFIG_ARCH_HAS_SET_DIRECT_MAP */
> > +/*
> > + * Some architectures, e.g. ARM64 can disable direct map modifications at
> > + * boot time. Let them overrive this query.
> > + */
> > +#ifndef can_set_direct_map
> > +static inline bool can_set_direct_map(void)
> > +{
> > +	return true;
> > +}
> 
> I think we prefer __weak functions for something like that, avoids the
> ifdefery.

I'd prefer this for two reasons: first, static inline can be optimized
away and second, there is no really good place to put generic
implementation.

> Apart from that, LGTM.
> 
> -- 
> Thanks,
> 
> David / dhildenb
> 

-- 
Sincerely yours,
Mike.
