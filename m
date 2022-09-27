Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 051135EBE94
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Sep 2022 11:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbiI0J25 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Sep 2022 05:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbiI0J2h (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Sep 2022 05:28:37 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B887AB410;
        Tue, 27 Sep 2022 02:28:35 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28R8ss5K008035;
        Tue, 27 Sep 2022 09:28:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=LqS196DMkWdQStvfa93uqpfwaEiGR7PcBEC5QDFv/K8=;
 b=i0hRdOymMzYQGsSX3kd2Clb5Oytp3eh6xt+U3XAzv8Y9qiAdjhO/FzSP0wFHCVhbd2sb
 ME6hWunsaQ3uoVBjrNhWoKQdhiFrhAOmBliZ2NQWFVMZOWECxULBjy/pS9IT1Ex4shMV
 xMVxmynsvfj9GueiIFtkzstHHNrix56XSTW58IaA2dWkiPLU5TFZMVn2hK7HTobbDHxl
 7bVT8roG6qDiYmtCfp2bXT7plBIKya7Avn7qkIATBz9syYNUWiqQ2aTQUxQOfdE3P1l3
 vqo7WWscIt6zwUACyNo1p4kZZvvVonwmwdk5q/GPED3hF3n8QnoKi1I3SC32VdibEfPI rA== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3juv5nmrwm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Sep 2022 09:28:28 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28R9LQfX021131;
        Tue, 27 Sep 2022 09:28:26 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 3juapuh95d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Sep 2022 09:28:26 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28R9SOah51773768
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Sep 2022 09:28:24 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4D0144C044;
        Tue, 27 Sep 2022 09:28:24 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5A6134C040;
        Tue, 27 Sep 2022 09:28:22 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.61.44])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 27 Sep 2022 09:28:22 +0000 (GMT)
Date:   Tue, 27 Sep 2022 14:58:14 +0530
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>
Subject: Re: [RFC v2 0/8] ext4: Convert inode preallocation list to an rbtree
Message-ID: <YzLCLm53jvH5GVNg@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <cover.1664172580.git.ojaswin@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1664172580.git.ojaswin@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: VUy73F13a4decsLORvCMPrnSaImcgVi0
X-Proofpoint-GUID: VUy73F13a4decsLORvCMPrnSaImcgVi0
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-27_02,2022-09-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 mlxscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 mlxlogscore=538 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209270053
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 26, 2022 at 12:34:51PM +0530, Ojaswin Mujoo wrote:
> This patch series aim to improve the performance and scalability of
> inode preallocation by changing inode preallocation linked list to an
> rbtree. I've ran xfstests quick on this series and plan to run auto group
> as well to confirm we have no regressions.
> 
Hi,

I had missed to redefine a function in rebase. Have sent out a v3 with
the correct rebase:
https://lore.kernel.org/all/cover.1664269665.git.ojaswin@linux.ibm.com/

Regards,
Ojaswin
> 
> -- 
> 2.31.1
> 
