Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEDE14EB254
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Mar 2022 18:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239969AbiC2Q5a (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Mar 2022 12:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbiC2Q52 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Mar 2022 12:57:28 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA656CA67;
        Tue, 29 Mar 2022 09:55:45 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 1A2411FBB5;
        Tue, 29 Mar 2022 16:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1648572944;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vGp9jGwdHCBsNKzn3RMLekDPtLMAAOka0qtIic71SAE=;
        b=ggiJymO1CY5s++AmMmwGPJnw4UdEG2FEjEWzVHtt8rcdIib+Un2/xxXo2m24p8XUF3Wr1Q
        uCBww4Hgu5uLiM4G68q/TFAkhIOE+daaCjizzaYKhONVEmG2U43HTTdzZbKxs+fmp0dBv0
        preMHNRDbeR/kuN1+l5c/h71N+nrdaY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1648572944;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vGp9jGwdHCBsNKzn3RMLekDPtLMAAOka0qtIic71SAE=;
        b=kVCOgDMg2T+BYorkUFqDGI6jho5rldCiJTpvQSOTIVIYX0hEFpufc3ADFGKUtja90+r9rW
        euIhI+9rN+UK6bAw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 0F2D6A3B83;
        Tue, 29 Mar 2022 16:55:44 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 51348DA7F3; Tue, 29 Mar 2022 18:51:46 +0200 (CEST)
Date:   Tue, 29 Mar 2022 18:51:46 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     David Sterba <dsterba@suse.com>, linux-fsdevel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/affs: remove redundant assignment to ch
Message-ID: <20220329165145.GZ2237@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Colin Ian King <colin.i.king@gmail.com>,
        David Sterba <dsterba@suse.com>, linux-fsdevel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220307150742.137873-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220307150742.137873-1-colin.i.king@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 07, 2022 at 03:07:42PM +0000, Colin Ian King wrote:
> The assignment of ch after subtracting ('a' - 'A') is redundant and
> can be removed. Fix this by replacing the -= operator with just -
> to remove the assignment.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  fs/affs/namei.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/affs/namei.c b/fs/affs/namei.c
> index bcab18956b4f..a1270deba908 100644
> --- a/fs/affs/namei.c
> +++ b/fs/affs/namei.c
> @@ -19,7 +19,7 @@ typedef int (*toupper_t)(int);
>  static int
>  affs_toupper(int ch)
>  {
> -	return ch >= 'a' && ch <= 'z' ? ch -= ('a' - 'A') : ch;
> +	return ch >= 'a' && ch <= 'z' ? ch - ('a' - 'A') : ch;

AFFS is in fixes-only mode, I wonder how much this change is affecting
anybody, from the user perspective. I'd say not at all, W=1 build is
clean and that's something I'd be fine to fix, W=2 and W=3 warnings are
from other code.
