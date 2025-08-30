Return-Path: <linux-fsdevel+bounces-59710-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2819B3CC65
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Aug 2025 17:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 753C63A7080
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Aug 2025 15:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 120952609EE;
	Sat, 30 Aug 2025 15:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kZxJv6Fg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADE722A817;
	Sat, 30 Aug 2025 15:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756569291; cv=none; b=Gr8ibDSP4j3rnP/5riWwfMClhPfMkGDrq/zSRs4Ih76Cgyhs21LZzBEYRxwBJPC6bqI4vP8lDYmSm9vz5jqfShe0+duFAWj8AsK9PkWAx8dR6M9MldcvgYYDVakBKSzauPBp2kuCEZAqBsnISlji4BoXd4ZA3vF37vJ2ZQZS3v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756569291; c=relaxed/simple;
	bh=GVVHVXs4UCPiQnVcR2u/7qQBtlpWdwz3nn6Jlfw7yCw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nVx87DDYmyJM8Vx2cfA8jkGlhRQ6HSxbeM0bLdbLp7PcNLd8cH9zVQlwWsDmXOgfP8akU270qTU72Z9G3D8TZ7WpYDCIokaa6uct1dCZu39PrtDttQfmimOSljpJNU5zxke8vwHKr2aHr+znMxGkuP4VJ3bWpG40CTkfh4GpWQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kZxJv6Fg; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aff0775410eso211014566b.0;
        Sat, 30 Aug 2025 08:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756569288; x=1757174088; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JKnJgrbmUOh2oDMSjOOuFdf8pubpSvEuvnnxtiEFkJg=;
        b=kZxJv6FgYfp20p56z282eMsD5h5aFhsexDEwKvBCx5Td18ScqSqiY5CvPPlAFUKYP2
         jbXqTpw/pqQ0vDDLmDsKGeiLmtgJBTpdmLkn0t0a8FUAETVmPZX+v5ct9OAwkipIe4qQ
         InRnmaXNXHiyK3Yo9+51jzvwmf5QiqkctV2zN4m4hIhPJCZ/EQ+0aqP+KfJYbFhgYizV
         1p9OAjrjtsp6EfVq8wPGybelEeZhZiqL4ZNycT31KFAzgcaYvXcmLyCM5pmFCtzqMucA
         Kxkyhi7rxzImb9Xu/b5YNuxQbMRUTz/Jvl7+Hf3BPKMNXwlhqeEhHEFKYIwmNNHusIGp
         14jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756569288; x=1757174088;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JKnJgrbmUOh2oDMSjOOuFdf8pubpSvEuvnnxtiEFkJg=;
        b=mwG6ZBr9HiqAyLeciW+CYl7UE4bIYMbNb44kmyKew0ntbDgTfw3q7IXo8JRTuQKmLd
         eUz1klYy4CrpKfRFeTSB7vOoNcjo4fjoCQBCkHOKcjM3VSr1uXryA43Lf2nQgUO9o8wV
         Ua5TbvjFN8mj9+VedMK+Jhyjc6Kc+OmGTTWMkUFueDBt635a49zBqJsoJqa3DEwQFpke
         ZqRhQTNzL6wJ2ij1r4cz+yPT7fI7qMfFU12H6QrgaPkgn9LvJqc8UoSw/Mubyb1KOzw2
         V4TMl+IE8z3ioABDiCPIQisqAYFg61nUMT7FWd/MTPo3roPaEVtyYGYemFORkhO1pHi/
         c25w==
X-Forwarded-Encrypted: i=1; AJvYcCV2oZrw8/SueE4U7LYXpW3PK9vbJyOcNnezrTH5b8WJi4nmi5L3PNGYuxFMfPnohreHoQqI5e56GIRu8g==@vger.kernel.org, AJvYcCVi22YkWU9zmd7GLTBHxo+NPs5Dh3MdJubGEDKotCVIBFmqDhOIin6BnXg5DLOk5KnMTUO+81tOil91C9SL@vger.kernel.org, AJvYcCWUYClshOFhaHExST5SZ/vWImAQJpNnNWwa+SlEuoII0R0U8xnY6tbCQcZQ+jriiKe1xNkM3VOoedCpxA==@vger.kernel.org, AJvYcCXkOXcUYQUNOUjhWJ464HArW/f9VjyNaROp/ICRlNQwEHNeYtjynMqQhcAL0UnxjD824mJ0z9yrUv+t@vger.kernel.org, AJvYcCXov/6DBJ40RMwTVOX/eaua8OOPamK5qMn3HFUercKxPMdSFD6ygpnTEsYNSPB2I/ilXpCChjHQTCJh3TVxcg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyqFYRJEVPc3AoojHPL6tRf418w6fu4otXG409XuZTx1+DZAMrA
	j6SFTDnTZX7ZwYyFf/l2jckSJwumIdsAjGFv3UaRHc67P1jltMHAS+7w0fBIs8kjJL3vlW95D7C
	6Wttjb1tl4J7pi/brJBJx8HaCgnl8RYw=
X-Gm-Gg: ASbGncuQGHuJEMxurp4dJi+cSPET4Po4L3GomjNwy2xdAuPrMHPshHqEJwqs6enM22E
	x/5HuIzNV/rrhtJwbhmPG6sIi43llMOqnApEh9D/uNJmNHpQbVkecFLPiE/rglTdO0zyMnWea73
	nztSlc0f4lD5XtvckG5k8G3EvO3eE0R1tUECY0ZKhXBPswRBJaDm6zCriiEai8GZ3Ra5oEBt+SB
	7EUjffpLaySSpRnNw==
X-Google-Smtp-Source: AGHT+IElC6UnQKbYiLEokii4c0QnJGyNmpiKRwOAH3fYC7dsMe19ke8+l5PIvp3HUmB7xvmH/nqLeMEzovT7pA11oF8=
X-Received: by 2002:a17:907:60cb:b0:afe:834e:ac6c with SMTP id
 a640c23a62f3a-b00f67e0f14mr269568466b.7.1756569287634; Sat, 30 Aug 2025
 08:54:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827-kraut-anekdote-35789fddbb0b@brauner> <20250827162410.4110657-1-mjguzik@gmail.com>
In-Reply-To: <20250827162410.4110657-1-mjguzik@gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Sat, 30 Aug 2025 17:54:35 +0200
X-Gm-Features: Ac12FXxw_rI44Vo3uX6aJ6E7RnW-AezM7w6oV9lBe-qseTZJvVTh6oLpdGUdJuE
Message-ID: <CAGudoHE5UmqcbZD1apLsc7G=YmUsDQ=-i=ZQHSD=4qAtsYa3yA@mail.gmail.com>
Subject: Re: [PATCH] fs: revamp iput()
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, kernel-team@fb.com, 
	amir73il@gmail.com, linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-xfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I'm writing a long response to this series, in the meantime I noticed
this bit landed in
https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/commit/?h=3Dvfs=
-6.18.inode.refcount.preliminaries&id=3D3cba19f6a00675fbc2af0987dfc90e216e6=
cfb74
but with some whitespace issues in comments -- they are indented with
spaces instead of tabs after the opening line.

I verified the mail I sent does not have it, so I'm guessing this was
copy-pasted?

Tabing them by hand does the trick, below is my copy-paste as proof,
please indent by hand in your editor ;)

diff --git a/fs/inode.c b/fs/inode.c
index 2db680a37235..fe4868e2a954 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1915,10 +1915,10 @@ void iput(struct inode *inode)
        lockdep_assert_not_held(&inode->i_lock);
        VFS_BUG_ON_INODE(inode->i_state & I_CLEAR, inode);
        /*
-        * Note this assert is technically racy as if the count is bogusly
-        * equal to one, then two CPUs racing to further drop it can both
-        * conclude it's fine.
-        */
+        * Note this assert is technically racy as if the count is bogusly
+        * equal to one, then two CPUs racing to further drop it can both
+        * conclude it's fine.
+        */
        VFS_BUG_ON_INODE(atomic_read(&inode->i_count) < 1, inode);

        if (atomic_add_unless(&inode->i_count, -1, 1))
@@ -1942,9 +1942,9 @@ void iput(struct inode *inode)
        }

        /*
-        * iput_final() drops ->i_lock, we can't assert on it as the inode =
may
-        * be deallocated by the time the call returns.
-        */
+        * iput_final() drops ->i_lock, we can't assert on it as the inode =
may
+        * be deallocated by the time the call returns.
+        */
        iput_final(inode);
 }
 EXPORT_SYMBOL(iput);

While here, vim told me about spaces instead of tabs in 2 more spots
in the file. Again to show the lines:

diff --git a/fs/inode.c b/fs/inode.c
index 2db680a37235..833de5457a06 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -550,11 +550,11 @@ static void __inode_add_lru(struct inode *inode,
bool rotate)
 struct wait_queue_head *inode_bit_waitqueue(struct wait_bit_queue_entry *w=
qe,
                                            struct inode *inode, u32 bit)
 {
-        void *bit_address;
+       void *bit_address;

-        bit_address =3D inode_state_wait_address(inode, bit);
-        init_wait_var_entry(wqe, bit_address, 0);
-        return __var_waitqueue(bit_address);
+       bit_address =3D inode_state_wait_address(inode, bit);
+       init_wait_var_entry(wqe, bit_address, 0);
+       return __var_waitqueue(bit_address);
 }
 EXPORT_SYMBOL(inode_bit_waitqueue);
@@ -2938,7 +2938,7 @@ EXPORT_SYMBOL(mode_strip_sgid);
  */
 void dump_inode(struct inode *inode, const char *reason)
 {
-       pr_warn("%s encountered for inode %px", reason, inode);
+       pr_warn("%s encountered for inode %px", reason, inode);
 }

 EXPORT_SYMBOL(dump_inode);

Christian, I think it would be the most expedient if you just made
changes on your own with whatever commit message you see fit. No need
to mention I brought this up. If you insist I can send a patch.

On Wed, Aug 27, 2025 at 6:24=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com> w=
rote:
>
> The material change is I_DIRTY_TIME handling without a spurious ref
> acquire/release cycle.
>
> While here a bunch of smaller changes:
> 1. predict there is an inode -- bpftrace suggests one is passed vast
>    majority of the time
> 2. convert BUG_ON into VFS_BUG_ON_INODE
> 3. assert on ->i_count
> 4. assert ->i_lock is not held
> 5. flip the order of I_DIRTY_TIME and nlink count checks as the former
>    is less likely to be true
>
> I verified atomic_read(&inode->i_count) does not show up in asm if
> debug is disabled.
>
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> ---
>
> The routine kept annoying me, so here is a further revised variant.
>
> I verified this compiles, but I still cannot runtime test. I'm sorry for
> that.  My signed-off is conditional on a good samaritan making sure it
> works :)
>
> diff compared to the thing I sent "informally":
> - if (unlikely(!inode))
> - asserts
> - slightly reworded iput_final commentary
> - unlikely() on the second I_DIRTY_TIME check
>
> Given the revamp I think it makes sense to attribute the change to me,
> hence a "proper" mail.
>
> The thing surviving from the submission by Josef is:
> +       if (atomic_add_unless(&inode->i_count, -1, 1))
> +               return;
>
> And of course he is the one who brought up the spurious refcount trip in
> the first place.
>
> I'm happy with Reported-by, Co-developed-by or whatever other credit
> as you guys see fit.
>
> That aside I think it would be nice if NULL inodes passed to iput
> became illegal, but that's a different story for another day.
>
>  fs/inode.c | 46 +++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 35 insertions(+), 11 deletions(-)
>
> diff --git a/fs/inode.c b/fs/inode.c
> index 01ebdc40021e..01a554e11279 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -1908,20 +1908,44 @@ static void iput_final(struct inode *inode)
>   */
>  void iput(struct inode *inode)
>  {
> -       if (!inode)
> +       if (unlikely(!inode))
>                 return;
> -       BUG_ON(inode->i_state & I_CLEAR);
> +
>  retry:
> -       if (atomic_dec_and_lock(&inode->i_count, &inode->i_lock)) {
> -               if (inode->i_nlink && (inode->i_state & I_DIRTY_TIME)) {
> -                       atomic_inc(&inode->i_count);
> -                       spin_unlock(&inode->i_lock);
> -                       trace_writeback_lazytime_iput(inode);
> -                       mark_inode_dirty_sync(inode);
> -                       goto retry;
> -               }
> -               iput_final(inode);
> +       lockdep_assert_not_held(&inode->i_lock);
> +       VFS_BUG_ON_INODE(inode->i_state & I_CLEAR, inode);
> +       /*
> +        * Note this assert is technically racy as if the count is bogusl=
y
> +        * equal to one, then two CPUs racing to further drop it can both
> +        * conclude it's fine.
> +        */
> +       VFS_BUG_ON_INODE(atomic_read(&inode->i_count) < 1, inode);
> +
> +       if (atomic_add_unless(&inode->i_count, -1, 1))
> +               return;
> +
> +       if ((inode->i_state & I_DIRTY_TIME) && inode->i_nlink) {
> +               trace_writeback_lazytime_iput(inode);
> +               mark_inode_dirty_sync(inode);
> +               goto retry;
>         }
> +
> +       spin_lock(&inode->i_lock);
> +       if (unlikely((inode->i_state & I_DIRTY_TIME) && inode->i_nlink)) =
{
> +               spin_unlock(&inode->i_lock);
> +               goto retry;
> +       }
> +
> +       if (!atomic_dec_and_test(&inode->i_count)) {
> +               spin_unlock(&inode->i_lock);
> +               return;
> +       }
> +
> +       /*
> +        * iput_final() drops ->i_lock, we can't assert on it as the inod=
e may
> +        * be deallocated by the time the call returns.
> +        */
> +       iput_final(inode);
>  }
>  EXPORT_SYMBOL(iput);
>
> --
> 2.43.0
>


--=20
Mateusz Guzik <mjguzik gmail.com>

