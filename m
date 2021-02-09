Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 268B0314B48
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Feb 2021 10:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbhBIJQW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Feb 2021 04:16:22 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45608 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230073AbhBIJLj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Feb 2021 04:11:39 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 11991fui072494;
        Tue, 9 Feb 2021 04:09:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=EHJFlpAl6bxu+/XsIT5Z7pM+ru+nVQxvK4bFODgahCc=;
 b=nC8X0qp4OoxlR6jW823vmsITpQTEAmS32wsTXOMwr6MgiMDKMF+T0SfxQmKvMS1r4tQx
 oaHvPKwwyhjPrQ1ls9r8bXZhj9kG4LQ3+27uGJzTnyC5BDalNTsnWkQ0iERM2RfOfdzX
 +kGQ0D7dgzoXNgDH7sjGbudmhRD5mU9T1f13R6nLcRnM+x+IlLRjaiEhMTyilsMvjA5y
 CyOkDStqMO7H9a1vj/cHLJZwkQChdF2/TVezOOjj8gX+2PCZgLxUTZBhZth0ULMvgo2t
 EhfllRPKgQtT9EsDS4AL7uvAPMZ1P78Sb19dUBRxkZpke+tbkT62POzf8AHb0k/yNbvE MQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36kq41ruy8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Feb 2021 04:09:54 -0500
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 11992fU3077916;
        Tue, 9 Feb 2021 04:09:53 -0500
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36kq41ruuj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Feb 2021 04:09:53 -0500
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 1198Nc1g016786;
        Tue, 9 Feb 2021 09:09:49 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma01fra.de.ibm.com with ESMTP id 36hjr81jg3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Feb 2021 09:09:49 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11999kO332768396
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 9 Feb 2021 09:09:46 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B3616A405B;
        Tue,  9 Feb 2021 09:09:46 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CD9CDA4054;
        Tue,  9 Feb 2021 09:09:40 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.178.60])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue,  9 Feb 2021 09:09:40 +0000 (GMT)
Date:   Tue, 9 Feb 2021 11:09:38 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Michal Hocko <mhocko@suse.com>
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
        x86@kernel.org, Hagen Paul Pfeifer <hagen@jauu.net>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Subject: Re: [PATCH v17 07/10] mm: introduce memfd_secret system call to
 create "secret" memory areas
Message-ID: <20210209090938.GP299309@linux.ibm.com>
References: <20210208084920.2884-1-rppt@kernel.org>
 <20210208084920.2884-8-rppt@kernel.org>
 <YCEXMgXItY7xMbIS@dhcp22.suse.cz>
 <20210208212605.GX242749@kernel.org>
 <YCJMDBss8Qhha7g9@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YCJMDBss8Qhha7g9@dhcp22.suse.cz>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-09_02:2021-02-09,2021-02-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 spamscore=0 impostorscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=762
 phishscore=0 adultscore=0 clxscore=1011 bulkscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102090040
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 09, 2021 at 09:47:08AM +0100, Michal Hocko wrote:
> On Mon 08-02-21 23:26:05, Mike Rapoport wrote:
> > On Mon, Feb 08, 2021 at 11:49:22AM +0100, Michal Hocko wrote:
> > > On Mon 08-02-21 10:49:17, Mike Rapoport wrote:
> [...]
> > > > The file descriptor based memory has several advantages over the
> > > > "traditional" mm interfaces, such as mlock(), mprotect(), madvise(). It
> > > > paves the way for VMMs to remove the secret memory range from the process;
> > > 
> > > I do not understand how it helps to remove the memory from the process
> > > as the interface explicitly allows to add a memory that is removed from
> > > all other processes via direct map.
> > 
> > The current implementation does not help to remove the memory from the
> > process, but using fd-backed memory seems a better interface to remove
> > guest memory from host mappings than mmap. As Andy nicely put it:
> > 
> > "Getting fd-backed memory into a guest will take some possibly major work in
> > the kernel, but getting vma-backed memory into a guest without mapping it
> > in the host user address space seems much, much worse."
> 
> OK, so IIUC this means that the model is to hand over memory from host
> to guest. I thought the guest would be under control of its address
> space and therefore it operates on the VMAs. This would benefit from
> an additional and more specific clarification.

How guest would operate on VMAs if the interface between host and guest is
virtual hardware?

If you mean qemu (or any other userspace part of VMM that uses KVM), so one
of the points Andy mentioned back than is to remove mappings of the guest
memory from the qemu process.
 
> > > > As secret memory implementation is not an extension of tmpfs or hugetlbfs,
> > > > usage of a dedicated system call rather than hooking new functionality into
> > > > memfd_create(2) emphasises that memfd_secret(2) has different semantics and
> > > > allows better upwards compatibility.
> > > 
> > > What is this supposed to mean? What are differences?
> > 
> > Well, the phrasing could be better indeed. That supposed to mean that
> > they differ in the semantics behind the file descriptor: memfd_create
> > implements sealing for shmem and hugetlbfs while memfd_secret implements
> > memory hidden from the kernel.
> 
> Right but why memfd_create model is not sufficient for the usecase?
> Please note that I am arguing against. To be honest I do not really care
> much. Using an existing scheme is usually preferable from my POV but
> there might be real reasons why shmem as a backing "storage" is not
> appropriate.
   
Citing my older email:

    I've hesitated whether to continue to use new flags to memfd_create() or to
    add a new system call and I've decided to use a new system call after I've
    started to look into man pages update. There would have been two completely
    independent descriptions and I think it would have been very confusing.

-- 
Sincerely yours,
Mike.
