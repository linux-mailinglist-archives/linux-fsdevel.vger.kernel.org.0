Return-Path: <linux-fsdevel+bounces-63328-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EA54BB59BE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 03 Oct 2025 01:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2085484C3E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Oct 2025 23:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1724528C87D;
	Thu,  2 Oct 2025 23:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xts0w2OB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D74289821
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Oct 2025 23:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759447430; cv=none; b=jP4O1DZyDTJHgtpdZBJJU/cdX/Y1D+cyQtpjsgQ6VaK9QfYQ6/zdNUmkjhQzA9iN1+aCXNU12bk0ueXVfQpaRG7g8LKFSQkVPpsZpTV57hOjrdU+9P+5LOlVvUgeV7Os4ZhoYUWkAZX0J4ZrZYVn1U7EGtWKik5ZiKMFTZpRI+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759447430; c=relaxed/simple;
	bh=nOMVwT72cCpGcGX15qYmwGV4jcaP3lFEyBnC4b2ruHw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hsCXgNI09ZTM+JJQxSJrNHiy/ZhfP+w/Q8Qo0uNK9DAitee8inswvsAzZnGREr41WpfShZTf7zAxIryCDBAx0Wg7cRVI7Y2JQeQYcfCkPAYMyUNkGDVwAWu3ZFCzGURAzOqCaRwaIfrkSWsOKb+7TTcvcd6M2DuuZKOCbY4TIUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xts0w2OB; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so1360137b3a.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Oct 2025 16:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759447428; x=1760052228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Uvy7c1caOkRuXqR4gTnvA1e7HoOq2YmnWX/AduSHR6I=;
        b=Xts0w2OBRkl4axRxwnizKAGBkr5+9nbadFLuUATvCE2F8JeAEo9mheBkx2+A2eZVPI
         AviFr2IdJHQz//lAxd41/iQDjZY7xna+gHjkF6RcrsYxqK5RE1/GnRgDHbpSftKT7a+h
         z6IsBwJW4U6dXI93pZflGNv16opYi7SBaC7AQXZfTg0b/qHB8t+OZkCmeFHBVjRmm1X3
         qCL5GBCBrC9xLKCSWoMgvbj+GEDj+/hR1Xn5cq+tI1Ky4+6Ksb+U/L4lHq9L5Nrh47O4
         fN1u6v9Pk6dVDh5esrQySslU8nzMcdaSrb2x0tMLVHQ+e1/XEh/kx3HUhNHTjTiZc325
         H7gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759447428; x=1760052228;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uvy7c1caOkRuXqR4gTnvA1e7HoOq2YmnWX/AduSHR6I=;
        b=o51PIerDWrBDMqYWoArAo2QEsujxMZqFJtztw9E0wlmTBua9Uri6Ocq70AfKMcU53p
         YF2B1fTlZLg6i4LDU5V73L+OImQyzhEkjKn6P79QiuACgdDVhLfmMpP2Drhu5yoEZqnx
         5xlAA6hfqRw7GwGp0ZUIhpy8U0v5yQFl77PwPBZqR2vrkQoKDX44FLj7XE3b4hBz9eEI
         mE5KySTheU4RWHjXbZrcbDb8V9MfzZ1MP5pShbDhdjgCXG0HzEcTnoy3UP8ELd/Sc3nQ
         51wMPiPD74uOPKkqP2PPRaczLM6iU/zZZCgmo/32q2UevCOAHS+d31VpaXF3A7XimaIh
         IXRw==
X-Gm-Message-State: AOJu0YwIJ+v/L2TVQLWP/PMcqhtSuZn42jnSVK/ZVFZ6+5I709XXXBr3
	lkEqkoE7ZFokUOFgdJYZw5/0KsqVerwvYSxxIHqTZZefikIbka+zbjDTenmboWo/
X-Gm-Gg: ASbGncsMTRzCm6tXLLvMbxWsSdsliWOSNrtAp8ouY66Wh11jli3Us5JM822rjWeo6+i
	wmX6S3RG0a7gbaBuRbosX1j3oFLGnymUvI+2NDbLRtQ3M++SAlOdy6N2a/g4E7GM2B54kb45EAE
	yJporMbfjiI8s5LCxsFtbq1mcQiKA7xp64VzCWai26174snyoXfb9hb8cmCSUAeNGr4dLMKFIJt
	G2WDTQwgRitczfea3zHZhWpKbBHgq3COuWEiA/J7xuWcWOhsQv7bhO7pRM80fKRBt75JCHb/kji
	wnPuc/L/eikZefVEcrdu7BjU1wTQs2+oeCbPxCNxRfP0RGRF6uDR7st18Kq6pKsz2yYWfSNlTyK
	GHPtzVO6wxM+7ZxDzSnm7DmFNfhUH0BOqhXqNCuqprOENbz8JyePKNQCzhxwsKC/C6jYhsMccEb
	vjCefOLsxF0z2f46UeMdz2omydIA==
X-Google-Smtp-Source: AGHT+IED1715mCa6muA00tzaJAIUYwL/txfIyf/f+YjgmKfe9Jg3tH8dykIAwOJr5bWJwjqUHsB4xg==
X-Received: by 2002:a05:6a00:3c94:b0:78a:f4e6:847f with SMTP id d2e1a72fcca58-78b0220510dmr5840731b3a.6.1759447428451;
        Thu, 02 Oct 2025 16:23:48 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:389d:38c3:a5e9:d69a:7a4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b01fb1902sm3148802b3a.31.2025.10.02.16.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 16:23:47 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] isofs: fix inode leak caused by disconnected dentries from exportfs
Date: Fri,  3 Oct 2025 04:53:41 +0530
Message-ID: <20251002232341.2396110-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thank you for debugging this properly and providing the correct analysis. I clearly missed the actual root cause. 
I'll study your patch to understand what I got wrong.

Best regards,
Deepanshu

