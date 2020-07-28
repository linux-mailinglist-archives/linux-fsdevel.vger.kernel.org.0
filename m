Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DCA2231119
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jul 2020 19:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732068AbgG1RpB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jul 2020 13:45:01 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:48854 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731948AbgG1RpB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jul 2020 13:45:01 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06SHbdhO119251;
        Tue, 28 Jul 2020 17:44:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=bAxoxVqkxvfHt6SEE10MiPl/V0wf4gBcQL+oBZHzmbs=;
 b=k8sAiZsjkapHCiwl7lQCXXq7V2xxPlwd/o/Vi0qSxmuLhMd4JONU5FHb26rdfvNQs2cl
 gClofoapoK+hGLjV9p85pBAk2ttgdD1jqmeX72M98WQbGx7BT6TtvpO5H2Zi50hBWISx
 P/QhLgs5v+mAIMdT1RQL0nhx7z1AXTcwxF6MR/k3PKLVGq5zJkmwfGvktQvblRwJHG2d
 UeHbz7qHtE9BL/LanTq9wTR7k9+SEWeH7UugAHkSsFFOjARjUfUJapTkgiyhxSbAFtAV
 sbaDy+mEjMb7nRo7EFT/BFsOYcnznLegrOibQBScrEQ0TENTotzx5WXy8zf/MZSojQKy iw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 32hu1jgya4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 28 Jul 2020 17:44:23 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06SHWi3i162287;
        Tue, 28 Jul 2020 17:44:22 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 32hu5ug1g1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Jul 2020 17:44:22 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06SHiFYe032078;
        Tue, 28 Jul 2020 17:44:16 GMT
Received: from [10.154.121.35] (/10.154.121.35)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 28 Jul 2020 10:44:15 -0700
Subject: Re: [RFC PATCH 3/5] mm: introduce VM_EXEC_KEEP
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org, mhocko@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        arnd@arndb.de, keescook@chromium.org, gerg@linux-m68k.org,
        ktkhai@virtuozzo.com, christian.brauner@ubuntu.com,
        peterz@infradead.org, esyr@redhat.com, jgg@ziepe.ca,
        christian@kellner.me, areber@redhat.com, cyphar@cyphar.com,
        steven.sistare@oracle.com
References: <1595869887-23307-1-git-send-email-anthony.yznaga@oracle.com>
 <1595869887-23307-4-git-send-email-anthony.yznaga@oracle.com>
 <87365bg3nx.fsf@x220.int.ebiederm.org>
From:   Anthony Yznaga <anthony.yznaga@oracle.com>
Organization: Oracle Corporation
Message-ID: <7694af9d-dfb9-8c44-dc41-79f58bb14413@oracle.com>
Date:   Tue, 28 Jul 2020 10:44:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87365bg3nx.fsf@x220.int.ebiederm.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9696 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxscore=0 adultscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007280128
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9696 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 mlxlogscore=999
 malwarescore=0 impostorscore=0 priorityscore=1501 spamscore=0 phishscore=0
 suspectscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007280128
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 7/28/20 6:38 AM, ebiederm@xmission.com wrote:
> Anthony Yznaga <anthony.yznaga@oracle.com> writes:
>
>> A vma with the VM_EXEC_KEEP flag is preserved across exec.  For anonymous
>> vmas only.  For safety, overlap with fixed address VMAs created in the new
>> mm during exec (e.g. the stack and elf load segments) is not permitted and
>> will cause the exec to fail.
>> (We are studying how to guarantee there are no conflicts. Comments welcome.)
>>
>> diff --git a/fs/exec.c b/fs/exec.c
>> index 262112e5f9f8..1de09c4eef00 100644
>> --- a/fs/exec.c
>> +++ b/fs/exec.c
>> @@ -1069,6 +1069,20 @@ ssize_t read_code(struct file *file, unsigned long addr, loff_t pos, size_t len)
>>  EXPORT_SYMBOL(read_code);
>>  #endif
>>  
>> +static int vma_dup_some(struct mm_struct *old_mm, struct mm_struct *new_mm)
>> +{
>> +	struct vm_area_struct *vma;
>> +	int ret;
>> +
>> +	for (vma = old_mm->mmap; vma; vma = vma->vm_next)
>> +		if (vma->vm_flags & VM_EXEC_KEEP) {
>> +			ret = vma_dup(vma, new_mm);
>> +			if (ret)
>> +				return ret;
>> +		}
>> +	return 0;
>> +}
>> +
>>  /*
>>   * Maps the mm_struct mm into the current task struct.
>>   * On success, this function returns with the mutex
>> @@ -1104,6 +1118,12 @@ static int exec_mmap(struct mm_struct *mm)
>>  			mutex_unlock(&tsk->signal->exec_update_mutex);
>>  			return -EINTR;
>>  		}
>> +		ret = vma_dup_some(old_mm, mm);
>                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>
> Ouch! An unconditional loop through all of the vmas of the execing
> process, just in case there is a VM_EXEC_KEEP vma.
>
> I know we already walk the list in exit_mmap, but I get the feeling this
> will slow exec down when this feature is not enabled, especially when
> a process with a lot of vmas is calling exec.
Patch 4 changes this to only call vma_dup_some() if the new
binary has opted in to accepting preserved memory.

Anthony
>
>                 
>> +		if (ret) {
>> +			mmap_read_unlock(old_mm);
>> +			mutex_unlock(&tsk->signal->exec_update_mutex);
>> +			return ret;
>> +		}
>>  	}
>>  
>>  	task_lock(tsk);

