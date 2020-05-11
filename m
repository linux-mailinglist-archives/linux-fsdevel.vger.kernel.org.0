Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8051CE745
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 May 2020 23:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbgEKVS1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 May 2020 17:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725836AbgEKVS1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 May 2020 17:18:27 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF6BDC061A0E
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 May 2020 14:18:25 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id g11so1218653plp.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 May 2020 14:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GxSruKmA2bVgy2K4+WkymzUTkS1gnJsJUC47X7HGuw8=;
        b=EwKfi3+hJDWZ8/AeaZnpGHoqH6Kcbn3pIZMuRsFGvZIL80r6CJy070DkChxmmGK2fG
         7WoORQoH5aNIKpqth43z3WE328yeHngrUwOvfgV2ZpW75R++NnIiTV22MYbsZMa9B1HV
         lwxydVAz8ZkQ6j1CP3zxv4sMDONCi9iK7naYE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GxSruKmA2bVgy2K4+WkymzUTkS1gnJsJUC47X7HGuw8=;
        b=Xq/5yhSBRA/+r5stfeCVE+JWaRvS1cBAGJLGbr27S1CLmdMz2thp9VD6GkjTSMBJWo
         ktDx+BGEbJgTn04dU6uwhraej4/ZvI9ZO5dTdC7I61JMXXeiyoL2kfVdRpBU7uO3l3YG
         Pk7shTaeWpeN+8AK/7NKo0B/Ugpk7FfRXRxvrPlP9s4FAkxDHWfzuUMaFJ/qgYLW69rd
         764EJdOJHRL7JdOglFlkUzg+ezbQt7Sf7FsBR+ZryNXyd4Xc3cE/NADjUqLvNguGDU+i
         NZj5rV6uqgVGdJ1KCGHieG2F9DLQ9E7LWFaWmmoF0FEwxJEQ4lkee68AtqHgOpyTgbrK
         dA3Q==
X-Gm-Message-State: AGi0Pubz43S9HNlrTdTQvUcRi+f3OIbmwSoKi/Z0VmL7edKcShAsaZ+x
        5tNfrVI0oRLqHPNRZQKGSpVvzymYiQ8=
X-Google-Smtp-Source: APiQypIQTSd9p1Hcvj1g6YAF7Rt7WW61eGi49zkjg5ig+hvMKX8MGOBSXbVNH7xwhe+a038HXAfJ3w==
X-Received: by 2002:a17:902:8496:: with SMTP id c22mr17155337plo.182.1589231904878;
        Mon, 11 May 2020 14:18:24 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a23sm9923384pfo.145.2020.05.11.14.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 14:18:23 -0700 (PDT)
Date:   Mon, 11 May 2020 14:18:22 -0700
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
Subject: Re: [PATCH 2/5] exec: Directly call security_bprm_set_creds from
 __do_execve_file
Message-ID: <202005111245.6E390B46@keescook>
References: <87h7wujhmz.fsf@x220.int.ebiederm.org>
 <87sgga6ze4.fsf@x220.int.ebiederm.org>
 <87v9l4zyla.fsf_-_@x220.int.ebiederm.org>
 <87k11kzyjm.fsf_-_@x220.int.ebiederm.org>
 <202005101929.A4374D0F56@keescook>
 <87y2pytnvq.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y2pytnvq.fsf@x220.int.ebiederm.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 11, 2020 at 11:52:41AM -0500, Eric W. Biederman wrote:
> Kees Cook <keescook@chromium.org> writes:
> 
> > On Sat, May 09, 2020 at 02:41:17PM -0500, Eric W. Biederman wrote:
> >> 
> >> Now that security_bprm_set_creds is no longer responsible for calling
> >> cap_bprm_set_creds, security_bprm_set_creds only does something for
> >> the primary file that is being executed (not any interpreters it may
> >> have).  Therefore call security_bprm_set_creds from __do_execve_file,
> >> instead of from prepare_binprm so that it is only called once, and
> >> remove the now unnecessary called_set_creds field of struct binprm.
> >> 
> >> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> >> ---
> >>  fs/exec.c                  | 11 +++++------
> >>  include/linux/binfmts.h    |  6 ------
> >>  security/apparmor/domain.c |  3 ---
> >>  security/selinux/hooks.c   |  2 --
> >>  security/smack/smack_lsm.c |  3 ---
> >>  security/tomoyo/tomoyo.c   |  6 ------
> >>  6 files changed, 5 insertions(+), 26 deletions(-)
> >> 
> >> diff --git a/fs/exec.c b/fs/exec.c
> >> index 765bfd51a546..635b5085050c 100644
> >> --- a/fs/exec.c
> >> +++ b/fs/exec.c
> >> @@ -1635,12 +1635,6 @@ int prepare_binprm(struct linux_binprm *bprm)
> >>  
> >>  	bprm_fill_uid(bprm);
> >>  
> >> -	/* fill in binprm security blob */
> >> -	retval = security_bprm_set_creds(bprm);
> >> -	if (retval)
> >> -		return retval;
> >> -	bprm->called_set_creds = 1;
> >> -
> >>  	retval = cap_bprm_set_creds(bprm);
> >>  	if (retval)
> >>  		return retval;
> >> @@ -1858,6 +1852,11 @@ static int __do_execve_file(int fd, struct filename *filename,
> >>  	if (retval < 0)
> >>  		goto out;
> >>  
> >> +	/* fill in binprm security blob */
> >> +	retval = security_bprm_set_creds(bprm);
> >> +	if (retval)
> >> +		goto out;
> >> +
> >>  	retval = prepare_binprm(bprm);
> >>  	if (retval < 0)
> >>  		goto out;
> >> 
> >
> > Here I go with a Sunday night review, so hopefully I'm thinking better
> > than Friday night's review, but I *think* this patch is broken from
> > the LSM sense of the world in that security_bprm_set_creds() is getting
> > called _before_ the creds actually get fully set (in prepare_binprm()
> > by the calls to bprm_fill_uid(), cap_bprm_set_creds(), and
> > check_unsafe_exec()).
> >
> > As a specific example, see the setting of LSM_UNSAFE_NO_NEW_PRIVS in
> > bprm->unsafe during check_unsafe_exec(), which must happen after
> > bprm_fill_uid(bprm) and cap_bprm_set_creds(bprm), to have a "true" view
> > of the execution privileges. Apparmor checks for this flag in its
> > security_bprm_set_creds() hook. Similarly do selinux, smack, etc...
> 
> I think you are getting prepare_binprm confused with prepare_bprm_creds.
> Understandable given the similarity of their names.

I fixated on a bad example, having confused myself about when
check_unsafe_exec() happens. My original concern (with the bad example)
was that the LSM is having security_bprm_set_creds() called before the
new cred in bprm->cred has been initialized with all the correct uid/gid,
caps, and associated flags.

But anything associated with capabilities should be confined to the
commoncap LSM, though there is "leakage" into the uid/gid states and some
bprm state (more on this later). That said, as you also found, I can't
find any LSM that examines those fields of the cred (I had stopped this
research last night when I saw check_unsafe_exec() and confused myself);
they're all looking at other bprm state not associated with caps and uid
changes (file, unsafe_exec, security field of new cred, etc). So that's
very good! That means we've actually kept a bright line between things
here -- whew.

> > The security_bprm_set_creds() boundary for LSM is to see the "final"
> > state of the process privileges, and that needs to happen after
> > bprm_fill_uid(), cap_bprm_set_creds(), and check_unsafe_exec() have all
> > finished.
> >
> > So, as it stands, I don't think this will work, but perhaps it can still
> > be rearranged to avoid the called_set_creds silliness. I'll look more
> > this week...
> 
> If you look at the flow of the code in __do_execve_file before this
> change it is:
> 
> 	prepare_bprm_creds()
>         check_unsafe_exec()
> 
> 	...
> 
>         prepare_binprm()
>         	bprm_file_uid()

(bprm_fill_uid(), but yes)

>                 	bprm->cred->euid = current_euid()
>                         bprm->cred->egid = current_egid()
> 		security_bprm_set_creds()
>                 	for_each_lsm()
>                         	lsm->bprm_set_creds()
>                                 	if (called_set_creds)
>                                         	return;
>                                         ...
> 		bprm->called_set_creds = 1;
> 	...
> 
> 	exec_binprm()
>         	search_binary_handler()
>                 	security_bprm_check()
>                         	tomoyo_bprm_check_security()
>                                 ima_bprm_check()
>    			load_script()
>                         	prepare_binprm()
>                                 	/* called_set_creds already == 1 */
>                                 	bprm_file_uid()
>                                         security_bprm_set_creds()
> 			                	for_each_lsm()
> 			                        	lsm->bprm_set_creds()
> 		                                	if (called_set_creds)
>                 		                        	return;
>                                 		        ...
>                                 search_binary_handler()
>                                 	security_bprm_check_security()
>                                         load_elf_binary()
>                                         	...
>                                                 setup_new_exec
>                                                 ...
> 
> 
> Assuming you are executing a shell script.
> 
> Now bprm_file_uid is written with the assumption that it will be called
> multiple times and it reinitializes all of it's variables each time.

Right -- and the same is true for cap_bprm_set_creds() (in that
it needs to be run multiple times and depends on the work done in
bprm_fill_uid()). If we encounter a future use-case for having other
LSMs call out here multiple time, we can introduce a new LSM hook.

> As you can see in above the implementations of bprm_set_creds() only
> really execute before called_set_creds is set, aka the first time.
> They in no way see the final state.
> 
> Further when I looked as those hooks they were not looking at the values
> set by bprm_file_uid at all.  There were busy with the values their
> they needed to set in that hook for their particular lsm.

Agreed (though I'd love some other LSM eyes on this conclusion).

> So while in theory I can see the danger of moving above bprm_file_uid
> I don't see anything in practice that would be a problem.
> 
> Further by moving the call of security_bprm_set_creds out of
> prepare_binprm int __do_execve_file just before the call of
> prepare_binprm I am just moving the call above binprm_fill_uid
> and nothing else.
> 
> So I think you just confused prepare_bprm_creds with prepare_binprm.
> As most of your criticisms appear valid in that case.  Can you take a
> second look?

So, in earlier attempts to clean up code near all this, I removed the
LSM's bprm_secureexec hook, which only commoncap was using to impart
details about privilege elevation. I switched the semantics to having LSMs
set bprm->secureexec to true (but never to zero). Since commoncap's idea
of "was I elevated?" might repeatedly change, I had to store its results
"privately" in the bprm, which got us cap_elevated (in 46d98eb4e1d2):

c425e189ffd7 ("binfmt: Introduce secureexec flag")
993b3ab0642e ("apparmor: Refactor to remove bprm_secureexec hook")
62874c3adf70 ("selinux: Refactor to remove bprm_secureexec hook")
46d98eb4e1d2 ("commoncap: Refactor to remove bprm_secureexec hook")
ee67ae7ef6ff ("commoncap: Move cap_elevated calculation into bprm_set_creds")
2af622802696 ("LSM: drop bprm_secureexec hook")

So, given the special-case nature of capabilities here, this does seem
to be the right choice (assuming we're not missing something in the
other LSMs). As such, I think the comment for cap_elevated needs to be
updated to reflect the change to function call flow, and to specify it
cannot be used by the other LSMs. Maybe something like:

               /*
                * True if most recent call to cap_bprm_set_creds()
                * (due to multiple prepare_binprm() calls from the
                * binfmt_script/misc handlers) resulted in elevated
                * privileges. This is used internally by fs/exec.c
		* to set bprm->secureexec.
                */
               cap_elevated:1,

And that brings us to naming. Whee. I think we should make the following
name changes:

bprm_fill_uid      ->	bprm_establish_privileges
cap_bprm_set_creds ->	cap_establish_privileges

Finally, I think we should update the comment on bprm_set_creds (which,
actually, I think is the correct name now) to something like:

 * @bprm_set_creds:
 *	Save security information in the @bprm->cred->security field,
 *	typically based on information about the bprm->file, for later
 *	use during the @bprm_committing_creds hook. Specifically
 *	the credentials themselves (uid, gid, etc), are not finalized
 *	yet and must not be examined until the @bprm_committing_creds
 *	hook.
 *      This hook is called once, after the creds structure has been
 *	allocated.
 *      The hook must set @bprm->secureexec to 1 if a "secure exec"
 *	has happened as a result of this hook call. The flag is used to
 *      indicate the need for a sanitized execution environment, and is
 *      also passed in the ELF auxiliary table on the initial stack to
 *      indicate whether libc should enable secure mode.
 *	This hook may also optionally check LSM-specific permissions
 *	(e.g. for transitions between security domains).
 *      @bprm contains the linux_binprm structure.
 *      Return 0 if the hook is successful and permission is granted.

-Kees

-- 
Kees Cook
