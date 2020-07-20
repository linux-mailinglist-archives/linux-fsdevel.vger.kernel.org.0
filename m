Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C02E226552
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jul 2020 17:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731414AbgGTPwu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jul 2020 11:52:50 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:25962 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731115AbgGTPwt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:52:49 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06KFZClQ100188;
        Mon, 20 Jul 2020 11:51:58 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32d5h7sk2a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Jul 2020 11:51:57 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06KFaXMR110773;
        Mon, 20 Jul 2020 11:51:57 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32d5h7sk1c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Jul 2020 11:51:57 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06KFYvFQ012130;
        Mon, 20 Jul 2020 15:51:55 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma02wdc.us.ibm.com with ESMTP id 32brq8tb75-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 20 Jul 2020 15:51:55 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06KFps6657934112
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Jul 2020 15:51:54 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5A87178060;
        Mon, 20 Jul 2020 15:51:54 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ED0747805E;
        Mon, 20 Jul 2020 15:51:46 +0000 (GMT)
Received: from [153.66.254.194] (unknown [9.85.132.116])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 20 Jul 2020 15:51:46 +0000 (GMT)
Message-ID: <1595260305.4554.9.camel@linux.ibm.com>
Subject: Re: [PATCH 3/6] mm: introduce secretmemfd system call to create
 "secret" memory areas
From:   James Bottomley <jejb@linux.ibm.com>
Reply-To: jejb@linux.ibm.com
To:     Arnd Bergmann <arnd@arndb.de>, Mike Rapoport <rppt@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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
Date:   Mon, 20 Jul 2020 08:51:45 -0700
In-Reply-To: <CAK8P3a0NyvRMqH7X0YNO5E6DGtvZXD5ZcD6Y6n7AkocufkMnHA@mail.gmail.com>
References: <20200720092435.17469-1-rppt@kernel.org>
         <20200720092435.17469-4-rppt@kernel.org>
         <CAK8P3a0NyvRMqH7X0YNO5E6DGtvZXD5ZcD6Y6n7AkocufkMnHA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-20_09:2020-07-20,2020-07-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 clxscore=1011 mlxscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007200106
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2020-07-20 at 13:30 +0200, Arnd Bergmann wrote:
> On Mon, Jul 20, 2020 at 11:25 AM Mike Rapoport <rppt@kernel.org>
> wrote:
> > 
> > From: Mike Rapoport <rppt@linux.ibm.com>
> > 
> > Introduce "secretmemfd" system call with the ability to create
> > memory areas visible only in the context of the owning process and
> > not mapped not only to other processes but in the kernel page
> > tables as well.
> > 
> > The user will create a file descriptor using the secretmemfd system
> > call where flags supplied as a parameter to this system call will
> > define the desired protection mode for the memory associated with
> > that file descriptor. Currently there are two protection modes:
> > 
> > * exclusive - the memory area is unmapped from the kernel direct
> > map and it
> >               is present only in the page tables of the owning mm.
> > * uncached  - the memory area is present only in the page tables of
> > the
> >               owning mm and it is mapped there as uncached.
> > 
> > For instance, the following example will create an uncached mapping
> > (error handling is omitted):
> > 
> >         fd = secretmemfd(SECRETMEM_UNCACHED);
> >         ftruncate(fd, MAP_SIZE);
> >         ptr = mmap(NULL, MAP_SIZE, PROT_READ | PROT_WRITE,
> > MAP_SHARED,
> >                    fd, 0);
> > 
> > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> 
> I wonder if this should be more closely related to dmabuf file
> descriptors, which are already used for a similar purpose: sharing
> access to secret memory areas that are not visible to the OS but can
> be shared with hardware through device drivers that can import a
> dmabuf file descriptor.

I'll assume you mean the dmabuf userspace API?  Because the kernel API
is completely device exchange specific and wholly inappropriate for
this use case.

The user space API of dmabuf uses a pseudo-filesystem.  So you mount
the dmabuf file type (and by "you" I mean root because an ordinary user
doesn't have sufficient privilege).  This is basically because every
dmabuf is usable by any user who has permissions.  This really isn't
the initial interface we want for secret memory because secret regions
are supposed to be per process and not shared (at least we don't want
other tenants to see who's using what).

Once you have the fd, you can seek to find the size, mmap, poll and
ioctl it.  The ioctls are all to do with memory synchronization (as
you'd expect from a device backed region) and the mmap is handled by
the dma_buf_ops, which is device specific.  Sizing is missing because
that's reported by the device not settable by the user.

What we want is the ability to get an fd, set the properties and the
size and mmap it.  This is pretty much a 100% overlap with the memfd
API and not much overlap with the dmabuf one, which is why I don't
think the interface is very well suited.

James

