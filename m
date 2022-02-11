Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9214B3169
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Feb 2022 00:40:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354249AbiBKXkU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Feb 2022 18:40:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238960AbiBKXkQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Feb 2022 18:40:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA6ECF9;
        Fri, 11 Feb 2022 15:40:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 10433B82DD0;
        Fri, 11 Feb 2022 23:40:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6B73C340E9;
        Fri, 11 Feb 2022 23:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644622811;
        bh=qjDhoyLBnjObhE+qaWk23jxLof4n/h4IluDmsF4S+Zc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=HxHkOQCy8wBjoXjL70TshCgTZJSE9ew2DxDnJ18jj/4/DZV2JSnnbrH8FYWN5XOpz
         7Ti0r5fW2KunCYfy9nEiI8B7VECUh3JugBLGRtdOucxqELydi8URSwwK5ypcHOgllo
         JURaNYZHo4Vvle1HwR+VFcqPtgpSAnhTW53ToVTE6/tophEv+r9/HuKCXdTKs+SzCs
         XXl3/zxMMecQoDvxqQcHzdXmfIB4/8dL1CNJeB9yr2QyMFVgooY3uJs2SsYqA9Nr/i
         6cmkPGk37vDLzgx5UttouMfTOmgXCX6jZbciQMJBcUR5bRSeqHpTIXNgrJGAVebGls
         Ml6ubZ55tvGsw==
Message-ID: <314affa4-fbcb-2cb9-deb7-f61a2ac99260@kernel.org>
Date:   Fri, 11 Feb 2022 15:40:09 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 04/12] mm/shmem: Support memfile_notifier
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
        jun.nakajima@intel.com, dave.hansen@intel.com, ak@linux.intel.com,
        david@redhat.com
References: <20220118132121.31388-1-chao.p.peng@linux.intel.com>
 <20220118132121.31388-5-chao.p.peng@linux.intel.com>
From:   Andy Lutomirski <luto@kernel.org>
In-Reply-To: <20220118132121.31388-5-chao.p.peng@linux.intel.com>
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
> It maintains a memfile_notifier list in shmem_inode_info structure and
> implements memfile_pfn_ops callbacks defined by memfile_notifier. It
> then exposes them to memfile_notifier via
> shmem_get_memfile_notifier_info.
> 
> We use SGP_NOALLOC in shmem_get_lock_pfn since the pages should be
> allocated by userspace for private memory. If there is no pages
> allocated at the offset then error should be returned so KVM knows that
> the memory is not private memory.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>

>   static int memfile_get_notifier_info(struct inode *inode,
>   				     struct memfile_notifier_list **list,
>   				     struct memfile_pfn_ops **ops)
>   {
> -	return -EOPNOTSUPP;
> +	int ret = -EOPNOTSUPP;
> +#ifdef CONFIG_SHMEM
> +	ret = shmem_get_memfile_notifier_info(inode, list, ops);
> +#endif
> +	return ret;
>   }

> +int shmem_get_memfile_notifier_info(struct inode *inode,
> +				    struct memfile_notifier_list **list,
> +				    struct memfile_pfn_ops **ops)
> +{
> +	struct shmem_inode_info *info;
> +
> +	if (!shmem_mapping(inode->i_mapping))
> +		return -EINVAL;
> +
> +	info = SHMEM_I(inode);
> +	*list = &info->memfile_notifiers;
> +	if (ops)
> +		*ops = &shmem_pfn_ops;
> +
> +	return 0;

I can't wrap my head around exactly who is supposed to call these 
functions and when, but there appears to be a missing check that the 
inode is actually a shmem inode.

What is this code trying to do?  It's very abstract.
