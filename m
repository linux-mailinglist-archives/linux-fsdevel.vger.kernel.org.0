Return-Path: <linux-fsdevel+bounces-51575-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A96AD855A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 10:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63EE43B7EC1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 08:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031A226B766;
	Fri, 13 Jun 2025 08:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cj4NJ0fB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C14253935;
	Fri, 13 Jun 2025 08:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749802781; cv=none; b=ST3rMLI4U45U76whf3Y7yV6vYSIrV4jC8TRyt2wgduIhbVgEMOcjlOozBzYt//HNIbqEdPcuj2BPF1F3KhkhORoJTPHMU6kPl7sbh/XBnPbBuNbtJoEeo9sCu1YvvkOxmn0b3yN5vY8LfJSjuVetZWKcAYnu0ebcqZ5cJrqw8gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749802781; c=relaxed/simple;
	bh=CpSS0Syu7W8trhVa61zPlq9ZdSivRbuhRztZE//GV/c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uze03Jc9S28RBtavdFF4vVrSlFFm7eHWhzhBaI/sNEvGjHEmbIGt5vsI/Fuwjg0iK3UTCo15rGTAoUwQEddnVeX6Z35+vcf68RzsdqBDpB/qKjrWvYRAc4d1kI1dQcc8lQ+A7uRfrx59O+P0/oQS10gthDeDPyXjqFGKxDGnoz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cj4NJ0fB; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ad89333d603so371311766b.2;
        Fri, 13 Jun 2025 01:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749802778; x=1750407578; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CSdo7wiN8uPVGA75+U4tG+qHxaxYIcltnib03CDwyUo=;
        b=Cj4NJ0fBKHzs0+ayZtziZPzxl+F1dootglct3vePBKfcmdVLoVTr2yLRLv5cg5FLM5
         eExdplfvpJ/weHgUig8AlBzn3dJcyLHniOWytRuyZzQHSaMWaXZFRkKm6cs7IGCIXa2p
         oeKlJDJURaDv5KBK1l89+KmZ/lMYnyY6HufMJ2Gwx4aqjF3rwJUOEqvdYq5jeqc81Pxj
         f43u5Nt4WDDwLHBh/Xin1g8ofMwRE6iMktsFkjR+qxYNbUKUZqriSUugVP8C8jP9Zxz1
         Y3B7nk1WTcCsx+khOfnxzXqtYu2IEos541SRzCblWwTmgcD4Eqi359QZFl1igQW4Ejvt
         pnSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749802778; x=1750407578;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CSdo7wiN8uPVGA75+U4tG+qHxaxYIcltnib03CDwyUo=;
        b=RfYk1O1DN8Z0X1mUzQsmIwSPKaxLn8d+0HFCl0SGEi5QFyNrNR6qj2ir/7PnVYan/v
         QTM2kHfrjlmOAsPipn7wUr5WwUR3ZagZzcdydjbgmVtzmBHsMV4ZUBSktsQM6ZOC4Hb5
         4oUrbAqVHdyBLdYDlqqbJzaspZaAU985tjc8Sh7Vrpvn9YpFSqnbxnwlm7XVSJqHxFwd
         BfSl74jqVk7zzC5T/O6evoJPsQuPGtDn1EoPwG82ki84ZXB19OrCaMZBMzHmqowdkMF9
         6kW6NkkXQVr1uCPth5n9Rc9LEI6ufaQSHiEs6dHoqA0l+pAcrmOye7OOLlvqQXfjXlhd
         pLww==
X-Forwarded-Encrypted: i=1; AJvYcCWGkWnCXvd8vpXR/FdUvmvn0ljN/eVPbT6OouAkJ9TRE3zjngnu/7B+RsJ9LETZPX/0EryqKTI9BDc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR4tJbVxZm/aqwl1w5BiyDEeRJabYmRcNpAMspKMVDs0YgKJc+
	jwvKvWr3uVYGyhgytmmVrUvG/FXROVA6ohVQhbM1p/nAYUqYgNx7BxNpQcIVYulfqNLzeAHzlyd
	Ksft5Se4/TM3QEFrqoA1Tu2USD2OT/8g=
X-Gm-Gg: ASbGnct4+I0fdXrtV0auuLirskwpRiDyk6++DSEeLXUGZpvqy22+hfRI2rSQwdcTYcw
	B2ihNlkrKKt4RH1vcO4Wxyc6/t28OyPkzygwEFJwyuGaaTjlSQcEXl74p+pXp2kDXH+PYxwrxGo
	3W7sZXKYqRVLYkPtk9OqqOoIrqmi5JOehgy8gShKNONpI=
X-Google-Smtp-Source: AGHT+IFIpt7nmUDhK7cuWbHgUetwkODhe0OGwcEcPAgnrvIg2tq1MIsqB9UTgfxOmwVNNkWcxFbY/X0Odpv7eEo3dwQ=
X-Received: by 2002:a17:906:4fca:b0:ade:865f:481 with SMTP id
 a640c23a62f3a-adec53e9a5fmr225644766b.12.1749802777547; Fri, 13 Jun 2025
 01:19:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250613073149.GI1647736@ZenIV> <20250613073432.1871345-1-viro@zeniv.linux.org.uk>
In-Reply-To: <20250613073432.1871345-1-viro@zeniv.linux.org.uk>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 13 Jun 2025 10:19:25 +0200
X-Gm-Features: AX0GCFtX5ZjHmJ5VFxV98lbX4BCxWiOEABu35bm7O-9KDL6CA_UNFHbZlAzkglI
Message-ID: <CAOQ4uxhW3Hvicbb7Byi3_UbvBuS3-fpBOC8gmQ7d+Cns1wbWJg@mail.gmail.com>
Subject: Re: [PATCH 01/17] simple_recursive_removal(): saner interaction with fsnotify
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, chuck.lever@oracle.com, jlayton@kernel.org, 
	linux-nfs@vger.kernel.org, neil@brown.name, torvalds@linux-foundation.org, 
	trondmy@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 13, 2025 at 9:35=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> Make it match the real unlink(2)/rmdir(2) - notify *after* the
> operation.  And use fsnotify_delete() instead of messing with
> fsnotify_unlink()/fsnotify_rmdir().
>
> Currently the only caller that cares is the one in debugfs, and
> there the order matching the normal syscalls makes more sense;
> it'll get more serious for users introduced later in the series.
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Makes sense.
Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  fs/libfs.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/fs/libfs.c b/fs/libfs.c
> index 9ea0ecc325a8..42e226af6095 100644
> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -628,12 +628,9 @@ void simple_recursive_removal(struct dentry *dentry,
>                         inode_lock(inode);
>                         if (simple_positive(victim)) {
>                                 d_invalidate(victim);   // avoid lost mou=
nts
> -                               if (d_is_dir(victim))
> -                                       fsnotify_rmdir(inode, victim);
> -                               else
> -                                       fsnotify_unlink(inode, victim);
>                                 if (callback)
>                                         callback(victim);
> +                               fsnotify_delete(inode, d_inode(victim), v=
ictim);
>                                 dput(victim);           // unpin it
>                         }
>                         if (victim =3D=3D dentry) {
> --
> 2.39.5
>
>

