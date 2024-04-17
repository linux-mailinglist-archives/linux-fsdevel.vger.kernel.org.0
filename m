Return-Path: <linux-fsdevel+bounces-17133-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9088A83C0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 15:05:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4C8E1F2353B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Apr 2024 13:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB6F13D62C;
	Wed, 17 Apr 2024 13:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="WlW0rVrg";
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="icV/Ihcy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9130D13D527;
	Wed, 17 Apr 2024 13:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713359098; cv=none; b=crwCTETI4rG9IRMGOjpeakcs8I0O238aIN/v6KNc+WgYT8DBNC9vXxrk+pIJh6mAQ4ugDuQAXZOcj+H1lQZ2dqDMvKfVksDW8oQhDGodj5YbqdWLXYug5vkz6iNu7VtPbzxtVsTyxGvhWqFcWm5I0hu/iuDjU5X7TIFidJeER/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713359098; c=relaxed/simple;
	bh=nHiJJBnDAQh8XXjJSwshq7E/3U50CC4VOVeAqV3KbtU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=aXw0xnOwinBuZyF0jecCP+wTJ9a7+/ZmdrWlBuiVmTys15Q1e1SEyarQpva+wgQTDTlpQilFsH2MFtrBxVVO9su6XQYXy8lihBirgmnOeI39J/TvGyJMOr38o+pBaMFWVl6zHmUR9+RSr2Ea30hOsb3knC0/7WJaPJ3/bTv79C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=WlW0rVrg; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=icV/Ihcy; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from relayfre-01.paragon-software.com (unknown [172.30.72.12])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id B08182126;
	Wed, 17 Apr 2024 12:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1713358642;
	bh=BrCZcm5Cajkf+pB8Wxb1+H+kYQ+CtM5WRPNP2QBYrWk=;
	h=Date:Subject:From:To:References:In-Reply-To;
	b=WlW0rVrg97I3/mFt/HdsMnEJVjChVc1DurOPVFCFE9Dz/0sruBBZIQtXKgofFe2R/
	 4Oau6CCebmd8vYgqCYRsCNbrMr9GbCiz4lxjTCqvJEdY6W7QH6jdW6rdJKYvtzm7Z0
	 KpTWwL5VRvIeveDRaVxOM3CkqQYUkUZfL7K6T9To=
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id A196035D;
	Wed, 17 Apr 2024 13:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1713359091;
	bh=BrCZcm5Cajkf+pB8Wxb1+H+kYQ+CtM5WRPNP2QBYrWk=;
	h=Date:Subject:From:To:References:In-Reply-To;
	b=icV/IhcysPooiB40Kq1jxZ1t4y7DPQn6K/cs6rIDEJeXNwPCvxxWrbC1CWSu+US6Q
	 jJXHJIAeQeHdTRQhd5kZRJ4YIi3m1BGXJoIunKSW7HW3wKVy6V/OTDi7eBWq4CANCH
	 ZLcKKG9eZlCP+fgRCHdudvmsE8UK55WwVx1CwCnU=
Received: from [192.168.211.39] (192.168.211.39) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 17 Apr 2024 16:04:51 +0300
Message-ID: <45365ee4-44da-46a7-9edb-a641f0900076@paragon-software.com>
Date: Wed, 17 Apr 2024 16:04:50 +0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 02/11] fs/ntfs3: Missed le32_to_cpu conversion
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
  fs/ntfs3/fslog.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs3/fslog.c b/fs/ntfs3/fslog.c
index 855519713bf7..d9d08823de62 100644
--- a/fs/ntfs3/fslog.c
+++ b/fs/ntfs3/fslog.c
@@ -517,7 +517,7 @@ static inline bool is_rst_area_valid(const struct 
RESTART_HDR *rhdr)
          seq_bits -= 1;
      }

-    if (seq_bits != ra->seq_num_bits)
+    if (seq_bits != le32_to_cpu(ra->seq_num_bits))
          return false;

      /* The log page data offset and record header length must be 
quad-aligned. */
-- 
2.34.1


