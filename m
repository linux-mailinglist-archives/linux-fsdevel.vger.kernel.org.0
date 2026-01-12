Return-Path: <linux-fsdevel+bounces-73251-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 908C6D1364B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 16:01:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BDA8B30E0870
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 14:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A407C2DCC03;
	Mon, 12 Jan 2026 14:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UuFizG2l";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="gjJz467o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3E62BEFFB
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jan 2026 14:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768229462; cv=none; b=ShRMKAGyifHip3wTPDU8Xuwyf7wT03uTdlaElezZ+mGry2/CFPVWiI+nQe4gpWGSmZT+R0NK25Dv7vlGuEn+EOJCvFFGRtACEUdzduVeY8a/yOPwtrr1VJ2k2XF4uKZ9/18aqDxC6hqVaiLlP3Xj5FHMACQ4VM7/6EIrK5bZ2Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768229462; c=relaxed/simple;
	bh=yWqqnqyEHVCP+GfyyAPeDyvO4XQXeMSaifR3DHZygFE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nU7pWGHv2HGi8NF30tIALv1bJ20RfEk1hEd8G5QteGv/6kwIUzLJxZlfXeME4ttJf+hjpEhpiBfmRALWE0cZyTdYCZ1IAiUhgFi2o5v+R5fHW7RN6VX+nv8xKIC2nSfRnd3r7a39eEq9jKoRjWHsw+OfqYockvhZri8uqGXj6VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UuFizG2l; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=gjJz467o; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768229459;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/8i7Y45C1rUzQ3Pho8pbs3bPeHebh5bCEthructqQBM=;
	b=UuFizG2liKAwtcoRKFJcQmf9YljXtGliMPwzgFH1XDJQmq7AmnA0MOHRavd8u0+BL13EvW
	3ABfRqDl4MDVsuupYG6yTZRBuYouGrIVxHjX4OOCjPH8ceWcZMacgJ7y8MFXH8dQpwH1GV
	x6pSudu6Xu1q7CZo1ZE0k0mnqgQRKco=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-333-t4lymYaBNqCouT1S2yg6UA-1; Mon, 12 Jan 2026 09:50:58 -0500
X-MC-Unique: t4lymYaBNqCouT1S2yg6UA-1
X-Mimecast-MFC-AGG-ID: t4lymYaBNqCouT1S2yg6UA_1768229457
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b87039c9a43so170482366b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jan 2026 06:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768229457; x=1768834257; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/8i7Y45C1rUzQ3Pho8pbs3bPeHebh5bCEthructqQBM=;
        b=gjJz467o2d8UVIDzTO8S5XPRDsfVma3/btziW/pPyfeyg0nhLC9iHp72zl+qhfteUB
         s45oqKDAyLRCusH5EmufM/XT1OACypMgt9ID4OhmIdV7b+Fk2zokVPKmAJvBMzRnokK+
         dG+GlayberxQdKP6lAhmPaMSEyCslr3huVgCQXKxc05Y/PAG0M1PLvBs16oKQmbICwrM
         e1esg9d+YGRtnm22osmVTHPA82HEV2CuZKcaNYwwualhm5At0+2BrrqnC2TgicDRB0tP
         5uKrnYOqkmptqTd+b/0OO7MZTQ5RGMTjsi1BbhutrriJVMAiRaynxhuflp2CC7hPhTEn
         NXKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768229457; x=1768834257;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/8i7Y45C1rUzQ3Pho8pbs3bPeHebh5bCEthructqQBM=;
        b=cNufx7XwCrV9e4y8ruzXeuNlB6nURt3PPXPLNqt6J8U2rgSLctWVDmk0nDwYIGm6oQ
         907trEl5LPD79z/NOBltPw0ZJMBhCrsi8JHRAcIuU66v40XvMIzs4hYoVlcT48AYnnPc
         irJcSs2JFxIxCVug7lakH5dbEnD2Yu/X/hVSOmUWHtgv1tapEsMZYWHgR3etWutROnq1
         es1YkzksSxOqP1f5ebQJ/1OTV0QwhpGsCkU8UnXexQR7lONW6JoK9ogCKm/UQZjfbGh+
         G8wubrn/kes0M/itmCCyzz/Aoq68N6vaU2M8hDu5HZFTDlq6txdEdEY+DhwahBFHxuB3
         dzSg==
X-Forwarded-Encrypted: i=1; AJvYcCWmqkfxh4o0I9FT6359KRbJ+vYWPGwA7G5DZQ7h9RgcsbFMqv9iqSH24RdkcNYnj65BuwSuaIDdmQ2Tib0c@vger.kernel.org
X-Gm-Message-State: AOJu0YywhqPjXBXS7AT/za996IrkWxS6ag9RV8lBDF4fH7zvCs0Di2Zp
	IAw1m7py+Wkzhs3IUJ+T1GXGObSvoAS592w7qHVCxl6X73GCHHz24rfSzESVnGgTjB12qCV88bb
	n96/iy4WfOyKfWHQ7DqwT236PXIdHWX2CCpME0EUPWCjS+QcMwiaWoxRtGf0G6NT7aw==
X-Gm-Gg: AY/fxX7oiLg4KS/kIGeiDq+Jp6CRDvInJcCALadibU6O7i6vdejnDjgudEZrFCy0HPJ
	2fUUl1TasXgeULvnPItvcGOahckFv/WQbbjLEdDp8z89V5cBsVdl0G9fViTBeAAuSNecGw2LYKT
	tJil9LCqvS/Y1C0u1qzVJqON9hVUGlrd/zlZU8sJEmE+9fjRQuqr9aJbM5GcGNjQ0Kcu3b9yUEq
	AM/Lferc594whlNjFmm7RcRhQZ7xUmII6rFbsYcqMugXt6Vcezk20UivEEiZUkAPsU+A/ynwZno
	UU1zJL8AOCVLLz/G0ixhMwXmZ88WhlfeniaVV8hp7Wbknl9OZUMy1diPAWlquPOnhXlOOPRKDP4
	=
X-Received: by 2002:a17:907:d11:b0:b87:19ac:98ce with SMTP id a640c23a62f3a-b8719ac9ba6mr340670266b.4.1768229457181;
        Mon, 12 Jan 2026 06:50:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGodEgWaGnO/BinsgSPFbBzgONiFVWuueEar/8j4zEvL7xMhaUYrOMxjKwwTSCT4wC7a0hARQ==
X-Received: by 2002:a17:907:d11:b0:b87:19ac:98ce with SMTP id a640c23a62f3a-b8719ac9ba6mr340667066b.4.1768229456659;
        Mon, 12 Jan 2026 06:50:56 -0800 (PST)
Received: from thinky ([217.30.74.39])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8715d0e99asm388258666b.51.2026.01.12.06.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 06:50:56 -0800 (PST)
From: Andrey Albershteyn <aalbersh@redhat.com>
X-Google-Original-From: Andrey Albershteyn <aalbersh@kernel.org>
Date: Mon, 12 Jan 2026 15:50:55 +0100
To: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org, 
	ebiggers@kernel.org, linux-fsdevel@vger.kernel.org, aalbersh@kernel.org, 
	aalbersh@redhat.com, djwong@kernel.org
Cc: djwong@kernel.org, david@fromorbit.com, hch@lst.de
Subject: [PATCH v2 9/22] xfs: don't allow to enable DAX on fs-verity sealed
 inode
Message-ID: <osfyixw77gnssemtxreoziyumsdstic4xgm6k6c5hp7v2nj4x6@ypfnx6seiaps>
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

fs-verity doesn't support DAX. Forbid filesystem to enable DAX on
inodes which already have fs-verity enabled. The opposite is checked
when fs-verity is enabled, it won't be enabled if DAX is.

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
[djwong: fix typo in subject]
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/xfs_iops.c | 2 ++
 1 file changed, 2 insertions(+), 0 deletions(-)

diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 6b8e4e87ab..44c6161137 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -1366,6 +1366,8 @@
 		return false;
 	if (!xfs_inode_supports_dax(ip))
 		return false;
+	if (ip->i_diflags2 & XFS_DIFLAG2_VERITY)
+		return false;
 	if (xfs_has_dax_always(ip->i_mount))
 		return true;
 	if (ip->i_diflags2 & XFS_DIFLAG2_DAX)

-- 
- Andrey


