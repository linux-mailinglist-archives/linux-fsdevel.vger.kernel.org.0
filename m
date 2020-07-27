Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7AB522F73C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jul 2020 20:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730143AbgG0SBR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jul 2020 14:01:17 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:55092 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729610AbgG0SBR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jul 2020 14:01:17 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06RHvoW3022570;
        Mon, 27 Jul 2020 18:00:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=eu4SrTGieRdpo72CtnDZ91l+25Ht7vSkZp5hzFeF660=;
 b=DEc72janMLcdPS8ZsEPwLHNF3DJzt4ricPlsLOmBD1/LCfhSq+9Q7BUil5Cgy659rh2G
 ZgnlsxeI4z0r7XM2WebMEbKMUkdnsYV7rx0cZaoUtyXkS9HABUtxL17icKvPC31tigSF
 dvdgJU37nAmobyMf3qnrrDmz9+6AXy/35DgVzZH1SlCycpeChR8RmjdX+OQPMFpqEKx0
 ZThfzrvB/79OH3r91iE3lHXvOMZldYSn8hkTnnYTPWuHpmRcam0ZMaXwNxT1IRrzmR8Z
 YvKcMtHZARTLjZrdd1Z3O9fsygYlhUNtrb+ksvr8DVmzd5tndW1j2USVZH5tm+9B+PSP pQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 32hu1j31k9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 27 Jul 2020 18:00:29 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06RHxIp3102771;
        Mon, 27 Jul 2020 18:00:28 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 32hu5r5014-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Jul 2020 18:00:27 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06RI0LEV025773;
        Mon, 27 Jul 2020 18:00:21 GMT
Received: from [10.39.226.160] (/10.39.226.160)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 27 Jul 2020 11:00:21 -0700
Subject: Re: [RFC PATCH 0/5] madvise MADV_DOEXEC
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Anthony Yznaga <anthony.yznaga@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org, mhocko@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        arnd@arndb.de, keescook@chromium.org, gerg@linux-m68k.org,
        ktkhai@virtuozzo.com, christian.brauner@ubuntu.com,
        peterz@infradead.org, esyr@redhat.com, jgg@ziepe.ca,
        christian@kellner.me, areber@redhat.com, cyphar@cyphar.com
References: <1595869887-23307-1-git-send-email-anthony.yznaga@oracle.com>
 <87pn8glwd2.fsf@x220.int.ebiederm.org>
From:   Steven Sistare <steven.sistare@oracle.com>
Organization: Oracle Corporation
Message-ID: <28125570-4129-bcba-099b-f90481cfbfe8@oracle.com>
Date:   Mon, 27 Jul 2020 14:00:17 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87pn8glwd2.fsf@x220.int.ebiederm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9695 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007270121
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9695 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 clxscore=1011 mlxscore=0 impostorscore=0
 phishscore=0 adultscore=0 suspectscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007270121
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/27/2020 1:07 PM, ebiederm@xmission.com wrote:
> Anthony Yznaga <anthony.yznaga@oracle.com> writes:
> 
>> This patchset adds support for preserving an anonymous memory range across
>> exec(3) using a new madvise MADV_DOEXEC argument.  The primary benefit for
>> sharing memory in this manner, as opposed to re-attaching to a named shared
>> memory segment, is to ensure it is mapped at the same virtual address in
>> the new process as it was in the old one.  An intended use for this is to
>> preserve guest memory for guests using vfio while qemu exec's an updated
>> version of itself.  By ensuring the memory is preserved at a fixed address,
>> vfio mappings and their associated kernel data structures can remain valid.
>> In addition, for the qemu use case, qemu instances that back guest RAM with
>> anonymous memory can be updated.
> 
> What is wrong with using a file descriptor to a possibly deleted file
> and re-mmaping it?
> 
> There is already MAP_FIXED that allows you to ensure you have the same
> address.

MAP_FIXED blows away any existing mapping in that range, which is not the 
desired behavior.  We want to preserve the previously created mapping at
the same VA and co-exist with other mappings created by the new process.
There is no way to guarantee availability of a VA post-exec.

> I think all it would take would be a small protocol from one version
> to the next to say map file descriptor #N and address #A.  Something
> easily passed on the command line.
> 
> There is just enough complexity in exec currently that our
> implementation of exec is already teetering.  So if we could use
> existing mechanisms it would be good.
> 
> And I don't see why this version of sharing a mmap area would be
> particularly general.  I do imagine that being able to force a
> mmap area into a setuid executable would be a fun attack vector.

Any mmap(MAP_ANON) segment can be preserved.  That is very general, and is 
the case we need to support to upgrade legacy applications that are already
running (such as qemu) -- we cannot recode them before they are updated.

> Perhaps I missed this in my skim of these patches but I did not see
> anything that guarded this feature against an exec that changes an
> applications privileges.

The ELF opt-in flag must be set, so only selected executables will accept
incoming mappings.  The exec() code verifies that the preserved mappings 
do not overlap or become adjacent to text or stack, so it is not possible for
example for an attacker to cause stack underflow or overflow to access injected
content.  A gadget invoked by some other attack could access the preserved content.

- Steve

>> Patches 1 and 2 ensure that loading of ELF load segments does not silently
>> clobber existing VMAS, and remove assumptions that the stack is the only
>> VMA in the mm when the stack is set up.  Patch 1 re-introduces the use of
>> MAP_FIXED_NOREPLACE to load ELF binaries that addresses the previous issues
>> and could be considered on its own.
>>
>> Patches 3, 4, and 5 introduce the feature and an opt-in method for its use
>> using an ELF note.
>>
>> Anthony Yznaga (5):
>>   elf: reintroduce using MAP_FIXED_NOREPLACE for elf executable mappings
>>   mm: do not assume only the stack vma exists in setup_arg_pages()
>>   mm: introduce VM_EXEC_KEEP
>>   exec, elf: require opt-in for accepting preserved mem
>>   mm: introduce MADV_DOEXEC
>>
>>  arch/x86/Kconfig                       |   1 +
>>  fs/binfmt_elf.c                        | 196 +++++++++++++++++++++++++--------
>>  fs/exec.c                              |  33 +++++-
>>  include/linux/binfmts.h                |   7 +-
>>  include/linux/mm.h                     |   5 +
>>  include/uapi/asm-generic/mman-common.h |   3 +
>>  kernel/fork.c                          |   2 +-
>>  mm/madvise.c                           |  25 +++++
>>  mm/mmap.c                              |  47 ++++++++
>>  9 files changed, 266 insertions(+), 53 deletions(-)
