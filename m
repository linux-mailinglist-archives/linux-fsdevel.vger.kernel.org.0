Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85D57201DA2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Jun 2020 23:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbgFSV5H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Jun 2020 17:57:07 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:55400 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbgFSV5G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Jun 2020 17:57:06 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05JLlxg9037623;
        Fri, 19 Jun 2020 21:57:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=Fh1TauyG94rhfUBSdHsqI+sTrR/HW9QksqHgZMTrwBE=;
 b=znXBd2T4mtleYKCi6c7EstsMXMARd5a6vKJLbs2GOEqSryoCxLKYTjLyJBpt5nw5bvTY
 dmSI1HoX0wSTYGBs25Lrxr0RCBiflgP0MnVlBilJSX4JjUmkHCCPFjCtLL9N2n0e3fJO
 uhsXSH8rR6gtXb0n/S9aOBmW9Ch2N2ve6+CiwLpIz1SOj50CC727B4tQ2czdkouCoSpZ
 HHa6wh8D2V5Inv6zfMl5n9JNIFR7sagELED6qkC7Qt1m/hYKrxbaqwXpcoqqSM/oyssx
 Y5RltoRP9EzPnHoOdWOPN+U9xGZC2pYQeZrEtxzlRJFe8d7rG+6R7Angrvvkin5enBc8 fQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 31q6608w70-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 19 Jun 2020 21:57:01 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05JLnIeI076693;
        Fri, 19 Jun 2020 21:57:01 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 31q66s28td-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Jun 2020 21:57:01 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 05JLv0D3002185;
        Fri, 19 Jun 2020 21:57:00 GMT
Received: from dhcp-10-159-240-10.vpn.oracle.com (/10.159.240.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 19 Jun 2020 14:57:00 -0700
Subject: Re: [PATCH] proc: Avoid a thundering herd of threads freeing proc
 dentries
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <matthew.wilcox@oracle.com>,
        Srinivas Eeda <SRINIVAS.EEDA@oracle.com>,
        "joe.jin@oracle.com" <joe.jin@oracle.com>,
        Wengang Wang <wen.gang.wang@oracle.com>
References: <54091fc0-ca46-2186-97a8-d1f3c4f3877b@oracle.com>
 <20200618233958.GV8681@bombadil.infradead.org>
 <877dw3apn8.fsf@x220.int.ebiederm.org>
 <2cf6af59-e86b-f6cc-06d3-84309425bd1d@oracle.com>
 <87bllf87ve.fsf_-_@x220.int.ebiederm.org>
 <caa9adf6-e1bb-167b-6f59-d17fd587d4fa@oracle.com>
 <87k1036k9y.fsf@x220.int.ebiederm.org>
From:   Junxiao Bi <junxiao.bi@oracle.com>
Message-ID: <68a1f51b-50bf-0770-2367-c3e1b38be535@oracle.com>
Date:   Fri, 19 Jun 2020 14:56:58 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <87k1036k9y.fsf@x220.int.ebiederm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9657 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 mlxscore=0 bulkscore=0 malwarescore=0 mlxlogscore=926 suspectscore=11
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006190152
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9657 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 malwarescore=0
 bulkscore=0 phishscore=0 adultscore=0 priorityscore=1501 mlxscore=0
 spamscore=0 clxscore=1015 mlxlogscore=945 suspectscore=11 impostorscore=0
 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006190152
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/19/20 10:24 AM, ebiederm@xmission.com wrote:

> Junxiao Bi <junxiao.bi@oracle.com> writes:
>
>> Hi Eric,
>>
>> The patch didn't improve lock contention.
> Which raises the question where is the lock contention coming from.
>
> Especially with my first variant.  Only the last thread to be reaped
> would free up anything in the cache.
>
> Can you comment out the call to proc_flush_pid entirely?

Still high lock contention. Collect the following hot path.

     74.90%     0.01%  proc_race 
[kernel.kallsyms]                               [k] 
entry_SYSCALL_64_after_hwframe
             |
              --74.89%--entry_SYSCALL_64_after_hwframe
                        |
                         --74.88%--do_syscall_64
                                   |
                                   |--69.70%--exit_to_usermode_loop
                                   |          |
                                   |           --69.70%--do_signal
                                   |                     |
                                   | --69.69%--get_signal
                                   | |
                                   | |--56.30%--do_group_exit
                                   | |          |
                                   | |           --56.30%--do_exit
                                   | |                     |
                                   | |                     
|--27.50%--_raw_write_lock_irq
                                   | |                     |          |
                                   | |                     | 
--27.47%--queued_write_lock_slowpath
                                   | |                     
|                     |
                                   | |                     | 
--27.18%--native_queued_spin_lock_slowpath
                                   | |                     |
                                   | |                     
|--26.10%--release_task.part.20
                                   | |                     |          |
                                   | |                     |           
--25.60%--_raw_write_lock_irq
                                   | |                     
|                     |
                                   | |                     | 
--25.56%--queued_write_lock_slowpath
                                   | |                     
|                                |
                                   | |                     | 
--25.23%--native_queued_spin_lock_slowpath
                                   | |                     |
                                   | |                      --0.56%--mmput
                                   | |                                |
                                   | |                                 
--0.55%--exit_mmap
                                   | |
|                                 --13.31%--_raw_spin_lock_irq
|                                           |
| --13.28%--native_queued_spin_lock_slowpath
                                   |

Thanks,

Junxiao.

>
> That will rule out the proc_flush_pid in d_invalidate entirely.
>
> The only candidate I can think of d_invalidate aka (proc_flush_pid) vs ps.
>
> Eric
