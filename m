Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 901AD6729F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jul 2019 17:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbfGLPnA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Jul 2019 11:43:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39154 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726867AbfGLPnA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Jul 2019 11:43:00 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6CFTFPt119608
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jul 2019 11:42:58 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tpu50ds2s-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jul 2019 11:42:58 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <pasic@linux.ibm.com>;
        Fri, 12 Jul 2019 16:42:56 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 12 Jul 2019 16:42:52 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6CFgo9535914004
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Jul 2019 15:42:50 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B7FE1A4051;
        Fri, 12 Jul 2019 15:42:50 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3D052A404D;
        Fri, 12 Jul 2019 15:42:50 +0000 (GMT)
Received: from oc2783563651 (unknown [9.152.224.222])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 12 Jul 2019 15:42:50 +0000 (GMT)
Date:   Fri, 12 Jul 2019 17:42:49 +0200
From:   Halil Pasic <pasic@linux.ibm.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Thiago Jung Bauermann <bauerman@linux.ibm.com>, x86@kernel.org,
        iommu@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Mike Anderson <andmike@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>
Subject: Re: [PATCH 3/3] fs/core/vmcore: Move sev_active() reference to x86
 arch code
In-Reply-To: <20190712151129.GA30636@lst.de>
References: <20190712053631.9814-1-bauerman@linux.ibm.com>
        <20190712053631.9814-4-bauerman@linux.ibm.com>
        <20190712150912.3097215e.pasic@linux.ibm.com>
        <20190712140812.GA29628@lst.de>
        <20190712165153.78d49095.pasic@linux.ibm.com>
        <20190712151129.GA30636@lst.de>
Organization: IBM
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19071215-0028-0000-0000-00000383C6D5
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19071215-0029-0000-0000-00002443DF5A
Message-Id: <20190712174249.33b74535.pasic@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-12_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907120165
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 12 Jul 2019 17:11:29 +0200
Christoph Hellwig <hch@lst.de> wrote:

> On Fri, Jul 12, 2019 at 04:51:53PM +0200, Halil Pasic wrote:
> > Thank you very much! I will have another look, but it seems to me,
> > without further measures taken, this would break protected virtualization
> > support on s390. The effect of the che for s390 is that
> > force_dma_unencrypted() will always return false instead calling into
> > the platform code like it did before the patch, right?
> > 
> > Should I send a  Fixes: e67a5ed1f86f "dma-direct: Force unencrypted DMA
> > under SME for certain DMA masks" (Tom Lendacky, 2019-07-10) patch that
> > rectifies things for s390 or how do we want handle this?
> 
> Yes, please do.  I hadn't noticed the s390 support had landed in
> mainline already.
> 

Will do! I guess I should do the patch against the for-next branch of the
dma-mapping tree. But that branch does not have the s390 support patches (yet?).
To fix it I need both e67a5ed1f86f and 64e1f0c531d1 "s390/mm: force
swiotlb for protected virtualization" (Halil Pasic, 2018-09-13). Or
should I wait for e67a5ed1f86f landing in mainline?

Regards,
Halil

