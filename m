Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76F01253D8D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Aug 2020 08:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbgH0GOU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Aug 2020 02:14:20 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47618 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725909AbgH0GOU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Aug 2020 02:14:20 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07R6323f126362;
        Thu, 27 Aug 2020 02:14:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : date : mime-version : in-reply-to : content-type :
 content-transfer-encoding : message-id; s=pp1;
 bh=pJanTcRrSobhV+CnpT6ahbjTwZg7JOS2dPDEmkoPgs8=;
 b=iKY1zfvQvtdfg4G1ZW7aU56VzxN6tQ9h3s+Pph3h8NmGMRpRXydotp4CXHgA9hdCoE2c
 cRtzBrOQYDcW/u/gHuzyeXy3ihE3ewGrvNdhnPgG29JpbxHRiqiov5ljcOmudVFyRKrK
 aEB0cRls1o/qF/R/CDg9OyeOw6RbuHXFZX/FBr9XTldb25RGip3Q8R2WLg5eI77ZaDRw
 ZYm0e2jhJShjia9hXOUzg6xcfPjs35TpqG8G9RxYUQFPLlwxIQuz9GC0z9b1nAVHIeu7
 hjrZkTQXpdWs0P5Yeak3LTfuwN4sD0Be/q6v8Qs/Foii5fsopLluZScYrbNmWFBn+Z59 rw== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com with ESMTP id 33669ahu7n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Aug 2020 02:14:13 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07R6EBDU011234;
        Thu, 27 Aug 2020 06:14:11 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04fra.de.ibm.com with ESMTP id 332ujju97r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Aug 2020 06:14:11 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07R6E9eC31523126
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Aug 2020 06:14:09 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1FD8952050;
        Thu, 27 Aug 2020 06:14:09 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.43.157])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 8D34D5204F;
        Thu, 27 Aug 2020 06:14:07 +0000 (GMT)
Subject: Re: [PATCH 1/1] block: Set same_page to false in __bio_try_merge_page
 if ret is false
To:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, axboe@kernel.dk,
        Christoph Hellwig <hch@infradead.org>,
        Shivaprasad G Bhat <sbhat@linux.ibm.com>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>
References: <e50582833c897c1a51a676d7726d1380a3e5a678.1598032711.git.riteshh@linux.ibm.com>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Thu, 27 Aug 2020 11:44:06 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <e50582833c897c1a51a676d7726d1380a3e5a678.1598032711.git.riteshh@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <20200827061407.8D34D5204F@d06av21.portsmouth.uk.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-27_01:2020-08-26,2020-08-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 spamscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 mlxlogscore=850 malwarescore=0 adultscore=0 bulkscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008270044
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Jens,

On 8/21/20 11:41 PM, Ritesh Harjani wrote:
> If we hit the UINT_MAX limit of bio->bi_iter.bi_size and so we are anyway
> not merging this page in this bio, then it make sense to make same_page
> also as false before returning.
> 
> Without this patch, we hit below WARNING in iomap.
> This mostly happens with very large memory system and / or after tweaking
> vm dirty threshold params to delay writeback of dirty data.
> 
> WARNING: CPU: 18 PID: 5130 at fs/iomap/buffered-io.c:74 iomap_page_release+0x120/0x150
>   CPU: 18 PID: 5130 Comm: fio Kdump: loaded Tainted: G        W         5.8.0-rc3 #6
>   Call Trace:
>    __remove_mapping+0x154/0x320 (unreliable)
>    iomap_releasepage+0x80/0x180
>    try_to_release_page+0x94/0xe0
>    invalidate_inode_page+0xc8/0x110
>    invalidate_mapping_pages+0x1dc/0x540
>    generic_fadvise+0x3c8/0x450
>    xfs_file_fadvise+0x2c/0xe0 [xfs]
>    vfs_fadvise+0x3c/0x60
>    ksys_fadvise64_64+0x68/0xe0
>    sys_fadvise64+0x28/0x40
>    system_call_exception+0xf8/0x1c0
>    system_call_common+0xf0/0x278
> 
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Reported-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
> Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>

Sorry, I forgot to add the fixes tag. I think below commit
have introduced this. Let me know if you want me to
re-send this patch with below fixes tag.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=cc90bc68422318eb8e75b15cd74bc8d538a7df29


-ritesh

