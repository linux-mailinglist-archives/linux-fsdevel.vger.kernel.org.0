Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 477735BA255
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Sep 2022 23:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbiIOVdo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Sep 2022 17:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiIOVdn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Sep 2022 17:33:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB0BF753A4;
        Thu, 15 Sep 2022 14:33:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 690F1626AA;
        Thu, 15 Sep 2022 21:33:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FEEDC433B5;
        Thu, 15 Sep 2022 21:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1663277621;
        bh=s40+g/crwq1I2vJ8w7LiVAh9DCAgzPt0b4Ee7q8s0r8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rRxulAlbxdOqg4gW7VA89ev50Pa7VTg3cXQVIvArvDCL9yEFO+TdDE4lzmqkIzPu/
         wRPVvo81ns86PPXZkjuiuN0tds9qcQpypkrjP5yCpDxDVoDfDrnZDltOlC9fnDnvU5
         w5GLqbBSKBwYJjGymIrpQmQGoztjwvi4XeNkoH0g=
Date:   Thu, 15 Sep 2022 14:33:40 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Eliav Farber <farbere@amazon.com>
Cc:     <viro@zeniv.linux.org.uk>, <yangyicong@hisilicon.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <andriy.shevchenko@intel.com>, <hhhawa@amazon.com>,
        <jonnyc@amazon.com>
Subject: Re: [PATCH] libfs: fix error format in simple_attr_write()
Message-Id: <20220915143340.eeb3a8ca0bf50df1cd6359f9@linux-foundation.org>
In-Reply-To: <20220915091544.42767-1-farbere@amazon.com>
References: <20220915091544.42767-1-farbere@amazon.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 15 Sep 2022 09:15:44 +0000 Eliav Farber <farbere@amazon.com> wrote:

> In commit 488dac0c9237 ("libfs: fix error cast of negative value in
> simple_attr_write()"), simple_attr_write() was changed to use kstrtoull()
> instead of simple_strtoll() to convert a string got from a user.
> A user trying to set a negative value will get an error.
> 
> This is wrong since it breaks all the places that use
> DEFINE_DEBUGFS_ATTRIBUTE() with format of a signed integer.
> 
> For the record there are 43 current users of signed integer which are
> likely to be effected by this:
> 
> $ git grep -n -A1 -w DEFINE_DEBUGFS_ATTRIBUTE | grep ');' |
> sed 's,.*\(".*%.*"\).*,\1,' | sort | uniq -c
>   1 "%08llx\n"
>   5 "0x%016llx\n"
>   5 "0x%02llx\n"
>   5 "0x%04llx\n"
>  13 "0x%08llx\n"
>   1 "0x%4.4llx\n"
>   3 "0x%.4llx\n"
>   4 "0x%llx\n"
>   1 "%1lld\n"
>  40 "%lld\n"
>   2 "%lli\n"
> 129 "%llu\n"
>   1 "%#llx\n"
>   2 "%llx\n"
> 
> u64 is not an issue for negative numbers.
> The %lld and %llu in any case are for 64-bit value, representing it as
> unsigned simplifies the generic code, but it doesn't mean we can't keep
> their signed value if we know that.
> 
> This change uses sscanf() to fix the problem since it does the conversion
> based on the supplied format string.
> 
> Fixes: 488dac0c9237 ("libfs: fix error cast of negative value in simple_attr_write()")

488dac0c9237 was two years ago, so I'm assuming that this error isn't
causing a lot of trouble out there.

In which I may be totally wrong.  Do you see a reason for backporting
this fix into earlier kernels?  If so, what is it?

Thanks.


