Return-Path: <linux-fsdevel+bounces-39766-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B3DA17CAA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2025 12:08:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C178216216D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2025 11:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8471F1529;
	Tue, 21 Jan 2025 11:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XZMgOZXC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF2A1B4137;
	Tue, 21 Jan 2025 11:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737457707; cv=none; b=WyomTprp1uEbDtIpkB3jvCbg5ktuCYXZDUZBVElpAkElrUmmocU4991y5j4IpFY3hTHy0qtP7EnOMHBL6zAe/R2lwcJzc545asxv2Jhypott9Hmf++UDsO8wceQQ2/unfQKUQVFypcXHwbDnmBVmkUVqGPR2rff3Yiuf0G5whY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737457707; c=relaxed/simple;
	bh=IqNdaLNbz0YEh4i8b5tfBkuxskzb1iUgZOIQzKFIm9k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gvFUHFmOKtFl0sbMRvpPY9/GYV2dWTUrfcKp54CbbaUMehIH5m4vrStZNaVY4omuYgYjwvJXxvpgnJ1NbSuB0eEuysjHc9Vg1lvu4KoV0Kpfpt6eeawsv1ABeIHCtsvhqcpg5ritlkmxVCUmUVsXWcfI+u0BH16oafwMnzm8u5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XZMgOZXC; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5d7e3f1fdafso11066533a12.0;
        Tue, 21 Jan 2025 03:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737457704; x=1738062504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yxwX7BPSuszkHp6D+XbucJtCVXIOlfH3y1QCR8ZPf3w=;
        b=XZMgOZXC3OPRN+KjjCCobL47EVW3gG3c+PC5/cStPLlX9Bzg6POqwNCid4JDV4URu2
         bnjnQEenZCwfOuCglhulTJHvfSrjQolLgMzjHPAWega0/2tqEulbUwzc+atdK2KS+j5w
         1lg+5OXHEmYZWSPzoXtb0KhKL2rUO0VyPJnC45/kE4X2yeMwf6EvfVjF6QOyO5KM+qMb
         ZmXt8mdQQXbY1sTc6BR/y2d2JTOyc2MpZZD+YSflQ4y3fI4+mSSmzQCTl+WYo1S/S2iQ
         ZoTLJ+6aXqR5sAdE3FMCONyENW7KonZBIlCn/11/XmM8BFCQlAt3p+DAMrFqmiNFHrBa
         4uzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737457704; x=1738062504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yxwX7BPSuszkHp6D+XbucJtCVXIOlfH3y1QCR8ZPf3w=;
        b=tRx1+gjnsVxlpf1SfB64Ei48AkVzwHX91k43YPBaJhhpDiftYZxnIEtvH0sZinOVoC
         +3hOw+P4VD5UDv7eSzAh9gSv+Z+zfIaifZyCIN2argFaYcnyzlv1pkIOpbP2lsd94lNv
         xl7YQ3wykQp3D1/sZDgposIDNz+HuZVyNbz/Sby7exN8oVPyrtyBDh0s4fcqQ2Cbn862
         QZsLT6WVy27zybBWYPv8LMsbbiOv19B0T9PTPbL1mgc22VKDYx0dFY+8uMlUqoT2phkT
         7M2z1r06jfCL1XDKQNZ9Xpxm3NULh86Yg8JZtpzceqjonDyf0VFDAShMNLCDls7vrzaV
         DUHw==
X-Forwarded-Encrypted: i=1; AJvYcCUjarzu9pCeM3C3yTtHDzdtTIwkefMCEfp+CIRa2zon3iQ8pGAVGt4dk+L9o6PQkdlpkVuFGiPx@vger.kernel.org, AJvYcCUrqJJ5jAB1ECmpMZ72Mwd/vCMizW4i7PMBFml2SAY61efUz6xNqlHxcd3OPeeNpq/IMkCeaYpZsMy5AVaMQA==@vger.kernel.org, AJvYcCWwvN9i5WPkP7sQLIzTJ51WxXsYcMuOG22UWCVykmqmOv/59GotVMIGz4HmqD8Wh7+4G2aKy3AzP5gW85cl@vger.kernel.org
X-Gm-Message-State: AOJu0YzkTOsZi4wd13PuWNOFCnVt3yOHBHR8W2tipIROJ6S6DKh/Fuws
	Iy+lUD414IDulhCu9I0We23XOYrmfp927fMXmPAhhvlE8YiddHBu
X-Gm-Gg: ASbGncvcWDL2Pl/J+Qa0iRkNd6tftyngk1EmK7eHmne99CHsvg0Jj23Qi+Q+pSA1NtP
	nh+tTSqizVqG0QlZOcVUmfSXW7slhBALaArLMCRi91YwOuAGdtUPMo+kea4CuvSgFkwjaKyPcSW
	n/f/T1voR2yo5QznCphDnUp2VgYHtjJQuJ5S5lRaP0NXkQpsd/ES288R8UQVKb7zzYjAYqwNZUG
	zhtDfl/9SogyXZmCimkVCgDW2PbYLGNmalT7NSZ1m6GYu6LoqUAsM+ypx390GT4F7Jm/SpQHiiS
	mtr46n5b48k10UiysSb+WFqA7kkArYdXwZTJfWNvXxMHfiZfV6q3dNzV0aOeHMoFqRI=
X-Google-Smtp-Source: AGHT+IELsrdB1CQN2m+UnzgVC3Or0p2Dl8YBuYBjUSRZHoUx5TfI+wBdi58JW2SBSytuw2XO1WdB2Q==
X-Received: by 2002:a05:6402:2792:b0:5da:105b:86c2 with SMTP id 4fb4d7f45d1cf-5db7db078b7mr13315810a12.20.1737457703905;
        Tue, 21 Jan 2025 03:08:23 -0800 (PST)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5db73683d28sm7209841a12.40.2025.01.21.03.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 03:08:23 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Jan Kara <jack@suse.cz>,
	Dmitry Safonov <dima@arista.com>,
	Ignat Korchagin <ignat@cloudflare.com>,
	linux-fsdevel@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+ec07f6f5ce62b858579f@syzkaller.appspotmail.com,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH 6.6 3/3] fs: relax assertions on failure to encode file handles
Date: Tue, 21 Jan 2025 12:08:15 +0100
Message-Id: <20250121110815.416785-4-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250121110815.416785-1-amir73il@gmail.com>
References: <20250121110815.416785-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 974e3fe0ac61de85015bbe5a4990cf4127b304b2 upstream.

Encoding file handles is usually performed by a filesystem >encode_fh()
method that may fail for various reasons.

The legacy users of exportfs_encode_fh(), namely, nfsd and
name_to_handle_at(2) syscall are ready to cope with the possibility
of failure to encode a file handle.

There are a few other users of exportfs_encode_{fh,fid}() that
currently have a WARN_ON() assertion when ->encode_fh() fails.
Relax those assertions because they are wrong.

The second linked bug report states commit 16aac5ad1fa9 ("ovl: support
encoding non-decodable file handles") in v6.6 as the regressing commit,
but this is not accurate.

The aforementioned commit only increases the chances of the assertion
and allows triggering the assertion with the reproducer using overlayfs,
inotify and drop_caches.

Triggering this assertion was always possible with other filesystems and
other reasons of ->encode_fh() failures and more particularly, it was
also possible with the exact same reproducer using overlayfs that is
mounted with options index=on,nfs_export=on also on kernels < v6.6.
Therefore, I am not listing the aforementioned commit as a Fixes commit.

Backport hint: this patch will have a trivial conflict applying to
v6.6.y, and other trivial conflicts applying to stable kernels < v6.6.

Reported-by: syzbot+ec07f6f5ce62b858579f@syzkaller.appspotmail.com
Tested-by: syzbot+ec07f6f5ce62b858579f@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-unionfs/671fd40c.050a0220.4735a.024f.GAE@google.com/
Reported-by: Dmitry Safonov <dima@arista.com>
Closes: https://lore.kernel.org/linux-fsdevel/CAGrbwDTLt6drB9eaUagnQVgdPBmhLfqqxAf3F+Juqy_o6oP8uw@mail.gmail.com/
Cc: stable@vger.kernel.org
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Link: https://lore.kernel.org/r/20241219115301.465396-1-amir73il@gmail.com
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fdinfo.c     | 4 +---
 fs/overlayfs/copy_up.c | 5 ++---
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/notify/fdinfo.c b/fs/notify/fdinfo.c
index 5c430736ec12c..26655572975d3 100644
--- a/fs/notify/fdinfo.c
+++ b/fs/notify/fdinfo.c
@@ -51,10 +51,8 @@ static void show_mark_fhandle(struct seq_file *m, struct inode *inode)
 	size = f.handle.handle_bytes >> 2;
 
 	ret = exportfs_encode_fid(inode, (struct fid *)f.handle.f_handle, &size);
-	if ((ret == FILEID_INVALID) || (ret < 0)) {
-		WARN_ONCE(1, "Can't encode file handler for inotify: %d\n", ret);
+	if ((ret == FILEID_INVALID) || (ret < 0))
 		return;
-	}
 
 	f.handle.handle_type = ret;
 	f.handle.handle_bytes = size * sizeof(u32);
diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index e97bcf15c689c..18e018cb18117 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -399,9 +399,8 @@ struct ovl_fh *ovl_encode_real_fh(struct ovl_fs *ofs, struct inode *realinode,
 	buflen = (dwords << 2);
 
 	err = -EIO;
-	if (WARN_ON(fh_type < 0) ||
-	    WARN_ON(buflen > MAX_HANDLE_SZ) ||
-	    WARN_ON(fh_type == FILEID_INVALID))
+	if (fh_type < 0 || fh_type == FILEID_INVALID ||
+	    WARN_ON(buflen > MAX_HANDLE_SZ))
 		goto out_err;
 
 	fh->fb.version = OVL_FH_VERSION;
-- 
2.34.1


