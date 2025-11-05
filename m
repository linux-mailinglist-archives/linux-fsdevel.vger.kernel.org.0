Return-Path: <linux-fsdevel+bounces-67191-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E02C378D9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 20:52:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72A383B712F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 19:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 090DF34403D;
	Wed,  5 Nov 2025 19:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fKPsnSrj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D22344026
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Nov 2025 19:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762372268; cv=none; b=HZMl9fKmvOwCw5s9AzkJ3ictJfAZbaPVlxbccz8Qbrs0uumSKRT4tltlgwcFVDU5EnwrlhyT0uzbiy6Lb0dRLjKYF4/ozVzjw4DQg2TKQOunqiwt5Wdbpvqctu0hz2EgVpHRJdAZfNgLsTmMXVUaCaKNp2RQSuyKKE334Zp0BOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762372268; c=relaxed/simple;
	bh=Pk0Npog8sZ0LZeV37QkwTxusJxsZmgGiGMBvOdfNujQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aaztWEp21jD51ykAxtDDO4enLwGlbjO3MwGJD54XVevRptrW4vB/SoFmbHGOsG4PxdOX4gr7A3moNcBR8dXxKoWmwKA/TqJ+GbSaOGRd4cMVG7WLIgbZzwOp5XQXPASBQEhGgZY4+v3Z+DYf2WMZQ0LCWwPirzHMeC2QAocLtzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fKPsnSrj; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-640f0f82da9so280832a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 05 Nov 2025 11:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762372265; x=1762977065; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N+1+3F9krAd0V9GErIF2j9xx69fWENxgr7H3lgTY8x0=;
        b=fKPsnSrjCiCv4jP3M1ZD82RU/aJBgWDc/ZEJgPK/Wg03bzylXF+ULvWNeBOdY8b1RQ
         JwToVDXCSsq26TGQeXrhhO3qv94qbqs8PnZWznvVrPQDd//Kap2B7G1+y6eDzTpkWzUK
         Wc76MrDbOBHbTS9VWExAdNC36oBS6D4AMiWf9xq7Dm087eY2KZFZIYe/UyHE5wq20GK/
         RmhTx4FN6hxqNNGfV81M7L6LRmU3u4q8d9fKG+b2evxv4S1Yojp0v+ELlLsJahZYqoOh
         jZqZXUOxH9MYlSB4Y6tItCfAqns84H815hit3dkOJNfgkKPKBb4GFeerhx0rP5PY7tes
         pTgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762372265; x=1762977065;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N+1+3F9krAd0V9GErIF2j9xx69fWENxgr7H3lgTY8x0=;
        b=hrsq9KUYMubFKWepFs1kMefI37Mv3dnKo9PBjU8STMaCqB8n66TgPMXhCqpbp2pEeo
         1XHYjuDV5IqZxcI04WKQ/XP/uqC6m7geGvpTUUd4ONcFdNEsiWk9Qh2u8aY5GDwXmg/J
         NoleGnWsFN5jUTL1jbpUtiJ65aEk7yLPLCqvWgq4VjiOCSwK6HaRJS/+7I3qxN8G/7Cg
         NP9z8hZ/JqrTjX4FXZ1Ix1bYHp1SX+7XqxYQUZcrManX6W+n+O1e3+f0qiAWOCADrjd+
         uPXsPMjhDIvNhQfkOKjt4BnCvrRwmam1OpY2FdW9X4CJZCdXzLEaNNOH40OgfxWsm06z
         vc+A==
X-Forwarded-Encrypted: i=1; AJvYcCW0HhOCNZsHmPsy/wh8JyHzdV+At2X+WnBtyvsRJ6/E4fr0P1g7JYYPvg7wE13vsbXytYt23cYaNfLx1dDY@vger.kernel.org
X-Gm-Message-State: AOJu0YyQvoVgGMhyT2HSx3yYMPNRW2zLLVaH5AkmGAB5BlIB5T3s1zkU
	4yR+cGN06+R0UfZorqaVZjarSbCpUkUMomoh9IFK+vrlXYIecXKKNoid6qrgtgH1uw+M3KYBDdx
	0A+O9f5lacO2r1s5RAaEautewms/D/7A=
X-Gm-Gg: ASbGncuDeJddXEjRV16pt52vSquHEyhczPnfuF6EHctjIDZ6qT02e8EEWQHg9pQijkP
	+z+sG6BB5Wty2RGxE5ophHjuVg19RHi/t1eo+JNT0UlvjZFVfOjnvuPiuPr/OzeQvlF4p3ZsSRj
	Z4qBuYTq7faS29W2Dg7ZaV51aCd8iluTkUXl+aTvEpBRpyxxVtle8OaFkUgvFL6KycysznnuOYb
	jyxHJWeUWtxduxnwkHMk89l3Sx2ZpgutfRBrQyQ4fBfdGfuGlm3K+oqEap3SKZPiuZoGVIpHPY2
	eGHrPdMtp1xkr3s=
X-Google-Smtp-Source: AGHT+IGw6uruJ9ZEI48AgrBdkQ6+Y4KI/t3qaGHgTl6iUqNZaRX9HqUFuxhME6r39mMz7B0UJDlRLhanlWqFyjj6ElI=
X-Received: by 2002:a05:6402:4007:b0:640:f041:c7c6 with SMTP id
 4fb4d7f45d1cf-64105a3ea6emr4012523a12.21.1762372264805; Wed, 05 Nov 2025
 11:51:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105193800.2340868-1-mic@digikod.net>
In-Reply-To: <20251105193800.2340868-1-mic@digikod.net>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 5 Nov 2025 20:50:52 +0100
X-Gm-Features: AWmQ_bmf-MJjucXoTdZsQJpswia7qMghXA6jxfB57WcztYQemJGt9Ps6MJInHsU
Message-ID: <CAGudoHEvnTCxK-c9yistxN5ZjFjh5x3REoW4XxmiRAXNEDeyPQ@mail.gmail.com>
Subject: Re: [PATCH v1] fs: Move might_sleep() annotation to iput_final()
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Christian Brauner <brauner@kernel.org>, linux-security-module@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, 
	Edward Adam Davis <eadavis@qq.com>, =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Hillf Danton <hdanton@sina.com>, Jan Kara <jack@suse.cz>, Jann Horn <jannh@google.com>, 
	Max Kellermann <max.kellermann@ionos.com>, Tingmao Wang <m@maowtm.org>, 
	syzbot+12479ae15958fc3f54ec@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 8:38=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic@digiko=
d.net> wrote:
>
> iput() don't directly call any sleepable code but mostly checks flags
> and decrement a reference counter before calling iput_final() and then
> evict().
>
> Some code might call iput() with guarantees that iput_final() will not
> be called.  This is the case for Landlock's hook_sb_delete() where the
> inode counter must de decremented while holding it with another
> reference, see comment above the first iput() call.
>
> Move the new might_sleep() call from iput() to iput_final().  The
> alternative would be to manually decrement the counter without calling
> iput(), but it doesn't seem right.
>

This would mostly defeat the point of the original change.

Instead, if you have a consumer which *guarantees* this is not the
last reference, the vfs layer can provide a helper which acts
accordingly.

Something like this (untested):
diff --git a/fs/inode.c b/fs/inode.c
index 84f539497857..a3ece9b4b6ef 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -2011,6 +2011,15 @@ void iput(struct inode *inode)
 }
 EXPORT_SYMBOL(iput);

+void iput_not_last(struct inode *inode)
+{
+       VFS_BUG_ON_INODE(inode_state_read_once(inode) & I_CLEAR, inode);
+       VFS_BUG_ON_INODE(atomic_read(&inode->i_count) < 2, inode);
+
+       WARN_ON(atomic_sub_return(1, &inode->i_count) =3D=3D 0);
+}
+EXPORT_SYMBOL(iput_not_last);
+
 #ifdef CONFIG_BLOCK
 /**
  *     bmap    - find a block number in a file
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 41c855ef0594..8181a0d0e2ac 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2909,6 +2909,7 @@ extern int current_umask(void);

 extern void ihold(struct inode * inode);
 extern void iput(struct inode *);
+void iput_not_last(struct inode *);
 int inode_update_timestamps(struct inode *inode, int flags);
 int generic_update_time(struct inode *, int);

