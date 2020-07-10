Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F40921AE19
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jul 2020 06:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgGJEbk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Jul 2020 00:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbgGJEbk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Jul 2020 00:31:40 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56AEBC08C5CE
        for <linux-fsdevel@vger.kernel.org>; Thu,  9 Jul 2020 21:31:40 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id k5so2056808pjg.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Jul 2020 21:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NT4ks9hhnbWaFMSgDjtyc7VOZxcDYOUZO3SrDJL1oNA=;
        b=l2Gni8VkGX4ycXwuoNMtI8lJuVbDljbiMhzSv5/h7SZY0y4lolp3y9Ff4MS2p8D9zH
         SufvsUXukygmincyfyqGytqJ8byubGSu2ttU1UDOCLQ/gxHGSjVl4SuNXDinHaszIjDW
         9afeTbzQtHCoemu5kIqZ82N7Uh2gXe4KMrANo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NT4ks9hhnbWaFMSgDjtyc7VOZxcDYOUZO3SrDJL1oNA=;
        b=hGm8aFgADY1yhQ2PmS/zadJaUeiN/tpFXiY778k6Ha/2LkgGQb/fc+IZa3sc5Cn9Lq
         fmLktyRB7URJzHfDH0gVQd0aPH0j4rnAMw2LHh39vCMgBKxQE3mn7AxWqdeUFPApFGtT
         EnHJVdz17Hx1hQ3qW6D9VJ8kMHbB9dY+OtfOAfKG3W4GB+m8QVVJRZJcoeHHAD0Ox6Hb
         InLX8pIht1FBvVzm75z7Vkb51N2z0lldr1mMJbIxyrPJWQRC3Oxmqwq1WB8kOWTT45Gv
         dk9/iqZ+ksG6rFBWHRDrDDHmoNi2Rwf5P/HVMxPX9kKS6ZJWMford1Xo6ZoPG7Oziw6d
         L8IA==
X-Gm-Message-State: AOAM531bp1yXhfZjahuMgRFiz/vO+zeYocxzjOQvTpg0wl0QvxUMup9Y
        VUAkCOKBs1bQ8G2ZxhijzDXOlw==
X-Google-Smtp-Source: ABdhPJwIspzog1VUiBfY70nRImgloUCtHTT/BN1paaclHnpBfUxBpsJr4jZpnSNdlG+u2KnB5S4+Ug==
X-Received: by 2002:a17:902:aa0c:: with SMTP id be12mr58619318plb.45.1594355499772;
        Thu, 09 Jul 2020 21:31:39 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g30sm4540856pfq.189.2020.07.09.21.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 21:31:38 -0700 (PDT)
Date:   Thu, 9 Jul 2020 21:31:37 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Julius Hemanth Pitti <jpitti@cisco.com>, mingo@elte.hu,
        akpm@linux-foundation.org
Cc:     yzaikin@google.com, mcgrof@kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, xe-linux-external@cisco.com,
        jannh@google.com
Subject: Re: [PATCH] proc/sysctl: make protected_* world readable
Message-ID: <202007092122.782EE053@keescook>
References: <20200709235115.56954-1-jpitti@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200709235115.56954-1-jpitti@cisco.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 09, 2020 at 04:51:15PM -0700, Julius Hemanth Pitti wrote:
> protected_* files have 600 permissions which prevents
> non-superuser from reading them.
> 
> Container like "AWS greengrass" refuse to launch unless
> protected_hardlinks and protected_symlinks are set. When
> containers like these run with "userns-remap" or "--user"
> mapping container's root to non-superuser on host, they
> fail to run due to denied read access to these files.
> 
> As these protections are hardly a secret, and do not
> possess any security risk, making them world readable.
> 
> Though above greengrass usecase needs read access to
> only protected_hardlinks and protected_symlinks files,
> setting all other protected_* files to 644 to keep
> consistency.
> 
> Fixes: 800179c9b8a1 ("fs: add link restrictions")
> Signed-off-by: Julius Hemanth Pitti <jpitti@cisco.com>

Acked-by: Kees Cook <keescook@chromium.org>

I had originally proposed it as 0644, but Ingo asked that it have
a more conservative default value[1]. I figured that given the settings
can be discovered easily, it's not worth much. And if there are legit
cases where things are improved, I don't have a problem switching this
back.

Ingo, any thoughts on this now, 8 years later in the age of containers?
:)

(One devil's advocate question: as a workaround, you are able to just
change those files to 0644 after mounting /proc, yes? But regardless,
why get in people's way for no justifiable reason.)

-Kees

[1] https://lore.kernel.org/lkml/20120105091704.GB3249@elte.hu/

-- 
Kees Cook
