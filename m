Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 276DD6BC670
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Mar 2023 08:02:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbjCPHCe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Mar 2023 03:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjCPHCd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Mar 2023 03:02:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB5B30293;
        Thu, 16 Mar 2023 00:02:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE00D61F2F;
        Thu, 16 Mar 2023 07:02:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B9C8C433D2;
        Thu, 16 Mar 2023 07:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678950151;
        bh=oyu2Kf+xnN2T5vtUW9pLhUslgU39oPBN51+0UsfURbU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TNPhUyiQBTLe3keDiMxW0p2heZwA4vnfSWQXtHqxNbeyoRSzAFnJzhOYHUNbm1Evw
         7VdQxZlbitsH9VSYqA+ANSm4J4B6VAUQphiQdFheBNAufgnq5golNODuG4Gw37Ca5+
         kxGnpfvElDO3y/WwxvrIKmimKAFpqvzzuYkqaWLWBLewa/GeNP2ld9UbjFRXbQz2uv
         qI7t0D6iuIs2k3TJdXDF9/wAS7a6khdqb/6z+l1NIj80z2Hdjh9QCxZI9oEiMeTFwO
         Nt/jaVWtBwdkoX8zOUG+d8YsyEsOy81/D1OYEoBiZ7jAdHj3DyRLZDna4H3LFXBXmH
         svsGf3H6sTuEQ==
Date:   Thu, 16 Mar 2023 09:02:11 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <emmir@google.com>,
        Andrei Vagin <avagin@gmail.com>,
        Danylo Mocherniuk <mdanylo@google.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Nadav Amit <namit@vmware.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Yun Zhou <yun.zhou@windriver.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Matthew Wilcox <willy@infradead.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>, kernel@collabora.com
Subject: Re: [PATCH v11 2/7] userfaultfd: Define dummy uffd_wp_range()
Message-ID: <ZBK+86eMMazwfhdx@kernel.org>
References: <20230309135718.1490461-1-usama.anjum@collabora.com>
 <20230309135718.1490461-3-usama.anjum@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230309135718.1490461-3-usama.anjum@collabora.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On Thu, Mar 09, 2023 at 06:57:13PM +0500, Muhammad Usama Anjum wrote:
> Define uffd_wp_range() for the cases when CONFIG_USERFAULTFD isn't set.
> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
>  include/linux/userfaultfd_k.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
> index b680c0ec8b85..fd1a1ecdb5f6 100644
> --- a/include/linux/userfaultfd_k.h
> +++ b/include/linux/userfaultfd_k.h
> @@ -182,6 +182,14 @@ extern int userfaultfd_wp_async(struct vm_area_struct *vma);
>  
>  #else /* CONFIG_USERFAULTFD */
>  
> +extern inline long uffd_wp_range(struct mm_struct *dst_mm,

static inline

> +				 struct vm_area_struct *vma,
> +				 unsigned long start, unsigned long len,
> +				 bool enable_wp)
> +{
> +	return 0;
> +}
> +

I didn't see uffd_wp_range() defined in the previous patch.
Could be a rebase issue?

In any case, the stub should be defined in the same patch as the actual
function in order not to break bisectability.

>  /* mm helpers */
>  static inline vm_fault_t handle_userfault(struct vm_fault *vmf,
>  				unsigned long reason)
> -- 
> 2.39.2
> 

-- 
Sincerely yours,
Mike.
