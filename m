Return-Path: <linux-fsdevel+bounces-68431-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4536C5C086
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 09:41:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 400F642077D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 08:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC812FC896;
	Fri, 14 Nov 2025 08:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="JaerscKf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3272FB61D
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Nov 2025 08:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763109614; cv=none; b=CAs3BlG4hmETKhnK0SvMxOY4Jwk6am52NTAD4SxK2hIzM1+ZO/AJelW3xnBCnOg/CPjsoU09vy6ak45LUwAKLYhaZMkRLvAs6Sn11S/CwmcKwRQZCOL8KvZA0TsCKYe9Fv//yemYhuHB0lCcHO3iQNhAvhouiCif+Zvcg86JxCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763109614; c=relaxed/simple;
	bh=Jn8ZK4GsZJNhfPPdDS4J79dwH5A2hmQGPFAbZPYlDZ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iS1coWIyq7UkD/ViS+T4zBl2kuyh8fu1of0NuoH3dt6sOJ3cRakgg8aHGrJ5g+6dQblFkTEBpwvKI3a9eunQ0mh9njpOGunsdrpv7QHKh5nFRZxI2guHIkVmRro8Con/rCIuYKcEPoF0l2BxsflPO87djvZRIFvJuJjCv3m4ywI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=JaerscKf; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8b22a30986fso162158685a.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Nov 2025 00:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1763109612; x=1763714412; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1cb48UXKoNWccEdIeoX9cWYHZInUMZC/Q/uZyQIp29g=;
        b=JaerscKf9Gt0IfOVXHrDXPc4rjB6iu3D/2PhERVz+UvL+Hp/DaQciepzxnGg4LEmKs
         3zBrEatTsoW1MKAo5RzPXWQH11mdtxg/XUoT2+jiO4jLdQufkmpK8OdfLmvDTTAdTSA8
         RL6uu9yShSQY9nTNKC49MMdXQqyqci0rqacLw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763109612; x=1763714412;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1cb48UXKoNWccEdIeoX9cWYHZInUMZC/Q/uZyQIp29g=;
        b=kyE7w8ZqLiK4+/JNEtYnFx17rv+RL2OSkKruHNSHNaEddOVUfb14b1UszKkEQ9c+kB
         s7uXmtsCS5XPr07dBdJB+f2RQaz4z4YnsTkT6Xxdidi4DhaUcBrpQR1usbs/PS5RkBaD
         mnRHduhQwCaDtkgiwRJ0dNfDsqI7oqQ5Yl5+1vo7WDyvMTm0pDqh5LxQpSVHSeXdzzH2
         JcAiXri+870DvkOtBFkH5hCYcWP03Zk0tNFfOd+wiUgK0QdZveRYzynptSmZM8t531JZ
         yVn9Zx9JL2nZ4d3CRBhXTzgIqR02kmUpccOt3Lmy26/q6HUCQUda/YOsmsDHSsEOvKFv
         k2Mg==
X-Forwarded-Encrypted: i=1; AJvYcCUE5Scvle5ZNlyp2ZE41SrSIOZkcGC61picm31t8t4o7eV5OVSCNHYm49Cx3pcc9lsq52oSBORQ50L78+jV@vger.kernel.org
X-Gm-Message-State: AOJu0YyGPAaA9ZZW/xXzOY3eORhS2GFpoLIaRqCZPX9tG9WniXM/gN6o
	srHmcvsyJ+CrqbDHbAKxh0xji4hh8HHexYGJsWE6bW6RJXLIS9RkwWZB5gULqgRXzkq3mcSrzCb
	8WXIU1lEO59Kjjr4p5GTy1Rcp6Xmxgv92Qsm42hTcng==
X-Gm-Gg: ASbGncsOISjO5U3FtLP0qwyc+XZUZ8bUkdfNK1B7UOQbzJe8ZifjzMsdDhsYzg97uiD
	y+Sjpjte+FEUkjJAUs2KB3lue+6XQuCIr3N0KQ3wtC0/CTGTsw1x54Dtu6jgxfbxHPOz04euNdb
	Q8kn5qMBBCW1RS8dcAdaTCnQU4oXZsbVPjy0Mz/j8hnGy0gjpQiuvTP/rs8OoSeVCXedEjbvqLn
	eXfc7E4JwyRwI0T3dwgKuaA1BuUHyN4wrpzqH64aRKisFssx/FPS7wYzMljvAxJB5oJe+Aq3qOf
	Vq52DUgoqc7XNPnIgg==
X-Google-Smtp-Source: AGHT+IEYExGpmwgALAyAiE3bEbEH/l/xCZ02vI9A1961kA1r2jyxfrOAGS78MScKS2e7ZhLHtivgMnRQvyxPd2Dbf0o=
X-Received: by 2002:ac8:7f41:0:b0:4ed:659e:efb4 with SMTP id
 d75a77b69052e-4edf20ed3c9mr35717331cf.46.1763109611844; Fri, 14 Nov 2025
 00:40:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251113-work-ovl-cred-guard-v3-0-b35ec983efc1@kernel.org> <20251113-work-ovl-cred-guard-v3-25-b35ec983efc1@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v3-25-b35ec983efc1@kernel.org>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 14 Nov 2025 09:40:00 +0100
X-Gm-Features: AWmQ_bmJYP551kqV7yMygpjJTx-gYuODzKKt9DdL2vHc4nXcnFBKdQ-lI-eZMVE
Message-ID: <CAJfpeguUirm5Hzrob=pBVgANym9wdJAEN1w7zEEuv-aW3P0ktw@mail.gmail.com>
Subject: Re: [PATCH v3 25/42] ovl: refactor ovl_iterate() and port to cred guard
To: Christian Brauner <brauner@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 13 Nov 2025 at 22:32, Christian Brauner <brauner@kernel.org> wrote:

> +       /*
> +        * With xino, we need to adjust d_ino of lower entries.
> +        * On same fs, if parent is merge, then need to adjust d_ino for '..',
> +        * and if dir is impure then need to adjust d_ino for copied up entries.
> +        * Otherwise, we can iterate the real dir directly.
> +        */
> +       if (!ovl_xino_bits(ofs) &&
> +           !(ovl_same_fs(ofs) &&
> +             (ovl_is_impure_dir(file) ||
> +              OVL_TYPE_MERGE(ovl_path_type(dir->d_parent)))))
> +               return iterate_dir(od->realfile, ctx);

If this condition was confusing before, it's even more confusing now.
 What about

static bool ovl_need_adjust_d_ino(struct file *file)
{
        struct dentry *dentry = file->f_path.dentry;
        struct ovl_fs *ofs = OVL_FS(dentry->d_sb);

        /* If parent is merge, then need to adjust d_ino for '..' */
        if (ovl_xino_bits(ofs))
                return true;

        /* Can't do consistent inode numbering */
        if (!ovl_same_fs(ofs))
                return false;

        /* If dir is impure then need to adjust d_ino for copied up entries */
        if (ovl_is_impure_dir(file) ||
OVL_TYPE_MERGE(ovl_path_type(dentry->d_parent)))
                return true;

        /* Pure: no need to adjust d_ino */
        return false;
}

>
> +static int ovl_iterate(struct file *file, struct dir_context *ctx)
> +{
> +       struct ovl_dir_file *od = file->private_data;
> +
> +       if (!ctx->pos)
> +               ovl_dir_reset(file);
> +
> +       with_ovl_creds(file_dentry(file)->d_sb) {
> +               if (od->is_real)
> +                       return ovl_iterate_real(file, ctx);

        if (od->is_real) {
                if (ovl_need_d_ino_adjust(file))
                        return ovl_iterate_real(file, ctx);
                else
                        return iterate_dir(od->realfile, ctx);
        }

