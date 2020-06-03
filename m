Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B36E1ECDA5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jun 2020 12:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725983AbgFCKfH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Jun 2020 06:35:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:24526 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725854AbgFCKfH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Jun 2020 06:35:07 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 053AYp5V075359;
        Wed, 3 Jun 2020 06:34:53 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com with ESMTP id 31dp431mau-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 Jun 2020 06:34:52 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 053AUan1008800;
        Wed, 3 Jun 2020 10:31:52 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma02fra.de.ibm.com with ESMTP id 31bf47u6x3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 Jun 2020 10:31:52 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 053AVnsT25165956
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 3 Jun 2020 10:31:49 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C96F852050;
        Wed,  3 Jun 2020 10:31:49 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.36.151])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id C42D65204F;
        Wed,  3 Jun 2020 10:31:46 +0000 (GMT)
Subject: Re: [PATCHv5 1/1] ext4: mballoc: Use raw_cpu_ptr instead of
 this_cpu_ptr
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-ext4@vger.kernel.org, tytso@mit.edu
Cc:     linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.com>,
        linux-kernel@vger.kernel.org, adilger.kernel@dilger.ca,
        sfr@canb.auug.org.au, linux-next@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        syzbot+82f324bb69744c5f6969@syzkaller.appspotmail.com
References: <20200602134721.18211-1-riteshh@linux.ibm.com>
 <CGME20200603102422eucas1p109e0d0140e8fc61dc3e57957f2ccf700@eucas1p1.samsung.com>
 <ca794804-7d99-9837-2490-366a2eb97a94@samsung.com>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Wed, 3 Jun 2020 16:01:45 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <ca794804-7d99-9837-2490-366a2eb97a94@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <20200603103146.C42D65204F@d06av21.portsmouth.uk.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-03_11:2020-06-02,2020-06-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 clxscore=1011 cotscore=-2147483648
 adultscore=0 suspectscore=0 spamscore=0 bulkscore=0 impostorscore=0
 mlxscore=0 mlxlogscore=799 priorityscore=1501 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006030083
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> This fixes the warning observed on various Samsung Exynos SoC based
> boards with linux-next 20200602.
> 
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> 

Thanks Marek,

Hello Ted,

Please pick up below change which I just sent with an added "Fixes" by
tag. Changes wise it is the same which Marek tested.

https://patchwork.ozlabs.org/project/linux-ext4/patch/20200603101827.2824-1-riteshh@linux.ibm.com/


-ritesh
