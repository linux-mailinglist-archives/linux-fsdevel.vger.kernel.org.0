Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16CDA2310DE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jul 2020 19:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731980AbgG1R3N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jul 2020 13:29:13 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:36914 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731779AbgG1R3M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jul 2020 13:29:12 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06SHHeLa087169;
        Tue, 28 Jul 2020 17:28:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=gfcnzZS+pACnKP3O6i/6oeBSyg3BfNE44V5fbhOhYKA=;
 b=NsSPSQZGKciMBL7sa84M+iSzT2U0jJhtu+UdEOXKuLKi72Ei67TtcctOb8GExL/DmskM
 K63EPeoxyYxWsVTq9Q6enw2hxIVtMIkKC/e4yxemW11QUlgq4eY8nhoNdxX/cYEraq8c
 i5NM3VfN2vQHLQ5GuXthCI7w/Sxl9vkFuNVkFuvae23t9wsUtb/ym4w2MP4xv7iPbgE8
 F8zx3dwyIutsmg4W6+QlDyqRQZ9tdkpuD4uzmqn582fCbsZBUrFlrR9HGA09Q8aviQdx
 yYAirhOF5q3fryvsxEfRr4XmCo+H3l1juOmfAx4N0YtJmpAYtGENCTafn1LV0Y7Sffot jQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 32hu1jgvqn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 28 Jul 2020 17:28:23 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06SHCiVr081715;
        Tue, 28 Jul 2020 17:28:23 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 32hu5ufj71-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Jul 2020 17:28:22 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06SHS9Nb024053;
        Tue, 28 Jul 2020 17:28:10 GMT
Received: from [10.154.121.35] (/10.154.121.35)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 28 Jul 2020 10:28:09 -0700
Subject: Re: [RFC PATCH 0/5] madvise MADV_DOEXEC
To:     Kirill Tkhai <ktkhai@virtuozzo.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org
Cc:     mhocko@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org, arnd@arndb.de,
        ebiederm@xmission.com, keescook@chromium.org, gerg@linux-m68k.org,
        christian.brauner@ubuntu.com, peterz@infradead.org,
        esyr@redhat.com, jgg@ziepe.ca, christian@kellner.me,
        areber@redhat.com, cyphar@cyphar.com, steven.sistare@oracle.com
References: <1595869887-23307-1-git-send-email-anthony.yznaga@oracle.com>
 <46891e3b-ca08-197d-935f-fa0a52a60051@virtuozzo.com>
From:   Anthony Yznaga <anthony.yznaga@oracle.com>
Organization: Oracle Corporation
Message-ID: <e6699d15-8c86-8f9a-b840-7c3872e3ec8c@oracle.com>
Date:   Tue, 28 Jul 2020 10:28:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <46891e3b-ca08-197d-935f-fa0a52a60051@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9696 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxscore=0 adultscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007280127
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9696 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 mlxlogscore=999
 malwarescore=0 impostorscore=0 priorityscore=1501 spamscore=0 phishscore=0
 suspectscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007280127
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 7/28/20 4:34 AM, Kirill Tkhai wrote:
> On 27.07.2020 20:11, Anthony Yznaga wrote:
>> This patchset adds support for preserving an anonymous memory range across
>> exec(3) using a new madvise MADV_DOEXEC argument.  The primary benefit for
>> sharing memory in this manner, as opposed to re-attaching to a named shared
>> memory segment, is to ensure it is mapped at the same virtual address in
>> the new process as it was in the old one.  An intended use for this is to
>> preserve guest memory for guests using vfio while qemu exec's an updated
>> version of itself.  By ensuring the memory is preserved at a fixed address,
> So, the goal is an update of QEMU binary without a stopping of virtual machine?
Essentially, yes.  The VM is paused very briefly.

Anthony
>
>> vfio mappings and their associated kernel data structures can remain valid.
>> In addition, for the qemu use case, qemu instances that back guest RAM with
>> anonymous memory can be updated.
>>
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
>>

