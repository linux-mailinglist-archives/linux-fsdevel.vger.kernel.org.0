Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4812D3550A1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Apr 2021 12:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245042AbhDFKNx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Apr 2021 06:13:53 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52902 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245037AbhDFKNx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Apr 2021 06:13:53 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 136A5R52054474;
        Tue, 6 Apr 2021 06:13:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : mime-version : content-type
 : in-reply-to; s=pp1; bh=6pdQAJ5/OaleDxgn9+MGbQ2SQVm7sujGX1yPdpCzALs=;
 b=nygngEKFTD7sq6YeOg5w4RrTe2iVRKIscf+8unTy/vGBT37KCIIScZTFF7cAc+zJPbDG
 tEOe7vlj67HtOOeq9ue3e0UHUQRvwTZ465mq8mkQ1QK+M4Lk04iY8sGakRgbnf9Q3qMS
 h41B9X1ie6UBzV0IypKa96saInBiGuslrpEFzSulIEulrlm58DPfGqpMyv2LIVrCvy8S
 d7x7lVVHWqeY+zvddYHXcn9cy6Kjp2rc90tmtS9/hudy2wLOL6fccPoVGrGjtkMamkey
 0hg46o9wGzQ9Fxqz3rDiJ4k4ru1HEkYmRDNcm2tPvP15Qp3kLdcESgF6LyucvJ4C8QOs RA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37q5byvv2f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Apr 2021 06:13:41 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 136A7qKU062851;
        Tue, 6 Apr 2021 06:13:40 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37q5byvv0y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Apr 2021 06:13:40 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 136AD5H7029826;
        Tue, 6 Apr 2021 10:13:38 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma02fra.de.ibm.com with ESMTP id 37q2nm12tn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Apr 2021 10:13:37 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 136ADZBe35193298
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 6 Apr 2021 10:13:35 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C86B311C054;
        Tue,  6 Apr 2021 10:13:35 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 163C211C04A;
        Tue,  6 Apr 2021 10:13:34 +0000 (GMT)
Received: from in.ibm.com (unknown [9.102.27.68])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue,  6 Apr 2021 10:13:33 +0000 (GMT)
Date:   Tue, 6 Apr 2021 15:43:31 +0530
From:   Bharata B Rao <bharata@linux.ibm.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     Yang Shi <shy828301@gmail.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        aneesh.kumar@linux.ibm.com
Subject: Re: High kmalloc-32 slab cache consumption with 10k containers
Message-ID: <20210406101331.GB1354243@in.ibm.com>
Reply-To: bharata@linux.ibm.com
References: <20210405054848.GA1077931@in.ibm.com>
 <CAHbLzko-17bUWdxmOi-p2_MLSbsMCvhjKS1ktnBysC5dN_W90A@mail.gmail.com>
 <YGtZNLhXjv8RegTK@carbon.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YGtZNLhXjv8RegTK@carbon.dhcp.thefacebook.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: njluuTwv1y1SmKCg2zcjzuNSdMgS6qtZ
X-Proofpoint-ORIG-GUID: jb6S0QOfedpmrFGUTzNc5DJpXlcKc0Gp
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-04-06_02:2021-04-01,2021-04-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 mlxlogscore=999 priorityscore=1501 mlxscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104030000 definitions=main-2104060067
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 05, 2021 at 11:38:44AM -0700, Roman Gushchin wrote:
> > > @@ -534,7 +521,17 @@ static void memcg_drain_list_lru_node(struct list_lru *lru, int nid,
> > >         spin_lock_irq(&nlru->lock);
> > >
> > >         src = list_lru_from_memcg_idx(nlru, src_idx);
> > > +       if (!src)
> > > +               goto out;
> > > +
> > >         dst = list_lru_from_memcg_idx(nlru, dst_idx);
> > > +       if (!dst) {
> > > +               /* TODO: Use __GFP_NOFAIL? */
> > > +               dst = kmalloc(sizeof(struct list_lru_one), GFP_ATOMIC);
> > > +               init_one_lru(dst);
> > > +               memcg_lrus = rcu_dereference_protected(nlru->memcg_lrus, true);
> > > +               memcg_lrus->lru[dst_idx] = dst;
> > > +       }
> 
> Hm, can't we just reuse src as dst in this case?
> We don't need src anymore and we're basically allocating dst to move all data from src.

Yes, we can do that and it would be much simpler.

> If not, we can allocate up to the root memcg every time to avoid having
> !dst case and fiddle with __GFP_NOFAIL.
> 
> Otherwise I like the idea and I think it might reduce the memory overhead
> especially on (very) big machines.

Yes, I will however have to check if the callers of list_lru_add() are capable
of handling failure which can happen with this approach if kmalloc fails.

Regards,
Bharata.
