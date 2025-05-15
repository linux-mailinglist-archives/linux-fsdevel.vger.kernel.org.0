Return-Path: <linux-fsdevel+bounces-49135-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE304AB87BA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 15:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6BFD3ABD98
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 13:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E41D13790B;
	Thu, 15 May 2025 13:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="ipLse8c/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E977370838
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 May 2025 13:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747315189; cv=none; b=pfzn7I7qLdTxBzq6M+czut/7w5Ktx+Hi04OucQdi5hrY1l87AOjuRlpMA3IhEGiaCutkc71ZWOG+tUX485fTBYXcpCxlAqj8H2h+XqDGgIS8Zc5HL7CWnkDgd+qgcQfQZwxA8+uMTRlYt3m4wUzXAhaoP07kTmFQ1gyhNkAJRKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747315189; c=relaxed/simple;
	bh=zdw58KYBsWdL9BjnNQJ46Sy3sZuoLDF6pEtcYu2REY4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hev1SxBKRTvruyfzZyWI4v25UWnzXKni3pEO5pq6qd3iC/UKhcK1WxZVLMCtTXCvSb0NFbpPioP9OoR40oFi8YShl74GUXCcv45RSoh6mAvNqBCR4qMMSHeUjpWmhJun/SSH674c/iuLi5NjoTzgpZGTn8JSALpsYnGi3EW9hoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=ipLse8c/; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5fff52493e0so576837a12.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 May 2025 06:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1747315186; x=1747919986; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=72YGls/wmZumucGNN0maR/XQvib0UmG7AVEkYhDNH34=;
        b=ipLse8c/RyqGZjtk57S+m0waJaS3VV5xM2hg09yArZA1S81si+GY9qLXmBJd6ZzMTm
         VY6KZi7D2z5yJEvnJhRdygGMlf+bMAuCrvF74/RWdipe46/Ahr3eVB9f0oV2VrcfMKe6
         PWD+nsoJTlfCjg4pQfHh7h4DS3c1cnLjL3ANg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747315186; x=1747919986;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=72YGls/wmZumucGNN0maR/XQvib0UmG7AVEkYhDNH34=;
        b=DntwyEZ1ShyyP4z9CFmpd60JbXbVWUlU8pmZt6tBYYDO9iUtBiYdlMbQ3Ja7HPoMLM
         FtHlLmJZtDV4l0u9eeLwlsuhTJQUsUqpqtJl+tRIJcAku1H7212OyuB1UrJwH2rzj44x
         v230mC/cjeBLx3A0eo3ziOV50IGVu3YendPpU7FSTdr3nIkcykXNpz6WD5dFfky4M5qC
         iJuN2lfTQtCWc8XnE112cIv7vI6Rj7SEO4ifZWSVo0Ut1NrQJW1LMBwnXpBLfAGQr7EO
         JwE9gQUahV4QbfOXhri3To1kQHAqdeye6DltB33w1tE4yo9GrIb0iJKvfLxDJEQ+1dQS
         8law==
X-Gm-Message-State: AOJu0YxjU4B5Y72Is6lX/k9rWg11eUbZVlDPBuMGdRVmXJYH3XpM1ofm
	JKqOcssw0EkyFvo/yTouFBzsTwAgnFbJI7jdYlfEIpnrkoe5xw3re85NOZfTwPnkgIjLofuYM1m
	0yV7IQWBSYD59eCCpJnC2sxYcXOxS+RF7csDWo1j15FYP+yN4Tkt2sYBW
X-Gm-Gg: ASbGncsowS2m8/ri0uOCZS92hmLaSa+9zEP4iK/kuHq6neNT3Hw4NXczO50Mw9Re4/Y
	4vO5cutXMLpqPCtnwh+0R0zpPyHp7JVuYIV3nkItuMI9tucpYLPGtN3yso9IEmJ81cZpEt/YEB6
	iHEh/7NhshqzCwa2wYuY3BCV5YAzUb8Q5Dhg==
X-Google-Smtp-Source: AGHT+IGNyWKiGAcDc21zS2n5oJ3Sv5jjJvor1bjNLonysQPufNFoL1blELIM8hkLoTTF1EMx4KAbwrCBiaYKUHi/YOU=
X-Received: by 2002:a05:6512:6403:b0:54b:ed9:2d00 with SMTP id
 2adb3069b0e04-550d5f97849mr2639384e87.2.1747315175318; Thu, 15 May 2025
 06:19:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250515-work-coredump-socket-v7-0-0a1329496c31@kernel.org> <20250515-work-coredump-socket-v7-1-0a1329496c31@kernel.org>
In-Reply-To: <20250515-work-coredump-socket-v7-1-0a1329496c31@kernel.org>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Thu, 15 May 2025 15:19:23 +0200
X-Gm-Features: AX0GCFuQ_HXhhcRwS2YBk813kZ6rMjXII-JyogoSIhCBQ_Aa68UbV4_Ng2TdrMw
Message-ID: <CAJqdLrq5n28zKPFnXdVRtzQn7Mb0tmvrNf_NRRUWNPukRP5z3g@mail.gmail.com>
Subject: Re: [PATCH v7 1/9] coredump: massage format_corname()
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

Am Do., 15. Mai 2025 um 00:04 Uhr schrieb Christian Brauner
<brauner@kernel.org>:
>
> We're going to extend the coredump code in follow-up patches.
> Clean it up so we can do this more easily.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>

> ---
>  fs/coredump.c | 41 ++++++++++++++++++++++++-----------------
>  1 file changed, 24 insertions(+), 17 deletions(-)
>
> diff --git a/fs/coredump.c b/fs/coredump.c
> index d740a0411266..368751d98781 100644
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
> +                               if (cn->core_type != COREDUMP_PIPE)
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

