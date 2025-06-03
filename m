Return-Path: <linux-fsdevel+bounces-50480-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30FBDACC862
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 15:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0989174BB9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 13:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89DFC26290;
	Tue,  3 Jun 2025 13:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b="Mh94UmcA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E669523815B
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Jun 2025 13:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748958614; cv=none; b=eqOmCGBH9C2sQ2GwvukY+/j2PzeMEOnVQYahJEPKH7yfI8Bk3KtB7pO/qtAQL+2EaQQngPSE41vRu8RB3jJ3Ol+eclLNQ/E632tQbZZr1GtyIRDKLuA24STfuRRAlaWH41rnenKI92S7IHtuDg5UIceOwieete7oBJoCwCPEnGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748958614; c=relaxed/simple;
	bh=EIG67Kzypl1whW5y8canogYDLSXqErUE2HMOIdrrj/M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HT/e3uKwFwh0zXKsoUuQekQHDGNC3S+KpCEEImycAGLR53KeBL8SzYmpUm829QOyAFO6rRX2MBzc31ZDAyw2DNpFA/XZBOgWYXvNaMnaIgHmbb3WDbVhcjFGuS+TQSWwYtWQnj8QA0kPPhekhaZiGavqobTSz2gGE8lJVV6hkow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com; spf=pass smtp.mailfrom=mihalicyn.com; dkim=pass (1024-bit key) header.d=mihalicyn.com header.i=@mihalicyn.com header.b=Mh94UmcA; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mihalicyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mihalicyn.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-32925727810so50303441fa.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Jun 2025 06:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mihalicyn.com; s=mihalicyn; t=1748958610; x=1749563410; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xunPP5P6YatM3ODm/67UzZIIEcbZDSh6RIO6FNMLyWk=;
        b=Mh94UmcABkfmmCK4JeiNF7nYB7b8IcDn7ePpMnxCz2VXRnxA9AH0OgAXYnnZx4EgVX
         S+huqkaNZZvapNNDcWgJP3pLzvcqGg7lE5+nyv2M6oobXMRfPIKM2g9pLWRWpg/m7dFX
         CQypa47veIIrJORNK1r5zRzZInvt8cEnqRzb0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748958610; x=1749563410;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xunPP5P6YatM3ODm/67UzZIIEcbZDSh6RIO6FNMLyWk=;
        b=hcTXv5xhOx34nYtmSQHRzbtnuEd8Tzs9qwOJ7hRqinq55LBNaAmom8ciEqLaRnZgMe
         diYgTjYr8lT45MLwsaUjUfi68+T8gn23DkbU8QXMMvVKy7PoivAKRXwdZFPC0NrYhjo8
         YKtUiZlIrB8SaltKZFxxur3rBkgf9voIzovnQpwGiZCXmcQlQue+bX7aVq0ebu7IVk10
         yLRs5MfD3R3WQYwq++2Un/g44FRvnqVB6W+YwU4sUw2/5ShKDOnrR+OlD2mHMmYothPX
         4fKFo9IhgNVgodxTrHNgIg8JyoIp8FNuJ6mP6tAshm9yAOBYHf/mqoMyqh5nKupjUpiv
         hrVQ==
X-Gm-Message-State: AOJu0YzrWRMMhh7Moe+90lkvGvK3smqG+P82nwth3V2I4db53dePsybO
	17RVHpn+g84Hg5MKyP/GPzePg3RULicHsUOiCHZ5dvmpNXGMYYauDOHCzVJ0n1pYapUMFhoo6Up
	n86Bdu8bjQrfR0vWKJbgXVSxDbJ0UmGzmEcMu5oZb/A==
X-Gm-Gg: ASbGnctMO5eA99r43H47D+F4hSCfyuER+K6dAHi7GHkPLIedTI61CD0qS6OGNlIToIs
	PUeD+u/BIPoVrdOtFegoPIy1E8gcU+ToCbcuIifiQPL2p3/FzvXFOdst3gcMrYS/9QzmtcGM74K
	eoP78S3vUnZp1enjrDVOGEb87f48u5B/w6pw==
X-Google-Smtp-Source: AGHT+IElVlLoYhlh+gDEfajOQQ44owM7qXy3oyFXcZH7BJXkYj+o6LcQJnJ9x2evybUmuO9Mpv+Ur0d8FwnUYVTHqgo=
X-Received: by 2002:a05:651c:b2c:b0:30c:2efb:6608 with SMTP id
 38308e7fff4ca-32a8ce49842mr57233971fa.34.1748958609472; Tue, 03 Jun 2025
 06:50:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250603-work-coredump-socket-protocol-v2-0-05a5f0c18ecc@kernel.org>
 <20250603-work-coredump-socket-protocol-v2-1-05a5f0c18ecc@kernel.org>
In-Reply-To: <20250603-work-coredump-socket-protocol-v2-1-05a5f0c18ecc@kernel.org>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Tue, 3 Jun 2025 15:49:58 +0200
X-Gm-Features: AX0GCFuL6RL_ia-sEEGW7p2cvMFfTKbyaulY44HuZkIf4Nq2wvn6LTYqzPEpyd8
Message-ID: <CAJqdLrrB8bETfo0dTA5zwHMxo+0LfVR43fpbjkuyqrb8xvEskQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] coredump: allow for flexible coredump handling
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>, 
	Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Daan De Meyer <daan.j.demeyer@gmail.com>, 
	Jan Kara <jack@suse.cz>, Lennart Poettering <lennart@poettering.net>, Mike Yuan <me@yhndnzj.com>, 
	=?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>
Content-Type: text/plain; charset="UTF-8"

Am Di., 3. Juni 2025 um 15:32 Uhr schrieb Christian Brauner
<brauner@kernel.org>:
>
> Extend the coredump socket to allow the coredump server to tell the
> kernel how to process individual coredumps.
>
> When the crashing task connects to the coredump socket the kernel will
> send a struct coredump_req to the coredump server. The kernel will set
> the size member of struct coredump_req allowing the coredump server how
> much data can be read.
>
> The coredump server uses MSG_PEEK to peek the size of struct
> coredump_req. If the kernel uses a newer struct coredump_req the
> coredump server just reads the size it knows and discard any remaining
> bytes in the buffer. If the kernel uses an older struct coredump_req
> the coredump server just reads the size the kernel knows.
>
> The returned struct coredump_req will inform the coredump server what
> features the kernel supports. The coredump_req->mask member is set to
> the currently know features.
>
> The coredump server may only use features whose bits were raised by the
> kernel in coredump_req->mask.
>
> In response to a coredump_req from the kernel the coredump server sends
> a struct coredump_ack to the kernel. The kernel informs the coredump
> server what version of struct coredump_ack it supports by setting struct
> coredump_req->size_ack to the size it knows about. The coredump server
> may only send as many bytes as coredump_req->size_ack indicates (a
> smaller size is fine of course). The coredump server must set
> coredump_ack->size accordingly.
>
> The coredump server sets the features it wants to use in struct
> coredump_ack->mask. Only bits returned in struct coredump_req->mask may
> be used.
>
> In case an invalid struct coredump_ack is sent to the kernel an
> out-of-band byte will be sent by the kernel indicating the reason why
> the coredump_ack was rejected.
>
> The out-of-band markers allow advanced userspace to infer failure. They
> are optional and can be ignored by not listening for POLLPRI events and
> aren't necessary for the coredump server to function correctly.
>
> In the initial version the following features are supported in
> coredump_{req,ack}->mask:
>
> * COREDUMP_KERNEL
>   The kernel will write the coredump data to the socket.
>
> * COREDUMP_USERSPACE
>   The kernel will not write coredump data but will indicate to the
>   parent that a coredump has been generated. This is used when userspace
>   generates its own coredumps.
>
> * COREDUMP_REJECT
>   The kernel will skip generating a coredump for this task.
>
> * COREDUMP_WAIT
>   The kernel will prevent the task from exiting until the coredump
>   server has shutdown the socket connection.
>
> The flexible coredump socket can be enabled by using the "@@" prefix
> instead of the single "@" prefix for the regular coredump socket:
>
>   @@/run/systemd/coredump.socket
>
> will enable flexible coredump handling. Current kernels already enforce
> that "@" must be followed by "/" and will reject anything else. So
> extending this is backward and forward compatible.
>
> Signed-off-by: Christian Brauner <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>

> ---
>  fs/coredump.c                 | 130 +++++++++++++++++++++++++++++++++++++++---
>  include/uapi/linux/coredump.h | 104 +++++++++++++++++++++++++++++++++
>  2 files changed, 227 insertions(+), 7 deletions(-)
>
> diff --git a/fs/coredump.c b/fs/coredump.c
> index f217ebf2b3b6..e79f37d3eefb 100644
> --- a/fs/coredump.c
> +++ b/fs/coredump.c
> @@ -51,6 +51,7 @@
>  #include <net/sock.h>
>  #include <uapi/linux/pidfd.h>
>  #include <uapi/linux/un.h>
> +#include <uapi/linux/coredump.h>
>
>  #include <linux/uaccess.h>
>  #include <asm/mmu_context.h>
> @@ -83,15 +84,17 @@ static int core_name_size = CORENAME_MAX_SIZE;
>  unsigned int core_file_note_size_limit = CORE_FILE_NOTE_SIZE_DEFAULT;
>
>  enum coredump_type_t {
> -       COREDUMP_FILE = 1,
> -       COREDUMP_PIPE = 2,
> -       COREDUMP_SOCK = 3,
> +       COREDUMP_FILE           = 1,
> +       COREDUMP_PIPE           = 2,
> +       COREDUMP_SOCK           = 3,
> +       COREDUMP_SOCK_REQ       = 4,
>  };
>
>  struct core_name {
>         char *corename;
>         int used, size;
>         enum coredump_type_t core_type;
> +       u64 mask;
>  };
>
>  static int expand_corename(struct core_name *cn, int size)
> @@ -235,6 +238,9 @@ static int format_corename(struct core_name *cn, struct coredump_params *cprm,
>         int pid_in_pattern = 0;
>         int err = 0;
>
> +       cn->mask = COREDUMP_KERNEL;
> +       if (core_pipe_limit)
> +               cn->mask |= COREDUMP_WAIT;
>         cn->used = 0;
>         cn->corename = NULL;
>         if (*pat_ptr == '|')
> @@ -264,6 +270,13 @@ static int format_corename(struct core_name *cn, struct coredump_params *cprm,
>                 pat_ptr++;
>                 if (!(*pat_ptr))
>                         return -ENOMEM;
> +               if (*pat_ptr == '@') {
> +                       pat_ptr++;
> +                       if (!(*pat_ptr))
> +                               return -ENOMEM;
> +
> +                       cn->core_type = COREDUMP_SOCK_REQ;
> +               }
>
>                 err = cn_printf(cn, "%s", pat_ptr);
>                 if (err)
> @@ -632,6 +645,93 @@ static int umh_coredump_setup(struct subprocess_info *info, struct cred *new)
>         return 0;
>  }
>
> +#ifdef CONFIG_UNIX
> +static inline bool coredump_sock_recv(struct file *file, struct coredump_ack *ack, size_t size, int flags)
> +{
> +       struct msghdr msg = {};
> +       struct kvec iov = { .iov_base = ack, .iov_len = size };
> +       ssize_t ret;
> +
> +       memset(ack, 0, size);
> +       ret = kernel_recvmsg(sock_from_file(file), &msg, &iov, 1, size, flags);
> +       return ret == size;
> +}
> +
> +static inline bool coredump_sock_send(struct file *file, struct coredump_req *req)
> +{
> +       struct msghdr msg = { .msg_flags = MSG_NOSIGNAL };
> +       struct kvec iov = { .iov_base = req, .iov_len = sizeof(*req) };
> +       ssize_t ret;
> +
> +       ret = kernel_sendmsg(sock_from_file(file), &msg, &iov, 1, sizeof(*req));
> +       return ret == sizeof(*req);
> +}
> +
> +static_assert(sizeof(enum coredump_oob) == sizeof(__u8));
> +
> +static inline bool coredump_sock_oob(struct file *file, enum coredump_oob oob)
> +{
> +#ifdef CONFIG_AF_UNIX_OOB
> +       struct msghdr msg = { .msg_flags = MSG_NOSIGNAL | MSG_OOB };
> +       struct kvec iov = { .iov_base = &oob, .iov_len = sizeof(oob) };
> +
> +       kernel_sendmsg(sock_from_file(file), &msg, &iov, 1, sizeof(oob));
> +#endif
> +       coredump_report_failure("Coredump socket ack failed %u", oob);
> +       return false;
> +}
> +
> +static bool coredump_request(struct core_name *cn, struct coredump_params *cprm)
> +{
> +       struct coredump_req req = {
> +               .size           = sizeof(struct coredump_req),
> +               .mask           = COREDUMP_KERNEL | COREDUMP_USERSPACE |
> +                                 COREDUMP_REJECT | COREDUMP_WAIT,
> +               .size_ack       = sizeof(struct coredump_ack),
> +       };
> +       struct coredump_ack ack = {};
> +       ssize_t usize;
> +
> +       if (cn->core_type != COREDUMP_SOCK_REQ)
> +               return true;
> +
> +       /* Let userspace know what we support. */
> +       if (!coredump_sock_send(cprm->file, &req))
> +               return false;
> +
> +       /* Peek the size of the coredump_ack. */
> +       if (!coredump_sock_recv(cprm->file, &ack, sizeof(ack.size),
> +                               MSG_PEEK | MSG_WAITALL))
> +               return false;
> +
> +       /* Refuse unknown coredump_ack sizes. */
> +       usize = ack.size;
> +       if (usize < COREDUMP_ACK_SIZE_VER0 || usize > sizeof(ack))
> +               return coredump_sock_oob(cprm->file, COREDUMP_OOB_INVALIDSIZE);
> +
> +       /* Now retrieve the coredump_ack. */
> +       if (!coredump_sock_recv(cprm->file, &ack, usize, MSG_WAITALL))
> +               return false;
> +       if (ack.size != usize)
> +               return false;
> +
> +       /* Refuse unknown coredump_ack flags. */
> +       if (ack.mask & ~req.mask)
> +               return coredump_sock_oob(cprm->file, COREDUMP_OOB_UNSUPPORTED);
> +
> +       /* Refuse mutually exclusive options. */
> +       if (hweight64(ack.mask & (COREDUMP_USERSPACE | COREDUMP_KERNEL |
> +                                 COREDUMP_REJECT)) != 1)
> +               return coredump_sock_oob(cprm->file, COREDUMP_OOB_CONFLICTING);
> +
> +       if (ack.spare)
> +               return coredump_sock_oob(cprm->file, COREDUMP_OOB_UNSUPPORTED);
> +
> +       cn->mask = ack.mask;
> +       return true;
> +}
> +#endif
> +
>  void do_coredump(const kernel_siginfo_t *siginfo)
>  {
>         struct core_state core_state;
> @@ -850,6 +950,8 @@ void do_coredump(const kernel_siginfo_t *siginfo)
>                 }
>                 break;
>         }
> +       case COREDUMP_SOCK_REQ:
> +               fallthrough;
>         case COREDUMP_SOCK: {
>  #ifdef CONFIG_UNIX
>                 struct file *file __free(fput) = NULL;
> @@ -918,6 +1020,9 @@ void do_coredump(const kernel_siginfo_t *siginfo)
>
>                 cprm.limit = RLIM_INFINITY;
>                 cprm.file = no_free_ptr(file);
> +
> +               if (!coredump_request(&cn, &cprm))
> +                       goto close_fail;
>  #else
>                 coredump_report_failure("Core dump socket support %s disabled", cn.corename);
>                 goto close_fail;
> @@ -929,12 +1034,17 @@ void do_coredump(const kernel_siginfo_t *siginfo)
>                 goto close_fail;
>         }
>
> +       /* Don't even generate the coredump. */
> +       if (cn.mask & COREDUMP_REJECT)
> +               goto close_fail;
> +
>         /* get us an unshared descriptor table; almost always a no-op */
>         /* The cell spufs coredump code reads the file descriptor tables */
>         retval = unshare_files();
>         if (retval)
>                 goto close_fail;
> -       if (!dump_interrupted()) {
> +
> +       if ((cn.mask & COREDUMP_KERNEL) && !dump_interrupted()) {
>                 /*
>                  * umh disabled with CONFIG_STATIC_USERMODEHELPER_PATH="" would
>                  * have this set to NULL.
> @@ -968,17 +1078,23 @@ void do_coredump(const kernel_siginfo_t *siginfo)
>                 kernel_sock_shutdown(sock_from_file(cprm.file), SHUT_WR);
>  #endif
>
> +       /* Let the parent know that a coredump was generated. */
> +       if (cn.mask & COREDUMP_USERSPACE)
> +               core_dumped = true;
> +
>         /*
>          * When core_pipe_limit is set we wait for the coredump server
>          * or usermodehelper to finish before exiting so it can e.g.,
>          * inspect /proc/<pid>.
>          */
> -       if (core_pipe_limit) {
> +       if (cn.mask & COREDUMP_WAIT) {
>                 switch (cn.core_type) {
>                 case COREDUMP_PIPE:
>                         wait_for_dump_helpers(cprm.file);
>                         break;
>  #ifdef CONFIG_UNIX
> +               case COREDUMP_SOCK_REQ:
> +                       fallthrough;
>                 case COREDUMP_SOCK: {
>                         ssize_t n;
>
> @@ -1249,8 +1365,8 @@ static inline bool check_coredump_socket(void)
>         if (current->nsproxy->mnt_ns != init_task.nsproxy->mnt_ns)
>                 return false;
>
> -       /* Must be an absolute path. */
> -       if (*(core_pattern + 1) != '/')
> +       /* Must be an absolute path or the socket request. */
> +       if (*(core_pattern + 1) != '/' && *(core_pattern + 1) != '@')
>                 return false;
>
>         return true;
> diff --git a/include/uapi/linux/coredump.h b/include/uapi/linux/coredump.h
> new file mode 100644
> index 000000000000..4fa7d1f9d062
> --- /dev/null
> +++ b/include/uapi/linux/coredump.h
> @@ -0,0 +1,104 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +
> +#ifndef _UAPI_LINUX_COREDUMP_H
> +#define _UAPI_LINUX_COREDUMP_H
> +
> +#include <linux/types.h>
> +
> +/**
> + * coredump_{req,ack} flags
> + * @COREDUMP_KERNEL: kernel writes coredump
> + * @COREDUMP_USERSPACE: userspace writes coredump
> + * @COREDUMP_REJECT: don't generate coredump
> + * @COREDUMP_WAIT: wait for coredump server
> + */
> +enum {
> +       COREDUMP_KERNEL         = (1ULL << 0),
> +       COREDUMP_USERSPACE      = (1ULL << 1),
> +       COREDUMP_REJECT         = (1ULL << 2),
> +       COREDUMP_WAIT           = (1ULL << 3),
> +};
> +
> +/**
> + * struct coredump_req - message kernel sends to userspace
> + * @size: size of struct coredump_req
> + * @size_ack: known size of struct coredump_ack on this kernel
> + * @mask: supported features
> + *
> + * When a coredump happens the kernel will connect to the coredump
> + * socket and send a coredump request to the coredump server. The @size
> + * member is set to the size of struct coredump_req and provides a hint
> + * to userspace how much data can be read. Userspace may use MSG_PEEK to
> + * peek the size of struct coredump_req and then choose to consume it in
> + * one go. Userspace may also simply read a COREDUMP_ACK_SIZE_VER0
> + * request. If the size the kernel sends is larger userspace simply
> + * discards any remaining data.
> + *
> + * The coredump_req->mask member is set to the currently know features.
> + * Userspace may only set coredump_ack->mask to the bits raised by the
> + * kernel in coredump_req->mask.
> + *
> + * The coredump_req->size_ack member is set by the kernel to the size of
> + * struct coredump_ack the kernel knows. Userspace may only send up to
> + * coredump_req->size_ack bytes to the kernel and must set
> + * coredump_ack->size accordingly.
> + */
> +struct coredump_req {
> +       __u32 size;
> +       __u32 size_ack;
> +       __u64 mask;
> +};
> +
> +enum {
> +       COREDUMP_REQ_SIZE_VER0 = 16U, /* size of first published struct */
> +};
> +
> +/**
> + * struct coredump_ack - message userspace sends to kernel
> + * @size: size of the struct
> + * @spare: unused
> + * @mask: features kernel is supposed to use
> + *
> + * The @size member must be set to the size of struct coredump_ack. It
> + * may never exceed what the kernel returned in coredump_req->size_ack
> + * but it may of course be smaller (>= COREDUMP_ACK_SIZE_VER0 and <=
> + * coredump_req->size_ack).
> + *
> + * The @mask member must be set to the features the coredump server
> + * wants the kernel to use. Only bits the kernel returned in
> + * coredump_req->mask may be set.
> + */
> +struct coredump_ack {
> +       __u32 size;
> +       __u32 spare;
> +       __u64 mask;
> +};
> +
> +enum {
> +       COREDUMP_ACK_SIZE_VER0 = 16U, /* size of first published struct */
> +};
> +
> +/**
> + * enum coredump_oob - Out-of-band markers for the coredump socket
> + *
> + * The kernel will place a single byte coredump_oob marker on the
> + * coredump socket. An interested coredump server can listen for POLLPRI
> + * and figure out why the provided coredump_ack was invalid.
> + *
> + * The out-of-band markers allow advanced userspace to infer more details
> + * about a coredump ack. They are optional and can be ignored. They
> + * aren't necessary for the coredump server to function correctly.
> + *
> + * @COREDUMP_OOB_INVALIDSIZE: the provided coredump_ack size was invalid
> + * @COREDUMP_OOB_UNSUPPORTED: the provided coredump_ack mask was invalid
> + * @COREDUMP_OOB_CONFLICTING: the provided coredump_ack mask has conflicting options
> + * @__COREDUMP_OOB_MAX: the maximum value for coredump_oob
> + */
> +enum coredump_oob {
> +       COREDUMP_OOB_INVALIDSIZE = 1U,
> +       COREDUMP_OOB_UNSUPPORTED = 2U,
> +       COREDUMP_OOB_CONFLICTING = 3U,
> +       __COREDUMP_OOB_MAX       = 255U,
> +} __attribute__ ((__packed__));
> +
> +#endif /* _UAPI_LINUX_COREDUMP_H */
>
> --
> 2.47.2
>

