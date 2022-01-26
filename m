Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9C0E49D3E7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jan 2022 21:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbiAZU5E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jan 2022 15:57:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231379AbiAZU4z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jan 2022 15:56:55 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3928C06173B
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jan 2022 12:56:54 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id n32so751812pfv.11
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jan 2022 12:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9ZwIq4eguK8bjpndwvt9UIq9IEoCw/zcQla69AcmA50=;
        b=RQ10Tio1poE3AXTsW5p/YVJVY6U709VCN2+mvYw90Av7V1glFMm+9ySOSOJPS8QbIv
         YxUWXGj1mt1MoTLmtvZcBu7fq2jDfS8B9rSc5FMa9DqetFRTDEpRP3Wl5o8yGhJhQa94
         CQ3s4tCQ+qe23rOYnJj14TsbpOsX/g55l+AII=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9ZwIq4eguK8bjpndwvt9UIq9IEoCw/zcQla69AcmA50=;
        b=UAEN3C4v2/9turMOT3EErAD9fSW9YzKnXwYDkeLESiyg7Z+HAs6I8wtNpTIohDBBAt
         dAxD1x0mFXwTHEzw09+4RZfn24Q9wQSu+AkHe1TRNAPTAhxgW74+K2FkBecn/2kKsBxG
         Y0qMdybYoLGVTqClLFIRMV7bbiJ2zw9yEN0Vn69Ffv8328zf1JxPgkWAtXhqIZm66g8a
         3f5kMt44YJ6K0hoRKau1/y3J2CLBamcdM2OdmVbNWKCuiJriruhTDkiyYibkFjfq7PJb
         fggu1wHtr/s9fo4MM/+uNjRyqB2KMg6rvU4I+MpPGn+bHTUedEdHmSX4XbOrnruMGja0
         eErA==
X-Gm-Message-State: AOAM531MMrhFDEQSybGChBAqpynuFPrR8/67C+1w7UzlZNxOogZzJbv/
        7w5xriwGEJWfpH55y/19qmsEug==
X-Google-Smtp-Source: ABdhPJzrbvvBPSry0l58yYYNwOMPr0OGtfx9yO0cujWD32y6i9dDGbqlr2UF6MjyaoPG9r6ijn4UIg==
X-Received: by 2002:a05:6a00:b91:: with SMTP id g17mr110228pfj.27.1643230614317;
        Wed, 26 Jan 2022 12:56:54 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c20sm2826072pfn.190.2022.01.26.12.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 12:56:54 -0800 (PST)
Date:   Wed, 26 Jan 2022 12:56:53 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Ariadne Conill <ariadne@dereferenced.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Eric Biederman <ebiederm@xmission.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v2] fs/exec: require argv[0] presence in
 do_execveat_common()
Message-ID: <202201261239.CB5D7C991A@keescook>
References: <20220126114447.25776-1-ariadne@dereferenced.org>
 <202201261202.EC027EB@keescook>
 <a8fef39-27bf-b25f-7cfe-21782a8d3132@dereferenced.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8fef39-27bf-b25f-7cfe-21782a8d3132@dereferenced.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 26, 2022 at 02:23:59PM -0600, Ariadne Conill wrote:
> Hi,
> 
> On Wed, 26 Jan 2022, Kees Cook wrote:
> 
> > On Wed, Jan 26, 2022 at 11:44:47AM +0000, Ariadne Conill wrote:
> > > In several other operating systems, it is a hard requirement that the
> > > first argument to execve(2) be the name of a program, thus prohibiting
> > > a scenario where argc < 1.  POSIX 2017 also recommends this behaviour,
> > > but it is not an explicit requirement[0]:
> > > 
> > >     The argument arg0 should point to a filename string that is
> > >     associated with the process being started by one of the exec
> > >     functions.
> > > 
> > > To ensure that execve(2) with argc < 1 is not a useful gadget for
> > > shellcode to use, we can validate this in do_execveat_common() and
> > > fail for this scenario, effectively blocking successful exploitation
> > > of CVE-2021-4034 and similar bugs which depend on this gadget.
> > > 
> > > The use of -EFAULT for this case is similar to other systems, such
> > > as FreeBSD, OpenBSD and Solaris.  QNX uses -EINVAL for this case.
> > > 
> > > Interestingly, Michael Kerrisk opened an issue about this in 2008[1],
> > > but there was no consensus to support fixing this issue then.
> > > Hopefully now that CVE-2021-4034 shows practical exploitative use
> > > of this bug in a shellcode, we can reconsider.
> > > 
> > > [0]: https://pubs.opengroup.org/onlinepubs/9699919799/functions/exec.html
> > > [1]: https://bugzilla.kernel.org/show_bug.cgi?id=8408
> > > 
> > > Changes from v1:
> > > - Rework commit message significantly.
> > > - Make the argv[0] check explicit rather than hijacking the error-check
> > >   for count().
> > > 
> > > Signed-off-by: Ariadne Conill <ariadne@dereferenced.org>
> > > ---
> > >  fs/exec.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > > 
> > > diff --git a/fs/exec.c b/fs/exec.c
> > > index 79f2c9483302..e52c41991aab 100644
> > > --- a/fs/exec.c
> > > +++ b/fs/exec.c
> > > @@ -1899,6 +1899,10 @@ static int do_execveat_common(int fd, struct filename *filename,
> > >  	retval = count(argv, MAX_ARG_STRINGS);
> > >  	if (retval < 0)
> > >  		goto out_free;
> > > +	if (retval == 0) {
> > > +		retval = -EFAULT;
> > > +		goto out_free;
> > > +	}
> > >  	bprm->argc = retval;
> > > 
> > >  	retval = count(envp, MAX_ARG_STRINGS);
> > > --
> > > 2.34.1
> > 
> > Okay, so, the dangerous condition is userspace iterating through envp
> > when it thinks it's iterating argv.
> > 
> > Assuming it is not okay to break valgrind's test suite:
> > https://sources.debian.org/src/valgrind/1:3.18.1-1/none/tests/execve.c/?hl=22#L22
> > we cannot reject a NULL argv (test will fail), and we cannot mutate
> > argc=0 into argc=1 (test will enter infinite loop).
> > 
> > Perhaps we need to reject argv=NULL when envp!=NULL, and add a
> > pr_warn_once() about using a NULL argv?
> 
> Sure, I can rework the patch to do it for only the envp != NULL case.
> 
> I think we should combine it with the {NULL, NULL} padding patch in this
> case though, since it appears to work, that way the execve(..., NULL, NULL)
> case gets some protection.

I don't think the padding will actually work correctly, for the reason
Jann pointed out. My testing shows that suddenly my envp becomes NULL,
but libc is just counting argc to find envp to pass into main.

> > I note that glibc already warns about NULL argv:
> > argc0.c:7:3: warning: null argument where non-null required (argument 2)
> > [-Wnonnull]
> >    7 |   execve(argv[0], NULL, envp);
> >      |   ^~~~~~
> > 
> > in the future we could expand this to only looking at argv=NULL?
> 
> I don't think musl's headers generate a diagnostic for this, but main(0,
> {NULL}) is not a supported use-case at least as far as Alpine is concerned.
> I am sure it is the same with the other musl distributions.
> 
> Will send a v3 patch with this logic change and move to EINVAL shortly.

I took a spin too. Refuses execve(..., NULL, !NULL), injects "" argv[0]
for execve(..., NULL, NULL):


diff --git a/fs/exec.c b/fs/exec.c
index a098c133d8d7..0565089d5f9e 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1917,9 +1917,40 @@ static int do_execveat_common(int fd, struct filename *filename,
 	if (retval < 0)
 		goto out_free;
 
-	retval = copy_strings(bprm->argc, argv, bprm);
-	if (retval < 0)
-		goto out_free;
+	if (likely(bprm->argc > 0)) {
+		retval = copy_strings(bprm->argc, argv, bprm);
+		if (retval < 0)
+			goto out_free;
+	} else {
+		const char * const argv0 = "";
+
+		/*
+		 * Start making some noise about the argc == NULL case that
+		 * POSIX doesn't like and other Unix-like systems refuse.
+		 */
+		pr_warn_once("process '%s' used a NULL argv\n", bprm->filename);
+
+		/*
+		 * Refuse to execute when argc == 0 and envc > 0, since this
+		 * can lead to userspace iterating envp if it fails to check
+		 * for argc == 0.
+		 *
+		 * i.e. continue to allow: execve(path, NULL, NULL);
+		 */
+		if (bprm->envc > 0) {
+			retval = -EINVAL;
+			goto out_free;
+		}
+
+		/*
+		 * Force an argv of {"", NULL} if argc == 0 so that broken
+		 * userspace that assumes argc != 0 will not be surprised.
+		 */
+		bprm->argc = 1;
+		retval = copy_strings_kernel(bprm->argc, &argv0, bprm);
+		if (retval < 0)
+			goto out_free;
+	}
 
 	retval = bprm_execve(bprm, fd, filename, flags);
 out_free:


$ cat argc0.c
#include <stdio.h>
#include <unistd.h>

int main(int argc, char *argv[], char *envp[])
{
        if (argv[0][0] != '\0') {
                printf("execve(argv[0], NULL, envp);\n");
                execve(argv[0], NULL, envp);
                perror("execve");
                printf("execve(argv[0], NULL, NULL);\n");
                execve(argv[0], NULL, NULL);
                return 0;
        }
        printf("argc=%d\n", argc);
        printf("argv[0]%p=%s\n", &argv[0], argv[0]);
        printf("argv[1]%p=%s\n", &argv[1], argv[1]);
        printf("envp[0]%p=%s\n", &envp[0], envp[0]);
        return 0;
}

$ gcc -Wall argc0.c -o argc0
argc0.c: In function 'main':
argc0.c:8:3: warning: null argument where non-null required (argument 2) [-Wnonnull]
    8 |   execve(argv[0], NULL, envp);
      |   ^~~~~~
argc0.c:11:3: warning: null argument where non-null required (argument 2) [-Wnonnull]
   11 |   execve(argv[0], NULL, NULL);
      |   ^~~~~~

$ ./argc0
execve(argv[0], NULL, envp);
execve: Invalid argument
execve(argv[0], NULL, NULL);
argc=1
argv[0]0x7fff1f577bd8=
argv[1]0x7fff1f577be0=(null)
envp[0]0x7fff1f577be8=(null)

$ dmesg | tail -n1
[   20.748467] process './argc0' used a NULL argv


-- 
Kees Cook
