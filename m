Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06E1768E10
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2019 16:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732949AbfGOODi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Jul 2019 10:03:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53536 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1733058AbfGOOD2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Jul 2019 10:03:28 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6FDwjPe098933
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jul 2019 10:03:27 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2trsjdw5uy-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jul 2019 10:03:27 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <pasic@linux.ibm.com>;
        Mon, 15 Jul 2019 15:03:25 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 15 Jul 2019 15:03:20 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6FE3JR555574606
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Jul 2019 14:03:19 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1F3BCA4053;
        Mon, 15 Jul 2019 14:03:19 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8BB8AA404D;
        Mon, 15 Jul 2019 14:03:18 +0000 (GMT)
Received: from oc2783563651 (unknown [9.152.224.43])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 15 Jul 2019 14:03:18 +0000 (GMT)
Date:   Mon, 15 Jul 2019 16:03:17 +0200
From:   Halil Pasic <pasic@linux.ibm.com>
To:     Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>
Cc:     x86@kernel.org, iommu@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Mike Anderson <andmike@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>,
        "Lendacky\, Thomas" <thomas.lendacky@amd.com>
Subject: Re: [PATCH 3/3] fs/core/vmcore: Move sev_active() reference to x86
 arch code
In-Reply-To: <87tvbqgboc.fsf@morokweng.localdomain>
References: <20190712053631.9814-1-bauerman@linux.ibm.com>
        <20190712053631.9814-4-bauerman@linux.ibm.com>
        <20190712150912.3097215e.pasic@linux.ibm.com>
        <87tvbqgboc.fsf@morokweng.localdomain>
Organization: IBM
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19071514-4275-0000-0000-0000034D26BA
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19071514-4276-0000-0000-0000385D35C5
Message-Id: <20190715160317.7e3dfb33.pasic@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-15_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907150167
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 12 Jul 2019 18:55:47 -0300
Thiago Jung Bauermann <bauerman@linux.ibm.com> wrote:

> 
> [ Cc'ing Tom Lendacky which I forgot to do earlier. Sorry about that. ]
> 
> Hello Halil,
> 
> Thanks for the quick review.
> 
> Halil Pasic <pasic@linux.ibm.com> writes:
> 
> > On Fri, 12 Jul 2019 02:36:31 -0300
> > Thiago Jung Bauermann <bauerman@linux.ibm.com> wrote:
> >
> >> Secure Encrypted Virtualization is an x86-specific feature, so it shouldn't
> >> appear in generic kernel code because it forces non-x86 architectures to
> >> define the sev_active() function, which doesn't make a lot of sense.
> >
> > sev_active() might be just bad (too specific) name for a general
> > concept. s390 code defines it drives the right behavior in
> > kernel/dma/direct.c (which uses it).
> 
> I thought about that but couldn't put my finger on a general concept.
> Is it "guest with memory inaccessible to the host"?
> 

Well, force_dma_unencrypted() is a much better name thatn sev_active():
s390 has no AMD SEV, that is sure, but for virtio to work we do need to
make our dma accessible to the hypervisor. Yes, your "guest with memory
inaccessible to the host" shows into the right direction IMHO.
Unfortunately I don't have too many cycles to spend on this right now.

> Since your proposed definiton for force_dma_unencrypted() is simply to
> make it equivalent to sev_active(), I thought it was more
> straightforward to make each arch define force_dma_unencrypted()
> directly.

I did not mean to propose equivalence. I intended to say the name
sev_active() is not suitable for a common concept. On the other hand
we do have a common concept -- as common code needs to do or not do
things depending on whether "memory is protected/encrypted" or not. I'm
fine with the name force_dma_unencrypted(), especially because I don't
have a better name.

> 
> Also, does sev_active() drive the right behavior for s390 in
> elfcorehdr_read() as well?
> 

AFAIU, since s390 does not override it boils down to the same, whether
sev_active() returns true or false. I'm no expert in that area, but I
strongly hope that is the right behavior. @Janosch: can you help me
out with this one?

> >> To solve this problem, add an x86 elfcorehdr_read() function to override
> >> the generic weak implementation. To do that, it's necessary to make
> >> read_from_oldmem() public so that it can be used outside of vmcore.c.
> >>
> >> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> >> ---
> >>  arch/x86/kernel/crash_dump_64.c |  5 +++++
> >>  fs/proc/vmcore.c                |  8 ++++----
> >>  include/linux/crash_dump.h      | 14 ++++++++++++++
> >>  include/linux/mem_encrypt.h     |  1 -
> >>  4 files changed, 23 insertions(+), 5 deletions(-)
> >
> > Does not seem to apply to today's or yesterdays master.
> 
> It assumes the presence of the two patches I mentioned in the cover
> letter. Only one of them is in master.
> 
> I hadn't realized the s390 virtio patches were on their way to upstream.
> I was keeping an eye on the email thread but didn't see they were picked
> up in the s390 pull request. I'll add a new patch to this series making
> the corresponding changes to s390's <asm/mem_encrypt.h> as well.
> 

Being on cc for your patch made me realize that things got broken on
s390. Thanks! I've sent out a patch that fixes protvirt, but we are going
to benefit from your cleanups. I think with your cleanups and that patch
of mine both sev_active() and sme_active() can be removed. Feel free to
do so. If not, I can attend to it as well.

Regards,
Halil

