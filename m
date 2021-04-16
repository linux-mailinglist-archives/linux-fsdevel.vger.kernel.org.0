Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62EDD3618FA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Apr 2021 06:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237782AbhDPEpQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Apr 2021 00:45:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45852 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229555AbhDPEpP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Apr 2021 00:45:15 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13G4YPGU048393;
        Fri, 16 Apr 2021 00:44:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : mime-version : content-type
 : in-reply-to; s=pp1; bh=sFqB8Nx1yOnTC2YBXhWD1XQdbyVUMOcgezM1VW/ORvI=;
 b=jX5FPixHA1ZrJuF15BkI0b/otjV5RWXfSgUWlxv1TB4nx5qJ9MTgGPutg3bcStb4vH/R
 X7OsBahhzPIs2vZyenu3hynq2BSC9UN6Wfh9Xuaja0ktqHFXHxKYFCIlwwhwWiiQQ/EI
 UXVp208gzXGNWaWx615WKpVf8hg9zqq25gw3bXNz6s/dSO1u9iM0V0FpPHp4qcXbTjVi
 UL5QeSEL+8zloSW1B2KlyChvUquSrr51+7CaDpbc8AQalQ2I6yp2W810SG7dBhpGN6zN
 s1P6HSo4/Th5oYvSa+CsHgK/n3hiHCkC9ATzPr+ePVMrLtQMjXD/xdaAUZ4IID3hWGuv mw== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37xsvadgbc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Apr 2021 00:44:48 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13G4es0T009176;
        Fri, 16 Apr 2021 04:44:46 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma05fra.de.ibm.com with ESMTP id 37u3n8a9sx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Apr 2021 04:44:45 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13G4iL9B32243986
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Apr 2021 04:44:21 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8C55CAE051;
        Fri, 16 Apr 2021 04:44:43 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 606F4AE045;
        Fri, 16 Apr 2021 04:44:42 +0000 (GMT)
Received: from in.ibm.com (unknown [9.77.199.141])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri, 16 Apr 2021 04:44:42 +0000 (GMT)
Date:   Fri, 16 Apr 2021 10:14:39 +0530
From:   Bharata B Rao <bharata@linux.ibm.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        aneesh.kumar@linux.ibm.com
Subject: Re: High kmalloc-32 slab cache consumption with 10k containers
Message-ID: <20210416044439.GB1749436@in.ibm.com>
Reply-To: bharata@linux.ibm.com
References: <20210405054848.GA1077931@in.ibm.com>
 <20210406222807.GD1990290@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210406222807.GD1990290@dread.disaster.area>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: iZ4sgeYm6gM96f61qbJja4XmxuUaxycO
X-Proofpoint-GUID: iZ4sgeYm6gM96f61qbJja4XmxuUaxycO
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-15_11:2021-04-15,2021-04-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 phishscore=0 mlxlogscore=673 priorityscore=1501 spamscore=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 mlxscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104160033
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 07, 2021 at 08:28:07AM +1000, Dave Chinner wrote:
> On Mon, Apr 05, 2021 at 11:18:48AM +0530, Bharata B Rao wrote:
> 
> > As an alternative approach, I have this below hack that does lazy
> > list_lru creation. The memcg-specific list is created and initialized
> > only when there is a request to add an element to that particular
> > list. Though I am not sure about the full impact of this change
> > on the owners of the lists and also the performance impact of this,
> > the overall savings look good.
> 
> Avoiding memory allocation in list_lru_add() was one of the main
> reasons for up-front static allocation of memcg lists. We cannot do
> memory allocation while callers are holding multiple spinlocks in
> core system algorithms (e.g. dentry_kill -> retain_dentry ->
> d_lru_add -> list_lru_add), let alone while holding an internal
> spinlock.
> 
> Putting a GFP_ATOMIC allocation inside 3-4 nested spinlocks in a
> path we know might have memory demand in the *hundreds of GB* range
> gets an NACK from me. It's a great idea, but it's just not a

I do understand that GFP_ATOMIC allocations are really not preferrable
but want to point out that the allocations in the range of hundreds of
GBs get reduced to tens of MBs when we do lazy list_lru head allocations
under GFP_ATOMIC.

As shown earlier, this is what I see in my experimental setup with
10k containers:

Number of kmalloc-32 allocations
		Before		During		After
W/o patch	178176		3442409472	388933632
W/  patch	190464		468992		468992

So 3442409472*32=102GB upfront list_lru creation-time GFP_KERNEL allocations
get reduced to 468992*32=14MB dynamic list_lru addtion-time GFP_ATOMIC
allocations.

This does really depend and vary on the type of the container and
the number of mounts it does, but I suspect we are looking
at GFP_ATOMIC allocations in the MB range. Also the number of
GFP_ATOMIC slab allocation requests matter I suppose.

There are other users of list_lru, but I was just looking at
dentry and inode list_lru usecase. It appears to me that for both
dentry and inode, we can tolerate the failure from list_lru_add
due to GFP_ATOMIC allocation failure. The failure to add dentry
or inode to the lru list means that they won't be retained in
the lru list, but would be freed immediately. Is this understanding
correct?

If so, would that likely impact the subsequent lookups adversely?
We failed to retain a dentry or inode in the lru list because
we failed to allocate memory, presumably under memory pressure.
Even in such a scenario, is failure to add dentry or inode to
lru list so bad and not tolerable? 

Regards,
Bharata.
