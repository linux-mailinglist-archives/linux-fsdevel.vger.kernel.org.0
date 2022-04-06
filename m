Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 794824F6CBE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Apr 2022 23:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233994AbiDFVcy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Apr 2022 17:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236247AbiDFVcg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Apr 2022 17:32:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 601A0347993;
        Wed,  6 Apr 2022 13:40:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 041F76123F;
        Wed,  6 Apr 2022 20:40:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2959AC385A1;
        Wed,  6 Apr 2022 20:40:27 +0000 (UTC)
Date:   Wed, 6 Apr 2022 21:40:23 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        Will Deacon <will@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] btrfs: Avoid live-lock in search_ioctl() on
 hardware with sub-page faults
Message-ID: <Yk36tyvswgl3VcM0@arm.com>
References: <20220406180922.1522433-1-catalin.marinas@arm.com>
 <20220406180922.1522433-4-catalin.marinas@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220406180922.1522433-4-catalin.marinas@arm.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 06, 2022 at 07:09:22PM +0100, Catalin Marinas wrote:
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 238cee5b5254..d49e8254f823 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -2556,8 +2556,13 @@ static noinline int search_ioctl(struct inode *inode,
>  	key.offset = sk->min_offset;
>  
>  	while (1) {
> +		size_t len = *buf_size - sk_offset;
>  		ret = -EFAULT;
> -		if (fault_in_writeable(ubuf + sk_offset, *buf_size - sk_offset))
> +		/*
> +		 * Ensure that the whole user buffer is faulted in at sub-page
> +		 * granularity, otherwise the loop may live-lock.
> +		 */
> +		if (fault_in_subpage_writeable(ubuf + sk_offset, len))
>  			break;

This doesn't need a new 'len' variable. It's a left-over from the v2
where fault_in_writeable() took the size and a min_size argument, both
being 'len'.

-- 
Catalin
