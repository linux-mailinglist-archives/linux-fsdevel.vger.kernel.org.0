Return-Path: <linux-fsdevel+bounces-41100-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B33A2AE70
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 18:05:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DCC6188C072
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 17:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D68C7237171;
	Thu,  6 Feb 2025 17:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gu38IcDN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5523238B73;
	Thu,  6 Feb 2025 17:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738861406; cv=none; b=ubkGMF0i8C+yCElf0nShJh9dlehjBKLWB8TPYxPmZgIti60jANDc2r1Qw+PIKHt4nF8xnOsO7qfve1I2kpIeonBYp27xLMb0+Vw5TbQnZvlAZPRCOql8pwVveAwEX1M/z7FPfB0E8nfqNP/ZtrHJnnRK/AvwG1E0ggHsykMm5MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738861406; c=relaxed/simple;
	bh=4bGNyjfePr6cLfEicYz5bD4g9j8T0BUJf9j7LFKGCEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tAmNiDENxrLrWZ5eQKvq4IpLSdOsTUgdCl8b+Gggi+QiZUHwv98a5y2KhoKPKxUmaft9CmgLYEF/WV6iXEMCdyapOXKXTULFl0SF250iNG+8QoeqVMqsjRbzU3tf1ljZ1USzc33SNi7ACaTZ4XqhYqyLTeRGMrT6aDhml/M3Amo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gu38IcDN; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5dcef821092so1375969a12.0;
        Thu, 06 Feb 2025 09:03:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738861403; x=1739466203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FEovPneKy6UrZ39w/lOvewEqfwBWVAMdy5819a+Iq1I=;
        b=gu38IcDNkm3Xo8geR3z3Kh05CvDc5HXN+7q9UI0sksnpnVN/tu3IM3RrkPIGvXUE3P
         3X3R4YdTQmLkL2Nqk8FY3KpNkvWaMBOkuS+3g75cqbdbyOUCGfoiUUutfYEjfTYwr19c
         c+Wi6xqbRcqulyh+6ZpgY/+HLas8kikimmXVltxUa8IKsV5u0n52/r7tQ5Vwx+u/LQOr
         iTLxf3QJbu6BGxoYr0g/MXv6JobaYYCPlgaZ1uqcdrtryVkA8/pg1zINwXhQ14MXo7B1
         +frwEqGqf48Ipu0yk0q00jsPRsl/c8DXoGZPPyy+U0nZRCmg974VYdvUFqdeyyDSl6q6
         Q7TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738861403; x=1739466203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FEovPneKy6UrZ39w/lOvewEqfwBWVAMdy5819a+Iq1I=;
        b=M+wUFHRtghgcF2eIelN/lyNVyCv4g7Ud2oYmAObt3Q5QpcmThHD+yeIwSTBvC3mxY/
         39JK0EAwblSgygbAXEsPB1saOTIbwOumeqPR7y6Ptbe7FgP28MEUF0SFx9L3uuQMo9aX
         0sZHOExtQ4tfThkWMwR2+Xu/sSHhRO202sDVJKHwgNf0F1o+LgDg6g2G8s3WXrWaL0yh
         aabOB6Cdb3okbxwS9qaGZd/M809hRMLGZL0x4HWe7NIMVXR8hsIdfvTP1crTHhBF8FhS
         76AbzwJMv6pG/H9pNbFaXdVHXyLOhCsLm5CCX51WMyEp+MIlzr0mI0SkpQiOsll9o9lT
         XBZA==
X-Forwarded-Encrypted: i=1; AJvYcCVHxxzku2+dkE4ANYyWM72icMH6zj4CdO0phb6mZO0Dt5vyjWA+odXaFQgofG9NPHpl9wTkRN05uuAPmldc@vger.kernel.org, AJvYcCWqDltNFag5ogUQOn9uk0aaA5osVIYFDcOHaSrEKCtD0bQmdJFVc2cunw8zaRxjstuZSaa8RQbFFZJXltmW@vger.kernel.org
X-Gm-Message-State: AOJu0YzcF1MwqmtItEiZwuDkRUy18SbueAZhMZLUU1VkKM0WgLZw/a+L
	ADnpptaH+6T9inJLmWmQHIlrGzJSe3CjgTQxY9/oWNKlhatHo3pr
X-Gm-Gg: ASbGncsX1SCVPv2sRGJozwY6EAoIdVnu7BUL8zqQx9mHK3auEtJ6OUbXgnKLI1Ixuae
	3xwFzo9EWE8sB9UHeOoY3S40D8aWGnF4ahFfrGJFZxiMHChB1x/fzFh/ouqxZz0UUykjNqVN4fJ
	ltmyIYpzQYCB4x54PX9oKUy7UzTFPAXzwg+jRoUFAim15C25M6cs5oDaWMOKZOeQ5+oS2tVIwDZ
	SyiFGMmHAtjnIy0IzWySOrnJSGBPXD9MYIpomLTA2Yyf2lxN4M1Y5LxmPoR4TkuKwa8WmhmnSAR
	WC2d1kf/Oa9Pg74MIAGky3D3hTzGs68=
X-Google-Smtp-Source: AGHT+IGQwNdshHD081tWNYQI/DvmUmpHoi/6DCNjKUx5MrBc6+fl91Og1Q2YslRTGiFHV2X8apgNlg==
X-Received: by 2002:a05:6402:3483:b0:5d4:4143:c06c with SMTP id 4fb4d7f45d1cf-5de450734c8mr102741a12.23.1738861402587;
        Thu, 06 Feb 2025 09:03:22 -0800 (PST)
Received: from f.. (cst-prg-95-94.cust.vodafone.cz. [46.135.95.94])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dcf1b73995sm1158110a12.7.2025.02.06.09.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 09:03:21 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v2 2/3] vfs: catch invalid modes in may_open()
Date: Thu,  6 Feb 2025 18:03:06 +0100
Message-ID: <20250206170307.451403-3-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250206170307.451403-1-mjguzik@gmail.com>
References: <20250206170307.451403-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/namei.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/namei.c b/fs/namei.c
index 3ab9440c5b93..21630a0f8e30 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3415,6 +3415,8 @@ static int may_open(struct mnt_idmap *idmap, const struct path *path,
 		if ((acc_mode & MAY_EXEC) && path_noexec(path))
 			return -EACCES;
 		break;
+	default:
+		VFS_BUG_ON_INODE(1, inode);
 	}
 
 	error = inode_permission(idmap, inode, MAY_OPEN | acc_mode);
-- 
2.43.0


