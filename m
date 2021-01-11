Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C57752F2435
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jan 2021 01:34:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404264AbhALAZi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Jan 2021 19:25:38 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:56074 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390497AbhAKWot (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Jan 2021 17:44:49 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10BMdih7051839;
        Mon, 11 Jan 2021 22:43:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=6Ose25Stsa51S7paVM2cR2t4IRVZY53vBBpbLwwbkAA=;
 b=OghPzvJl8YKoQgZy+h246WtI8gJr1vTaM4fGqtfvDD4fahBYOUU4hiOIcq3Dng8s4Hzk
 3H+t61iDmRgbzOPeXjjsZUYcV76d9XnKjpoAOGe+z1hqA93Ar7+wzFDKyb7YJP6UQnTH
 w+/T3kNBCao6O3DsdnYRGzlEajcS8pn1VQ1PDdfEky7U1AhlB2ZTffNTRc7W5E13fx/x
 zo7RA6wj49BDQjBD+OqpjHrBgwPNFwM2wa/A3lGd2Tv4YLVAjjlbwuaLXZ/lB9oascl2
 HUTkDh33+PDz2W4Y0DoO+osPTxLC40i3M5JyIQz/r9XAlMytVg3bRKrRviOmYKcssNWB qw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 360kcykpnx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 Jan 2021 22:43:01 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10BMeTU6011908;
        Mon, 11 Jan 2021 22:43:01 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 360kefuysq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Jan 2021 22:43:01 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 10BMgpJ8003688;
        Mon, 11 Jan 2021 22:42:51 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 11 Jan 2021 14:42:51 -0800
Subject: Re: [RFC PATCH 0/2] userfaultfd: handle minor faults, add
 UFFDIO_CONTINUE
To:     Axel Rasmussen <axelrasmussen@google.com>,
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
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Xu <peterx@redhat.com>, Shaohua Li <shli@fb.com>,
        Shawn Anastasio <shawn@anastas.io>,
        Steven Rostedt <rostedt@goodmis.org>,
        Steven Price <steven.price@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Adam Ruprecht <ruprecht@google.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Oliver Upton <oupton@google.com>
References: <20210107190453.3051110-1-axelrasmussen@google.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <48f4f43f-eadd-f37d-bd8f-bddba03a7d39@oracle.com>
Date:   Mon, 11 Jan 2021 14:42:48 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20210107190453.3051110-1-axelrasmussen@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9861 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 spamscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101110127
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9861 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0
 impostorscore=0 bulkscore=0 adultscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1011 mlxlogscore=999 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101110127
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/7/21 11:04 AM, Axel Rasmussen wrote:
> Overview
> ========
> 
> This series adds a new userfaultfd registration mode,
> UFFDIO_REGISTER_MODE_MINOR. This allows userspace to intercept "minor" faults.
> By "minor" fault, I mean the following situation:
> 
> Let there exist two mappings (i.e., VMAs) to the same page(s) (shared memory).
> One of the mappings is registered with userfaultfd (in minor mode), and the
> other is not. Via the non-UFFD mapping, the underlying pages have already been
> allocated & filled with some contents. The UFFD mapping has not yet been
> faulted in; when it is touched for the first time, this results in what I'm
> calling a "minor" fault. As a concrete example, when working with hugetlbfs, we
> have huge_pte_none(), but find_lock_page() finds an existing page.
> 
> We also add a new ioctl to resolve such faults: UFFDIO_CONTINUE. The idea is,
> userspace resolves the fault by either a) doing nothing if the contents are
> already correct, or b) updating the underlying contents using the second,
> non-UFFD mapping (via memcpy/memset or similar, or something fancier like RDMA,
> or etc...). In either case, userspace issues UFFDIO_CONTINUE to tell the kernel
> "I have ensured the page contents are correct, carry on setting up the mapping".
> 

One quick thought.

This is not going to work as expected with hugetlbfs pmd sharing.  If you
are not familiar with hugetlbfs pmd sharing, you are not alone. :)

pmd sharing is enabled for x86 and arm64 architectures.  If there are multiple
shared mappings of the same underlying hugetlbfs file or shared memory segment
that are 'suitably aligned', then the PMD pages associated with those regions
are shared by all the mappings.  Suitably aligned means 'on a 1GB boundary'
and 1GB in size.

When pmds are shared, your mappings will never see a 'minor fault'.  This
is because the PMD (page table entries) is shared.

-- 
Mike Kravetz
