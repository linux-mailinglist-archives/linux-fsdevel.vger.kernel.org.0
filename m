Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 327272886ED
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Oct 2020 12:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731978AbgJIK34 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Oct 2020 06:29:56 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:33382 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725979AbgJIK3z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Oct 2020 06:29:55 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 099AKk5E081439;
        Fri, 9 Oct 2020 10:28:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=iO7iieAE97VWREkueb1YYE1lfRocN/epUOpy+ZHHzLU=;
 b=lm/RRwEN7aMfPBGuu1y8+/4adW66cEn+DgLonp2Cdor0mppzl8uvoXGxADkJGXzaahLt
 08zSAgiY+fuMh6tp5BIn3HO/xI9FiGXYGAvEsnjUVQICwqzoX437nzYz7/eJbZmaJrke
 sE9v5SNvFFNfgL1dH20+B051p/OgMi7bOPKQmkhCo6gfGayoRqV+hCsxvEdpAwA27BmR
 KWmf6KPdEd3FhRWsN26JIB7pcqKANL7eF+hkIaaigun95lhrqk8ADLMcyIxYUUUQDVZG
 rL7P3chD49VMIw9nGsp2r4BOSof7u6vPob3e/gcg+9ROOAjIT/mraIkajbyHC1ipo2SC xA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 3429juts2b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 09 Oct 2020 10:28:39 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 099AQH6t142717;
        Fri, 9 Oct 2020 10:28:38 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 3429k0x68n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Oct 2020 10:28:38 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 099ASa86025600;
        Fri, 9 Oct 2020 10:28:36 GMT
Received: from [10.175.178.74] (/10.175.178.74)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 09 Oct 2020 03:28:36 -0700
Subject: Re: [PATCH 22/35] kvm, x86: Distinguish dmemfs page from mmio page
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        yulei.kernel@gmail.com
Cc:     akpm@linux-foundation.org, naoya.horiguchi@nec.com,
        viro@zeniv.linux.org.uk, pbonzini@redhat.com,
        linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, xiaoguangrong.eric@gmail.com,
        kernellwp@gmail.com, lihaiwei.kernel@gmail.com,
        Yulei Zhang <yuleixzhang@tencent.com>,
        Chen Zhuo <sagazchen@tencent.com>
References: <cover.1602093760.git.yuleixzhang@tencent.com>
 <b2b6837785f6786575823c919788464373d3ee05.1602093760.git.yuleixzhang@tencent.com>
 <20201009005823.GA11151@linux.intel.com>
From:   Joao Martins <joao.m.martins@oracle.com>
Message-ID: <a6dd5fbe-ca71-cf05-ec40-ec916843e9b7@oracle.com>
Date:   Fri, 9 Oct 2020 11:28:31 +0100
MIME-Version: 1.0
In-Reply-To: <20201009005823.GA11151@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9768 signatures=668681
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 suspectscore=1 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010090073
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9768 signatures=668681
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999 mlxscore=0
 phishscore=0 bulkscore=0 suspectscore=1 lowpriorityscore=0 spamscore=0
 clxscore=1011 malwarescore=0 priorityscore=1501 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010090072
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/9/20 1:58 AM, Sean Christopherson wrote:
> On Thu, Oct 08, 2020 at 03:54:12PM +0800, yulei.kernel@gmail.com wrote:
>> From: Yulei Zhang <yuleixzhang@tencent.com>
>>
>> Dmem page is pfn invalid but not mmio. Support cacheable
>> dmem page for kvm.
>>
>> Signed-off-by: Chen Zhuo <sagazchen@tencent.com>
>> Signed-off-by: Yulei Zhang <yuleixzhang@tencent.com>
>> ---
>>  arch/x86/kvm/mmu/mmu.c | 5 +++--
>>  include/linux/dmem.h   | 7 +++++++
>>  mm/dmem.c              | 7 +++++++
>>  3 files changed, 17 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
>> index 71aa3da2a0b7..0115c1767063 100644
>> --- a/arch/x86/kvm/mmu/mmu.c
>> +++ b/arch/x86/kvm/mmu/mmu.c
>> @@ -41,6 +41,7 @@
>>  #include <linux/hash.h>
>>  #include <linux/kern_levels.h>
>>  #include <linux/kthread.h>
>> +#include <linux/dmem.h>
>>  
>>  #include <asm/page.h>
>>  #include <asm/memtype.h>
>> @@ -2962,9 +2963,9 @@ static bool kvm_is_mmio_pfn(kvm_pfn_t pfn)
>>  			 */
>>  			(!pat_enabled() || pat_pfn_immune_to_uc_mtrr(pfn));
>>  
>> -	return !e820__mapped_raw_any(pfn_to_hpa(pfn),
>> +	return (!e820__mapped_raw_any(pfn_to_hpa(pfn),
>>  				     pfn_to_hpa(pfn + 1) - 1,
>> -				     E820_TYPE_RAM);
>> +				     E820_TYPE_RAM)) || (!is_dmem_pfn(pfn));
> 
> This is wrong.  As is, the logic reads "A PFN is MMIO if it is INVALID &&
> (!RAM || !DMEM)".  The obvious fix would be to change it to "INVALID &&
> !RAM && !DMEM", but that begs the question of whether or DMEM is reported
> as RAM.  I don't see any e820 related changes in the series, i.e. no evidence
> that dmem yanks its memory out of the e820 tables, which makes me think this
> change is unnecessary.
> 
Even if there would exist e820 changes, e820__mapped_raw_any() checks against
hardware-provided e820 that we are given before any changes happen i.e. not the one kernel
has changed (e820_table_firmware). So unless you're having that memory carved from an MMIO
range (which would be wrong), or the BIOS is misrepresenting its memory map... the
e820__mapped_raw_any(E820_TYPE_RAM) ought to be enough to cover RAM.

Or at least that has been my experience with similar work.

	Joao
