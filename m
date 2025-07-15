Return-Path: <linux-fsdevel+bounces-55024-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF9CB066B6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 21:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FCA51895167
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 19:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD162BEC23;
	Tue, 15 Jul 2025 19:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="Xs06nDen"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B8E26D4CF
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jul 2025 19:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752607223; cv=none; b=blKdVKfXhKz/fMwEMJUTLfD5n01xTbQrOrqOHfvCkjnhlygEFMv/f61cRTFnhWjQFT6xyoJT+Es6nbwRQjMQHEN27SVnn32A9XKR5RZQJef8Zv/56Scg5YzZDWWGd/LGZYdz4eCnTMi7QbyeGz6W32e0u/FupncldJaREm3y7W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752607223; c=relaxed/simple;
	bh=z9FEBK4ATYBXZXrK4juNd0w6CLSefdZH8NpY8gHimyk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jQeSI0VG1IcjgX8EVh7ZIpZLNWSPh9kPrZE3V+wVrZ42ca9P/+uPwwVWOTmZCu6Oa7LobMb/FbvYamNLTPU8ek/8NRN88Jz6bKRGS6e2/cQPRHu2Q2dR860ZEryOR9mVBdD7CrLprrzI1La88rklzSQxom6JENPDnveDLwXnff4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=Xs06nDen; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e8b62d09908so5410503276.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jul 2025 12:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1752607220; x=1753212020; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0Iy19JY5XNgs3r8E4txe9TVMwR2RCJAFm46qs90Z6yE=;
        b=Xs06nDenG9YcZAOomQbR9gf2u5uvxJmEbUHsTys9ddjSDC9zGHETcLnQq5Bk8yONcj
         D6zj9eiAyMZ6PbYxJxL5bfoRplaSLwIDoMZWxawqLsuWXZM1OqoiQ/dzms8860C6IMUl
         Hv+6OICVa90ZrhjS2OamUr5zXtG/Nrq4H28fZeRTlT2lYYIaxuWmfz5MVSbS34chboBl
         23SifGGirTjOEWuWp+CBCctl9eSO4eVVue6eSKF+dBIuV8xGjcoqeRbKTW8Kh+qbZfQI
         Y5H4sL/4dqcSlLTuYmQHQhLK8xRrHIGobZ85WnNHMCQPAFIBls6Sm0oGKmnp2cx+R1jU
         G8Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752607220; x=1753212020;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Iy19JY5XNgs3r8E4txe9TVMwR2RCJAFm46qs90Z6yE=;
        b=RBrwSS+7Uty/2g9jZ63LBd8hI2ZZEE+qo3H6LwfmPEdFhFlZAzdzXamcwhvPuruquW
         BJxxjlTszEO31Kd1FK0uB3zCWPCPffFskTs1fL+8t1kygCgaxKfmxXfPfKyRplIWr3s3
         SF1Gsen/QFieazyA+VoSX+7X4VwU5qSHM3p95Hcoa2Nzh5IMVVJugl3qzRUxkxfPQNhc
         r0RiCPPHCBQSfZ1IBxtwh/49RPd3celSAKiCggvSFK5GYUgoZBEARv/L0gHyYVye3G8r
         F4ANjjo/irceuTZ4gC2Qs8MxyAsuFkBmRzxigvl0aDuseF4olyoufvjmCV5f5yv6cj1J
         QqLg==
X-Forwarded-Encrypted: i=1; AJvYcCUgK0mAj3RaZziDVUQ+kw0B4Q2M6G5RaAYgJKH+Lk9utoJiH1vgmoybQKrx4xBX/34R6ab6nck4Mxcsw3sX@vger.kernel.org
X-Gm-Message-State: AOJu0YxVWydIMNG6YxTC88u+i2CeqqWYLJ2PQBbNz59ni966NvtCyBzg
	dKaKm3g1+J7VZOKv5SwXUOxYQLdIGxshta66Oel7B2Sv6iuUhid2keHijtCSnzc6JsEAYx29RBp
	W/pKc/rZwLg==
X-Gm-Gg: ASbGncvvkA2mkft4kfjVTg9yeI1u0xMzz7bKCANy+Z5LJTFW2YGqoGp5nuc5qS38d4O
	vpeISWY6bL2XDrh6oMl9X0ETZJXO9chtwiH2oGXB5+dzz6l1gy6UBNgfplF8SPhzaAiTVOp4S0P
	FSDt1jVtUWVj756oXEYjICoT0amHXNZJ79QyGntatw++urhGp2fzDxssI9qiTyz6+BKdc6dMaP/
	lemKVuPmc3hT0U9mWbZ94IRhB+HJ5LEdZo2yRrsYBjC5JGKl8sReLtQrOT+C8q7IB5mWV+xEVDR
	hte28UXlO9t+XeBYzmX0VKRcuZv1eAYyr180U0Xdk+nuU+pV7whh87bs9r9QW0bmY/+s6ad6l4U
	lfmA0OnNbaTJvhSVQSEbPGEj5LUKVayaL3VTNzdsXhd1l0RZvi/hvMUFG/0ufnprN1p5GAg==
X-Google-Smtp-Source: AGHT+IHDrtoSIdUfR861XkjZK3RuIKJCU3EePRJBEIqf0iO6i4dldB0AavSvAIg/dfE7IIXbJu85Eg==
X-Received: by 2002:a05:6902:1381:b0:e89:a15d:2bf6 with SMTP id 3f1490d57ef6-e8bc269ef23mr1980276.7.1752607219589;
        Tue, 15 Jul 2025 12:20:19 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:b4ff:5ce4:f713:9976? ([2600:1700:6476:1430:b4ff:5ce4:f713:9976])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e8bc19023e3sm68413276.7.2025.07.15.12.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 12:20:18 -0700 (PDT)
Message-ID: <4c1eb34018cabe33f81b1aa13d5eb0adc44661e7.camel@dubeyko.com>
Subject: Re: [PATCH v2] hfs: remove BUG() from
 hfs_release_folio()/hfs_test_inode()/hfs_write_inode()
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, John Paul Adrian
 Glaubitz <glaubitz@physik.fu-berlin.de>, Yangtao Li <frank.li@vivo.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-fsdevel
	 <linux-fsdevel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
 Matthew Wilcox <willy@infradead.org>
Date: Tue, 15 Jul 2025 12:20:17 -0700
In-Reply-To: <db6a106e-e048-49a8-8945-b10b3bf46c47@I-love.SAKURA.ne.jp>
References: <ddee2787-dcd9-489d-928b-55a4a95eed6c@I-love.SAKURA.ne.jp>
	 <b6e39a3e-f7ce-4f7e-aa77-f6b146bd7c92@I-love.SAKURA.ne.jp>
	 <Z1GxzKmR-oA3Fmmv@casper.infradead.org>
	 <b992789a-84f5-4f57-88f6-76efedd7d00e@I-love.SAKURA.ne.jp>
	 <24e72990-2c48-4084-b229-21161cc27851@I-love.SAKURA.ne.jp>
	 <db6a106e-e048-49a8-8945-b10b3bf46c47@I-love.SAKURA.ne.jp>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-07-15 at 15:51 +0900, Tetsuo Handa wrote:
> Since syzkaller can mount crafted filesystem images with inode->ino
> =3D=3D 0
> (which is not listed as "Some special File ID numbers" in
> fs/hfs/hfs.h ),
> replace BUG() with pr_warn().
>=20
> Reported-by: syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D97e301b4b82ae803d21b
> Tested-by: syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
> =C2=A0fs/hfs/inode.c | 6 +++---
> =C2=A01 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
> index a81ce7a740b9..794d710c3ae0 100644
> --- a/fs/hfs/inode.c
> +++ b/fs/hfs/inode.c
> @@ -81,7 +81,7 @@ static bool hfs_release_folio(struct folio *folio,
> gfp_t mask)
> =C2=A0		tree =3D HFS_SB(sb)->cat_tree;
> =C2=A0		break;
> =C2=A0	default:
> -		BUG();
> +		pr_warn("unexpected inode %lu at %s()\n", inode-
> >i_ino, __func__);

I don't think that it makes sense to add the function name here. I
understand that you would like to be informative here. But, usually,
HFS code doesn't show the the function name in error messages.

By the way, why are you using pr_warn() but not pr_err()? Any
particular reason to use namely pr_warn()?

We had BUG() here before and, potentially, we could use pr_warn() +
dump_stack() to be really informative here.

> =C2=A0		return false;
> =C2=A0	}
> =C2=A0
> @@ -305,7 +305,7 @@ static int hfs_test_inode(struct inode *inode,
> void *data)
> =C2=A0	case HFS_CDR_FIL:
> =C2=A0		return inode->i_ino =3D=3D be32_to_cpu(rec->file.FlNum);
> =C2=A0	default:
> -		BUG();
> +		pr_warn("unexpected type %u at %s()\n", rec->type,
> __func__);

Ditto.

> =C2=A0		return 1;
> =C2=A0	}
> =C2=A0}
> @@ -441,7 +441,7 @@ int hfs_write_inode(struct inode *inode, struct
> writeback_control *wbc)
> =C2=A0			hfs_btree_write(HFS_SB(inode->i_sb)-
> >cat_tree);
> =C2=A0			return 0;
> =C2=A0		default:
> -			BUG();
> +			pr_warn("unexpected inode %lu at %s()\n",
> inode->i_ino, __func__);

Ditto.

Thanks,
Slava.

> =C2=A0			return -EIO;
> =C2=A0		}
> =C2=A0	}

