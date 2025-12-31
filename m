Return-Path: <linux-fsdevel+bounces-72263-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CA8ECEB3D7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Dec 2025 05:48:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1481C300AFF6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Dec 2025 04:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3364A2F49EB;
	Wed, 31 Dec 2025 04:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="Vi6WhnPf";
	dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="LDduBncw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B08219E8;
	Wed, 31 Dec 2025 04:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.171.160.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767156509; cv=none; b=QrfjbO8aloJTytNykNiGnNJz1DLsmSycefWEScUveuf2K/c7TyzZ1ypdRiPd60MxN2i74NisQcxQ4anT6kd+VuTSjwGUWOkfBfOP7ZeTrbRwumIuB2dNz8PpedxMrdtAXFa9ZghfA2VNazchpwGQqVD0MjQiaOEQ9YxnqbiCJvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767156509; c=relaxed/simple;
	bh=Y5STvpbLFchDPxv5AKA6CA0YE5aPUZ9b41fJenXR/A4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OgCMtFBVq6pizIzaJr97buU2Rmf81FraknlaiREWKJuL5r6y/FA6G/UEIeIbXbXTgHyriHycBH2lFBtEUnjFnGuRkXaVjHrkoNNq7a9COEMHy6l94MX6jLSQYK1jehkRf904z/RsZrdxkcveGU1WF1SLSaVsueOGDji/zD5zIIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp; spf=pass smtp.mailfrom=parknet.co.jp; dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=Vi6WhnPf; dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=LDduBncw; arc=none smtp.client-ip=210.171.160.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id 5FD9526F7658;
	Wed, 31 Dec 2025 13:41:47 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114; t=1767156107;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GJg9D2/rQAcIczscJ6y9eKBgMTU7/0gQppNdTnS+N/A=;
	b=Vi6WhnPfpbTAdPOQSWwQrGenYQESGcwWr9wSe7LXBTrZ8FZ7pSC45FPqBojvbjR0TAr/8V
	tlrmswope0EO7nyGITwEIFosw7JSUuQqBxtmZAzdD+HxRPeDnnQd5omWQqf2CVvZj/ECDa
	shpBuKU050V0R9a9L+sSk+wR1cuoukWn2khMDYnfShlq3MijpRq4qDplioO5GO1fPAHQ9O
	momwPdSFIcCNEsQCrcwD0WB2kRXU7037ctp9dyeFtvFrBG608oGcAEbwhPHK6U17qJJFhb
	RnBFVNGYIQCT4p7UNB8l7PCLkFJatp4xWYhg/Ag76mZJ97LHNjnvbS1tMZaF6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114-ed25519; t=1767156107;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GJg9D2/rQAcIczscJ6y9eKBgMTU7/0gQppNdTnS+N/A=;
	b=LDduBncw9gEdm7YZj8at9UxlA5yPFTQ2Cveqe8LBtMVRYYCKEzjrOTcCR3ZIJMjzR3UCjc
	AS1DvFML97z027Bw==
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (8.18.1/8.18.1/Debian-7) with ESMTPS id 5BV4fjV0267935
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 31 Dec 2025 13:41:46 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
	by devron.myhome.or.jp (8.18.1/8.18.1/Debian-7) with ESMTPS id 5BV4fj24637326
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 31 Dec 2025 13:41:45 +0900
Received: (from hirofumi@localhost)
	by devron.myhome.or.jp (8.18.1/8.18.1/Submit) id 5BV4fjl5637325;
	Wed, 31 Dec 2025 13:41:45 +0900
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: Zhiyu Zhang <zhiyuzhang999@gmail.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, syzkaller <syzkaller@googlegroups.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [Kernel Bug] WARNING in vfat_rmdir
In-Reply-To: <CALf2hKsMc3o+mYg2xwNEFO+q2Z=XteOmCjd1=EHOR0Na3=201Q@mail.gmail.com>
References: <CALf2hKtp5SQCAzjkY8UvKU6Qqq4Qt=ZSjN18WK_BU==v4JOLuA@mail.gmail.com>
	<CALf2hKsMc3o+mYg2xwNEFO+q2Z=XteOmCjd1=EHOR0Na3=201Q@mail.gmail.com>
Date: Wed, 31 Dec 2025 13:41:44 +0900
Message-ID: <87ms2zgt4n.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Zhiyu Zhang <zhiyuzhang999@gmail.com> writes:

> Dear Linux kernel developers and maintainers,
>
> I=E2=80=99m sorry =E2=80=94 the root cause analysis in my previous report=
 was likely
> incorrect, and the patch I suggested there does not alleviate the
> issue after further testing, which means that the root cause is not on
> the errno passing.
>
> After adding debug prints in fat__get_entry(), I observed frequent
> cases of err=3D0, phys=3D0 at pos =3D=3D i_size, which means the code is
> taking a "normal EOF" path (as decided by fat_bmap()) rather than
> hitting and swallowing a negative errno. As a result,
> fat_get_short_entry() still returns -ENOENT, fat_dir_empty() still
> returns 0, and the code path does not prevent drop_nlink(dir) from
> being executed even when the parent directory's i_nlink is already
> abnormal. In other words, the parent directory's i_nlink appears to be
> wrong/corrupted in the first place. Subsequent vfat_rmdir() calls then
> decrement the already-too-low link count, eventually reaching 0 and
> triggering WARN_ON(inode->i_nlink =3D=3D 0) in drop_nlink() (and panicking
> if panic_on_warn is enabled).
>
> So please IGNORE my previous patch proposal. A conservative mitigation
> that I tested EFFECTIVE is similar to the UDF fix for corrupted parent
> link count handling (Jan Kara's WARNING in udf_rmdir fix:
> "https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commi=
t/?id=3Dc5566903af56dd1abb092f18dcb0c770d6cd8dcb").

It can occur on a corrupted image that didn't correctly initialized as a
directory.

> static int vfat_rmdir(struct inode *dir, struct dentry *dentry)
>         err =3D fat_remove_entries(dir, &sinfo);  /* and releases bh */
>         if (err)
>                 goto out;
> -       drop_nlink(dir);
> +       if (dir->i_nlink >=3D 3)
> +               drop_nlink(dir);
> +       else
> +               fat_fs_error_ratelimit(sb, "parent dir link count too
> low (%u)\n",
> +                       dir->i_nlink);

Looks good sanity check. However, I think it doesn't need
_ratelimit. And this should be done in msdos_namei.c too.

And fat_fs_error() should remove last "\n", and please add {} for 2
lines code (it is not necessary as c though, sorry for kind of my
preference), also looks like no "sb" here, need testing before actually
submitting the patch.

	else {
		fat_fs_error(sb, "parent dir link count too low (%u)",
			     dir->i_nlink);
	}

Thanks.

>         clear_nlink(inode);
>         fat_truncate_time(inode, NULL, S_ATIME|S_MTIME);
--=20
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

