Return-Path: <linux-fsdevel+bounces-14914-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C056881750
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Mar 2024 19:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D496FB21DBC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Mar 2024 18:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859E36CDAA;
	Wed, 20 Mar 2024 18:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ClG9T9QN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FAC96A03E;
	Wed, 20 Mar 2024 18:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710959199; cv=none; b=m4T6paEWSXgE+J1x6mVqGmL3cjzClGr+t8AZ1klQ02wIQC8G4LOirVrx0nL3OM/DRxhco2QAV5bcv5PODM0wMicevprMTSH5ODfvg4uhFL9Lq0prgaWxN2jwqXro9LhcerJdTDLjo/YJa++zQk7LMFFOZLGcX0kTz1OfayLve3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710959199; c=relaxed/simple;
	bh=D1LXc0UmUagZVPqKr1Rh4M2j2+83SmyrSsFiinK2Gn0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tppC1Rn8r0uAHinB6r2T2WVrrMDbf+utP/wlivq1xMunkciiMetlfAK66tPOr1stMcwktVSBPqWxwhIPsh3s+BAt47txdnK9FL2ozME+6Gb0sOyAayFpitvYJJvBOliczWBgHRRPLlBRB7kBddk7+Dqh2psY+6ICdt/0hD7EXUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ClG9T9QN; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5a470320194so70956eaf.3;
        Wed, 20 Mar 2024 11:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710959196; x=1711563996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8B7P/zRiu0s9e23bBiGTn371yzLAFaX1RO8T0tzOVR4=;
        b=ClG9T9QNaF2d2HvKKqZyCV3yWTWAxX92RL5kbFoNpqxtuJ1G9n50fCDnCdrYCmkZz2
         TgOtKJRyOrWOhQ4TPcnfxQpLaKiKZInksxwG3lhFCMxo/P2GUaKMcnhqFG5aQwfo/VnI
         3wPxf5KYtBDsMZexcZv50pwfLovfEckdldNBAyrhQvWlNmxh1V3Eb4z82GVLtPn1nxxh
         lghax66nR2vL0LSqO+TlHmsEwi2ouPxdqICuvniANL6yt34h6Op5DRSZzh7B9QMuhXPa
         pcuzgWKvbb4FM/fLng3ng2ZPSfKY3v9iWkr3XvqqnMfYSZ+4f8DV5A2GVVUoZ2s9YuEs
         7erw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710959196; x=1711563996;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8B7P/zRiu0s9e23bBiGTn371yzLAFaX1RO8T0tzOVR4=;
        b=wb0SFZdRIvJ4o4Tz1XEde+Xre6XaYrzKZMa36Cmn/1V2P/c4KsE19Gj2uodHgv/+xA
         BCwI2hW3lxTF+Afk7tqNZRFw/GQbCnwgrjGBFJoXUnKBIVmTKeUMgKxIB43Vycp62z9M
         ugV3kYtjugJTk0N92n2ZaF1LRVtWitrmW21loeDSNTmqfs9i95uBjSLtKRVpHkjTw809
         k6VqLKqWJSTMaoG5+b713+xKAupOFkIBjsoD2gF+nUXWvgz5TQhZDLmGJp38aFfENMRP
         OB9RQ7lmJ7mQSv6GK/SXtOznGI5NdINiLsVIADEkzRpOzWqny4I6rKSScZ3i/HYU5NLN
         9dtQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUIk1hSH9e7wt6uw2/GuZ8gYTbWPk4EGBygzByKk+Yp4AW1/Ffrt4Tuz4wFjmBM1kJm5udw0TrPYD3kuR7sjE75m/zAVP+iaVMAWjjX6Vt328NM8bzG0p2kPtXQmJzlohqBpIaMg==
X-Gm-Message-State: AOJu0Yw9AXI5NBhSUAQ0vz8IfPiwIlUwWW3xKHEzh/VSQ4d/otL6fdPt
	naK4b5HkpbhXwrj4oAxflTaIIX8x/io/2LeeOm49WqQUT/n38OP5oC/5fvF+
X-Google-Smtp-Source: AGHT+IEE0OoJUKSUHMpvSdcMuTsIv8qJSqKoDqQqd6beQBy3Y/6x9dVKIRV+jdBEc2+m4h/rFRMqTQ==
X-Received: by 2002:a05:6358:7f1a:b0:17e:c5b9:5f6d with SMTP id p26-20020a0563587f1a00b0017ec5b95f6dmr7427978rwn.14.1710959196191;
        Wed, 20 Mar 2024 11:26:36 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:646:a200:bbd0:b371:84ee:dcf6:87b4])
        by smtp.gmail.com with ESMTPSA id h62-20020a638341000000b005dc832ed816sm11209679pge.59.2024.03.20.11.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 11:26:35 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	Eric Biederman <ebiederm@xmission.com>,
	Kees Cook <keescook@chromium.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Rich Felker <dalias@libc.org>,
	Max Filippov <jcmvbkbc@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] exec: fix linux_binprm::exec in transfer_args_to_stack()
Date: Wed, 20 Mar 2024 11:26:07 -0700
Message-Id: <20240320182607.1472887-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In NUMMU kernel the value of linux_binprm::p is the offset inside the
temporary program arguments array maintained in separate pages in the
linux_binprm::page. linux_binprm::exec being a copy of linux_binprm::p
thus must be adjusted when that array is copied to the user stack.
Without that adjustment the value passed by the NOMMU kernel to the ELF
program in the AT_EXECFN entry of the aux array doesn't make any sense
and it may break programs that try to access memory pointed to by that
entry.

Adjust linux_binprm::exec before the successful return from the
transfer_args_to_stack().

Cc: stable@vger.kernel.org
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 fs/exec.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/exec.c b/fs/exec.c
index af4fbb61cd53..5ee2545c3e18 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -895,6 +895,7 @@ int transfer_args_to_stack(struct linux_binprm *bprm,
 			goto out;
 	}
 
+	bprm->exec += *sp_location - MAX_ARG_PAGES * PAGE_SIZE;
 	*sp_location = sp;
 
 out:
-- 
2.39.2


