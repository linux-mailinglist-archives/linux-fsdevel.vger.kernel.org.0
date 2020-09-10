Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE4F22655DE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Sep 2020 01:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725306AbgIJX6g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Sep 2020 19:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725275AbgIJX6c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Sep 2020 19:58:32 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D34DC061756
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Sep 2020 16:58:32 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id f2so3235857pgd.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Sep 2020 16:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TiD2LqrFMgU68bxi0s2xnUciJbQ2K0M9nK4+d+t39K8=;
        b=gfDQq0ZQqLUJ2DXD4GeetN5kOqP51hwBhKIkS41DxfjESdBN19BG5x+kfviKP/yh9X
         NBzaEVawSvptQ7Q4030RuEKgEvrEhYDi7bTC89bB7xG03X9rvK14W6PkRUtnT9UOr0Zn
         w2FsE0kcZLviYstxkTuTgVRezP064DYBbisLc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TiD2LqrFMgU68bxi0s2xnUciJbQ2K0M9nK4+d+t39K8=;
        b=DsesxbrvX+CFgA1hcQ4lL37ZJCYpRVgn2oJhp4TTkmaj1EiPXC9KfCwZRN5LKkQZKt
         9N7ki+ULkDhO5yPAlUM3i5dhDCg0dLL6NtvbWcsw//JL2Jyc9u/HzhJcr7BRTx3bLiCE
         p35eQ+DI3d/YHD7soOEp9u58CkdyaiFJRNdPlibbTD/+8T4D48auEg7hzJJ7c5ev7QEF
         w3Twe8OMFa8JUI9CTHeD01z66OtqcHUXf5NLwaXAfiZ3n4ajYWNFfbCaDrwT5xzyk6Iz
         T/TF4KN7VGEV/MssZJJrM9xzNj3euWsK2DiqkBB0n1Gf+Bm76KwSBU2Dtptk0pWkxFDA
         J4dA==
X-Gm-Message-State: AOAM5331+T/H9P/RvagystFT2ystvuSmS+fNQnsGyaRTgiQvv5crdUSP
        jSnPXTgPpTl6+2152eJGJC0s/g==
X-Google-Smtp-Source: ABdhPJx7/8vv2eB24dRiaLxWkU+dxFBXMvFoW+hNl5OQ5bHZLnmTBQqdIzH3CPNupiTU/enKTlQaQg==
X-Received: by 2002:a17:902:b216:: with SMTP id t22mr8241168plr.35.1599782311659;
        Thu, 10 Sep 2020 16:58:31 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v91sm159824pjv.12.2020.09.10.16.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 16:58:30 -0700 (PDT)
Date:   Thu, 10 Sep 2020 16:58:29 -0700
From:   Kees Cook <keescook@chromium.org>
To:     kernel-hardening@lists.openwall.com
Cc:     John Wood <john.wood@gmx.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [RESEND][RFC PATCH 0/6] Fork brute force attack mitigation
 (fbfam)
Message-ID: <202009101656.FB68C6A@keescook>
References: <20200910202107.3799376-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200910202107.3799376-1-keescook@chromium.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 10, 2020 at 01:21:01PM -0700, Kees Cook wrote:
> From: John Wood <john.wood@gmx.com>
> 
> The goal of this patch serie is to detect and mitigate a fork brute force
> attack.

Thanks for this RFC! I'm excited to get this problem finally handled in
the kernel. Hopefully the feedback is useful. :)

-- 
Kees Cook
