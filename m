Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D87001F0430
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Jun 2020 03:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728515AbgFFBpl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Jun 2020 21:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728426AbgFFBpl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Jun 2020 21:45:41 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A2F9C08C5C3
        for <linux-fsdevel@vger.kernel.org>; Fri,  5 Jun 2020 18:45:40 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id d66so5774246pfd.6
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Jun 2020 18:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EYATkoDd/DlTVvMSnKtKT7ZrCQbghipgNSfif3PPTdQ=;
        b=hZPAno3Zqe8dlYsL2LzWn8Cqbw5Cy5a1a5fGUH7kjV6Aa8+ckDOu3YxIijiEO9YlRg
         pTgQlBFXKXs/hWsbaLmVRsuzPAujEobi8t/Y9ydG3Jz0HbuKrJinEMzu4mf2CsSC2QY2
         8KgrfNit1c2PnHzP9N69IE2PvHFFPWPNxYRfA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EYATkoDd/DlTVvMSnKtKT7ZrCQbghipgNSfif3PPTdQ=;
        b=sRaStwMcgaUPueuKXDlktDhm77/wlEZooTwfOgL0t0Ks1cO1UHXBgxStJRcddMliuN
         DbpkBAjft0dj23y/YLI/CSRSZoYJZTOLaJbOlohqx2G1bkKMf5/0ZV6aI5dKMjj3aODH
         43MRoOeuU2LY3cfSiJ7C9ZzAdZ3535uwPGBglb/XEmV3ZxQhpNR5JnSFgf8M8cGGqVO+
         4upfh5JaL5p86htFIa0e75ZmJtdR7Mfci+a/p58ImGSa3dvTNhRUI160Yc/Q6dYuDtTP
         zB5b1hkvk2+t06Q8NZC/O6N8M+c/80gGhxuR1faaqq/FKYyqqPK1PlqPnaca+j+po0HA
         xuuA==
X-Gm-Message-State: AOAM5335UKfijT22EPErk2l6BOE49MflscjAx8N0eS8/mtZys0XnIUwA
        J0uK3u96YthTrSphZAUBjmUDrA==
X-Google-Smtp-Source: ABdhPJxjBK6bdJJIde1SuASUwSUrqHloLqXlowG4H6YmCkN1UfVnFk8Oo7dg72GZPLT/Vb2F4UEmuw==
X-Received: by 2002:a62:c185:: with SMTP id i127mr12889207pfg.132.1591407939582;
        Fri, 05 Jun 2020 18:45:39 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m4sm531153pgp.32.2020.06.05.18.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 18:45:38 -0700 (PDT)
Date:   Fri, 5 Jun 2020 18:45:37 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Biggers <ebiggers3@gmail.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Relocate execve() sanity checks
Message-ID: <202006051844.2EBA35A7@keescook>
References: <20200605160013.3954297-1-keescook@chromium.org>
 <20200605174053.eea9557878d81024d2519e47@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200605174053.eea9557878d81024d2519e47@linux-foundation.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 05, 2020 at 05:40:53PM -0700, Andrew Morton wrote:
> On Fri,  5 Jun 2020 09:00:10 -0700 Kees Cook <keescook@chromium.org> wrote:
> 
> > While looking at the code paths for the proposed O_MAYEXEC flag, I saw
> > some things that looked like they should be fixed up.
> > 
> >   exec: Change uselib(2) IS_SREG() failure to EACCES
> > 	This just regularizes the return code on uselib(2).
> > 
> >   exec: Move S_ISREG() check earlier
> > 	This moves the S_ISREG() check even earlier than it was already.
> > 
> >   exec: Move path_noexec() check earlier
> > 	This adds the path_noexec() check to the same place as the
> > 	S_ISREG() check.
> 
> Thanks.
> 
> These don't seem super-urgent and they aren't super-reviewed, so I
> suggest we hold them off until the next cycle?

Agreed; that's fine by me. It's mostly clean up and preparation for
performing future checking through the MAY_EXEC path.

And I'd love to get an Ack from Al or Aleksa, nudge nudge. :)

-- 
Kees Cook
