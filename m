Return-Path: <linux-fsdevel+bounces-35957-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B71809DA23E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2024 07:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B1BDB22F26
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2024 06:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DCE51494B2;
	Wed, 27 Nov 2024 06:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lmBY+u/w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46252145FE4;
	Wed, 27 Nov 2024 06:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732688416; cv=none; b=pYOaoYKRl2en0C92xcbAoUc4gTg1ZE6LTKFK4HKtVuzG5J1MmP1mj3QnJ4EFktYHGgPyuxQKrr08+mjFMQqzxYvPKNbl+sJrFey9d1TTY4T6aE4DybJH30Wh2+qBOs7oxgaEIbyC4pdNa8lbkl+O495Kz2xbiDkRWR19ea1xx4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732688416; c=relaxed/simple;
	bh=1kPtCehNXI7szzQiWHuhcxeJUsKblPfr+Onyb9hTxQA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n5c4WAQhgICT87VYCAfm/WzvTI1xmNdBixDjSUrgNuk85dLdQiDJKwPRyIw2vOTJ/IJvvBRR5fSHZVSIFFqq1uD21c88CVqUt5I5dmWwg+OoHF+2IzoXmJhb9VX3F4lY/NQUr9Pl3AUm6dIJML+M4ndz09+h63Vyo9Ayg4xCtfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lmBY+u/w; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aa539d2b4b2so81938866b.1;
        Tue, 26 Nov 2024 22:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732688413; x=1733293213; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v/iivPp+l72JnY9vYj/hX54ZOaGshomdwdZlqq+eIEY=;
        b=lmBY+u/w4pWaREEkpTgKNFsVnqzkiYp6/2Zc78oaujBZjUq0YTiNqTVwR+XVWF5Idy
         wW1V61ZJEGFctkB9AydLyCgawSODkiI7MEnUFqzAwGI/GMKrUtSLmZbDa4lYmqaLES51
         Vbu1dl0pkT9PO+4FNOS47plPL6c4OPL7bUDxZgFhB6HqEWOGdPN2m3EYHGB5KKD/kz7W
         uwQypdkuvI62kzqUNoyG1ckejRtE5G/CEjcxKizTKaA3eXYoZ2BCOVAym18M9iIz+4/C
         y7NP2OktOTKCT2lL7ZSMkoHPW155jJo6Go21XUze0sLoodfetHVa4Am5KU12Wdj5tCRF
         yMww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732688413; x=1733293213;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v/iivPp+l72JnY9vYj/hX54ZOaGshomdwdZlqq+eIEY=;
        b=UPrcnaIIjfQ2L4C829oZJysJYHdN5YHkVFLqASM5lZ5LhVTOpEWftjtQ/opy/+M/0U
         Z420I77gaBH+EOr4jnP36FPP1DUDKjE2hMkaWdv56mUA7Q6jQ42w7KUWzpRAxPXd4bL9
         pB5LYw6MzgAZFSPe7WP15jGX4ojFGO3S8ZrCuKLJsxDXttqgYzzi3Gad3cfsfbHT13YL
         rQ37h5NNm4TQuIajOlI4WUfYhhD1OQ9ogiyF/VcLJfMvWoGxxxgsi2teJgM/xWjG5qV1
         E32tBi39DtzyjzlMyzLboH4vrqYAZYIVloCqF1KRY10/edwBWa/dgXTuqOr8XzmkwikS
         cUkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQjmmBcDbzf5qm0klMcB0hXMZ6Jco5xgcEzeU57PZ+AQe/MBtes6c8ziTQszwWmbzTKUvBmBHnfLe5YxaC@vger.kernel.org, AJvYcCWJnMGGXp1F4tOBibG1tLnQCZ8CAJYyCIyn9UC0LTetNuBNWiOXWmrYaYpiZVkhWi0buNqAMbslIVhslqJJ@vger.kernel.org
X-Gm-Message-State: AOJu0YykvVcW72z+XlaqtyUQlf0kU54M81dhkpALFh3fKEQ/IMDumDmv
	4IsUDx19sb49s8IwIH8qICioCA8eijjHiD3IhuUETwhppbjjT/WIstqcPtYM7S3QkOf3n2ePro5
	/1heshmIHWGmCUGslgCk1q+449zs=
X-Gm-Gg: ASbGncspLV3iWUKaI4lZzA4LsiIL0tTFkkkwfosy1sKCsyk/qcSA6lvm+ZrwOxQgXYt
	lnKfpqh4GkqNgHMKqhEdm5cYjdKLWH/8=
X-Google-Smtp-Source: AGHT+IGEwnUc8vPNCtyAfttz2QoN0COH3xUg8RCh11QFT+6Mn2KXsvxhdQl4Cy9scBpq0NBxxqKI8acJCxBSWNKaXAg=
X-Received: by 2002:a17:906:32d2:b0:aa5:ac9:ce5f with SMTP id
 a640c23a62f3a-aa57f47f138mr221183666b.0.1732688412477; Tue, 26 Nov 2024
 22:20:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127054737.33351-1-bharata@amd.com> <CAGudoHGup2iLPUONz=ScsK1nQsBUHf_TrTrUcoStjvn3VoOr7Q@mail.gmail.com>
In-Reply-To: <CAGudoHGup2iLPUONz=ScsK1nQsBUHf_TrTrUcoStjvn3VoOr7Q@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 27 Nov 2024 07:19:59 +0100
Message-ID: <CAGudoHEvrML100XBTT=sBDud5L2zeQ3ja5BmBCL2TTYYoEC55A@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] Large folios in block buffered IO path
To: Bharata B Rao <bharata@amd.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, nikunj@amd.com, 
	willy@infradead.org, vbabka@suse.cz, david@redhat.com, 
	akpm@linux-foundation.org, yuzhao@google.com, axboe@kernel.dk, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, joshdon@google.com, 
	clm@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 27, 2024 at 7:13=E2=80=AFAM Mateusz Guzik <mjguzik@gmail.com> w=
rote:
>
> On Wed, Nov 27, 2024 at 6:48=E2=80=AFAM Bharata B Rao <bharata@amd.com> w=
rote:
> >
> > Recently we discussed the scalability issues while running large
> > instances of FIO with buffered IO option on NVME block devices here:
> >
> > https://lore.kernel.org/linux-mm/d2841226-e27b-4d3d-a578-63587a3aa4f3@a=
md.com/
> >
> > One of the suggestions Chris Mason gave (during private discussions) wa=
s
> > to enable large folios in block buffered IO path as that could
> > improve the scalability problems and improve the lock contention
> > scenarios.
> >
>
> I have no basis to comment on the idea.
>
> However, it is pretty apparent whatever the situation it is being
> heavily disfigured by lock contention in blkdev_llseek:
>
> > perf-lock contention output
> > ---------------------------
> > The lock contention data doesn't look all that conclusive but for 30% r=
wmixwrite
> > mix it looks like this:
> >
> > perf-lock contention default
> >  contended   total wait     max wait     avg wait         type   caller
> >
> > 1337359017     64.69 h     769.04 us    174.14 us     spinlock   rwsem_=
wake.isra.0+0x42
> >                         0xffffffff903f60a3  native_queued_spin_lock_slo=
wpath+0x1f3
> >                         0xffffffff903f537c  _raw_spin_lock_irqsave+0x5c
> >                         0xffffffff8f39e7d2  rwsem_wake.isra.0+0x42
> >                         0xffffffff8f39e88f  up_write+0x4f
> >                         0xffffffff8f9d598e  blkdev_llseek+0x4e
> >                         0xffffffff8f703322  ksys_lseek+0x72
> >                         0xffffffff8f7033a8  __x64_sys_lseek+0x18
> >                         0xffffffff8f20b983  x64_sys_call+0x1fb3
> >    2665573     64.38 h       1.98 s      86.95 ms      rwsem:W   blkdev=
_llseek+0x31
> >                         0xffffffff903f15bc  rwsem_down_write_slowpath+0=
x36c
> >                         0xffffffff903f18fb  down_write+0x5b
> >                         0xffffffff8f9d5971  blkdev_llseek+0x31
> >                         0xffffffff8f703322  ksys_lseek+0x72
> >                         0xffffffff8f7033a8  __x64_sys_lseek+0x18
> >                         0xffffffff8f20b983  x64_sys_call+0x1fb3
> >                         0xffffffff903dce5e  do_syscall_64+0x7e
> >                         0xffffffff9040012b  entry_SYSCALL_64_after_hwfr=
ame+0x76
>
> Admittedly I'm not familiar with this code, but at a quick glance the
> lock can be just straight up removed here?
>
>   534 static loff_t blkdev_llseek(struct file *file, loff_t offset, int w=
hence)
>   535 {
>   536 =E2=94=82       struct inode *bd_inode =3D bdev_file_inode(file);
>   537 =E2=94=82       loff_t retval;
>   538 =E2=94=82
>   539 =E2=94=82       inode_lock(bd_inode);
>   540 =E2=94=82       retval =3D fixed_size_llseek(file, offset, whence,
> i_size_read(bd_inode));
>   541 =E2=94=82       inode_unlock(bd_inode);
>   542 =E2=94=82       return retval;
>   543 }
>
> At best it stabilizes the size for the duration of the call. Sounds
> like it helps nothing since if the size can change, the file offset
> will still be altered as if there was no locking?
>
> Suppose this cannot be avoided to grab the size for whatever reason.
>
> While the above fio invocation did not work for me, I ran some crapper
> which I had in my shell history and according to strace:
> [pid 271829] lseek(7, 0, SEEK_SET)      =3D 0
> [pid 271829] lseek(7, 0, SEEK_SET)      =3D 0
> [pid 271830] lseek(7, 0, SEEK_SET)      =3D 0
>
> ... the lseeks just rewind to the beginning, *definitely* not needing
> to know the size. One would have to check but this is most likely the
> case in your test as well.
>
> And for that there is 0 need to grab the size, and consequently the inode=
 lock.

That is to say bare minimum this needs to be benchmarked before/after
with the lock removed from the picture, like so:

diff --git a/block/fops.c b/block/fops.c
index 2d01c9007681..7f9e9e2f9081 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -534,12 +534,8 @@ const struct address_space_operations def_blk_aops =3D=
 {
 static loff_t blkdev_llseek(struct file *file, loff_t offset, int whence)
 {
        struct inode *bd_inode =3D bdev_file_inode(file);
-       loff_t retval;

-       inode_lock(bd_inode);
-       retval =3D fixed_size_llseek(file, offset, whence, i_size_read(bd_i=
node));
-       inode_unlock(bd_inode);
-       return retval;
+       return fixed_size_llseek(file, offset, whence, i_size_read(bd_inode=
));
 }

 static int blkdev_fsync(struct file *filp, loff_t start, loff_t end,

To be aborted if it blows up (but I don't see why it would).

--=20
Mateusz Guzik <mjguzik gmail.com>

