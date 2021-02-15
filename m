Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAEC931C154
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Feb 2021 19:17:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbhBOSQj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Feb 2021 13:16:39 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41900 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230462AbhBOSQP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Feb 2021 13:16:15 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 11FI3keQ089147;
        Mon, 15 Feb 2021 13:14:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=oGpfBMoJflzNtTxXhAAqknfbJZwwOWhWibJHXOD15mY=;
 b=B/bnia+10Cs1nS5Q/upnquv2ZqXghmk3a6oXvIJu1bYAT9fq48cugx6TbeiTQlsj7qZM
 r9narncQVfykPHEyJHuo45qRrCnDhJP4fLWXNTzh+wRkWX5CekXlUGk5CLJznaZt6huP
 QS1lVTZ4HiwSm6Zccy5axTKKb4qK9kdk4mVKgXfsgW4HArxGrxT1EA/Pn6mTps4Vjfvm
 m0YOQFc0aWwzXwNK3mVbIys228lxpSUTYg08cJcpzpHT4PcHyChXHf6by4iByZs77BV9
 yKmIzsatDpKh4JWGLHQGoDjjCqXOeQXIJU15C840vpqciQ/nRrzDNGV2nbGbjXU11G1r lA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36qww5gb83-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Feb 2021 13:14:55 -0500
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 11FI4Lrj090689;
        Mon, 15 Feb 2021 13:14:54 -0500
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36qww5gb7m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Feb 2021 13:14:54 -0500
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11FICq9U024338;
        Mon, 15 Feb 2021 18:14:53 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma02dal.us.ibm.com with ESMTP id 36p6d9d37g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Feb 2021 18:14:53 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11FIEph216515450
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Feb 2021 18:14:51 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C21B67806A;
        Mon, 15 Feb 2021 18:14:51 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CA8027805E;
        Mon, 15 Feb 2021 18:14:44 +0000 (GMT)
Received: from jarvis.int.hansenpartnership.com (unknown [9.85.199.127])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 15 Feb 2021 18:14:44 +0000 (GMT)
Message-ID: <be1d821d3f0aec24ad13ca7126b4359822212eb0.camel@linux.ibm.com>
Subject: Re: [PATCH v17 07/10] mm: introduce memfd_secret system call to
 create "secret" memory areas
From:   James Bottomley <jejb@linux.ibm.com>
Reply-To: jejb@linux.ibm.com
To:     Michal Hocko <mhocko@suse.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
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
Date:   Mon, 15 Feb 2021 10:14:43 -0800
In-Reply-To: <YCo7TqUnBdgJGkwN@dhcp22.suse.cz>
References: <20210214091954.GM242749@kernel.org>
         <052DACE9-986B-424C-AF8E-D6A4277DE635@redhat.com>
         <244f86cba227fa49ca30cd595c4e5538fe2f7c2b.camel@linux.ibm.com>
         <YCo7TqUnBdgJGkwN@dhcp22.suse.cz>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-15_14:2021-02-12,2021-02-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 adultscore=0 phishscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102150137
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2021-02-15 at 10:13 +0100, Michal Hocko wrote:
> On Sun 14-02-21 11:21:02, James Bottomley wrote:
> > On Sun, 2021-02-14 at 10:58 +0100, David Hildenbrand wrote:
> > [...]
> > > > And here we come to the question "what are the differences that
> > > > justify a new system call?" and the answer to this is very
> > > > subjective. And as such we can continue bikeshedding forever.
> > > 
> > > I think this fits into the existing memfd_create() syscall just
> > > fine, and I heard no compelling argument why it shouldn‘t. That‘s
> > > all I can say.
> > 
> > OK, so let's review history.  In the first two incarnations of the
> > patch, it was an extension of memfd_create().  The specific
> > objection by Kirill Shutemov was that it doesn't share any code in
> > common with memfd and so should be a separate system call:
> > 
> > https://lore.kernel.org/linux-api/20200713105812.dnwtdhsuyj3xbh4f@box/
> 
> Thanks for the pointer. But this argument hasn't been challenged at
> all. It hasn't been brought up that the overlap would be considerable
> higher by the hugetlb/sealing support. And so far nobody has claimed
> those combinations as unviable.

Kirill is actually interested in the sealing path for his KVM code so
we took a look.  There might be a two line overlap in memfd_create for
the seal case, but there's no real overlap in memfd_add_seals which is
the bulk of the code.  So the best way would seem to lift the inode ...
-> seals helpers to be non-static so they can be reused and roll our
own add_seals.

I can't see a use case at all for hugetlb support, so it seems to be a
bit of an angels on pin head discussion.  However, if one were to come
along handling it in the same way seems reasonable.

> > The other objection raised offlist is that if we do use
> > memfd_create, then we have to add all the secret memory flags as an
> > additional ioctl, whereas they can be specified on open if we do a
> > separate system call.  The container people violently objected to
> > the ioctl because it can't be properly analysed by seccomp and much
> > preferred the syscall version.
> > 
> > Since we're dumping the uncached variant, the ioctl problem
> > disappears but so does the possibility of ever adding it back if we
> > take on the container peoples' objection.  This argues for a
> > separate syscall because we can add additional features and extend
> > the API with flags without causing anti-ioctl riots.
> 
> I am sorry but I do not understand this argument.

You don't understand why container guarding technology doesn't like
ioctls?  The problem is each ioctl is the multiplexor is specific to
the particular fd implementation, so unlike fcntl you don't have global
ioctl numbers (although we do try to separate the space somewhat with
the _IO macros).  This makes analysis and blocking a hard problem for
container seccomp.

>  What kind of flags are we talking about and why would that be a
> problem with memfd_create interface? Could you be more specific
> please?

You mean what were the ioctl flags in the patch series linked above? 
They were SECRETMEM_EXCLUSIVE and SECRETMEM_UNCACHED in patch 3/5. 
They were eventually dropped after v10, because of problems with
architectural semantics, with the idea that it could be added back
again if a compelling need arose:

https://lore.kernel.org/linux-api/20201123095432.5860-1-rppt@kernel.org/

In theory the extra flags could be multiplexed into the memfd_create
flags like hugetlbfs is but with 32 flags and a lot already taken it
gets messy for expansion.  When we run out of flags the first question
people will ask is "why didn't you do separate system calls?".

James



