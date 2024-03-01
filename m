Return-Path: <linux-fsdevel+bounces-13338-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6364886EBE4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 23:33:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1507D2831D8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 22:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB445E09E;
	Fri,  1 Mar 2024 22:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TUaWDAyP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4E058ABA
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Mar 2024 22:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709332398; cv=none; b=DEM9qyTamStC7YjCEPqOvwES7SgRcIFm/laFAMCgPZzMStSznY+psRezHVTJ8idIkynkQ2e4U6/Gtdkcltjdgw+EFoRh18jFWi1J+JM61eZKn/4oSyqCtYLPFawQH8Q8RER8Bc+6pNIDte4sc9Cta18d2EJRUMn6GCH8MlsYzPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709332398; c=relaxed/simple;
	bh=EWb/ftvwdaQd9qh1/h4cZUpTZSO/pUNQ8VCrENQBSI4=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=K5UJQWRcMNnS8fiJeCE6AccMmY7X+701NyTu1a+WesdWC1xbLaF56pUIcJRLGcOxi6Fylo6JGREiDdOSZndC6WxCxJz7HlIivzTBAf1F/SF9LVDj2Jv1XGCXCHgdoVqA1O/QVHCT7/k6BqLH+yCtUS0ZdzvvEcZS8lKy0niXyyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TUaWDAyP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709332396;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=moEJ5/lO3tirRLCWaEf0dR82LKqpwz4rWP+Prw6pDjo=;
	b=TUaWDAyPxGzfS4N4u0ujaW4eFbzVXQHlCl4giK17erdAbP+0ceom8m1WEb3lTrZGMYazkW
	Q62/MkrZ85GRM81GhRO7YLbXmdHOUtSl/VCJdqpzGvHjCyTm2Es4NhYSLUJsDf1YGAA9pj
	tPO+s2w4PBCmhLPhduUibySkMkCUywA=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-UCLO5d3uMKGxyG6YVfX_dQ-1; Fri, 01 Mar 2024 17:33:15 -0500
X-MC-Unique: UCLO5d3uMKGxyG6YVfX_dQ-1
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7c7e91ddc42so273102339f.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 Mar 2024 14:33:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709332393; x=1709937193;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=moEJ5/lO3tirRLCWaEf0dR82LKqpwz4rWP+Prw6pDjo=;
        b=D90CSmLPzKCcU/yEezWvamt/0Jp9wLDw8+RuhNQEZoxa9RlGe2BV0iPmUXoM9Y6CLm
         /KayHAcdQf1ibFnysgk0Fu023Lg0ORr51CrobMfmL3G3PIH9glsC2UuPW5cnPrHCjHk6
         1ucC+eeyuU6IaZKCL4lwceN5+qxCT2REgMb16502nQFOmbN+W+B8NaiblLOWW+tgXIOp
         uAZLbWYunVxZUbrFnZNyOCgSwhPWA6M4q5iD+D3LpzdpEDEnCeA5wOBi9kIqIsgi0wNl
         whSKT54bFTVfsXnisL0kuzOEybfMW9p7G1U8wCnX4wqg/+PzbAfEfxz3WReWM1FCBrbK
         RUug==
X-Gm-Message-State: AOJu0Yx5u5yCTuVDXUuN5zLRRXwqwJWuw98+tz3eDPCsLc+T2Xn96W2z
	iWTJ2eN+ZvVGEBI8yl149+2S9Uw2A4XAR4vwb4Qa1ShYmCRqZQvXrGVrEqRJCfJXsoE2k+EusH3
	f5EcGAwEKphDAAX3+zij601hXyW6V+1wJTUQ88dBNHZOABOjYm0F2p2HKHqQtd87LvDIo+QsmkE
	XYWNz4OQz6jVF/nyrkpp2BS2bgpJJYo3EE8u97iZYUe6nRlKnv
X-Received: by 2002:a05:6e02:1a22:b0:365:4e45:7869 with SMTP id g2-20020a056e021a2200b003654e457869mr1792485ile.12.1709332393473;
        Fri, 01 Mar 2024 14:33:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGXb8d6ZVdLG8Xf/a3u1BKzxIzAGpKSp/m/EdNtQU8xqhMAjDn+r99a5SgOvG10wIfeyvuG5Q==
X-Received: by 2002:a05:6e02:1a22:b0:365:4e45:7869 with SMTP id g2-20020a056e021a2200b003654e457869mr1792473ile.12.1709332393160;
        Fri, 01 Mar 2024 14:33:13 -0800 (PST)
Received: from [10.0.0.71] (sandeen.net. [63.231.237.45])
        by smtp.gmail.com with ESMTPSA id m7-20020a056e020de700b00363909191b8sm1120061ilj.39.2024.03.01.14.33.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Mar 2024 14:33:12 -0800 (PST)
Message-ID: <90b968aa-c979-420f-ba37-5acc3391b28f@redhat.com>
Date: Fri, 1 Mar 2024 16:33:11 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-fsdevel@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
 Christian Brauner <brauner@kernel.org>, Bill O'Donnell <billodo@redhat.com>
From: Eric Sandeen <sandeen@redhat.com>
Subject: [PATCH] openpromfs: finish conversion to the new mount API
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The original mount API conversion inexplicably left out the change
from ->remount_fs to ->reconfigure; do that now.

Fixes: 7ab2fa7693c3 ("vfs: Convert openpromfs to use the new mount API")
Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---

diff --git a/fs/openpromfs/inode.c b/fs/openpromfs/inode.c
index c4b65a6d41cc..aa79ac0b3e30 100644
--- a/fs/openpromfs/inode.c
+++ b/fs/openpromfs/inode.c
@@ -355,10 +355,10 @@ static struct inode *openprom_iget(struct super_block *sb, ino_t ino)
 	return inode;
 }
 
-static int openprom_remount(struct super_block *sb, int *flags, char *data)
+static int openprom_reconfigure(struct fs_context *fc)
 {
-	sync_filesystem(sb);
-	*flags |= SB_NOATIME;
+	sync_filesystem(fc->root->d_sb);
+	fc->sb_flags |= SB_NOATIME;
 	return 0;
 }
 
@@ -366,7 +366,6 @@ static const struct super_operations openprom_sops = {
 	.alloc_inode	= openprom_alloc_inode,
 	.free_inode	= openprom_free_inode,
 	.statfs		= simple_statfs,
-	.remount_fs	= openprom_remount,
 };
 
 static int openprom_fill_super(struct super_block *s, struct fs_context *fc)
@@ -415,6 +414,7 @@ static int openpromfs_get_tree(struct fs_context *fc)
 
 static const struct fs_context_operations openpromfs_context_ops = {
 	.get_tree	= openpromfs_get_tree,
+	.reconfigure	= openpromfs_reconfigure,
 };
 
 static int openpromfs_init_fs_context(struct fs_context *fc)


