Return-Path: <linux-fsdevel+bounces-60638-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A55CB4A75B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 11:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9A4A1630BA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 09:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 249272C1596;
	Tue,  9 Sep 2025 09:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D8gUuABu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64EE2C0F60;
	Tue,  9 Sep 2025 09:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757409270; cv=none; b=dGkPubjbkr6GRtDN2WOlqSpZMUweK92QDcC6WbP7C1uCvRe3X5r3Zibty3c4TQUmMyLrzfuy1PewHRlPB32Ndli1mFmZy3Wcf83BCymvpxps6i5NnFVu2Yg9d7MbGAci2+vU+GkevQd6hDJc8vRfbk6+by9eTD2wwgtRxRC6SIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757409270; c=relaxed/simple;
	bh=eRFMjyzp2oGycBxV/BqaSJ27ZRWUJFSdWHeBZPduE80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZX6Wna+pTOZNvAjLLrD3AEv1C5efQNoj1I4urDJ8DLahRc/gXlCAtqV1lLHS6FHXTpWSUMPA6zvnMNAB9fGsjdGydIHIGkUP+bMXVA2gTTqsKllYV93T5Vofb/PVXjx205n4Em4itEXqQrDOnYel5O4amufVAlNngnJHnujIZIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D8gUuABu; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45de2b517a3so21065125e9.3;
        Tue, 09 Sep 2025 02:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757409267; x=1758014067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pGeEYXDQB6umQx6HKeL3+YR9XaxrRRDu5k2GywHVd3M=;
        b=D8gUuABumcsFqpa6fO296ipgDHBDdxnAUX3WM8P2aXfjPzZ58CsaP1GPTLTrka1DSm
         0IuPHkLRZTUS79NlfSuR0naI+yh1xzYx1O0nEi1qUSht+ZKRrd0CDlgNKbLyJaOFUa4U
         AUSsKrxtKK9g66sd79xo7tdxl+5lZdIYbRDjQB0xcBmABAjjEllgG6zVjDLv2QqzWBYY
         3V70B8nyPb1ZkhUXvcN1P9G3OL0VsyW/yZ+4zVeu2+zEw5/F55VNUatsfTe7Fx1rCVX3
         HWVcG2ehuzsn/NdwxrBGmuZV5l6VWDxcQXFbW8BRlz+weYA054EZ5G0p5OJJQsZYQHvL
         SYyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757409267; x=1758014067;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pGeEYXDQB6umQx6HKeL3+YR9XaxrRRDu5k2GywHVd3M=;
        b=ScHr37mXJt1YJ9Qp2HaIdVZDDKRbDIRVTWs20770tSYIqymZyj/uJSoSJzpH65y4j7
         DskKQLMtrc2TgrI8Cuc31mQzb1BuIv2c4K4f6vB6m/ATvjTR8b0xdMIVNul3aj8Md7Hz
         bLW6hKdo08vtUNqFRXBBu232qKn9ycMrgxKPXvbpg/u1AZt1GzcL2cTPN3FjWG81tVDR
         7VjjbN+ut2MvNPbjUnbX4Y45EPUXpMq95Cmh8mxZSJzBHcy8X4pu0A/H5YrjZ8EkVw+x
         FsiknqxgGNj8OzJfC9lGR8zU2Vvy8Gw0tc2qDX6HakPK7X828kuGkEa2037HM+DT33EN
         lynw==
X-Forwarded-Encrypted: i=1; AJvYcCUuDwY7MxAeMrHFIK0RliDD87GtIAhIfO7upyaQNHdHn16kgJ8pYhihmRtgISSPy4kpF9WOGNYSHi2z6A==@vger.kernel.org, AJvYcCVwSaTaIPV7a/uTymi2HhI4tRd9eDYhWOtFMej4oXcCnWQbfjt9IZyEL+ONLGxkC+ofzMYHbuGJJvto@vger.kernel.org, AJvYcCWD7cW6eq7yDi/pHp2NbjZ0TGCSXZUC1czr6Mgdr0Zq/uww4bC8Siwi/Qwsmb5TNUYaQpP5IsmCXJkeJ7UF@vger.kernel.org, AJvYcCX8hFYPPcf78grTmlXMNhBWKRm8EC2iJcomktIhDomweoeciU+1Jf/vQFdORFcnI/fCK/eInXiMrsBN+WNJDg==@vger.kernel.org, AJvYcCXNCl7/hjOKmiFx3LWB+FKnZscxWTG3Ys5jmDCqI/k7Vu47iTFDGjaXbjS2TNg0Pd6WTePto6rXQti9dw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzKJ4CYLKtPV7OIgCIVafN7HMIZF8jm1L8eMK0wDbMv0gnwmlr5
	DhR9mDfaTqEIpPXocsHIRoVfrvQsBx9QoszluoijC5uuaEqamT9OYIdO
X-Gm-Gg: ASbGncuT5b9oieGekV7FbazBWQLRiE2xKNcZFngab0Iccog0mUpO7LHRDGY9qSueco4
	JKeEXnHpBx8PhrqaRvAyjbx/6yeAd4xLV+52O/ROea1JKED9KhUiHIekAeQ/P25Xc+oIiWuuVct
	/56UwqROmDeOG0RKdgat1C236tcZkobetLN+O8yi+5yAYt0y8RFCuy60UpXZwa8Tg2ZU4s4p6eL
	P+RYeAuF/zUBT3k9Tt8ZmVAgD+fbvQ+WusgTl6bjl+fjp7csFE9Qt2L8yMvtDibCtk/RAB7PH3F
	J/MOcmlq+0DtSwYIhGWQ+2GsxqwfUVOMhI0A8ifG5HCS7Fr+fnZfaJxraBc+vxyS9KmxVfSheDC
	+HHbjxeClFhqzxGhwWeYm/h6N49y/nvV0NG4f9ywf
X-Google-Smtp-Source: AGHT+IG73BUdVqF7npmnaqNpM6L2M9vasLYgSIvBku9zwGGD2nanT1deNZNWSqsd32FJ9AMUZgh3Vw==
X-Received: by 2002:a05:600c:1f11:b0:45d:db2a:ce4a with SMTP id 5b1f17b1804b1-45de07ee7b3mr93383135e9.9.1757409267121;
        Tue, 09 Sep 2025 02:14:27 -0700 (PDT)
Received: from f.. (cst-prg-84-152.cust.vodafone.cz. [46.135.84.152])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7521bff6esm1810784f8f.13.2025.09.09.02.14.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 02:14:26 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	josef@toxicpanda.com,
	kernel-team@fb.com,
	amir73il@gmail.com,
	linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	ocfs2-devel@lists.linux.dev,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v2 09/10] fs: set I_FREEING instead of I_WILL_FREE in iput_final() prior to writeback
Date: Tue,  9 Sep 2025 11:13:43 +0200
Message-ID: <20250909091344.1299099-10-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250909091344.1299099-1-mjguzik@gmail.com>
References: <20250909091344.1299099-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is in preparation for I_WILL_FREE flag removal.

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/inode.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 20f36d54348c..9c695339ec3e 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1880,18 +1880,17 @@ static void iput_final(struct inode *inode)
 		return;
 	}
 
+	inode_state_add(inode, I_FREEING);
+
 	if (!drop) {
-		inode_state_add(inode, I_WILL_FREE);
 		spin_unlock(&inode->i_lock);
 
 		write_inode_now(inode, 1);
 
 		spin_lock(&inode->i_lock);
-		inode_state_del(inode, I_WILL_FREE);
 		WARN_ON(inode_state_read(inode) & I_NEW);
 	}
 
-	inode_state_add(inode, I_FREEING);
 	if (!list_empty(&inode->i_lru))
 		inode_lru_list_del(inode);
 	spin_unlock(&inode->i_lock);
-- 
2.43.0


