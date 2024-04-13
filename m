Return-Path: <linux-fsdevel+bounces-16850-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B5ED8A3B45
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Apr 2024 08:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05953B21148
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Apr 2024 06:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C67C1CA80;
	Sat, 13 Apr 2024 06:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AMrZwmyK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F201B947
	for <linux-fsdevel@vger.kernel.org>; Sat, 13 Apr 2024 06:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712990540; cv=none; b=o79uFi71cUFvZakrTJjKerwegjmmtjvslJ8C0X2Z5rIs4mgSTd9ISH76vDZLncviIwoPEUH3ZXXxBADGdvng7954iI0u+9YGCXAh3ztagbBUhhUtnI4Si4YbIoANP3aj12+6abIqv0ELLpcqsGhnVlHjvO3QA95H1jXsDxhdBVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712990540; c=relaxed/simple;
	bh=DJ+iFSjOOvVlf8+X1p76vyKfNHnVTKWuMVJpf4JMOrQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dekvX6ZkPdsI8Zjw3yY3xNsIOB7v2mMN0qq7nM92/XHSWAcyyM9iPEY9UK4yeG8RNOz/WX9rkR4+LbqqBbOsK87ATmoWAXpYZUFjWw7UPzv8NxADG8XVLXNAlB52nN426PHo+3sqXUNBRhzXAdGo3lLV9T7/DjebhWl/NCQEZz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AMrZwmyK; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6962e6fbf60so13556146d6.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Apr 2024 23:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712990538; x=1713595338; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FDpA8Iel52+HQB06A078keX0+huxQz6XhywTfG6695k=;
        b=AMrZwmyKyOGj5CWCiFDVLo1HDfPPHpzbgwl5+mb68pXqmtKL5MaWUn4vQxW8iCu8Hr
         CnIjy+jKqDPDXOfsA7jfcvtdVXh+Yb3b4EQAy7IUW7RRpOXrm1PBCK9i/kYdXyVzmj04
         51Z/CIFaZDvT7fKXDG0JfEW/7mkCL1yJxPLU/eYzhbSxBUlbBWB4HFyZYa/TPq3RLV+P
         mlYuXf1g/biqM4BCeP6v53YBzzQkk5AKUgSNAiUn3Kl9qbmqylsGxEsEWEA+yx6sgahu
         FjJ29VQJ9xIXZ8nkGdBQm9gc8NhxBsAcHVj4sHmEK7w4NAhECw6E5+O1rW2MXldp3fBs
         f2Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712990538; x=1713595338;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FDpA8Iel52+HQB06A078keX0+huxQz6XhywTfG6695k=;
        b=c6zC6nzbhSlcyALMXQl4UBtRR5S5QCEXhUsx/ouxQ2Qu11l5ep0O2j+OPsEzZrc8vr
         jOqc1LjbXfAlDo2xS/ntYjGEdkxVMQ2CJKUBdMhcw10qKmmjY90E8M5gCmTlpSrGd3Xt
         KVdrpInIz2o7t61cgfcRf7vnt2C/qYIBtIjx3CJaQXF4/0QAVk/6VQSOTn5zvFissgRc
         cdgQLyupO/S75X8GDnl8bnjtH+4IuBp389fGEaIW+0u2H4jFuy2gzERvYRB7pvdZqN2r
         w4vm4JRMmtqzZoGEHzIqmrjpR+8PnQU4ttWqCEYjk9x2wteUwLn7UUoZkfDFXrHfKuUC
         l57g==
X-Forwarded-Encrypted: i=1; AJvYcCWcfTlA1ZgIGvMSnaG651evKA3lEtFZ6Ke+zbMZuyCZAyXfNTKRWbMC707HALKRlXfpUC6DjbOYmNmcNuJEEll4HaV+XGda2oXtEbPPFQ==
X-Gm-Message-State: AOJu0YxiTejDqgeZnr6YRy/9Rg6TNWwABAYowzxjNVr0OZXTwMPj0T8g
	7BTJ/OP9vDBNmdiLwdqb4IKA2Ov98WmRvMtLQMKI9/HE/F4wV7KwYmWQYUCjcBBeZO0KGmh01yE
	Hf21ogOl1F6cRRdOZoXxsbfPJNCU=
X-Google-Smtp-Source: AGHT+IH069Xyhl7ZUzs/YtiOMh82YOHfe27Kk86LcVO5u12SHiemC4wYqFiFV8QwLKuB9JP4M9TfzaOkRnW+wCInyRo=
X-Received: by 2002:a0c:fca7:0:b0:69b:112d:2d4e with SMTP id
 h7-20020a0cfca7000000b0069b112d2d4emr5286859qvq.55.1712990538048; Fri, 12 Apr
 2024 23:42:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <00000000000042c9190615cdb315@google.com> <20240413014033.1722-1-hdanton@sina.com>
In-Reply-To: <20240413014033.1722-1-hdanton@sina.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 13 Apr 2024 09:42:06 +0300
Message-ID: <CAOQ4uxhJi_YT=AZOaJGH6tt9kM7kUoAF1uzVqfGBXjvc8S78Ug@mail.gmail.com>
Subject: Re: [syzbot] [ext4?] KASAN: slab-use-after-free Read in fsnotify
To: Hillf Danton <hdanton@sina.com>
Cc: syzbot <syzbot+5e3f9b2a67b45f16d4e6@syzkaller.appspotmail.com>, 
	linux-fsdevel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: multipart/mixed; boundary="0000000000008659bc0615f4b07f"

--0000000000008659bc0615f4b07f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 13, 2024 at 4:41=E2=80=AFAM Hillf Danton <hdanton@sina.com> wro=
te:
>
> On Thu, 11 Apr 2024 01:11:20 -0700
> > syzbot found the following issue on:
> >
> > HEAD commit:    6ebf211bb11d Add linux-next specific files for 20240410
> > git tree:       linux-next
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D1621af9d180=
000
>
> #syz test https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next=
.git  6ebf211bb11d
>
> --- x/fs/notify/fsnotify.c
> +++ y/fs/notify/fsnotify.c
> @@ -101,8 +101,8 @@ void fsnotify_sb_delete(struct super_blo
>         wait_var_event(fsnotify_sb_watched_objects(sb),
>                        !atomic_long_read(fsnotify_sb_watched_objects(sb))=
);
>         WARN_ON(fsnotify_sb_has_priority_watchers(sb, FSNOTIFY_PRIO_CONTE=
NT));
> -       WARN_ON(fsnotify_sb_has_priority_watchers(sb,
> -                                                 FSNOTIFY_PRIO_PRE_CONTE=
NT));
> +       WARN_ON(fsnotify_sb_has_priority_watchers(sb, FSNOTIFY_PRIO_PRE_C=
ONTENT));
> +       synchronize_srcu(&fsnotify_mark_srcu);
>         kfree(sbinfo);
>  }
>
> @@ -499,7 +499,7 @@ int fsnotify(__u32 mask, const void *dat
>  {
>         const struct path *path =3D fsnotify_data_path(data, data_type);
>         struct super_block *sb =3D fsnotify_data_sb(data, data_type);
> -       struct fsnotify_sb_info *sbinfo =3D fsnotify_sb_info(sb);
> +       struct fsnotify_sb_info *sbinfo;
>         struct fsnotify_iter_info iter_info =3D {};
>         struct mount *mnt =3D NULL;
>         struct inode *inode2 =3D NULL;
> @@ -529,6 +529,8 @@ int fsnotify(__u32 mask, const void *dat
>                 inode2_type =3D FSNOTIFY_ITER_TYPE_PARENT;
>         }
>
> +       iter_info.srcu_idx =3D srcu_read_lock(&fsnotify_mark_srcu);
> +       sbinfo =3D fsnotify_sb_info(sb);
>         /*
>          * Optimization: srcu_read_lock() has a memory barrier which can
>          * be expensive.  It protects walking the *_fsnotify_marks lists.


See comment above. This kills the optimization.
It is not worth letting all the fsnotify hooks suffer the consequence
for the edge case of calling fsnotify hook during fs shutdown.

Also, fsnotify_sb_info(sb) in fsnotify_sb_has_priority_watchers()
is also not protected and using srcu_read_lock() there completely
nullifies the purpose of fsnotify_sb_info.

Here is a simplified fix for fsnotify_sb_error() rebased on the
pending mm fixes for this syzbot boot failure:

#syz test: https://github.com/amir73il/linux fsnotify-fixes

Jan,

I think that all the functions called from fs shutdown context
should observe that SB_ACTIVE is cleared but wasn't sure?

Thanks,
Amir.

--0000000000008659bc0615f4b07f
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-fsnotify-do-not-handle-events-on-a-shutting-down-fil.patch"
Content-Disposition: attachment; 
	filename="0001-fsnotify-do-not-handle-events-on-a-shutting-down-fil.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_luxq8od70>
X-Attachment-Id: f_luxq8od70

RnJvbSA5ZTU4OTc4NjVjNGJhODI5NmE4MWY0NTFkMjQ2M2RiZDZiNDlmYjNjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbWlyIEdvbGRzdGVpbiA8YW1pcjczaWxAZ21haWwuY29tPgpE
YXRlOiBUaHUsIDExIEFwciAyMDI0IDE4OjU5OjA4ICswMzAwClN1YmplY3Q6IFtQQVRDSF0gZnNu
b3RpZnk6IGRvIG5vdCBoYW5kbGUgZXZlbnRzIG9uIGEgc2h1dHRpbmcgZG93biBmaWxlc3lzdGVt
CgpQcm90ZWN0IGFnYWluc3QgdXNlIGFmdGVyIGZyZWUgd2hlbiBmaWxlc3lzdGVtIGNhbGxzIGZz
bm90aWZ5X3NiX2Vycm9yKCkKZHVyaW5nIGZzIHNodXRkb3duLgoKUmVwb3J0ZWQtYnk6IHN5emJv
dCs1ZTNmOWIyYTY3YjQ1ZjE2ZDRlNkBzeXprYWxsZXIuYXBwc3BvdG1haWwuY29tCkZpeGVzOiAw
N2EzYjhkMGJmNzIgKCJmc25vdGlmeTogbGF6eSBhdHRhY2ggZnNub3RpZnlfc2JfaW5mbyBzdGF0
ZSB0byBzYiIpClNpZ25lZC1vZmYtYnk6IEFtaXIgR29sZHN0ZWluIDxhbWlyNzNpbEBnbWFpbC5j
b20+Ci0tLQogaW5jbHVkZS9saW51eC9mc25vdGlmeS5oIHwgNCArKysrCiAxIGZpbGUgY2hhbmdl
ZCwgNCBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9mc25vdGlmeS5o
IGIvaW5jbHVkZS9saW51eC9mc25vdGlmeS5oCmluZGV4IDRkYTgwZTkyZjgwNC4uNjY1MTJhOTY1
ODI0IDEwMDY0NAotLS0gYS9pbmNsdWRlL2xpbnV4L2Zzbm90aWZ5LmgKKysrIGIvaW5jbHVkZS9s
aW51eC9mc25vdGlmeS5oCkBAIC00NTMsNiArNDUzLDEwIEBAIHN0YXRpYyBpbmxpbmUgaW50IGZz
bm90aWZ5X3NiX2Vycm9yKHN0cnVjdCBzdXBlcl9ibG9jayAqc2IsIHN0cnVjdCBpbm9kZSAqaW5v
ZGUsCiAJCS5zYiA9IHNiLAogCX07CiAKKwkvKiBmcyBtYXkgYmUgY2FsbGluZyB0aGlzIGhvb2sg
ZnJvbSB3aXRob3V0IHNodXRkb3duICovCisJaWYgKHVubGlrZWx5KCEoc2ItPnNfZmxhZ3MgJiBT
Ql9BQ1RJVkUpKSkKKwkJcmV0dXJuIDA7CisKIAlyZXR1cm4gZnNub3RpZnkoRlNfRVJST1IsICZy
ZXBvcnQsIEZTTk9USUZZX0VWRU5UX0VSUk9SLAogCQkJTlVMTCwgTlVMTCwgTlVMTCwgMCk7CiB9
Ci0tIAoyLjM0LjEKCg==
--0000000000008659bc0615f4b07f--

