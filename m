Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8A650CE19
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Apr 2022 02:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235669AbiDWXwQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 23 Apr 2022 19:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiDWXwQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 23 Apr 2022 19:52:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F14E26113;
        Sat, 23 Apr 2022 16:49:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3B4C3B80CFD;
        Sat, 23 Apr 2022 23:49:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98098C385A0;
        Sat, 23 Apr 2022 23:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1650757755;
        bh=Ph02Z8NmFW9Xa0ZFqyBY0dnHe4IOaDafx/zUg80yRtQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TBBj3bG5S4VvgKxTlmXV4+9CZ/ALUdKJ2u2xj63Cg4+MxNFtYT+//RNFEyjpfXer5
         rUVntarp+N8WQB8Ou/BXv1jECuyiVry1h9+zA/i3gjYAiKdNq5S0v8xpWGy/+VYN7W
         gLflr7woNIoTmfGwtfzCowFogIhRN466ItRYoOkw=
Date:   Sat, 23 Apr 2022 16:49:13 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>, Will Deacon <will@kernel.org>,
        linux-fsdevel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] mm: Add fault_in_subpage_writeable() to probe at
 sub-page granularity
Message-Id: <20220423164913.3f0c92f7ad6ec718ea7c0360@linux-foundation.org>
In-Reply-To: <20220423100751.1870771-2-catalin.marinas@arm.com>
References: <20220423100751.1870771-1-catalin.marinas@arm.com>
        <20220423100751.1870771-2-catalin.marinas@arm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 23 Apr 2022 11:07:49 +0100 Catalin Marinas <catalin.marinas@arm.com> wrote:

> On hardware with features like arm64 MTE or SPARC ADI, an access fault
> can be triggered at sub-page granularity. Depending on how the
> fault_in_writeable() function is used, the caller can get into a
> live-lock by continuously retrying the fault-in on an address different
> from the one where the uaccess failed.
> 
> In the majority of cases progress is ensured by the following
> conditions:
> 
> 1. copy_to_user_nofault() guarantees at least one byte access if the
>    user address is not faulting.
> 
> 2. The fault_in_writeable() loop is resumed from the first address that
>    could not be accessed by copy_to_user_nofault().
> 
> If the loop iteration is restarted from an earlier (initial) point, the
> loop is repeated with the same conditions and it would live-lock.
> 
> Introduce an arch-specific probe_subpage_writeable() and call it from
> the newly added fault_in_subpage_writeable() function. The arch code
> with sub-page faults will have to implement the specific probing
> functionality.
> 
> Note that no other fault_in_subpage_*() functions are added since they
> have no callers currently susceptible to a live-lock.
> 
> ...
>
> --- a/include/linux/uaccess.h
> +++ b/include/linux/uaccess.h
> @@ -231,6 +231,28 @@ static inline bool pagefault_disabled(void)
>   */
>  #define faulthandler_disabled() (pagefault_disabled() || in_atomic())
>  
> +#ifndef CONFIG_ARCH_HAS_SUBPAGE_FAULTS
> +
> +/**
> + * probe_subpage_writeable: probe the user range for write faults at sub-page
> + *			    granularity (e.g. arm64 MTE)
> + * @uaddr: start of address range
> + * @size: size of address range
> + *
> + * Returns 0 on success, the number of bytes not probed on fault.
> + *
> + * It is expected that the caller checked for the write permission of each
> + * page in the range either by put_user() or GUP. The architecture port can
> + * implement a more efficient get_user() probing if the same sub-page faults
> + * are triggered by either a read or a write.
> + */
> +static inline size_t probe_subpage_writeable(void __user *uaddr, size_t size)

It's `char __user *' at the other definition.

> +{
> +	return 0;
> +}
> +
> +#endif /* CONFIG_ARCH_HAS_SUBPAGE_FAULTS */
> +
>  #ifndef ARCH_HAS_NOCACHE_UACCESS
>  
> ...
>
