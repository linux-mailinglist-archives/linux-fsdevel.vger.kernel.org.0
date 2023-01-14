Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65B6466AD63
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Jan 2023 20:33:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbjANTdI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 14 Jan 2023 14:33:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjANTdH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 14 Jan 2023 14:33:07 -0500
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9034F93D6;
        Sat, 14 Jan 2023 11:33:04 -0800 (PST)
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id D47A510A2; Sat, 14 Jan 2023 13:33:02 -0600 (CST)
Date:   Sat, 14 Jan 2023 13:33:02 -0600
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     viro@zeniv.linux.org.uk, serge@hallyn.com,
        torvalds@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH 1/2] capability: add cap_isidentical
Message-ID: <20230114193302.GB23094@mail.hallyn.com>
References: <20230114180224.1777699-1-mjguzik@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230114180224.1777699-1-mjguzik@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jan 14, 2023 at 07:02:23PM +0100, Mateusz Guzik wrote:
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

Reviewed-by: Serge Hallyn <serge@hallyn.com>

> ---
>  include/linux/capability.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/include/linux/capability.h b/include/linux/capability.h
> index 65efb74c3585..736a973c677a 100644
> --- a/include/linux/capability.h
> +++ b/include/linux/capability.h
> @@ -156,6 +156,16 @@ static inline bool cap_isclear(const kernel_cap_t a)
>  	return true;
>  }
>  
> +static inline bool cap_isidentical(const kernel_cap_t a, const kernel_cap_t b)
> +{
> +	unsigned __capi;
> +	CAP_FOR_EACH_U32(__capi) {
> +		if (a.cap[__capi] != b.cap[__capi])
> +			return false;
> +	}
> +	return true;
> +}
> +
>  /*
>   * Check if "a" is a subset of "set".
>   * return true if ALL of the capabilities in "a" are also in "set"
> -- 
> 2.34.1
