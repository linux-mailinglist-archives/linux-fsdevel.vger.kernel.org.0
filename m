Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E93484A7980
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Feb 2022 21:33:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232023AbiBBUbu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Feb 2022 15:31:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbiBBUbt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Feb 2022 15:31:49 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD822C061714
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Feb 2022 12:31:49 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id o64so415811pjo.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Feb 2022 12:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2yFJj6ZVefTE/vWISdKzupJXVjEcJPH4z8zqtZHrZMU=;
        b=g9ENtVpiaPQ7gXq2RjybtD1vNjZ+vkdx4HgR7sglG5kF08w7f3otDMOAwt6gfBvpXj
         v1OSktJ1XnffVQpqdExOi/gP/MBtuZNQYSffEN+6/VYDauLT9fU7bFs68ehxwVTFV26g
         +ZpnzNGfnrAAIkDbtsRXJF7wLsYtouY9HtgEM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2yFJj6ZVefTE/vWISdKzupJXVjEcJPH4z8zqtZHrZMU=;
        b=s/Iyl2uU14wF7RKYiMFjsvbKbRQsJK2zNtpIHQy+oPRCHaUUlcqduV2DDybmf9fxop
         sZg1QHCjwoQhtQdW2pNy185527Yss+mFzLIdWcIKn+x+Ttm0wlxcyQ5Lmn1RL9jvZYOW
         iXHIPxPHmcTBDdoIRUYdOV82oOOQ5c0KbicmKAT06jR24pUI8SWWh1y8u90AAOz7fR6y
         SPcu0MyVsl0Tb/PL/beHdMZXqxxsRFyWKNVbsPu4cHjXTdPYRPYecMIoWOVta+hsbN08
         xC64tloxuHiuYSFbSl/FwYuJBPX/KKoalFMQwfPJWTSWY1gBvWOGX7vrPk1Pt1IZdm/B
         d6YQ==
X-Gm-Message-State: AOAM532utLOABz8t1gQ00m6oWXZH9HqgeR9cIq+OYg8mtyNXfpVs/hVq
        lEICLD0qnC6+ZdCxCds0sM2MZg==
X-Google-Smtp-Source: ABdhPJwmTwJ5ie1k8bwwQQWok+d1e3DNDo3GqAuF1F32vPbnmIN2LP3OmiFsSSsjNlqbjhUKCc7mLw==
X-Received: by 2002:a17:903:249:: with SMTP id j9mr31864782plh.81.1643833909142;
        Wed, 02 Feb 2022 12:31:49 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id ca12sm7166526pjb.11.2022.02.02.12.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 12:31:48 -0800 (PST)
Date:   Wed, 2 Feb 2022 12:31:48 -0800
From:   Kees Cook <keescook@chromium.org>
To:     David Laight <David.Laight@aculab.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Ariadne Conill <ariadne@dereferenced.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <brauner@kernel.org>,
        Rich Felker <dalias@libc.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH] exec: Force single empty string when argv is empty
Message-ID: <202202021229.9681AD39B0@keescook>
References: <20220201000947.2453721-1-keescook@chromium.org>
 <78959c88715049a4be00fc75bb333d3a@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78959c88715049a4be00fc75bb333d3a@AcuMS.aculab.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 01, 2022 at 09:17:47AM +0000, David Laight wrote:
> From: Kees Cook
> > Sent: 01 February 2022 00:10
> ...
> > While the initial code searches[6][7] turned up what appeared to be
> > mostly corner case tests, trying to that just reject argv == NULL
> > (or an immediately terminated pointer list) quickly started tripping[8]
> > existing userspace programs.
> > 
> > The next best approach is forcing a single empty string into argv and
> > adjusting argc to match. The number of programs depending on argc == 0
> > seems a smaller set than those calling execve with a NULL argv.
> 
> Has anyone considered using the pathname for argv[0]?
> So converting:
> 	execl(path, NULL);
> into:
> 	execl(path, path, NULL);
> 
> I've not spotted any such suggestion.

It came up on some IRC discussions at some point. I'm personally not a
fan of this because it creates a bit of "new" ABI that has a lot of
variability (depending on "" is one thing, but depending on a "missing"
argv matching the exec path is very different). I think there were also
concerns about dealing with fd-based exec ("what is the 'right' name"),
etc.

I'd prefer we stay as simple as possible for this change.

-- 
Kees Cook
