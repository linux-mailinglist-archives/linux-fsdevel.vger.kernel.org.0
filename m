Return-Path: <linux-fsdevel+bounces-46332-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7713EA87164
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Apr 2025 11:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E93D16E9D0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Apr 2025 09:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4653119D897;
	Sun, 13 Apr 2025 09:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I9g3t6b/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DF817B505;
	Sun, 13 Apr 2025 09:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744537323; cv=none; b=t4Kt1KeVfhS5Qqw2lZ4/k5RJT7Qxe6wDwKKI1mgjWZDCxw/jWQZBGGhGpQONcCsz/gtnJLb+ZdnL8UZkKv9seQb91ewH/TwZXohhbPjkUXSQRpnEMyhDELbdH45bLS0VUaajUBLDI4oEHzt0eVp8SNHx4gBDQmeGFx8gBout3SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744537323; c=relaxed/simple;
	bh=/e42NX17m2wurRo49aRPFCahZ9/j7RSM/fqwrkndzEU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T8fpKf17P8iexQylZXKyzy04eHdOflZ/taPqm8LvkvKAq/Qfk1M0l9zvzv1rssHd2pimPOlNY2QjNJ62jIzJ35Q6e61hsS7ktRjNX03sJqmruDHti8SqSlmdnEHV2Y1C1ivKCUJ6f7XGjQln3amz+UCAUVJmuBq5YupLDC0KI1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I9g3t6b/; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ac2bb7ca40bso643001766b.3;
        Sun, 13 Apr 2025 02:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744537320; x=1745142120; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iXPdrjG0TFEMntEgUB7ySxBNxp4joMOMo46usv9N8tk=;
        b=I9g3t6b/Xzy+h0ct9jZ4G8O0ayEOUqrHJUooVCazSTQIzNDxAES33C9lIMO+fJY4rU
         xvv7Ia/GmoG3XhfJJLinvotF6byVTwLt7rWFKdwlq47FUPFBscKBGDURXn3tUZuG05vL
         KXD3GfPwi/2E7m6CmlL7Yw3+WFjfAyYyTx4LYQbyA0OmBjz5R1SB4DwFxkOwIScVGvG2
         gELyMUoYqKb6lyrDlIrU7zAR7tQ2boskaHzfdNr/67KXji1VPx5Jm7DOGCCLOvR9+AXH
         CkjnbPzx+6hWblcUASbJMO66LclmhKZIWJCwSZbzJ9EmE0NDla+ZFhhbQ95KiN5ulj7L
         QSFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744537320; x=1745142120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iXPdrjG0TFEMntEgUB7ySxBNxp4joMOMo46usv9N8tk=;
        b=CK3W9iqlAiqntNi4HJ4QhLPxNwzQdlzgM4ZQlocdo7/e+0/s39FwhHGfqrZLCqcFnK
         HZ7XXaB98qGb9Wx47ZBeP8woP+IQoMsicSPTExCancN5wMokklmUXvEZd8Ctbm/2EK7Q
         U3551kay8E2D/okmTJ+f5y+nasYH9cWwx7SJ6ygq17OYFumHfoZLBK91f8dOWjImHIqS
         z0+a8GN05N+c/7ZjC/FtODzSdTjPDONMu/0dvA58SgstHjB9Z4AC+uBqjkqX3ZYL6FqH
         sUy48LIlhCuEaYex7wyk93imyo2SlDg5LjmU/jXSgvLn+Q+0YSu8Ojz2WMSIAscm536y
         mHCw==
X-Forwarded-Encrypted: i=1; AJvYcCUHQbBmyyM/qVRwIeqz1AO91I5fT5LOSpnPBulGHKq9sfF3UT+BgZo1wdbf9dI4AYiUnvDnHdSVJ5OB36Vb8g==@vger.kernel.org, AJvYcCWmAMv7TuJlvMZnCHVS5luYt6HAiPLSILrFVY4c3g4NJvZ3+p0kXSOswUyVYF/Q6RVlrD38zZfV4kMd@vger.kernel.org
X-Gm-Message-State: AOJu0YwMC6XD53Moo03iPw53RERThxv5oC4Gh8EbPGGpYWZP/Pv2fdSQ
	zbMKbU2AIClXmB1eawG19bib9qDhH20Dflc2GOdAdOk1NwPDGHfaRvij8Ro8/vkmzWdHJNIJ02L
	vqrEA2btWKJbwanmdShGZWM6QJ+4=
X-Gm-Gg: ASbGnct4oiRlzCQpgQ/D4kVPU2uzYJlbaR2h8XZhBc4kvam3q0PWf/zIRLUJGI9gF1u
	+aq2rm2btFarYhjyRt0gnkQdOwAN4jRM04sD/Htoj4wswBUoe7pVHOoIFKn26CPfXR9jY7IZCLx
	ClzXVt8Gkh+mxspwjdwJ0+QS0opBZ7pto=
X-Google-Smtp-Source: AGHT+IEVmibuPI4M9twLmFOFhacU2kqWpn1MuC8yq7hJ5fqrULuMlidr7HrDOJZTNGpTfKFhb+l+LID/T2TCLj8I4pY=
X-Received: by 2002:a17:907:7f0d:b0:ac3:bd68:24f0 with SMTP id
 a640c23a62f3a-acad3457c9dmr873730266b.7.1744537319786; Sun, 13 Apr 2025
 02:41:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241031-klaglos-geldmangel-c0e7775d42a7@brauner>
 <CAHk-=wjwNkQXLvAM_CKn2YwrCk8m4ScuuhDv2Jzr7YPmB8BOEA@mail.gmail.com>
 <CAHk-=wiKyMzE26G7KMa_D1KXa6hCPu5+3ZEPUN0zB613kc5g4Q@mail.gmail.com>
 <CAHk-=wiB6vJNexDzBhc3xEwPTJ8oYURvcRLsRKDNNDeFTSTORg@mail.gmail.com>
 <CAHk-=whSzc75TLLPWskV0xuaHR4tpWBr=LduqhcCFr4kCmme_w@mail.gmail.com>
 <a7gys7zvegqwj2box4cs56bvvgb5ft3o3kn4e7iz43hojd4c6g@d3hihtreqdoy>
 <CAHk-=wgEvF3_+sa5BOuYG2J_hXv72iOiQ8kpmSzCpegUhqg4Zg@mail.gmail.com>
 <CAGudoHGxr5gYb0JqPqF_J0MoSAb_qqoF4gaJMEdOhp51yobbLw@mail.gmail.com>
 <20250412215257.GF13132@mit.edu> <CAHk-=wifig365Ej8JQrXBzK1_BzU9H9kqvvbBGuboF7CzR28VQ@mail.gmail.com>
 <20250412235535.GH13132@mit.edu>
In-Reply-To: <20250412235535.GH13132@mit.edu>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Sun, 13 Apr 2025 11:41:47 +0200
X-Gm-Features: ATxdqUHDBKPot_g_4gFVHRat16xkomb0osOGfn8jGoXyK6THAXpO3hfZFWmybQU
Message-ID: <CAGudoHEJZ32rDUt4+n2-L-RU=bpGgkYMroxtdMF6MQjKRsW24w@mail.gmail.com>
Subject: Re: generic_permission() optimization
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	Jan Kara <jack@suse.cz>, Ext4 Developers List <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 13, 2025 at 1:55=E2=80=AFAM Theodore Ts'o <tytso@mit.edu> wrote=
:
>
> On Sat, Apr 12, 2025 at 03:36:00PM -0700, Linus Torvalds wrote:
> > Indeed. I sent a query to the ext4 list (and I think you) about
> > whether my test was even the right one.
>
> Sorry, I must have not seen that message; at least, I don't have any
> memory of it.
>
> > Also, while I did a "getfattr -dR" to see if there are any *existing*
> > attributes (and couldn't find any), I also assume that if a file has
> > ever *had* any attributes, the filesystem may have the attribute block
> > allocated even if it's now empty.
>
> Well, getfattr will only show user xattrs.  It won't show security.*
> xattr's that might have been set by SELinux, or a
> system.posix_acl_access xattr.
>
> > I assume there's some trivial e2fstools thing to show things like
> > that, but it needs more ext4 specific knowledge than I have.
>
> Yes, we can test for this using the debugfs command.  For exaple:
>
> root@kvm-xfstests:~# debugfs /dev/vdc
> debugfs 1.47.2-rc1 (28-Nov-2024)
> debugfs:  stat <13>
> Inode: 13   Type: regular    Mode:  0644   Flags: 0x80000
> Generation: 1672288850    Version: 0x00000000:00000003
> User:     0   Group:     0   Project:     0   Size: 286
> File ACL: 0
> Links: 1   Blockcount: 8
> Fragment:  Address: 0    Number: 0    Size: 0
>  ctime: 0x67faf5d0:30d0b2e4 -- Sat Apr 12 19:22:56 2025
>  atime: 0x67faf571:7064bd50 -- Sat Apr 12 19:21:21 2025
>  mtime: 0x67faf571:71236aa8 -- Sat Apr 12 19:21:21 2025
> crtime: 0x67faf571:7064bd50 -- Sat Apr 12 19:21:21 2025
> Size of extra inode fields: 32
> Extended attributes:
>   system.posix_acl_access (28) =3D 01 00 00 00 01 00 06 00 02 00 04 00 b7=
 7a 00 00 04 00 04 00 10 00 04 00 20 00 04 00
> Inode checksum: 0xc8f7f1a7
> EXTENTS:
> (0):33792
>
> (If you know the pathname instead of the inode number, you can also
> give that to debugfs's stat command, e.g., "stat /lost+found")
>
> I tested it with a simple variant of your patch, and seems to do the righ=
t
> thing.  Mateusz, if you want, try the following patch, and then mount
> your test file system with "mount -o debug".  (The test_opt is to
> avoid a huge amount of noise on your root file system; you can skip it
> if it's more trouble than it's worth.)  The patch has a reversed
> seense of the test, so it will print a message for every one where
> cache_no_acl *wouldn't* be called.  You casn then use debugfs's "stat
> <ino#>" to verify whether it has some kind of extended attribute.
>
>                                       - Ted
>
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index f386de8c12f6..3e0ba7c4723a 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -5109,6 +5109,11 @@ struct inode *__ext4_iget(struct super_block *sb, =
unsigned long ino,
>                 goto bad_inode;
>         brelse(iloc.bh);
>
> +       if (test_opt(sb, DEBUG) &&
> +           (ext4_test_inode_state(inode, EXT4_STATE_XATTR) ||
> +            ei->i_file_acl))
> +               ext4_msg(sb, KERN_DEBUG, "has xattr ino %lu", inode->i_in=
o);
> +
>         unlock_new_inode(inode);
>         return inode;
>

This is the rootfs of the thing, so I tried it out with merely
printing it. I got 70 entries at boot time. I don't think figuring out
what this is specifically is warranted (it is on debian though).

With a little bit of cumbersome bpf tracing I verified newly created
dirs (as in mkdir) also have i_acl =3D=3D NULL, which is the bit important
here (apart from dirs instantiated from storage which now also have
it).

So... I think this is good enough to commit? I had no part in writing
the patch and I'm not an ext4 person, so I'm not submitting it myself.

Ted, you seem fine with the patch, so perhaps you could do the needful(tm)?

The patch is valuable in its own right and is a soft blocker for my
own patch which adds IOP_FAST_MAY_EXEC to skip a bunch of crap work in
inode_permission() which for MAY_EXEC wont be needed [I have not
posted it yet].
--=20
Mateusz Guzik <mjguzik gmail.com>

