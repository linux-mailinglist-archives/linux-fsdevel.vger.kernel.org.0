Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5702568926B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Feb 2023 09:37:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbjBCIhZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Feb 2023 03:37:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231903AbjBCIhY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Feb 2023 03:37:24 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A9047ED9;
        Fri,  3 Feb 2023 00:37:18 -0800 (PST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3138Uisk017670;
        Fri, 3 Feb 2023 08:37:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=A0hof6re8u8bm6k4Ym83IwjdZ/iNuiNk73vuae2ePIM=;
 b=pNPn+10ziFT3bMd1IFQpcbV9UxiH5d9ARGz6Wg6dtiYQBtQUj/WE+wWcUNAO8j7RlMPP
 784ABAgQw9Fe8OUcgexRPpFJ/vVvKmAG8DIdEuAcj7TnGpiK/SVu5sDRxUvzMEz1a6WR
 33yZZQrCQctNqdrSBsVyRrdfpAbS9uOKYy3pHbSZAEnChqaVJYhua7q6V5AQk21X7wkg
 q3WqgaVdSRj7oN7R3/wgpDBoVho9LUE49K29m24IT89iHthXXyjoyYbBTIzlKDaba90X
 qfeoWXoolpaMsCZNCLX+dhO9HAiH3bxH5QosniqyXeUOgFKHLUK/FT/B5YZC6dnivFAa AA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ngxtu84v9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Feb 2023 08:37:07 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3138b7F2009292;
        Fri, 3 Feb 2023 08:37:07 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ngxtu84un-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Feb 2023 08:37:06 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 312MGEGr005441;
        Fri, 3 Feb 2023 08:37:04 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma03fra.de.ibm.com (PPS) with ESMTPS id 3ncvshd48m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Feb 2023 08:37:04 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3138b2RL25887184
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 3 Feb 2023 08:37:02 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0C29620043;
        Fri,  3 Feb 2023 08:37:02 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0DCF820040;
        Fri,  3 Feb 2023 08:37:00 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.50.106])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Fri,  3 Feb 2023 08:36:59 +0000 (GMT)
Date:   Fri, 3 Feb 2023 14:06:56 +0530
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        rookxu <brookxu.cn@gmail.com>,
        Ritesh Harjani <ritesh.list@gmail.com>
Subject: Re: [PATCH v3 7/8] ext4: Use rbtrees to manage PAs instead of inode
 i_prealloc_list
Message-ID: <Y9zHkMx7w4Io0TTv@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20230116080216.249195-1-ojaswin@linux.ibm.com>
 <20230116080216.249195-8-ojaswin@linux.ibm.com>
 <20230116122334.k2hlom22o2hlek3m@quack3>
 <Y8Z413XTPMr//bln@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
 <20230117110335.7dtlq4catefgjrm3@quack3>
 <Y8jizbGg6l2WxJPF@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
 <20230127144312.3m3hmcufcvxxp6f4@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230127144312.3m3hmcufcvxxp6f4@quack3>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: S1Ys9Hr3qTx5WgoEprq5s_riUOj4rJUW
X-Proofpoint-GUID: GeekTf8ko8WYwxXtYxFuzeCYJPuYle4H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-03_04,2023-02-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 phishscore=0 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0
 mlxscore=0 mlxlogscore=813 priorityscore=1501 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302030079
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 27, 2023 at 03:43:12PM +0100, Jan Kara wrote:
> 
> Well, I think cond_resched() + goto retry would be OK here. We could also
> cycle the corresponding group lock which would wait for
> ext4_mb_discard_group_preallocations() to finish but that is going to burn
> the CPU even more than the cond_resched() + retry as we'll be just spinning
> on the spinlock. Sleeping is IMHO not warranted as the whole
> ext4_mb_discard_group_preallocations() is running under a spinlock anyway
> so it should better be a very short sleep.
> 
> Or actually I have one more possible solution: What the adjusting function
> is doing that it looks up PA before and after ac->ac_o_ex.fe_logical and
> trims start & end to not overlap these PAs. So we could just lookup these
> two PAs (ignoring the deleted state) and then just iterate from these with
> rb_prev() & rb_next() until we find not-deleted ones. What do you think? 

Hey Jan, 

Just thought I'd update you, I'm trying this solution out, and it looks
good but I'm hitting a few bugs in the implementation. Will update here
once I have it working correctly.

Regards,
Ojaswin
