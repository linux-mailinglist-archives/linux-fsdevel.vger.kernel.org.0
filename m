Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 867F34B314A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Feb 2022 00:34:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354148AbiBKXdn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Feb 2022 18:33:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243430AbiBKXdm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Feb 2022 18:33:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8CC0C66;
        Fri, 11 Feb 2022 15:33:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 06EF061AB8;
        Fri, 11 Feb 2022 23:33:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6308C340E9;
        Fri, 11 Feb 2022 23:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644622418;
        bh=NcXN/ZExFBWEE/4j7wW8A6WXqsCsTCy55XEhj/QVImY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=MD/s1KgbDdFqUM3Vb1BzoByXZiIGv1RlMk7utUYwSOUf2JBAZFlRXxt4ECnUyYqy2
         W2P/xae6UgnONaMt/yfHTrkcp/Ewnkisg3q/XL2qGzszRkrYQfhNfDKBUVkaTyjKiI
         TMeacNN8OOe3NX8ZpbtDEriWYxrQhsGFC7y9uGqj0S7moAb1kWthU5wOueV/EfmDja
         96CZMpWUQRSafptUAWevRxcbiJHzmf1Bt5DG3KdDxxX9JAXkqI6HsnPE0GyAOsixEF
         V+mxb58acULwgB8+JZQHVywpmh7FewNQBkD25shtBrNaMabuc4v6KV0+VFfKIvJZXJ
         fcZZKVqrIZMqg==
Message-ID: <619547ad-de96-1be9-036b-a7b4e99b09a6@kernel.org>
Date:   Fri, 11 Feb 2022 15:33:35 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 01/12] mm/shmem: Introduce F_SEAL_INACCESSIBLE
Content-Language: en-US
To:     Chao Peng <chao.p.peng@linux.intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, qemu-devel@nongnu.org,
        Linux API <linux-api@vger.kernel.org>
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
        jun.nakajima@intel.com, dave.hansen@intel.com, ak@linux.intel.com,
        david@redhat.com
References: <20220118132121.31388-1-chao.p.peng@linux.intel.com>
 <20220118132121.31388-2-chao.p.peng@linux.intel.com>
From:   Andy Lutomirski <luto@kernel.org>
In-Reply-To: <20220118132121.31388-2-chao.p.peng@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/18/22 05:21, Chao Peng wrote:
> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> 
> Introduce a new seal F_SEAL_INACCESSIBLE indicating the content of
> the file is inaccessible from userspace through ordinary MMU access
> (e.g., read/write/mmap). However, the file content can be accessed
> via a different mechanism (e.g. KVM MMU) indirectly.
> 
> It provides semantics required for KVM guest private memory support
> that a file descriptor with this seal set is going to be used as the
> source of guest memory in confidential computing environments such
> as Intel TDX/AMD SEV but may not be accessible from host userspace.
> 
> At this time only shmem implements this seal.
> 

I don't dislike this *that* much, but I do dislike this. 
F_SEAL_INACCESSIBLE essentially transmutes a memfd into a different type 
of object.  While this can apparently be done successfully and without 
races (as in this code), it's at least awkward.  I think that either 
creating a special inaccessible memfd should be a single operation that 
create the correct type of object or there should be a clear 
justification for why it's a two-step process.

(Imagine if the way to create an eventfd would be to call 
timerfd_create() and then do a special fcntl to turn it into an eventfd 
but only if it's not currently armed.  This would be weird.)
