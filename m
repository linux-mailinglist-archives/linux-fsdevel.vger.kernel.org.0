Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC0212172DF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jul 2020 17:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728588AbgGGPpa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jul 2020 11:45:30 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:45991 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbgGGPp3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jul 2020 11:45:29 -0400
Received: from ip5f5af08c.dynamic.kabel-deutschland.de ([95.90.240.140] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jspmM-0001C3-Mv; Tue, 07 Jul 2020 15:45:06 +0000
Date:   Tue, 7 Jul 2020 17:45:04 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Nicolas Viennot <Nicolas.Viennot@twosigma.com>,
        Jann Horn <jannh@google.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Adrian Reber <areber@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        =?utf-8?B?TWljaGHFgiBDxYJhcGnFhHNraQ==?= <mclapinski@google.com>,
        Kamil Yurtsever <kyurtsever@google.com>,
        Dirk Petersen <dipeit@gmail.com>,
        Christine Flood <chf@redhat.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "selinux@vger.kernel.org" <selinux@vger.kernel.org>,
        Eric Paris <eparis@parisplace.org>,
        Jann Horn <jannh@google.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v4 3/3] prctl: Allow ptrace capable processes to change
 /proc/self/exe
Message-ID: <20200707154504.aknxmw6qavpjkr24@wittgenstein>
References: <20200701064906.323185-1-areber@redhat.com>
 <20200701064906.323185-4-areber@redhat.com>
 <20200702211647.GB3283@mail.hallyn.com>
 <CAHC9VhQZ=cwiOay6OMMdM1UHm69wDaga9HBkyTbx8-1OU=aBvA@mail.gmail.com>
 <a2b4deacfc7541e3adea2f36a6f44262@EXMBDFT11.ad.twosigma.com>
 <20200706174437.zpshxlul7rl3vmmq@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200706174437.zpshxlul7rl3vmmq@wittgenstein>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 06, 2020 at 07:44:38PM +0200, Christian Brauner wrote:
> On Mon, Jul 06, 2020 at 05:13:35PM +0000, Nicolas Viennot wrote:
> > > > This is scary.  But I believe it is safe.
> > > >
> > > > Reviewed-by: Serge Hallyn <serge@hallyn.com>
> > > >
> > > > I am a bit curious about the implications of the selinux patch.
> > > > IIUC you are using the permission of the tracing process to execute
> > > > the file without transition, so this is a way to work around the
> > > > policy which might prevent the tracee from doing so.
> > > > Given that SELinux wants to be MAC, I'm not *quite* sure that's
> > > > considered kosher.  You also are skipping the PROCESS__PTRACE to
> > > > SECCLASS_PROCESS check which selinux_bprm_set_creds does later on.
> > > > Again I'm just not quite sure what's considered normal there these
> > > > days.
> > > >
> > > > Paul, do you have input there?
> > >
> > > I agree, the SELinux hook looks wrong.  Building on what Christian said, this looks more like a ptrace operation than an exec operation.
> > 
> > Serge, Paul, Christian,
> > 
> > I made a PoC to demonstrate the change of /proc/self/exe without CAP_SYS_ADMIN using only ptrace and execve.
> > You may find it here: https://github.com/nviennot/run_as_exe
> > 
> > What do you recommend to relax the security checks in the kernel when it comes to changing the exe link?
> 
> Looks fun! Yeah, so that this is possible is known afaict. But you're
> not really circumventing the kernel check but are mucking with the EFL
> by changing the auxv, right?
> 
> Originally, you needed to be userns root, i.e. only uid 0 could
> change the /proc/self/exe link (cf. [1]). This was changed to
> ns_capable(CAP_SYS_ADMIN) in [2].
> 
> The original reasoning in [1] is interesting as it basically already
> points to your poc:
> 
> "Still note that updating exe-file link now doesn't require sys-resource
>  capability anymore, after all there is no much profit in preventing
>  setup own file link (there are a number of ways to execute own code --
>  ptrace, ld-preload, so that the only reliable way to find which exactly
>  code is executed is to inspect running program memory).  Still we
>  require the caller to be at least user-namespace root user."
> 
> There were arguments being made that /proc/<pid>/exe needs to be sm that
> userspace can have a decent amount of trust in but I believe that that's
> not a great argument.
> 
> But let me dig a little into the original discussion and see what the
> thread-model was.
> At this point I'm starting to believe that it was people being cautios
> but better be sure.

Ok, so the original patch proposal was presented in [4] in 2014. The
final version of that patch added the PR_SET_MM_MAP we know today. The
initial version presented in [4] did not require _any_ privilege.

So the reasoning for only placing the /proc/<pid>/exe link under
ns_capable(CAP_SYS_ADMIN) is very thin. to quote from [5]:

"Controlling exe_fd without privileges may turn out to be dangerous. At
 least things like tomoyo examine it for making policy decisions (see
 tomoyo_manager())."

So yes, tomoyo_get_exe() is what this was retained for apparently:

const char *tomoyo_get_exe(void)
{
	struct file *exe_file;
	const char *cp;
	struct mm_struct *mm = current->mm;

	if (!mm)
		return NULL;
	exe_file = get_mm_exe_file(mm);
	if (!exe_file)
		return NULL;

	cp = tomoyo_realpath_from_path(&exe_file->f_path);
	fput(exe_file);
	return cp;
}

The exe path is literally used in tomoyo_manager() to verify that you
are allowed to change policy. That seems like a bad idea to me but then
again, I don't know enough about Tomoyo. In any case, I think that means
we can't remove CAP_SYS_ADMIN because that would make things worse than
they are right now for Tomoyo but I also don't see why placing this
under ns_capable(CAP_SYS_ADMIN) || ns_capable(CAP_CHECKPOINT_RESTORE)
would make this any worse.

And Cyrill (and later in that thread Andrei) already mentioned it in [6]:
"@exe_fd is just a hint and as I mentioned if we have ptrace/preload
 rights there damn a lot of ways to inject own code into any program so
 that a user won't even notice ;)"

Another place where the exe file is relevant is for the coredump with
the -E option. But it only uses the path when generating the coredump
pattern and if that's a security issue than your poc shows that this can
already be achieved today.

Christian

> 
> [1]: f606b77f1a9e ("prctl: PR_SET_MM -- introduce PR_SET_MM_MAP operation")
> [2]: 4d28df6152aa ("prctl: Allow local CAP_SYS_ADMIN changing exe_file")
> [3]: https://lore.kernel.org/patchwork/patch/697304/

[4]: https://lore.kernel.org/lkml/20140703151102.842945837@openvz.org/ 
[5]: https://lore.kernel.org/lkml/CAGXu5jL3exT4j+8rjMv1O54uJWQ5UHL69Z-24b61rhXROqZamQ@mail.gmail.com/
[6]: https://lore.kernel.org/lkml/20140722203614.GF838@moon/
