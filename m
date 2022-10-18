Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ADAB603237
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Oct 2022 20:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbiJRSUX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Oct 2022 14:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbiJRSUV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Oct 2022 14:20:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B1A7606A3;
        Tue, 18 Oct 2022 11:20:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D5FB1616CF;
        Tue, 18 Oct 2022 18:20:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD346C433C1;
        Tue, 18 Oct 2022 18:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666117219;
        bh=NvhhyK9lab3DToVl45Rqdbu70WmZzVvJ21km5nzXMZw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zn4qrdE4oBzwg5ma3af26uEAN+5xgiYPZCOFWL+CV/oXCGFImJR5SjyTVV6kRtIqg
         1OPuz2U+K5jzo8t4StmTHi56GJpuQCTR6zVioRoy/DG73cANUhHc5uwM7QPL1MFiyI
         ML34MLKBRKV4B3npJnC+HWKIowpYzAWIaU82bgv4=
Date:   Tue, 18 Oct 2022 20:20:16 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     Danylo Mocherniuk <mdanylo@google.com>, avagin@gmail.com,
        linux-mm@kvack.org, akpm@linux-foundation.org, corbet@lwn.net,
        david@redhat.com, kernel@collabora.com, krisman@collabora.com,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        peter.enderborg@sony.com, shuah@kernel.org,
        viro@zeniv.linux.org.uk, willy@infradead.org, emmir@google.com,
        figiel@google.com, kyurtsever@google.com,
        Paul Gofman <pgofman@codeweavers.com>, surenb@google.com
Subject: Re: [PATCH v3 0/4] Implement IOCTL to get and clear soft dirty PTE
Message-ID: <Y07uYHLW8iShPw1S@kroah.com>
References: <Y0T2l3HaH2MU8M9m@gmail.com>
 <20221014134802.1361436-1-mdanylo@google.com>
 <474513c0-4ff9-7978-9d77-839fe775d04c@collabora.com>
 <8e6ae988-ae89-9e94-ca05-38a4c2548356@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e6ae988-ae89-9e94-ca05-38a4c2548356@collabora.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 18, 2022 at 06:32:46PM +0500, Muhammad Usama Anjum wrote:
> On 10/18/22 3:36 PM, Muhammad Usama Anjum wrote:
> > > > > > > > I mean we should be able to specify for what
> > > > > > > > pages we need to get info
> > > > > > > > for. An ioctl argument can have these four fields:
> > > > > > > > * required bits (rmask & mask == mask) - all
> > > > > > > > bits from this mask have to be set.
> > > > > > > > * any of these bits (amask & mask != 0) - any of these bits is set.
> > > > > > > > * exclude masks (emask & mask == 0) = none of these bits are set.
> > > > > > > > * return mask - bits that have to be reported to user.
> > > > > The required mask (rmask) makes sense to me. At the moment, I only know
> > > > > about the practical use case for the required mask. Can you share how
> > > > > can any and exclude masks help for the CRIU?
> > > > > 
> > > > 
> > > > I looked at should_dump_page in the CRIU code:
> > > > https://github.com/checkpoint-restore/criu/blob/45641ab26d7bb78706a6215fdef8f9133abf8d10/criu/mem.c#L102
> > > > 
> > > > When CRIU dumps file private mappings, it needs to get pages that have
> > > > PME_PRESENT or PME_SWAP but don't have PME_FILE.
> > > 
> > > I would really like to see the mask discussed will be adopted. With
> > > it CRIU will
> > > be able to migrate huge sparse VMAs assuming that a single hole is
> > > processed in
> > > O(1) time.
> > > 
> > > Use cases for migrating sparse VMAs are binaries sanitized with
> > > ASAN, MSAN or
> > > TSAN [1]. All of these sanitizers produce sparse mappings of shadow
> > > memory [2].
> > > Being able to migrate such binaries allows to highly reduce the
> > > amount of work
> > > needed to identify and fix post-migration crashes, which happen
> > > constantly.
> > > 
> > 
> > Hello all,
> > 
> > I've included the masks which the CRIU developers have specified.
> > max_out_page is another new optional variable which is needed to
> > terminate the operation without visiting all the pages after finding the
> > max_out_page number of desired pages. There is no way to terminate the
> > operation without this variable.
> > 
> > How does the interface looks now? Please comment.
> > 
> Updated interface with only one IOCTL. If vec is defined, get operation will
> be performed. If PAGEMAP_SD_CLEAR flag is specified, soft dirty bit will be
> cleared as well. CLEAR flag can only be specified for clearing soft dirty
> bit.
> 
> /* PAGEMAP IOCTL */
> #define PAGEMAP_SCAN	_IOWR('f', 16, struct pagemap_sd_args)
> 
> /* Bits are set in the bitmap of the page_region and masks in
> pagemap_sd_args */
> #define PAGE_IS_SD	1 << 0
> #define PAGE_IS_FILE	1 << 1
> #define PAGE_IS_PRESENT	1 << 2
> #define PAGE_IS_SWAPED	1 << 3
> 
> /**
>  * struct page_region - Page region with bitmap flags
>  * @start:	Start of the region
>  * @len:	Length of the region
>  * bitmap:	Bits sets for the region
>  */
> struct page_region {
> 	__u64 start;
> 	__u64 len;
> 	__u64 bitmap;
> };
> 
> /**
>  * struct pagemap_sd_args - Soft-dirty IOCTL argument
>  * @start:		Starting address of the page
>  * @len:		Length of the region (All the pages in this length are included)
>  * @vec:		Output page_region struct array
>  * @vec_len:		Length of the page_region struct array
>  * @max_out_page:	Optional max output pages (It must be less than vec_len if
> specified)
>  * @flags:		Special flags for the IOCTL
>  * @rmask:		Required mask - All of these bits have to be set

Why have it at all if it always has to be all 1s?

>  * @amask:		Any mask - Any of these bits are set

which ones?

>  * @emask:		Exclude mask - None of these bits are set

Why have it, if none are ever set?

>  * @rmask:		Bits that have to be reported to the user in page_region

I feel like I have no idea what these bits are...

Anyway, please send a real patch, with real code, so we have a better
idea of what is happening.  AFTER you have tested and made it all work
properly.

thanks,

greg k-h
