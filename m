Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81E004D1A29
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Mar 2022 15:15:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347393AbiCHOPy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Mar 2022 09:15:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347382AbiCHOPx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Mar 2022 09:15:53 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7AE4AE18;
        Tue,  8 Mar 2022 06:14:56 -0800 (PST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 228DWw14004089;
        Tue, 8 Mar 2022 14:14:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=viaTZqcwt4wv6G40EPgXAMur6u3Bz8/qVAALzpo4eC8=;
 b=ET7JGWy7Vn/IyTMgsSJtx+sfcxpe7iGKkfzwN1yHZGTh6BOxzGBz/m3j5/T4kkgU7/X4
 MJnrDP8GPuSqNcPBFdiLu5ZoFPrN17e5XzVCjRVjXJIRiYL+PpRmBvKjKX46LGVAshLX
 oQXtXtICkzkkV9HOZGdS8PbtJyw9BWa7+FLCvWwmNrBQaZc8puRzLZD0JqGBnP8vzBNh
 HBXYSwHvAvfTGV71d7bIxrlrK/w1tO38mrJkVeNCfckWt6ZwlUUN8m6Li9RqEeK4VPQe
 pt4nWix2kVSB11Dxn0GjVsTOxM1wIBN0cS22Mev3Ek/yDA8/4rS4YMqSFZwcWEjp4UMS lg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3enxs04a3r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Mar 2022 14:14:52 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 228DYvBx031620;
        Tue, 8 Mar 2022 14:14:51 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3enxs04a32-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Mar 2022 14:14:51 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 228E7nNU016918;
        Tue, 8 Mar 2022 14:14:49 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 3enqgnj9nb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Mar 2022 14:14:48 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 228EEjfq51642872
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 8 Mar 2022 14:14:45 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9FF7652052;
        Tue,  8 Mar 2022 14:14:45 +0000 (GMT)
Received: from thinkpad (unknown [9.171.70.239])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with SMTP id 071FB5204E;
        Tue,  8 Mar 2022 14:14:44 +0000 (GMT)
Date:   Tue, 8 Mar 2022 15:14:43 +0100
From:   Gerald Schaefer <gerald.schaefer@linux.ibm.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: Buffered I/O broken on s390x with page faults disabled (gfs2)
Message-ID: <20220308151443.6be164cf@thinkpad>
In-Reply-To: <da799fa7-b6c6-eb70-27e4-0c5d8592bd34@redhat.com>
References: <CAHc6FU5nP+nziNGG0JAF1FUx-GV7kKFvM7aZuU_XD2_1v4vnvg@mail.gmail.com>
        <CAHk-=wgmCuuJdf96WiT6WXzQQTEeSK=cgBy24J4U9V2AvK4KdQ@mail.gmail.com>
        <bcafacea-7e67-405c-a969-e5a58a3c727e@redhat.com>
        <2266e1a8-ac79-94a1-b6e2-47475e5986c5@redhat.com>
        <81f2f76d-24ef-c23b-449e-0b8fdec506e1@redhat.com>
        <1bdb0184-696c-0f1a-3054-d88391c32e64@redhat.com>
        <20220308142047.7a725518@thinkpad>
        <da799fa7-b6c6-eb70-27e4-0c5d8592bd34@redhat.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: PbigOjr5pp5L_Zu3UJEghMW8Gkem5y8F
X-Proofpoint-ORIG-GUID: n6lkj0XilohaZ_7e0P0wxPmZl-C_yvSt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-08_03,2022-03-04_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 bulkscore=0 mlxlogscore=999 clxscore=1015 adultscore=0 spamscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203080075
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 8 Mar 2022 14:32:25 +0100
David Hildenbrand <david@redhat.com> wrote:

[...]
> 
> > - using set_pte_at() here seems a bit dangerous, as I'm not sure if this will
> >   always only operate on invalid PTEs. Using it on active valid PTEs could
> >   result in TLB issues because of missing flush. Also not sure about kvm impact.
> >   Using ptep_set_access_flags() seems safer, again similar to touch_pmd() and
> >   also cow_user_page().
> 
> Yeah, I sticked to what follow_pfn_pte() does for simplicity for now.

Uh oh, that set_pte_at() in follow_pfn_pte() also looks dangerous, at least
I do not spontaneously see that it would only be used for invalid / pte_none()
PTEs. But that is a totally different story, and maybe (hopefully) not
affecting s390 until we have proper DAX support...
