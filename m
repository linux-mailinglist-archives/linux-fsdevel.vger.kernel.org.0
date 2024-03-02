Return-Path: <linux-fsdevel+bounces-13351-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6DF386EF2F
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Mar 2024 08:43:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EAD828341B
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Mar 2024 07:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A6D14298;
	Sat,  2 Mar 2024 07:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T6o04TDQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54BA313FF1;
	Sat,  2 Mar 2024 07:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709365352; cv=none; b=kCBqBlLHI4JChR8JiGHAx8ycZcUoDqbAUVnpGd2OxCnfcGGJ28gjXJfJLV/M2qPWBrwzlqphIs85IUelWCkxb0Tantyl8S/f5B5feLuojPTMGWo17eydBbeTHgUHJLBTc3LzDe+0TOKJSYkRU7VjLsXIAYEnTdh2dSkRxR/S29Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709365352; c=relaxed/simple;
	bh=Lxf86wsgMeVIjl0s92RhlwZEQt9iGDE8hAGXnMOeIA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q83OcIPnqGv/InsR75FQx5S0Cd+7i96QrYaqKdROUJx0DVtdaH04rPO8B7TeONE1NLn49RvP9KHUOV3quljhTAuf932BRFb0FUKpyTGcf2MQ5+LI82RCuqFgVBPayP63hSmKDs3+mNUNd/W/LA8KUAcb6ALTyu5CtavUR0y6iNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T6o04TDQ; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-214def5da12so1575020fac.2;
        Fri, 01 Mar 2024 23:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709365349; x=1709970149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oUtRlA4LTpnrKeik+etCM2Hf0A7iESJvM3SgKuLTazM=;
        b=T6o04TDQfLvmXf/8g0jijtB7KlwW3OmkCac/MdAoxuqnRgKVnq43r9+hbyVrcpvMkz
         mJjdp1jzYGwCW4YHjtl+grWJyM2Tf1VsnOA8G7RksT879D+xaB56m0iNhitvZYH4xPTf
         mCOcobto02pHFdOs6kxqDE0P5GielGFJDxD2qaj715ToBF/bBBJtZUemG47V4gxlzE8b
         HaQ2VgNK40TvD42gfbjfAgv0C9cVlBeX2SpJQtWlu9GCPVwluAUeyubwLei/jWzt7E22
         dHSUu6T6e0tDKc/YT8Rli781UFKcodUtx5F9YKc1fYBmtGtXoQJ+UlFfhwRFSAehpgAA
         Cxcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709365349; x=1709970149;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oUtRlA4LTpnrKeik+etCM2Hf0A7iESJvM3SgKuLTazM=;
        b=amnoNPFnEQYafUQTRb1rJLnaI3ubzsp9PjCdC31SMr022GBkEhS8IWOPgsTwcCLZNk
         MVTeKlDRiShv7tv9oU9i1Y4+knWUX/0tvpo/V3JtKBw34VMMyMJyvQri6krlUEU38a7U
         cpm6F0zuDjFDvv+/Hd5ng6HiywUdX+Qnzy1ckwuuuZ/xpcHfZdgD3kiPq6EOylmbhMSu
         seOwSg4z7JOLcSAU0PzUPcR7aOKXuj/ppgU6nG3rmuErhMuD1ZsXgmvtfBnv2cJN7CSX
         OM9PUleYO2+iH4hGvQJes9secC1taqbjOsX/NCgfJ76Vy65UwQ+EPytKVCa+k3two9a0
         SwRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCRWb6S2mgBYzYKx7RB/RleTs7eFC0iM+OOtXB9J7EXmT5d5pUTzoN+4qBeEEwJhcUsEAKSVCuygS6aerwB4i1m2gB4eI4rcSu3o+Uow7PzgAki23Vx1NwRtCBMDROtitRNDe7TrUhPw==
X-Gm-Message-State: AOJu0YzyVmsjBpj1lXvC0Ki8IC0QEfoRu2cYsB/zMyEkjiXivb4cP72+
	927ykD+sCoiaHSN8EuPYlyLhw3L33Pga0jjU9RqkfCbNn3B/xYTdy6ve/6Ss
X-Google-Smtp-Source: AGHT+IFLWQMIWT3GGADxP32VJxgTJ7bnzRo5oiL+zKPMncJknrpocXur9iaOqh9flLW96BfDePoPcA==
X-Received: by 2002:a05:6870:230b:b0:21e:d763:f5f1 with SMTP id w11-20020a056870230b00b0021ed763f5f1mr4114232oao.42.1709365348656;
        Fri, 01 Mar 2024 23:42:28 -0800 (PST)
Received: from dw-tp.. ([49.205.218.89])
        by smtp.gmail.com with ESMTPSA id x11-20020aa784cb000000b006e45c5d7720sm4138206pfn.93.2024.03.01.23.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 23:42:28 -0800 (PST)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org
Cc: Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Jan Kara <jack@suse.cz>,
	Theodore Ts'o <tytso@mit.edu>,
	Matthew Wilcox <willy@infradead.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	John Garry <john.g.garry@oracle.com>,
	linux-kernel@vger.kernel.org,
	Ritesh Harjani <ritesh.list@gmail.com>
Subject: [RFC 1/8] fs: Add FS_XFLAG_ATOMICWRITES flag
Date: Sat,  2 Mar 2024 13:11:58 +0530
Message-ID: <555cc3e262efa77ee5648196362f415a1efc018d.1709361537.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1709356594.git.ritesh.list@gmail.com>
References: <cover.1709356594.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: John Garry <john.g.garry@oracle.com>

Add a flag indicating that a regular file is enabled for atomic writes.

Signed-off-by: John Garry <john.g.garry@oracle.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 include/uapi/linux/fs.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index a0975ae81e64..b5b4e1db9576 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -140,6 +140,7 @@ struct fsxattr {
 #define FS_XFLAG_FILESTREAM	0x00004000	/* use filestream allocator */
 #define FS_XFLAG_DAX		0x00008000	/* use DAX for IO */
 #define FS_XFLAG_COWEXTSIZE	0x00010000	/* CoW extent size allocator hint */
+#define FS_XFLAG_ATOMICWRITES	0x00020000	/* atomic writes enabled */
 #define FS_XFLAG_HASATTR	0x80000000	/* no DIFLAG for this	*/
 
 /* the read-only stuff doesn't really belong here, but any other place is
-- 
2.43.0


