Return-Path: <linux-fsdevel+bounces-59438-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C24B38AA1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 22:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8ADCD1B287E2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 20:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EAD62C15AF;
	Wed, 27 Aug 2025 20:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="NzvWbO7v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F2A19924D
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Aug 2025 20:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756325052; cv=none; b=p7F0LGwxL2Vtfz3rH3QdvXSejzGb+XGi/Z5k8WlVyPH4Y8nnKVSCIETdJpuhvKJ6EiVy7Fywmu409k4AA9M0GziYc+ABm07RohJ/vSNx8qciY44Q+YCNlb6KyaQbCR7jSDDx0cbRWcTas/W1Fk+nJ+cmSodcSUeV0cn58E+x6y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756325052; c=relaxed/simple;
	bh=lEECP8sLHkrjv5PDRa5Nz050IrTm7wq11Qe/q+RREgI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=axN2VgqXlc6/z/Ibn9qyU1utPwo3e5cTAO5f3KhHCmeyvkgXJKWDOO7PtCQks7FshN+oOMNRD+A6RyoPzrfxL37hHLv+d5bizEtxXC+bkg9QUVz33vY3unDYn1wkzdvItwgo6vpjBUN1ov+Xr+5oQWJYFXrbF2y3idKzAerULeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=NzvWbO7v; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e953dca529dso182569276.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Aug 2025 13:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1756325049; x=1756929849; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gIElFavk+IY4EPoRuABBoeaw8C7mUqfEAtIctmxNh5U=;
        b=NzvWbO7vTKtaMWBLXgYKxlVuZ7kniu4C2XCcEJhiEb86AGsBkz1AtdbDC2L9xJNBr9
         EBj5ESST9xyFUN9+ItHlkLhc5l8dnXiehqrZCKflokYK/bgH4sZ9yd2hh19Umlrr6Fde
         Q63zDoKjQn4AbzQzj2dkMfhchoyLm1XjLdFawD4Ek/8PGPGIyDcHRpMeyT1yOFZ/I5Sc
         sn/nfnh6PArcb/f8MxvrgGos9O8SZHXZw7W3TCQDCGAtduZTSAAp3eUiGVChTtVppQOp
         g0Z/V9Xci2FvRTh8uhKgq1qtF0Pk2i5yDCPxqHDPZnWro2psIQOLnagZ7zeEO1bIeT6Q
         sViA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756325049; x=1756929849;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gIElFavk+IY4EPoRuABBoeaw8C7mUqfEAtIctmxNh5U=;
        b=UimqtXfpS/v2i3O+MqGoFPESXcBTCGM+pYWzH6LTI9Fne9TxuYsImw1bHcF/Fqa2tV
         Rlx6uLpvI7Qk8llQU/+puHCvhW3htPUYGNbxECR8XUI90YX5ywPH79De+ie1CFJ0hu8U
         EoPXmU0l1H3Kps+Nc3dJY/XTDsJUFnvRww8M7Jc9d9uGsOLaMBm0nynAlWg28aUmGzJX
         2qKM6rAjXTKWAAeycswMMKHEcjPlPYiwnUvYik/Z/w7jJaTBsG8DaE5s6NslSEzwdSU7
         8sNtBNkp+F8Vvsf2ubJUPx+xRovcj4oF/sUQ2eekueQgU3ZAgmzeHIYLuYy1CfiP02RJ
         jTvQ==
X-Gm-Message-State: AOJu0Yzetsrd+QWd3UpmTjjjW0bnI2LZhL54/E28zEBUkVUx+89eHiXM
	6cE3PapMQUNfdZTrL7u5fO0cJKQNb6GA6eTtAxyNdFmEVNE146hQF/S+iKiDck91Vig=
X-Gm-Gg: ASbGncslGTcDO0d5pIfboHk3ElFMAw+Or3v8BQCSriaMai2wiPlC6Whq2CHomVFnKiJ
	EJAr77BfJQuYTXo9sa402S/NY1/xUFFmdMUxLJSZy+bCWe50+XYa+tjhOmJv1Z+THfL1qwRqVzm
	3o84Tj6nOg1kC67ksjTFMsncJw7NlXFwPGKCdZXYu9BNiii/rmptI0AKemsdUdDwS1GIhwGRnkT
	9rBP1okoTruHz2KCn9Jm/yGQXGkTCfdJhk7Ng8dmA3la8lYy6bGJppGDGUr8LZRgpuSNs8y4L2I
	A0wbHMwHCMZ+unGCaEeoPyQK0yQx6dVrar9QC5BB4CRM73lU7kevO30qbdFRzICLOV+yL6jFTRL
	zVn+atTWnY2D2H9+Lpr0RW6SxYIKPI0vfDA==
X-Google-Smtp-Source: AGHT+IGhD1/lT8YmvxteUbOgQfKML7Nke0CB94LOX6/z7nvYthwVGBpKqziGYrSiylPHzzZyWZ2IcA==
X-Received: by 2002:a05:6902:1243:b0:e95:37c1:aa89 with SMTP id 3f1490d57ef6-e9537c1afc3mr15890878276.42.1756325048339;
        Wed, 27 Aug 2025 13:04:08 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:2480:b54f:6f64:7f79])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e96d661d1basm2046705276.13.2025.08.27.13.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 13:04:07 -0700 (PDT)
Message-ID: <2913155abcc272d83d369ff4f81a08483be021dc.camel@dubeyko.com>
Subject: Re: [RFC PATCH v2] hfs: add return values to hfs_brec_lenoff and
 hfs_bnode_read to improve robustness
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Chenzhi Yang <yang.chenzhi@vivo.com>, glaubitz@physik.fu-berlin.de, 
	frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 27 Aug 2025 13:04:06 -0700
In-Reply-To: <20250827064018.327046-1-yang.chenzhi@vivo.com>
References: <20250827064018.327046-1-yang.chenzhi@vivo.com>
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

On Wed, 2025-08-27 at 14:40 +0800, Chenzhi Yang wrote:
> From: Yang Chenzhi <yang.chenzhi@vivo.com>
>=20
> This patch addresses two issues in the hfs filesystem:
>=20
> 1. out-of-bounds access in hfs_bmap_alloc
>=20
> Analysis can be found here:
> https://lore.kernel.org/all/20250818141734.8559-2-yang.chenzhi@vivo.com/
>=20
> With specially crafted offsets from syzbot, hfs_brec_lenoff()
> could return invalid offset and length values.
>=20
> This patch introduces a return value for hfs_brec_lenoff().
> The function now validates offset and length:
> =C2=A0 - if invalid, it returns an error code;
> =C2=A0 - if valid, it returns 0.
>=20
> All callers of hfs_brec_lenoff() are updated to check its return
> value before using offset and length, thus preventing out-of-bounds
> access.
>=20
> 2. potential use of uninitialized memory in hfs_bnode_dump
>=20
> Related bug report:
> https://syzkaller.appspot.com/bug?extid=3Df687659f3c2acfa34201
>=20
> This bug was previously fixed in commit:
> commit a431930c9bac518bf99d6b1da526a7f37ddee8d8
>=20
> However, a new syzbot report indicated a KMSAN use-uninit-value.
> The root cause is that hfs_bnode_dump() calls hfs_bnode_read_u16()
> with an invalid offset.
> =C2=A0 - hfs_bnode_read() detects the invalid offset and returns
> immediately;
> =C2=A0 - Back in hfs_bnode_read_u16(), be16_to_cpu() was then called on a=
n
> =C2=A0=C2=A0=C2=A0 uninitialized variable.
>=20
> To address this, the intended direction is for hfs_bnode_read()
> to return a status code (0 on success, negative errno on failure)
> so that callers can detect errors and exit early, avoiding the use
> of uninitialized memory.
>=20
> However, hfs_bnode_read() is widely used, this patch does not modify
> it directly. Instead, new __hfs_bnode_read*() helper functions are
> introduced, which mirror the original behavior but add offset/length
> validation and return values.
>=20
> For now, only the hfs_bnode_dump() code path is updated to use these
> helpers in order to validate the feasibility of this approach.
>=20
> After applying the patch, the xfstests quick suite was run:
> =C2=A0 - The previously failing generic/113 test now passes;
> =C2=A0 - All other test cases remain unchanged.
>=20
> -------------------------------------------
>=20
> The main idea of this patch is to:
> Add explicit return values to critical functions so that
> invalid offset/length values are reported via error codes;
>=20
> Require all callers to check return values, ensuring
> invalid parameters are not propagated further;
>=20
> Improve the overall robustness of the HFS codebase and
> protect against syzbot-crafted invalid inputs.
>=20
> RFC: feedback is requested on whether adding return values
> to hfs_brec_lenoff() and hfs_bnode_read() in this manner
> is an acceptable direction, and if such safety improvements
> should be expanded more broadly within the HFS subsystem.
>=20
> Signed-off-by: Yang Chenzhi <yang.chenzhi@vivo.com>
> ---
> =C2=A0fs/hfs/bfind.c | 14 ++++----
> =C2=A0fs/hfs/bnode.c | 87 +++++++++++++++++++++++++++++++++++------------=
-
> --
> =C2=A0fs/hfs/brec.c=C2=A0 | 13 ++++++--
> =C2=A0fs/hfs/btree.c | 21 +++++++++---
> =C2=A0fs/hfs/btree.h | 21 +++++++++++-
> =C2=A05 files changed, 116 insertions(+), 40 deletions(-)
>=20
> diff --git a/fs/hfs/bfind.c b/fs/hfs/bfind.c
> index 34e9804e0f36..aea6edd4d830 100644
> --- a/fs/hfs/bfind.c
> +++ b/fs/hfs/bfind.c
> @@ -61,16 +61,16 @@ int __hfs_brec_find(struct hfs_bnode *bnode,
> struct hfs_find_data *fd)
> =C2=A0	u16 off, len, keylen;
> =C2=A0	int rec;
> =C2=A0	int b, e;
> -	int res;
> +	int res, ret;
> =C2=A0
> =C2=A0	b =3D 0;
> =C2=A0	e =3D bnode->num_recs - 1;
> =C2=A0	res =3D -ENOENT;
> =C2=A0	do {
> =C2=A0		rec =3D (e + b) / 2;
> -		len =3D hfs_brec_lenoff(bnode, rec, &off);
> +		ret =3D hfs_brec_lenoff(bnode, rec, &off, &len);

Frankly speaking, I don't think that reworking this method for
returning the error code is necessary. Currently, we return the length
value (u16) and we can return U16_MAX as for off as for len for the
case of incorrect offset or erroneous logic. We can treat U16_MAX as
error condition and we can check off and len for this value. Usually,
HFS b-tree node has 512 bytes in size and as offset as length cannot be
equal to U16_MAX (or bigger). And we don't need to change the input and
output arguments if we will check for U16_MAX value.

> =C2=A0		keylen =3D hfs_brec_keylen(bnode, rec);
> -		if (keylen =3D=3D 0) {
> +		if (keylen =3D=3D 0 || ret) {
> =C2=A0			res =3D -EINVAL;
> =C2=A0			goto fail;
> =C2=A0		}
> @@ -87,9 +87,9 @@ int __hfs_brec_find(struct hfs_bnode *bnode, struct
> hfs_find_data *fd)
> =C2=A0			e =3D rec - 1;
> =C2=A0	} while (b <=3D e);
> =C2=A0	if (rec !=3D e && e >=3D 0) {
> -		len =3D hfs_brec_lenoff(bnode, e, &off);
> +		ret =3D hfs_brec_lenoff(bnode, e, &off, &len);
> =C2=A0		keylen =3D hfs_brec_keylen(bnode, e);
> -		if (keylen =3D=3D 0) {
> +		if (keylen =3D=3D 0 || ret) {

The same here.

> =C2=A0			res =3D -EINVAL;
> =C2=A0			goto fail;
> =C2=A0		}
> @@ -223,9 +223,9 @@ int hfs_brec_goto(struct hfs_find_data *fd, int
> cnt)
> =C2=A0		fd->record +=3D cnt;
> =C2=A0	}
> =C2=A0
> -	len =3D hfs_brec_lenoff(bnode, fd->record, &off);
> +	res =3D hfs_brec_lenoff(bnode, fd->record, &off, &len);
> =C2=A0	keylen =3D hfs_brec_keylen(bnode, fd->record);
> -	if (keylen =3D=3D 0) {
> +	if (keylen =3D=3D 0 || res) {

Ditto.

> =C2=A0		res =3D -EINVAL;
> =C2=A0		goto out;
> =C2=A0	}
> diff --git a/fs/hfs/bnode.c b/fs/hfs/bnode.c
> index e8cd1a31f247..b0bbaf016b8d 100644
> --- a/fs/hfs/bnode.c
> +++ b/fs/hfs/bnode.c
> @@ -57,26 +57,16 @@ int check_and_correct_requested_length(struct
> hfs_bnode *node, int off, int len)
> =C2=A0	return len;
> =C2=A0}
> =C2=A0
> -void hfs_bnode_read(struct hfs_bnode *node, void *buf, int off, int
> len)
> +int __hfs_bnode_read(struct hfs_bnode *node, void *buf, u16 off, u16
> len)

I don't follow why do we need to introduce __hfs_bnode_read(). One
method for all is enough. And I think we still can use only
hfs_bnode_read(). Because, we can initialize the buffer by 0x00 or 0xFF
in the case we cannot read if offset or length are invalid. Usually,
every method checks (or should) check the returning value of
hfs_bnode_read().

> =C2=A0{
> =C2=A0	struct page *page;
> =C2=A0	int pagenum;
> =C2=A0	int bytes_read;
> =C2=A0	int bytes_to_read;
> =C2=A0
> -	if (!is_bnode_offset_valid(node, off))
> -		return;
> -
> -	if (len =3D=3D 0) {
> -		pr_err("requested zero length: "
> -		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "NODE: id %u, type %#x, height %u=
, "
> -		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "node_size %u, offset %d, len %d\=
n",
> -		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 node->this, node->type, node->hei=
ght,
> -		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 node->tree->node_size, off, len);
> -		return;
> -	}
> -
> -	len =3D check_and_correct_requested_length(node, off, len);
> +	/* len =3D 0 is invalid: prevent use of an uninitalized
> buffer*/
> +	if (!len || !hfs_off_and_len_is_valid(node, off, len))
> +		return -EINVAL;
> =C2=A0
> =C2=A0	off +=3D node->page_offset;
> =C2=A0	pagenum =3D off >> PAGE_SHIFT;
> @@ -93,6 +83,47 @@ void hfs_bnode_read(struct hfs_bnode *node, void
> *buf, int off, int len)
> =C2=A0		pagenum++;
> =C2=A0		off =3D 0; /* page offset only applies to the first
> page */
> =C2=A0	}
> +
> +	return 0;
> +}
> +
> +static int __hfs_bnode_read_u16(struct hfs_bnode *node, u16* buf,
> u16 off)

I don't see the point to introduce another version of method because we
can return U16_MAX as invalid value.

> +{
> +	__be16 data;
> +	int res;
> +
> +	res =3D __hfs_bnode_read(node, (void*)(&data), off, 2);
> +	if (res)
> +		return res;
> +	*buf =3D be16_to_cpu(data);
> +	return 0;
> +}
> +
> +
> +static int __hfs_bnode_read_u8(struct hfs_bnode *node, u8* buf, u16
> off)

And we can return U8_MAX as invalid value here too.

> +{
> +	int res;
> +
> +	res =3D __hfs_bnode_read(node, (void*)(&buf), off, 2);
> +	if (res)
> +		return res;
> +	return 0;
> +}
> +
> +void hfs_bnode_read(struct hfs_bnode *node, void *buf, int off, int
> len)

I don't think that we need two methods instead of one.

> +{
> +	int res;
> +
> +	len =3D check_and_correct_requested_length(node, off, len);
> +	res =3D __hfs_bnode_read(node, buf, (u16)off, (u16)len);
> +	if (res) {
> +		pr_err("hfs_bnode_read error: "
> +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "NODE: id %u, type %#x, height %u=
, "
> +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "node_size %u, offset %d, len %d\=
n",
> +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 node->this, node->type, node->hei=
ght,
> +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 node->tree->node_size, off, len);
> +	}
> +	return;
> =C2=A0}
> =C2=A0
> =C2=A0u16 hfs_bnode_read_u16(struct hfs_bnode *node, int off)
> @@ -241,7 +272,8 @@ void hfs_bnode_dump(struct hfs_bnode *node)

The hfs_bnode_dump() is mostly debugging method. So, maybe, it could be
interesting to see the "garbage" instead of breaking the read logic.

> =C2=A0{
> =C2=A0	struct hfs_bnode_desc desc;
> =C2=A0	__be32 cnid;
> -	int i, off, key_off;
> +	int i, res;
> +	u16 off, key_off;
> =C2=A0
> =C2=A0	hfs_dbg(BNODE_MOD, "bnode: %d\n", node->this);
> =C2=A0	hfs_bnode_read(node, &desc, 0, sizeof(desc));
> @@ -251,23 +283,28 @@ void hfs_bnode_dump(struct hfs_bnode *node)
> =C2=A0
> =C2=A0	off =3D node->tree->node_size - 2;
> =C2=A0	for (i =3D be16_to_cpu(desc.num_recs); i >=3D 0; off -=3D 2, i--)
> {
> -		key_off =3D hfs_bnode_read_u16(node, off);
> +		res =3D __hfs_bnode_read_u16(node, &key_off, off);
> +		if (res) return;
> =C2=A0		hfs_dbg_cont(BNODE_MOD, " %d", key_off);
> =C2=A0		if (i && node->type =3D=3D HFS_NODE_INDEX) {
> -			int tmp;
> -
> -			if (node->tree->attributes &
> HFS_TREE_VARIDXKEYS)
> -				tmp =3D (hfs_bnode_read_u8(node,
> key_off) | 1) + 1;
> -			else
> +			u8 tmp, data;
> +			if (node->tree->attributes &
> HFS_TREE_VARIDXKEYS) {
> +				res =3D __hfs_bnode_read_u8(node,
> &data, key_off);
> +				if (res) return;

This breaks the kernel code style.

> +				tmp =3D (data | 1) + 1;
> +			} else {
> =C2=A0				tmp =3D node->tree->max_key_len + 1;
> -			hfs_dbg_cont(BNODE_MOD, " (%d,%d",
> -				=C2=A0=C2=A0=C2=A0=C2=A0 tmp, hfs_bnode_read_u8(node,
> key_off));
> +			}
> +			res =3D __hfs_bnode_read_u8(node, &data,
> key_off);
> +			if (res) return;

This breaks the kernel code style.

> +			hfs_dbg_cont(BNODE_MOD, " (%d,%d", tmp,
> data);
> =C2=A0			hfs_bnode_read(node, &cnid, key_off + tmp,
> 4);
> =C2=A0			hfs_dbg_cont(BNODE_MOD, ",%d)",
> be32_to_cpu(cnid));
> =C2=A0		} else if (i && node->type =3D=3D HFS_NODE_LEAF) {
> -			int tmp;
> +			u8 tmp;
> =C2=A0
> -			tmp =3D hfs_bnode_read_u8(node, key_off);
> +			res =3D __hfs_bnode_read_u8(node, &tmp,
> key_off);
> +			if (res) return;

This breaks the kernel code style.

> =C2=A0			hfs_dbg_cont(BNODE_MOD, " (%d)", tmp);
> =C2=A0		}
> =C2=A0	}
> diff --git a/fs/hfs/brec.c b/fs/hfs/brec.c
> index 896396554bcc..d7026a3ffeea 100644
> --- a/fs/hfs/brec.c
> +++ b/fs/hfs/brec.c
> @@ -16,15 +16,22 @@ static int hfs_brec_update_parent(struct
> hfs_find_data *fd);
> =C2=A0static int hfs_btree_inc_height(struct hfs_btree *tree);
> =C2=A0
> =C2=A0/* Get the length and offset of the given record in the given node
> */
> -u16 hfs_brec_lenoff(struct hfs_bnode *node, u16 rec, u16 *off)
> +int hfs_brec_lenoff(struct hfs_bnode *node, u16 rec, u16 *off, u16
> *len)

Please, see my comments above. I think we can use U16_MAX as invalid
value.

> =C2=A0{
> =C2=A0	__be16 retval[2];
> =C2=A0	u16 dataoff;
> +	int res;
> =C2=A0
> =C2=A0	dataoff =3D node->tree->node_size - (rec + 2) * 2;
> -	hfs_bnode_read(node, retval, dataoff, 4);
> +	res =3D __hfs_bnode_read(node, retval, dataoff, 4);
> +	if (res)
> +		return -EINVAL;
> =C2=A0	*off =3D be16_to_cpu(retval[1]);
> -	return be16_to_cpu(retval[0]) - *off;
> +	*len =3D be16_to_cpu(retval[0]) - *off;
> +	if (!hfs_off_and_len_is_valid(node, *off, *len) ||
> +			*off < sizeof(struct hfs_bnode_desc))
> +		return -EINVAL;
> +	return 0;
> =C2=A0}
> =C2=A0
> =C2=A0/* Get the length of the key from a keyed record */
> diff --git a/fs/hfs/btree.c b/fs/hfs/btree.c
> index e86e1e235658..b13582dcc27a 100644
> --- a/fs/hfs/btree.c
> +++ b/fs/hfs/btree.c
> @@ -301,7 +301,9 @@ struct hfs_bnode *hfs_bmap_alloc(struct hfs_btree
> *tree)
> =C2=A0	node =3D hfs_bnode_find(tree, nidx);
> =C2=A0	if (IS_ERR(node))
> =C2=A0		return node;
> -	len =3D hfs_brec_lenoff(node, 2, &off16);
> +	res =3D hfs_brec_lenoff(node, 2, &off16, &len);
> +	if (res)
> +		return ERR_PTR(res);
> =C2=A0	off =3D off16;
> =C2=A0
> =C2=A0	off +=3D node->page_offset;
> @@ -347,7 +349,9 @@ struct hfs_bnode *hfs_bmap_alloc(struct hfs_btree
> *tree)
> =C2=A0			return next_node;
> =C2=A0		node =3D next_node;
> =C2=A0
> -		len =3D hfs_brec_lenoff(node, 0, &off16);
> +		res =3D hfs_brec_lenoff(node, 0, &off16, &len);
> +		if (res)
> +			return ERR_PTR(res);
> =C2=A0		off =3D off16;
> =C2=A0		off +=3D node->page_offset;
> =C2=A0		pagep =3D node->page + (off >> PAGE_SHIFT);
> @@ -363,6 +367,7 @@ void hfs_bmap_free(struct hfs_bnode *node)
> =C2=A0	u16 off, len;
> =C2=A0	u32 nidx;
> =C2=A0	u8 *data, byte, m;
> +	int res;
> =C2=A0
> =C2=A0	hfs_dbg(BNODE_MOD, "btree_free_node: %u\n", node->this);
> =C2=A0	tree =3D node->tree;
> @@ -370,7 +375,9 @@ void hfs_bmap_free(struct hfs_bnode *node)
> =C2=A0	node =3D hfs_bnode_find(tree, 0);
> =C2=A0	if (IS_ERR(node))
> =C2=A0		return;
> -	len =3D hfs_brec_lenoff(node, 2, &off);
> +	res =3D hfs_brec_lenoff(node, 2, &off, &len);
> +	if (res)
> +		goto fail;
> =C2=A0	while (nidx >=3D len * 8) {
> =C2=A0		u32 i;
> =C2=A0
> @@ -394,7 +401,9 @@ void hfs_bmap_free(struct hfs_bnode *node)
> =C2=A0			hfs_bnode_put(node);
> =C2=A0			return;
> =C2=A0		}
> -		len =3D hfs_brec_lenoff(node, 0, &off);
> +		res =3D hfs_brec_lenoff(node, 0, &off, &len);
> +		if (res)
> +			goto fail;
> =C2=A0	}
> =C2=A0	off +=3D node->page_offset + nidx / 8;
> =C2=A0	page =3D node->page[off >> PAGE_SHIFT];
> @@ -415,4 +424,8 @@ void hfs_bmap_free(struct hfs_bnode *node)
> =C2=A0	hfs_bnode_put(node);
> =C2=A0	tree->free_nodes++;
> =C2=A0	mark_inode_dirty(tree->inode);
> +	return;
> +fail:
> +	hfs_bnode_put(node);
> +	pr_err("fail to free a bnode due to invalid off or len\n");

I am not sure that breaking free bnode logic because of incorrect
length (and, maybe, even offset) is correct behavior. Because, we can
correct length and continue to free bnode. So, I am not sure that
complete failure is the correct way of managing the situation.

Thanks,
Slava.

> =C2=A0}
> diff --git a/fs/hfs/btree.h b/fs/hfs/btree.h
> index 0e6baee93245..78f228e62a86 100644
> --- a/fs/hfs/btree.h
> +++ b/fs/hfs/btree.h
> @@ -94,6 +94,7 @@ extern struct hfs_bnode * hfs_bmap_alloc(struct
> hfs_btree *);
> =C2=A0extern void hfs_bmap_free(struct hfs_bnode *node);
> =C2=A0
> =C2=A0/* bnode.c */
> +extern int __hfs_bnode_read(struct hfs_bnode *, void *, u16, u16);
> =C2=A0extern void hfs_bnode_read(struct hfs_bnode *, void *, int, int);
> =C2=A0extern u16 hfs_bnode_read_u16(struct hfs_bnode *, int);
> =C2=A0extern u8 hfs_bnode_read_u8(struct hfs_bnode *, int);
> @@ -116,7 +117,7 @@ extern void hfs_bnode_get(struct hfs_bnode *);
> =C2=A0extern void hfs_bnode_put(struct hfs_bnode *);
> =C2=A0
> =C2=A0/* brec.c */
> -extern u16 hfs_brec_lenoff(struct hfs_bnode *, u16, u16 *);
> +extern int hfs_brec_lenoff(struct hfs_bnode *, u16, u16 *, u16 *);
> =C2=A0extern u16 hfs_brec_keylen(struct hfs_bnode *, u16);
> =C2=A0extern int hfs_brec_insert(struct hfs_find_data *, void *, int);
> =C2=A0extern int hfs_brec_remove(struct hfs_find_data *);
> @@ -170,3 +171,21 @@ struct hfs_btree_header_rec {
> =C2=A0						=C2=A0=C2=A0 max key length.
> use din catalog
> =C2=A0						=C2=A0=C2=A0 b-tree but not in
> extents
> =C2=A0						=C2=A0=C2=A0 b-tree (hfsplus).
> */
> +static inline
> +bool hfs_off_and_len_is_valid(struct hfs_bnode *node, u16 off, u16
> len)
> +{
> +	bool ret =3D true;
> +	if (off > node->tree->node_size ||
> +			off + len > node->tree->node_size)
> +		ret =3D false;
> +
> +	if (!ret) {
> +		pr_err("requested invalid offset: "
> +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "NODE: id %u, type %#x, height %u=
, "
> +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "node_size %u, offset %u, length =
%u\n",
> +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 node->this, node->type, node->hei=
ght,
> +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 node->tree->node_size, off, len);
> +	}
> +
> +	return ret;
> +}

