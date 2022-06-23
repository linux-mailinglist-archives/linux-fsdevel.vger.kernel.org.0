Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4050855779A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jun 2022 12:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbiFWKOM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Jun 2022 06:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbiFWKOL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Jun 2022 06:14:11 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A5E49F17;
        Thu, 23 Jun 2022 03:14:10 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 5898A21DCF;
        Thu, 23 Jun 2022 10:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655979249; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W5T2qmd5H7dxbiKDFmJzp0jMdrslZSbenmGTQN/sETw=;
        b=np4WzaTmnvcEUlROnXi1tfV0CpeG6ACx7cZWnUWiyjRMIjS8dN4nBDufnHFfPBpPOPeCjN
        HxFdbYrl1IvEgh8/AsojJWDI9EUXDNBhd8TIHmobFQxPNTmfSDSwNuxcP5OtzQCeUZEplJ
        pS99pvn2i7isIe2w+2NsPu73t4MVg+4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655979249;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W5T2qmd5H7dxbiKDFmJzp0jMdrslZSbenmGTQN/sETw=;
        b=n2yPE75NkcmvIcmj+/harY362JUkj0HP9CHcmfPJbpnedSPf7A7xWzciXALaK5ADVrOWA1
        CyHEemdmmK4smzAw==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 846862C142;
        Thu, 23 Jun 2022 10:14:03 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id E6AFCA062B; Thu, 23 Jun 2022 12:14:08 +0200 (CEST)
Date:   Thu, 23 Jun 2022 12:14:08 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Matthew Bobrowski <repnop@google.com>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH 2/2] fanotify: introduce FAN_MARK_IGNORE
Message-ID: <20220623101408.ejmqpp7xw6f67me7@quack3.lan>
References: <20220620134551.2066847-1-amir73il@gmail.com>
 <20220620134551.2066847-3-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220620134551.2066847-3-amir73il@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 20-06-22 16:45:51, Amir Goldstein wrote:
> This flag is a new way to configure ignore mask which allows adding and
> removing the event flags FAN_ONDIR and FAN_EVENT_ON_CHILD in ignore mask.
> 
> The legacy FAN_MARK_IGNORED_MASK flag would always ignore events on
> directories and would ignore events on children depending on whether
> the FAN_EVENT_ON_CHILD flag was set in the (non ignored) mask.
> 
> FAN_MARK_IGNORE can be used to ignore events on children without setting
> FAN_EVENT_ON_CHILD in the mark's mask and will not ignore events on
> directories unconditionally, only when FAN_ONDIR is set in ignore mask.
> 
> The new behavior is sticky.  After calling fanotify_mark() with
> FAN_MARK_IGNORE once, calling fanotify_mark() with FAN_MARK_IGNORED_MASK
> will update the ignore mask, but will not change the event flags in
> ignore mask nor how these flags are treated.

IMHO this stickyness is not very obvious. Wouldn't it be less error-prone
for users to say that once FAN_MARK_IGNORE is used for a mark, all
subsequent modifications of ignore mask have to use FAN_MARK_IGNORE? I mean
if some program bothers with FAN_MARK_IGNORE, I'd expect it to use it for
all its calls as otherwise the mixup is kind of difficult to reason
about...

Also it follows the behavior we have picked for FAN_MARK_EVICTABLE AFAIR
but that's not really important to me.

> @@ -1591,10 +1601,20 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
>  
>  	/*
>  	 * Event flags (FAN_ONDIR, FAN_EVENT_ON_CHILD) have no effect with
> -	 * FAN_MARK_IGNORED_MASK.
> +	 * FAN_MARK_IGNORED_MASK.  They can be updated in ignore mask with
> +	 * FAN_MARK_IGNORE and then they do take effect.
>  	 */
> -	if (ignore)
> +	switch (ignore) {
> +	case 0:
> +	case FAN_MARK_IGNORE:
> +		break;
> +	case FAN_MARK_IGNORED_MASK:
>  		mask &= ~FANOTIFY_EVENT_FLAGS;
> +		umask = FANOTIFY_EVENT_FLAGS;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}

I think this would be easier to follow as two ifs:

	/* We don't allow FAN_MARK_IGNORE & FAN_MARK_IGNORED_MASK together */
	if (ignore == FAN_MARK_IGNORE | FAN_MARK_IGNORED_MASK)
		return -EINVAL;
	/*
	 * Event flags (FAN_ONDIR, FAN_EVENT_ON_CHILD) have no effect with
	 * FAN_MARK_IGNORED_MASK.
	 */
	if (ignore == FAN_MARK_IGNORED_MASK) {
  		mask &= ~FANOTIFY_EVENT_FLAGS;
		umask = FANOTIFY_EVENT_FLAGS;
	}

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
