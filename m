Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 031091DA2DA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 May 2020 22:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbgESUiB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 May 2020 16:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbgESUiA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 May 2020 16:38:00 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF76C08C5C2
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2020 13:38:00 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id z26so431072pfk.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2020 13:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1ajSll4bK53Qb2Ak/L8hDSxkSGAnkpDcgNlbRYtpvdY=;
        b=bdpue+Ojf13IRe6EAqF+S2fM9FW1U9KJIwBTq1d4UtGhfpgkzxqbNMwL2t9gD/HgLg
         dzeF1gIHEz8PErdvGj7aC4MbQMcPkV3d3d2qYtkVu2Wif68mY8/Wm6UD9TIbyOM18bXQ
         GIF7TGksPetl0XqMWhyuq9wcVAqbqi+bOu8+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1ajSll4bK53Qb2Ak/L8hDSxkSGAnkpDcgNlbRYtpvdY=;
        b=WoMi5R2BWk4lKWpjZszIxYRjdcJhxXc85iYiQasky/9C16eEjLALKM1hkbeAWWTOJf
         BZ96dMGoDXji8Mwsh9fbu4N7zFSo3gIJ0nYYBp5/Ky7s7GKGeCMAlwmpL7zYuBJZ+SO6
         jcFyETmvxKCEnY3N4Xjt917HLCjvcGPVGtJ3jryO9R0HOovAneWHE1hyhRxQH9OZvFew
         56cgYIp6J9I5VX+vG9Eb1Amt5F4V/Zj0mmOGFM+kFwjH0GQMcTWvqfxmSSSepCQaynz4
         NbqDG1hVCEJNeHwJwrz5khmsLeRPEDX0L96tt3jSBlWU1fvNDLpIlRF3oXBpI8/Og9Fw
         ahDQ==
X-Gm-Message-State: AOAM531IXtCMFJ+aW2C5UrmfeVtwe/pyteRKUYnbuDebkmpgEjz8Q9Zm
        m/GuRHNlgwMCR1/PU4kKJRueCQ==
X-Google-Smtp-Source: ABdhPJzOaJoPTT49vaOBrznFkW9TmN9W+ndpxwI48V37k7vrHTnQHLcXHDI+QItVM51xmiO2ue42TQ==
X-Received: by 2002:aa7:91da:: with SMTP id z26mr954615pfa.18.1589920680112;
        Tue, 19 May 2020 13:38:00 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i184sm278051pgc.36.2020.05.19.13.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 13:37:59 -0700 (PDT)
Date:   Tue, 19 May 2020 13:37:57 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Rob Landley <rob@landley.net>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH v2 8/8] exec: Remove recursion from search_binary_handler
Message-ID: <202005191320.230EFDFCB@keescook>
References: <87h7wujhmz.fsf@x220.int.ebiederm.org>
 <87sgga6ze4.fsf@x220.int.ebiederm.org>
 <87v9l4zyla.fsf_-_@x220.int.ebiederm.org>
 <877dx822er.fsf_-_@x220.int.ebiederm.org>
 <87sgfwyd84.fsf_-_@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sgfwyd84.fsf_-_@x220.int.ebiederm.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 18, 2020 at 07:34:19PM -0500, Eric W. Biederman wrote:
> 
> Recursion in kernel code is generally a bad idea as it can overflow
> the kernel stack.  Recursion in exec also hides that the code is
> looping and that the loop changes bprm->file.
> 
> Instead of recursing in search_binary_handler have the methods that
> would recurse set bprm->interpreter and return 0.  Modify exec_binprm
> to loop when bprm->interpreter is set.  Consolidate all of the
> reassignments of bprm->file in that loop to make it clear what is
> going on.
> 
> The structure of the new loop in exec_binprm is that all errors return
> immediately, while successful completion (ret == 0 &&
> !bprm->interpreter) just breaks out of the loop and runs what
> exec_bprm has always run upon successful completion.
> 
> Fail if the an interpreter is being call after execfd has been set.
> The code has never properly handled an interpreter being called with
> execfd being set and with reassignments of bprm->file and the
> assignment of bprm->executable in generic code it has finally become
> possible to test and fail when if this problematic condition happens.
> 
> With the reassignments of bprm->file and the assignment of
> bprm->executable moved into the generic code add a test to see if
> bprm->executable is being reassigned.
> 
> In search_binary_handler remove the test for !bprm->file.  With all
> reassignments of bprm->file moved to exec_binprm bprm->file can never
> be NULL in search_binary_handler.
> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Lovely!

Reviewed-by: Kees Cook <keescook@chromium.org>

I spent some time following the file lifetimes of deny/allow_write_access()
and the fget/fput() paths. It all looks correct to me; it's tricky
(especially bprm->executable) but so very much cleaner than before. :)

The only suggestion I could come up with is more comments (surprise) to
help anyone new to this loop realize what the "common" path is (and
similarly, a compiler hint too):

diff --git a/fs/exec.c b/fs/exec.c
index a9f421ec9e27..738051a698e1 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1790,15 +1790,19 @@ static int exec_binprm(struct linux_binprm *bprm)
 	/* This allows 4 levels of binfmt rewrites before failing hard. */
 	for (depth = 0;; depth++) {
 		struct file *exec;
+
 		if (depth > 5)
 			return -ELOOP;
 
 		ret = search_binary_handler(bprm);
+		/* Unrecoverable error, give up. */
 		if (ret < 0)
 			return ret;
-		if (!bprm->interpreter)
+		/* Found final handler, start execution. */
+		if (likely(!bprm->interpreter))
 			break;
 
+		/* Found an interpreter, so try again and attempt to run it. */
 		exec = bprm->file;
 		bprm->file = bprm->interpreter;
 		bprm->interpreter = NULL;

-- 
Kees Cook
