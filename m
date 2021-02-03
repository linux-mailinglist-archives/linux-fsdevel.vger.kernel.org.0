Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F32B30E5F6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Feb 2021 23:20:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232184AbhBCWSL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Feb 2021 17:18:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbhBCWSK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Feb 2021 17:18:10 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09C5AC061573;
        Wed,  3 Feb 2021 14:17:30 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id m22so961945ljj.4;
        Wed, 03 Feb 2021 14:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fwKwcjkOakabuMC8IDDuvslB5j91FzNr2ME4Ak/U/ps=;
        b=V5L8auhbCPrs/G84QeTojaX6uGf030RjbQ/EHQpDA9BBU7ay28h+u1Yt0AjcJEsPJd
         /YO0xAMPgKvxqnqYh67F5qEX9gwUrYgsEDvxg2AkPheyc/em2Gz+bKtJem0VcUAhFO8x
         Rr5jnVRW7+e4QfMjp4dGYgCedjvP2MFLa9UDcRcNblPfW0wtYT6aEE5bajWeIbWMIyRu
         qr+vBSAR21aCXAti7QHDpnoa3Q0en3k3ictIAF/sk/T4dtxtshxdx4zIys9zxuIoR3oM
         dC6VJfjJoRDI+mNzvnfuW0BWHER+9vA5yb9UhLygriS3GScTyjm4WZixMKJ9IFJAIW95
         FLcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fwKwcjkOakabuMC8IDDuvslB5j91FzNr2ME4Ak/U/ps=;
        b=EOumvuG/iEzmihnI+kUPfEqIepqWNkBPFUSQ1yeJO/cHuaVL2x+oFHP2RvCZdRurDQ
         LvkQ9iQ5Dp+SD7zsB5lRomN6jCnAVGRJCmakKdrlw67QEjQoPAd1etaGQNPlgEOf0KO/
         tppAqek8+UfVj6omHZi+Ne+e30i/fL/X6tO3KTLyyj7ImIYxr5G/7VPmU5jKCBOfAVY7
         ogPKPGVo1v6pqeAgbf/2Px6Z2cpmrkkh1HtNNREHNqKY9+CzLn2fIfue8NlB7spea2Tz
         cx4t+JaOf5WnCt2YM2IcnpAtyQ88vhBCrqoA5+fLLS+MMjMBareHy1VwdVu2WFcR08nA
         nNmQ==
X-Gm-Message-State: AOAM533VVKEsgspawJkCd1DAuzAZUiEmBEUEDKM9NXkE8xQsg6NZiQao
        kEdH+OlC5mbMh5dABmMHKHE=
X-Google-Smtp-Source: ABdhPJyr7sA80ksw4CHNkRXkXYkTRduS44pOEpiEJNOCT54lrNGXz9TRkEjoSHNY6oPMDSOnvq4NHQ==
X-Received: by 2002:a2e:b543:: with SMTP id a3mr2968626ljn.336.1612390648430;
        Wed, 03 Feb 2021 14:17:28 -0800 (PST)
Received: from grain.localdomain ([5.18.103.226])
        by smtp.gmail.com with ESMTPSA id g27sm362995lfh.291.2021.02.03.14.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 14:17:27 -0800 (PST)
Received: by grain.localdomain (Postfix, from userid 1000)
        id 64ABA560097; Thu,  4 Feb 2021 01:17:26 +0300 (MSK)
Date:   Thu, 4 Feb 2021 01:17:26 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Cc:     Jeff Layton <jlayton@poochiereds.net>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrei Vagin <avagin@gmail.com>
Subject: Re: [PATCH] fcntl: make F_GETOWN(EX) return 0 on dead owner task
Message-ID: <20210203221726.GF2172@grain>
References: <20210203124156.425775-1-ptikhomirov@virtuozzo.com>
 <20210203193201.GD2172@grain>
 <88739f26-63b0-be1d-4e6d-def01633323e@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88739f26-63b0-be1d-4e6d-def01633323e@virtuozzo.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 04, 2021 at 12:35:42AM +0300, Pavel Tikhomirov wrote:
> 
> AFAICS if pid is held only by 1) fowner refcount and by 2) single process
> (without threads, group and session for simplicity), on process exit we go
> through:
> 
> do_exit
>   exit_notify
>     release_task
>       __exit_signal
>         __unhash_process
>           detach_pid
>             __change_pid
>               free_pid
>                 idr_remove
> 
> So pid is removed from idr, and after that alloc_pid can reuse pid numbers
> even if old pid structure is still alive and is still held by fowner.
...
> Hope this answers your question, Thanks!

Yeah, indeed, thanks! So the change is sane still I'm
a bit worried about backward compatibility, gimme some
time I'll try to refresh my memory first, in a couple
of days or weekend (though here are a number of experienced
developers CC'ed maybe they reply even faster).
