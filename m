Return-Path: <linux-fsdevel+bounces-46318-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA05BA86E23
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Apr 2025 18:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9E7D19E3C66
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Apr 2025 16:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F0431FFC67;
	Sat, 12 Apr 2025 16:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jHx8h9Ce"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4011F8691;
	Sat, 12 Apr 2025 16:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744475185; cv=none; b=j8nOFsnOjOqnkvu7k4xdsR5/2Hdkw214vTV2qimqTFD0UlYT9aIznEiMIK1zT7PTBrgKPFD9cgRdqUKaEbRlZUyNenstUwrRQ5XbFzW7jWjY9vcM9WEiOAbgQBcJH2s0E1D38Ggi3MiUL+B31aKBl2e+3uH6Yv/ShO7KwTqGwoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744475185; c=relaxed/simple;
	bh=TgOepuTRab8lxv8vZ5W6tjHvakxfbUJ6Z3G1oGXFK8U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nfqrRttpkDnyhp+ttdJCNAvmXTrLxi694Y5Yrmp9moYOIVXUMtB0NvGP2nYe90murSw8I5/rdIdmphG57XogYRJC5QQDXXE9A/49Ni2F5ShrEnJqmEq+i9YvBJUDfLDd/hP72C+4lb6rSOL78BmZHxZ5wuUfOvj/fYsmf2GuVdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jHx8h9Ce; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5e686d39ba2so5406337a12.2;
        Sat, 12 Apr 2025 09:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744475182; x=1745079982; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=szkj8CDkf0ug43a6Nf+d4w7o4nOixURK7uDCQKDdfkA=;
        b=jHx8h9CegjyNq0fJ/Dasiv6cC3nB4Biz+ZlhocTjLZVhQlz8U9/iQJNhGungEgzq82
         XJGhMFxjvF4f9IkaVZTnQz5KPId+LK6W8igCTKsr4rM4VAhv1Bay6srnXz5b/u/zLGKj
         G/qe/P98ZjWrlqImvgeR5cfSyUVmtpHZosNfuw1Pp1DNxlnJVbaNjKXWIEHsSf//a9cS
         wBZsD7uuE+854mKe2viiJJtslADWuW6uDWKKKWg1ngrkNbCmEstCBxLlCVJ/Pf5Y50u7
         NSzbEoHtm0JOQyyUmkMji+BB57fsdAjWuW8DjTilnIlxo9AI5XyTrgWZ/+Uz4OnwruNs
         /qlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744475182; x=1745079982;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=szkj8CDkf0ug43a6Nf+d4w7o4nOixURK7uDCQKDdfkA=;
        b=H/KxRsfvIYinE15QwjORtuAAGGWHU+Sd2NVyjnxdf5LTOB6/29z6k2VNQbHPmxX8AL
         d+UNzXPlPGRTHWGiefA/9i3tT4rCwaRT/v3dea2bGJILccnLTXTsb42bZOvk52jecKaC
         NI0x0LoWprb5Y/5ebfbOlGdmxGy5uxsmPuQUu9PcJqjKXNaCmDnUI6AUUQ5Si2CJ2yMH
         P+1L6koIvjts2hUm2WoSDziOd742vVuKKmZ6RFN0+qN9VQnYZ/ZwK2kVnkl5Xf6zgWjX
         VpFbrChnNNXsXvo2ufx7iJ9zWa4+yIxv00VykF9oeMB3MMqzPHU97xDlYqlv13iA0Jwd
         oY8A==
X-Forwarded-Encrypted: i=1; AJvYcCV55oTaUmWMT9B7hROWdUu+Qu37IFUbRAcOSSOmcbrawxGaOr4ZOd1v6q9h0BzPvNGbVxexAtxQZE0NkdddJw==@vger.kernel.org, AJvYcCViGCcidNCu4p8OBzrPZYZZ9dEH5lVJRT0N8jWEKiDr8jf2kHQg3Jn/gSNnQcsz9cartu5b24zvZaFb@vger.kernel.org
X-Gm-Message-State: AOJu0YyNBAxn/2PWyolvnAd8Ub/Hu9kClZFKcSkpKTifLVRz0iIV3+Ii
	wdgsQt6nbHLyDpiMLP3m0Bk910UAsJFKDJYgWMpY1pPLblOP3DJ5gqV1dQBLUdLB8qXa5M/tEVS
	MXijEjYWTPgZUS9MvEuEmLKIx/RU=
X-Gm-Gg: ASbGncuxZfQQm6xF0AGnhR9ml5NJsu13nK5pSu6lYKnIMhuVd8P28IhLUqjjlPpG4F4
	LqwzkPcAak5BZCAYt6fgmf26frIMU1UKeBJQ348Ljvflda6nEb/nvIFlITn/aZE8Eu7vKbMeQy9
	FaYOrXRdNNXQATBS/Y2wjA
X-Google-Smtp-Source: AGHT+IHp7OMLw6VbFGxBeYonrEdt5mPvROXjfDcy3Y9ZMwE7aT835X+3Gzyjbt+ICCHpIr6C54iZq2fon49//DxyCgs=
X-Received: by 2002:a17:906:6a27:b0:ac8:1bb3:35b0 with SMTP id
 a640c23a62f3a-acad34a184dmr555126166b.20.1744475181825; Sat, 12 Apr 2025
 09:26:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=whJgRDtxTudTQ9HV8BFw5-bBsu+c8Ouwd_PrPqPB6_KEQ@mail.gmail.com>
 <20241031-klaglos-geldmangel-c0e7775d42a7@brauner> <CAHk-=wjwNkQXLvAM_CKn2YwrCk8m4ScuuhDv2Jzr7YPmB8BOEA@mail.gmail.com>
 <CAHk-=wiKyMzE26G7KMa_D1KXa6hCPu5+3ZEPUN0zB613kc5g4Q@mail.gmail.com>
 <CAHk-=wiB6vJNexDzBhc3xEwPTJ8oYURvcRLsRKDNNDeFTSTORg@mail.gmail.com>
 <CAHk-=whSzc75TLLPWskV0xuaHR4tpWBr=LduqhcCFr4kCmme_w@mail.gmail.com>
 <a7gys7zvegqwj2box4cs56bvvgb5ft3o3kn4e7iz43hojd4c6g@d3hihtreqdoy> <CAHk-=wgEvF3_+sa5BOuYG2J_hXv72iOiQ8kpmSzCpegUhqg4Zg@mail.gmail.com>
In-Reply-To: <CAHk-=wgEvF3_+sa5BOuYG2J_hXv72iOiQ8kpmSzCpegUhqg4Zg@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Sat, 12 Apr 2025 18:26:09 +0200
X-Gm-Features: ATxdqUH8rE9aqiS888HvXSF1A7JDSnPNjYFrY_Qx5nI-OCGKG1BW9PA6KLrusEQ
Message-ID: <CAGudoHGxr5gYb0JqPqF_J0MoSAb_qqoF4gaJMEdOhp51yobbLw@mail.gmail.com>
Subject: Re: generic_permission() optimization
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, Jan Kara <jack@suse.cz>, 
	Ext4 Developers List <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 11:49=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, 7 Nov 2024 at 12:22, Mateusz Guzik <mjguzik@gmail.com> wrote:
> >
> > How about filesystems maintaing a flag: IOP_EVERYONECANTRAREVERSE?
>
> It's actually just easier if a filesystem just does
>
>         cache_no_acl(inode);
>
> in its read-inode function if it knows it has no ACL's.
>
> Some filesystems already do that, eg btrfs has
>
>         /*
>          * try to precache a NULL acl entry for files that don't have
>          * any xattrs or acls
>          */
>         ....
>         if (!maybe_acls)
>                 cache_no_acl(inode);
>
> in btrfs_read_locked_inode(). If that 'maybe' is just reliable enough,
> that's all it takes.
>
> I tried to do the same thing for ext4, and failed miserably, but
> that's probably because my logic for "maybe_acls" was broken since I'm
> not familiar enough with ext4 at that level, and I made it do just
>
>         /* Initialize the "no ACL's" state for the simple cases */
>         if (!ext4_test_inode_state(inode, EXT4_STATE_XATTR) && !ei->i_fil=
e_acl)
>                 cache_no_acl(inode);
>
> which doesn't seem to be a strong enough text.
>

[ roping in ext4 people ]

I plopped your snippet towards the end of __ext4_iget:

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 4008551bbb2d..34189d85e363 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5071,7 +5071,12 @@ struct inode *__ext4_iget(struct super_block
*sb, unsigned long ino,
                goto bad_inode;
        }

+       /* Initialize the "no ACL's" state for the simple cases */
+       if (!ext4_test_inode_state(inode, EXT4_STATE_XATTR) && !ei->i_file_=
acl)
+               cache_no_acl(inode);
+
        brelse(iloc.bh);

bpftrace over a kernel build shows almost everything is sorted out:
 bpftrace -e 'kprobe:security_inode_permission { @[((struct inode
*)arg0)->i_acl] =3D count(); }'

@[0xffffffffffffffff]: 23810
@[0x0]: 65984202

That's just shy of 66 mln calls where the acls were explicitly set to
empty, compared to less than 24k where it was the default "uncached"
state.

So indeed *something* is missed, but the patch does cover almost everything=
.

Perhaps the ext4 guys would chime in and see it through? :)

The context is speeding path lookup by avoiding some of the branches
during permission checking.

--=20
Mateusz Guzik <mjguzik gmail.com>

