Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5D01E89F8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 May 2020 23:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728315AbgE2VYu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 May 2020 17:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727879AbgE2VYt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 May 2020 17:24:49 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 695FEC08C5C9
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 May 2020 14:24:49 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id n18so459439pfa.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 May 2020 14:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=D4XvzccK0xuuOxPVRAAoMtzFaRjIX/ZkQiWNAhxPFLA=;
        b=RON1Jx7dOzYu+YHprq0o6tiT6Yv2AJ9MlOS/A/Nuono2hH/bCcRvNgoMbMInHMuCJb
         TTx63JMbKAOZhxwpGi8uy4l9LdwxdBZmmxOq+bMRXYk7rC6u1Ts7NlZPXhm1wMafChz0
         hNFUuluNC9zd9xt4v5wBqJbchJIASDUzkdTTE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=D4XvzccK0xuuOxPVRAAoMtzFaRjIX/ZkQiWNAhxPFLA=;
        b=WFO5+3TvO9aTvTPolFfKMUW0iTAKnhSSrbdNX5DEdu5lV8itw7LmHvoKwC4pgh2u5C
         I+CTNo7jWqnVJrDabUah7FzH29JvFI3CmGiufbNcZL99NqObMONqNOiK2TgCIQtTt9Sb
         NmHZPzypmjDJXdcUcOggVTTYS+DwrQZvEkQpBS45Vr5VoVPUpXkP/O5HSsSJCfeQq4v6
         cumKgSdh/zl4O4XzkKd+Y+Kd5bD9qc5T2vprkjMl3nZYkHpVQLhBmDsEDSENDoh4AqTQ
         JDcctxQQJ6WDsrlkxDQ+zCF+Q2pr+pVO+B4o7hut+pKA2eDq9P5WVoj7TxMx/gsVc0y4
         k9jg==
X-Gm-Message-State: AOAM531EuNU4woKXj+Ii7PSAAmwvVv04IzRRt4iDVp5YC3/f/0wyvL9a
        Nun7IBCUIkuSYYmx0GA0KD2RAA==
X-Google-Smtp-Source: ABdhPJx19G73LsHEx0RQVpMqVyTccPM6mmiPuIW/RTCEwlk0mpgkD9B1OZq0r63Cob8gJllfSSl6pA==
X-Received: by 2002:a62:fc52:: with SMTP id e79mr10893035pfh.297.1590787488823;
        Fri, 29 May 2020 14:24:48 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w206sm2029579pfc.28.2020.05.29.14.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 14:24:47 -0700 (PDT)
Date:   Fri, 29 May 2020 14:24:46 -0700
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
Subject: Re: [PATCH 2/2] exec: Compute file based creds only once
Message-ID: <202005291406.52E27AF8@keescook>
References: <87h7wujhmz.fsf@x220.int.ebiederm.org>
 <87sgga6ze4.fsf@x220.int.ebiederm.org>
 <87v9l4zyla.fsf_-_@x220.int.ebiederm.org>
 <877dx822er.fsf_-_@x220.int.ebiederm.org>
 <87k10wysqz.fsf_-_@x220.int.ebiederm.org>
 <87d06mr8ps.fsf_-_@x220.int.ebiederm.org>
 <871rn2r8m6.fsf_-_@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871rn2r8m6.fsf_-_@x220.int.ebiederm.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 29, 2020 at 11:47:29AM -0500, Eric W. Biederman wrote:
> Move the computation of creds from prepare_binfmt into begin_new_exec
> so that the creds need only be computed once.  This is just code
> reorganization no semantic changes of any kind are made.
> 
> Moving the computation is safe.  I have looked through the kernel and
> verified none of the binfmts look at bprm->cred directly, and that
> there are no helpers that look at bprm->cred indirectly.  Which means
> that it is not a problem to compute the bprm->cred later in the
> execution flow as it is not used until it becomes current->cred.
> 
> A new function bprm_creds_from_file is added to contain the work that
> needs to be done.  bprm_creds_from_file first computes which file
> bprm->executable or most likely bprm->file that the bprm->creds
> will be computed from.
> 
> The funciton bprm_fill_uid is updated to receive the file instead of
> accessing bprm->file.  The now unnecessary work needed to reset the
> bprm->cred->euid, and bprm->cred->egid is removed from brpm_fill_uid.
> A small comment to document that bprm_fill_uid now only deals with the
> work to handle suid and sgid files.  The default case is already
> heandled by prepare_exec_creds.
> 
> The function security_bprm_repopulate_creds is renamed
> security_bprm_creds_from_file and now is explicitly passed the file
> from which to compute the creds.  The documentation of the
> bprm_creds_from_file security hook is updated to explain when the hook
> is called and what it needs to do.  The file is passed from
> cap_bprm_creds_from_file into get_file_caps so that the caps are
> computed for the appropriate file.  The now unnecessary work in
> cap_bprm_creds_from_file to reset the ambient capabilites has been
> removed.  A small comment to document that the work of
> cap_bprm_creds_from_file is to read capabilities from the files
> secureity attribute and derive capabilities from the fact the
> user had uid 0 has been added.
> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

This all looks good to me. Small notes below...

Reviewed-by: Kees Cook <keescook@chromium.org>

> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> index cd3dd0afceb5..37bb3df751c6 100644
> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -44,18 +44,18 @@
>   *	request libc enable secure mode.
>   *	@bprm contains the linux_binprm structure.
>   *	Return 0 if the hook is successful and permission is granted.
> - * @bprm_repopulate_creds:
> - *	Assuming that the relevant bits of @bprm->cred->security have been
> - *	previously set, examine @bprm->file and regenerate them.  This is
> - *	so that the credentials derived from the interpreter the code is
> - *	actually going to run are used rather than credentials derived
> - *	from a script.  This done because the interpreter binary needs to
> - *	reopen script, and may end up opening something completely different.
> - *	This hook may also optionally check permissions (e.g. for
> - *	transitions between security domains).
> - *	The hook must set @bprm->active_secureexec to 1 if AT_SECURE should be set to
> + * @bprm_creds_from_file:
> + *	If @file is setpcap, suid, sgid or otherwise marked to change
> + *	privilege upon exec, update @bprm->cred to reflect that change.
> + *	This is called after finding the binary that will be executed.
> + *	without an interpreter.  This ensures that the credentials will not
> + *	be derived from a script that the binary will need to reopen, which
> + *	when reopend may end up being a completely different file.  This
> + *	hook may also optionally check permissions (e.g. for transitions
> + *	between security domains).
> + *	The hook must set @bprm->secureexec to 1 if AT_SECURE should be set to
>   *	request libc enable secure mode.
> - *	The hook must set @bprm->pf_per_clear to the personality flags that
> + *	The hook must set @bprm->per_clear to the personality flags that

Here and the other per_clear comment have language that doesn't quite
line up with how hooks should deal with the bits. They should not "set
it to" the personality flags they want clear, they need to "add the
bits" they want to see cleared. i.e I don't want something thinking
they're the only one touching per_clear, so they should never do:
	bprm->per_clear = PER_CLEAR_ON_SETID;
but always:
	bprm->per_clear |= PER_CLEAR_ON_SETID;

How about:

The hook must set @bprm->per_clear with any personality flag bits that

> diff --git a/security/commoncap.c b/security/commoncap.c

Not about this patch, but while looking through this file, I see:

int cap_bprm_set_creds(struct linux_binprm *bprm)
{
	...
	*capability manipulations*

        if (WARN_ON(!cap_ambient_invariant_ok(new)))
                return -EPERM;

        if (nonroot_raised_pE(new, old, root_uid, has_fcap)) {
                ret = audit_log_bprm_fcaps(bprm, new, old);
                if (ret < 0)
                        return ret;
        }

        new->securebits &= ~issecure_mask(SECURE_KEEP_CAPS);

        if (WARN_ON(!cap_ambient_invariant_ok(new)))
                return -EPERM;
	...
}

The cap_ambient_invariant_ok() test is needlessly repeated: it doesn't
examine securebits, and nonroot_raised_pE appears to have no
side-effects.

One of those can be dropped, yes?

-- 
Kees Cook
