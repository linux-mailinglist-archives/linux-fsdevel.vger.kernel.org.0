Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C48A466EFD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Dec 2021 02:11:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbhLCBOa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Dec 2021 20:14:30 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:34040 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbhLCBOa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Dec 2021 20:14:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 136EEB823BC;
        Fri,  3 Dec 2021 01:11:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C284C00446;
        Fri,  3 Dec 2021 01:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638493864;
        bh=R/KWoIy8A+QpAIZYriI3L7Yc6+H44YcDyCxAm0FjAwA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ihyFPI+9wQEgGHtHHyI1UGBdo+aBGtm3Q77KfZWJr/tltJr8YQZ5lCMqyoAZvT2ei
         +0CEvmFJIvBpYSzkeX9SOGZDBbhnkT2plO8mlGlqmtatHrcFa9oH0wEoWyXZhmiL5L
         Xcx3SIJrFK/qJzumkKdvu0dPrQkMjEtIhUv3OBMv5Horb4JfJZeDX3gJVN34m8EBGD
         b1XNke6O36NiZpOq2AgwGIX9u3/fKt/OzTD+uuL6XgwkwFjfGgVpmZdAVvOqZNd8uN
         Tn9A2X6WCVg4n2Wfid1giUg69N3xc1ggzwygloYsifUBdqDcD0TVL9vIvYQnnE/8ar
         zdvAaEh0D0mRA==
Message-ID: <faf88ba7-cb9c-f7ec-07f5-e3971bd35a4c@kernel.org>
Date:   Thu, 2 Dec 2021 17:11:02 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [RFC v2 PATCH 01/13] mm/shmem: Introduce F_SEAL_GUEST
Content-Language: en-US
To:     Chao Peng <chao.p.peng@linux.intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, qemu-devel@nongnu.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <seanjc@google.com>,
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
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        john.ji@intel.com, susie.li@intel.com, jun.nakajima@intel.com,
        dave.hansen@intel.com, ak@linux.intel.com, david@redhat.com
References: <20211119134739.20218-1-chao.p.peng@linux.intel.com>
 <20211119134739.20218-2-chao.p.peng@linux.intel.com>
From:   Andy Lutomirski <luto@kernel.org>
In-Reply-To: <20211119134739.20218-2-chao.p.peng@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/19/21 05:47, Chao Peng wrote:
> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> 
> The new seal type provides semantics required for KVM guest private
> memory support. A file descriptor with the seal set is going to be used
> as source of guest memory in confidential computing environments such as
> Intel TDX and AMD SEV.
> 
> F_SEAL_GUEST can only be set on empty memfd. After the seal is set
> userspace cannot read, write or mmap the memfd.

I don't have a strong objection here, but, given that you're only 
supporting it for memfd, would a memfd_create() flag be more 
straightforward?  If nothing else, it would avoid any possible locking 
issue.

I'm also very very slightly nervous about a situation in which one 
program sends a memfd to an untrusted other process and that process 
truncates the memfd and then F_SEAL_GUESTs it.  This could be mostly 
mitigated by also requiring that no other seals be set when F_SEAL_GUEST 
happens, but the alternative MFD_GUEST would eliminate this issue too.
