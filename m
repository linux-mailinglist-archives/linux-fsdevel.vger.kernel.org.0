Return-Path: <linux-fsdevel+bounces-24589-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C87A6940CAC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 11:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83CF128413A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 09:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A57D1946A5;
	Tue, 30 Jul 2024 08:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aepfle.de header.i=@aepfle.de header.b="iSeaF96X";
	dkim=permerror (0-bit key) header.d=aepfle.de header.i=@aepfle.de header.b="g50jNaPt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95312192B9B;
	Tue, 30 Jul 2024 08:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722329982; cv=pass; b=AT1/XxjWqaEJNw82rFi60bLY+Nc6+n6HZQrZWdVeR0JZxONr9vWneVRxucTs3OH6NvmqSAEm7iVhu0cjsa1g1Zzd6qAev//WPMbCMYjh5HJTuAGQ6PN81Mq7PTPSp+mKPISSN40F0D9IfroGIEGDJvgPcE6U8qbLm3hS7iTIPMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722329982; c=relaxed/simple;
	bh=YfTqhFDqJYp+JLjwF5uh/+vKK88aVkgIiewk3DPjjgM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DTOJnNgteQIv7CYOd9TeNdeGejC6nO0gCkypygHnVFdiRM/gd4F3SSrQ65sCv5TtBcC4iBzke99wl+2pWGhLF4vbN5fZB2CSE/CBQPnVBm2rNRG0/bURg02eqx7QPNaeTC+pS7FVWctLaiJiV9rg5y/tFRaxWap2LKnc91okzFc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aepfle.de; spf=none smtp.mailfrom=aepfle.de; dkim=pass (2048-bit key) header.d=aepfle.de header.i=@aepfle.de header.b=iSeaF96X; dkim=permerror (0-bit key) header.d=aepfle.de header.i=@aepfle.de header.b=g50jNaPt; arc=pass smtp.client-ip=85.215.255.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aepfle.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=aepfle.de
ARC-Seal: i=1; a=rsa-sha256; t=1722329965; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=qOSf1FKAbz8XYjxwFlimLpfQUPpNF+IRljKJUVPqrtRTAkDZJ/5fuGIbym1/NuPZtA
    lX+XBjqT5Fsr9xOdjdHQHqvBaj9rlnupp1xcTIkfVuTNnZt4jlYCMq837mbEPkv3gFF8
    272YtmeJNGsFxnFKJNnQntW6ImeuXaTMgK7WtgMpwAk41rJt2PiX9+A4vDn/Jnj075l0
    tx2U7dm90xFKrwQJ7WfBGGykuf8m5Z+kgZFt/ameVLEJ0rn3Q7LQZqUqBl3lUJkp2glH
    O8vdtnCCBpDhw/bj6v0dxljYyitlInd6L9c/7hEgX+ep7PaVlU3ORRKrvE/OpoWy8Nu4
    Dy/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1722329965;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=zh/9T9nyWLdcZOIjv+Rhg6f0fftFaK7VZ4t/7b8wz7s=;
    b=WiIYunI+4LRCXQSCSr86u9QX+cZOnoqANwjpytOzaIFP7/2mvnYDKlZTSHDsjdJiLT
    tEtwTVvNdoVZ1uceP6a3m8sjId2dy9b0+0j7sfT7W4yVErW2R8Ew0AqR20KO44LRIxBn
    oMW+VAtTrNc7+2eedWNOc6c1h87YA6CjIpbSlOH+eeziomgz48YBienR7VZy2orqMEnk
    FfIBblMMn7NQpUoudiu8poFs6T0h+OpbGuMCPSXsliLErtg6JGUU0Rbo/Zlpac8nn7WI
    phG4+n/O4sKaJ4S5IznUxHOdcbmjXWOb8oOmk3Lmhe2ndwZJbBbCdUzCkkALaqdfrUci
    XYSw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1722329965;
    s=strato-dkim-0002; d=aepfle.de;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=zh/9T9nyWLdcZOIjv+Rhg6f0fftFaK7VZ4t/7b8wz7s=;
    b=iSeaF96XRvrXC7a4waUjKXeA1LaVSz+fDJVSCLTMvRzbFniqYOKA6rMcs7qjXKJvI9
    nKIeGz7wr4g+tdlvxEZWCElgw3LhjE0GFC3JDkQEX1fSFgiGyEyS+NmUTT2qbTjk/CYV
    6NH5gOZU9PBtXVCV1/99kbbPgVb9gjZ45XXAi3y/q1lmweOqVOAvJzlubRlgKzRW2Ran
    SZz4MaRX6lPKzo7o8sOrJZ2tN2oWxbmRWvM6gCFvuN21BSJcdVF2+JaO0OqQM/HaDftc
    MX5Gg512xsqd85aNe45RYJxBIW34/BRWj3W5oHZMWelnp6hrWtk5FUSBntBAbK93FCXW
    5n6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1722329965;
    s=strato-dkim-0003; d=aepfle.de;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=zh/9T9nyWLdcZOIjv+Rhg6f0fftFaK7VZ4t/7b8wz7s=;
    b=g50jNaPtfSJntt3v075sHv+IONjlFfoLW/qhuarjwlTirlizsu+9Ld1CQ2Dtr4dNNh
    E+00rTw3szQsJbX5JTBw==
X-RZG-AUTH: ":P2EQZWCpfu+qG7CngxMFH1J+3q8wa/QXkBR9MXjAuzpIG0mv9coXAg4w9Fn7GsstJkkzL2wSKUGj13GSl42eC/3RYuHJGQ=="
Received: from sender
    by smtp.strato.de (RZmta 51.1.0 AUTH)
    with ESMTPSA id Da26f206U8xPNQO
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 30 Jul 2024 10:59:25 +0200 (CEST)
From: Olaf Hering <olaf@aepfle.de>
To: Deepa Dinamani <deepa.kernel@gmail.com>,
	Jeff Layton <jlayton@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH v1] mount: handle OOM on mnt_warn_timestamp_expiry
Date: Tue, 30 Jul 2024 10:58:13 +0200
Message-ID: <20240730085856.32385-1-olaf@aepfle.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

If no page could be allocated, an error pointer was used as format
string in pr_warn.

Rearrange the code to return early in case of OOM. Also add a check
for the return value of d_path. The API of that function is not
documented. It currently returns only ERR_PTR values, but may return
also NULL in the future. Use PTR_ERR_OR_ZERO to cover both cases.

Fixes: f8b92ba67c5d ("mount: Add mount warning for impending timestamp expiry")

Signed-off-by: Olaf Hering <olaf@aepfle.de>
---
 fs/namespace.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 328087a4df8a..539d4f203a20 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2922,7 +2922,14 @@ static void mnt_warn_timestamp_expiry(struct path *mountpoint, struct vfsmount *
 	   (!(sb->s_iflags & SB_I_TS_EXPIRY_WARNED)) &&
 	   (ktime_get_real_seconds() + TIME_UPTIME_SEC_MAX > sb->s_time_max)) {
 		char *buf = (char *)__get_free_page(GFP_KERNEL);
-		char *mntpath = buf ? d_path(mountpoint, buf, PAGE_SIZE) : ERR_PTR(-ENOMEM);
+		char *mntpath;
+		
+		if (!buf)
+			return;
+
+		mntpath = d_path(mountpoint, buf, PAGE_SIZE);
+		if (PTR_ERR_OR_ZERO(mntpath))
+			goto err;
 
 		pr_warn("%s filesystem being %s at %s supports timestamps until %ptTd (0x%llx)\n",
 			sb->s_type->name,
@@ -2930,8 +2937,9 @@ static void mnt_warn_timestamp_expiry(struct path *mountpoint, struct vfsmount *
 			mntpath, &sb->s_time_max,
 			(unsigned long long)sb->s_time_max);
 
-		free_page((unsigned long)buf);
 		sb->s_iflags |= SB_I_TS_EXPIRY_WARNED;
+err:
+		free_page((unsigned long)buf);
 	}
 }
 

