Return-Path: <linux-fsdevel+bounces-73985-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6148ED27A10
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 19:36:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0BA9B306EB31
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 18:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C1DA3C0081;
	Thu, 15 Jan 2026 18:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JRqy9Oiq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5402D2491
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jan 2026 18:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768501070; cv=pass; b=RgE5HKfJvrTa2sKG38K1z8V1GZrM6qQjQSZsuzUl7ln193YaHf4t8q1JEayswEdo/CsMicZgGqED0qjeqdnmHOZtkXNz90yGdplSY2NCLg8QwUwUp8JpHl3SBkLHavYoSgqs6Ryx5opdfgQfkNqgfoglBqOerwyy5wIoYbUAuD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768501070; c=relaxed/simple;
	bh=lrPbqnzgCOvE5NgsFSOuHcaOEuIUQeGDqGbHFIodw8A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n2lwoU82V071XbC7vbtit8lye8o4ELPpNcWxh1CBkvSZO75elLWZ3qRMfwqSFCvgAFxj9Uan1TByqewt8VlAUFTdK99SaE9nD/iXLslg+t0UMLixNMOi9wL6kFURI3fQziVqmdgBBAxXDaOCeP02JKM+PPWKGaErvAKRm9hPU44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JRqy9Oiq; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-64ba9a00b5aso1741333a12.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jan 2026 10:17:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768501067; cv=none;
        d=google.com; s=arc-20240605;
        b=GUS6ratoq69hinaffpRXdQP2Mw9AY59p65sulYecHCIR1WnYbeTCU5CHtCbEhIfUKc
         XjVsbSWLIlDHT401YUTbeUjTBSKgX24xPHyB6050SDGDXTDZAsSN2VsKG+z5K9KtSQAh
         PydWXWSVNbZV3Ha/QA383xmXfZdh7nYMpNKBAaYCXGH1My9jjtYWpzSd1rpIGdz1kECq
         YoH9x1ER/gpUJZYdlYCOQ7UnkdIlPf097tKqxxQP1QfjoyVpspOBJqDIUHzcrQ7i0TAz
         K1uyVeP6gibETvQ8IJMCqExSNbJ0zh1wo8GpYyE+L2BRaitJJb0hEf2wne0JA2PCAaab
         LeWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lrPbqnzgCOvE5NgsFSOuHcaOEuIUQeGDqGbHFIodw8A=;
        fh=gloK9OBuFQXxWJhzvNAnYb1UhkjOdJ0GuzeGnUo3HwQ=;
        b=J8C5R8//bT6kLR+i3435N3fiyVClDZ94cIUzFm3TCf8COAsn30R4ynNEkWaO18h8Ef
         CxCeCCXBfJvKDyBA9TNDdCtpKKMSzyqr8k4Zjtj6zwMGTzp3zSR+sJSqxueJ6YaTIQEA
         QaKmwfBhzUfzC5nl/U0UyLJeGyCMLCKfnEEmuyt2C7ySRBd8HQjIC/4oGjKdLY/63EN8
         Mbz09oAQSOkgjJ5PQRf+zI16/GcccEUMclzmAAVHMhr3lwL5F6eJxnUgCmNQAl9JAnQr
         aQ7l8Bb2p/HmZPTV9TKgNu9fTWFL6tJXMH5EnwhW4CpqHZi1/O5Pq7iQWNphlAUnBRQR
         sSaQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768501067; x=1769105867; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lrPbqnzgCOvE5NgsFSOuHcaOEuIUQeGDqGbHFIodw8A=;
        b=JRqy9OiqbHt3NQq3XCkGStTAlcxglCMEMq+vkPdztBR4c+MkrffxyXlppZJ7bL4sv3
         +FXHo4WCeS6ifCEJXW+UdjZqdayxLi0mNMYJfj32IOulawR+3uE9C6Ut2x3X5eVTlY8+
         6iRo29sMNevgrrtfjtiRzEF0k4plHYlK2kgxZb4KZPdGjfbpVgT/wXn6hxIwTOtPADbq
         2v6VOk25RJEEoHnf4r5a+RfNediJCsI/4TTnPiMJgJQLHdyofqjBzPnr34u+fCoLT989
         FV5CVbIQ4AFknrnsxqTVaClS78Bq+9klbvidUC90tZ/EK9JmXeohHKVG3ipODkA8GlnY
         LSvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768501067; x=1769105867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lrPbqnzgCOvE5NgsFSOuHcaOEuIUQeGDqGbHFIodw8A=;
        b=hJDHnSW6Cyo5eTBFclu7w6JOBZ+bEfosRbHN9F6M+wNF5y6Nd3ir0ROQCtlCzlfaqE
         14iLWPtmA+SQGN1k/HnWkRg1FU6kR0jlcDsW1ZV0V6Zu5kWD8OI7ttZSnrejzFOC76ZZ
         8FTz4jaSpYXgaXczf6o/8to1H32uuG2RUCtmV40e7IMduuAb7rDufLiPVZtjWn5D2hjF
         0hvDWxtVEel9dCo6icHdUXPFY8lJGO3Y19YCYAYkVdyA5qpWm5bBeGrpWVpxbdlWJGjn
         Vb8eSFG9RBT/CZFwAtyTUwO/DL1/ncusTym36eVnOD+eydTdNftb+yqByOT3a2v3bDSn
         0jFw==
X-Forwarded-Encrypted: i=1; AJvYcCWUJUD3l2/YKgYG7EGFdP77zKYn6OsskhegYEdhlr/Cm9XSQi/K7R/qCXupob+jAxnzoeWMZajrIzOnMp+D@vger.kernel.org
X-Gm-Message-State: AOJu0YyK4hQTHcbZOml7pgVGOJQ8dRhorvwDP16KrhiLOnmov8BOSFtH
	yQIM+Kv7aSyDR0o62jWVBgzOrZ2hp5lDNo0Vnkec0rGPwZNanaCxbTsMgK4B41oCOZZo0smf74+
	u7YHHT2bH/S3vEwaTkSp2lyNK0ZxWmC4=
X-Gm-Gg: AY/fxX4/LAT4YYcxT4BlIMtAVeP+Olq28xv7+2Vgz0lw42aXG+8We36mpbQWQWmIoeb
	6/0svq2d3LWthIPScC/tanw4Zy0w3TLgbJSBhrTbjI9M1XnDCezDYiXmMCRq7PZW/nawJLi1neO
	ly6JrewoiNR9sJpAnMfj6gw++HJ202HFB71F2gaQufBlysw8OiI27LH4nl5slxbZaY4BXhIlO3q
	Z+i2wxCRRbfL4S/EStLgEkjWxuxmCuc29UN+xe9XWpgz/zh/rQrClBsigcvcnVpyIvBC2y72eFz
	lEbQDRYGxin/ZiQzchRN5Fv1UFoxpg==
X-Received: by 2002:a05:6402:510f:b0:64b:7eba:39ed with SMTP id
 4fb4d7f45d1cf-654525ccad4mr346097a12.13.1768501066374; Thu, 15 Jan 2026
 10:17:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115-exportfs-nfsd-v1-0-8e80160e3c0c@kernel.org>
In-Reply-To: <20260115-exportfs-nfsd-v1-0-8e80160e3c0c@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 15 Jan 2026 19:17:35 +0100
X-Gm-Features: AZwV_QjhT3ZtgvkbHJB7796GEklGCbcNDL5CeRwrn_YYeN3X8FqPO-3_iRnRORw
Message-ID: <CAOQ4uxjOJMwv_hRVTn3tJHDLMQHbeaCGsdLupiZYcwm7M2rm3g@mail.gmail.com>
Subject: Re: [PATCH 00/29] fs: require filesystems to explicitly opt-in to
 nfsd export support
To: Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	Hugh Dickins <hughd@google.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Andrew Morton <akpm@linux-foundation.org>, "Theodore Ts'o" <tytso@mit.edu>, 
	Andreas Dilger <adilger.kernel@dilger.ca>, Jan Kara <jack@suse.com>, Gao Xiang <xiang@kernel.org>, 
	Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>, 
	Jeffle Xu <jefflexu@linux.alibaba.com>, Sandeep Dhavale <dhavale@google.com>, 
	Hongbo Li <lihongbo22@huawei.com>, Chunhai Guo <guochunhai@vivo.com>, 
	Carlos Maiolino <cem@kernel.org>, Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
	Viacheslav Dubeyko <slava@dubeyko.com>, Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>, 
	Luis de Bethencourt <luisbg@kernel.org>, Salah Triki <salah.triki@gmail.com>, 
	Phillip Lougher <phillip@squashfs.org.uk>, Steve French <sfrench@samba.org>, 
	Paulo Alcantara <pc@manguebit.org>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
	Shyam Prasad N <sprasad@microsoft.com>, Bharath SM <bharathsm@microsoft.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Mike Marshall <hubcap@omnibond.com>, 
	Martin Brandenburg <martin@omnibond.com>, Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>, 
	Joseph Qi <joseph.qi@linux.alibaba.com>, 
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, 
	Ryusuke Konishi <konishi.ryusuke@gmail.com>, Trond Myklebust <trondmy@kernel.org>, 
	Anna Schumaker <anna@kernel.org>, Dave Kleikamp <shaggy@kernel.org>, 
	David Woodhouse <dwmw2@infradead.org>, Richard Weinberger <richard@nod.at>, Jan Kara <jack@suse.cz>, 
	Andreas Gruenbacher <agruenba@redhat.com>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, 
	Jaegeuk Kim <jaegeuk@kernel.org>, Christoph Hellwig <hch@infradead.org>, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-ext4@vger.kernel.org, linux-erofs@lists.ozlabs.org, 
	linux-xfs@vger.kernel.org, ceph-devel@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, linux-cifs@vger.kernel.org, 
	samba-technical@lists.samba.org, linux-unionfs@vger.kernel.org, 
	devel@lists.orangefs.org, ocfs2-devel@lists.linux.dev, ntfs3@lists.linux.dev, 
	linux-nilfs@vger.kernel.org, jfs-discussion@lists.sourceforge.net, 
	linux-mtd@lists.infradead.org, gfs2@lists.linux.dev, 
	linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 15, 2026 at 6:48=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> In recent years, a number of filesystems that can't present stable
> filehandles have grown struct export_operations. They've mostly done
> this for local use-cases (enabling open_by_handle_at() and the like).
> Unfortunately, having export_operations is generally sufficient to make
> a filesystem be considered exportable via nfsd, but that requires that
> the server present stable filehandles.

Where does the term "stable file handles" come from? and what does it mean?
Why not "persistent handles", which is described in NFS and SMB specs?

Not to mention that EXPORT_OP_PERSISTENT_HANDLES was Acked
by both Christoph and Christian:

https://lore.kernel.org/linux-fsdevel/20260115-rundgang-leihgabe-12018e93c0=
0c@brauner/

Am I missing anything?

Thanks,
Amir.

