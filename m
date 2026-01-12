Return-Path: <linux-fsdevel+bounces-73264-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C7DD13702
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 16:05:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5C7D930E0B33
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 14:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067A02D838C;
	Mon, 12 Jan 2026 14:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aDcZwGIL";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="hG07ugsH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA0C883F
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jan 2026 14:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768229554; cv=none; b=f1jCNSa2gmeZEtVqiikmFf040P+DFauMzj1BscvHB5+6QNt4TLWrMxp7XNnAY6+bphRcKNavLXMR3dYLp/tYB6ZZ7UjgJJBJaZMyZU7y/iI4iosln781FS0CJjTEAuj+11KQp7yoBYoavYVxiuqUU1awiN+NDvNDDbhtKJnbf8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768229554; c=relaxed/simple;
	bh=4oN3KsYgjU1gziBXcCV2JxaplDe0MjbcejD0zRksvRk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YQGw29WUi7WxHEoLwRytLt6hZFZ7hONb8KsHjfrmBzj/w7WrjL/TEKI2udsc4uQqOrNj9HBFQ8A4RARzbBV4xaCL3AGX3JkUbYGEJkG7+dYaOYFCofnNCeGytDWVWIvzyEQyia0UaqKYSxaP30ikL0qnwgRfs9URwsfH6CeNN9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aDcZwGIL; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=hG07ugsH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768229552;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=27c0RwsiUqQbIRsQgbUzvN/pOWTjcdmLaKAYvxOvoHg=;
	b=aDcZwGILi0j4brsOH0DuO/rW1YDnjL+B0+W1fxkX3Ktl34ezt3UCTziFTFoIlbNk2oanDv
	X1r9SYNHWMe5uzsDNh96fz9JfzXeKulbZ8o/AZWxfwixg5nMtJ7PqpH2felTK0S4/ERlMY
	5MIaTx3zemGywxslZYsjVdkTFf+AQ50=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377--8ZjQMLINV6ngtCoKJjNZA-1; Mon, 12 Jan 2026 09:52:30 -0500
X-MC-Unique: -8ZjQMLINV6ngtCoKJjNZA-1
X-Mimecast-MFC-AGG-ID: -8ZjQMLINV6ngtCoKJjNZA_1768229549
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b8395cae8c8so661003966b.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jan 2026 06:52:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768229548; x=1768834348; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=27c0RwsiUqQbIRsQgbUzvN/pOWTjcdmLaKAYvxOvoHg=;
        b=hG07ugsHB2HIRTMIwCF0OCtBqNaeuaiN9aueXT1Ohedd52/yttCGaFFYwmS9rqpA/T
         rngerTTiUdwzisnyyoAaMxmCg+uKpp6qXm0HYnFu2SEs50cM7R4d1xP8+IveQ+1nGGoC
         xHP5HHINzOuJchZ+Cd93CIE73I3ZSUbfNj7DPSYPNbY2Xtku4VbwLK5/Ot7cDnXEvxXy
         1ZpXZAgorkPC4gjEDmKEECY0znP/k5OOB90Vh+TXFVq6k3oZZKr4TPmHuzfxHrXtJMNa
         lpmHG8HCMC8AdDJmkn6AuQL00VedGrgjVG7qUs1AKuK5iBs1VkzTXGk3qEQFpHX23wJk
         YsCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768229548; x=1768834348;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=27c0RwsiUqQbIRsQgbUzvN/pOWTjcdmLaKAYvxOvoHg=;
        b=q+Hek8TmHWDniQuTtskNEmcuI/OSwbVZISDaIDgOQyB1lic8kG6LGWRFDYEA7fAb+Y
         UUzUXQiHIZLxdvmIawbNQsB3Egg/wXucBgB7te0L1PLnCMni4LMcuiEAzF3tbk0BzrQ3
         /wbQqtkEzXz1ugX3DLFBB2Ro726sDNXlhkzgZMl4gkLqOu+kjPacv3uucvb/u/h6p3Qg
         ElAUhkMaS+N12gBVflasSmTu4IWRZddPc5Q+3uWKJ9tQa/x9BjBL31rrYPd8WtJh2ytr
         IX1JvdvoIs9Lw0QNzULZYFiVH3oCWdb6eC0n7g7o1rReCqmVHfatfESSrk2JLEszGNRw
         2/YA==
X-Forwarded-Encrypted: i=1; AJvYcCWga9Gkr3kUqnB9fNBt8dPxmXJZjRQZxQy9D5tqDp/lAqw9zAm0t3+Vce6RJ9tcUrgtq/jkaLaUeHG1VeoE@vger.kernel.org
X-Gm-Message-State: AOJu0YxA1iC88mUo8K9RO8YH84aAlP5UwVqOufea1NtBZwDfS05HsNGj
	XgduAPV00z+IzYfhNktLgbUZTRuacY0XHX5icwLLGbkENm0PQf7SW8mkbVdYnv395uYVR/XNjD3
	I4zolja/fJDM3vOw2zxa5AwYHWU8oczyEvzlKCCw/mS0jJkDXo2IkXCNxZM4PB/ec/wFB2A205g
	==
X-Gm-Gg: AY/fxX7j2LidTtAmQt9eBbMtPtQF3NDxFeFJZEGOpEgnWk+y4yavKqTJPfxZe04Er92
	fdHIboh1krDxRfymTWet+pH8TQX32v32GmUpylD3a3OAa8ruhO5A/7B0QnDsFPn/Yv1j4c1b9NE
	tH+AS0jaZT0e8w/qqJJ2V4Or03UWX6igrOfuhMazJsrUHiqmccmN9eRPgWg8+LL/EJg/PsdOBRy
	0Bu3eJI7FrJT5VMV0+XGXFh9RrC0ox+tLV9AjYPgjCinbjxOPARuCLkdK2TpIWR+FcOKr5x8lci
	mPB2Gsp5NZ94H9KpRAoh/tMJLDF9TlJba/ZASYMkuy+3iaQ07vCBZ1hbd7gP4RJPlBHg2e9Rzr4
	=
X-Received: by 2002:a17:906:ef0d:b0:b76:7f64:77a5 with SMTP id a640c23a62f3a-b8444f21c49mr1822210366b.20.1768229548309;
        Mon, 12 Jan 2026 06:52:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHdX+T72PLi+rN64BMH3u11dTZ5cmvdk1ssM9FQvlRjQjwZTrPkhU4nI7/e1E+OEM+96ED/HA==
X-Received: by 2002:a17:906:ef0d:b0:b76:7f64:77a5 with SMTP id a640c23a62f3a-b8444f21c49mr1822207566b.20.1768229547833;
        Mon, 12 Jan 2026 06:52:27 -0800 (PST)
Received: from thinky ([217.30.74.39])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b870bcd342bsm475411366b.56.2026.01.12.06.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 06:52:27 -0800 (PST)
From: Andrey Albershteyn <aalbersh@redhat.com>
X-Google-Original-From: Andrey Albershteyn <aalbersh@kernel.org>
Date: Mon, 12 Jan 2026 15:52:26 +0100
To: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org, 
	ebiggers@kernel.org, linux-fsdevel@vger.kernel.org, aalbersh@kernel.org, 
	aalbersh@redhat.com, djwong@kernel.org
Cc: djwong@kernel.org, david@fromorbit.com, hch@lst.de
Subject: [PATCH v2 22/22] xfs: enable ro-compat fs-verity flag
Message-ID: <t2mwgqd6j3lknok5yexswvdba6nbji24efthhcqhvtqirzeahf@wdlnxaoaupam>
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

Finalize fs-verity integration in XFS by making kernel fs-verity
aware with ro-compat flag.

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
[djwong: add spaces]
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_format.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_format.h b/fs/xfs/libxfs/xfs_format.h
index d67b404964..f5e43909f0 100644
--- a/fs/xfs/libxfs/xfs_format.h
+++ b/fs/xfs/libxfs/xfs_format.h
@@ -378,8 +378,9 @@
 #define XFS_SB_FEAT_RO_COMPAT_ALL \
 		(XFS_SB_FEAT_RO_COMPAT_FINOBT | \
 		 XFS_SB_FEAT_RO_COMPAT_RMAPBT | \
-		 XFS_SB_FEAT_RO_COMPAT_REFLINK| \
-		 XFS_SB_FEAT_RO_COMPAT_INOBTCNT)
+		 XFS_SB_FEAT_RO_COMPAT_REFLINK | \
+		 XFS_SB_FEAT_RO_COMPAT_INOBTCNT | \
+		 XFS_SB_FEAT_RO_COMPAT_VERITY)
 #define XFS_SB_FEAT_RO_COMPAT_UNKNOWN	~XFS_SB_FEAT_RO_COMPAT_ALL
 static inline bool
 xfs_sb_has_ro_compat_feature(

-- 
- Andrey


