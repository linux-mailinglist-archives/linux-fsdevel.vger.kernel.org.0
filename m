Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0C32F2432
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jan 2021 01:34:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405513AbhALAZk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Jan 2021 19:25:40 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:52950 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404251AbhALAPp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Jan 2021 19:15:45 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10C03xQl195908;
        Tue, 12 Jan 2021 00:13:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=g98Oc2l6CX7Vawq4qdGkbD1zcPlN3W0CHY7TJH65Nko=;
 b=O86sQ++WtQMSepFVfhOY5zlN0XgY7WiQ3VGEoHqOkiTFw0dSJ+ty/b4gdF6an6ax0OSM
 NqucrDqxkke4MZ62MfrSh4nHXnnUlaiQkhv2qVgF1SWXkC/n1ylsr+rS8lWVWeXXBSyL
 iBeR64iGtFGoyYwgam3GlVuv31DsVA/RMheBs8G+Wr+WLkkoLlHN5HiAVILDC0NccOaz
 sHJO0UNyyBeFO3kkvb1JG3kvdQaQ3l1ku7zEqB1+EP3/s/rEvxHCz83p3PjVrlMupWMA
 O7XRP1vb2rLrVl4Btd62PcS9zuUZu/c+8IsCyByX0tPY73aqXKEeOtHmnJs31nNU8b8N 0Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 360kcykwec-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 Jan 2021 00:13:59 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10C05wGo073452;
        Tue, 12 Jan 2021 00:13:59 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 360kex2drg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jan 2021 00:13:59 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 10C0DjXO018290;
        Tue, 12 Jan 2021 00:13:45 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 11 Jan 2021 16:13:44 -0800
Subject: Re: [RFC PATCH 0/2] userfaultfd: handle minor faults, add
 UFFDIO_CONTINUE
To:     Peter Xu <peterx@redhat.com>
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chinwen Chang <chinwen.chang@mediatek.com>,
        Huang Ying <ying.huang@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Michel Lespinasse <walken@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>, Shaohua Li <shli@fb.com>,
        Shawn Anastasio <shawn@anastas.io>,
        Steven Rostedt <rostedt@goodmis.org>,
        Steven Price <steven.price@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Adam Ruprecht <ruprecht@google.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Oliver Upton <oupton@google.com>
References: <20210107190453.3051110-1-axelrasmussen@google.com>
 <48f4f43f-eadd-f37d-bd8f-bddba03a7d39@oracle.com>
 <20210111230848.GA588752@xz-x1>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <2b31c1ad-2b61-32e7-e3e5-63a3041eabfd@oracle.com>
Date:   Mon, 11 Jan 2021 16:13:41 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20210111230848.GA588752@xz-x1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9861 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 adultscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101110138
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9861 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0
 impostorscore=0 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 mlxlogscore=999 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101110138
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/11/21 3:08 PM, Peter Xu wrote:
> On Mon, Jan 11, 2021 at 02:42:48PM -0800, Mike Kravetz wrote:
>> On 1/7/21 11:04 AM, Axel Rasmussen wrote:
>>> Overview
>>> ========
>>>
>>> This series adds a new userfaultfd registration mode,
>>> UFFDIO_REGISTER_MODE_MINOR. This allows userspace to intercept "minor" faults.
>>> By "minor" fault, I mean the following situation:
>>>
>>> Let there exist two mappings (i.e., VMAs) to the same page(s) (shared memory).
>>> One of the mappings is registered with userfaultfd (in minor mode), and the
>>> other is not. Via the non-UFFD mapping, the underlying pages have already been
>>> allocated & filled with some contents. The UFFD mapping has not yet been
>>> faulted in; when it is touched for the first time, this results in what I'm
>>> calling a "minor" fault. As a concrete example, when working with hugetlbfs, we
>>> have huge_pte_none(), but find_lock_page() finds an existing page.
>>>
>>> We also add a new ioctl to resolve such faults: UFFDIO_CONTINUE. The idea is,
>>> userspace resolves the fault by either a) doing nothing if the contents are
>>> already correct, or b) updating the underlying contents using the second,
>>> non-UFFD mapping (via memcpy/memset or similar, or something fancier like RDMA,
>>> or etc...). In either case, userspace issues UFFDIO_CONTINUE to tell the kernel
>>> "I have ensured the page contents are correct, carry on setting up the mapping".
>>>
>>
>> One quick thought.
>>
>> This is not going to work as expected with hugetlbfs pmd sharing.  If you
>> are not familiar with hugetlbfs pmd sharing, you are not alone. :)
>>
>> pmd sharing is enabled for x86 and arm64 architectures.  If there are multiple
>> shared mappings of the same underlying hugetlbfs file or shared memory segment
>> that are 'suitably aligned', then the PMD pages associated with those regions
>> are shared by all the mappings.  Suitably aligned means 'on a 1GB boundary'
>> and 1GB in size.
>>
>> When pmds are shared, your mappings will never see a 'minor fault'.  This
>> is because the PMD (page table entries) is shared.
> 
> Thanks for raising this, Mike.
> 
> I've got a few patches that plan to disable huge pmd sharing for uffd in
> general, e.g.:
> 
> https://github.com/xzpeter/linux/commit/f9123e803d9bdd91bf6ef23b028087676bed1540
> https://github.com/xzpeter/linux/commit/aa9aeb5c4222a2fdb48793cdbc22902288454a31
> 
> I believe we don't want that for missing mode too, but it's just not extremely
> important for missing mode yet, because in missing mode we normally monitor all
> the processes that will be using the registered mm range.  For example, in QEMU
> postcopy migration with vhost-user hugetlbfs files as backends, we'll monitor
> both the QEMU process and the DPDK program, so that either of the programs will
> trigger a missing fault even if pmd shared between them.  However again I think
> it's not ideal since uffd (even if missing mode) is pgtable-based, so sharing
> could always be too tricky.
> 
> They're not yet posted to public yet since that's part of uffd-wp support for
> hugetlbfs (along with shmem).  So just raise this up to avoid potential
> duplicated work before I post the patchset.
> 
> (Will read into details soon; probably too many things piled up...)

Thanks for the heads up about this Peter.

I know Oracle DB really wants shared pmds -and- UFFD.  I need to get details
of their exact usage model.  I know they primarily use SIGBUS, but use
MISSING_HUGETLBFS as well.  We may need to be more selective in when to
disable.

-- 
Mike Kravetz
