Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A97D37572C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 May 2021 17:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235341AbhEFPap (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 May 2021 11:30:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:25670 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235593AbhEFP2m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 May 2021 11:28:42 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 146F6QQk151323;
        Thu, 6 May 2021 11:26:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=sjoZoiMhBl/YeAs7nylvrqucKRtz6t+UYFLBf4hwx58=;
 b=HNnR1WbtcErDOmskKqlTooqNTP1IivLAtx4QS4CKp6cKX+kgP4zQvoFZWL5AVg264ZTj
 /8JlRuQgWTJqNrDCfS3qB6iutm3wRUwNb5gT6wRvkj7xEihLZiVwqPsEQ8ad6kAutzc1
 vWXExVZgy6ss+xtA+6SYXg/ZOVdbIsgx2CKiIb7wGnIwmvj1GGrO7ifiBh9RhnmDdNoJ
 LMoRMK0OqojDRTYJuBf4qF8l+Q7nlnlOocgvLdq3bMaE1Oq4M0+Eg7+ihwCtwfSxcest
 1EoxjQ/XX+Q78+58ZXnBQCbBu5x4dPi1zM0YuMj7+PuRZF52CyumY9KDrfdHysz7ZluW Mw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38cjhps4q7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 May 2021 11:26:58 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 146F7KKD161033;
        Thu, 6 May 2021 11:26:58 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38cjhps4pf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 May 2021 11:26:57 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 146FLr4I023803;
        Thu, 6 May 2021 15:26:56 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma04dal.us.ibm.com with ESMTP id 38bedtysuw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 May 2021 15:26:56 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 146FQtK516646530
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 May 2021 15:26:55 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 71AB07805E;
        Thu,  6 May 2021 15:26:55 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 50AA17805C;
        Thu,  6 May 2021 15:26:43 +0000 (GMT)
Received: from jarvis (unknown [9.80.192.238])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu,  6 May 2021 15:26:42 +0000 (GMT)
Message-ID: <de27bfae0f4fdcbb0bb4ad17ec5aeffcd774c44b.camel@linux.ibm.com>
Subject: Re: [PATCH v18 0/9] mm: introduce memfd_secret system call to
 create "secret" memory areas
From:   James Bottomley <jejb@linux.ibm.com>
Reply-To: jejb@linux.ibm.com
To:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
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
        x86@kernel.org
Date:   Thu, 06 May 2021 08:26:41 -0700
In-Reply-To: <20210505120806.abfd4ee657ccabf2f221a0eb@linux-foundation.org>
References: <20210303162209.8609-1-rppt@kernel.org>
         <20210505120806.abfd4ee657ccabf2f221a0eb@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: HbXsy0ifNJ0qG09HbRm_LXazjxQbp5n0
X-Proofpoint-ORIG-GUID: DJupxtqPHyyQ3Z1xYY6MEK2xJzvjhhcP
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-06_10:2021-05-06,2021-05-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 clxscore=1011 mlxlogscore=999 lowpriorityscore=0 priorityscore=1501
 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105060108
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2021-05-05 at 12:08 -0700, Andrew Morton wrote:
> On Wed,  3 Mar 2021 18:22:00 +0200 Mike Rapoport <rppt@kernel.org>
> wrote:
> 
> > This is an implementation of "secret" mappings backed by a file
> > descriptor.
> > 
> > The file descriptor backing secret memory mappings is created using
> > a dedicated memfd_secret system call The desired protection mode
> > for the memory is configured using flags parameter of the system
> > call. The mmap() of the file descriptor created with memfd_secret()
> > will create a "secret" memory mapping. The pages in that mapping
> > will be marked as not present in the direct map and will be present
> > only in the page table of the owning mm.
> > 
> > Although normally Linux userspace mappings are protected from other
> > users, such secret mappings are useful for environments where a
> > hostile tenant is trying to trick the kernel into giving them
> > access to other tenants mappings.
> 
> I continue to struggle with this and I don't recall seeing much
> enthusiasm from others.  Perhaps we're all missing the value point
> and some additional selling is needed.
> 
> Am I correct in understanding that the overall direction here is to
> protect keys (and perhaps other things) from kernel bugs?  That if
> the kernel was bug-free then there would be no need for this
> feature?  If so, that's a bit sad.  But realistic I guess.

Secret memory really serves several purposes. The "increase the level
of difficulty of secret exfiltration" you describe.  And, as you say,
if the kernel were bug free this wouldn't be necessary.

But also:

   1. Memory safety for use space code.  Once the secret memory is
      allocated, the user can't accidentally pass it into the kernel to be
      transmitted somewhere.
   2. It also serves as a basis for context protection of virtual
      machines, but other groups are working on this aspect, and it is
      broadly similar to the secret exfiltration from the kernel problem.

> 
> Is this intended to protect keys/etc after the attacker has gained
> the ability to run arbitrary kernel-mode code?  If so, that seems
> optimistic, doesn't it?

Not exactly: there are many types of kernel attack, but mostly the
attacker either manages to effect a privilege escalation to root or
gets the ability to run a ROP gadget.  The object of this code is to be
completely secure against root trying to extract the secret (some what
similar to the lockdown idea), thus defeating privilege escalation and
to provide "sufficient" protection against ROP gadgets.

The ROP gadget thing needs more explanation: the usual defeatist
approach is to say that once the attacker gains the stack, they can do
anything because they can find enough ROP gadgets to be turing
complete.  However, in the real world, given the kernel stack size
limit and address space layout randomization making finding gadgets
really hard, usually the attacker gets one or at most two gadgets to
string together.  Not having any in-kernel primitive for accessing
secret memory means the one gadget ROP attack can't work.  Since the
only way to access secret memory is to reconstruct the missing mapping
entry, the attacker has to recover the physical page and insert a PTE
pointing to it in the kernel and then retrieve the contents.  That
takes at least three gadgets which is a level of difficulty beyond most
standard attacks.

> I think that a very complete description of the threats which this
> feature addresses would be helpful.  

It's designed to protect against three different threats:

   1. Detection of user secret memory mismanagement
   2. significant protection against privilege escalation
   3. enhanced protection (in conjunction with all the other in-kernel
      attack prevention systems) against ROP attacks.

Do you want us to add this to one of the patch descriptions?

James


