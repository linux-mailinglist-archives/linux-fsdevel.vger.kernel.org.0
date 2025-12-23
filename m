Return-Path: <linux-fsdevel+bounces-71993-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A0DE8CDABC7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 23:13:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 74867302B13A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 22:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A13632720C;
	Tue, 23 Dec 2025 22:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="P+BwwErE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B752E201004
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Dec 2025 22:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766527998; cv=none; b=d/SH8kloAEordNF/m60UohSPIsXmP7QoaBw856SfnIBEgmR9KR0M1tvdaAn8fAW95HZ01ueEfyRZQWH0K3XSQQkLizMZd8i/q6jRO5GDykh8QUwNm6BH3y2mz+1TcsK+95HgdnSPRzfSh/F9IHUOBeqwPxoMiybbmQeOZQr1rAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766527998; c=relaxed/simple;
	bh=djrFm7idG1wZTyNavDvRaYpps8Oyojc9Dl+G4hxSw5A=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OdXsJsSq0BlQccbZMvf6R/s9iLQ9xOa/FXhVDUd30kr72HpZCq3NmzE1LMD85367voUsqoK4T00dNTpGsEkRncoZiNSEmF8gJUzPP8THDhQHc5KOL9b1bizlpZD2bG9G4OIcQhKi1opzftIYArLxaoUCvD429s2DoFMyxSEZLVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=P+BwwErE; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-64b791b5584so7775000a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Dec 2025 14:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1766527994; x=1767132794; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q3Dh9wBErOPmFpOs6QRksp4HS/VjZZOOvG60XaDU/jM=;
        b=P+BwwErEW5u9Z805BqOKSyDyER8Vqqiy/0g+OEREBwHUcJzs7szWVaKDhnkwG443D9
         KDuztNF6uqFth0BIcDgAguLL8aN4VTrgVnJyvyZTML53++e8LHXMZNMdIXw1ZJqJOgSj
         /Sw4S8PdngXi1kw+g891qkPlWiMV2Lu+f0iQdsmKXHDoOKQZ5OQl9Ygc5es09S+g+Q5r
         MBrKeTy0itrJaADPam93QL/axzZyDl94XGTDDkJs0J2HjTlduKpJryfruOMaCTUPicM5
         8eG1pcaW0syFxVOVeDGqmN5cek+TRGuLiHVEIO4TXiSuismn25C0YafsejfHCLQrM241
         eA3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766527994; x=1767132794;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q3Dh9wBErOPmFpOs6QRksp4HS/VjZZOOvG60XaDU/jM=;
        b=IdKlndeSc5NtpdppFpliDym5IWxpRv1+pxi37o9gtc0O0gCiZ+UGvajiGBiwFa7wBX
         kneNgpzDg7y2KOaGFFePXfoMRy2lpRz796H2LwKKEz9Y+ZB06p+3t4gScuJwq67aspsV
         QPWyldNaFiGXDCSx4e6eCTAjsJKSqBvCbhDuUuQUpcWRpLKysR+jl511xb67ZTTDzfUi
         x2aNMi+XNphYSr709sPjp6uM7xX46mFNuMmoMQIzBldjNtPNOFf6r78366zMfSW4d5C1
         6B7UPZhd66q+ng5V0avVBYXw0JtzXMG36rSEtq5gZGRBSEmwJxdK5R70MXEpIJmo20qI
         Iquw==
X-Forwarded-Encrypted: i=1; AJvYcCXAvkUNwDPkZvsLS6YzQpU7UilL1S4JFxMapxsWtRF2gxEtXyiID8UtocM96x++1BkQyFJp+lYT9lvEVS+H@vger.kernel.org
X-Gm-Message-State: AOJu0YwJdiCCWnPnyDm7d6sXh8vl2INXP/KNpx3cpYBdgUYdDcyHtocd
	3rLRAVKP/h7fY2KjgiwXVrh5P3MNbKmiQi278ewf9/7ozbWxwOv8zbM32DGn+V8T
X-Gm-Gg: AY/fxX6jSOgxQDjP93DWQ00B7Dl7opVNlT/Gf52OFI7w0+xsQYG41MWOYPUReOpP+5c
	p5J7uv6EI0MNSOLy0VxowjCC0+hQq8UK/sKLPWaufhqrNK6a+OsHl0MWSX1Dw704DAjm2Q9ctV0
	hh47Zhm60FOhxNW/mOc9nHmDFI3Qx47m7mNBlT2ATSQQ/nwWmrpyUpJD/2P7+2MXeZQVhxCNjpH
	O9mWr2zOrBdHWD/9YPE9kl9py4lry/cUIUTKnNbspj1gN009/So62lIMJXzr+TLC8dgcA4P28Mp
	Ulgw/7aFCGwJ/gjmqG/Kxk4PSta943r7J+XmzB0dL/zqmn01BgOgoBNyWVt2M1pxTv7OyYtyH3N
	IxYnKUcieljdXPP7R2KjcZQqKOblu9WUVGxv24oxcgRvKhmp4gXRDVdnzseBNzVB1uCGMH6mu4/
	FHBtbs+HYq9WPV78/SZrO1E2GDXQtBH1HKxCmq/fUH7NeDyaYT
X-Google-Smtp-Source: AGHT+IG0BW6zOSQPCl5+xsJLwqkeT+/jd4oHnJe9qeceHJtvUmi/Oxz0wRtNk+wuP0JzZcO3/HoeDg==
X-Received: by 2002:a05:6402:50cf:b0:64b:9fa4:b586 with SMTP id 4fb4d7f45d1cf-64b9fa4b629mr13502460a12.25.1766527993875;
        Tue, 23 Dec 2025 14:13:13 -0800 (PST)
Received: from [127.0.1.1] (178-062-210-188.ip-addr.inexio.net. [188.210.62.178])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64b90f53c70sm14903373a12.6.2025.12.23.14.13.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 14:13:12 -0800 (PST)
From: Horst Birthelmer <hbirthelmer@googlemail.com>
X-Google-Original-From: Horst Birthelmer <hbirthelmer@ddn.com>
Subject: [PATCH RFC v2 0/2] fuse: compound commands
Date: Tue, 23 Dec 2025 23:13:04 +0100
Message-Id: <20251223-fuse-compounds-upstream-v2-0-0f7b4451c85e@ddn.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPATS2kC/4WNSw6CMBCGr0Jm7RhoeYgrExMP4NawaOkgXdCSD
 jQawt1tuIDL//X9GzAFSwzXbINA0bL1LglxyqAflXsTWpM0iFxUhRASh5UJez/NfnWGcZ15CaQ
 m7C+VLkm2WhoJaT0HGuznIL/g+bhDl8zR8uLD93iLxRH9BccCc2y0MlTXsi0bfTPGnVMRun3ff
 1d1gW/BAAAA
X-Change-ID: 20251223-fuse-compounds-upstream-c85b4e39b3d3
To: Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bschubert@ddn.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Horst Birthelmer <hbirthelmer@ddn.com>, syzbot@syzkaller.appspotmail.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766527992; l=1397;
 i=hbirthelmer@ddn.com; s=20251006; h=from:subject:message-id;
 bh=djrFm7idG1wZTyNavDvRaYpps8Oyojc9Dl+G4hxSw5A=;
 b=cuoM+ooNHpcZPOFw6ECsIXETrsbFwZBd67tkIq5LxiGHLLYq33ECLD+QLeyNWSbp9izjglb+u
 BLRt7auz+TyAbbwBffFXP5QBFyAIWCj6GVb7oOfSTAbEqZ1M4cha0o8
X-Developer-Key: i=hbirthelmer@ddn.com; a=ed25519;
 pk=v3BVDFoy16EzgHZ23ObqW+kbpURtjrwxgKu8YNDKjGg=

In the discussion about open+getattr here [1] Bernd and Miklos talked
about the need for a compound command in fuse that could send multiple
commands to a fuse server.
    
Here's a propsal for exactly that compound command with an example
(the mentioned open+getattr).
    
[1] https://lore.kernel.org/linux-fsdevel/CAJfpegshcrjXJ0USZ8RRdBy=e0MxmBTJSCE0xnxG8LXgXy-xuQ@mail.gmail.com/

Signed-off-by: Horst Birthelmer <hbirthelmer@ddn.com>
---
Changes in v2:
- fixed issues with error handling in the compounds as well as in the
  open+getattr
- Link to v1: https://lore.kernel.org/r/20251223-fuse-compounds-upstream-v1-0-7bade663947b@ddn.com

---
Horst Birthelmer (2):
      fuse: add compound command to combine multiple requests
      fuse: add an implementation of open+getattr

 fs/fuse/Makefile          |   2 +-
 fs/fuse/compound.c        | 368 ++++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/dev.c             |  25 ++++
 fs/fuse/file.c            | 125 ++++++++++++++--
 fs/fuse/fuse_i.h          |  20 ++-
 fs/fuse/inode.c           |   6 +
 fs/fuse/ioctl.c           |   2 +-
 include/uapi/linux/fuse.h |  37 +++++
 8 files changed, 566 insertions(+), 19 deletions(-)
---
base-commit: 9448598b22c50c8a5bb77a9103e2d49f134c9578
change-id: 20251223-fuse-compounds-upstream-c85b4e39b3d3

Best regards,
-- 
Horst Birthelmer <hbirthelmer@ddn.com>


