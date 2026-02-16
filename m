Return-Path: <linux-fsdevel+bounces-77312-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aEdlMc9kk2k44QEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77312-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 19:41:19 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C68147065
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 19:41:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CBAC7300D4F9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Feb 2026 18:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36972E88B6;
	Mon, 16 Feb 2026 18:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zetier.com header.i=@zetier.com header.b="ewm15mzp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58EE22E719C
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Feb 2026 18:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771267266; cv=none; b=H+mOA1y+a33FqlmPYYum7BrqAwpd4YY2cTaxP+Vcy30qv3y8B3vE12P1DDd/PqvzHvkWpwPKtPmkqVACzEMWTQI28NpBV0xIbBPjELmJ+D54aFSWhK//EK2AqMBISppfzH4i5t5jeG2Cz9Mvs4Qx4F+/iBeYgQRHuIxPPCaB8XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771267266; c=relaxed/simple;
	bh=MXq1CDAmgqYRszJ+nnSbEjk0iJBh6nFxedE+wHn9LyE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iG103c3Y5kfEiJc3cYiLQmV3bd4WFTM+9zN5gYxSl7MzAVVNOidbhHDUqkaoSwvv/Zk37VNUbXYb4JcySnN9WmdHatrGVh1u33Ka5HlqP+dl9OzPGwcD/wuxzmaYJPeOTH+Euy4fQqm+e3j6zllIGI6ieYt1r6P0K//G1aSCmwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=zetier.com; spf=pass smtp.mailfrom=zetier.com; dkim=pass (2048-bit key) header.d=zetier.com header.i=@zetier.com header.b=ewm15mzp; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=zetier.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zetier.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-506a67282a0so31130931cf.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Feb 2026 10:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zetier.com; s=gm; t=1771267264; x=1771872064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LZMNMKlhcmf87aR6VWLnRpZivg5g7JusG+MWbwtnK50=;
        b=ewm15mzp0splMOwzm9GgxBLe2aKP3zjbCBQ9KTTZk0BG02H3N8tb7Gb5T5kd2C+eon
         17Ap/Ku3PwShh0veldOFYzVPVioMQNdkA6Y71CfcgxAV3egJnDRQ+PdW8IbUY6DMpR/u
         FpEgxNPaNiMPJaztmovFMgIKyR0y3lns0TBFIpWuXM8OE/YV0Ba1NmKxLuOUjEiSufKb
         3k6STVeQ5V2OrlxdFHB/JtCogQFkCONCThsAeJBZg/Dzs3rxqMMlGAos2WtPiiVrRLf8
         J1dg0vKB9T+own/XiC7Y2LRH9DdsXLbEdfXTJwe/GiOqSmW7YbumQz4yW02jys7wgg+K
         adDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771267264; x=1771872064;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LZMNMKlhcmf87aR6VWLnRpZivg5g7JusG+MWbwtnK50=;
        b=CzFSOgqwj5RMAWf19Nt3fdd9YQ9o/kn8ev0BPxloFjpJaO26McMW2KvsCaTyDGkn5P
         3BiLuHyyTLi/6eBLIyD6xgllb2doEksyYDTYQjm9gp2mhIo+YhxU69/cY7yE6SBpwA0q
         O48glHVhYa54rstXK10GnbhjobvICZKqSO7bnIuXZOJVEE5v92qAcrLuewKSAmTwil88
         B78zIXHJOzMQVt/rEthreG4MXMO0iPrFQRqDbfxGHx7sdnoZATGnFwmpbxC36ip3ixrJ
         6PGAEeMemMuYtK9mgOHrSVOVAbhp14fjhWVgFFZYbg4ZCvBHF1WvuXXWsHDJAJ4KWDEs
         mzKQ==
X-Gm-Message-State: AOJu0YzsYaEEq7JiQEyKidIPBl+SGWcGDib0ygp9aWyDTcP4JWASCy54
	dIiKsVRiFnQ+9AepvswmMZE1u6B+817Lm39531Y82/G009GtDPNiLRS/K84A7aJpAjs=
X-Gm-Gg: AZuq6aLpAnTlA5Gzfkahi0EoI8GQHQHHPLFRsedzDHcwm0dsMu1Ztg1BEHZIi0faUQ3
	Vy6Nz8vvGIy8D05VfSyPgu3dxFtuWh8F7DmMKRw9rtSvYv6h9551BKwbV+a5ZP7/GBUcb+0CYV8
	zfb3e9WGzwMY9r5Z+dxv0nJEzxvLJrqzHs/qHIra8tWeNTOgduQzVGlngpIWUmaILYguR5hDDgw
	mmuY72gDWvZ0etodvMEsvjpTu7fdUuOShFUkE6ki3FtuAAt9eDKU0Y1LS+WwK3NPqudVe64iFRo
	R5K1ByIiRUFK1HPAka7UIR3qi0dewUmf2hw43UH/OeVBx1orDB3+n8vrePzKk+HnGMnrxEOxRVb
	nS9a5v9Hu9W/m6fkQIaWH7yBUgHrfBk4IcALv8KH9RA7ZSty46mXWv75rhQwdnoK93w+kCzAAli
	ktbF3HDKOSHwNKLsNeudascU+5ao7N1BW8oxrsKQi9nfkDJB9p3WLP+pliBp/lK0aULPPttl0UM
	RJv
X-Received: by 2002:a05:622a:1897:b0:501:19fa:b041 with SMTP id d75a77b69052e-506a8276ea7mr148196171cf.9.1771267264246;
        Mon, 16 Feb 2026 10:41:04 -0800 (PST)
Received: from warpstation.incus (243.69.21.34.bc.googleusercontent.com. [34.21.69.243])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8971cca7299sm157766676d6.22.2026.02.16.10.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 10:41:03 -0800 (PST)
From: Ethan Ferguson <ethan.ferguson@zetier.com>
To: luisbg@kernel.org,
	salah.triki@gmail.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ethan Ferguson <ethan.ferguson@zetier.com>
Subject: [PATCH 0/2] befs: Add FS_IOC_GETFSLABEL / FS_IOC_SETFSLABEL ioctls
Date: Mon, 16 Feb 2026 13:38:57 -0500
Message-ID: <20260216183859.38269-1-ethan.ferguson@zetier.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[zetier.com,quarantine];
	R_DKIM_ALLOW(-0.20)[zetier.com:s=gm];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77312-lists,linux-fsdevel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ethan.ferguson@zetier.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[zetier.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,zetier.com:mid,zetier.com:dkim]
X-Rspamd-Queue-Id: 64C68147065
X-Rspamd-Action: no action

Add the ability to read / write to the befs filesystem label through the
FS_IOC_GETFSLABEL and FS_IOC_SETFSLABEL ioctls.

v2:
Added an include for <linux/compat.h> for x86-32 compat ioctls

Ethan Ferguson (2):
  befs: Add FS_IOC_GETFSLABEL ioctl
  befs: Add FS_IOC_SETFSLABEL ioctl

 fs/befs/befs.h     |   1 +
 fs/befs/linuxvfs.c | 111 +++++++++++++++++++++++++++++++++++++++------
 fs/befs/super.c    |   1 +
 3 files changed, 100 insertions(+), 13 deletions(-)

base-commit: 541c43310e85dbf35368b43b720c6724bc8ad8ec
-- 
2.43.0


