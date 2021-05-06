Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55A9D375A68
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 May 2021 20:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbhEFStx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 May 2021 14:49:53 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:23448 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229622AbhEFStw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 May 2021 14:49:52 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 146Ie0Id095816;
        Thu, 6 May 2021 14:48:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=Wc+kGeasxC6SCjHD/hF7VUIpoQ6yJFeE+vXN7W7+C4U=;
 b=OTVCDM3WySurOF5XXn57WUpqZhxVqXaTB8D+to5XbmiwW+4XK39ESsbHdU0eKsg4gHg5
 M9m1v87wap5KMdARxbTYfS1Vkb6dmoqLJm45GOW5vi6sAw+ClYZG/Ukudm5sDTA9NOFH
 lAGH29vry4j7aTa16opQjvhkXs8HZHCle5EwO6S4TO/+JIue4T7X3+GuQjZGl4wGF28a
 Dpn1ZEybliVEIcSb0RpYDt8VtfWlWeVPFwKY1OJGaRu12yLUqdQe6uSGPBNEsPdcxhr7
 j8DvjnPv68EtoQJ8p+h5nrehmQKUKBRYJFWRnD+iSaZEYAdVycCRCmbjkhKSILB2deGB Nw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38cmsfa5we-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 May 2021 14:48:05 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 146IeELI097074;
        Thu, 6 May 2021 14:48:04 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38cmsfa5vr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 May 2021 14:48:04 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 146IcEn9017016;
        Thu, 6 May 2021 18:48:03 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
        by ppma01dal.us.ibm.com with ESMTP id 38bee1150t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 May 2021 18:48:03 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 146Im26m21758272
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 May 2021 18:48:02 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 41B3C78068;
        Thu,  6 May 2021 18:48:02 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 55FB77805F;
        Thu,  6 May 2021 18:47:49 +0000 (GMT)
Received: from jarvis (unknown [9.80.192.238])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu,  6 May 2021 18:47:49 +0000 (GMT)
Message-ID: <9e1953a1412fad06a9f7988a280d2d9a74ab0464.camel@linux.ibm.com>
Subject: Re: [PATCH v18 0/9] mm: introduce memfd_secret system call to
 create "secret" memory areas
From:   James Bottomley <jejb@linux.ibm.com>
Reply-To: jejb@linux.ibm.com
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
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
        linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org
Date:   Thu, 06 May 2021 11:47:47 -0700
In-Reply-To: <202105060916.ECDEC21@keescook>
References: <20210303162209.8609-1-rppt@kernel.org>
         <20210505120806.abfd4ee657ccabf2f221a0eb@linux-foundation.org>
         <de27bfae0f4fdcbb0bb4ad17ec5aeffcd774c44b.camel@linux.ibm.com>
         <202105060916.ECDEC21@keescook>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: g0-aeVw8NpL0zpJxkftnXh3fKMLJvIyG
X-Proofpoint-ORIG-GUID: QDTWMRO_ZYIJvGBc0eZdMSgIeAAZWI1o
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-06_10:2021-05-06,2021-05-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 clxscore=1015
 adultscore=0 mlxscore=0 bulkscore=0 impostorscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105060127
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2021-05-06 at 10:33 -0700, Kees Cook wrote:
> On Thu, May 06, 2021 at 08:26:41AM -0700, James Bottomley wrote:
[...]
> >    1. Memory safety for user space code.  Once the secret memory is
> >       allocated, the user can't accidentally pass it into the
> > kernel to be
> >       transmitted somewhere.
> 
> In my first read through, I didn't see how cross-userspace operations
> were blocked, but it looks like it's the various gup paths where
> {vma,page}_is_secretmem() is called. (Thank you for the self-test!
> That helped me follow along.) I think this access pattern should be
> more clearly spelled out in the cover later (i.e. "This will block
> things like process_vm_readv()").

I'm sure Mike can add it.

> I like the results (inaccessible outside the process), though I
> suspect this will absolutely melt gdb or other ptracers that try to
> see into the memory.

I wouldn't say "melt" ... one of the Demos we did a FOSDEM was using
gdb/ptrace to extract secrets and then showing it couldn't be done if
secret memory was used.  You can still trace the execution of the
process (and thus you could extract the secret as it's processed in
registers, for instance) but you just can't extract the actual secret
memory contents ... that's a fairly limited and well defined
restriction.

>  Don't get me wrong, I'm a big fan of such concepts[0], but I see
> nothing in the cover letter about it (e.g. the effects on "ptrace" or
> "gdb" are not mentioned.)

Sure, but we thought "secret" covered it.  It wouldn't be secret if
gdb/ptrace from another process could see it.

> There is also a risk here of this becoming a forensics nightmare:
> userspace malware will just download their entire executable region
> into a memfd_secret region. Can we, perhaps, disallow mmap/mprotect
> with PROT_EXEC when vma_is_secretmem()? The OpenSSL example, for
> example, certainly doesn't need PROT_EXEC.

I think disallowing PROT_EXEC is a great enhancement.

> What's happening with O_CLOEXEC in this code? I don't see that
> mentioned in the cover letter either. Why is it disallowed? That
> seems a strange limitation for something trying to avoid leaking
> secrets into other processes.

I actually thought we forced it, so I'll let Mike address this.  I
think allowing it is great, so the secret memory isn't inherited by
children, but I can see use cases where a process would want its child
to inherit the secrets.

> And just so I'm sure I understand: if a vma_is_secretmem() check is
> missed in future mm code evolutions, it seems there is nothing to
> block the kernel from accessing the contents directly through
> copy_from_user() via the userspace virtual address, yes?

Technically no because copy_from_user goes via the userspace page
tables which do have access.

> >    2. It also serves as a basis for context protection of virtual
> >       machines, but other groups are working on this aspect, and it
> > is
> >       broadly similar to the secret exfiltration from the kernel
> > problem.
> > 
> > > Is this intended to protect keys/etc after the attacker has
> > > gained the ability to run arbitrary kernel-mode code?  If so,
> > > that seems optimistic, doesn't it?
> > 
> > Not exactly: there are many types of kernel attack, but mostly the
> > attacker either manages to effect a privilege escalation to root or
> > gets the ability to run a ROP gadget.  The object of this code is
> > to be completely secure against root trying to extract the secret
> > (some what similar to the lockdown idea), thus defeating privilege
> > escalation and to provide "sufficient" protection against ROP
> > gadgets.
> > 
> > The ROP gadget thing needs more explanation: the usual defeatist
> > approach is to say that once the attacker gains the stack, they can
> > do anything because they can find enough ROP gadgets to be turing
> > complete.  However, in the real world, given the kernel stack size
> > limit and address space layout randomization making finding gadgets
> > really hard, usually the attacker gets one or at most two gadgets
> > to string together.  Not having any in-kernel primitive for
> > accessing secret memory means the one gadget ROP attack can't
> > work.  Since the only way to access secret memory is to reconstruct
> > the missing mapping entry, the attacker has to recover the physical
> > page and insert a PTE pointing to it in the kernel and then
> > retrieve the contents.  That takes at least three gadgets which is
> > a level of difficulty beyond most standard attacks.
> 
> As for protecting against exploited kernel flaws I also see benefits
> here. While the kernel is already blocked from directly reading
> contents from userspace virtual addresses (i.e. SMAP), this feature
> does help by blocking the kernel from directly reading contents via
> the direct map alias. (i.e. this feature is a specialized version of
> XPFO[1], which tried to do this for ALL user memory.) So in that
> regard, yes, this has value in the sense that to perform
> exfiltration, an attacker would need a significant level of control
> over kernel execution or over page table contents.
> 
> Sufficient control over PTE allocation and positioning is possible
> without kernel execution control[3], and "only" having an arbitrary
> write primitive can lead to direct PTE control. Because of this, it
> would be nice to have page tables strongly protected[2] in the
> kernel. They remain a viable "data only" attack given a sufficiently
> "capable" write flaw.

Right, but this is on the radar of several people and when fixed will
strengthen the value of secret memory.

> I would argue that page table entries are a more important asset to
> protect than userspace secrets, but given the difficulties with XPFO
> and the not-yet-available PKS I can understand starting here. It
> does, absolutely, narrow the ways exploits must be written to
> exfiltrate secret contents. (We are starting to now constrict[4] many
> attack methods into attacking the page table itself, which is good in
> the sense that protecting page tables will be a big win, and bad in
> the sense that focusing attack research on page tables means we're
> going to see some very powerful attacks.)
> 
> > > I think that a very complete description of the threats which
> > > this feature addresses would be helpful.  
> > 
> > It's designed to protect against three different threats:
> > 
> >    1. Detection of user secret memory mismanagement
> 
> I would say "cross-process secret userspace memory exposures" (via a
> number of common interfaces by blocking it at the GUP level).
> 
> >    2. significant protection against privilege escalation
> 
> I don't see how this series protects against privilege escalation.
> (It protects against exfiltration.) Maybe you mean include this in
> the first bullet point (i.e. "cross-process secret userspace memory
> exposures, even in the face of privileged processes")?

It doesn't prevent privilege escalation from happening in the first
place, but once the escalation has happened it protects against
exfiltration by the newly minted root attacker.

> >    3. enhanced protection (in conjunction with all the other in-
> > kernel
> >       attack prevention systems) against ROP attacks.
> 
> Same here, I don't see it preventing ROP, but I see it making
> "simple" ROP insufficient to perform exfiltration.

Right, that's why I call it "enhanced protection".  With ROP the design
goal is to take exfiltration beyond the simple, and require increasing
complexity in the attack ... the usual security whack-a-mole approach
... in the hope that script kiddies get bored by the level of
difficulty and move on to something easier.

James


