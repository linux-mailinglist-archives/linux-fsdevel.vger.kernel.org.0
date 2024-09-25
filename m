Return-Path: <linux-fsdevel+bounces-30114-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 803649864A5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 18:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 062F31F2163D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 16:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCDFC4965B;
	Wed, 25 Sep 2024 16:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="waZd9n2j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D047143ABD
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Sep 2024 16:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727281081; cv=none; b=DXAo+ACPMu1E+8LK375Bt64ZqzQLrsGUH8vJFflb/uXk0oKzrnb2XN18Nimsb7i8Bf7GhvwzUpVod06N2TeWEmsP95V8Zi25Thpy7fOcEPXBTUsp3o/jt7uCNsRJxwDbwrt9kE4s4QWdu9R76IXRGQYhcHcjGHSLm12Byc9WF8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727281081; c=relaxed/simple;
	bh=g9E8zPJQZ+WKtz/NOzLnwgbBUCFBXvSj04Z75GvLJZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tXBSTjgjd3LAoMzWxM7+PQoPoAMqzw16acHgZhlxOYRdfB1eXKouqJsm4a7kqM7EfzX+DYnF2hxoBg7juC3D/NDGxFW0uFyB0XmX0Bzsb9jdO/gPqSP7/Z681MBIyDIYTyEd4P4wwfUnWAl0E/wivecgzF0Rwrj4Ken8+1FnmoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=waZd9n2j; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com [209.85.221.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 73CF64064D
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Sep 2024 16:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1727281072;
	bh=KEgQnWZ+UHxrm0MMWG0A0YgheYaHlx7qOY6QwfASbDE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=waZd9n2jTVAMr+zlvebWzdSaQNSCafbiKGSPASfP96te8bfQ08pdZEN2pimL4d7RF
	 ApaL7iBF3lm2Gz5vNwmXCWE8MEswovcbJyXbl6TeXEz4FIVzYZWyr3srSAegsP7CJW
	 OZbqEhAnseMjISb0srFEgwbubEM+Y8lCtnCWJPL+KRJbFF+hVRpKsq+xbVfJE8zIFx
	 ArY6MxAdhrTXsGIsPXplD8AjOLoOoTVNDpAsSSLRO2cYVU0upudWs1ter9I64NYH+a
	 OVhQCXsrZGc15JFzEPZWzbu1Y4iMsvg5XRpfxC6UpAIuMe4I/Nd3SNkSvzE/F79KP3
	 Z210Kbd+p6oAQ==
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-5012505f76bso790185e0c.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Sep 2024 09:17:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727281071; x=1727885871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KEgQnWZ+UHxrm0MMWG0A0YgheYaHlx7qOY6QwfASbDE=;
        b=ae2Jq27DE3RcuSlUALVNhPZuc4eLLFqHQKs6r/NcP6TaYVT3wS+jaNvLBlCPLB0U5Y
         q/YeZG7k7mzayuZUTeFjND1fran7c2SKoYUrW3A22AuXqh9LBA+a3ysvF7N+NhdmuG7U
         XC+hml7JmELV+vc38katUipvxS5SZC28WSF8+rjk7cedfVpv0g1oxzxMk9CKXKlOOBnn
         sKNXFcmR8Xq+b0h8ecq2GuRRpvfxmOi+sHzk6CNOTSsdLjVE2HuDnWz+BozNK7tWF+4z
         B4DagPhv2JppHEVNWeylekElfYiOhjU+m3FWoa2OmEgvi4+6oqQgRDsuJcD3j8iviNYy
         nmYQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4efb5xQ25T4/cVk75LVsPCNBP2QwmbEeSusVP2vcDQSKL1YtX7QrzZX3bSUrckXpk570uivjloWYKwZVG@vger.kernel.org
X-Gm-Message-State: AOJu0YzctJqT4DKbymQ6tbTFkyCjoe8JmO8rF/qkKOioyQN/R7wqZgVw
	cnY676jsmF+yQDnGQaY9Zk9DtSP27j8sHU1C5a6lpmF2usZF95M2pJdyv9/YkuZabLsT25JMStQ
	2zMMEd5RWjY1xCIdTVas4KNNL6kIVI9VSi3YDxZsCrKuxZ2HQp410bq1LpigOvdsYoccCRLJqA9
	symyivnVpVNzWc8uwyEbtTmVWTQ2mkj8963kqQbzp4vtxBk3ixTSSwMg==
X-Received: by 2002:a05:6122:3193:b0:503:d876:5e0a with SMTP id 71dfb90a1353d-5073bf2c77fmr313434e0c.0.1727281070934;
        Wed, 25 Sep 2024 09:17:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZZuyYU0WAWeXCej3QTUblc6Uv7YSQNlxDGc/5pLtnfQpPZc0N61MMk4ehu32sSNA43VULOeWPMn3L/LXLhPg=
X-Received: by 2002:a05:6122:3193:b0:503:d876:5e0a with SMTP id
 71dfb90a1353d-5073bf2c77fmr313362e0c.0.1727281070421; Wed, 25 Sep 2024
 09:17:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925143325.518508-1-aleksandr.mikhalitsyn@canonical.com>
 <20240925143325.518508-2-aleksandr.mikhalitsyn@canonical.com> <20240925155706.zad2euxxuq7h6uja@quack3>
In-Reply-To: <20240925155706.zad2euxxuq7h6uja@quack3>
From: Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date: Wed, 25 Sep 2024 18:17:39 +0200
Message-ID: <CAEivzxfjnKq2fgCfYwhZukAO-ZfoUiC5n0Y5yaUpuz-y7kDf+g@mail.gmail.com>
Subject: Re: [PATCH 1/1] ext4: fix crash on BUG_ON in ext4_alloc_group_tables
To: Jan Kara <jack@suse.cz>
Cc: tytso@mit.edu, stable@vger.kernel.org, 
	Andreas Dilger <adilger.kernel@dilger.ca>, Baokun Li <libaokun1@huawei.com>, 
	=?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@stgraber.org>, 
	Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, 
	Wesley Hershberger <wesley.hershberger@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2024 at 5:57=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Wed 25-09-24 16:33:24, Alexander Mikhalitsyn wrote:
> > [   33.882936] EXT4-fs (dm-5): mounted filesystem 8aaf41b2-6ac0-4fa8-b9=
2b-77d10e1d16ca r/w with ordered data mode. Quota mode: none.
> > [   33.888365] EXT4-fs (dm-5): resizing filesystem from 7168 to 786432 =
blocks
> > [   33.888740] ------------[ cut here ]------------
> > [   33.888742] kernel BUG at fs/ext4/resize.c:324!
>
> Ah, I was staring at this for a while before I understood what's going on
> (it would be great to explain this in the changelog BTW).  As far as I
> understand commit 665d3e0af4d3 ("ext4: reduce unnecessary memory allocati=
on
> in alloc_flex_gd()") can actually make flex_gd->resize_bg larger than
> flexbg_size (for example when ogroup =3D flexbg_size, ngroup =3D 2*flexbg=
_size
> - 1) which then confuses things. I think that was not really intended and

Hi Jan,

First of all, thanks for your reaction/review on this one ;-)

You are absolutely right, have just checked with our reproducer and
this modification:

diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
index e04eb08b9060..530a918f0cab 100644
--- a/fs/ext4/resize.c
+++ b/fs/ext4/resize.c
@@ -258,6 +258,8 @@ static struct ext4_new_flex_group_data
*alloc_flex_gd(unsigned int flexbg_size,
                flex_gd->resize_bg =3D 1 << max(fls(last_group - o_group + =
1),
                                              fls(n_group - last_group));

+       BUG_ON(flex_gd->resize_bg > flexbg_size);
+
        flex_gd->groups =3D kmalloc_array(flex_gd->resize_bg,
                                        sizeof(struct ext4_new_group_data),
                                        GFP_NOFS);

and yes, it crashes on this BUG_ON. So it looks like instead of making
flex_gd->resize_bg to be smaller
than flexbg_size in most cases we can actually have an opposite effect
here. I guess we really need to fix alloc_flex_gd() too.

> instead of fixing up ext4_alloc_group_tables() we should really change
> the logic in alloc_flex_gd() to make sure flex_gd->resize_bg never exceed=
s
> flexbg size. Baokun?

At the same time, if I understand the code right, as we can have
flex_gd->resize_bg !=3D flexbg_size after
5d1935ac02ca5a ("ext4: avoid online resizing failures due to oversized
flex bg") and
665d3e0af4d3 ("ext4: reduce unnecessary memory allocation in alloc_flex_gd(=
)")
we should always refer to flex_gd->resize_bg value which means that
ext4_alloc_group_tables() fix is needed too.
Am I correct in my understanding?

>
>                                                                 Honza

Kind regards,
Alex

>
>
> > [   33.889075] Oops: invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
> > [   33.889503] CPU: 9 UID: 0 PID: 3576 Comm: resize2fs Not tainted 6.11=
.0+ #27
> > [   33.890039] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), B=
IOS 1.15.0-1 04/01/2014
> > [   33.890705] RIP: 0010:ext4_resize_fs+0x1212/0x12d0
> > [   33.891063] Code: b8 45 31 c0 4c 89 ff 45 31 c9 31 c9 ba 0e 08 00 00=
 48 c7 c6 68 75 65 b8 e8 2b 79 01 00 41 b8 ea ff ff ff 41 5f e9 8d f1 ff ff=
 <0f> 0b 48 83 bd 70 ff ff ff 00 75 32 45 31 c0 e9 53 f1 ff ff 41 b8
> > [   33.892701] RSP: 0018:ffffa97f413f3cc8 EFLAGS: 00010202
> > [   33.893081] RAX: 0000000000000018 RBX: 0000000000000001 RCX: 0000000=
0fffffff0
> > [   33.893639] RDX: 0000000000000017 RSI: 0000000000000016 RDI: 0000000=
0e8c2c810
> > [   33.894197] RBP: ffffa97f413f3d90 R08: 0000000000000000 R09: 0000000=
000008000
> > [   33.894755] R10: ffffa97f413f3cc8 R11: ffffa2c1845bfc80 R12: 0000000=
000000000
> > [   33.895317] R13: ffffa2c1843d6000 R14: 0000000000008000 R15: ffffa2c=
199963000
> > [   33.895877] FS:  00007f46efd17000(0000) GS:ffffa2c89fc40000(0000) kn=
lGS:0000000000000000
> > [   33.896524] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [   33.896954] CR2: 00005630a4a1cc88 CR3: 000000010532c000 CR4: 0000000=
000350eb0
> > [   33.897516] Call Trace:
> > [   33.897638]  <TASK>
> > [   33.897728]  ? show_regs+0x6d/0x80
> > [   33.897942]  ? die+0x3c/0xa0
> > [   33.898106]  ? do_trap+0xe5/0x110
> > [   33.898311]  ? do_error_trap+0x6e/0x90
> > [   33.898555]  ? ext4_resize_fs+0x1212/0x12d0
> > [   33.898844]  ? exc_invalid_op+0x57/0x80
> > [   33.899101]  ? ext4_resize_fs+0x1212/0x12d0
> > [   33.899387]  ? asm_exc_invalid_op+0x1f/0x30
> > [   33.899675]  ? ext4_resize_fs+0x1212/0x12d0
> > [   33.899961]  ? ext4_resize_fs+0x745/0x12d0
> > [   33.900239]  __ext4_ioctl+0x4e0/0x1800
> > [   33.900489]  ? srso_alias_return_thunk+0x5/0xfbef5
> > [   33.900832]  ? putname+0x5b/0x70
> > [   33.901028]  ? srso_alias_return_thunk+0x5/0xfbef5
> > [   33.901374]  ? do_sys_openat2+0x87/0xd0
> > [   33.901632]  ? srso_alias_return_thunk+0x5/0xfbef5
> > [   33.901981]  ? srso_alias_return_thunk+0x5/0xfbef5
> > [   33.902324]  ? __x64_sys_openat+0x59/0xa0
> > [   33.902595]  ext4_ioctl+0x12/0x20
> > [   33.902802]  ? ext4_ioctl+0x12/0x20
> > [   33.903031]  __x64_sys_ioctl+0x99/0xd0
> > [   33.903277]  x64_sys_call+0x1206/0x20d0
> > [   33.903534]  do_syscall_64+0x72/0x110
> > [   33.903771]  ? srso_alias_return_thunk+0x5/0xfbef5
> > [   33.904115]  ? irqentry_exit+0x3f/0x50
> > [   33.904362]  ? srso_alias_return_thunk+0x5/0xfbef5
> > [   33.904707]  ? exc_page_fault+0x1aa/0x7b0
> > [   33.904979]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > [   33.905349] RIP: 0033:0x7f46efe3294f
> > [   33.905579] Code: 00 48 89 44 24 18 31 c0 48 8d 44 24 60 c7 04 24 10=
 00 00 00 48 89 44 24 08 48 8d 44 24 20 48 89 44 24 10 b8 10 00 00 00 0f 05=
 <41> 89 c0 3d 00 f0 ff ff 77 1f 48 8b 44 24 18 64 48 2b 04 25 28 00
> > [   33.907321] RSP: 002b:00007ffe9b8833a0 EFLAGS: 00000246 ORIG_RAX: 00=
00000000000010
> > [   33.907926] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007f4=
6efe3294f
> > [   33.908487] RDX: 00007ffe9b8834a0 RSI: 0000000040086610 RDI: 0000000=
000000004
> > [   33.909046] RBP: 00005630a4a0b0e0 R08: 0000000000000000 R09: 00007ff=
e9b8832d7
> > [   33.909605] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000=
000000004
> > [   33.910165] R13: 00005630a4a0c580 R14: 00005630a4a10400 R15: 0000000=
000000000
> > [   33.910740]  </TASK>
> > [   33.910837] Modules linked in:
> > [   33.911049] ---[ end trace 0000000000000000 ]---
> > [   33.911428] RIP: 0010:ext4_resize_fs+0x1212/0x12d0
> > [   33.911810] Code: b8 45 31 c0 4c 89 ff 45 31 c9 31 c9 ba 0e 08 00 00=
 48 c7 c6 68 75 65 b8 e8 2b 79 01 00 41 b8 ea ff ff ff 41 5f e9 8d f1 ff ff=
 <0f> 0b 48 83 bd 70 ff ff ff 00 75 32 45 31 c0 e9 53 f1 ff ff 41 b8
> > [   33.913928] RSP: 0018:ffffa97f413f3cc8 EFLAGS: 00010202
> > [   33.914313] RAX: 0000000000000018 RBX: 0000000000000001 RCX: 0000000=
0fffffff0
> > [   33.914909] RDX: 0000000000000017 RSI: 0000000000000016 RDI: 0000000=
0e8c2c810
> > [   33.915482] RBP: ffffa97f413f3d90 R08: 0000000000000000 R09: 0000000=
000008000
> > [   33.916258] R10: ffffa97f413f3cc8 R11: ffffa2c1845bfc80 R12: 0000000=
000000000
> > [   33.917027] R13: ffffa2c1843d6000 R14: 0000000000008000 R15: ffffa2c=
199963000
> > [   33.917884] FS:  00007f46efd17000(0000) GS:ffffa2c89fc40000(0000) kn=
lGS:0000000000000000
> > [   33.918818] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [   33.919322] CR2: 00005630a4a1cc88 CR3: 000000010532c000 CR4: 0000000=
000350eb0
> > [   44.072293] ------------[ cut here ]------------
> >
> > Cc: stable@vger.kernel.org # v6.8+
> > Fixes: 665d3e0af4d3 ("ext4: reduce unnecessary memory allocation in all=
oc_flex_gd()")
> > Cc: "Theodore Ts'o" <tytso@mit.edu>
> > Cc: Andreas Dilger <adilger.kernel@dilger.ca>
> > Cc: Jan Kara <jack@suse.cz>
> > Cc: Baokun Li <libaokun1@huawei.com>
> > Cc: St=C3=A9phane Graber <stgraber@stgraber.org>
> > Cc: Christian Brauner <brauner@kernel.org>
> > Cc: <linux-kernel@vger.kernel.org>
> > Cc: <linux-fsdevel@vger.kernel.org>
> > Cc: <linux-ext4@vger.kernel.org>
> > Reported-by: Wesley Hershberger <wesley.hershberger@canonical.com>
> > Closes: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2081231
> > Reported-by: St=C3=A9phane Graber <stgraber@stgraber.org>
> > Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.c=
om>
> > ---
> >  fs/ext4/resize.c | 13 ++++++-------
> >  1 file changed, 6 insertions(+), 7 deletions(-)
> >
> > diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
> > index e04eb08b9060..c057a7867363 100644
> > --- a/fs/ext4/resize.c
> > +++ b/fs/ext4/resize.c
> > @@ -300,8 +300,7 @@ static void free_flex_gd(struct ext4_new_flex_group=
_data *flex_gd)
> >   * block group.
> >   */
> >  static int ext4_alloc_group_tables(struct super_block *sb,
> > -                             struct ext4_new_flex_group_data *flex_gd,
> > -                             unsigned int flexbg_size)
> > +                             struct ext4_new_flex_group_data *flex_gd)
> >  {
> >       struct ext4_new_group_data *group_data =3D flex_gd->groups;
> >       ext4_fsblk_t start_blk;
> > @@ -313,7 +312,7 @@ static int ext4_alloc_group_tables(struct super_blo=
ck *sb,
> >       ext4_group_t group;
> >       ext4_group_t last_group;
> >       unsigned overhead;
> > -     __u16 uninit_mask =3D (flexbg_size > 1) ? ~EXT4_BG_BLOCK_UNINIT :=
 ~0;
> > +     __u16 uninit_mask =3D (flex_gd->resize_bg > 1) ? ~EXT4_BG_BLOCK_U=
NINIT : ~0;
> >       int i;
> >
> >       BUG_ON(flex_gd->count =3D=3D 0 || group_data =3D=3D NULL);
> > @@ -321,8 +320,8 @@ static int ext4_alloc_group_tables(struct super_blo=
ck *sb,
> >       src_group =3D group_data[0].group;
> >       last_group  =3D src_group + flex_gd->count - 1;
> >
> > -     BUG_ON((flexbg_size > 1) && ((src_group & ~(flexbg_size - 1)) !=
=3D
> > -            (last_group & ~(flexbg_size - 1))));
> > +     BUG_ON((flex_gd->resize_bg > 1) && ((src_group & ~(flex_gd->resiz=
e_bg - 1)) !=3D
> > +            (last_group & ~(flex_gd->resize_bg - 1))));
> >  next_group:
> >       group =3D group_data[0].group;
> >       if (src_group >=3D group_data[0].group + flex_gd->count)
> > @@ -403,7 +402,7 @@ static int ext4_alloc_group_tables(struct super_blo=
ck *sb,
> >
> >               printk(KERN_DEBUG "EXT4-fs: adding a flex group with "
> >                      "%u groups, flexbg size is %u:\n", flex_gd->count,
> > -                    flexbg_size);
> > +                    flex_gd->resize_bg);
> >
> >               for (i =3D 0; i < flex_gd->count; i++) {
> >                       ext4_debug(
> > @@ -2158,7 +2157,7 @@ int ext4_resize_fs(struct super_block *sb, ext4_f=
sblk_t n_blocks_count)
> >                                        ext4_blocks_count(es));
> >                       last_update_time =3D jiffies;
> >               }
> > -             if (ext4_alloc_group_tables(sb, flex_gd, flexbg_size) !=
=3D 0)
> > +             if (ext4_alloc_group_tables(sb, flex_gd) !=3D 0)
> >                       break;
> >               err =3D ext4_flex_group_add(sb, resize_inode, flex_gd);
> >               if (unlikely(err))
> > --
> > 2.34.1
> >
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

