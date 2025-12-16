Return-Path: <linux-fsdevel+bounces-71461-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A234CC1FEE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Dec 2025 11:40:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 181C93037534
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Dec 2025 10:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502A833D6D3;
	Tue, 16 Dec 2025 10:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Xsb6jJOw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD1833D6C4
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Dec 2025 10:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765881609; cv=none; b=AR1yW5pTxy/Q+ukJ72U+kTGCcPi5e/XI7v/PtzpmLu5amVmU1UKBrPzwd1Uqw5XC11tTbV8K+IQoKoK8GhR264GYEDOKKHCTyt6UYx+H8uve2/Tuj9DHN/j2g7xO80s7QRAt+hcYrrz/3wnJOvv4vOzuE9MlusjTvzU2Ykmsbh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765881609; c=relaxed/simple;
	bh=R9Tb8whQoT3JDFy4+8xkeYUsiQfJdy9DNDXFZ9/6UQA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UIhDSk4jn/1vO9mmCELo4o+v/TwlWtLM04cvON3Zsc+Gi7Hl00IJVElSDQ3IzZYv0Kl6Y+KLJCBrwghGQTyflLYfG6ALojLFOAz778U2Yu72TRB+33yjrhReNaU+5k5fR/9PSUWDYyO55cxuOK4iziCGbMnUzC+Lu6T5jy3Dvcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=Xsb6jJOw; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4f1aecac2c9so48879531cf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Dec 2025 02:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1765881606; x=1766486406; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OWvXmhU1Eg9uCDeh/PMgWMisx9j6I/VJvmFEqitj/PY=;
        b=Xsb6jJOwEbwlNyRY4Dz1EGe24MbrhpvWQYLJU9II1p9EH5FYBtcCeOc591b43Y26iB
         CSnr3ApJupp/nNlS7oOA+OP+5aWKO29IboZT5WEZiROONoHnl2n0FO5AY9IPQvcoqK3L
         idFb6Tru2bkq574HPVBlzeVtxRzl2IsLOqoBA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765881606; x=1766486406;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OWvXmhU1Eg9uCDeh/PMgWMisx9j6I/VJvmFEqitj/PY=;
        b=cW4jxYKRVA5pM9KhAdDV0Bxh1ClvYxqNL7yAutHDclM6cTF2u7EW/XDfAfMATIzmzj
         tEtLZzb5NehdelhqDW9ioemEIQwsbRL5A98H0iHTkIKiHnU/tZl+Xt6sjEHKulaqET0D
         af2my1ztrPXvvUQcQa+OlCUpJ+9OoKhBDyCTTATaXvHjY3NpM62uKCNH9PlqdRxTSs0o
         cuDhB+bEgOiHhHHjN4DL23XIjDPNCxg+kL3kVP/WI2QgsyXOueXA+6B6Vz2e9xjIOwL2
         4WOZG6BccqTJiqDhryg1gbDbV/NqdVKfUy6rPgeI8nxNj7ji+RbK+wPsPwJgYE6RcalP
         XYSw==
X-Forwarded-Encrypted: i=1; AJvYcCWNR/jcOP8gOAGgENCKSNObC3khetNW/HGqHgN55GkUaml8El/BbDygnKryRDcv25wU83lHijiI/OOei7LQ@vger.kernel.org
X-Gm-Message-State: AOJu0YzSFxV8q3LzhczYS2M7spr6qQ7F6bC84fgVCCFFf9ayY0jIcxnf
	WjPDainjNHLgO7+dlWBAmL7QWO84xWy16Y/9MouWNyLQUL2CzDouF7IReXxTilC6Fhm06UakqA8
	6zgPylrjnseDabkUoF/YkgUJvNJGObxM4Sj/FnswBqA==
X-Gm-Gg: AY/fxX5yKYBtKwDBR0H2z8gV3cQc0CpfHohXo0iN0rtfyEoj4wD8hae7jtFAWnR8UXc
	RMW2tu5ohB6x+rktUQbhvd0MtqjETZpRSbCgGTROx1lKZwi4UNRaz5WHgOB1op4tEdnIwoqGGo9
	JmcZIQv6gY0FuVa8+CzEiiRYPiLHjQe0uPJZH4X6diJIDDGTyMxnFRsNPGGPgAhnkLtagiu4uZ6
	wv8au8QEkpA0xGVC4CRRa2mBlZcez4iRP42dFOU4iPShdHeRhTw3/rLPx54ODhfL1e45bwsUMKU
	7oAZsw==
X-Google-Smtp-Source: AGHT+IGyvp1IcpTAoE2oiN1Ja/XossQU2f1A+DqDhbx6/D8cc0lSjHfy3V0E9sCrCA0UqCLbiuuNFzm4VFO5RUXrXSE=
X-Received: by 2002:a05:622a:60f:b0:4ee:17c7:8996 with SMTP id
 d75a77b69052e-4f1cf311c95mr199863951cf.14.1765881605822; Tue, 16 Dec 2025
 02:40:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251212181254.59365-1-luis@igalia.com> <20251212181254.59365-5-luis@igalia.com>
In-Reply-To: <20251212181254.59365-5-luis@igalia.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 16 Dec 2025 11:39:54 +0100
X-Gm-Features: AQt7F2rmP45n9HroB0YsDQUb5fy_Ft-x_wr7vOjYbMk4UW0uZp2zIyWVzc67Iv0
Message-ID: <CAJfpegszP+2XA=vADK4r09KU30BQd-r9sNu2Dog88yLG8iV7WQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 4/6] fuse: implementation of the FUSE_LOOKUP_HANDLE operation
To: Luis Henriques <luis@igalia.com>
Cc: Amir Goldstein <amir73il@gmail.com>, "Darrick J. Wong" <djwong@kernel.org>, 
	Bernd Schubert <bschubert@ddn.com>, Kevin Chen <kchen@ddn.com>, 
	Horst Birthelmer <hbirthelmer@ddn.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Matt Harvey <mharvey@jumptrading.com>, 
	kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 12 Dec 2025 at 19:12, Luis Henriques <luis@igalia.com> wrote:
>
> The implementation of LOOKUP_HANDLE modifies the LOOKUP operation to include
> an extra inarg: the file handle for the parent directory (if it is
> available).  Also, because fuse_entry_out now has a extra variable size
> struct (the actual handle), it also sets the out_argvar flag to true.

How about adding this as an extension header (FUSE_EXT_HANDLE)?  That
would allow any operation to take a handle instead of a nodeid.

Yeah, the infrastructure for adding extensions is inadequate, but I
think the API is ready for this.

> @@ -181,8 +182,24 @@ static void fuse_lookup_init(struct fuse_conn *fc, struct fuse_args *args,
>         args->in_args[2].size = 1;
>         args->in_args[2].value = "";
>         args->out_numargs = 1;
> -       args->out_args[0].size = sizeof(struct fuse_entry_out);
> +       args->out_args[0].size = sizeof(*outarg) + outarg->fh.size;
> +
> +       if (fc->lookup_handle) {
> +               struct fuse_inode *fi = NULL;
> +
> +               args->opcode = FUSE_LOOKUP_HANDLE;
> +               args->out_argvar = true;

How about allocating variable length arguments on demand?  That would
allow getting rid of max_handle_size negotiation.

        args->out_var_alloc  = true;
        args->out_args[1].size = MAX_HANDLE_SZ;
        args->out_args[1].value = NULL; /* Will be allocated to the
actual size of the handle */

> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> index 4acf71b407c9..b75744d2d75d 100644
> --- a/include/uapi/linux/fuse.h
> +++ b/include/uapi/linux/fuse.h
> @@ -690,6 +690,13 @@ enum fuse_notify_code {
>  #define FUSE_MIN_READ_BUFFER 8192
>
>  #define FUSE_COMPAT_ENTRY_OUT_SIZE 120
> +#define FUSE_COMPAT_45_ENTRY_OUT_SIZE 128
> +
> +struct fuse_file_handle {
> +       uint32_t        size;

uint16_t should be enough for everyone ;)

> +       uint32_t        type;

Please make "type" just be a part of the opaque handle.  Makes
conversion from struct file_handle to struct fuse_file_handle slightly
more complex, but api clarity is more important imo.

> +       char            handle[0];

uint8_t handle[];

Thanks,
Miklos

