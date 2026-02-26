Return-Path: <linux-fsdevel+bounces-78436-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id FfhRJEjGn2kzdwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78436-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 05:04:24 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B28941A0C06
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 05:04:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3C6E6301AAAF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 04:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37C1389E05;
	Thu, 26 Feb 2026 04:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iJJ60pW/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A1A329E43
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Feb 2026 04:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772078658; cv=none; b=NFdOQUk2xNVgnytw19xFOGERw9T0hSlNPHb3k+/E4pPwG8sHeVUvR50MSqMAh2sE0x5HZ0f/FheH7KZQVSjlk5m6tml6DlvRHLGbZvynxiM8UhAVWBcjr816tw2AlFUJLikzCQ6kV2h44YYwSSc40rD3nRD972TrWL8ZWxMcfSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772078658; c=relaxed/simple;
	bh=9QnsUH1b8xu9HS7Lr8NBFEdFNO86Z9sWzIxCtwZ5Yio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AyoxuFwVg2EuaV1m9sWeVVD3vMDvgERJg/UwS8dPEpH39NbqTAirUX6Mm7OXejJvMyax4LeObttmlQGYFxjKP4q/gs+GyGfoA/mO8QrO+ypd3XrjTCg7KZiXb9xnbiPH3KxeX52QWAuIrJS+M/hEK8h6kWSYcoXSYSsI+mbQ3vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iJJ60pW/; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-64ad9fabd08so355621d50.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Feb 2026 20:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772078656; x=1772683456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OW2A0GS7O+4pmpGmbAo6fa4SoWiUi8MSUjgZBunJX3U=;
        b=iJJ60pW/vBrRRj6NVIV0KCXXsTF6YSr7yx/kRgmD5A8GXesWanT59o9ataANxw1/NO
         PRNY1UXQX7GpmNujqQHU8KZZa3KCscGfRJEdEvNXvLW8a5g7DDHCWTuua04PiMl+BTIj
         RxMRvp3vKBFvNtyxgNu73SXH4k7tY9bkBfaUtSB7W+vqqpDaSGaisbvUqy1cwqvpYFsK
         FZXh0PFaku+aDnKSNc8JCsGQdg6AwPojh6RFFsOfAyVXk5AdPz0TuLaQB9Y4FnX/nc2D
         nB2ng9t5plr6lig8pBRUTkmCksKlbJadndeBxY2GskV85KHuiF4GJgCeefvAZokzeHaL
         i26w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772078656; x=1772683456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OW2A0GS7O+4pmpGmbAo6fa4SoWiUi8MSUjgZBunJX3U=;
        b=GCud1H6uThT9G6vFK/zg76yxNbNMt3P/GYPwJQlEt7kno3amNRY1D35QbJSdlEz/gF
         KDefgwHyziv5+jyN3iEl90B5utCEhd/HLgiHWyyA9zPX566p/yNfa0M7KBdxxctr8auz
         shlV47P7pmG+yBTfR0pNdxRFdySSFOeV1xnhFXPJtvfnyJSqHIivuTDI1CfUG3MMpaMo
         Tv8NP4OosLp0ItSuc4D5IrglPnFZqZcjIUQNHSQ2k6IfxxnnDm4g3WxJ4sdpEuftpvGW
         LSY77eJXSkVB+l2XHZ7FgtOQHtdItnIuZYh+B9/XX5VKMxMsH0RfrAoqJzNvnB1/qU5s
         0gtg==
X-Gm-Message-State: AOJu0YzO5/nvJj25CBjfQ7FgYALfsQxXHO+yDCvViQ15WWOs83NtTaNU
	JJyAyhIpAd4ySEqecH6wLTLVE2FU2CRtCmPMOTO+KMyp2SAGpMsiemfW
X-Gm-Gg: ATEYQzzi96loHcNTXFeFRT5XPSGtQA+BrCz421l0spKUUnWKH7vej6BLT4GVdukXgXL
	XsXz92iEkEzKSbwRVhgkzcPOTGGxVGnKJEVYwMfnNRvCSJWmfnnMWbo3gUfSGCBhS44Ki3gXsu1
	KvFHIoyucVXYcyaEGgTze4J8uws5442ZO4/YlAaNa6LyY8fOJiqeomokP4+YnTJKZk6CcqTQefw
	nAsZdvrC5V8uDXtDAed3vV9EY9o2H1TpM/wU9VU+eHwG3HbOFFsuSGNsAHsibHMdMHntqDgiBAR
	rLzE8PbDmo15Cs1WU5cx1vy2RkGCwH0oTE/5tS6HKpwDdnZ3Iqz1rkLlVgrA0AE8/PnUDi9p11N
	OE8zf+fcy2/gg67VjE50n9+9AiGA7+QZ7S7AQQomSKRfHLh6qa1diHOA8KIY/AArPoe+HSjNYN5
	ntt81OKEcQIkJf8GIvF4iklk32yGjDRSwvk5p24K+jczNxouJwSwXz7Kbzzd7EEM0+qDwGIkYjV
	UKRKFSRDE+KucBD+3hHEygo
X-Received: by 2002:a05:690e:168d:b0:649:d79c:1608 with SMTP id 956f58d0204a3-64c787d43b6mr16826743d50.18.1772078656402;
        Wed, 25 Feb 2026 20:04:16 -0800 (PST)
Received: from tux ([2601:7c0:c37c:4c00::5c0b])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64cb759f638sm498466d50.7.2026.02.25.20.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 20:04:16 -0800 (PST)
From: Ethan Tidmore <ethantidmore06@gmail.com>
To: linkinjeon@kernel.org,
	hyc.lee@gmail.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ethan Tidmore <ethantidmore06@gmail.com>
Subject: [PATCH 1/2] ntfs: Replace ERR_PTR(0) with NULL
Date: Wed, 25 Feb 2026 22:03:54 -0600
Message-ID: <20260226040355.1974628-2-ethantidmore06@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260226040355.1974628-1-ethantidmore06@gmail.com>
References: <20260226040355.1974628-1-ethantidmore06@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78436-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ethantidmore06@gmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B28941A0C06
X-Rspamd-Action: no action

The variable err is confirmed to be 0 and then never reassigned in the
success path. The function then returns with ERR_PTR(err) which just
equals NULL and can be misleading.

Detected by Smatch:
fs/ntfs/namei.c:1091 ntfs_mkdir() warn:
passing zero to 'ERR_PTR'

Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
---
 fs/ntfs/namei.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs/namei.c b/fs/ntfs/namei.c
index a21eeaec57b4..cecfaabfbfe7 100644
--- a/fs/ntfs/namei.c
+++ b/fs/ntfs/namei.c
@@ -1088,7 +1088,7 @@ static struct dentry *ntfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	}
 
 	d_instantiate_new(dentry, VFS_I(ni));
-	return ERR_PTR(err);
+	return NULL;
 }
 
 static int ntfs_rmdir(struct inode *dir, struct dentry *dentry)
-- 
2.53.0


