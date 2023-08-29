Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E72B78BD12
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Aug 2023 04:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232536AbjH2Cy5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Aug 2023 22:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233355AbjH2Cyy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Aug 2023 22:54:54 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B3FB9;
        Mon, 28 Aug 2023 19:54:50 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37T2NYix025517;
        Tue, 29 Aug 2023 02:53:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=cKhR/hXI9TfQVMxJKBEpbKXuPkzD/6c5MCP4RSxTLCw=;
 b=aJjaitgE+MNEcv6pStestGm3ovNl2PCHIDgAS0ezUu1PJhWjiVAJkaWbVdyPPMxXqeuv
 J8TGIrU+0GAuxQX7eIIapM8gHoJ/i/+3Lg86ilvRhCdks0OYIgvIXDu+m1F9qvPig1n9
 qmaPZSttzxHapTHsQhqj+8ez1Mh6AU41gyUZuYSjEw/M6ix2alFl2clZcq2fzw9TRV8m
 T3VdqIsiJZXsGkuNzRqG8q7Wyez0X9VKsY1Jq2v4Bt+32v5og2RtpbTDAMPn6awuDbIF
 bXfmOhB1JZWgA6QKAkE/ndq/tn0aSh7gBLV6EKEnJxvPb+roMqUGXj3Ar6OaLs3F+VbY DQ== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ss7mer1wr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 02:53:30 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37T2rTft030498
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 02:53:29 GMT
Received: from [10.110.29.109] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Mon, 28 Aug
 2023 19:53:26 -0700
Message-ID: <253965df-6d80-bbfd-ab01-f9e69b274bf3@quicinc.com>
Date:   Mon, 28 Aug 2023 19:53:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RFC PATCH v11 12/29] KVM: Add KVM_CREATE_GUEST_MEMFD ioctl() for
 guest-specific backing memory
Content-Language: en-US
To:     Ackerley Tng <ackerleytng@google.com>,
        Sean Christopherson <seanjc@google.com>
CC:     <pbonzini@redhat.com>, <maz@kernel.org>, <oliver.upton@linux.dev>,
        <chenhuacai@kernel.org>, <mpe@ellerman.id.au>,
        <anup@brainfault.org>, <paul.walmsley@sifive.com>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
        <willy@infradead.org>, <akpm@linux-foundation.org>,
        <paul@paul-moore.com>, <jmorris@namei.org>, <serge@hallyn.com>,
        <kvm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <kvmarm@lists.linux.dev>, <linux-mips@vger.kernel.org>,
        <linuxppc-dev@lists.ozlabs.org>, <kvm-riscv@lists.infradead.org>,
        <linux-riscv@lists.infradead.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <chao.p.peng@linux.intel.com>,
        <tabba@google.com>, <jarkko@kernel.org>,
        <yu.c.zhang@linux.intel.com>, <vannapurve@google.com>,
        <mail@maciej.szmigiero.name>, <vbabka@suse.cz>, <david@redhat.com>,
        <qperret@google.com>, <michael.roth@amd.com>,
        <wei.w.wang@intel.com>, <liam.merwick@oracle.com>,
        <isaku.yamahata@gmail.com>, <kirill.shutemov@linux.intel.com>
References: <diqzttsiu67n.fsf@ackerleytng-ctop.c.googlers.com>
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <diqzttsiu67n.fsf@ackerleytng-ctop.c.googlers.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: j_S7WCFYaAduXo62GgrPKoDWB6xd2scP
X-Proofpoint-GUID: j_S7WCFYaAduXo62GgrPKoDWB6xd2scP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-28_20,2023-08-28_04,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 bulkscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 priorityscore=1501 clxscore=1011 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308290024
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 8/28/2023 3:56 PM, Ackerley Tng wrote:
 > 1. Since the physical memory's representation is the inode and should be
 >     coupled to the virtual machine (as a concept, not struct kvm), should
 >     the binding/coupling be with the file, or the inode?
 >

I've been working on Gunyah's implementation in parallel (not yet posted 
anywhere). Thus far, I've coupled the virtual machine struct to the 
struct file so that I can increment the file refcount when mapping the 
gmem to the virtual machine.

 > 2. Should struct kvm still be bound to the file/inode at gmem file
 >     creation time, since
 >
 >     + struct kvm isn't a good representation of a "virtual machine"
 >     + we currently don't have anything that really represents a "virtual
 >       machine" without hardware support
 >
 >
 > I'd also like to bring up another userspace use case that Google has:
 > re-use of gmem files for rebooting guests when the KVM instance is
 > destroyed and rebuilt.
 >
 > When rebooting a VM there are some steps relating to gmem that are
 > performance-sensitive:
 >
 > a.      Zeroing pages from the old VM when we close a gmem file/inode
 > b. Deallocating pages from the old VM when we close a gmem file/inode
 > c.   Allocating pages for the new VM from the new gmem file/inode
 > d.      Zeroing pages on page allocation
 >
 > We want to reuse the gmem file to save re-allocating pages (b. and c.),
 > and one of the two page zeroing allocations (a. or d.).
 >
 > Binding the gmem file to a struct kvm on creation time means the gmem
 > file can't be reused with another VM on reboot. Also, host userspace is
 > forced to close the gmem file to allow the old VM to be freed.
 >
 > For other places where files pin KVM, like the stats fd pinning vCPUs, I
 > guess that matters less since there isn't much of a penalty to close and
 > re-open the stats fd.

I had a 3rd question that's related to how to wire the gmem up to a 
virtual machine:

I learned of a usecase to implement copy-on-write for gmem. The premise 
would be to have a "golden copy" of the memory that multiple virtual 
machines can map in as RO. If a virtual machine tries to write to those 
pages, they get copied to a virtual machine-specific page that isn't 
shared with other VMs. How do we track those pages?

Thanks,
Elliot
