Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 343181F38D2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jun 2020 12:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728250AbgFIK5k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Jun 2020 06:57:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:6742 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725996AbgFIK5j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Jun 2020 06:57:39 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 059AXC6B107616;
        Tue, 9 Jun 2020 06:57:28 -0400
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31j59u82y1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Jun 2020 06:57:27 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 059AfCqs026468;
        Tue, 9 Jun 2020 10:57:23 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma01fra.de.ibm.com with ESMTP id 31g2s7tc3v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Jun 2020 10:57:23 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 059AvLxU23199958
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 9 Jun 2020 10:57:21 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 754F6AE057;
        Tue,  9 Jun 2020 10:57:21 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 83455AE051;
        Tue,  9 Jun 2020 10:57:19 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.37.89])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  9 Jun 2020 10:57:19 +0000 (GMT)
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
 <20200603103146.C42D65204F@d06av21.portsmouth.uk.ibm.com>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Tue, 9 Jun 2020 16:27:18 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200603103146.C42D65204F@d06av21.portsmouth.uk.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <20200609105719.83455AE051@d06av26.portsmouth.uk.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-09_03:2020-06-09,2020-06-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 impostorscore=0 priorityscore=1501
 malwarescore=0 adultscore=0 mlxscore=0 cotscore=-2147483648 phishscore=0
 mlxlogscore=678 bulkscore=0 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006090081
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch is superseded by

https://patchwork.ozlabs.org/project/linux-ext4/patch/534f275016296996f54ecf65168bb3392b6f653d.1591699601.git.riteshh@linux.ibm.com/
