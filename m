Return-Path: <linux-fsdevel+bounces-59090-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64289B345C2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 17:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24CA75E2375
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 15:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87C02FCBF1;
	Mon, 25 Aug 2025 15:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BKYNwyzG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779B72F0C55;
	Mon, 25 Aug 2025 15:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756135718; cv=none; b=Q4/uegZv1VqdvgTtYKqbPoW44CnxAQ0f7wH2S4DdtwFXIp3eFCwVQ7I7AC1/P5InCYZsr3d0mnA6yNqkTRDtjH77T7Kl+EaJ+LzSV5J89kaxByxJ6I66MH81QyLagx3Sn7Kd7YlRnYb6a5amMvJ2kKeufVRzNUbxDS/JnT9WoFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756135718; c=relaxed/simple;
	bh=IWpzwcrehe85J/geGPMQJAOvmAatUECDj1Pge6kqj14=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jIBdPTePmKdwQeF48RVjV5Erur75cplU4Wbr2xCRmXaKI6X5sRGTuXb/+TQeooxUYSP7xL2nC/ow8WrUFPs+TQF6vMgVg9YaoDhTfMiQAZczHTwuyy0Urq6GhmfhGrvxbTeDWix8zRNKuxuoBBA7p3mZpLzw1cNkemRoMiaHw28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BKYNwyzG; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-61c4f73cf20so3248572a12.0;
        Mon, 25 Aug 2025 08:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756135715; x=1756740515; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=47AW27LEnnJXypb5y1Qz0IzTZSNqhhJiJIDrXg4ead0=;
        b=BKYNwyzGwgLT6tUZmD2j2wNWyoG2FGJnKc6rcTHf2JdjSInc//Nc1nIgLSZCUbaPgk
         O8+9e+Y7YI6fsAeqgWhf9pgVh/LkzZEJEopSeCn3KMOpN0wMIDZ8/7qXcC+Bqz+YQJjN
         pWNMaK7sUp1o3M+yAt5bMpuGRRLa8H1dTJbmL4THDV+I295c/o+/yA1rLyud/fkAFJdD
         mtI4bfGIGSh7VBwJrHDG7dVnUAx82FWdoK+AWSWpADoZ49d/4hWtn44BCJ91OXsxmJ1/
         XC6+KGFr+M2uzP0aVv8LdMhtzICijj1xMOo5pTUPJwxxkWLN3iw46r6pXKChkFMLJs64
         +PgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756135715; x=1756740515;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=47AW27LEnnJXypb5y1Qz0IzTZSNqhhJiJIDrXg4ead0=;
        b=U+x6lzHtUxNS7gNeXwPvqfGrtmxZyPAncFs0+AMlFy06t/6KLq5kE3Q50lqeKkTFnW
         YgkS71sGSpRBSSUk863Rn1hlrhiMCk+yQ8quAuLBBbAwYzYXFg2APUuUDO3oHG4GXJw1
         4e6Pw1A2x8S7OMV/sK7Uy1vWOzITbwFZOmfXxapiBzy+ghUfO1NvcPIbLqnYZlAThW//
         +GMn9dnVmYMcFet3KqxMislkOwL2BBpqK5/rtnggVedDt8DrS2GsKLh3nM/tr0VZgxgx
         xgvVqyS3U/Fk/SYnbKUXpZKFUc+anVUdwbfFVLvp7VURA0lzfUq4pvMZmF3AWej8aD8X
         FZpg==
X-Forwarded-Encrypted: i=1; AJvYcCVbER8CeoPsMP0oU/v1eHVusFtUZnooqZvZOCccFlujeocU3q0v4AVdL0Hisl2oM3OqhxuUtWDu+v+njnajBA==@vger.kernel.org, AJvYcCVwNxE3ToxfRPfU27GFCAGD0c7m1Nh+AUfeOBgk+q3/Yt9BEohRrVFaqznUSLtKc1IcloNMUO6pdYJCmtBN@vger.kernel.org, AJvYcCXhHhIXlHma4AtcSxdsHBNZPj1uGCFkLp2f8OTNGoDY6q/LNHP/KN8fLCNjIdMGzXy8mBlSDU0rpfZE8TQl@vger.kernel.org
X-Gm-Message-State: AOJu0Yxmvs4Z+4Vx+h0/PaerFpKeLA1POBfIo+SEREC4Dis2sG8JMdpl
	IKDKkB/PdtLTjnmx0slrD2qpM7xmvStYa4zs/BO4T3oItecrt/vUBxaDZVZVF7RBFbf2ITXW8WN
	YPQ4WFoHostTH5iM4LbOcVFyd2KnQh3NXO4kMrdI=
X-Gm-Gg: ASbGncu4oXmAzHyLwZGIEVVPOKKd344f/XiP4WhpVYe8tIydVczlIqXAw23G4BDMCXu
	H0jlOi6TDc0oLzSvvXfGTPauPKDhGKt3fuxDBEooe1YCwhQqo9u6S2CCNsxAVqmf6bXTLddtEkZ
	Yyci/H1qajNwoEjdSP5frpd8epK9saYFIAM+I4kvs6SjW8MxBslE41JxevW+GAVZtTgEGR6nU4A
	JKz5avbG9bvETweMA==
X-Google-Smtp-Source: AGHT+IHDRMzC68NK/baYwoWBqtv/LGW/rQGNgLXeDM44dwJ5Sno9kqTuCljzjt2eVXS1E2wyp9qTdPOQfXLjVD2kLRk=
X-Received: by 2002:a05:6402:26d2:b0:61c:7902:54a4 with SMTP id
 4fb4d7f45d1cf-61c79025bb4mr1924818a12.8.1756135714598; Mon, 25 Aug 2025
 08:28:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250822-tonyk-overlayfs-v6-0-8b6e9e604fa2@igalia.com>
 <20250822-tonyk-overlayfs-v6-1-8b6e9e604fa2@igalia.com> <87sehf4lv9.fsf@mailhost.krisman.be>
In-Reply-To: <87sehf4lv9.fsf@mailhost.krisman.be>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 25 Aug 2025 17:28:23 +0200
X-Gm-Features: Ac12FXzEhNWWI-1052eKsMa5Vb3C_fpFdUbJD8reH5ZkZXcCUkI9LT-sgtV59cU
Message-ID: <CAOQ4uxgF8zuEbzWerj+Gz1BhJCVtGNmLE6gYTmvEw-vv0yEmYQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/9] fs: Create sb_encoding() helper
To: Gabriel Krisman Bertazi <krisman@suse.de>
Cc: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Theodore Tso <tytso@mit.edu>, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 25, 2025 at 2:38=E2=80=AFPM Gabriel Krisman Bertazi <krisman@su=
se.de> wrote:
>
> Andr=C3=A9 Almeida <andrealmeid@igalia.com> writes:
>
> > Filesystems that need to deal with the super block encoding need to use
> > a if IS_ENABLED(CONFIG_UNICODE) around it because this struct member is
> > not declared otherwise. In order to move this if/endif guards outside o=
f
> > the filesytem code and make it simpler, create a new function that
> > returns the s_encoding member of struct super_block if Unicode is
> > enabled, and return NULL otherwise.
> >
> > Suggested-by: Amir Goldstein <amir73il@gmail.com>
> > Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> > Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
> > ---
> >  include/linux/fs.h | 11 ++++++++---
> >  1 file changed, 8 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index e1d4fef5c181d291a7c685e5897b2c018df439ae..a4d353a871b094b562a87dd=
cffe8336a26c5a3e2 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -3733,15 +3733,20 @@ static inline bool generic_ci_validate_strict_n=
ame(struct inode *dir, struct qst
> >  }
> >  #endif
> >
> > -static inline bool sb_has_encoding(const struct super_block *sb)
> > +static inline struct unicode_map *sb_encoding(const struct super_block=
 *sb)
> >  {
> >  #if IS_ENABLED(CONFIG_UNICODE)
> > -     return !!sb->s_encoding;
> > +     return sb->s_encoding;
> >  #else
> > -     return false;
> > +     return NULL;
> >  #endif
> >  }
> >
> > +static inline bool sb_has_encoding(const struct super_block *sb)
> > +{
> > +     return !!sb_encoding(sb);
> > +}
> > +
>
> FWIW, sb_has_encoding is completely superfluous now.  It is also only
> used by overlayfs itself, so it should be easy to drop in favor of your
> new helper in the following patches.  It even has a smaller function
> name :)

Heh. ok maybe we should.
I'll wait for Christian to decide how he would like to funnel those helpers
and maybe he has an opinion.

Thanks,
Amir.

