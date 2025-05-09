Return-Path: <linux-fsdevel+bounces-48539-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E99E3AB0B7E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 09:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE6B03AFE4C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 07:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E61926A1C9;
	Fri,  9 May 2025 07:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q+sZxWDq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3220C8F64;
	Fri,  9 May 2025 07:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746775282; cv=none; b=H8qPXzOqsi0g6N8f+YIrsg1uiGdJXFazvR8Ci9DKay7F5+Jp6iTq9kFhIdK8NFutI+KmR+zmjfGwC0T22pQEXKLONhN8Ss0q+4ihU5QjGFfnPeiWpcpg0erojGim85OWMx1DqWoXAPrjCFNPt1wNWLl8R5+BXGj5O9Et155kvCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746775282; c=relaxed/simple;
	bh=AU97mTucFD8huV9girVLcsarctFzJeJaKwanWY6F4Dk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VNG+hVglzaCwqNZvZwUyrmke+79CILoKMFml0KifKlpix5VRn91rQPLhbrNGlQPphgdmHgH2K3MQxKNuwuGP1cJAxIH25PsbmsVnVajFIrhApwhIAufW/GEdjQxh3PxAvjwIaw4hw72nRD77nw1nhXwRSD2fFHv6Exvp6yTLGnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q+sZxWDq; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ace333d5f7bso306656366b.3;
        Fri, 09 May 2025 00:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746775279; x=1747380079; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GIO49LvjU1ArzBRt+DVSk3+lysp0QTnWTNGBa5IZDHw=;
        b=Q+sZxWDqOUctnGtnqquR0tDR99wokV9cJULgoN2BC8ITkj06ThFUgMk5/675/j1utE
         1LBxHGDhlywJBZIo6u0rNTwqDI+Ouj54JAdhgr1ORzt1NoGRLjfkB75zFyRS9Qelfbji
         jCuAxRyialm2et8dbNe1bhI+I/ybmYz4O57FIkWl1yBJdJZ5HxqVmbsZBppneTx1Q26j
         fWNtpl20rDbKlILE1eeQ5XI7XBE/sD4A50JJeHq9uCL3OiQHlQqYVyBwrRjwTdWjNIhr
         GSkI8TKt0wqIrUTU8Tn855PGt0eylKUVbXyD8wuqoNyRLmohb0MHaPOdew8k5OYtjBru
         UOYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746775279; x=1747380079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GIO49LvjU1ArzBRt+DVSk3+lysp0QTnWTNGBa5IZDHw=;
        b=uGzjazD32kaAoJSBoQYliNhhbfhROVrkmX9xDAe+eWzjIjD4NoULC1dEjtEGKQ57ni
         NWXutVgICcIMI89exDR0LxlEhrujnsg+oulpitM3Jpc0O4XB8sZ8utliWrZp5NGGGHZ5
         wB0DlDxryp+xLHCeb2gxFPrZ4eStKn0Swtxi4m4V0aDKSMTQDHDHUoC/8wgMEvZgQQJe
         xAPBFht43R65HpVvdUuftga6SO2F5k6zjs8g1kXK8b/MWJzqq9tuakBLZgsFXx7L1JMA
         PO5ig7iBE5mp9L01l3+zGeGBomt5kaSxbSzg9R99CagUt5ahwCxrM6kxP7qqhRdgjjLx
         Y/xw==
X-Forwarded-Encrypted: i=1; AJvYcCUBQuDhgtYOgYEp9HWI2b3yxwOh4MIMUYGlb7w/xFXwwv6lP4xt2JMuKU30VD4Fc8OI1jrwQuSa1uGCG54/@vger.kernel.org, AJvYcCV896HGnzOPPk17bsfAdSUsAxPyFIklecbjLnJOEprL7rZOAQT3T+UT7+JgQJmvAZjCvFp/DdOnJ4CKqSeb@vger.kernel.org
X-Gm-Message-State: AOJu0YyIQtOkC0KHsZG+tDaESOulbpgGR6fNlEgapayksjheyWM671sM
	7zFZ7R6Wq/redoi2JzVuqr+kg4qnufBjxVTpLxSplNcqn7GQrFfhTp9BdDYZ0m3684JlOqBZiJP
	fvaim8c1R7a0F/20t7rDzmEbhmak=
X-Gm-Gg: ASbGnct34EyM0URqPqCIvfgSAMJjGAJMX9sTLKYyMJUZn0OBf/RyVz5nIr7T1mH8upU
	AZdNyVncQUGw96FikwvHZz0KkYGtkeP/6XU1rBHY2VR+rhrEOCz0wWMmaskAO87S0gcrZE7Uc82
	dEkFEjMcCgGrLfW+EpLezcQw==
X-Google-Smtp-Source: AGHT+IEEEWHj6h3X59Q9RMPV3W3nRGeDebR0nHC6CB7xQbEGZmQHmK7xBc9IR7w+nEug5cevPajg7B19/65D/tLbN1o=
X-Received: by 2002:a17:906:8e0f:b0:ace:6f8e:e857 with SMTP id
 a640c23a62f3a-ad21880d6a9mr209438166b.0.1746775279256; Fri, 09 May 2025
 00:21:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250509-fusectl-backing-files-v3-0-393761f9b683@uniontech.com> <20250509-fusectl-backing-files-v3-1-393761f9b683@uniontech.com>
In-Reply-To: <20250509-fusectl-backing-files-v3-1-393761f9b683@uniontech.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 9 May 2025 09:21:08 +0200
X-Gm-Features: ATxdqUFBQx08WpmlPn6LRFl9_eMPAokWkmeX_591NcQm0jWfFh5a1CETU74LTm4
Message-ID: <CAOQ4uxinMMXY+vmu4nVLqTKSoDqUjDjH3D7VaPUQOa2b-N3AKw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] fs: fuse: add const qualifier to fuse_ctl_file_conn_get()
To: chenlinxuan@uniontech.com
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 9, 2025 at 8:34=E2=80=AFAM Chen Linxuan via B4 Relay
<devnull+chenlinxuan.uniontech.com@kernel.org> wrote:
>
> From: Chen Linxuan <chenlinxuan@uniontech.com>
>
> Add const qualifier to the file parameter in fuse_ctl_file_conn_get
> function to indicate that this function does not modify the passed file
> object. This improves code clarity and type safety by making the API
> contract more explicit.
>
> Signed-off-by: Chen Linxuan <chenlinxuan@uniontech.com>

Feel free to add:
Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  fs/fuse/control.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/fuse/control.c b/fs/fuse/control.c
> index 2a730d88cc3bdb50ea1f8a3185faad5f05fc6e74..f0874403b1f7c91571f38e4ae=
9f8cebe259f7dd1 100644
> --- a/fs/fuse/control.c
> +++ b/fs/fuse/control.c
> @@ -20,7 +20,7 @@
>   */
>  static struct super_block *fuse_control_sb;
>
> -static struct fuse_conn *fuse_ctl_file_conn_get(struct file *file)
> +static struct fuse_conn *fuse_ctl_file_conn_get(const struct file *file)
>  {
>         struct fuse_conn *fc;
>         mutex_lock(&fuse_mutex);
>
> --
> 2.43.0
>
>

