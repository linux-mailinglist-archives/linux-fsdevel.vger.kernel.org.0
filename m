Return-Path: <linux-fsdevel+bounces-70359-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F1BC9860F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 01 Dec 2025 17:55:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C37D3A3FC4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Dec 2025 16:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB59A335BBE;
	Mon,  1 Dec 2025 16:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GJ9X37Tk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760C0335BB4
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Dec 2025 16:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764608125; cv=none; b=vFkzPHs9L5qA92dCN3kKEx0J0T5MaPxZ5axSZwqmbctlM+75gJMrJeDU/l4fnGGeFm2hhFLWtmI7lGY0p6EjTvzr26JX7remk17FaG0yf49oV0MNUKfICi5b6L8917tqLWVRNJfJsj9jCK0HRFomokneDamy25Gc8tLNw6F/XPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764608125; c=relaxed/simple;
	bh=tnBeSzBy41ElJjUNzaDGRg1rFGe4xN+4QiZQOyT4O+Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SFokcWCQ9X0CkfKkxfJJxQdkM2zGC50QaeJfpu4Bht3sSfDlWZpPnplWCvmJG144M0ckrBwxN1gaLzy4xW73ibMWSzko+n7GqYeKMVJPhkgancxyZhvKB+PEGs9Mta9SjFDJBnuwgzy83Ct5SiHjdqnHBNtXmKPIch1oX4kPomg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GJ9X37Tk; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8804ca2a730so63772896d6.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Dec 2025 08:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764608121; x=1765212921; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4sEVpko+5n0PJOroaHb42D9u1KdHljQU3qjynTesipo=;
        b=GJ9X37TkUuCxtss+oKBzZ89YJ0NLf0DpFV+EwYiunAPVlKcWGYsSV7r8Kw5Tw7XbnI
         EhxP/95SRbLzXJowplUn553x5fgSQf7MCTLICu2VvjHVyZwSljGa0If7LLS9uj/NsbWg
         zZ5zEsoOtrKoHj2ADWf7ONFJCN+Y0WX1fH2wl5C6VD21zUL0eHZS86SzLQ26Phks9kyI
         7Y/KAXn4tvuFRQevd9nQyJFWjRbFwDZYF+shQLI6Zo+oEdEL4DC7lFnZIxWNgplyV3Pl
         1Gv1Nl/FzAjtaSsyLlvnA95dRp7H5EvU0GeqCCmqFDBwpv++XUOegNRiKrHv9DDZDZU9
         rNig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764608121; x=1765212921;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4sEVpko+5n0PJOroaHb42D9u1KdHljQU3qjynTesipo=;
        b=XbocnwS4Zn4pgx4nXwsdbRFgjBQmk50FlO+zvPg3NrIu/UmcpOaF0TKGhU4uam31PY
         7fMe/c9hWowxN1mESCRHhgoNQwkg4htw8zDZjazXKhQ+KDnNVYEk1VmHRi0iKM9b8uu8
         ZaXV1U1+NaVnk/uO7PIHYp6TnQhykhZ4kcMzJCsy0xfniKZxN3oXlX6dkLnbfIMAWgVY
         hkgkN7muJGSu/rp4ei6CXZQ+l2S5k7Oydg1DQT1vXVuGK0HVW01YS7dw4C9NCO6NCjZm
         0tw8J0vmBrS+/nk31Yoxq8SHohuBb626YU7JvJV97ErX7P5KFMEZSAYPfnQDxtAaiMVb
         Zyaw==
X-Forwarded-Encrypted: i=1; AJvYcCVwRU1y9rkwDqSgZYnH7An7Ob3G75gasUZLk9kxsp1PPK1sXIh6Mhx117zy29tk89hzMtSDxQszp9vbI+aT@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5fPyKd5ad4wtXI4bS2V1k3iPuHRtvWubxtjUW7s1f7Wmg0+Lf
	/CquWdsNiGxvomNZyw2L1vu7PhA2VnuFjSO7a7RK0dsYv35A4WUohVD6ZD8PuWuFaz2N91+lKWS
	gikqWjv+deaQNmqD1ut8hBOgJmh5hBgA=
X-Gm-Gg: ASbGnculr1uJt5zIi8updR59aJVv511/8ZoojzjJdf5DcDlQ7SfE0oMoCjXYoHECsTe
	c+RdcA3/FwYW3addB9fETT1NVFRGGRTSpKIeSjj97P1op23BLvPPylLz2+4oBWeHTy90Vxy7UwP
	sPkASAbd5siX9v2xIjX1ayfRWLy3epJRF50QAzd4tdUO3kB1VymqEEzQr1NBS4G1qUtb/uFP3qm
	3D6DkUHad+P9kAYio+HHiCXorx+2lSMEncrHr1Kkn4nnAD0AN4Wsc9N4XVUeLskDSDJhTXDMFHn
	h4yI/Sbng0Hq3rNiA+n0wbw4IK3z/mcFOJwsfPSdMAjQDY9FALtzf7vbuGTh+uziNfWV2tyy44C
	QqDga/ypc2/v1/fhyW9DkwKcOYpiwp5rzuq64bXzfnMc/XORpVoXhkIfsRnB+GnXe4Jx8KNgjtK
	0jHvFaheg=
X-Google-Smtp-Source: AGHT+IEG6R92jICSyFXT632ttWwgPqabGo/7YGPVecrju8YTrqTUBKLOzvnujd7HCxZ6Q3MkFdRGL2qRP8TIEVJqoic=
X-Received: by 2002:ad4:5c6d:0:b0:880:4ec0:417f with SMTP id
 6a1803df08f44-8847c4a3f8emr545853166d6.24.1764608121279; Mon, 01 Dec 2025
 08:55:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1430101.1764595523@warthog.procyon.org.uk>
In-Reply-To: <1430101.1764595523@warthog.procyon.org.uk>
From: Steve French <smfrench@gmail.com>
Date: Mon, 1 Dec 2025 10:55:08 -0600
X-Gm-Features: AWmQ_bn6VuRsE8Iui3zMCTDCVt_cM2s03jlNDIA4eOmN3RT6hBJvlGPPfTBZm0o
Message-ID: <CAH2r5ms9VSfTebnVe24bM7V5TVJkZgG=cOmZrxJo+RCPf1ZgtA@mail.gmail.com>
Subject: Re: Can we sort out the prototypes within the cifs headers?
To: David Howells <dhowells@redhat.com>
Cc: Paulo Alcantara <pc@manguebit.org>, Enzo Matsumiya <ematsumiya@suse.de>, 
	Steve French <sfrench@samba.org>, Shyam Prasad N <sprasad@microsoft.com>, 
	Stefan Metzmacher <metze@samba.org>, linux-cifs@vger.kernel.org, netfs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> (4) Move SMB1-specific functions out to smb1proto.h.  Move SMB2/3-specifi=
c
     functions out to smb2proto.h.

I am generally in favor of those type of cleanup patches (as
potentially higher priority) as we want to be able to turn off/remove
SMB1 code easily and not confuse old, less secure SMB1, with modern
dialects

On Mon, Dec 1, 2025 at 7:26=E2=80=AFAM David Howells <dhowells@redhat.com> =
wrote:
>
> Hi Paulo, Enzo, et al.,
>
> You may have seen my patch:
>
>         https://lore.kernel.org/linux-cifs/20251124124251.3565566-4-dhowe=
lls@redhat.com/T/#u
>
> to sort out the cifs header file prototypes, which are a bit of a mess: s=
ome
> seem to have been placed haphazardly in the headers, some have unnamed
> arguments and also sometimes the names in the .h and the .c don't match.
>
> Now Steve specifically namechecked you two as this will affect the backpo=
rting
> of patches.  Whilst this only affects the prototypes in the headers and n=
ot
> the implementations in C files, it does cause chunks of the headers to mo=
ve
> around.
>
> Can we agree on at least a subset of the cleanups to be made?  In order o=
f
> increasing conflictiveness, I have:
>
>  (1) Remove 'extern'.  cifs has a mix of externed and non-externed, but t=
he
>      documented approach is to get rid of externs on prototypes.
>
>  (2) (Re)name the arguments in the prototypes to be the same as in the
>      implementations.
>
>  (3) Adjust the layout of each prototype to match the implementation, jus=
t
>      with a semicolon on the end.  My script partially does this, but mov=
es
>      the return type onto the same line as the function name.
>
>  (4) Move SMB1-specific functions out to smb1proto.h.  Move SMB2/3-specif=
ic
>      functions out to smb2proto.h.
>
>  (5) Divide the lists of prototypes (particularly the massive one in
>      cifsproto.h) up into blocks according to which .c file contains the
>      implementation and preface each block with a comment that indicates =
the
>      name of the relevant .c file.
>
>      The comment could then be used as a key for the script to maintain t=
he
>      division in future.
>
>  (6) Sort each block by position in the .c file to make it easier to main=
tain
>      them.
>
> A hybrid approach is also possible, where we run the script to do the bas=
ic
> sorting and then manually correct the output.
>
> David
>
>


--=20
Thanks,

Steve

