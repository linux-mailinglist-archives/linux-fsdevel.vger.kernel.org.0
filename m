Return-Path: <linux-fsdevel+bounces-13542-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 823DA870A61
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 20:14:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DC161F23544
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Mar 2024 19:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94777D41B;
	Mon,  4 Mar 2024 19:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I+J1LG6l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB427D3EA
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Mar 2024 19:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709579557; cv=none; b=MDwblLvQ1UyhRiHXA8o1BMFS/FN27WCxGwxpke5ua/AGAASVQUq0c0bScZZ7P94E90dB1PkvXOwGweNjtkY03bhkmVTp54oFLA4Zhdz1CAMAZb5n+mHTSP/TjJeAWru0ifwrLDpx01sf+2S73hQWerv7fcWUxaYj9QK0AmLKVQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709579557; c=relaxed/simple;
	bh=QdzJQ1kBU4GhtNmWFv/v5q2u9OPK6bqQ8YoEEN+UHm4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bq/MXigvaZwSasaZB1wwQlE5FVrf8/l75AZWHVOaCCjuPCp4UEJlIW8cspo+YTd2KqRZOdxdnNfiUwUIcwK52e6PLamMkNfcs/f6OUq38ChsbH4dH1xvxWwYqSdlXIlWgdKKtXk6pOrr7n6uBP+Ntuj2e+KAf16qdGAbRYf364I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I+J1LG6l; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709579554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CCVu6C3sA7ElU4nB0aYXUKm+yvCdjGTpJNzXHRX3ZOA=;
	b=I+J1LG6lILvgXd7Se1zlhzBaaou5TJ+Lqu6EDMQ3lrDxzCnFUKRlZUt2s4+1ipSGzhI71R
	5nrRv8LlYnGJ5Ipde7ev50yLKvKFKK+hfJkz8fyeQ6q+f3xTNjoe6ZOCAz8YWGiFPSvnZI
	n1mAExKclvHPRUsKmIGiR60wA0XO9CI=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-170-aIBaWtSMNP2VdjEM1YojZw-1; Mon, 04 Mar 2024 14:12:33 -0500
X-MC-Unique: aIBaWtSMNP2VdjEM1YojZw-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-559555e38b0so5250414a12.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Mar 2024 11:12:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709579552; x=1710184352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CCVu6C3sA7ElU4nB0aYXUKm+yvCdjGTpJNzXHRX3ZOA=;
        b=rpYYSXbByi92nl74DMKQHMvgrBStUfR4LQWqF54dmcPQjw/c+ta6UXaMgAl6sj/9am
         NgOXuFymcCDn8kJtzikt1nc21RDqR8LakB1BGHWNrl6vBbMnQHUTIoeGyDrCjKPnAJgM
         eFhut0KctaVtD6To/yXZ29Jw2uC6xRrjOPsFzDG9KqKVZceuKRZ+FbczJpenTOBjzAW2
         0Z8D/FSPvtFD5oMPWXz6HpHiXai3tsbakAxvcm6mtMTU3yXfIpAWWHx441+3xYILxsqL
         IO4My/Oie5cK5BlN6Eq9seHHRuFxOAO81ut8170zUp/Hu0Lk5p/VmrVskbNyQ+pmKd1F
         BQmw==
X-Forwarded-Encrypted: i=1; AJvYcCVyB6cTY9Q91yJTVmvAlSoC2+xTCI8E50x9LVUz0m9MqnZ2vjT2KPdhaRuYADoDmDVpRwslBZnILl0GSLbgpkfXxPF1mrOv/zv581NOZw==
X-Gm-Message-State: AOJu0YwjABeEISaduVTBx1G+1HxTS+tPluX/pE60vJOvud45chQpPcts
	LlRYrIkyOQrvNQKgqj4iPkOcvIV8R4MniY+846cZDVLby/Prtc6dBeMvYLDWzYq4D5Od7/lqbSF
	1YWaQN2C7/Epu+8yJ5cJKp1arKRuqI3Bl9nXw1YUvz01U03M7kjSkIO+NUyrZn/Ml3lrjIQ==
X-Received: by 2002:a17:906:ca46:b0:a3e:8223:289a with SMTP id jx6-20020a170906ca4600b00a3e8223289amr6658577ejb.31.1709579551778;
        Mon, 04 Mar 2024 11:12:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGwEVH/LAIuJqd047oj/TDNuXhBpSOEKAD5TItZIL/0FSEVj2eqhjgA+Kb1gdJhwoiOZ/4iBg==
X-Received: by 2002:a17:906:ca46:b0:a3e:8223:289a with SMTP id jx6-20020a170906ca4600b00a3e8223289amr6658560ejb.31.1709579551268;
        Mon, 04 Mar 2024 11:12:31 -0800 (PST)
Received: from thinky.redhat.com ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id a11-20020a1709064a4b00b00a44a04aa3cfsm3783319ejv.225.2024.03.04.11.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 11:12:30 -0800 (PST)
From: Andrey Albershteyn <aalbersh@redhat.com>
To: fsverity@lists.linux.dev,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	chandan.babu@oracle.com,
	djwong@kernel.org,
	ebiggers@kernel.org
Cc: Andrey Albershteyn <aalbersh@redhat.com>
Subject: [PATCH v5 22/24] xfs: make scrub aware of verity dinode flag
Date: Mon,  4 Mar 2024 20:10:45 +0100
Message-ID: <20240304191046.157464-24-aalbersh@redhat.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240304191046.157464-2-aalbersh@redhat.com>
References: <20240304191046.157464-2-aalbersh@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fs-verity adds new inode flag which causes scrub to fail as it is
not yet known.

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/scrub/attr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xfs/scrub/attr.c b/fs/xfs/scrub/attr.c
index 9a1f59f7b5a4..ae4227cb55ec 100644
--- a/fs/xfs/scrub/attr.c
+++ b/fs/xfs/scrub/attr.c
@@ -494,7 +494,7 @@ xchk_xattr_rec(
 	/* Retrieve the entry and check it. */
 	hash = be32_to_cpu(ent->hashval);
 	badflags = ~(XFS_ATTR_LOCAL | XFS_ATTR_ROOT | XFS_ATTR_SECURE |
-			XFS_ATTR_INCOMPLETE | XFS_ATTR_PARENT);
+			XFS_ATTR_INCOMPLETE | XFS_ATTR_PARENT | XFS_ATTR_VERITY);
 	if ((ent->flags & badflags) != 0)
 		xchk_da_set_corrupt(ds, level);
 	if (ent->flags & XFS_ATTR_LOCAL) {
-- 
2.42.0


