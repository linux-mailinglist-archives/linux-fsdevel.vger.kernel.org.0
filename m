Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B82155670DD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Jul 2022 16:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232499AbiGEOWy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Jul 2022 10:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233218AbiGEOWJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Jul 2022 10:22:09 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF6102F7;
        Tue,  5 Jul 2022 07:21:39 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 265E53JS029319;
        Tue, 5 Jul 2022 14:21:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=PJ6sfBrteaY3d3xMJ6YNRiQMX0P+Yb8RFk/boKnsfdA=;
 b=IcuaBfPCkS3JBXYz13zKb07+pE4O5NfRXxI17vqqWrsxI9QnLGk2v5mZykumnvlyD596
 JnzP3Xr2SmrPg/NxyGSkMxukISXEpNDW3j33H2bcKBWhj45hrAE6dFCgQaTnCmRCgnm8
 1VqLGH6AeD/AMn8X4+xRRGhCCYZaVMG4FL9e2qViWnvcQdk4Zovx6MAD795soSn2VKfw
 /hrPviNQX29R4lSK2+MqBA+oJK36WrI7OKPOQyC056E7SRQX3uEWTbF6gK1f4Eo/JL3y
 v547QbiLcQC7mzuV16VVZ1sQ4sm7MNQJtYmTjgMMoZcnDwBTE1zwY+Dk7g00wq5ZiBv+ nQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3h4pg0s49g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Jul 2022 14:21:26 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 265E59PY030047;
        Tue, 5 Jul 2022 14:21:26 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3h4pg0s48x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Jul 2022 14:21:25 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 265E6SMd031049;
        Tue, 5 Jul 2022 14:21:24 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3h2d9jc58c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Jul 2022 14:21:24 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 265ELTtp32899530
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 5 Jul 2022 14:21:29 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CEBA55204F;
        Tue,  5 Jul 2022 14:21:20 +0000 (GMT)
Received: from thinkpad (unknown [9.171.76.42])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with SMTP id 272035204E;
        Tue,  5 Jul 2022 14:21:20 +0000 (GMT)
Date:   Tue, 5 Jul 2022 16:21:18 +0200
From:   Gerald Schaefer <gerald.schaefer@linux.ibm.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Jan Kara <jack@suse.cz>, clm@fb.com, josef@toxicpanda.com,
        dsterba@suse.com, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH] btrfs: remove btrfs_writepage_cow_fixup
Message-ID: <20220705162118.153efe62@thinkpad>
In-Reply-To: <20220629075837.GA22346@lst.de>
References: <20220624122334.80603-1-hch@lst.de>
        <7c30b6a4-e628-baea-be83-6557750f995a@gmx.com>
        <20220624125118.GA789@lst.de>
        <20220624130750.cu26nnm6hjrru4zd@quack3.lan>
        <20220625091143.GA23118@lst.de>
        <20220627101914.gpoz7f6riezkolad@quack3.lan>
        <e73be42e-fce5-733a-310d-db9dc5011796@gmx.com>
        <20220628115356.GB20633@suse.cz>
        <20220629075837.GA22346@lst.de>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: qQir0kRs4iE1Xk7GHT__fz80lb2HMA69
X-Proofpoint-ORIG-GUID: VSjWlvkv1KztAt_UQzmGzsCnbd9pp_os
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-05_10,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 malwarescore=0
 priorityscore=1501 mlxscore=0 impostorscore=0 lowpriorityscore=0
 spamscore=0 bulkscore=0 mlxlogscore=710 adultscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2207050061
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 29 Jun 2022 09:58:37 +0200
Christoph Hellwig <hch@lst.de> wrote:

> On Tue, Jun 28, 2022 at 01:53:56PM +0200, David Sterba wrote:
> > This would work only for the higher level API where eg. RDMA notifies
> > the filesystem, but there's still the s390 case that is part of the
> > hardware architecture. The fixup worker is there as a safety for all
> > other cases, I'm not fine removing or ignoring it.  
> 
> I'd really like to have a confirmation of this whole s390 theory.
> s390 does treat some dirtying different than the other architectures,
> but none of that should leak into the file system API if any way that
> bypasses ->page_mkwrite.
> 
> Because if it did most file systems would be completely broken on
> s390.

Could you please be more specific about what exactly you mean with
"the s390 case that is part of the hardware architecture"?

One thing that s390 might handle different from others, is that it
is not using a HW dirty bit in the PTE, but instead a fault-triggered
SW dirty bit.

E.g. pte_mkwrite() will mark a PTE as writable (via another SW bit),
but not clear the HW protection bit, which would then generate a
fault on first write access. In handle_pte_fault(), the PTE would
then be marked as dirty via pte_mkdirty(), which also clears the HW
protection bit, at least for pte_write() PTEs.
For the !pte_write() COW case, we would go through do_wp_page() like
everybody else, but probably still end up in some pte_mkdirty()
eventually, to avoid getting another fault.

Not being familiar with either btrfs, any other fs, or RDMA, I cannot
really follow the discussion here. Still it seems to me that you are
not talking about special s390 HW architecture regarding PTE, but
rather about some (struct) page dirtying on the COW path, which should
be completely common code and not subject to any s390 special case.

Somewhere in this thread it was also mentioned that "s390 can not do
page flags update atomically", which I can not confirm, in case this
was the question. The code in include/linux/page-flags.h seems to
use normal (arch)_test/set/clear_bit operations, which should always be
atomic on s390.
