Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5244077BD4D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Aug 2023 17:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232596AbjHNPku (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Aug 2023 11:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232710AbjHNPkg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Aug 2023 11:40:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F4010CE;
        Mon, 14 Aug 2023 08:40:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA069632AB;
        Mon, 14 Aug 2023 15:40:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58968C433C7;
        Mon, 14 Aug 2023 15:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692027635;
        bh=WgPLziGT93g69DcX3Nr2VzINzq9kF/xajqL2y7Km8QU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JEJUkV5Qh72uzzWukxjdX7X+2afsyiGqIb3+/ZEmMkQY+Cl/DZvPDRK0nUoUn9y9Q
         YbADTmxb1egPpIcwuP4RDavf8wBgTK/gyky+YwtZWw3+gGOqOGNVMGwQ1KPT5TEkV5
         EBepxDzN5zg+yBsZYCiuSEwXNNGCaQuqcs7SlwZ/7S12fOFZhMs9HSFbglUTj1R4V5
         jkz42Uc/nfgeXun4qtg35G67xZxzwFP00/N1BCFnDewRxQMpQk+p7QtVVO/wR9TDxG
         VVxTCBgC4Qq8pgzAK8mOfAZ76fNFTqvsgUOiowHLPdMQpJymcqVuKgNEfBkJydGxjh
         wPyk0D4qEWZJw==
Date:   Mon, 14 Aug 2023 17:40:30 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Loic Poulain <loic.poulain@linaro.org>
Cc:     viro@zeniv.linux.org.uk, corbet@lwn.net,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, hch@infradead.org,
        rdunlap@infradead.org
Subject: Re: [PATCH v4] init: Add support for rootwait timeout parameter
Message-ID: <20230814-flaute-achsen-05169559ea75@brauner>
References: <20230813082349.513386-1-loic.poulain@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230813082349.513386-1-loic.poulain@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Aug 13, 2023 at 10:23:49AM +0200, Loic Poulain wrote:
> Add an optional timeout arg to 'rootwait' as the maximum time in
> seconds to wait for the root device to show up before attempting
> forced mount of the root filesystem.
> 
> Use case:
> In case of device mapper usage for the rootfs (e.g. root=/dev/dm-0),
> if the mapper is not able to create the virtual block for any reason
> (wrong arguments, bad dm-verity signature, etc), the `rootwait` param
> causes the kernel to wait forever. It may however be desirable to only
> wait for a given time and then panic (force mount) to cause device reset.
> This gives the bootloader a chance to detect the problem and to take some
> measures, such as marking the booted partition as bad (for A/B case) or
> entering a recovery mode.
> 
> In success case, mounting happens as soon as the root device is ready,
> unlike the existing 'rootdelay' parameter which performs an unconditional
> pause.
> 
> Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
> ---

Looks mostly fine to me now but that's v6.7 fodder as it's rather late
in the cycle. I'll earmark this but feel free to resend post merge
window closure.
