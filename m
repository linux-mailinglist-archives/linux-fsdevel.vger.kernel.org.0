Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60A51230C05
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jul 2020 16:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730316AbgG1OHK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jul 2020 10:07:10 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:54912 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730211AbgG1OHJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jul 2020 10:07:09 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06SE2whW012373;
        Tue, 28 Jul 2020 14:06:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=GWvmtNw2Buotc0Z9pinQFTYuFu4BUOZm0ph5jo3/R5g=;
 b=Ywu0KlR68UAmPMAMzEijN5sPfsI2RFlNe0ywEuGhVtHAqUHAxSlnPvj+fvBg3CfawQLi
 O8QV3k70bHHGi+TDE7WzgN3AXyKCHd07itHADpsyvH3bno67SP9WHuF3rt/9+WY6nDaa
 oVaHl0qxoVGp4tj7fsHlZ4hFcrh0ThlK2GXSUJsCw7RXQ/aIgHMBEqNFg+BLg5O3rc7E
 cvBKTE+lzbtLOrYV/3yxnTMmzCYchUp+2o6RilnRq3Qy1NrIgaXBPlmUSW/T3VMgtaQo
 f1lvD3tcoOt41X7/ZLiPEvV4mI0Fkg2/hIkPf5WQ+VuptNKUN8lA/OnPzhQkcA+3Sr8Y +w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 32hu1j7p8b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 28 Jul 2020 14:06:27 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06SDxL7i141077;
        Tue, 28 Jul 2020 14:06:27 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 32hu5ss78y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Jul 2020 14:06:27 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06SE6BVF008475;
        Tue, 28 Jul 2020 14:06:11 GMT
Received: from [10.39.227.185] (/10.39.227.185)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 28 Jul 2020 07:06:10 -0700
Subject: Re: [RFC PATCH 5/5] mm: introduce MADV_DOEXEC
To:     Kirill Tkhai <ktkhai@virtuozzo.com>,
        Anthony Yznaga <anthony.yznaga@oracle.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org
Cc:     mhocko@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org, arnd@arndb.de,
        ebiederm@xmission.com, keescook@chromium.org, gerg@linux-m68k.org,
        christian.brauner@ubuntu.com, peterz@infradead.org,
        esyr@redhat.com, jgg@ziepe.ca, christian@kellner.me,
        areber@redhat.com, cyphar@cyphar.com
References: <1595869887-23307-1-git-send-email-anthony.yznaga@oracle.com>
 <1595869887-23307-6-git-send-email-anthony.yznaga@oracle.com>
 <743a51db-dc27-c49c-9c65-ac164f5283ba@virtuozzo.com>
From:   Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
Message-ID: <bd50a6f0-670e-6bd3-13f1-c7a96e56a9bb@oracle.com>
Date:   Tue, 28 Jul 2020 10:06:05 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <743a51db-dc27-c49c-9c65-ac164f5283ba@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9695 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007280107
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9695 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 clxscore=1015
 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007280107
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/28/2020 9:22 AM, Kirill Tkhai wrote:
> On 27.07.2020 20:11, Anthony Yznaga wrote:
>> madvise MADV_DOEXEC preserves a memory range across exec.  Initially
>> only supported for non-executable, non-stack, anonymous memory.
>> MADV_DONTEXEC reverts the effect of a previous MADV_DOXEXEC call and
>> undoes the preservation of the range.  After a successful exec call,
>> the behavior of all ranges reverts to MADV_DONTEXEC.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
>> ---
>>  include/uapi/asm-generic/mman-common.h |  3 +++
>>  mm/madvise.c                           | 25 +++++++++++++++++++++++++
>>  2 files changed, 28 insertions(+)
>>
>> diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-generic/mman-common.h
>> index f94f65d429be..7c5f616b28f7 100644
>> --- a/include/uapi/asm-generic/mman-common.h
>> +++ b/include/uapi/asm-generic/mman-common.h
>> @@ -72,6 +72,9 @@
>>  #define MADV_COLD	20		/* deactivate these pages */
>>  #define MADV_PAGEOUT	21		/* reclaim these pages */
>>  
>> +#define MADV_DOEXEC	22		/* do inherit across exec */
>> +#define MADV_DONTEXEC	23		/* don't inherit across exec */
>> +
>>  /* compatibility flags */
>>  #define MAP_FILE	0
>>  
>> diff --git a/mm/madvise.c b/mm/madvise.c
>> index dd1d43cf026d..b447fa748649 100644
>> --- a/mm/madvise.c
>> +++ b/mm/madvise.c
>> @@ -103,6 +103,26 @@ static long madvise_behavior(struct vm_area_struct *vma,
>>  	case MADV_KEEPONFORK:
>>  		new_flags &= ~VM_WIPEONFORK;
>>  		break;
>> +	case MADV_DOEXEC:
> 
> For me MADV_KEEPONEXEC sounds better as it's symmetric to MADV_KEEPONFORK.

We chose MADV_DOEXEC and MADV_DONTEXEC to match the precedent set by:

#define MADV_DONTFORK   10              /* don't inherit across fork */


#define MADV_DOFORK     11              /* do inherit across fork */


I do like "keep" as a concise description of the operation.  KEEPONFORK is not a perfect 
analog because its opposite is wipe ...

#define MADV_WIPEONFORK 18              /* Zero memory on fork, child only */
#define MADV_KEEPONFORK 19              /* Undo MADV_WIPEONFORK */

... but if folks are ok with that then IMO these are all good choices:

MADV_KEEPONEXEC
MADV_DROPONEXEC

MADV_KEEPEXEC    (shorter)
MADV_DROPEXEC 

MADV_KEEP_EXEC   (more legible, but no existing MADV names use 2nd underscores)
MADV_DROP_EXEC

Whatever folks like best.

- Steve

>> +		/*
>> +		 * MADV_DOEXEC is only supported on private, non-executable,
>> +		 * non-stack anonymous memory and if the VM_EXEC_KEEP flag
>> +		 * is available.
>> +		 */
>> +		if (!VM_EXEC_KEEP || vma->vm_file || vma->vm_flags & (VM_EXEC|VM_SHARED|VM_STACK)) {
>> +			error = -EINVAL;
>> +			goto out;
>> +		}
>> +		new_flags |= (new_flags & ~VM_MAYEXEC) | VM_EXEC_KEEP;
>> +		break;
>> +	case MADV_DONTEXEC:
>> +		if (!VM_EXEC_KEEP) {
>> +			error = -EINVAL;
>> +			goto out;
>> +		}
>> +		if (new_flags & VM_EXEC_KEEP)
>> +			new_flags |= (new_flags & ~VM_EXEC_KEEP) | VM_MAYEXEC;
>> +		break;
>>  	case MADV_DONTDUMP:
>>  		new_flags |= VM_DONTDUMP;
>>  		break;
>> @@ -983,6 +1003,8 @@ static int madvise_inject_error(int behavior,
>>  	case MADV_SOFT_OFFLINE:
>>  	case MADV_HWPOISON:
>>  #endif
>> +	case MADV_DOEXEC:
>> +	case MADV_DONTEXEC:
>>  		return true;
>>  
>>  	default:
>> @@ -1037,6 +1059,9 @@ static int madvise_inject_error(int behavior,
>>   *  MADV_DONTDUMP - the application wants to prevent pages in the given range
>>   *		from being included in its core dump.
>>   *  MADV_DODUMP - cancel MADV_DONTDUMP: no longer exclude from core dump.
>> + *  MADV_DOEXEC - On exec, preserve and duplicate this area in the new process
>> + *		  if the new process allows it.
>> + *  MADV_DONTEXEC - Undo the effect of MADV_DOEXEC.
>>   *
>>   * return values:
>>   *  zero    - success
>>
> 
