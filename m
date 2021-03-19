Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 164A334233A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Mar 2021 18:26:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbhCSRZ3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Mar 2021 13:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbhCSRZB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Mar 2021 13:25:01 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FD41C061763
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Mar 2021 10:25:01 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id e14so3271347plj.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Mar 2021 10:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=RPNBgVNWrZM19pIS372izv7KcqqWZ135/0V8aeAzGP4=;
        b=K1efaQIPJngSEiTSfj5NbLVfNLqZtgPvqUfvC1WNYpzdFAu7/1XTpLPBBFtmSt+oY2
         KVmLT9t34Y6/JS+Ig+PPncatAS2b/d4cD8tjJcN54O8jhVmiXiLmNkazHuqcVfqBBhC6
         yW0J2Fu5AtsfqocA+fV3xcEFAv2KViqTGmszc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=RPNBgVNWrZM19pIS372izv7KcqqWZ135/0V8aeAzGP4=;
        b=FY8t/IztWUG0zsbJWJKJENVLhiJ9HH5+cO6gDI2Qp6LqMy44pbYxzI9qfmb3oMS8Qd
         ShiJQishWNRoDQg8R48N86MEll5A++A8m1SQatX4+dzIte2o181sMI3XFYqjqF5cu6HG
         MDUhT924t39oj5yWPDox7ubIHRofjt5lFaPkT2ZAaGTF1SvbhMCkR35Vm26lmZboa8XY
         EEjnS8BHpFoRhUI2rS1cx1UFfAYNt8JIj70zFz1hUvM7r3eQTAs1PTfC5LccgplfNnNf
         rwkWsWLD7fDnOjmQfqfQl/xvu5hqyDShLmcuB/tG8XRGPx7B/W1ajOLrb8UqeY+pGnOi
         d/eg==
X-Gm-Message-State: AOAM533vOqczU+bGiyPRqyn0Oku7nbUU6R6PH/iJkKEioXxTI0yWhXzB
        rzaRtt7n7+yUvIR1Xo7YY6JTyA==
X-Google-Smtp-Source: ABdhPJwQo7lLAkkNXduzlhCfNKIga0uRqxJV6ZyIr8rEdU6i+dH0dy8a1JUabwKCyr6ayySXYWHO+A==
X-Received: by 2002:a17:90b:291:: with SMTP id az17mr10475690pjb.206.1616174700784;
        Fri, 19 Mar 2021 10:25:00 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w4sm5976831pjk.55.2021.03.19.10.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 10:24:59 -0700 (PDT)
Date:   Fri, 19 Mar 2021 10:24:59 -0700
From:   Kees Cook <keescook@chromium.org>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        David Howells <dhowells@redhat.com>,
        Jeff Dike <jdike@addtoit.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Shuah Khan <shuah@kernel.org>,
        Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org, x86@kernel.org,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@linux.microsoft.com>
Subject: Re: [PATCH v30 06/12] fs,security: Add sb_delete hook
Message-ID: <202103191024.436E16509C@keescook>
References: <20210316204252.427806-1-mic@digikod.net>
 <20210316204252.427806-7-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210316204252.427806-7-mic@digikod.net>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 16, 2021 at 09:42:46PM +0100, Mickaël Salaün wrote:
> From: Mickaël Salaün <mic@linux.microsoft.com>
> 
> The sb_delete security hook is called when shutting down a superblock,
> which may be useful to release kernel objects tied to the superblock's
> lifetime (e.g. inodes).
> 
> This new hook is needed by Landlock to release (ephemerally) tagged
> struct inodes.  This comes from the unprivileged nature of Landlock
> described in the next commit.
> 
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: James Morris <jmorris@namei.org>
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
