Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 931BD226EDB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jul 2020 21:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730863AbgGTTRP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jul 2020 15:17:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:7852 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726899AbgGTTRO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jul 2020 15:17:14 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06KJ3Kws110242;
        Mon, 20 Jul 2020 15:16:36 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32d5h7y11u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Jul 2020 15:16:36 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06KJ3QeO110872;
        Mon, 20 Jul 2020 15:16:35 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32d5h7y11c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Jul 2020 15:16:35 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06KJ6AQW029169;
        Mon, 20 Jul 2020 19:16:34 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma03dal.us.ibm.com with ESMTP id 32brq90hx8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Jul 2020 19:16:34 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06KJGWTR38207870
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Jul 2020 19:16:32 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 41D1D78064;
        Mon, 20 Jul 2020 19:16:32 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 55DB078066;
        Mon, 20 Jul 2020 19:16:26 +0000 (GMT)
Received: from [153.66.254.194] (unknown [9.85.132.116])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 20 Jul 2020 19:16:26 +0000 (GMT)
Message-ID: <1595272585.4554.28.camel@linux.ibm.com>
Subject: Re: [PATCH 3/6] mm: introduce secretmemfd system call to create
 "secret" memory areas
From:   James Bottomley <jejb@linux.ibm.com>
Reply-To: jejb@linux.ibm.com
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Mike Rapoport <rppt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Idan Yaniv <idan.yaniv@ibm.com>,
        Ingo Molnar <mingo@redhat.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, linux-nvdimm@lists.01.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        linaro-mm-sig@lists.linaro.org,
        Sumit Semwal <sumit.semwal@linaro.org>
Date:   Mon, 20 Jul 2020 12:16:25 -0700
In-Reply-To: <CAK8P3a34kx4aAFY=-SBHX3suCLwxeZY7+YSRzct93YM_OFbSWA@mail.gmail.com>
References: <20200720092435.17469-1-rppt@kernel.org>
         <20200720092435.17469-4-rppt@kernel.org>
         <CAK8P3a0NyvRMqH7X0YNO5E6DGtvZXD5ZcD6Y6n7AkocufkMnHA@mail.gmail.com>
         <1595260305.4554.9.camel@linux.ibm.com>
         <CAK8P3a34kx4aAFY=-SBHX3suCLwxeZY7+YSRzct93YM_OFbSWA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-20_09:2020-07-20,2020-07-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 clxscore=1015 mlxscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007200128
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2020-07-20 at 20:08 +0200, Arnd Bergmann wrote:
> On Mon, Jul 20, 2020 at 5:52 PM James Bottomley <jejb@linux.ibm.com>
> wrote:
> > On Mon, 2020-07-20 at 13:30 +0200, Arnd Bergmann wrote:
> > 
> > I'll assume you mean the dmabuf userspace API?  Because the kernel
> > API is completely device exchange specific and wholly inappropriate
> > for this use case.
> > 
> > The user space API of dmabuf uses a pseudo-filesystem.  So you
> > mount the dmabuf file type (and by "you" I mean root because an
> > ordinary user doesn't have sufficient privilege).  This is
> > basically because every dmabuf is usable by any user who has
> > permissions.  This really isn't the initial interface we want for
> > secret memory because secret regions are supposed to be per process
> > and not shared (at least we don't want other tenants to see who's
> > using what).
> > 
> > Once you have the fd, you can seek to find the size, mmap, poll and
> > ioctl it.  The ioctls are all to do with memory synchronization (as
> > you'd expect from a device backed region) and the mmap is handled
> > by the dma_buf_ops, which is device specific.  Sizing is missing
> > because that's reported by the device not settable by the user.
> 
> I was mainly talking about the in-kernel interface that is used for
> sharing a buffer with hardware. Aside from the limited ioctls,
> anything in the kernel can decide on how it wants to export a dma_buf
> by calling dma_buf_export()/dma_buf_fd(), which is roughly what the
> new syscall does as well. Using dma_buf vs the proposed
> implementation for this is not a big difference in complexity.

I have thought about it, but haven't got much further:  We can't couple
to SGX without a huge break in the current simple userspace API (it
becomes complex because you'd have to enter the enclave each time you
want to use the memory, or put the whole process in the enclave, which
is a bit of a nightmare for simplicity), and we could only couple it to
SEV if the memory encryption engine would respond to PCID as well as
ASID, which it doesn't.

> The one thing that a dma_buf does is that it allows devices to
> do DMA on it. This is either something that can turn out to be
> useful later, or it is not. From the description, it sounded like
> the sharing might be useful, since we already have known use
> cases in which "secret" data is exchanged with a trusted execution
> environment using the dma-buf interface.

The current use case for private keys is that you take an encrypted
file (which would be the DMA coupled part) and you decrypt the contents
into the secret memory.  There might possibly be a DMA component later
where a HSM like device DMAs a key directly into your secret memory to
avoid exposure, but I wouldn't anticipate any need for anything beyond
the usual page cache API for that case (effectively this would behave
like an ordinary page cache page except that only the current process
would be able to touch the contents).

> If there is no way the data stored in this new secret memory area
> would relate to secret data in a TEE or some other hardware
> device, then I agree that dma-buf has no value.

Never say never, but current TEE designs tend to require full
confidentiality for the entire execution.  What we're probing is
whether we can improve security by doing an API that requires less than
full confidentiality for the process.  I think if the API proves useful
then we will get HW support for it, but it likely won't be in the
current TEE of today form.

> > What we want is the ability to get an fd, set the properties and
> > the size and mmap it.  This is pretty much a 100% overlap with the
> > memfd API and not much overlap with the dmabuf one, which is why I
> > don't think the interface is very well suited.
> 
> Does that mean you are suggesting to use additional flags on
> memfd_create() instead of a new system call?

Well, that was what the previous patch did.  I'm agnostic on the
mechanism for obtaining the fd: new syscall as this patch does or
extension to memfd like the old one did.  All I was saying is that once
you have the fd, the API you use on it is the same as the memfd API.

James

