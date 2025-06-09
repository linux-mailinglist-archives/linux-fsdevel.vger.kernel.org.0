Return-Path: <linux-fsdevel+bounces-51032-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E286AD20B8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 16:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5057D1697C8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 14:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8131D25C83C;
	Mon,  9 Jun 2025 14:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="csEytVx3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE51137C2A
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Jun 2025 14:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749478620; cv=none; b=UjgmeNMXUGOyiQ1LYokyMLIBoMu8mgOCyyOq5aL8PJasT9flw2PurfnucBybGbztVRegOBCw3RCMQKvwdEk7Gzo+V7h8Ner5YULOuNoRyJ61IEVUU6M13B1GZ+ukr+Yv/2b1m1S9dAz1x/Y5OFeADg+XZydrtGAnD4+pLDWHv6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749478620; c=relaxed/simple;
	bh=q9IKG9OSknaGm/VRrHxllgcC+t508o6lCaTwhLiSc2g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bnR8mxHsrs6oXP6UUfIWTmMVqtS8ieQt47Fy6XVEJAt9sTnoumbnGqj7ADtvsldgRcf9Sq5/59BJPZ1Mg2qgYfgkk1ly/e+W49gWbzDUHBBu+IBs0y+tE7M0ygiOWgF/4Ne5EYxGnl73GA0XTNdVJe0MbCZF3q9/TnNse+OCF2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=csEytVx3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85A3AC4CEEB;
	Mon,  9 Jun 2025 14:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749478618;
	bh=q9IKG9OSknaGm/VRrHxllgcC+t508o6lCaTwhLiSc2g=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=csEytVx3+OV1jdhNH01ohTbkTXfjewyHe8bK9tEoX68ysDyGjouV8upUHOLV2m9RO
	 XgzfUKJDjq8uYnu2px55Ro99nP8hYDAx1bMdEhcR4JACnfi1d2ElADm/uP/8HoC7Q8
	 aff2XorNa0g1VnxVswBuPBEjccT0CqYMRmMoauT/VvlIoJO6ETWA0Q66+11rlLRmXI
	 CNp+I7uFot7PhLfQkZUuTBEgLHT4+IMC0uIMmjjAM/Hra19yjzTyRDFSSV/f1yPov6
	 Msq6rky2ecScLPgEI60RCNl2YauOe65Bi7US00aFpC4vTmnmql3Z6AK9d5QAG2npcL
	 uW7w3V+00QQ+w==
Message-ID: <beb4cecea02a0c595c432c431944106744d2926a.camel@kernel.org>
Subject: Re: [PATCH v2 1/5] coredump: allow for flexible coredump handling
From: Jeff Layton <jlayton@kernel.org>
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
 Jann Horn <jannh@google.com>
Cc: Josef Bacik <josef@toxicpanda.com>, Alexander Viro
 <viro@zeniv.linux.org.uk>,  Daan De Meyer <daan.j.demeyer@gmail.com>, Jan
 Kara <jack@suse.cz>, Lennart Poettering <lennart@poettering.net>,  Mike
 Yuan <me@yhndnzj.com>, Zbigniew =?UTF-8?Q?J=C4=99drzejewski-Szmek?=
 <zbyszek@in.waw.pl>,  Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Mon, 09 Jun 2025 10:16:56 -0400
In-Reply-To: <20250603-work-coredump-socket-protocol-v2-1-05a5f0c18ecc@kernel.org>
References: 
	<20250603-work-coredump-socket-protocol-v2-0-05a5f0c18ecc@kernel.org>
	 <20250603-work-coredump-socket-protocol-v2-1-05a5f0c18ecc@kernel.org>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-06-03 at 15:31 +0200, Christian Brauner wrote:
> Extend the coredump socket to allow the coredump server to tell the
> kernel how to process individual coredumps.
>=20
> When the crashing task connects to the coredump socket the kernel will
> send a struct coredump_req to the coredump server. The kernel will set
> the size member of struct coredump_req allowing the coredump server how
> much data can be read.
>=20
> The coredump server uses MSG_PEEK to peek the size of struct
> coredump_req. If the kernel uses a newer struct coredump_req the
> coredump server just reads the size it knows and discard any remaining
> bytes in the buffer. If the kernel uses an older struct coredump_req
> the coredump server just reads the size the kernel knows.
>=20
> The returned struct coredump_req will inform the coredump server what
> features the kernel supports. The coredump_req->mask member is set to
> the currently know features.
>=20
> The coredump server may only use features whose bits were raised by the
> kernel in coredump_req->mask.
>=20
> In response to a coredump_req from the kernel the coredump server sends
> a struct coredump_ack to the kernel. The kernel informs the coredump
> server what version of struct coredump_ack it supports by setting struct
> coredump_req->size_ack to the size it knows about. The coredump server
> may only send as many bytes as coredump_req->size_ack indicates (a
> smaller size is fine of course). The coredump server must set
> coredump_ack->size accordingly.
>=20
> The coredump server sets the features it wants to use in struct
> coredump_ack->mask. Only bits returned in struct coredump_req->mask may
> be used.
>=20
> In case an invalid struct coredump_ack is sent to the kernel an
> out-of-band byte will be sent by the kernel indicating the reason why
> the coredump_ack was rejected.
>=20
> The out-of-band markers allow advanced userspace to infer failure. They
> are optional and can be ignored by not listening for POLLPRI events and
> aren't necessary for the coredump server to function correctly.
>=20
> In the initial version the following features are supported in
> coredump_{req,ack}->mask:
>=20
> * COREDUMP_KERNEL
>   The kernel will write the coredump data to the socket.
>=20
> * COREDUMP_USERSPACE
>   The kernel will not write coredump data but will indicate to the
>   parent that a coredump has been generated. This is used when userspace
>   generates its own coredumps.
>=20
> * COREDUMP_REJECT
>   The kernel will skip generating a coredump for this task.
>=20
> * COREDUMP_WAIT
>   The kernel will prevent the task from exiting until the coredump
>   server has shutdown the socket connection.
>=20
> The flexible coredump socket can be enabled by using the "@@" prefix
> instead of the single "@" prefix for the regular coredump socket:
>=20
>   @@/run/systemd/coredump.socket
>=20
> will enable flexible coredump handling. Current kernels already enforce
> that "@" must be followed by "/" and will reject anything else. So
> extending this is backward and forward compatible.
>=20
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  fs/coredump.c                 | 130 ++++++++++++++++++++++++++++++++++++=
+++---
>  include/uapi/linux/coredump.h | 104 +++++++++++++++++++++++++++++++++
>  2 files changed, 227 insertions(+), 7 deletions(-)
>=20
> diff --git a/fs/coredump.c b/fs/coredump.c
> index f217ebf2b3b6..e79f37d3eefb 100644
> --- a/fs/coredump.c
> +++ b/fs/coredump.c
> @@ -51,6 +51,7 @@
>  #include <net/sock.h>
>  #include <uapi/linux/pidfd.h>
>  #include <uapi/linux/un.h>
> +#include <uapi/linux/coredump.h>
> =20
>  #include <linux/uaccess.h>
>  #include <asm/mmu_context.h>
> @@ -83,15 +84,17 @@ static int core_name_size =3D CORENAME_MAX_SIZE;
>  unsigned int core_file_note_size_limit =3D CORE_FILE_NOTE_SIZE_DEFAULT;
> =20
>  enum coredump_type_t {
> -	COREDUMP_FILE =3D 1,
> -	COREDUMP_PIPE =3D 2,
> -	COREDUMP_SOCK =3D 3,
> +	COREDUMP_FILE		=3D 1,
> +	COREDUMP_PIPE		=3D 2,
> +	COREDUMP_SOCK		=3D 3,
> +	COREDUMP_SOCK_REQ	=3D 4,
>  };
> =20
>  struct core_name {
>  	char *corename;
>  	int used, size;
>  	enum coredump_type_t core_type;
> +	u64 mask;
>  };
> =20
>  static int expand_corename(struct core_name *cn, int size)
> @@ -235,6 +238,9 @@ static int format_corename(struct core_name *cn, stru=
ct coredump_params *cprm,
>  	int pid_in_pattern =3D 0;
>  	int err =3D 0;
> =20
> +	cn->mask =3D COREDUMP_KERNEL;
> +	if (core_pipe_limit)
> +		cn->mask |=3D COREDUMP_WAIT;
>  	cn->used =3D 0;
>  	cn->corename =3D NULL;
>  	if (*pat_ptr =3D=3D '|')
> @@ -264,6 +270,13 @@ static int format_corename(struct core_name *cn, str=
uct coredump_params *cprm,
>  		pat_ptr++;
>  		if (!(*pat_ptr))
>  			return -ENOMEM;
> +		if (*pat_ptr =3D=3D '@') {
> +			pat_ptr++;
> +			if (!(*pat_ptr))
> +				return -ENOMEM;
> +
> +			cn->core_type =3D COREDUMP_SOCK_REQ;
> +		}
> =20
>  		err =3D cn_printf(cn, "%s", pat_ptr);
>  		if (err)
> @@ -632,6 +645,93 @@ static int umh_coredump_setup(struct subprocess_info=
 *info, struct cred *new)
>  	return 0;
>  }
> =20
> +#ifdef CONFIG_UNIX
> +static inline bool coredump_sock_recv(struct file *file, struct coredump=
_ack *ack, size_t size, int flags)
> +{
> +	struct msghdr msg =3D {};
> +	struct kvec iov =3D { .iov_base =3D ack, .iov_len =3D size };
> +	ssize_t ret;
> +
> +	memset(ack, 0, size);
> +	ret =3D kernel_recvmsg(sock_from_file(file), &msg, &iov, 1, size, flags=
);
> +	return ret =3D=3D size;
> +}
> +
> +static inline bool coredump_sock_send(struct file *file, struct coredump=
_req *req)
> +{
> +	struct msghdr msg =3D { .msg_flags =3D MSG_NOSIGNAL };
> +	struct kvec iov =3D { .iov_base =3D req, .iov_len =3D sizeof(*req) };
> +	ssize_t ret;
> +
> +	ret =3D kernel_sendmsg(sock_from_file(file), &msg, &iov, 1, sizeof(*req=
));
> +	return ret =3D=3D sizeof(*req);
> +}
> +
> +static_assert(sizeof(enum coredump_oob) =3D=3D sizeof(__u8));
> +
> +static inline bool coredump_sock_oob(struct file *file, enum coredump_oo=
b oob)
> +{
> +#ifdef CONFIG_AF_UNIX_OOB
> +	struct msghdr msg =3D { .msg_flags =3D MSG_NOSIGNAL | MSG_OOB };
> +	struct kvec iov =3D { .iov_base =3D &oob, .iov_len =3D sizeof(oob) };
> +
> +	kernel_sendmsg(sock_from_file(file), &msg, &iov, 1, sizeof(oob));
> +#endif
> +	coredump_report_failure("Coredump socket ack failed %u", oob);
> +	return false;
> +}
> +
> +static bool coredump_request(struct core_name *cn, struct coredump_param=
s *cprm)
> +{
> +	struct coredump_req req =3D {
> +		.size		=3D sizeof(struct coredump_req),
> +		.mask		=3D COREDUMP_KERNEL | COREDUMP_USERSPACE |
> +				  COREDUMP_REJECT | COREDUMP_WAIT,
> +		.size_ack	=3D sizeof(struct coredump_ack),
> +	};
> +	struct coredump_ack ack =3D {};
> +	ssize_t usize;
> +
> +	if (cn->core_type !=3D COREDUMP_SOCK_REQ)
> +		return true;
> +
> +	/* Let userspace know what we support. */
> +	if (!coredump_sock_send(cprm->file, &req))
> +		return false;
> +
> +	/* Peek the size of the coredump_ack. */
> +	if (!coredump_sock_recv(cprm->file, &ack, sizeof(ack.size),
> +				MSG_PEEK | MSG_WAITALL))
> +		return false;
> +
> +	/* Refuse unknown coredump_ack sizes. */
> +	usize =3D ack.size;
> +	if (usize < COREDUMP_ACK_SIZE_VER0 || usize > sizeof(ack))
> +		return coredump_sock_oob(cprm->file, COREDUMP_OOB_INVALIDSIZE);
> +
> +	/* Now retrieve the coredump_ack. */
> +	if (!coredump_sock_recv(cprm->file, &ack, usize, MSG_WAITALL))
> +		return false;
> +	if (ack.size !=3D usize)
> +		return false;
> +
> +	/* Refuse unknown coredump_ack flags. */
> +	if (ack.mask & ~req.mask)
> +		return coredump_sock_oob(cprm->file, COREDUMP_OOB_UNSUPPORTED);
> +
> +	/* Refuse mutually exclusive options. */
> +	if (hweight64(ack.mask & (COREDUMP_USERSPACE | COREDUMP_KERNEL |
> +				  COREDUMP_REJECT)) !=3D 1)
> +		return coredump_sock_oob(cprm->file, COREDUMP_OOB_CONFLICTING);
> +
> +	if (ack.spare)
> +		return coredump_sock_oob(cprm->file, COREDUMP_OOB_UNSUPPORTED);
> +
> +	cn->mask =3D ack.mask;
> +	return true;
> +}
> +#endif
> +
>  void do_coredump(const kernel_siginfo_t *siginfo)
>  {
>  	struct core_state core_state;
> @@ -850,6 +950,8 @@ void do_coredump(const kernel_siginfo_t *siginfo)
>  		}
>  		break;
>  	}
> +	case COREDUMP_SOCK_REQ:
> +		fallthrough;

nit: you can omit the "fallthrough;" line here.

>  	case COREDUMP_SOCK: {
>  #ifdef CONFIG_UNIX
>  		struct file *file __free(fput) =3D NULL;
> @@ -918,6 +1020,9 @@ void do_coredump(const kernel_siginfo_t *siginfo)
> =20
>  		cprm.limit =3D RLIM_INFINITY;
>  		cprm.file =3D no_free_ptr(file);
> +
> +		if (!coredump_request(&cn, &cprm))
> +			goto close_fail;
>  #else
>  		coredump_report_failure("Core dump socket support %s disabled", cn.cor=
ename);
>  		goto close_fail;
> @@ -929,12 +1034,17 @@ void do_coredump(const kernel_siginfo_t *siginfo)
>  		goto close_fail;
>  	}
> =20
> +	/* Don't even generate the coredump. */
> +	if (cn.mask & COREDUMP_REJECT)
> +		goto close_fail;
> +
>  	/* get us an unshared descriptor table; almost always a no-op */
>  	/* The cell spufs coredump code reads the file descriptor tables */
>  	retval =3D unshare_files();
>  	if (retval)
>  		goto close_fail;
> -	if (!dump_interrupted()) {
> +
> +	if ((cn.mask & COREDUMP_KERNEL) && !dump_interrupted()) {
>  		/*
>  		 * umh disabled with CONFIG_STATIC_USERMODEHELPER_PATH=3D"" would
>  		 * have this set to NULL.
> @@ -968,17 +1078,23 @@ void do_coredump(const kernel_siginfo_t *siginfo)
>  		kernel_sock_shutdown(sock_from_file(cprm.file), SHUT_WR);
>  #endif
> =20
> +	/* Let the parent know that a coredump was generated. */
> +	if (cn.mask & COREDUMP_USERSPACE)
> +		core_dumped =3D true;
> +
>  	/*
>  	 * When core_pipe_limit is set we wait for the coredump server
>  	 * or usermodehelper to finish before exiting so it can e.g.,
>  	 * inspect /proc/<pid>.
>  	 */

You can ignore my earlier question. The comment above clarifies it.

> -	if (core_pipe_limit) {
> +	if (cn.mask & COREDUMP_WAIT) {
>  		switch (cn.core_type) {
>  		case COREDUMP_PIPE:
>  			wait_for_dump_helpers(cprm.file);
>  			break;
>  #ifdef CONFIG_UNIX
> +		case COREDUMP_SOCK_REQ:
> +			fallthrough;
>  		case COREDUMP_SOCK: {
>  			ssize_t n;
> =20
> @@ -1249,8 +1365,8 @@ static inline bool check_coredump_socket(void)
>  	if (current->nsproxy->mnt_ns !=3D init_task.nsproxy->mnt_ns)
>  		return false;
> =20
> -	/* Must be an absolute path. */
> -	if (*(core_pattern + 1) !=3D '/')
> +	/* Must be an absolute path or the socket request. */
> +	if (*(core_pattern + 1) !=3D '/' && *(core_pattern + 1) !=3D '@')
>  		return false;
> =20
>  	return true;
> diff --git a/include/uapi/linux/coredump.h b/include/uapi/linux/coredump.=
h
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
> +	COREDUMP_KERNEL		=3D (1ULL << 0),
> +	COREDUMP_USERSPACE	=3D (1ULL << 1),
> +	COREDUMP_REJECT		=3D (1ULL << 2),
> +	COREDUMP_WAIT		=3D (1ULL << 3),
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
> +	__u32 size;
> +	__u32 size_ack;
> +	__u64 mask;
> +};
> +
> +enum {
> +	COREDUMP_REQ_SIZE_VER0 =3D 16U, /* size of first published struct */
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
> + * but it may of course be smaller (>=3D COREDUMP_ACK_SIZE_VER0 and <=3D
> + * coredump_req->size_ack).
> + *
> + * The @mask member must be set to the features the coredump server
> + * wants the kernel to use. Only bits the kernel returned in
> + * coredump_req->mask may be set.
> + */
> +struct coredump_ack {
> +	__u32 size;
> +	__u32 spare;
> +	__u64 mask;
> +};
> +
> +enum {
> +	COREDUMP_ACK_SIZE_VER0 =3D 16U, /* size of first published struct */
> +};
> +
> +/**
> + * enum coredump_oob - Out-of-band markers for the coredump socket
> + *
> + * The kernel will place a single byte coredump_oob marker on the
> + * coredump socket. An interested coredump server can listen for POLLPRI
> + * and figure out why the provided coredump_ack was invalid.
> + *
> + * The out-of-band markers allow advanced userspace to infer more detail=
s
> + * about a coredump ack. They are optional and can be ignored. They
> + * aren't necessary for the coredump server to function correctly.
> + *
> + * @COREDUMP_OOB_INVALIDSIZE: the provided coredump_ack size was invalid
> + * @COREDUMP_OOB_UNSUPPORTED: the provided coredump_ack mask was invalid
> + * @COREDUMP_OOB_CONFLICTING: the provided coredump_ack mask has conflic=
ting options
> + * @__COREDUMP_OOB_MAX: the maximum value for coredump_oob
> + */
> +enum coredump_oob {
> +	COREDUMP_OOB_INVALIDSIZE =3D 1U,
> +	COREDUMP_OOB_UNSUPPORTED =3D 2U,
> +	COREDUMP_OOB_CONFLICTING =3D 3U,
> +	__COREDUMP_OOB_MAX       =3D 255U,
> +} __attribute__ ((__packed__));
> +
> +#endif /* _UAPI_LINUX_COREDUMP_H */

Looks good!

Reviewed-by: Jeff Layton <jlayton@kernel.org>

