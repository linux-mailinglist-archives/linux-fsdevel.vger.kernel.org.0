Return-Path: <linux-fsdevel+bounces-19993-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 460588CBDD3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 11:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30D151C20CCA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 09:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1AC1811FF;
	Wed, 22 May 2024 09:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XSHPEaob"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B633811E0;
	Wed, 22 May 2024 09:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716370062; cv=none; b=sMIfqagQ+jUBi/dH+RMVNRK8VRSxOv9/pFhZS3ETIWmIWYjD72z7V0PbRl5qxtDtWgcHd188z37d+bteCySd/I3kz6U6mB/kuXSqL5c5WeP3eUlFcdBKhXZnu/qmTR/7PnhNdr936N+gKHgwSE9GFkjpbUYtMHw7vGIwkYHSB7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716370062; c=relaxed/simple;
	bh=yIYBXGdl869XX2pTr1QmDY+AP5o/usnaarQJoGjwRv8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tdw6sfM0zILYY9mHLy7o2IDkgo6ykfUAjmipjD/1QLdh6MhHIa69PbsECOmJa47p6ZuggkwPahFIL/oWaG4mRgfDoJWv1DMSQO6W1Idlzzolm4BNYj1tZAzAPlB5bP82LBb7w4fbUy9VMqyyV4fa+ZqwCK/Z2N3fOfjbioYLzTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XSHPEaob; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5238b5c080cso7793190e87.1;
        Wed, 22 May 2024 02:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716370057; x=1716974857; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J3RHkz1PAC1a1gnJwaqPWf+2yMWWiU1EZBBXLHMWkG0=;
        b=XSHPEaobQ9QyC7TaRkhuj1XVfte7fqlmkl1zwI76QejmgcVXIb3TtjszCV3XaUSBHL
         iejQNE4sIzbvqr9onGJaOShqjfFQRbubQ955RukW8YccLlUEqL3e6kIuU6SIIZt6N9In
         6GKfJekFmwChbTjTafGbrdVGivvZYuUVnV7X7xRK5X6M6ukPLNMUP5DhRmhHR7nCJ0Yp
         1N20QOodKBW2Y46hF9DZe16/GuxFgRnehcqZGCO2wXq0LRArn5isHJewuYVUby4OOOSS
         2IUEgs6WOZb5RKq9rq0IEcoxZhIfE7m4oIEbLcESoSkDwB7HZS5KmQHEj0ph0nD3n19O
         ZoSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716370057; x=1716974857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J3RHkz1PAC1a1gnJwaqPWf+2yMWWiU1EZBBXLHMWkG0=;
        b=M4vQv7ieRtTYvfAmu0uY2iLbFjEpRamcI4zJwpf6ajg4IOzdYZZEwKE03koXATYBhj
         G4FV0CLwyvE0icLM8FgPR4ya84peIomm/tAKSi1jKVoLh0KtAAtUVAnCr9kak8dGNYWn
         VchPSKO1nTt5Ec1ZK+iXvtxS2XFcHKBXJFUOwvlLN33Hzl+4vvuj1dTbboPtu5DQxRhf
         mp99imDqnzifVUjhVSEM0lZ/m4gg2dYPejiw5i7Kd+lgyz7+p4LRbH4q4WqNy+xqPI8q
         z2euO1wDLi7TctUddxKPtNPa5y+DeMkvL/76pXaadUsrhJZtRcAxPP4D/nJsFkjFrLKM
         C12g==
X-Forwarded-Encrypted: i=1; AJvYcCUYf6PtWMOKbJIKkT/NNcCZN12mJ+sF1nusUUslL6AG8BKTANquIMsBtDGz0/k5ymqhxG/8Q7ie4PoM+HEtpH4IU0xKHsXWVA+kmUuX6cuvur0URZBN6bSyFxsAQ6M0ho9IOq85lxIiJEiDTT8UFooGfEHI5bk+75PuxGuZqrpZfqDIibSzcbk=
X-Gm-Message-State: AOJu0YyVnFyGk+djvmk3YaO2icKogXF7DQ7u49nZbE8dwky3HwL+U4v+
	iWJ+fmFdFLRIfV+GRiGKTeJIEEjdvYHlScaTkatZEVAeWCs0xiHOe3QftawrrtpvHsyqHV+R0i1
	hnXDbDXQqML6u/eosPw6nihQ57uw=
X-Google-Smtp-Source: AGHT+IEFyirCOQaf4B+kNykUPvpKVUgbY2KUycXUHf9UnyJn6uHYcrCR1+MiVHLL/L30cClXAAGye9v+HQ0A/uuAH5M=
X-Received: by 2002:a05:6512:4dc:b0:519:2d60:d71b with SMTP id
 2adb3069b0e04-526bdd47f63mr896360e87.22.1716370057087; Wed, 22 May 2024
 02:27:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <367856.1716367128@warthog.procyon.org.uk>
In-Reply-To: <367856.1716367128@warthog.procyon.org.uk>
From: Steve French <smfrench@gmail.com>
Date: Wed, 22 May 2024 04:27:24 -0500
Message-ID: <CAH2r5mvhyrtXSvS4du4_iHO_X=bjrhPoyn4iFCrTVhbSo1eVew@mail.gmail.com>
Subject: Re: [PATCH] cifs: Fix smb3_insert_range() to move the zero_point
To: David Howells <dhowells@redhat.com>
Cc: Steve French <sfrench@samba.org>, Shyam Prasad N <nspmangalore@gmail.com>, 
	Rohith Surabattula <rohiths.msft@gmail.com>, Jeff Layton <jlayton@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, linux-cifs@vger.kernel.org, netfs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Added the patch to the test branch and rerunning tests on it now

http://smb311-linux-testing.southcentralus.cloudapp.azure.com/#/builders/3/=
builds/122

On Wed, May 22, 2024 at 3:39=E2=80=AFAM David Howells <dhowells@redhat.com>=
 wrote:
>
> Fix smb3_insert_range() to move the zero_point over to the new EOF.
> Without this, generic/147 fails as reads of data beyond the old EOF point
> return zeroes.
>
> Fixes: 3ee1a1fc3981 ("cifs: Cut over to using netfslib")
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Steve French <sfrench@samba.org>
> cc: Shyam Prasad N <nspmangalore@gmail.com>
> cc: Rohith Surabattula <rohiths.msft@gmail.com>
> cc: Jeff Layton <jlayton@kernel.org>
> cc: linux-cifs@vger.kernel.org
> cc: netfs@lists.linux.dev
> ---
>  fs/smb/client/smb2ops.c |    1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
> index ef18cd30f66c..b87b70edd0be 100644
> --- a/fs/smb/client/smb2ops.c
> +++ b/fs/smb/client/smb2ops.c
> @@ -3636,6 +3636,7 @@ static long smb3_insert_range(struct file *file, st=
ruct cifs_tcon *tcon,
>         rc =3D smb2_copychunk_range(xid, cfile, cfile, off, count, off + =
len);
>         if (rc < 0)
>                 goto out_2;
> +       cifsi->netfs.zero_point =3D new_eof;
>
>         rc =3D smb3_zero_data(file, tcon, off, len, xid);
>         if (rc < 0)
>
>


--=20
Thanks,

Steve

