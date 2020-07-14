Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40FB3220024
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jul 2020 23:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbgGNViY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jul 2020 17:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726929AbgGNViY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jul 2020 17:38:24 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE8AC061794
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jul 2020 14:38:24 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id j20so8187044pfe.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jul 2020 14:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rhUtjNTW91qlPLBzYGxtd6FEYeoJpzq4EC2Nr6kXNew=;
        b=XR5InLU/ZuYgwGb0JtnB3ih96loG0AE59nbhZISKaA1qecqUWLJaYCd13NQJ3Or6sC
         +3LfdAmhLom67MejtQ6qgLpS0M6Dmkf1Wsb8or6ZSMX/ni3TgDMdp8V4HIp9Y6BLUVn0
         iB1MILb/MoIgDVtacC26ydy565jdZ3reUFdJ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rhUtjNTW91qlPLBzYGxtd6FEYeoJpzq4EC2Nr6kXNew=;
        b=p2zBIvrHTDsFLd7LvwyG20jxTMKXeMFwfaVSaCI+OifX6gLIrYlGIfUZ8ng80KSHAQ
         diWV+rQxfRjofPXK8dRrp/AUGvMFKtCywS0oiSob1Rl/0M3mZ8WsViBdCskCDGbewRq3
         tVFYmPSv9dqAcTXWb7P3qlWF3FMvk7XsNxIwi5ux90trVjMZafWjUhrob7PQIHzAQTDW
         lPBOJNdI+kfNevUilI6j3hUf6EtlYvzTN/7+vmRfedE+RUBgEGQfT4MGFv/nj8Q8XU43
         8lbwUXKwh4jaGYHyY+n3Mjn7gy6oQgiarL1qQY4IaLwZK5PQTQ8cvgYVczixq3Zq+6c/
         V3qQ==
X-Gm-Message-State: AOAM533MaXuXgQYwTfQcvtNEKHDu/xrcIWYD2uciWGSmzUhnirP60YH9
        S5EbTCeZj3vHav1oTd0ixSFp2g==
X-Google-Smtp-Source: ABdhPJz6b6t7d1xxynzW3FbpvoGzvZ0dDIPSG7G6/UnTLzQBeOIoJTyLQKUygq9QebBJSIO7rhfuVQ==
X-Received: by 2002:a65:43c9:: with SMTP id n9mr4803979pgp.452.1594762703715;
        Tue, 14 Jul 2020 14:38:23 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g12sm109930pfb.190.2020.07.14.14.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 14:38:22 -0700 (PDT)
Date:   Tue, 14 Jul 2020 14:38:22 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-fsdevel@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        linux-security-module@vger.kernel.org,
        "Serge E. Hallyn" <serge@hallyn.com>,
        James Morris <jmorris@namei.org>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 2/7] exec: Factor out alloc_bprm
Message-ID: <202007141438.C4E2A2A9@keescook>
References: <871rle8bw2.fsf@x220.int.ebiederm.org>
 <87pn8y6x9a.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pn8y6x9a.fsf@x220.int.ebiederm.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 14, 2020 at 08:29:05AM -0500, Eric W. Biederman wrote:
> 
> Currently it is necessary for the usermode helper code and the code
> that launches init to use set_fs so that pages coming from the kernel
> look like they are coming from userspace.
> 
> To allow that usage of set_fs to be removed cleanly the argument
> copying from userspace needs to happen earlier.  Move the allocation
> of the bprm into it's own function (alloc_bprm) and move the call of
> alloc_bprm before unshare_files so that bprm can ultimately be
> allocated, the arguments can be placed on the new stack, and then the
> bprm can be passed into the core of exec.
> 
> Neither the allocation of struct binprm nor the unsharing depend upon each
> other so swapping the order in which they are called is trivially safe.
> 
> To keep things consistent the order of cleanup at the end of
> do_execve_common swapped to match the order of initialization.
> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
