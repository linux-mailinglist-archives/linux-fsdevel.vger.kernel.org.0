Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69D672D036F
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Dec 2020 12:34:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbgLFLec (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Dec 2020 06:34:32 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:29942 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725822AbgLFLec (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Dec 2020 06:34:32 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B6BWEGF085086;
        Sun, 6 Dec 2020 06:33:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=uLfseV5BFzDmXMVMV/hSVrONSrIDY8EYPsZgh4LDO3w=;
 b=PyoHBTbfhHjuCF1oLDWBdxBcOWbCcrx0qLYyzv7yOnKgB8jexML7XfGkA98WvLEgdz9M
 5NVJEhCmmrIp3Cx/4wUBNFH/D12JYvRM6KGOh+zrPqK66oGPKD1sItX+hCPEy/g/dqx8
 1mmR3tykJNjL2hzRzO/O781IVtqWFJTVQvwgussGhs8iMkWv0vL1sYxGjdogh8qOVzX/
 SKGw534Doh9a4lhe7kZPaYQRhzkF3jPh5UqBUmeHv/oWgcvtpiXVn10MduwIQjXxq60m
 JJ3NaX0IoUFgCLFSlAYhKmodHgvNyY3naabX9laFI+MV677+t5cfrBEj9LnLb9HpaiTM Bw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 358rmxnm9b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 06 Dec 2020 06:33:30 -0500
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0B6BXGjl087843;
        Sun, 6 Dec 2020 06:33:29 -0500
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 358rmxnm8p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 06 Dec 2020 06:33:29 -0500
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0B6BVO6l024300;
        Sun, 6 Dec 2020 11:33:27 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03fra.de.ibm.com with ESMTP id 3581u8hkes-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 06 Dec 2020 11:33:27 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0B6BUtaN30933468
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 6 Dec 2020 11:30:55 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3F1ED4C046;
        Sun,  6 Dec 2020 11:30:55 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4A6284C040;
        Sun,  6 Dec 2020 11:30:51 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.50.18])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sun,  6 Dec 2020 11:30:51 +0000 (GMT)
Date:   Sun, 6 Dec 2020 13:30:48 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Mike Rapoport <rppt@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
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
        x86@kernel.org, Palmer Dabbelt <palmerdabbelt@google.com>
Subject: Re: [PATCH v14 09/10] arch, mm: wire up memfd_secret system call
 were relevant
Message-ID: <20201206113048.GC123287@linux.ibm.com>
References: <20201203062949.5484-1-rppt@kernel.org>
 <20201203062949.5484-10-rppt@kernel.org>
 <20201203153916.91f0f80dcb8a0fa81fc341fa@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201203153916.91f0f80dcb8a0fa81fc341fa@linux-foundation.org>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-06_06:2020-12-04,2020-12-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=1
 impostorscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 mlxlogscore=802 malwarescore=0 adultscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012060070
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 03, 2020 at 03:39:16PM -0800, Andrew Morton wrote:
> On Thu,  3 Dec 2020 08:29:48 +0200 Mike Rapoport <rppt@kernel.org> wrote:
> 
> > From: Mike Rapoport <rppt@linux.ibm.com>
> > 
> > Wire up memfd_secret system call on architectures that define
> > ARCH_HAS_SET_DIRECT_MAP, namely arm64, risc-v and x86.
> > 
> > ...
> >
> > --- a/include/uapi/asm-generic/unistd.h
> > +++ b/include/uapi/asm-generic/unistd.h
> > @@ -861,9 +861,13 @@ __SYSCALL(__NR_faccessat2, sys_faccessat2)
> >  __SYSCALL(__NR_process_madvise, sys_process_madvise)
> >  #define __NR_watch_mount 441
> >  __SYSCALL(__NR_watch_mount, sys_watch_mount)
> > +#ifdef __ARCH_WANT_MEMFD_SECRET
> > +#define __NR_memfd_secret 442
> > +__SYSCALL(__NR_memfd_secret, sys_memfd_secret)
> > +#endif
> 
> Why do we add the ifdef?  Can't we simply define the syscall on all
> architectures and let sys_ni do its thing?
 
I quite blindly copied it from clone3. I agree there is no real need for
it and sys_ni handles this just fine.

-- 
Sincerely yours,
Mike.
