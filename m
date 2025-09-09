Return-Path: <linux-fsdevel+bounces-60719-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F38B7B5057F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 20:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E65F4E4CA5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 18:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33DE9301000;
	Tue,  9 Sep 2025 18:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="XwbzNfND"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9303002C2
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Sep 2025 18:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757443332; cv=none; b=MwLDm3WxipK6EhZY7n32Xo2ck6YUwRSDk8YCCkTW1b3I0ON2Qckk4ZidKaYPaGh9NuE3maT5ttzSM6MkZL6nk9xzrDyCZeeBwv1TrINVdbVspmA7hlEHmy7wWnWGc3dm+vhvV1U5YnkQdbwp2McYaRgeUEnpk29rX9N3lULdgKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757443332; c=relaxed/simple;
	bh=WLs5XCr0hbg3CG/7QuPwGg3fdr9HJpK2na9IiA8zc5c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fIeJve3Jvfun9qzU+OUposrdpsBhu9s23bBgcAOmuPmHvbZDLgOVo1sj1dJoWbCApdZFqGmbMOS5b0FJ3Lbxjs+dz8nKfBzmNwU+uaxyDrlblGOZ/nDASdmuDvxNrVEKCqfDRGQcibvSkorET0rYp7eI3TyBPo4KjFuNv4u5iHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=XwbzNfND; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-60f4731085bso1475552d50.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Sep 2025 11:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1757443329; x=1758048129; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RDmMTj4Mvs60F+h7kKfTcgdYY2+qzIvX/Vo1FJ9IUx4=;
        b=XwbzNfND5T9z6qhADcfOtHJ4rVE5qKmdo4YkLpAyUS0AYBepVNbw+7BFva3bSCfhyV
         8z5rmVMjeHKhuCpmQEnzLRSPy7HV05Vm0n2+PKbok4f+16IrHy0mx1VfpNfNWWlHUXT6
         U7HnYozIO4T24d67vjYFsz15InNYv/QaNQQ2p6iYGUuhEuXlyrYzOE1v9EE7x/Vkx6pK
         UM0yxtciPn5u3SXOU+/2J1LEBblY+/EbBVySavXQg//ip54aSwrV5ZAnZgQhKHrNm6sN
         LxQyGp7bruTXyMjZ0jNQYNQUE84FcxvCJ6dAamdb7ghTRpuZ1KdjkNzzj6CMRzx3v0kf
         Q7OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757443329; x=1758048129;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RDmMTj4Mvs60F+h7kKfTcgdYY2+qzIvX/Vo1FJ9IUx4=;
        b=azGTazn+wjyH6ykiOf1zKmOf+6OSRVP0z/deXAcxUGXodQQG7i5Az2soGOZP7nhicw
         J9oYkD5XTr2EOQFcAcaz5tOVo6RNbzm+YXz9NW5MxkKr7jknqSgND4WcgnnkOFaajdyk
         7aIog3IBcPhPwajwFDoGQOUhbTWt7ftDP+A2h4tVxeu2Op+6DeisTgGDPrO5WHD+L2Rx
         c01spZjTJ6CHzhDED6hgWFUQUByo4zVLtqkmmOJxSYoVJE1evgqNKdgi8I7EhP8aNEGx
         7ZmPk2kvKeU5RFMTbJPv8OLFpTFQ4/XELiZDvl2Avk7PE9Dd5ovBcpSan49+LaNbM0jC
         gdtw==
X-Forwarded-Encrypted: i=1; AJvYcCVQ6o8UzA+pvgpR9I9T2WlALwHDDyujQjMyVEUWAUmo35L4XF4lyGaXe+9DL0+3nHU0RNA5v9X3tgCKADJN@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb4OHRbVdeQpyhwgOh9NgjX3akf+MgWo8/Ky6Gw3NsTd5inip3
	cRjlZR4Uyx7flanPXej0lgQeG89tYILhmR1fCYbxqmv0l+1uIIt8RY4Sea8y2P/Tlvs=
X-Gm-Gg: ASbGncuoMzzK8hzT9Ue2erOegnNW/T/cznzToaJHpQZWS/g6EN5xn82g4q0DzpGOoYq
	1+1RNpCNp4pVi1QINQqKhPV19V62KDlkQ5mJUn2YKGQvMwjES5HwZL+nBESviElE6Py/HLJeamN
	72S0TvwSvM3znVODtuEeVe0LaFMCocwbBtt0A5nXs2XKpLwM7U5zQhh537OxoK3epIzpIXESarX
	Zan3rrM2Q/Zfs3kBCacjWko7ekLXU7aJj1NbbB6+RlfpIgUeSLLwC+dcZbCtUurDrsDar+Epmdl
	E352+skxohm8cyySGgWEMsQWxLSACvRujas4z9dtHF4VmJH0ZyBn9uXdIMYNCha6IUR0ar0H8+5
	QPRXlzCDwQ0Fz7e/q5soH3+HnaP7vdBpKh3Ngai5eG3cw
X-Google-Smtp-Source: AGHT+IG88T8dpyM0E/9PxtudUkT35w9yaSj1TiTjQCadcupBWSe4801YorkP8KyN1hexUg6oCvdtWg==
X-Received: by 2002:a05:690e:259c:b0:615:be7:8083 with SMTP id 956f58d0204a3-6150be79189mr5042366d50.8.1757443328922;
        Tue, 09 Sep 2025 11:42:08 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:1689:6011:96a1:eafd])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-723a8552c52sm62783637b3.51.2025.09.09.11.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 11:42:08 -0700 (PDT)
Message-ID: <4a07aee032e8fbe00db5cbe5ee9717879e42b462.camel@dubeyko.com>
Subject: Re: [SECURITY] [PATCH V3] hfsplus: fix slab-out-of-bounds read in
 hfsplus_uni2asc()
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Kang Chen <k.chen@smail.nju.edu.cn>
Cc: frank.li@vivo.com, glaubitz@physik.fu-berlin.de, 
	linux-fsdevel@vger.kernel.org, liushixin2@huawei.com, security@kernel.org, 
	wenzhi.wang@uwaterloo.ca
Date: Tue, 09 Sep 2025 11:42:06 -0700
In-Reply-To: <20250909031316.1647094-1-k.chen@smail.nju.edu.cn>
References: <20250907010826.597854-1-k.chen@smail.nju.edu.cn>
	 <20250909031316.1647094-1-k.chen@smail.nju.edu.cn>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-09-09 at 11:13 +0800, Kang Chen wrote:
> BUG: KASAN: slab-out-of-bounds in hfsplus_uni2asc+0xa71/0xb90
> fs/hfsplus/unicode.c:186
> Read of size 2 at addr ffff8880289ef218 by task syz.6.248/14290
>=20
> CPU: 0 UID: 0 PID: 14290 Comm: syz.6.248 Not tainted 6.16.4 #1
> PREEMPT(full)
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1
> 04/01/2014
> Call Trace:
> =C2=A0<TASK>
> =C2=A0__dump_stack lib/dump_stack.c:94 [inline]
> =C2=A0dump_stack_lvl+0x116/0x1b0 lib/dump_stack.c:120
> =C2=A0print_address_description mm/kasan/report.c:378 [inline]
> =C2=A0print_report+0xca/0x5f0 mm/kasan/report.c:482
> =C2=A0kasan_report+0xca/0x100 mm/kasan/report.c:595
> =C2=A0hfsplus_uni2asc+0xa71/0xb90 fs/hfsplus/unicode.c:186
> =C2=A0hfsplus_listxattr+0x5b6/0xbd0 fs/hfsplus/xattr.c:738
> =C2=A0vfs_listxattr+0xbe/0x140 fs/xattr.c:493
> =C2=A0listxattr+0xee/0x190 fs/xattr.c:924
> =C2=A0filename_listxattr fs/xattr.c:958 [inline]
> =C2=A0path_listxattrat+0x143/0x360 fs/xattr.c:988
> =C2=A0do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> =C2=A0do_syscall_64+0xcb/0x4c0 arch/x86/entry/syscall_64.c:94
> =C2=A0entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fe0e9fae16d
> Code: 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48
> 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48>
> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fe0eae67f98 EFLAGS: 00000246 ORIG_RAX:
> 00000000000000c3
> RAX: ffffffffffffffda RBX: 00007fe0ea205fa0 RCX: 00007fe0e9fae16d
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000200000000000
> RBP: 00007fe0ea0480f0 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007fe0ea206038 R14: 00007fe0ea205fa0 R15: 00007fe0eae48000
> =C2=A0</TASK>
>=20
> Allocated by task 14290:
> =C2=A0kasan_save_stack+0x24/0x50 mm/kasan/common.c:47
> =C2=A0kasan_save_track+0x14/0x30 mm/kasan/common.c:68
> =C2=A0poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
> =C2=A0__kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:394
> =C2=A0kasan_kmalloc include/linux/kasan.h:260 [inline]
> =C2=A0__do_kmalloc_node mm/slub.c:4333 [inline]
> =C2=A0__kmalloc_noprof+0x219/0x540 mm/slub.c:4345
> =C2=A0kmalloc_noprof include/linux/slab.h:909 [inline]
> =C2=A0hfsplus_find_init+0x95/0x1f0 fs/hfsplus/bfind.c:21
> =C2=A0hfsplus_listxattr+0x331/0xbd0 fs/hfsplus/xattr.c:697
> =C2=A0vfs_listxattr+0xbe/0x140 fs/xattr.c:493
> =C2=A0listxattr+0xee/0x190 fs/xattr.c:924
> =C2=A0filename_listxattr fs/xattr.c:958 [inline]
> =C2=A0path_listxattrat+0x143/0x360 fs/xattr.c:988
> =C2=A0do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> =C2=A0do_syscall_64+0xcb/0x4c0 arch/x86/entry/syscall_64.c:94
> =C2=A0entry_SYSCALL_64_after_hwframe+0x77/0x7f
>=20
> When hfsplus_uni2asc is called from hfsplus_listxattr,
> it actually passes in a struct hfsplus_attr_unistr*.
> The size of the corresponding structure is different from that of
> hfsplus_unistr,
> so the previous fix (94458781aee6) is insufficient.
> The pointer on the unicode buffer is still going beyond the allocated
> memory.
>=20
> This patch introduces two warpper functions hfsplus_uni2asc_xattr_str
> and
> hfsplus_uni2asc_str to process two unicode buffers,
> struct hfsplus_attr_unistr* and struct hfsplus_unistr* respectively.
> When ustrlen value is bigger than the allocated memory size,
> the ustrlen value is limited to an safe size.
>=20
> Fixes: 94458781aee6 ("hfsplus: fix slab-out-of-bounds read in
> hfsplus_uni2asc()")
> Signed-off-by: Kang Chen <k.chen@smail.nju.edu.cn>
> ---
> V2 -> V1: change struct pointer type to pass compiler
> V3 -> V2: complete the commit message and use two warpper functions

Looks good.

Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>

Thanks,
Slava.

>=20
> =C2=A0fs/hfsplus/dir.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 =
2 +-
> =C2=A0fs/hfsplus/hfsplus_fs.h |=C2=A0 8 ++++++--
> =C2=A0fs/hfsplus/unicode.c=C2=A0=C2=A0=C2=A0 | 24 +++++++++++++++++++----=
-
> =C2=A0fs/hfsplus/xattr.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 6 +++---
> =C2=A04 files changed, 29 insertions(+), 11 deletions(-)
>=20
> diff --git a/fs/hfsplus/dir.c b/fs/hfsplus/dir.c
> index 876bbb80fb4d..1b3e27a0d5e0 100644
> --- a/fs/hfsplus/dir.c
> +++ b/fs/hfsplus/dir.c
> @@ -204,7 +204,7 @@ static int hfsplus_readdir(struct file *file,
> struct dir_context *ctx)
> =C2=A0			fd.entrylength);
> =C2=A0		type =3D be16_to_cpu(entry.type);
> =C2=A0		len =3D NLS_MAX_CHARSET_SIZE * HFSPLUS_MAX_STRLEN;
> -		err =3D hfsplus_uni2asc(sb, &fd.key->cat.name, strbuf,
> &len);
> +		err =3D hfsplus_uni2asc_str(sb, &fd.key->cat.name,
> strbuf, &len);
> =C2=A0		if (err)
> =C2=A0			goto out;
> =C2=A0		if (type =3D=3D HFSPLUS_FOLDER) {
> diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
> index 96a5c24813dd..2311e4be4e86 100644
> --- a/fs/hfsplus/hfsplus_fs.h
> +++ b/fs/hfsplus/hfsplus_fs.h
> @@ -521,8 +521,12 @@ int hfsplus_strcasecmp(const struct
> hfsplus_unistr *s1,
> =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct hfsplus_unistr =
*s2);
> =C2=A0int hfsplus_strcmp(const struct hfsplus_unistr *s1,
> =C2=A0		=C2=A0=C2=A0 const struct hfsplus_unistr *s2);
> -int hfsplus_uni2asc(struct super_block *sb, const struct
> hfsplus_unistr *ustr,
> -		=C2=A0=C2=A0=C2=A0 char *astr, int *len_p);
> +int hfsplus_uni2asc_str(struct super_block *sb,
> +			const struct hfsplus_unistr *ustr, char
> *astr,
> +			int *len_p);
> +int hfsplus_uni2asc_xattr_str(struct super_block *sb,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct hfsplus_attr_unistr
> *ustr,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char *astr, int *len_p);
> =C2=A0int hfsplus_asc2uni(struct super_block *sb, struct hfsplus_unistr
> *ustr,
> =C2=A0		=C2=A0=C2=A0=C2=A0 int max_unistr_len, const char *astr, int len)=
;
> =C2=A0int hfsplus_hash_dentry(const struct dentry *dentry, struct qstr
> *str);
> diff --git a/fs/hfsplus/unicode.c b/fs/hfsplus/unicode.c
> index 36b6cf2a3abb..862ba27f1628 100644
> --- a/fs/hfsplus/unicode.c
> +++ b/fs/hfsplus/unicode.c
> @@ -119,9 +119,8 @@ static u16 *hfsplus_compose_lookup(u16 *p, u16
> cc)
> =C2=A0	return NULL;
> =C2=A0}
> =C2=A0
> -int hfsplus_uni2asc(struct super_block *sb,
> -		const struct hfsplus_unistr *ustr,
> -		char *astr, int *len_p)
> +static int hfsplus_uni2asc(struct super_block *sb, const struct
> hfsplus_unistr *ustr,
> +		=C2=A0=C2=A0=C2=A0 int max_len, char *astr, int *len_p)
> =C2=A0{
> =C2=A0	const hfsplus_unichr *ip;
> =C2=A0	struct nls_table *nls =3D HFSPLUS_SB(sb)->nls;
> @@ -134,8 +133,8 @@ int hfsplus_uni2asc(struct super_block *sb,
> =C2=A0	ip =3D ustr->unicode;
> =C2=A0
> =C2=A0	ustrlen =3D be16_to_cpu(ustr->length);
> -	if (ustrlen > HFSPLUS_MAX_STRLEN) {
> -		ustrlen =3D HFSPLUS_MAX_STRLEN;
> +	if (ustrlen > max_len) {
> +		ustrlen =3D max_len;
> =C2=A0		pr_err("invalid length %u has been corrected to
> %d\n",
> =C2=A0			be16_to_cpu(ustr->length), ustrlen);
> =C2=A0	}
> @@ -256,6 +255,21 @@ int hfsplus_uni2asc(struct super_block *sb,
> =C2=A0	return res;
> =C2=A0}
> =C2=A0
> +inline int hfsplus_uni2asc_str(struct super_block *sb,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct hfsplus_unistr *ust=
r,
> char *astr,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int *len_p)
> +{
> +	return hfsplus_uni2asc(sb, ustr, HFSPLUS_MAX_STRLEN, astr,
> len_p);
> +}
> +
> +inline int hfsplus_uni2asc_xattr_str(struct super_block *sb,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 const struct
> hfsplus_attr_unistr *ustr,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 char *astr, int *len_p)
> +{
> +	return hfsplus_uni2asc(sb, (const struct hfsplus_unistr
> *)ustr,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 HFSPLUS_ATTR_MAX_STRLEN, astr,
> len_p);
> +}
> +
> =C2=A0/*
> =C2=A0 * Convert one or more ASCII characters into a single unicode
> character.
> =C2=A0 * Returns the number of ASCII characters corresponding to the
> unicode char.
> diff --git a/fs/hfsplus/xattr.c b/fs/hfsplus/xattr.c
> index 18dc3d254d21..c951fa9835aa 100644
> --- a/fs/hfsplus/xattr.c
> +++ b/fs/hfsplus/xattr.c
> @@ -735,9 +735,9 @@ ssize_t hfsplus_listxattr(struct dentry *dentry,
> char *buffer, size_t size)
> =C2=A0			goto end_listxattr;
> =C2=A0
> =C2=A0		xattr_name_len =3D NLS_MAX_CHARSET_SIZE *
> HFSPLUS_ATTR_MAX_STRLEN;
> -		if (hfsplus_uni2asc(inode->i_sb,
> -			(const struct hfsplus_unistr *)&fd.key-
> >attr.key_name,
> -					strbuf, &xattr_name_len)) {
> +		if (hfsplus_uni2asc_xattr_str(inode->i_sb,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &fd.key-
> >attr.key_name, strbuf,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &xattr_name_len)) {
> =C2=A0			pr_err("unicode conversion failed\n");
> =C2=A0			res =3D -EIO;
> =C2=A0			goto end_listxattr;

