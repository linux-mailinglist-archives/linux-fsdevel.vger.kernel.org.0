Return-Path: <linux-fsdevel+bounces-52583-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69CCFAE468E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 16:22:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC0B44A07B2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 14:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFEAC25A340;
	Mon, 23 Jun 2025 14:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N1WnqFvL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9130825A2CC;
	Mon, 23 Jun 2025 14:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750688080; cv=none; b=RQFrA3+Zemm7i2ZNo95xZLscaSVhOPVbKeoUo9z5EbyULTI8Yr9iDrIG50GKd7A23GvbnBEhhrJ7SklDjT/vq/gMARPZthBkh1mx3CsVnjuwHymEJVM6HQwg9nTTBf4ebCn3lqkAvexRAzAsIKtZUQAxt/iMLvjzfmWoPmtCfCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750688080; c=relaxed/simple;
	bh=DrUgJmz9mv9oNuENjezJvKTNsknS0G1u9sssb8hLjWw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PULrFJLE185cUl37ZMea0zPnZU5BSoat7lQnO7OQtyX+NVpD6vtVrZKJR9Nb9YTXQtE3d+utuTZj0Cg+xNOT7uuz1RQWKGQ6qm4CO3imXZNx46SctrKV2vR0ra53ncNCs4PY5kLKznjLLbdfzzDpDSHAECJ68LTkQvxBQeTf0do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N1WnqFvL; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6faf66905adso23864016d6.2;
        Mon, 23 Jun 2025 07:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750688077; x=1751292877; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gB5mz+FxMOMtnMLrI/M5PI/QmYx/AfyqX4qBVvMef0s=;
        b=N1WnqFvLnbBCT0kovRXdy7nzs8hBUdmV00V9WyYO0N2ZeNr41r6eKDRlK9TJl7bo4N
         VAJBCbizvqCOJoqAGPUWbdQhN1IyxwyAe/fwtL1lXl/3VRx3t3AIL9iHm3E1MNQXdzq8
         zlabO77362dP4GmMbf3HPxwKvs20ypsnMLCODN6OvfmZCbLJSKZwHKB+LM7WGucjkk9T
         vQZ8YTtoYDEuhaeAaeZdPj4cuxLKBxM/qbf5ZSXbnF3mNz84ONhRd3Rsd2emaVw81f7a
         ARYD8w3ua4QB+ykqNZDaGXR1hS+Z8VxP7pcErPSOuG+lMwqpMgurMuAHsLbrlBcULXVd
         qgnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750688077; x=1751292877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gB5mz+FxMOMtnMLrI/M5PI/QmYx/AfyqX4qBVvMef0s=;
        b=CGwvtkqcXaswxELeW8wVdEKjyu3Oa6FpgNcbbON6Vj70bUQ1FKRU9SGe/h+wjRUKFX
         9ui8nCl7oyoMhwaZrhaiHd64VCrwk2a0o+2UaxdO/0NyLwkt5sAB5jLhfqgYFl8wRE+C
         jEvlLK1F7sTPF5jPnxwZpiA/1KF8lQfvk7A7iILFt7SYp+4LfPgcdna90p7lwRqaP4oM
         pUs6Dw8gdlsvmXa5IO2GOdyXsS35PUX6GYqfqQ8wyenrVBalPynj03lTgqa62yHG18bh
         dW75o73uSP/0HbwI0tWhJ74S4mF6Vf0h1c11prtHHLTSztl21+mx6wUdC3Mevz8nSIVU
         26Ag==
X-Forwarded-Encrypted: i=1; AJvYcCVXYQSD72oRBjhEWqB+CcPsuK6k7JJQFBwtYlqiGNk2ZG3BMJZ7TyNNih80wJ2WPCKeyvcMriQba5ZY@vger.kernel.org, AJvYcCVdFEIZ7cToLgc1KiDtn1Kny63LmjBvPd/FJj1RBOtAsJmDA3aA6B6RU8Q44NTfNVXtqfPkYAcZX4GVNWPW@vger.kernel.org, AJvYcCWdFY9rp5SjiHJ51Qne7CD/JNGVfll/rYeJ5ojqwAPoVff71tgpVtQC5X1iL9As1Wdu2sq0dKjHndC5nk7jbw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt3rut28WZ+S1voJRBn77/7uzB9H0Aplo/FsSbCxN2Ia7V3I/8
	7EhSLYXHz2efBiVNvjyRQ2CWAVHC0GrlhL8NkqeI0RV+xAC5n+EoUfvlWGpP7oklEGtGv4G3PVc
	ZjatK78Dp23gnDxD1W055+BvjtPNduMA=
X-Gm-Gg: ASbGncvUd6FRP6Drv89W6blhoumGOPyqku+oSNe5p+jHsgEn3yStZeknWS3mejWHz12
	Qe6estXbNZet2DDsMXN6lCN36XQafH7OEFJKF0LxPoCXEA+lxt9AaerYbLbER3BpTZQsK3UQHdX
	6ptuwG9he2/tXMV7xpOD7F8/qwJEMworYp2H3MkVQMZlyUjvq+HD9XaD9lnEs6cE6a737OLfnjK
	J39/g==
X-Google-Smtp-Source: AGHT+IEkXBzeNkvGlr+MIWstDnY8eKrXwYunCgNIcOP48vnJi9qyAPRtIff07B7nuxNo4Y6YB9GTJmQfZ5jk980sLjE=
X-Received: by 2002:a05:6214:4885:b0:6fb:6778:e205 with SMTP id
 6a1803df08f44-6fd0a535472mr220001536d6.25.1750688076986; Mon, 23 Jun 2025
 07:14:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250623124835.1106414-1-dhowells@redhat.com> <20250623124835.1106414-7-dhowells@redhat.com>
In-Reply-To: <20250623124835.1106414-7-dhowells@redhat.com>
From: Steve French <smfrench@gmail.com>
Date: Mon, 23 Jun 2025 09:14:25 -0500
X-Gm-Features: Ac12FXxLQPaj9HruER9vjDaDjWQT2gVo6q7LARadtOuRo6Y6TxV_q72wukZRZKQ
Message-ID: <CAH2r5mv5jjtNJmLAcaa7EbXpftuC04F+b_g6YZxkNDTNYnm7sg@mail.gmail.com>
Subject: Re: [PATCH 06/11] cifs: Fix prepare_write to negotiate wsize if needed
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <christian@brauner.io>, Steve French <sfrench@samba.org>, 
	Paulo Alcantara <pc@manguebit.com>, netfs@lists.linux.dev, linux-cifs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Paulo Alcantara <pc@manguebit.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This patch is already merged into mainline.

On Mon, Jun 23, 2025 at 7:50=E2=80=AFAM David Howells <dhowells@redhat.com>=
 wrote:
>
> Fix cifs_prepare_write() to negotiate the wsize if it is unset.
>
> Fixes: 69c3c023af25 ("cifs: Implement netfslib hooks")
> Signed-off-by: David Howells <dhowells@redhat.com>
> Reviewed-by: Paulo Alcantara <pc@manguebit.org>
> cc: Steve French <sfrench@samba.org>
> cc: netfs@lists.linux.dev
> cc: linux-fsdevel@vger.kernel.org
> cc: linux-cifs@vger.kernel.org
> ---
>  fs/smb/client/file.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
> index 9835672267d2..e9212da32f01 100644
> --- a/fs/smb/client/file.c
> +++ b/fs/smb/client/file.c
> @@ -52,6 +52,7 @@ static void cifs_prepare_write(struct netfs_io_subreque=
st *subreq)
>         struct netfs_io_stream *stream =3D &req->rreq.io_streams[subreq->=
stream_nr];
>         struct TCP_Server_Info *server;
>         struct cifsFileInfo *open_file =3D req->cfile;
> +       struct cifs_sb_info *cifs_sb =3D CIFS_SB(wdata->rreq->inode->i_sb=
);
>         size_t wsize =3D req->rreq.wsize;
>         int rc;
>
> @@ -63,6 +64,10 @@ static void cifs_prepare_write(struct netfs_io_subrequ=
est *subreq)
>         server =3D cifs_pick_channel(tlink_tcon(open_file->tlink)->ses);
>         wdata->server =3D server;
>
> +       if (cifs_sb->ctx->wsize =3D=3D 0)
> +               cifs_negotiate_wsize(server, cifs_sb->ctx,
> +                                    tlink_tcon(req->cfile->tlink));
> +
>  retry:
>         if (open_file->invalidHandle) {
>                 rc =3D cifs_reopen_file(open_file, false);
> @@ -160,10 +165,9 @@ static int cifs_prepare_read(struct netfs_io_subrequ=
est *subreq)
>         server =3D cifs_pick_channel(tlink_tcon(req->cfile->tlink)->ses);
>         rdata->server =3D server;
>
> -       if (cifs_sb->ctx->rsize =3D=3D 0) {
> +       if (cifs_sb->ctx->rsize =3D=3D 0)
>                 cifs_negotiate_rsize(server, cifs_sb->ctx,
>                                      tlink_tcon(req->cfile->tlink));
> -       }
>
>         rc =3D server->ops->wait_mtu_credits(server, cifs_sb->ctx->rsize,
>                                            &size, &rdata->credits);
>
>


--=20
Thanks,

Steve

