Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 775FC6029A1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Oct 2022 12:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbiJRKsN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Oct 2022 06:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbiJRKsM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Oct 2022 06:48:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDE76B5166;
        Tue, 18 Oct 2022 03:48:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 83D06614DE;
        Tue, 18 Oct 2022 10:48:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69882C433C1;
        Tue, 18 Oct 2022 10:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666090088;
        bh=TmSjMdn9KzKg0YBMH9ER0S5KZL106NcpkRk9mATClwg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y5ppxsgfo0DsaUPvj2xBQWV3sHMEmurar+lIlLLPJ9kLUcUjFw2IOLyhfGej2FYo8
         gE9GidnUZdAJIcbE7aJK117/zL7QKqyC9lrxIyNs+yCswWQzcPoDWBdIuRFrkVtBdr
         DMBvwQm7joy4cw3FOiiJ0REt4gCVWb0npNAORY00=
Date:   Tue, 18 Oct 2022 12:48:04 +0200
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
Message-ID: <Y06EZNAkLtigZi25@kroah.com>
References: <Y0T2l3HaH2MU8M9m@gmail.com>
 <20221014134802.1361436-1-mdanylo@google.com>
 <474513c0-4ff9-7978-9d77-839fe775d04c@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <474513c0-4ff9-7978-9d77-839fe775d04c@collabora.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 18, 2022 at 03:36:24PM +0500, Muhammad Usama Anjum wrote:
> /**
>  * struct pagemap_sd_args - Soft-dirty IOCTL argument
>  * @start:		Starting address
>  * @len:		Length of the region
>  * @vec:		Output page_region struct array
>  * @vec_len:		Length of the page_region struct array
>  * @max_out_page:	Optional max output pages (It must be less than vec_len if
> specified)
>  * @flags:		Special flags for the IOCTL
>  * @rmask:		Special flags for the IOCTL
>  * @amask:		Special flags for the IOCTL
>  * @emask:		Special flags for the IOCTL

What do you mean exactly by "special flags"?

>  * @__reserved:		Reserved member to preserve data alignment. Must be 0.
>  */
> struct pagemap_sd_args {
> 	__u64 __user start;
> 	__u64 len;
> 	__u64 __user vec; // page_region

__user is a marking for a pointer, not a u64, right?  Now the fact that
you treat it like a pointer later in the kernel is different, but that
shouldn't be on the uapi header file.  You can put it in the kerneldoc,
which you did not do.

thanks,

greg k-h
