Return-Path: <linux-fsdevel+bounces-48627-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C1B3AB1926
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 17:46:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43835525AFE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 15:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A80230269;
	Fri,  9 May 2025 15:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="RYgdbCHf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9F722FE02
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 May 2025 15:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746805596; cv=none; b=VAWuHQ29xT69PaPMTKsvlL81gQXAqvgywlOObORY9xZOCPmC7fWFz/VtJupNQceW7fJ8UdH9+STX4oMjx9NHhH5MHSAkRWapoPRE7SRBzxdoTC7ol3FtqK3qnTUyxCc0XQ18SY8+MUW042p8FRR9xhd9oO+12kWPcsEtHhVpKGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746805596; c=relaxed/simple;
	bh=DeBCrTmdTR5yKShLY0vZqCOTCX0K9ctcUoU2nBe6LVA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nrklyFrt/ZkVGeJLwIsTYnRbT5r4m/uW57XBWI5tiY2elHfI9tt9lZFXvNzwkv1/QYnUvgz+QLrraYlcKSgFsP99L6k/4J76hFR3Mu75NcQGKL+he5ZsMllPA/oJFIvyOW9qLcsJW5cT7cMZNkHrKglgYlGoVISHZ+mBrmjWIoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=RYgdbCHf; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-54998f865b8so2494071e87.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 May 2025 08:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1746805593; x=1747410393; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9xNbDuhYMNEOPQ0iDaGg7WmsIQAL98DsMilo3FOILHE=;
        b=RYgdbCHfoSKZLpdRCIWD/iPlUS9k46KL5BNo5lmTXtbn7IaDHnKqc50vvx/xBcKQzm
         /JlDDMmg5gmbeYurfPcGQ5tibFSr7uRtrFIfXqbSfv8PP5Jm5UkwkvrRlPC+xCyIBU2z
         mKPZgn+F80bC4/FqDYh50m47qBFef+DUY2FLc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746805593; x=1747410393;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9xNbDuhYMNEOPQ0iDaGg7WmsIQAL98DsMilo3FOILHE=;
        b=RPtvrhLxSiY9865hmqGAcu58IyKYeS9Zh8IKaLZSQHrivSCbD+Mc8KenNpFQwJI34b
         eEX8VpciMsOZ5uoeL4LdCd4t0A5/ewa3lnXXd5i4R+bXWAVxFyaM32Zr+ZXB2ibsYiSq
         nYi/iTyOZOZH4EmhvFbuzSL1QcbEIMCXlbp6OrWuMvwMtNflXo5YHDg22gzYlQ097LPV
         9ix1fBEBtVSfgfbouhpZ2yiDSKOj6Xs0D/1r7qENB/q3Luses9+WSgORurbdWcrUE1P8
         Bx3SibZfrsPiu4EcGvKrWX7G3xPL7nfgjMR0jE7qfGaQtsFflLKXSU069kgpwNDC87dh
         +WwA==
X-Gm-Message-State: AOJu0YwPvrmskbH1SblU5YhvI2pGPVO6hkeVte8NPtUJ7NAJi4tuxsOB
	ryLsi5l4P7SW/3UhhfdMEeFJ53KFCM5niXR6hFrzAgfaeVoNTKFZ541Xb2NLtyMFtSBOxeXA1/o
	lCG85wGxjrLTCh2r1DFxw+mRS3/16UZwbmfc6tg==
X-Gm-Gg: ASbGnctD8rAy2yqU8QlNJW7JftEJ76ucIAgCPIb2RV9zCKGZox9LM2QhZgQZpPS09rQ
	QaDxheofaZwxxF2SOcOOqw74zA9R1lTBwLmktgD98bp4qm+ov18ORefYGvHTeTPl3beEKmxluT5
	B9PTrDRrAwEDeSWE+aqPL+6XA=
X-Google-Smtp-Source: AGHT+IHoJp8wBzITN88S1HfrprVuyMRPvWzwS4HbJbfLM7QXMEGjXdAedeYOhNSQ8zXWIJlwtoij1I0pkOJyZ9tEoRk=
X-Received: by 2002:a05:651c:210a:b0:30c:aae:6d4a with SMTP id
 38308e7fff4ca-326c4627d80mr18504001fa.26.1746805592184; Fri, 09 May 2025
 08:46:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250509-work-coredump-socket-v5-0-23c5b14df1bc@kernel.org> <20250509-work-coredump-socket-v5-1-23c5b14df1bc@kernel.org>
In-Reply-To: <20250509-work-coredump-socket-v5-1-23c5b14df1bc@kernel.org>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Fri, 9 May 2025 17:46:21 +0200
X-Gm-Features: AX0GCFuTWF2y33BQszs3BPl-6caIW4wVI9SlZUstCcjjk5CXp49SmJp1kj1c_ao
Message-ID: <CAJqdLrqCkkA=TcEU0Oo5w=6Xrp=y1VepGZncBC4yKRU1hv2iDg@mail.gmail.com>
Subject: Re: [PATCH v5 1/9] coredump: massage format_corname()
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Eric Dumazet <edumazet@google.com>, Oleg Nesterov <oleg@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, David Rheinsberg <david@readahead.eu>, 
	Jakub Kicinski <kuba@kernel.org>, Jan Kara <jack@suse.cz>, 
	Lennart Poettering <lennart@poettering.net>, Luca Boccassi <bluca@debian.org>, Mike Yuan <me@yhndnzj.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	=?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Christian!

Am Fr., 9. Mai 2025 um 12:25 Uhr schrieb Christian Brauner <brauner@kernel.org>:
>
> We're going to extend the coredump code in follow-up patches.
> Clean it up so we can do this more easily.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  fs/coredump.c | 41 ++++++++++++++++++++++++-----------------
>  1 file changed, 24 insertions(+), 17 deletions(-)
>
> diff --git a/fs/coredump.c b/fs/coredump.c
> index d740a0411266..281320ea351f 100644
> --- a/fs/coredump.c
> +++ b/fs/coredump.c
> @@ -76,9 +76,15 @@ static char core_pattern[CORENAME_MAX_SIZE] = "core";
>  static int core_name_size = CORENAME_MAX_SIZE;
>  unsigned int core_file_note_size_limit = CORE_FILE_NOTE_SIZE_DEFAULT;
>
> +enum coredump_type_t {
> +       COREDUMP_FILE = 1,
> +       COREDUMP_PIPE = 2,
> +};
> +
>  struct core_name {
>         char *corename;
>         int used, size;
> +       enum coredump_type_t core_type;
>  };
>
>  static int expand_corename(struct core_name *cn, int size)
> @@ -218,18 +224,21 @@ static int format_corename(struct core_name *cn, struct coredump_params *cprm,
>  {
>         const struct cred *cred = current_cred();
>         const char *pat_ptr = core_pattern;
> -       int ispipe = (*pat_ptr == '|');
>         bool was_space = false;
>         int pid_in_pattern = 0;
>         int err = 0;
>
>         cn->used = 0;
>         cn->corename = NULL;
> +       if (*pat_ptr == '|')
> +               cn->core_type = COREDUMP_PIPE;
> +       else
> +               cn->core_type = COREDUMP_FILE;
>         if (expand_corename(cn, core_name_size))
>                 return -ENOMEM;
>         cn->corename[0] = '\0';
>
> -       if (ispipe) {
> +       if (cn->core_type == COREDUMP_PIPE) {
>                 int argvs = sizeof(core_pattern) / 2;
>                 (*argv) = kmalloc_array(argvs, sizeof(**argv), GFP_KERNEL);
>                 if (!(*argv))
> @@ -247,7 +256,7 @@ static int format_corename(struct core_name *cn, struct coredump_params *cprm,
>                  * Split on spaces before doing template expansion so that
>                  * %e and %E don't get split if they have spaces in them
>                  */
> -               if (ispipe) {
> +               if (cn->core_type == COREDUMP_PIPE) {
>                         if (isspace(*pat_ptr)) {
>                                 if (cn->used != 0)
>                                         was_space = true;
> @@ -353,7 +362,7 @@ static int format_corename(struct core_name *cn, struct coredump_params *cprm,
>                                  * Installing a pidfd only makes sense if
>                                  * we actually spawn a usermode helper.
>                                  */
> -                               if (!ispipe)
> +                               if (!(cn->core_type != COREDUMP_PIPE))

Shouldn't it be:
if (cn->core_type != COREDUMP_PIPE)

Except this, LGTM

Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>

>                                         break;
>
>                                 /*
> @@ -384,12 +393,12 @@ static int format_corename(struct core_name *cn, struct coredump_params *cprm,
>          * If core_pattern does not include a %p (as is the default)
>          * and core_uses_pid is set, then .%pid will be appended to
>          * the filename. Do not do this for piped commands. */
> -       if (!ispipe && !pid_in_pattern && core_uses_pid) {
> +       if (!(cn->core_type == COREDUMP_PIPE) && !pid_in_pattern && core_uses_pid) {
>                 err = cn_printf(cn, ".%d", task_tgid_vnr(current));
>                 if (err)
>                         return err;
>         }
> -       return ispipe;
> +       return 0;
>  }
>
>  static int zap_process(struct signal_struct *signal, int exit_code)
> @@ -583,7 +592,6 @@ void do_coredump(const kernel_siginfo_t *siginfo)
>         const struct cred *old_cred;
>         struct cred *cred;
>         int retval = 0;
> -       int ispipe;
>         size_t *argv = NULL;
>         int argc = 0;
>         /* require nonrelative corefile path and be extra careful */
> @@ -632,19 +640,18 @@ void do_coredump(const kernel_siginfo_t *siginfo)
>
>         old_cred = override_creds(cred);
>
> -       ispipe = format_corename(&cn, &cprm, &argv, &argc);
> +       retval = format_corename(&cn, &cprm, &argv, &argc);
> +       if (retval < 0) {
> +               coredump_report_failure("format_corename failed, aborting core");
> +               goto fail_unlock;
> +       }
>
> -       if (ispipe) {
> +       if (cn.core_type == COREDUMP_PIPE) {
>                 int argi;
>                 int dump_count;
>                 char **helper_argv;
>                 struct subprocess_info *sub_info;
>
> -               if (ispipe < 0) {
> -                       coredump_report_failure("format_corename failed, aborting core");
> -                       goto fail_unlock;
> -               }
> -
>                 if (cprm.limit == 1) {
>                         /* See umh_coredump_setup() which sets RLIMIT_CORE = 1.
>                          *
> @@ -695,7 +702,7 @@ void do_coredump(const kernel_siginfo_t *siginfo)
>                         coredump_report_failure("|%s pipe failed", cn.corename);
>                         goto close_fail;
>                 }
> -       } else {
> +       } else if (cn.core_type == COREDUMP_FILE) {
>                 struct mnt_idmap *idmap;
>                 struct inode *inode;
>                 int open_flags = O_CREAT | O_WRONLY | O_NOFOLLOW |
> @@ -823,13 +830,13 @@ void do_coredump(const kernel_siginfo_t *siginfo)
>                 file_end_write(cprm.file);
>                 free_vma_snapshot(&cprm);
>         }
> -       if (ispipe && core_pipe_limit)
> +       if ((cn.core_type == COREDUMP_PIPE) && core_pipe_limit)
>                 wait_for_dump_helpers(cprm.file);
>  close_fail:
>         if (cprm.file)
>                 filp_close(cprm.file, NULL);
>  fail_dropcount:
> -       if (ispipe)
> +       if (cn.core_type == COREDUMP_PIPE)
>                 atomic_dec(&core_dump_count);
>  fail_unlock:
>         kfree(argv);
>
> --
> 2.47.2
>

