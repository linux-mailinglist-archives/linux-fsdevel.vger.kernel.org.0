Return-Path: <linux-fsdevel+bounces-63552-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 313D9BC1B47
	for <lists+linux-fsdevel@lfdr.de>; Tue, 07 Oct 2025 16:23:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C222C34E728
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Oct 2025 14:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC492E1C6F;
	Tue,  7 Oct 2025 14:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="xzyJa7Yr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5522DFA2B
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Oct 2025 14:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759846981; cv=none; b=bnHe1AtV8luUKg+k+/H25o4+fr3jXNWQZ/ysHd6o4zN5XKF4Tj76Aw/wnvTptEJ41DoKfTbTqa8oA+Xvu0kuPxpSssWd541I6+37s3Qp0b5YgiqG6jpSoG779+p1nLSdtjZqnxKo5pwxhD9jVaeK5BHOllto1d99W32A2eK3nyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759846981; c=relaxed/simple;
	bh=tokGYqRJ676PTVUntDb8ZAGQKTgwiBhs3xhbI07if84=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K6OmQsr7b+5wB0DO+oyKEcuvt4Y0sE9AJNQJUdGb+EZejUjCwdlfP9byhncJhIO39tW8/ZwpDWjEnhsrwDhcYFw8MewYCt4oAVb+sfqMk6na04b+O/CZl7tiYpBfdzlFvb0TlHynnXsF6WUuasf9ZP6WoNDpdGhQ8Do4PYNbMA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=xzyJa7Yr; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5818de29d15so7864190e87.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Oct 2025 07:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1759846977; x=1760451777; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lq1P3EW7tGfQMqIQTuDaYae4Y7ieatBHo8HzSfhOj0g=;
        b=xzyJa7YrGfWsIkrECvqWbphWIuAjP+ZlFN3+Yp/uwyl1Xlxipdu4yxRspAH3hbh41m
         TOPzRVHH9hk5e3hd3SItTHrWipr7m6LZSdBuOHrJFCkvhzCLruTGOydfM3A70AYBzY6u
         i7m6GLEpDzxoVUVNbcCvUxTUCGyp9KfZgp8i2R3H8/KDgByxfSZdC88viCGrYo1gV80m
         dD88foSnjZizeT3sLOPP5nLH/vDgudkzpquaoQNY0SscNKymYWtoCMAZ0wSETSm4fAH8
         YUF0xiocHIK841zXhv+N0+JIPAOFt+urYG/NvY3uae5VFDeNOe2crrIGISo3bNWiRsdK
         O3JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759846977; x=1760451777;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Lq1P3EW7tGfQMqIQTuDaYae4Y7ieatBHo8HzSfhOj0g=;
        b=qHZF7FptL6opPmtqHkLOKJ+r/xdFmzlO1+/XPuB4dIpQUq7tQ/JGmMZlNGT93GwT4l
         Tho5d7exjElucW06sRS2z9zldoQixOpFsvIV5sauQQmKADdNlqZ7ZBqvkMTA134f0rF6
         MauZg7ooBVWyNl4xva5LgLfuJBic0p7r+k8HaBUlOCj35C37dmgyLY+2dzXiWMkoKk6S
         M15UrlxJb40YH+IR+/XoqrDYdB7ANKSZaW1wsuBa3OJL+C4+vEKtSOzWh3Ovc4kI1nWu
         VUDobD+57eUqv+LLXi3ioeHtY9Y5Ai5zj/NsuFzXaA8lKnQNCzR3Lsdq54W1ebfw2NEU
         ifwA==
X-Forwarded-Encrypted: i=1; AJvYcCUswWqQKFcGipbmlHhkiHSwWdVwyjGNHUvqvyQEo/Av/60wiAP9quZqCD8cggZlZrgfarHjacGa3FfgsX+Z@vger.kernel.org
X-Gm-Message-State: AOJu0YxphZWJPMsRtyt2aFFSCA/BejEPamYHO0NwdrZCwOi7fdwdZVDi
	ht7OLIojtuTI8afzIyAObVs2WKJQ/4nz2T738UU0wFWmYon4yB8mkFSaVpYBkEWO2XA=
X-Gm-Gg: ASbGnct+VDxe8BlfNAnS48JwFUN8gdAOqU/hxeaX7t+SMbw3CFP+VrzxNK5m6jYRZlW
	IZStsXcYEq/OmqZR5XL04YOisWZ49oNWpWC0pe/d8g/+DMAi+AcDBAfR3SHM5NTSWy9bxQPvmW4
	h7vGtgMyoHpJUW956hfdkx7jGbMy/X0cwaqj+g0IIJBIyAjyTyt7nP+QZtA2u8eI/HEGofeURLy
	GIAy0jWDU65loV9xv0i/v+O/B88ujH94FUFtxAwlyuyFvX+PINqXbhHfO24uwx95pa2XSB6m71Y
	EsBIgujSergkr2a+3HCaLS2SYDRy2N7cI5XpShgB4+vrV7V0fVYEyIbOogCoTelH6fGhO+BV430
	yfS/dmOj5VVVTy3mqWV88WNniJh31UGeiUvIHwxkTquu9pLTp
X-Google-Smtp-Source: AGHT+IEALbTTgMjCiz8CxCAPbQOF2VKZvelp7EZdNpBPhA+VZY+jCEOuA0LvBTVpjgGkefZxVK9TVA==
X-Received: by 2002:a05:6512:1195:b0:57b:c798:9edf with SMTP id 2adb3069b0e04-58cbc589a2dmr4959770e87.56.1759846977167;
        Tue, 07 Oct 2025 07:22:57 -0700 (PDT)
Received: from [10.78.74.174] ([212.248.24.216])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b0118d6e6sm6144451e87.78.2025.10.07.07.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 07:22:56 -0700 (PDT)
Message-ID: <bfad42ac8e1710e26329b7f1f816199cb1cf0c88.camel@dubeyko.com>
Subject: Re: [PATCH] hfsplus: Verify inode mode when loading from disk
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, John Paul Adrian
 Glaubitz <glaubitz@physik.fu-berlin.de>, Yangtao Li <frank.li@vivo.com>,
 linux-fsdevel	 <linux-fsdevel@vger.kernel.org>
Date: Tue, 07 Oct 2025 07:22:53 -0700
In-Reply-To: <10028383-1d85-402a-a390-3639e49a9b52@I-love.SAKURA.ne.jp>
References: <10028383-1d85-402a-a390-3639e49a9b52@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.0 (flatpak git) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2025-10-04 at 22:34 +0900, Tetsuo Handa wrote:
> The inode mode loaded from corrupted disk can be invalid. Do like
> what
> commit 0a9e74051313 ("isofs: Verify inode mode when loading from
> disk")
> does.
>=20
> Reported-by: syzbot
> <syzbot+895c23f6917da440ed0d@syzkaller.appspotmail.com>
> Closes: https://syzkaller.appspot.com/bug?extid=3D895c23f6917da440ed0d
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
> =C2=A0fs/hfsplus/inode.c | 8 +++++++-
> =C2=A01 file changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/hfsplus/inode.c b/fs/hfsplus/inode.c
> index b51a411ecd23..53f653019904 100644
> --- a/fs/hfsplus/inode.c
> +++ b/fs/hfsplus/inode.c
> @@ -558,9 +558,15 @@ int hfsplus_cat_read_inode(struct inode *inode,
> struct hfs_find_data *fd)
> =C2=A0			inode->i_op =3D
> &page_symlink_inode_operations;
> =C2=A0			inode_nohighmem(inode);
> =C2=A0			inode->i_mapping->a_ops =3D &hfsplus_aops;
> -		} else {
> +		} else if (S_ISCHR(inode->i_mode) || S_ISBLK(inode-
> >i_mode) ||
> +			=C2=A0=C2=A0 S_ISFIFO(inode->i_mode) ||
> S_ISSOCK(inode->i_mode)) {

As far as I can see, we operate by inode->i_mode here. But if inode
mode has been corrupted on disk, then we assigned wrong value before.
And HFS+ has hfsplus_get_perms() method that assigns perms->mode to
inode->i_mode. So, I think we need to rework hfsplus_get_perms() for
checking the correctness of inode mode before assigning it to inode-
>i_mode.

Thanks,
Slava.

> =C2=A0			init_special_inode(inode, inode->i_mode,
> =C2=A0					=C2=A0=C2=A0 be32_to_cpu(file-
> >permissions.dev));
> +		} else {
> +			printk(KERN_DEBUG "hfsplus: Invalid file
> type 0%04o for inode %lu.\n",
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inode->i_mode, inode->i_ino);
> +			res =3D -EIO;
> +			goto out;
> =C2=A0		}
> =C2=A0		inode_set_atime_to_ts(inode, hfsp_mt2ut(file-
> >access_date));
> =C2=A0		inode_set_mtime_to_ts(inode,

