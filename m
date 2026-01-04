Return-Path: <linux-fsdevel+bounces-72355-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EF451CF0AE9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 04 Jan 2026 07:51:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB4F7301FC31
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Jan 2026 06:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694DC2E6CC5;
	Sun,  4 Jan 2026 06:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="OjPYTMch"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34901A9B46
	for <linux-fsdevel@vger.kernel.org>; Sun,  4 Jan 2026 06:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767509486; cv=none; b=qTzIBz24gxJGc3oDan8FNKptqkQyGhSrc4l0Vqm06pceUnJqYvIrp92X+5zEOAzh4JLH6uYbwTaHp7bLxJnZw8Lhcitbb8bM/JWNs+N1qJRHl5kfpywMEzKk9PYLQOjyF4fRikpBxXuok/ml8PwIM02f+NrBZBT/jwXPHEk2HVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767509486; c=relaxed/simple;
	bh=6zrvH/Y6xj4ImMc7hbH57hysfldTJmwwfrXUGUhRLhw=;
	h=Mime-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=A1+FkDlIdbriCKyaDGdcDJAhmrw2pbKaXjKW2Cfvb09ps2MuwUaHeoj0+LceoydaHqPt+ZfCtyZrzccAmjmVJAbS0jYKVmfoFS+ouUmv3h4l6WrSN+MP8OxmpItL06TlBXiOpgjqdCQyZb38D5iFeZu2RA1Cyp1C31neR4W6tuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=OjPYTMch; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2a0d0788adaso117865285ad.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 03 Jan 2026 22:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1767509483; x=1768114283; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6zrvH/Y6xj4ImMc7hbH57hysfldTJmwwfrXUGUhRLhw=;
        b=OjPYTMchVEL33uYhFsibtk4+fbIi40YvRzNPzcPsbR0/2JTnnYHeG0EmlWFpCEaVlq
         4FsIp0ETk9OUvDmnQ2syOaG77glJIMzCnuInun8kbs/fERo0GRX2XOXA5DEKxGooZAqD
         ybjoDapOBRXOs14Ch9DWD30wdxV4RTkDjaMK+eSruvHwQYL1TemrDPqq46ajl49xGfT0
         TnCPwEjfjw0ZNjiLFd6g18K71CWiJEiB5jLEsMbUU3x3k2LjrqbfkfMQEZB3nQT1FgDI
         w3RHafPorcsNLxnH16+mmsDjybMFC3O2rkTwPtbZLJ2R3HPuErq/2/Yvnit5mSJ88ULp
         TpLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767509483; x=1768114283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6zrvH/Y6xj4ImMc7hbH57hysfldTJmwwfrXUGUhRLhw=;
        b=oGaWpROPQIbSa2Va9FpxvOFDb+7m0rSIm2/+LKuN3HQ6oYrL46LmNTWFo8WShBMDJz
         b9l1F/5UVZRYVUVWBojfLSqnQzeah5h5tXR2WdSTcLVvtRCUHQa+08cR3gjaSuzbCoa0
         gqeNS8sBrcOaZyBgr/7nYX+tEun4gHG9Syq4Id+jsLSVMzASL3iLpwqPgo0Fwm8b4NC0
         hn/5umb3fHRN1zQQFkzwyYlpK3nZPY/AWmrPMCftUnzMq4GhB/yYUsgdMkFJrmE3aC1k
         fxEFgRDef65eejWhe7DsxKUiVEQcgYYXbaYtSIzWgEqXxGTpz+o3/mQUkmJKWW4tQrNZ
         Pt4A==
X-Gm-Message-State: AOJu0YyvZmdDN4iXZr0S1G4ZYrCQNP1dha1xeguqAFDVoZVr3uicMg7y
	3af6/XZYEO9NSeqHOqK8jaHQD5sM7/yeOC8TqDROxYbTiDTl8diTB9QWKV5ZUpOeuKFOoHHPwlv
	ywav0yPjCf96Q8tw1n5lHBbZ9yP7j1IK10kwGFjVC7g==
X-Gm-Gg: AY/fxX7GtjgiHWaeFXVNyrYejo/uuwaN2NAzGm6hIL4VfFJ3ilEAmlyWnHEDOcuO0al
	IbmXRJoTJeF5d6ZpUd3U9R56AfljcT7rWIKC480ZNY1lnxFw16Qu3b2XDWWWaE9u6o2rKUJAML0
	9eZn1mAX3Fb2LcP6we1j0JSJu3uoT3IP00J+60POdl8vCfdVeYacJYH/u8bI2uw+WR+9Hj4S8sY
	YQbaHAuuA93vWU6FpD9Hy5xbWmOUMpi35LlPW7+rVTbKxjccRRJrK/6sjThgffak/1d88E=
X-Google-Smtp-Source: AGHT+IHEAp/0Uc42kWijpM2HjcTQxPtxvKnhqNUvcFoStiKxYNNrELPPWVIjU/gLXl2Nucc8SX4ABd99S6P+454wyo0=
X-Received: by 2002:a17:903:3b8b:b0:2a0:b461:c883 with SMTP id
 d9443c01a7336-2a2f2a354ebmr444934985ad.45.1767509483005; Sat, 03 Jan 2026
 22:51:23 -0800 (PST)
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST;
 Sun, 4 Jan 2026 06:51:22 +0000
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST;
 Sun, 4 Jan 2026 06:51:22 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: Zhang Tianci <zhangtianci.1997@bytedance.com>
Date: Sun, 4 Jan 2026 06:51:22 +0000
X-Gm-Features: AQt7F2rLFSKIBx_vo7nV2oTn4tgI-gsnDi4JWnKTHuLFxCFiIik9i1XzBTLQYIc
Message-ID: <CAP4dvsfs55KqSNmdv_LM1_4moUUcVxvjCrj5zjGFxOH4mi8xOQ@mail.gmail.com>
Subject: [QUESTION] fuse: why invalidate all page cache in truncate()
To: miklos <miklos@szeredi.hu>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, =?UTF-8?B?6LCi5rC45ZCJ?= <xieyongji@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

We have recently encountered a case where aria2c adopts the following
IO pattern when downloading files(We enabled writeback_cache option):

It allocates file space via fallocate. If fallocate is not supported,
it will circularly write 256KB of zero-filled data to the file until it rea=
ches
an enough size, and then truncate the file to the desired size. Subsequentl=
y,
it fills non-zero data into the file through random writes.

This causes aria2c to run extremely slowly, which does not meet our
expectations,
because we have enabled writeback_cache, random writes should not be this s=
low.
After investigation, I found that a readpage operation is performed in ever=
y
write_begin callback. This is quite odd, as the file was just fully filled =
with
zeros via write operations; the file's page cache should all be uptodate,
so there is no need for a readpage. Upon further analysis, I discovered tha=
t the
root cause is that truncate has invalidated all the page cache.

I would like to know why the invalidation is performed. After checking the =
code
commit history, I found that this has been the implementation since FUSE ad=
ded
support for the writeback cache mode.

Therefore, I can only seek help from the community: What were the
considerations
behind this implementation, and can it be removed?

--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -2279,7 +2279,6 @@ int fuse_do_setattr(struct mnt_idmap *idmap,
struct dentry *dentry,
=C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0 if ((is_truncate || !is_wb) &&
=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 S_ISREG(inode->i_mode) && ol=
dsize !=3D outarg.attr.size) {
=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 truncate_pagec=
ache(inode, outarg.attr.size);
- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 invalidate_inode_pages2(=
mapping);
=C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0 }

=C2=A0=C2=A0 =C2=A0 =C2=A0=C2=A0 clear_bit(FUSE_I_SIZE_UNSTABLE, &fi->state=
);

Thanks,
Tianci

