Return-Path: <linux-fsdevel+bounces-73260-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9943D13672
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 16:02:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4CE4430CB480
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 14:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F3732DC355;
	Mon, 12 Jan 2026 14:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z3UfTrqp";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="BPXjEGyO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728F22DAFAF
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jan 2026 14:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768229526; cv=none; b=DQ3TyXmGTd27D/pDXF004xx0W5k9U+famzrATP1m6HzUx2Y04ql5DCpn24/cUSyL4uLayxwrAZQY39alTSwVLz4j2n8rx/eHWmkeEh3c+PW94cicpxKL574eWHCdH4CurqgIpyUH5oBYvxsgWmDMXqhNB2uPEdX2vWUSdKhn3z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768229526; c=relaxed/simple;
	bh=w1I6PwvwzLsgyGpHJFKwtxkJvjQ0CES+ZFjhSTB9vDs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WLlOZRHXwEsfSfI4zOV3CKCIgOgLbaivje5RfoW1E+LFwpj9HlTWzC9kqvFqlpiHhJLPJzmkmnP7ymaTQrSldlMh55enEWju4o34j35Hi6eDvX20yW89wOsBRFuwr4mLS7+o7x6ppzwZPph0stLs3H4HCqn6TsS8uJYRyMAd7mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z3UfTrqp; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=BPXjEGyO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768229524;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rxT4TpIEnXfcR0i9Em+M35vPC8aSThrR47NkUhIyHDQ=;
	b=Z3UfTrqp0jMnxkDdJ+Db83221ON7daj5LopjQF+N3fCse9xIjkd/co+SUQbSon5YAbYkEj
	V39TkALSGg/3DauTjMgmaKNp29cIDw4rtBzjdcQGgyw9BKsXhUqNzD442wGSIokLXTi3vt
	/s63Cug4rCtrC6XyYA1wq2e1h+pNlFs=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-154-JX9tXYrHN7u5-Yy8BGOZRg-1; Mon, 12 Jan 2026 09:52:03 -0500
X-MC-Unique: JX9tXYrHN7u5-Yy8BGOZRg-1
X-Mimecast-MFC-AGG-ID: JX9tXYrHN7u5-Yy8BGOZRg_1768229522
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-64d589a5799so10477391a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jan 2026 06:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768229522; x=1768834322; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rxT4TpIEnXfcR0i9Em+M35vPC8aSThrR47NkUhIyHDQ=;
        b=BPXjEGyOgKjPUJJC2ZjtLpTvVAbHQf75kSpUnfCI25pSlE+Up/dP1i4a/PRRoRL70I
         tdFpU2sagKQI5fnCG2SQXA5d0RBSlkZ60JkerwyX6lBUhFIKKbv6WlAvNtCsk/MJPSab
         eu5plH71VivZkancdPOjCZNeGtWHco+OGoCJNK5WIZj6EQhU+9LfZ/17P9Q0uSh8Q63j
         bydlkXv2VKCohWodIM1CakCqFdThAMyRGDr9xepwbbcRnTU+U6rYtcTgl/a1yjL8Cxt0
         s1UJut0ueJxN6aayohDTZyEw9Bk431eGnt0nJYgiiN+NuDGW7uffGETQGHPaYgbvjaOS
         R9Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768229522; x=1768834322;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rxT4TpIEnXfcR0i9Em+M35vPC8aSThrR47NkUhIyHDQ=;
        b=LqZ7LdsXh6IGlTsQvlDOqWNbKKtVk91U8p68Rn0WdXIYMUA/O+yeprqiDYzHvlwepp
         4RsWYV8qC5MymzjsDkxSMxvUVxUpOvoJBPZ2x9DNpk24XySlcMEIGEplGIsSEpRsl7la
         Xby3vchyKr+dZQZ/rI/59i/WlYla2WYyBX7GQNl+MRVG4xtT162eG5xpxj5C9nPzoULR
         dY8QgiM/EQ6VuFRQCO7zMFg/H5LaVKkS20u0gGJOvcum0inuVQFDlXDVpMqmxdtQRMs/
         J6tRSuyKbosdD9sDdIdwjrkSkHVGNQ3nOBmGAqcSBWDk8qxlJSehtqz0E1xLHd2lJj0Q
         PfJw==
X-Forwarded-Encrypted: i=1; AJvYcCXWOsjMm/4MTIwt8XqrFXRin3JlZU8g+44DjBIhj3kerStlxio8BUwV3jak46NiwldAftHI3QONBAik+4hM@vger.kernel.org
X-Gm-Message-State: AOJu0YwMc2vojtCx1/x2r2I64wU/kSCH7cH7Wo4YJdG8QKEClbDu6viy
	kWPd4WsJ6MChT2VYy2IzBIdhHLes19d6ejm0CqS07b1i2MAAd5+mnI6dk7EMNwsCzDjtadD/JZp
	RrdKipg/ASD+rdYPS5q2qPnATYoytK7nKVX/qXUpbXBFkvz5FbFsT970RMbiFcuwgaQ==
X-Gm-Gg: AY/fxX7dWyOGcQXUQqGTSwmY9ZMWq9JapQS/OZTfktNLoOrPcVlJHf4SqVCRm+avx35
	sqyGAyxXTNLnKCeu6dXuMYKQZsa6o3U738KDE9qrd5oQtnoFxg3ZS0YBiegfhCGNBHy2bFc79bN
	lEUKckMXP3uyhY/VN902EPUSNmljQ72CaNAZfLqa/AEKIBegyjpsb0eW8z2djZaSXFs6zG/ELmg
	te1QNe1jvUzR3GguiM7KUzaD01iQQtKLbxdzHvLRB+Qv7v3ObspxBnmWu1UXmO8CwoPL4m6R0Dq
	ioSxwqazzGOljRm3sX+HLyVi7bL0gewvHp3tVlGRyK0cUxO0ZyQbkm7wrWAWlZozbSjiKm6U
X-Received: by 2002:a05:6402:4309:b0:64d:65d:2315 with SMTP id 4fb4d7f45d1cf-65097e8e3b3mr17114484a12.30.1768229522149;
        Mon, 12 Jan 2026 06:52:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF5HedpXYEVDgdb3na03m1dE9g5d9SGRCXlO36Bm8gCzP1H5KKM5v9HNGEWEFxIDCR45EpR/w==
X-Received: by 2002:a05:6402:4309:b0:64d:65d:2315 with SMTP id 4fb4d7f45d1cf-65097e8e3b3mr17114452a12.30.1768229521690;
        Mon, 12 Jan 2026 06:52:01 -0800 (PST)
Received: from thinky ([217.30.74.39])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507b8c4048sm18254819a12.2.2026.01.12.06.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 06:52:01 -0800 (PST)
From: "Darrick J. Wong" <aalbersh@redhat.com>
X-Google-Original-From: "Darrick J. Wong" <djwong@kernel.org>
Date: Mon, 12 Jan 2026 15:52:00 +0100
To: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org, 
	ebiggers@kernel.org, linux-fsdevel@vger.kernel.org, aalbersh@kernel.org, 
	aalbersh@redhat.com, djwong@kernel.org
Cc: djwong@kernel.org, david@fromorbit.com, hch@lst.de
Subject: [PATCH v2 18/22] xfs: advertise fs-verity being available on
 filesystem
Message-ID: <n54xljh4z2vdvxsifux2hue2hnjixlw6jtq3azudreah3lt4de@en2vz44o4vz7>
References: <cover.1768229271.patch-series@thinky>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1768229271.patch-series@thinky>

Advertise that this filesystem supports fsverity.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Andrey Albershteyn <aalbersh@redhat.com>
Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 fs/xfs/libxfs/xfs_fs.h | 1 +
 fs/xfs/libxfs/xfs_sb.c | 2 ++
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_fs.h b/fs/xfs/libxfs/xfs_fs.h
index b73458a7c2..3db9beb579 100644
--- a/fs/xfs/libxfs/xfs_fs.h
+++ b/fs/xfs/libxfs/xfs_fs.h
@@ -250,6 +250,7 @@
 #define XFS_FSOP_GEOM_FLAGS_PARENT	(1 << 25) /* linux parent pointers */
 #define XFS_FSOP_GEOM_FLAGS_METADIR	(1 << 26) /* metadata directories */
 #define XFS_FSOP_GEOM_FLAGS_ZONED	(1 << 27) /* zoned rt device */
+#define XFS_FSOP_GEOM_FLAGS_VERITY	(1 << 28) /* fs-verity */
 
 /*
  * Minimum and maximum sizes need for growth checks.
diff --git a/fs/xfs/libxfs/xfs_sb.c b/fs/xfs/libxfs/xfs_sb.c
index 744bd8480b..fe400bffa5 100644
--- a/fs/xfs/libxfs/xfs_sb.c
+++ b/fs/xfs/libxfs/xfs_sb.c
@@ -1587,6 +1587,8 @@
 		geo->flags |= XFS_FSOP_GEOM_FLAGS_METADIR;
 	if (xfs_has_zoned(mp))
 		geo->flags |= XFS_FSOP_GEOM_FLAGS_ZONED;
+	if (xfs_has_verity(mp))
+		geo->flags |= XFS_FSOP_GEOM_FLAGS_VERITY;
 	geo->rtsectsize = sbp->sb_blocksize;
 	geo->dirblocksize = xfs_dir2_dirblock_bytes(sbp);
 

-- 
- Andrey


