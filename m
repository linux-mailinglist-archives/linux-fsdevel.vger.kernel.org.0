Return-Path: <linux-fsdevel+bounces-11161-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8618D851A7F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 18:01:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 416252873E6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 17:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2DBD405C1;
	Mon, 12 Feb 2024 17:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VMT+PA8m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70983DB91
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Feb 2024 17:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707757223; cv=none; b=pkFl+zOtYfUr6jZhrTui6BtIYyapuUTzj9QSDgoB367btuimSX045GTDefBOVnXXQhxB7A1A15TuuQcXA9SV07ArbCsMLOruHZa+QP+oB5+iyfGWI69EeECf6jjUeFDTJab1HKu13kGGmOkeD3OiK4NJcqOuC2zE4o5vFTErMkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707757223; c=relaxed/simple;
	bh=vdHiY+5n22LurY8Opd20329Jh2sRmadcybRUqQPyIPs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QTAd8VJivJRhVbxH1KSOKQl0Vib+nYHSLgmcUhzwMuJQGqqYgRyfUA05k2RTpDmNySW9K1LGj1//oeHHyXavs34WhjU3JqY56asgqvYBZhmOYDZAF/X3beKYOZQ8M/CC9C2fMGtE67FnTUXh7dL/5IZPB9fcSLF2QCMueEzO4vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VMT+PA8m; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707757221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dJCZCHIXGjyZyLUGP8rE/I4QvbwAG0uLO2o/5Ew8lzA=;
	b=VMT+PA8mgO3pCC+jtm+qf/KWNv72sVbeqOT/671+St4jmJ0Ehs9THMaT9N+rrWB+x8B5fo
	/mMrSoT7u3zQA3PtpnC/gHpL0JbEo+CD3zqTQJ0Eag3B+cDzo7l6Ylyb/FZO5MBgYJvcAT
	rqe41IkRYovUKiWIBWrGYGeVz9jvzdw=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-0XpluZsTODOZGMyVJrxjQg-1; Mon, 12 Feb 2024 12:00:19 -0500
X-MC-Unique: 0XpluZsTODOZGMyVJrxjQg-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-55fc415b15aso3642106a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Feb 2024 09:00:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707757218; x=1708362018;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dJCZCHIXGjyZyLUGP8rE/I4QvbwAG0uLO2o/5Ew8lzA=;
        b=lidg7meic6Ew4mmIPWNfjQm5r4qjjXtSbwAefrPCjjmc6DDc0XZ7gQRWTgcFU5FQw3
         9CfsA6O3gv3rKi5I8ic50oaG3+A1SGetb23VjDwFLTDs2Api2V0HvvG1lb7kQ7Gjcaw0
         TJDoOOQeRq5GZVCnRJ3Tz1zxVJl1hW+GpHbCqIm4oTZxzndkJ6J07ijTqG0/HgIVUjda
         79+fbKjISeT6tUx+NrfQHOll3saeE/RutVriiwhnfqTMO7Q5D5DIoQxwKvSc1h5fETJQ
         VFAi/HopUQdE/yPjkCeUReLlJwrMP69NyTe5Wm0aNl8P0ZmaSknh8j0IpV3iAecVe1Xi
         A3HQ==
X-Gm-Message-State: AOJu0YwysfaYR9ji7dBIIuzZPZbLl+ZLKQh4TVAxpqxELqT61rsAda2m
	RHTzfLja/DZUIEbwItZF0uEGmuHDtoDQjiLPh8A1fra5u7OklkNQZxrAxgd125R+02YYQvl3YVt
	N6MJ6wm/NP3J4ykH+cN8wsM3ElUaUTIHrukvO9r6ItBxbzOTI1dRgkhkUuahh3w==
X-Received: by 2002:a05:6402:194b:b0:55f:d6b9:245f with SMTP id f11-20020a056402194b00b0055fd6b9245fmr81607edz.6.1707757218585;
        Mon, 12 Feb 2024 09:00:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEu9oz4kqazMkidIDc3OUaR2AIuDA+GdBkSrnXsXdYN1B/OVQMbeN2XlXF0/dFPIuNCyt2esg==
X-Received: by 2002:a05:6402:194b:b0:55f:d6b9:245f with SMTP id f11-20020a056402194b00b0055fd6b9245fmr81598edz.6.1707757218421;
        Mon, 12 Feb 2024 09:00:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX8qHo9KFTFqx7ffS+BaQUSAi3Ftf56a5RyK3q9a4EYYj9+86aRggYimde3QhhRm33PiYHGgj7kNkzhhEsugmBNpWsi1icmAgylRr/h8p1RapPYuLxTDAlrSRUjc60PQto5qCyrEP3V2pzQKbUURXsWdrlcSV9NVR3+GoKHqeQKhrkIlIb0ivzRDOeqUhRshgvoZj3vznkzGwz47of+OthOjOLnc7ISms8s
Received: from thinky.redhat.com ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id 14-20020a0564021f4e00b0056176e95a88sm2620261edz.32.2024.02.12.09.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 09:00:17 -0800 (PST)
From: Andrey Albershteyn <aalbersh@redhat.com>
To: fsverity@lists.linux.dev,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	chandan.babu@oracle.com,
	djwong@kernel.org,
	ebiggers@kernel.org
Cc: Andrey Albershteyn <aalbersh@redhat.com>
Subject: [PATCH v4 20/25] xfs: don't allow to enable DAX on fs-verity sealsed inode
Date: Mon, 12 Feb 2024 17:58:17 +0100
Message-Id: <20240212165821.1901300-21-aalbersh@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240212165821.1901300-1-aalbersh@redhat.com>
References: <20240212165821.1901300-1-aalbersh@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fs-verity doesn't support DAX. Forbid filesystem to enable DAX on
inodes which already have fs-verity enabled. The opposite is checked
when fs-verity is enabled, it won't be enabled if DAX is.

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
---
 fs/xfs/xfs_iops.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 8972274b8bc0..4cf6b317d018 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -1214,6 +1214,8 @@ xfs_inode_should_enable_dax(
 		return false;
 	if (!xfs_inode_supports_dax(ip))
 		return false;
+	if (ip->i_diflags2 & XFS_DIFLAG2_VERITY)
+		return false;
 	if (xfs_has_dax_always(ip->i_mount))
 		return true;
 	if (ip->i_diflags2 & XFS_DIFLAG2_DAX)
-- 
2.42.0


