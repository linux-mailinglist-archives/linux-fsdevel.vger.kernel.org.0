Return-Path: <linux-fsdevel+bounces-19327-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABEE58C3310
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 May 2024 20:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E8C0B21203
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 May 2024 18:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9AC61CA80;
	Sat, 11 May 2024 18:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Aycj8Hpv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60A31BC41
	for <linux-fsdevel@vger.kernel.org>; Sat, 11 May 2024 18:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715450762; cv=none; b=Hrj3tXmvxPoLbWEKD32y9iveeq5Ohexvkr9ppZ3hmd8jg64Jqd+qACMj3THWxuAG9ShJO3H2qQxgSuS3FG95bK/o0bkWMwK8d+tVvHSEpcOctePTFylLsQEj8eDdTxsLAGhr6qF6OVup0gv5AM7ncxcptXsIP4ynnTARFLx2FX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715450762; c=relaxed/simple;
	bh=PL1HkVXjNKI3duHapiyiZE4LMd/ACe8pxv1s+k6AqkQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KE+/W3YgNh9/5WsGUmj+BBP99WXU/Nnm0pbzeC94FG1nR5QbVODROlCa8gMOoYhxODmxX11zOm+1Z5tXv2qw9WpGweqeqY+Qe5oz9u3RoD20Pp/DIjrdPT+hNO7oSydHeYtXhEOv3qJlDvyJdjXKZFkz4lnzZHQ7YdSAndGTkbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Aycj8Hpv; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-51f1bf83f06so3663659e87.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 11 May 2024 11:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1715450758; x=1716055558; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1foWdcCDtmid0a9X2m1kIuYXll/LwTPlL4vJLBW01/g=;
        b=Aycj8HpvGeUHZ/ex5q2kY12u6Cx2osTx2H9OJyKe5MloFTGGosS+RubINBYpWxMgZf
         sQ5CBCzXjZqI/qJ1xW8WttuUMtsGRs+d25HSXQgsWRt7nVvACqaDtK37V0W7Bl5enqtr
         WsZ7JoQUguIx15IXsToHwnE2rpPaYsO4Z/Ry4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715450758; x=1716055558;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1foWdcCDtmid0a9X2m1kIuYXll/LwTPlL4vJLBW01/g=;
        b=hCEZBHJVX0ZxVQl5Otb7/4TYM2ZpTwSIFslZ0fTZWvzWNABcWJDjfCXqLG4qBnqBIe
         afRONPSPRung+PO5hEf4CD5ugsYrsUrFGVh/RGxNhpkru2DddtfK2whwKT4jNoiYJjuZ
         vuw3DIQuq++HsnfCbjV6i+LyooRoM8M7WtVuBu4MMCX8/oH6IpsGUidD4U5DBIzINY0b
         KtcUcMObmwpDW+x/+v27AUEKSClUUyD1H8e1PAj7RvhOTHw1Pb4Kq3y3+O2WJ8aA24Nx
         mb4E8ibACSVNP+3PgHzlZCaehzz7FKDbUKP6hjM66XkVApga/6YA4Hks5v9PoNa2Ul0R
         jwnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMcqoMG5n+KdXRzMLJYJqb4IT4ZBXLBAOcUjDV8LDXTRz0yuQdNiPg2CpcseBzEFO3DD4VJK0DHJ+JF88RJ2x4q96Tcj9BJHFZ8C3l9g==
X-Gm-Message-State: AOJu0YwLy4p8fj2h8otVC4Kyvsc65GN4jmVqONYeoDRfNakBouIw1ZqJ
	sjhCCf8Joice3ILl5sMXMtHj+MXd1PqqM7qfXbkNTSJZS8GlgGDCsJgI8j50XIWh+e/XUeIF3HL
	bLtEV9g==
X-Google-Smtp-Source: AGHT+IE7mhrcpMYhE1y2qDWf9u+bGxVjbyFvaHi9N/rQMhxUa7Ao3Eo2cCmZ7THU2KuwU4gcxbOjcg==
X-Received: by 2002:a05:6512:1305:b0:51f:452f:927b with SMTP id 2adb3069b0e04-52210070208mr4219772e87.45.1715450757872;
        Sat, 11 May 2024 11:05:57 -0700 (PDT)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a1781e97bsm354141266b.32.2024.05.11.11.05.57
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 May 2024 11:05:57 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a59c0a6415fso856455666b.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 11 May 2024 11:05:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX3iSDNS+jpHf1hpdsCZr7yPYU8sA3j2Ccta6lrFnuspcRIsolB039MK+5LI60Yi/wHB8eBxRmdUMzKMVb8SeInDX/sn/qBrv2ZpOS2FQ==
X-Received: by 2002:a17:906:a08:b0:a59:c3e2:712f with SMTP id
 a640c23a62f3a-a5a2d536941mr346954666b.9.1715450756631; Sat, 11 May 2024
 11:05:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240511022729.35144-1-laoar.shao@gmail.com> <CAHk-=wjs8MYigx695jk4dvF2vVPQa92K9fW_e6Li-Czt=wEGYw@mail.gmail.com>
 <CALOAHbCECWqpFzreANpvQJADicRr=AbP-nAymSEeUzUr3vGZMg@mail.gmail.com>
 <bed71a80-b701-4d04-bf30-84f189c41b2c@redhat.com> <Zj-VvK237nNfMgys@casper.infradead.org>
 <CAHk-=wiFU1QEvdba4EUMtb0HXdxwVxqTx-hoBbRd6E4b8JkL+Q@mail.gmail.com> <CAHk-=wg7ofKHALbEqzXCz9YMB5nyCzT8GnBLR+oxLnAAG62QCg@mail.gmail.com>
In-Reply-To: <CAHk-=wg7ofKHALbEqzXCz9YMB5nyCzT8GnBLR+oxLnAAG62QCg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 11 May 2024 11:05:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=whvo+r-VZH7Myr9fid=zspMo2-0BUJw5S=VTm72iEXXvQ@mail.gmail.com>
Message-ID: <CAHk-=whvo+r-VZH7Myr9fid=zspMo2-0BUJw5S=VTm72iEXXvQ@mail.gmail.com>
Subject: Re: [RFC PATCH] fs: dcache: Delete the associated dentry when
 deleting a file
To: Matthew Wilcox <willy@infradead.org>
Cc: Waiman Long <longman@redhat.com>, Yafang Shao <laoar.shao@gmail.com>, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	Wangkai <wangkai86@huawei.com>, Colin Walters <walters@verbum.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 11 May 2024 at 09:13, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So better batching, or maybe just walking the negative child dentry
> list after having marked the parent dead and then released the lock,
> might also be the solution.

IOW, maybe the solution is something as simple as this UNTESTED patch instead?

  --- a/fs/namei.c
  +++ b/fs/namei.c
  @@ -4207,16 +4207,19 @@ int vfs_rmdir(struct mnt_idmap *idmap,
struct inode *dir,
        if (error)
                goto out;

  -     shrink_dcache_parent(dentry);
        dentry->d_inode->i_flags |= S_DEAD;
        dont_mount(dentry);
        detach_mounts(dentry);
  +     inode_unlock(dentry->d_inode);
  +
  +     shrink_dcache_parent(dentry);
  +     dput(dentry);
  +     d_delete_notify(dir, dentry);
  +     return 0;

   out:
        inode_unlock(dentry->d_inode);
        dput(dentry);
  -     if (!error)
  -             d_delete_notify(dir, dentry);
        return error;
   }
   EXPORT_SYMBOL(vfs_rmdir);

where that "shrink_dcache_parent()" will still be quite expensive if
the directory has a ton of negative dentries, but because we now free
them after we've marked the dentry dead and released the inode, nobody
much cares any more?

Note (as usual) that this is untested, and maybe I haven't thought
everything through and I might be missing some important detail.

But I think shrinking the children later should be just fine - there's
nothing people can *do* with them. At worst they are reachable for
some lookup that doesn't take the locks, but that will just result in
a negative dentry which is all good, since they cannot become positive
dentries any more at this point.

So I think the inode lock is irrelevant for negative dentries, and
shrinking them outside the lock feels like a very natural thing to do.

Again: this is more of a "brainstorming patch" than an actual
suggestion. Yafang - it might be worth testing for your load, but
please do so knowing that it might have some consistency issues, so
don't test it on any production machinery, please ;)

Can anybody point out why I'm being silly, and the above change is
completely broken garbage? Please use small words to point out my
mental deficiencies to make sure I get it.

Just to clarify: this obviously will *not* speed up the actual rmdir
itself. *ALL* it does is to avoid holding the lock over the
potentially long cleanup operation. So the latency of the rmdir is
still the same, but now it should no longer matter for anything else.

            Linus

