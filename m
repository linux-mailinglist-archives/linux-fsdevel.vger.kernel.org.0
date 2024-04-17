Return-Path: <linux-fsdevel+bounces-17132-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B238A83BE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 15:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 852091F23622
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 13:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD24F13D8B6;
	Wed, 17 Apr 2024 13:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="j6Uo9ToS";
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="Gr9gds8m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2191A13D602;
	Wed, 17 Apr 2024 13:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713359065; cv=none; b=SIBbXvRKXe6ogABbMHKZM5FQSufeVTuJ47juENVNPgRHL1bi933nMAexR4MNFD3t40RhIeyzM35owkcDmY8h1A0VPD3NekOIbwcRnPFI5T/A1XWMLRrZNK6uHeJlzy7tWxSQn3pqrHXGI6P80yXVNrZ+Y8HxE8ew3mYD4HGYgOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713359065; c=relaxed/simple;
	bh=kN4Zh8uJjfNwUm/W7UF88zGWnSaHMwjVtETPiu+d704=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=e58L94f7XdH5wcH+10JvNDzuPsoJWdK6yYZLU6xEJQ/4X1KKL0uEOYWUmGlRNuqqgAa2+TWezzhAmztFa2WfjrrPwz/5LOrK07w08rQXqcOFrrR9imvPOWd4FA0QsEbqB6H65ndq0aOsaCOVyJUD+tH1uIBH+D5T7dyCFuYifQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=j6Uo9ToS; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=Gr9gds8m; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 3EF292126;
	Wed, 17 Apr 2024 12:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1713358610;
	bh=hOaXPBoDYaEEFQtxf9hg6OHtyzUndpHUFWq8x7yxmik=;
	h=Date:Subject:From:To:References:In-Reply-To;
	b=j6Uo9ToSctgbzS1+5bkR8GwAIKA5+0PYEtGUDf/lLsVx7QQJopqIGYCCNnFOGM4I3
	 w/f8ppQxiYc4pNoKFDfi802v6aGbFlSYhq4dilgsa49Hwoz1omf5zGLhuGIzMH98mp
	 Kv1V5y2AV9Tq/Ym41MyUzx2MFApMlw+Z4fQXAfgk=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 3034A35D;
	Wed, 17 Apr 2024 13:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1713359059;
	bh=hOaXPBoDYaEEFQtxf9hg6OHtyzUndpHUFWq8x7yxmik=;
	h=Date:Subject:From:To:References:In-Reply-To;
	b=Gr9gds8m2hKXjUXveXB9FoBTe9yCkG6hiB04RXWx8Pku0hVV1YzsPfob1UMPuQXt7
	 SwHB2UG9ITBX0U9xftutnogKa/py2CEeIGL9q68U3Y9UX0Yfx/pqnqTlfHj/FHnYFk
	 gvEpMqM/QDc6NeGjv6yxV6G2iTp8j8Zhu2GU9TQQ=
Received: from [192.168.211.39] (192.168.211.39) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 17 Apr 2024 16:04:18 +0300
Message-ID: <8c102e86-466d-4c6c-897a-f2d42c15a204@paragon-software.com>
Date: Wed, 17 Apr 2024 16:04:18 +0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 01/11] fs/ntfs3: Remove max link count info display during
 driver init
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>, LKML <linux-kernel@vger.kernel.org>,
	Linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <6c99c1bd-448d-4301-8404-50df34e8df8e@paragon-software.com>
Content-Language: en-US
In-Reply-To: <6c99c1bd-448d-4301-8404-50df34e8df8e@paragon-software.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
  fs/ntfs3/super.c | 2 --
  1 file changed, 2 deletions(-)

diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 9df7c20d066f..ac4722011140 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -1804,8 +1804,6 @@ static int __init init_ntfs_fs(void)
  {
      int err;

-    pr_info("ntfs3: Max link count %u\n", NTFS_LINK_MAX);
-
      if (IS_ENABLED(CONFIG_NTFS3_FS_POSIX_ACL))
          pr_info("ntfs3: Enabled Linux POSIX ACLs support\n");
      if (IS_ENABLED(CONFIG_NTFS3_64BIT_CLUSTER))
-- 
2.34.1


