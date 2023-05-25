Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70E64710390
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 May 2023 05:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237076AbjEYDyH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 May 2023 23:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjEYDyD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 May 2023 23:54:03 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE8AA139;
        Wed, 24 May 2023 20:54:01 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34P3Be6x026169;
        Thu, 25 May 2023 03:52:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=v6ZXU6gtBWqPvIHL/d+qw2nLh7zTm1pTEzgdqM8BY18=;
 b=B6YqZS1jPqUF06BXEDrHfDzumBPLwVJwEDM6Mlu3IE2H6cUE7J6o6ibyuUr7Tzm/OaMs
 hhautrhEj/2PGY+41qIPtpYoflgWRj/JHrKKa9zF8uUSpIAis0gld8gLLP+5xJWW1GMe
 sX5+Xajub5MRLWHzRBG5eH/M/bUHF1GEUu7rxcIMZLxBXx/wlfZFX6cDKHX6px+mzpwm
 kuLEs7WvC0qpOzkjLZTxIq9PsF/ZaNyTduC2Dxkedp6GGbQ4D0E1zA1TyvuZ0HZLdVXV
 5URnhC0WaDcCJ3qGCDSNvi50mCcjSmiVmP1CVeL0qUJlMWAvIaqH4Z7WiSQkdl5V8cea +A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qsyjagq7v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 May 2023 03:52:29 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34P3qS3q008921;
        Thu, 25 May 2023 03:52:28 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qsyjagq71-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 May 2023 03:52:28 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34P0fMmO026389;
        Thu, 25 May 2023 03:52:25 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3qppdk284d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 May 2023 03:52:25 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34P3qNT118350798
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 May 2023 03:52:23 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4097C20043;
        Thu, 25 May 2023 03:52:23 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D2F4420040;
        Thu, 25 May 2023 03:52:14 +0000 (GMT)
Received: from li-a450e7cc-27df-11b2-a85c-b5a9ac31e8ef.ibm.com (unknown [9.109.216.99])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Thu, 25 May 2023 03:52:14 +0000 (GMT)
Date:   Thu, 25 May 2023 09:22:12 +0530
From:   Kautuk Consul <kconsul@linux.vnet.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Sean Christopherson <seanjc@google.com>,
        Chao Peng <chao.p.peng@linux.intel.com>, kvm@vger.kernel.org,
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
Message-ID: <ZG7bbAkRfHkBijZb@li-a450e7cc-27df-11b2-a85c-b5a9ac31e8ef.ibm.com>
References: <20220706082016.2603916-1-chao.p.peng@linux.intel.com>
 <20220706082016.2603916-9-chao.p.peng@linux.intel.com>
 <ZGxo9ylqYI8JXjGn@li-a450e7cc-27df-11b2-a85c-b5a9ac31e8ef.ibm.com>
 <ZGzLf4zgxpBjghaF@google.com>
 <ZG2qv9sWl2RUnGqd@li-a450e7cc-27df-11b2-a85c-b5a9ac31e8ef.ibm.com>
 <ZG5wg3VbG4rCYrfk@google.com>
 <20230524203336.GC3447678@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230524203336.GC3447678@hirez.programming.kicks-ass.net>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: JMCMkBzE0_vErxya7Uw2ZgGvqaMed5tP
X-Proofpoint-ORIG-GUID: bS2bLfFp6dr_ipd_3qmflAOTtlaGVqG_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-24_17,2023-05-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 phishscore=0 clxscore=1011 spamscore=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=901 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2304280000 definitions=main-2305250027
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2023-05-24 22:33:36, Peter Zijlstra wrote:
> On Wed, May 24, 2023 at 01:16:03PM -0700, Sean Christopherson wrote:
> 
> > Atomics aren't memory barriers on all architectures, e.g. see the various
> > definitions of smp_mb__after_atomic().
> > 
> > Even if atomic operations did provide barriers, using an atomic would be overkill
> > and a net negative.  On strongly ordered architectures like x86, memory barriers are
> > just compiler barriers, whereas atomics may be more expensive. 
> 
> Not quite, smp_{r,w}mb() and smp_mb__{before,after}_atomic() are
> compiler barriers on the TSO archs, but smp_mb() very much isn't. TSO
> still allows stores to be delayed vs later loads (iow it doesn't pretend
> to hide the store buffer).
> 
> > Of course, the only
> > accesses outside of mmu_lock are reads, so on x86 that "atomic" access is just a
> > READ_ONCE() load, but that's not the case for all architectures.
> 
> This is true on *all* archs. atomic_set() and atomic_read() are no more
> and no less than WRITE_ONCE() / READ_ONCE().
> 
> > Anyways, the point is that atomics and memory barriers are different things that
> > serve different purposes.
> 
> This is true; esp. on the weakly ordered architectures where atomics do
> not naturally imply any ordering.

Thanks for the information, everyone.
