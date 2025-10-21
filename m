Return-Path: <linux-fsdevel+bounces-64806-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2878DBF460C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 04:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88CCF18A355B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 02:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585E427B340;
	Tue, 21 Oct 2025 02:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SJZl8czZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2592025FA13
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Oct 2025 02:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761013531; cv=none; b=nZ5oOkE5qdiryAwhIYnvq0IoVtWy2rdL1eYC1eQF2GrORTdSeUtCSBZ/B6OM4W/3UeJxCcFv8N3tK/nQcHwr1tyfIt0VFIbStqGUxi/oUV/oKFl0uwGIKBsABZJrJBkklSrsuKdLXc7GzNOipuniOV+a4fZzrKwflhWjQ9iCYNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761013531; c=relaxed/simple;
	bh=4NEB6i79j5sz/k1jyryWLeGzpc1E3YymDL8QTIYQ8Ns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rtOflRb4Nvbjo4lyRsq7B43E86UuWhXuAzLWitiY/x7E8T7xNDP8jli24CA2riTGZUIn36qwUoaFLq4/aEtoiMaIGKLg4ZbiIjIBFJi+qRpfylkye0wQubEn/M2HM/VuJoqovjf0LT/FBuLjnKz2MYM+FCIv+ZxIYqDyWRxszX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SJZl8czZ; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-87c217f4aaaso62533276d6.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Oct 2025 19:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761013527; x=1761618327; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N1luQ+e/4qugKBcMlsVj8SRUT2PF8Mxc4nYmeeDlrs0=;
        b=SJZl8czZWyQ2t48YqhUwGcjad94ymGoAksYYm9Cz53cOSOieCy1+1QOBq3WZa8/hgc
         l9wTpYPdpbbddFnDZ8LfG9fqMXQaar8i4gvYk1JkuuSWsAYYTq8RVScevPxex0//rsFP
         i6ESOeKp6oPEFdTqV9NlmfUWutnVlbFtvsYLskR9AE19ixkAJpe/HNIFfu4J1w8uaNyF
         H1kd/WN2roIMF3+S0xJO4Nho2yuLUijb67H/f8khjHjUF3XofnFS7fenrVt2N2Pw5Bte
         iBTLaZaVFRFe9PdfWbEN+SOF9I58eAAcTQX7wudiPEYCnCx4yTouBe4Kwn/9PBYBvwh6
         2S+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761013527; x=1761618327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N1luQ+e/4qugKBcMlsVj8SRUT2PF8Mxc4nYmeeDlrs0=;
        b=IDuViWeCl3vR48L9+J1Sk/pDtRnSyU4wOQy+tI3TARu24w/OkQmEpZaWiWbpmLDipB
         M/wpAUdxPS2B+YCwqy69IyOzvoaPGbE/PsbkkmfsD+PEFsrvVj2ifqUbX4O8uQrXrfnr
         fqpjxnytMsK8N4DJac5lTBeF6vXiqGwiqbJVFFTHW8crYf8eTQrB5ZWJ5hiM06soUrKu
         VUkDayHW+HfNaYaIhDH6PuGVxS01LC+GxcM0ovk5+JkVgdWdPja2+4GN1+s09JUouylp
         zYZjHA+/quwnHSPhEd6xUHq1wZ8ZzGSvN/lSTMp11isJ732JnG8anQX90gPNov2THTMh
         BPIA==
X-Forwarded-Encrypted: i=1; AJvYcCXMHHSdC0ilt0lI9cBTgPMY7yLPlBk1iBK8irdzPV5JLJIxhTMs4arz0MEyAM3pqH/wZ0KTCEReYtsK8V0w@vger.kernel.org
X-Gm-Message-State: AOJu0YxlMqjpYYxBbxx2fEEP7eBAwu5xzgM8gTn2v0cXpawvQ6qyeipH
	/bMslI0wP/rOk0wS4tZ93eYl4lUx3HaJTaU0uhaN+uIgfpqRqmv/G0yobkHEdltTiUrbY54245j
	63IYizftOUA9zCtlklhn5YlQFZVRqM+c7xjyt
X-Gm-Gg: ASbGnctntEBnauFQBqxoF7I4mruK/ST7nxbV7ikP3C9a42bXikZKx2HYTMZtMXKg0V1
	72bQTlGszlSYLeq97M0z7tu83wpghfyJogVQh+kvP+VZI0ZB9UPDj3+3fbYRKDZ3BXbjqcyifT7
	BEgiuUq8EuUDfmYgujk3GjkIAwx5x2NeAhLOl7xlC4pYiy6/NsMgMFpdm+O774O4nJu2LLGq/mX
	q6XeEFfOS5b/FKSu+DtCfhNJ29iscbvZ1jOSiuziQP+OhEJvirY9AHACmuKWtclSz9JdivoO5YV
	4DFlj+1RQYV7BvGuekgt4fxa2CwHsBQDOq4z0XzUpbmLB/pDMfwbR4xlsteSF7zKKa0cjyBHxeU
	jeu1rwIHu+xV+ElrWEEiyr89UH/gw23Imn1ItK8VdQ//wPJ6HJCCyJ5OmTKyl9qPNluG65sbDnI
	8Ta5NCjGn5sg==
X-Google-Smtp-Source: AGHT+IGIbBXPdleJFTf9ZI3LepzrcCiGQHq4dOORSjB1wDA83bUwKlG+/bNzG6X1SQNa3QuvIrMxyseeEKUyTeKz8mA=
X-Received: by 2002:ad4:5cc1:0:b0:70d:6df4:1b21 with SMTP id
 6a1803df08f44-87c206475dcmr196922176d6.62.1761013527425; Mon, 20 Oct 2025
 19:25:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1090391.1760961375@warthog.procyon.org.uk> <jf5k4w47cw3jhc3nfmhwtaqtqxrqd5ufg4agpagacbxejyuhb7@udi3ed54kf3m>
In-Reply-To: <jf5k4w47cw3jhc3nfmhwtaqtqxrqd5ufg4agpagacbxejyuhb7@udi3ed54kf3m>
From: Steve French <smfrench@gmail.com>
Date: Mon, 20 Oct 2025 21:25:16 -0500
X-Gm-Features: AS18NWAAU4F7DEiGyGYzXbDuBaEUTQIiuw45LKz1Aml1lgSpmTq63XNit4imBxM
Message-ID: <CAH2r5mvT9RtFAxLb0UCreeyfMMzhGU2BMO1FronmtQv+pQ8L4A@mail.gmail.com>
Subject: Re: [PATCH] cifs: Call the calc_signature functions directly
To: Enzo Matsumiya <ematsumiya@suse.de>
Cc: David Howells <dhowells@redhat.com>, Steve French <sfrench@samba.org>, 
	Paulo Alcantara <pc@manguebit.org>, linux-cifs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

merged updated patch into cifs-2.6.git for-next (and also has Enzo Acked-by=
 now)

On Mon, Oct 20, 2025 at 8:39=E2=80=AFAM Enzo Matsumiya <ematsumiya@suse.de>=
 wrote:
>
> Hi David,
>
> On 10/20, David Howells wrote:
> >As the SMB1 and SMB2/3 calc_signature functions are called from separate
> >sign and verify paths, just call them directly rather than using a funct=
ion
> >pointer.  The SMB3 calc_signature then jumps to the SMB2 variant if
> >necessary.
> >
> >Signed-off-by: David Howells <dhowells@redhat.com>
> >cc: Steve French <sfrench@samba.org>
> >cc: Paulo Alcantara <pc@manguebit.org>
> >cc: linux-cifs@vger.kernel.org
> >cc: linux-fsdevel@vger.kernel.org
> >---
> > fs/smb/client/cifsglob.h      |    2 --
> > fs/smb/client/smb2ops.c       |    4 ----
> > fs/smb/client/smb2proto.h     |    6 ------
> > fs/smb/client/smb2transport.c |   18 +++++++++---------
> > 4 files changed, 9 insertions(+), 21 deletions(-)
> >
> >diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
> >index b91397dbb6aa..7297f0f01cb3 100644
> >--- a/fs/smb/client/cifsglob.h
> >+++ b/fs/smb/client/cifsglob.h
> >@@ -536,8 +536,6 @@ struct smb_version_operations {
> >       void (*new_lease_key)(struct cifs_fid *);
> >       int (*generate_signingkey)(struct cifs_ses *ses,
> >                                  struct TCP_Server_Info *server);
> >-      int (*calc_signature)(struct smb_rqst *, struct TCP_Server_Info *=
,
> >-                              bool allocate_crypto);
> >       int (*set_integrity)(const unsigned int, struct cifs_tcon *tcon,
> >                            struct cifsFileInfo *src_file);
> >       int (*enum_snapshots)(const unsigned int xid, struct cifs_tcon *t=
con,
> >diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
> >index 7c392cf5940b..66eee3440df6 100644
> >--- a/fs/smb/client/smb2ops.c
> >+++ b/fs/smb/client/smb2ops.c
> >@@ -5446,7 +5446,6 @@ struct smb_version_operations smb20_operations =3D=
 {
> >       .get_lease_key =3D smb2_get_lease_key,
> >       .set_lease_key =3D smb2_set_lease_key,
> >       .new_lease_key =3D smb2_new_lease_key,
> >-      .calc_signature =3D smb2_calc_signature,
> >       .is_read_op =3D smb2_is_read_op,
> >       .set_oplock_level =3D smb2_set_oplock_level,
> >       .create_lease_buf =3D smb2_create_lease_buf,
> >@@ -5550,7 +5549,6 @@ struct smb_version_operations smb21_operations =3D=
 {
> >       .get_lease_key =3D smb2_get_lease_key,
> >       .set_lease_key =3D smb2_set_lease_key,
> >       .new_lease_key =3D smb2_new_lease_key,
> >-      .calc_signature =3D smb2_calc_signature,
> >       .is_read_op =3D smb21_is_read_op,
> >       .set_oplock_level =3D smb21_set_oplock_level,
> >       .create_lease_buf =3D smb2_create_lease_buf,
> >@@ -5660,7 +5658,6 @@ struct smb_version_operations smb30_operations =3D=
 {
> >       .set_lease_key =3D smb2_set_lease_key,
> >       .new_lease_key =3D smb2_new_lease_key,
> >       .generate_signingkey =3D generate_smb30signingkey,
> >-      .calc_signature =3D smb3_calc_signature,
> >       .set_integrity  =3D smb3_set_integrity,
> >       .is_read_op =3D smb21_is_read_op,
> >       .set_oplock_level =3D smb3_set_oplock_level,
> >@@ -5777,7 +5774,6 @@ struct smb_version_operations smb311_operations =
=3D {
> >       .set_lease_key =3D smb2_set_lease_key,
> >       .new_lease_key =3D smb2_new_lease_key,
> >       .generate_signingkey =3D generate_smb311signingkey,
> >-      .calc_signature =3D smb3_calc_signature,
> >       .set_integrity  =3D smb3_set_integrity,
> >       .is_read_op =3D smb21_is_read_op,
> >       .set_oplock_level =3D smb3_set_oplock_level,
> >diff --git a/fs/smb/client/smb2proto.h b/fs/smb/client/smb2proto.h
> >index b3f1398c9f79..7e98fbe7bf33 100644
> >--- a/fs/smb/client/smb2proto.h
> >+++ b/fs/smb/client/smb2proto.h
> >@@ -39,12 +39,6 @@ extern struct mid_q_entry *smb2_setup_async_request(
> >                       struct TCP_Server_Info *server, struct smb_rqst *=
rqst);
> > extern struct cifs_tcon *smb2_find_smb_tcon(struct TCP_Server_Info *ser=
ver,
> >                                               __u64 ses_id, __u32  tid)=
;
> >-extern int smb2_calc_signature(struct smb_rqst *rqst,
> >-                              struct TCP_Server_Info *server,
> >-                              bool allocate_crypto);
> >-extern int smb3_calc_signature(struct smb_rqst *rqst,
> >-                              struct TCP_Server_Info *server,
> >-                              bool allocate_crypto);
> > extern void smb2_echo_request(struct work_struct *work);
> > extern __le32 smb2_get_lease_state(struct cifsInodeInfo *cinode);
> > extern bool smb2_is_valid_oplock_break(char *buffer,
> >diff --git a/fs/smb/client/smb2transport.c b/fs/smb/client/smb2transport=
.c
> >index 33f33013b392..916c131d763d 100644
> >--- a/fs/smb/client/smb2transport.c
> >+++ b/fs/smb/client/smb2transport.c
> >@@ -247,9 +247,9 @@ smb2_find_smb_tcon(struct TCP_Server_Info *server, _=
_u64 ses_id, __u32  tid)
> >       return tcon;
> > }
> >
> >-int
> >+static int
> > smb2_calc_signature(struct smb_rqst *rqst, struct TCP_Server_Info *serv=
er,
> >-                      bool allocate_crypto)
> >+                  bool allocate_crypto)
> > {
> >       int rc;
> >       unsigned char smb2_signature[SMB2_HMACSHA256_SIZE];
> >@@ -576,9 +576,9 @@ generate_smb311signingkey(struct cifs_ses *ses,
> >       return generate_smb3signingkey(ses, server, &triplet);
> > }
> >
> >-int
> >+static int
> > smb3_calc_signature(struct smb_rqst *rqst, struct TCP_Server_Info *serv=
er,
> >-                      bool allocate_crypto)
> >+                  bool allocate_crypto)
> > {
> >       int rc;
> >       unsigned char smb3_signature[SMB2_CMACAES_SIZE];
> >@@ -589,6 +589,9 @@ smb3_calc_signature(struct smb_rqst *rqst, struct TC=
P_Server_Info *server,
> >       struct smb_rqst drqst;
> >       u8 key[SMB3_SIGN_KEY_SIZE];
> >
> >+      if ((server->vals->protocol_id & 0xf00) =3D=3D 0x200)
>
> Please use:
>
>    if (server->vals->protocol_id <=3D SMB21_PROT_ID)
>
> Other than that
>
> Acked-by: Enzo Matsumiya <ematsumiya@suse.de>
>
> >+              return smb2_calc_signature(rqst, server, allocate_crypto)=
;
> >+
> >       rc =3D smb3_get_sign_key(le64_to_cpu(shdr->SessionId), server, ke=
y);
> >       if (unlikely(rc)) {
> >               cifs_server_dbg(FYI, "%s: Could not get signing key\n", _=
_func__);
> >@@ -657,7 +660,6 @@ smb3_calc_signature(struct smb_rqst *rqst, struct TC=
P_Server_Info *server,
> > static int
> > smb2_sign_rqst(struct smb_rqst *rqst, struct TCP_Server_Info *server)
> > {
> >-      int rc =3D 0;
> >       struct smb2_hdr *shdr;
> >       struct smb2_sess_setup_req *ssr;
> >       bool is_binding;
> >@@ -684,9 +686,7 @@ smb2_sign_rqst(struct smb_rqst *rqst, struct TCP_Ser=
ver_Info *server)
> >               return 0;
> >       }
> >
> >-      rc =3D server->ops->calc_signature(rqst, server, false);
> >-
> >-      return rc;
> >+      return smb3_calc_signature(rqst, server, false);
> > }
> >
> > int
> >@@ -722,7 +722,7 @@ smb2_verify_signature(struct smb_rqst *rqst, struct =
TCP_Server_Info *server)
> >
> >       memset(shdr->Signature, 0, SMB2_SIGNATURE_SIZE);
> >
> >-      rc =3D server->ops->calc_signature(rqst, server, true);
> >+      rc =3D smb3_calc_signature(rqst, server, true);
> >
> >       if (rc)
> >               return rc;
> >
> >
>


--=20
Thanks,

Steve

