Return-Path: <linux-fsdevel+bounces-35098-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 832819D107F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 13:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F62C1F2253C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 12:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1241991DD;
	Mon, 18 Nov 2024 12:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lkg8gMWo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C267973477;
	Mon, 18 Nov 2024 12:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731932424; cv=none; b=mfzU0PK1FC4tVTcHU5FM9oEvCT4khXPdKIPHVvFyKyrLukJdC055+LTyf6JBvDp2zrJrdSgo50vo5Ip6PDsUbYbq9656+CdlA6WxqtuXY5NjiEOJdmLK0ST0nkG839Lvx3KMT3uTEqkN9r6aiBeoqRR21xuCA7/18NxCmrsq6dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731932424; c=relaxed/simple;
	bh=IhI/h80fUah5nG2xsX5MC36XPiFxN7OiHquqoWt4auU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JKVqzO5pQOVIUt2PRk+pyKbdXnZDvBNRFeh1E7umuCQ702mynjAirLlpZm2HJgPNpuS07X7/ZbWna2sluKVABas3HBEy715Pc3RzCW5SZernSPd1Y9/u7llZ4TD+VCtD97b0uZqoOP3jEEhCQbhc/ka+vO8oOF5mdpTYA38i+ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lkg8gMWo; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5cfcb7183deso1245240a12.0;
        Mon, 18 Nov 2024 04:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731932421; x=1732537221; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=91Y+NIQ0g0iO6ktSe6fnjx/GmiuOAuw5cfhfOdvqzxw=;
        b=lkg8gMWo8ZKqQs2GhDm4jAtJ3f9AZdcdKLa1rBDjQX/Bdh5G564kUfIvygvdiJKZc1
         L3cG9jJ9z9XbcWqBlEzSPoCeElmNsfgrfbt7DKTlnrNvNQ0WvTPaGNmyC/cOK6RpMldT
         t9nA3s6RUcw6JyN9CKIdfvkTXh4+yoPnBX/9jlVn2glKslHujBksy19YDY5+I4duuhmQ
         3BHiSDWJ6vFblTzWl1jBuFNhkk3oF8PC8P8sEx1rZzVH3vCiggJhju3mFAbGmw7yj2t8
         x22BWvpRijtcEFeCToHC+tBgiillt2Kdsccoe+xCp0DuKqUvH2vKyHumeqPBzLkbJEwU
         JUtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731932421; x=1732537221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=91Y+NIQ0g0iO6ktSe6fnjx/GmiuOAuw5cfhfOdvqzxw=;
        b=saNld0p7GZjPETmR8Zk3BKmV66mmum2gPWH3K7nVvvyr454y9aXhYt1neDMhZIgaLd
         BaFZRYNRCL9Errnuukrp+Pckv9XBorl8EGXy9G6vvRZEGctEYFsPHJbh7AMqwC4aBV0+
         uV74udR+5HJ47zygiw4ZOt4jWZjA2QC1hSGmcL40JdRS45rPZADiAe+HPSHx1u1CwQ4Z
         dbVviiE/KeL8JTzUhG8N8WjqBVe13YxXmoJ5EBqWGhxj1C5ioRrMOOrtwp9cHoStRvbR
         hk7ZuaPNGlFXqlugSq+3h+KgNu4nqz8suzMhP+h1HS3flLNMqu9PG8QRo9kG/tU77eSi
         iwlA==
X-Forwarded-Encrypted: i=1; AJvYcCUr7BmCHypAmEXTDy8fTBoQDbmAWOkdMi9pu0zdXx9Q0jlh2lT4L5op0W58sSdV1nSY79XKXitVAMJeKzqF@vger.kernel.org, AJvYcCWZnlB1JCV3hd65ThQNY1iezTVzi1AAkRHEQl77Rq718T25kmTbdjDDeq22P74fqwYe/DVrCdveNIR25noy@vger.kernel.org
X-Gm-Message-State: AOJu0YxUOL7sNtV9H+imFuC6fsv+YpZE+bdb4sQFhvxvrGh7/GNkpZmc
	f/777/DeNvf35P/WdBbxsOO736Bb0aq2EBrlEQdgJRcGZuK0d1JJl58cDIrjrHH75krlTWvX8eC
	0Mvhi5LLKRe2OjWa1uVFLyk5QFwg=
X-Google-Smtp-Source: AGHT+IGH4on/EbSLBQIqwiESQGhEX8bQ+wc9QBqriPeieJ05H4CEuJJx0XilNOHUip/VpFUFJyrTkNPOjoYB0KEI4hQ=
X-Received: by 2002:a05:6402:2807:b0:5cf:c187:c76c with SMTP id
 4fb4d7f45d1cf-5cfc187c9d5mr3336099a12.14.1731932420857; Mon, 18 Nov 2024
 04:20:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241118085357.494178-1-mjguzik@gmail.com> <20241118115359.mzzx3avongvfqaha@quack3>
In-Reply-To: <20241118115359.mzzx3avongvfqaha@quack3>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Mon, 18 Nov 2024 13:20:09 +0100
Message-ID: <CAGudoHHezVS1Z00N1EvC-QC5Z_R7pAbJw+B0Z1rijEN_OdFO1g@mail.gmail.com>
Subject: Re: [RFC PATCH] vfs: dodge strlen() in vfs_readlink() when ->i_link
 is populated
To: Jan Kara <jack@suse.cz>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 18, 2024 at 12:53=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Mon 18-11-24 09:53:57, Mateusz Guzik wrote:
> > This gives me about 1.5% speed up when issuing readlink on /initrd.img
> > on ext4.
> >
> > Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> > ---
> >
> > I had this running with the following debug:
> >
> > if (strlen(link) !=3D inode->i_size)
> >        printk(KERN_CRIT "mismatch [%s] %l %l\n", link,
> >            strlen(link), inode->i_size);
> >
> > nothing popped up
>
> Then you didn't run with UDF I guess ;). There inode->i_size is the lengt=
h
> of on-disk symlink encoding which is definitely different from the length
> of the string we return to VFS (it uses weird standards-defined cross OS
> compatible encoding of a path and I'm not even mentioning its own special
> encoding of character sets somewhat resembling UCS-2).
>

Indeed I did not, thanks. :>

> > I would leave something of that sort in if it was not defeating the
> > point of the change.
> >
> > However, I'm a little worried some crap fs *does not* fill this in
> > despite populating i_link.
> >
> > Perhaps it would make sense to keep the above with the patch hanging ou=
t
> > in next and remove later?
> >
> > Anyhow, worst case, should it turn out i_size does not work there are a=
t
> > least two 4-byte holes which can be used to store the length (and
> > chances are some existing field can be converted into a union instead).
>
> I'm not sure I completely follow your proposal here...
>

I am saying if the size has to be explicitly stored specifically for
symlinks, 2 options are:
- fill up one of the holes
- find a field which is never looked at for symlink inodes and convert
into a union

I'm going to look into it.

--=20
Mateusz Guzik <mjguzik gmail.com>

