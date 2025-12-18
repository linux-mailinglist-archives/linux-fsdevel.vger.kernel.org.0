Return-Path: <linux-fsdevel+bounces-71674-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE98CCC95D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 16:56:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8393230275D3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 15:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD1E35CB85;
	Thu, 18 Dec 2025 15:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FUeDZ+os"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC637286430
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Dec 2025 15:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766073338; cv=none; b=ccnA3gdcPp6Qi/3g0eeoq6c0UoUUzb+dBe5/hoVTkHEdlRPr6J7TmcK5UUuMQ+qbTREHAJSmrc5FSBRp6jLY9t/3GH92Vb2g2pkHrkuYkrbeprMkGWiNxRdXvsZQxXzD24WtEBS/nmzv0BOgS+Ni6AQ0N+D4KrQMbs+tdUzzJzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766073338; c=relaxed/simple;
	bh=0i64sHXFyeOn4T7lC0kL1MP9gkEtCAPdy37I0L5aKjI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yomw8ceYlyj0vofbFIn0mzXCHOqickSgZWxI2NXajPcmuVV7EsN1mjDq6YxFEMS5bQSE4R4dOYssX1ptsMHcG77HIdB6CM1iKr5I5SS4w+UlVkdI3dpZWzpWu40aAEBksLebVDUfjOXSnoovOItl3I8KVW2l5anD8wrmQ6rdUE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FUeDZ+os; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DA5CC19421
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Dec 2025 15:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766073338;
	bh=0i64sHXFyeOn4T7lC0kL1MP9gkEtCAPdy37I0L5aKjI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FUeDZ+oss3YBd2y/VNgS/uX/8Gg9xVk4I1fx9uzwiM5jpJSJo2g4YzAA9BWDVXmfS
	 k7Hk1YIY8oLo35Hjv9aE5mJAwOREaGHNJPa6JZa7gaD+hm1mb/+iwYlJbHIHxDriXw
	 L3ExVbXTNITsAWPVzn8TLSb8gQOuHWjflSA9xZ0Y2UFYqnfo+pCIoJ7r4K2le8YHZW
	 58adXYVz0+VPnSJ55wDDv80MtOzhiGYKijLfusi624UHJtMCQTzOQahOfOz9j0Zw/V
	 u+D6jhqrheEOiJD2pU6kXP1RgO6/Eu+XneL8Zt1OlaYOvW9w/7+oHUaGZunthTR5vq
	 gvuslkNcdXOUQ==
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b734fcbf1e3so139187266b.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Dec 2025 07:55:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX9oelOYs6NTMTtqdDwv7OTh2Qr0MEgeWaEQgfbKleGWJ24oj8rfL2QSxwGSn3Ogso48pncsWqowaYOF1he@vger.kernel.org
X-Gm-Message-State: AOJu0YwXbOPhpWkw21d0rTltKE1mb9izUVuJFLXo6jBdm8o4N4T5TsNZ
	Sf5WSw6Snrm1dSEjz2yfQNjfJuuaNncj1UgpyT38C8RGKhBBrz23qWyQUL8365/5zYOqCzYevAP
	hiuEG5mqkGZapksyCDK+m8WVGF1Zzbmk=
X-Google-Smtp-Source: AGHT+IEo6aZCX1KMrO1Ob47/LNB9dHPkXe/ckpqY7ps5CknJcM6648B9u4aMai/sFK3waKYewO8ACSRqqVF4LS1Urd8=
X-Received: by 2002:a17:907:1c1d:b0:b70:be84:5186 with SMTP id
 a640c23a62f3a-b7d23a61d65mr2257492066b.44.1766073337048; Thu, 18 Dec 2025
 07:55:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <712257.1766069339@warthog.procyon.org.uk> <b5ebd3be-c567-44bb-9411-add5e79234dc@linux.dev>
 <cb002f72-3e2a-4d23-b08d-f6d987a29661@linux.dev>
In-Reply-To: <cb002f72-3e2a-4d23-b08d-f6d987a29661@linux.dev>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Fri, 19 Dec 2025 00:55:25 +0900
X-Gmail-Original-Message-ID: <CAKYAXd81W9xERg0iOWm81hcfA1KsWj1TrUvsRP6nqJ_aZcgz0w@mail.gmail.com>
X-Gm-Features: AQt7F2qkIknFTga4RXT6YjWRe3Nu_koS2vm76FTBMTsoKLLXEmMsFlhPcgq0lsM
Message-ID: <CAKYAXd81W9xERg0iOWm81hcfA1KsWj1TrUvsRP6nqJ_aZcgz0w@mail.gmail.com>
Subject: Re: [PATCH] ksmbd: Fix to handle removal of rfc1002 header from smb_hdr
To: ChenXiaoSong <chenxiaosong.chenxiaosong@linux.dev>
Cc: David Howells <dhowells@redhat.com>, Steve French <sfrench@samba.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Tom Talpey <tom@talpey.com>, 
	Paulo Alcantara <pc@manguebit.org>, Shyam Prasad N <sprasad@microsoft.com>, linux-cifs@vger.kernel.org, 
	netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 19, 2025 at 12:47=E2=80=AFAM ChenXiaoSong
<chenxiaosong.chenxiaosong@linux.dev> wrote:
>
> Hi David,
>
> Since the size of `struct smb_hdr` has changed, the value of
> `SMB1_MIN_SUPPORTED_HEADER_SIZE` should also be updated to
> `(sizeof(struct smb_hdr) + 4)`. `SMB1_MIN_SUPPORTED_HEADER_SIZE` is used
> in `ksmbd_conn_handler_loop()`.
Right. And there are other places that need to be changed as well, I
will check it.
Thanks!
>
> Thanks,
> ChenXiaoSong.
>
> On 12/18/25 11:09 PM, ChenXiaoSong wrote:
> > `ksmbd_conn_handler_loop()` calls `get_rfc1002_len()`. Does this need t=
o
> > be updated as well?
> >
> > Thanks,
> > ChenXiaoSong.
> >
> > On 12/18/25 10:48 PM, David Howells wrote:
> >> Hi Namjae,
> >>
> >> Does this (untested) patch fix the problem for you?
> >>
> >> David
> >> ---
> >> The commit that removed the RFC1002 header from struct smb_hdr didn't
> >> also
> >> fix the places in ksmbd that use it in order to provide graceful
> >> rejection
> >> of SMB1 protocol requests.
> >>
> >> Fixes: 83bfbd0bb902 ("cifs: Remove the RFC1002 header from smb_hdr")
> >> Reported-by: Namjae Jeon <linkinjeon@kernel.org>
> >> Link: https://lore.kernel.org/r/
> >> CAKYAXd9Ju4MFkkH5Jxfi1mO0AWEr=3DR35M3vQ_Xa7Yw34JoNZ0A@mail.gmail.com/
> >> Signed-off-by: David Howells <dhowells@redhat.com>
> >> cc: Steve French <sfrench@samba.org>
> >> cc: Sergey Senozhatsky <senozhatsky@chromium.org>
> >> cc: Tom Talpey <tom@talpey.com>
> >> cc: Paulo Alcantara <pc@manguebit.org>
> >> cc: Shyam Prasad N <sprasad@microsoft.com>
> >> cc: linux-cifs@vger.kernel.org
> >> cc: netfs@lists.linux.dev
> >> cc: linux-fsdevel@vger.kernel.org
> >> ---
> >>   fs/smb/server/server.c     |    2 +-
> >>   fs/smb/server/smb_common.c |   10 +++++-----
> >>   2 files changed, 6 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/fs/smb/server/server.c b/fs/smb/server/server.c
> >> index 3cea16050e4f..bedc8390b6db 100644
> >> --- a/fs/smb/server/server.c
> >> +++ b/fs/smb/server/server.c
> >> @@ -95,7 +95,7 @@ static inline int check_conn_state(struct ksmbd_work
> >> *work)
> >>       if (ksmbd_conn_exiting(work->conn) ||
> >>           ksmbd_conn_need_reconnect(work->conn)) {
> >> -        rsp_hdr =3D work->response_buf;
> >> +        rsp_hdr =3D smb2_get_msg(work->response_buf);
> >>           rsp_hdr->Status.CifsError =3D STATUS_CONNECTION_DISCONNECTED=
;
> >>           return 1;
> >>       }
> >> diff --git a/fs/smb/server/smb_common.c b/fs/smb/server/smb_common.c
> >> index b23203a1c286..d6084580b59d 100644
> >> --- a/fs/smb/server/smb_common.c
> >> +++ b/fs/smb/server/smb_common.c
> >> @@ -140,7 +140,7 @@ int ksmbd_verify_smb_message(struct ksmbd_work *wo=
rk)
> >>       if (smb2_hdr->ProtocolId =3D=3D SMB2_PROTO_NUMBER)
> >>           return ksmbd_smb2_check_message(work);
> >> -    hdr =3D work->request_buf;
> >> +    hdr =3D smb2_get_msg(work->request_buf);
> >>       if (*(__le32 *)hdr->Protocol =3D=3D SMB1_PROTO_NUMBER &&
> >>           hdr->Command =3D=3D SMB_COM_NEGOTIATE) {
> >>           work->conn->outstanding_credits++;
> >> @@ -278,7 +278,6 @@ static int ksmbd_negotiate_smb_dialect(void *buf)
> >>                             req->DialectCount);
> >>       }
> >> -    proto =3D *(__le32 *)((struct smb_hdr *)buf)->Protocol;
> >>       if (proto =3D=3D SMB1_PROTO_NUMBER) {
> >>           struct smb_negotiate_req *req;
> >> @@ -320,8 +319,8 @@ static u16 get_smb1_cmd_val(struct ksmbd_work *wor=
k)
> >>    */
> >>   static int init_smb1_rsp_hdr(struct ksmbd_work *work)
> >>   {
> >> -    struct smb_hdr *rsp_hdr =3D (struct smb_hdr *)work->response_buf;
> >> -    struct smb_hdr *rcv_hdr =3D (struct smb_hdr *)work->request_buf;
> >> +    struct smb_hdr *rsp_hdr =3D (struct smb_hdr *)smb2_get_msg(work-
> >> >response_buf);
> >> +    struct smb_hdr *rcv_hdr =3D (struct smb_hdr *)smb2_get_msg(work-
> >> >request_buf);
> >>       rsp_hdr->Command =3D SMB_COM_NEGOTIATE;
> >>       *(__le32 *)rsp_hdr->Protocol =3D SMB1_PROTO_NUMBER;
> >> @@ -412,9 +411,10 @@ static int init_smb1_server(struct ksmbd_conn *co=
nn)
> >>   int ksmbd_init_smb_server(struct ksmbd_conn *conn)
> >>   {
> >> +    struct smb_hdr *rcv_hdr =3D (struct smb_hdr *)smb2_get_msg(conn-
> >> >request_buf);
> >>       __le32 proto;
> >> -    proto =3D *(__le32 *)((struct smb_hdr *)conn->request_buf)->Proto=
col;
> >> +    proto =3D *(__le32 *)rcv_hdr->Protocol;
> >>       if (conn->need_neg =3D=3D false) {
> >>           if (proto =3D=3D SMB1_PROTO_NUMBER)
> >>               return -EINVAL;
> >>
> >>
> >
>

