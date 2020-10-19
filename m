Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A738292E14
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Oct 2020 21:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731228AbgJSTEl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Oct 2020 15:04:41 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:44332 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731220AbgJSTEk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Oct 2020 15:04:40 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09JIsEfY062482;
        Mon, 19 Oct 2020 19:03:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=EC+J7ah2W71offlqrVjvLudJMGpmFKGp6UHyonnt/xo=;
 b=dPwLybw8G2mpMYUEMx9H5KSnnBXhbvSNMSLKO8gtkeCBHcBvQAbaqCLuK/Ot7g35l9EM
 XQsRp3tECIUEz44RNP7TS7WGWgdCsuL7fc6leHt6k1yRAownFljnyefOYsYxGel5EFCj
 jPk7/rD3YNyqsf7NlUWAYyhB81IZaRjcpunc9ALg47DEBCn61eQw/iGeuDCte4jrRjZT
 I9JqF3aOsRSdQGHcgFGfvuaQdRRmcpQVxyWS2CYNvzwJ2gjpnXSYrePy9LOxdmXNvAJ4
 oihLf3PRAQIfeN+56sRYfEXB59c3QOqiePBn2VJ+lWhXkbA2R+mcSV9nYqrONzHXVWkp DA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 347s8mq69x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 19 Oct 2020 19:03:21 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09JItYev165922;
        Mon, 19 Oct 2020 19:03:20 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 348agwg5n4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Oct 2020 19:03:20 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 09JJ3G6d032708;
        Mon, 19 Oct 2020 19:03:17 GMT
Received: from [10.175.162.151] (/10.175.162.151)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 19 Oct 2020 12:03:16 -0700
Subject: Re: [PATCH 00/35] Enhance memory utilization with DMEMFS
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     yulei zhang <yulei.kernel@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kvm <kvm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        Haiwei Li <lihaiwei.kernel@gmail.com>,
        Yulei Zhang <yuleixzhang@tencent.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Jane Y Chu <jane.chu@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
References: <cover.1602093760.git.yuleixzhang@tencent.com>
 <bdd0250e-4e14-f407-a584-f39af12c4e09@oracle.com>
 <CACZOiM2qKhogXQ_DXzWjGM5UCeCuEqT6wnR=f2Wi_T45_uoYHQ@mail.gmail.com>
 <b963565b-61d8-89d3-1abd-50cd8c8daad5@oracle.com>
 <CACZOiM26GPtqkGyecG=NGuB3etipV5-KgN+s19_U1WJrFxtYPQ@mail.gmail.com>
 <98be093d-c869-941a-6dd9-fb16356f763b@oracle.com>
 <CAPcyv4jZ7XTnYd7vLQ18xij7d+80jU0zLs+ykS2frY-LMPS=Nw@mail.gmail.com>
 <3626f5ff-b6a0-0811-5899-703a0714897d@redhat.com>
From:   Joao Martins <joao.m.martins@oracle.com>
Message-ID: <0c8fd8ab-c0d4-003a-6943-1ec732c96e1c@oracle.com>
Date:   Mon, 19 Oct 2020 20:03:09 +0100
MIME-Version: 1.0
In-Reply-To: <3626f5ff-b6a0-0811-5899-703a0714897d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9779 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010190126
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9779 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0
 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501 spamscore=0
 phishscore=0 clxscore=1015 bulkscore=0 impostorscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010190126
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/19/20 2:37 PM, Paolo Bonzini wrote:
> On 15/10/20 00:25, Dan Williams wrote:
>> Now, with recent device-dax extensions, it
>> also has a coarse grained memory management system for  physical
>> address-space partitioning and a path for struct-page-less backing for
>> VMs. What feature gaps remain vs dmemfs, and can those gaps be closed
>> with incremental improvements to the 2 existing memory-management
>> systems?
> 
> If I understand correctly, devm_memremap_pages() on ZONE_DEVICE memory
> would still create the "struct page" albeit lazily?  KVM then would use
> the usual get_user_pages() path.
> 
Correct.

The removal of struct page would be one of the added incremental improvements, like a
'map' with 'raw' sysfs attribute for dynamic dax regions that wouldn't online/create the
struct pages. The remaining plumbing (...)

> Looking more closely at the implementation of dmemfs, I don't understand
> is why dmemfs needs VM_DMEM etc. and cannot provide access to mmap-ed
> memory using remap_pfn_range and VM_PFNMAP, just like /dev/mem.  If it
> did that KVM would get physical addresses using fixup_user_fault and
> never need pfn_to_page() or get_user_pages().  I'm not saying that would
> instantly be an approval, but it would make remove a lot of hooks.
> 

(...) is similar to what you describe above. Albeit there's probably no need to do a
remap_pfn_range at mmap(), as DAX supplies a fault/huge_fault. Also, using that means it's
limited to a single contiguous PFN chunk.

KVM has the bits to make it work without struct pages, I don't think there's a need for
new pg/pfn_t/VM_* bits (aside from relying on {PFN,PAGE}_SPECIAL) as mentioned at the
start of the thread. I'm storing my wip here:

	https://github.com/jpemartins/linux pageless-dax

Which is based on the first series that had been submitted earlier this year:

	https://lore.kernel.org/kvm/20200110190313.17144-1-joao.m.martins@oracle.com/

  Joao
