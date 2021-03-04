Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C54B132D0A6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Mar 2021 11:28:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238481AbhCDK1n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Mar 2021 05:27:43 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:23802 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238477AbhCDK1d (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Mar 2021 05:27:33 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 124AFAmZ058633;
        Thu, 4 Mar 2021 05:26:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=ICRxmbr8yoJ3QpDzCh3NOr4s2q2P1leAAqYVC0+/LR8=;
 b=WK09cN6Wq5zB+2cyqsivQrNz8KvtypE5OHLaGkSUgrua4X0Lny9wHlopQWmNuWgAAvga
 stzZmIpTdBu/T62RAqA4XCQF/Be6lCuxQrF86OyWEVxrpJbx/C4USGj859AZqzCKfHs6
 jZDarNb+0f/SbTD159pc+pfU1ZbKMyhELRd+k7pARR+iITA0iExFKsNjhd7uduVXtI9P
 Ge/KvmsQQ+VbsCwcoSoCUGf6buX0BXef8NHejVonD1hNIuRB5aZhHhK7hyI35W6xPEz5
 l4ewycK0tHF98e+Fjl5Hg7ZbRK9mFYR6vZIu0nhzTNudc61uzQvzMbnIyD027TUy1NLB cQ== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 372wmr8c9m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Mar 2021 05:26:53 -0500
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 124AHIau031318;
        Thu, 4 Mar 2021 10:26:50 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma05fra.de.ibm.com with ESMTP id 3712v51dwk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 04 Mar 2021 10:26:50 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 124AQYQP36831706
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 4 Mar 2021 10:26:34 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8ADAB52052;
        Thu,  4 Mar 2021 10:26:48 +0000 (GMT)
Received: from [9.199.35.80] (unknown [9.199.35.80])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id C5E8052051;
        Thu,  4 Mar 2021 10:26:47 +0000 (GMT)
Subject: Re: [PATCH] iomap: Fix negative assignment to unsigned sis->pages in
 iomap_swapfile_activate
To:     linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, anju@linux.vnet.ibm.com
References: <b39319ab99d9c5541b2cdc172a4b25f39cbaad50.1614838615.git.riteshh@linux.ibm.com>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Message-ID: <e5dd2a59-d228-31ee-3f47-e54838c11b4e@linux.ibm.com>
Date:   Thu, 4 Mar 2021 15:56:47 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <b39319ab99d9c5541b2cdc172a4b25f39cbaad50.1614838615.git.riteshh@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-04_03:2021-03-03,2021-03-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 clxscore=1015 spamscore=0 bulkscore=0
 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103040043
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 3/4/21 11:51 AM, Ritesh Harjani wrote:
> In case if isi.nr_pages is 0, we are making sis->pages (which is
> unsigned int) a huge value in iomap_swapfile_activate() by assigning -1.
> This could cause a kernel crash in kernel v4.18 (with below signature).
> Or could lead to unknown issues on latest kernel if the fake big swap gets
> used.
> 
> Fix this issue by returning -EINVAL in case of nr_pages is 0, since it
> is anyway a invalid swapfile. Looks like this issue will be hit when
> we have pagesize < blocksize type of configuration.

Oops I meant blocksize < pagesize type of configuration.
