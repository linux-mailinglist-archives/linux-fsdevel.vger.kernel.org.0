Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD9E8763D8E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jul 2023 19:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232465AbjGZRUJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jul 2023 13:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232358AbjGZRUC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jul 2023 13:20:02 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66CE82706;
        Wed, 26 Jul 2023 10:19:55 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36QGlQu6027300;
        Wed, 26 Jul 2023 17:18:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : from : subject : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=ip3sa1zKMQ2zxWsxMFPxdq3PaMdI/MwxyZTVXbJTpvs=;
 b=i2RDq/0ouE1p0Qk33YvTF/NHZO7HzDwmf4G6/X9boSMShdSMP7py+5eEipe35xBxMlaG
 MdcVym7bNRuamvdEEm03a7KedxDMBhu4/3t7mYSxCf6H2g1c16fbfn2afIlrjMD4BlqY
 xP9K0s7wqqxnYtklUY6zEPCt5WBxv5DWfKOuX9t4Dy/V4/ierZhWKSvTlbyhoxwnwNPq
 ndGmjKB2WdSLWa4i2eYGe9wKyhXrHRAbT8uzTpMFrHrRJNkGvm+Rc9VeKdzXH4EWUj1x
 /2Hf+Oh7Ysdzl9v2/c/1CZ2hi3Pwn8Avzu+8uGCTp8vnPqbIEM/iSFctK4eEqwNDg/D8 rw== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s34x6gffc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jul 2023 17:18:39 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36QHIcJQ030805
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jul 2023 17:18:38 GMT
Received: from [10.71.109.50] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 26 Jul
 2023 10:18:37 -0700
Message-ID: <8f7ea958-7caa-a185-10d2-900024aeddf0@quicinc.com>
Date:   Wed, 26 Jul 2023 10:18:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
From:   Elliot Berman <quic_eberman@quicinc.com>
Subject: Re: [RFC PATCH v11 12/29] KVM: Add KVM_CREATE_GUEST_MEMFD ioctl() for
 guest-specific backing memory
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Huacai Chen <chenhuacai@kernel.org>,
        "Michael Ellerman" <mpe@ellerman.id.au>,
        Anup Patel <anup@brainfault.org>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
CC:     <kvm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <kvmarm@lists.linux.dev>, <linux-mips@vger.kernel.org>,
        <linuxppc-dev@lists.ozlabs.org>, <kvm-riscv@lists.infradead.org>,
        <linux-riscv@lists.infradead.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Chao Peng <chao.p.peng@linux.intel.com>,
        "Fuad Tabba" <tabba@google.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Ackerley Tng <ackerleytng@google.com>,
        Maciej Szmigiero <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        "David Hildenbrand" <david@redhat.com>,
        Quentin Perret <qperret@google.com>,
        "Michael Roth" <michael.roth@amd.com>, Wang <wei.w.wang@intel.com>,
        Liam Merwick <liam.merwick@oracle.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
References: <20230718234512.1690985-1-seanjc@google.com>
 <20230718234512.1690985-13-seanjc@google.com>
Content-Language: en-US
In-Reply-To: <20230718234512.1690985-13-seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: hvBAyKu5NMlIhf3rhtakVUP0GpxUNjz7
X-Proofpoint-ORIG-GUID: hvBAyKu5NMlIhf3rhtakVUP0GpxUNjz7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-26_08,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 adultscore=0 impostorscore=0 mlxscore=0
 bulkscore=0 spamscore=0 clxscore=1011 phishscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307260154
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 7/18/2023 4:44 PM, Sean Christopherson wrote:
> TODO
  <snip>
> diff --git a/include/uapi/linux/magic.h b/include/uapi/linux/magic.h
> index 6325d1d0e90f..15041aa7d9ae 100644
> --- a/include/uapi/linux/magic.h
> +++ b/include/uapi/linux/magic.h
> @@ -101,5 +101,6 @@
>   #define DMA_BUF_MAGIC		0x444d4142	/* "DMAB" */
>   #define DEVMEM_MAGIC		0x454d444d	/* "DMEM" */
>   #define SECRETMEM_MAGIC		0x5345434d	/* "SECM" */
> +#define GUEST_MEMORY_MAGIC	0x474d454d	/* "GMEM" */


Should this be:

#define GUEST_MEMORY_KVM_MAGIC

or KVM_GUEST_MEMORY_KVM_MAGIC?

BALLOON_KVM_MAGIC is KVM-specific few lines above.

---

Originally, I was planning to use the generic guest memfd infrastructure 
to support Gunyah hypervisor, however I see that's probably not going to 
be possible now that the guest memfd implementation is KVM-specific. I 
think this is good for both KVM and Gunyah as there will be some Gunyah 
specifics and some KVM specifics in each of implementation, as you 
mentioned in the previous series.

I'll go through series over next week or so and I'll try to find how 
much similar Gunyah guest mem fd implementation would be and we can see 
if it's better to pull whatever that ends up being into a common 
implementation? We could also agree to have completely divergent fd 
implementations like we do for the UAPI. Thoughts?

Thanks,
Elliot

  <snip>
