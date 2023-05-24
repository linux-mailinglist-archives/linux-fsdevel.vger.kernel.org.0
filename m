Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA21970EDBA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 May 2023 08:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234471AbjEXGPm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 May 2023 02:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239661AbjEXGPk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 May 2023 02:15:40 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E421A4;
        Tue, 23 May 2023 23:15:36 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34O690VE032324;
        Wed, 24 May 2023 06:12:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=PTmt9eLhdeiVXDS8uO8Ia64QTDlBey9Rm/GKOYWEYks=;
 b=brcpmZ8gK8yEHAN8/mcEbLmoGFQ+ZViwNCvq2fOZVZSnkODRG4LIPuwpv1iwSkyBMj/5
 PI3hDUV2VIA2BJs9h2JbUcnMa7DvnxN2PmZk+Lz8OInKw18s09iq2LbgEdoKdgKYhMnt
 GXiS5bjm0OIRDiX8QyXxNr8i4Yee7Pg8aIBlezoyytXtAZVBFf+si/ddW/3s+ZWVfvcA
 +mkbWo/i9t5OvlibGD9sKF+DN+AA7bNEutNefZbAw2eCJPc6kXQK6WQv1jD40eJ8oYP8
 NhaBEFYld+wfa1kRlkPTrobAPMmC4wGTYMK3duueZdqDK0VJqhEssyJAVDs3yWvqy/zI qA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qscnn8ek8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 May 2023 06:12:40 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34O6AGav003763;
        Wed, 24 May 2023 06:12:40 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qscnn8ej0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 May 2023 06:12:39 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34O3o6ux006708;
        Wed, 24 May 2023 06:12:36 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3qppcu9sxh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 May 2023 06:12:36 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34O6CYvi40763918
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 May 2023 06:12:34 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3012A20043;
        Wed, 24 May 2023 06:12:34 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E30AD20040;
        Wed, 24 May 2023 06:12:18 +0000 (GMT)
Received: from li-a450e7cc-27df-11b2-a85c-b5a9ac31e8ef.ibm.com (unknown [9.43.69.169])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Wed, 24 May 2023 06:12:18 +0000 (GMT)
Date:   Wed, 24 May 2023 11:42:15 +0530
From:   Kautuk Consul <kconsul@linux.vnet.ibm.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Chao Peng <chao.p.peng@linux.intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, qemu-devel@nongnu.org,
        linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Hugh Dickins <hughd@google.com>,
        Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Steven Price <steven.price@arm.com>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        Vishal Annapurve <vannapurve@google.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        luto@kernel.org, jun.nakajima@intel.com, dave.hansen@intel.com,
        ak@linux.intel.com, david@redhat.com, aarcange@redhat.com,
        ddutile@redhat.com, dhildenb@redhat.com,
        Quentin Perret <qperret@google.com>,
        Michael Roth <michael.roth@amd.com>, mhocko@suse.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH v7 08/14] KVM: Rename mmu_notifier_*
Message-ID: <ZG2qv9sWl2RUnGqd@li-a450e7cc-27df-11b2-a85c-b5a9ac31e8ef.ibm.com>
References: <20220706082016.2603916-1-chao.p.peng@linux.intel.com>
 <20220706082016.2603916-9-chao.p.peng@linux.intel.com>
 <ZGxo9ylqYI8JXjGn@li-a450e7cc-27df-11b2-a85c-b5a9ac31e8ef.ibm.com>
 <ZGzLf4zgxpBjghaF@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGzLf4zgxpBjghaF@google.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: C_AuAVKyjz4dkd3v88ALmdwDrbrcmXFC
X-Proofpoint-GUID: VJrRvR4p51BQjUredRyG9glImPen9xGi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-24_02,2023-05-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 phishscore=0 malwarescore=0 clxscore=1015 adultscore=0 mlxlogscore=898
 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305240051
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2023-05-23 07:19:43, Sean Christopherson wrote:
> On Tue, May 23, 2023, Kautuk Consul wrote:
> > On 2022-07-06 16:20:10, Chao Peng wrote:
> > > diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> > > index e9153b54e2a4..c262ebb168a7 100644
> > > --- a/include/linux/kvm_host.h
> > > +++ b/include/linux/kvm_host.h
> > > @@ -765,10 +765,10 @@ struct kvm {
> > >  
> > >  #if defined(CONFIG_MMU_NOTIFIER) && defined(KVM_ARCH_WANT_MMU_NOTIFIER)
> > >  	struct mmu_notifier mmu_notifier;
> > > -	unsigned long mmu_notifier_seq;
> > > -	long mmu_notifier_count;
> > > -	gfn_t mmu_notifier_range_start;
> > > -	gfn_t mmu_notifier_range_end;
> > > +	unsigned long mmu_updating_seq;
> > > +	long mmu_updating_count;
> > 
> > Can we convert mmu_updating_seq and mmu_updating_count to atomic_t ?
> 
> Heh, can we?  Yes.  Should we?  No.
> 
> > I see that not all accesses to these are under the kvm->mmu_lock
> > spinlock.
> 
> Ya, working as intended.  Ignoring gfn_to_pfn_cache for the moment, all accesses
> to mmu_invalidate_in_progress (was mmu_notifier_count / mmu_updating_count above)
> are done under mmu_lock.  And for for mmu_notifier_seq (mmu_updating_seq above),
> all writes and some reads are done under mmu_lock.  The only reads that are done
> outside of mmu_lock are the initial snapshots of the sequence number.
> 
> gfn_to_pfn_cache uses a different locking scheme, the comments in
> mmu_notifier_retry_cache() do a good job explaining the ordering.
> 
> > This will also remove the need for putting separate smp_wmb() and
> > smp_rmb() memory barriers while accessing these structure members.
> 
> No, the memory barriers aren't there to provide any kind of atomicity.  The barriers
> exist to ensure that stores and loads to/from the sequence and invalidate in-progress
> counts are ordered relative to the invalidation (stores to counts) and creation (loads)
> of SPTEs.  Making the counts atomic changes nothing because atomic operations don't
> guarantee the necessary ordering.
I'm not saying that the memory barriers provide atomicity.
My comment was based on the assumption that "all atomic operations are
implicit memory barriers". If that assumption is true then we won't need
the memory barriers here if we use atomic operations for protecting
these 2 structure members.
> 
> E.g. when handling a page fault, KVM snapshots the sequence outside of mmu_lock
> _before_ touching any state that is involved in resolving the host pfn, e.g. primary
> MMU state (VMAs, host page tables, etc.).   After the page fault task acquires
> mmu_lock, KVM checks that there are no in-progress invalidations and that the sequence
> count is the same.  This ensures that if there is a concurrent page fault and
> invalidation event, the page fault task will either acquire mmu_lock and create SPTEs
> _before_ the invalidation is processed, or the page fault task will observe either an
> elevated mmu_invalidate_in_progress or a different sequence count, and thus retry the
> page fault, if the page fault task acquires mmu_lock after the invalidation event.
