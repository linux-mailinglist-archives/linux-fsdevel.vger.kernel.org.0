Return-Path: <linux-fsdevel+bounces-34437-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 498609C56C6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 12:40:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 025001F227B0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 11:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85CB2309AA;
	Tue, 12 Nov 2024 11:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y5ZQj0XX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDE223099C;
	Tue, 12 Nov 2024 11:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731411597; cv=none; b=tgVJ53cw9sXnOUlnoaP2xUelDbZh6GsAfO2WmQoE+ChADw1lNXuVUZkoAj2O/IUbSfUkTu3r0gVbO0If9Yf15DiPPeO98aoh5iJGEy0+I/aDbeL0n/wKSK6XmRPdeqS4aEKuTNfB77a28F1s0m6X2T3MEWtS0mKQUI1KImpPBaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731411597; c=relaxed/simple;
	bh=l29njM0VLLj2zjM1LLVkaHz48P0kMR7ou0C+/31HP8A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VBzt8SG931iRqLTf9u4Za25kOS3lm4RLYbap/u74YExaPn03+n8kO5L1jvxHJOYlQU6fWJ+4x+48ybs8t8RUxn66o8cqaJ+q+he9dcTTVCRWFch/2DwrMSeaZYlObnzLbeJRqwL3z7DDfEFHli277H8TqF4qwiYsor7c0ZspRiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y5ZQj0XX; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20cd76c513cso46445275ad.3;
        Tue, 12 Nov 2024 03:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731411595; x=1732016395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zbpR32eMdhLZ9/UcHkTauMhtF31kw+5SFXtcGereRxE=;
        b=Y5ZQj0XXKl353eMM7b74g898jP9AIuG80YRnLjqYjXveelielalQpjNvQi+waNEHDW
         YJLUxQUsRxqS4u5xT0SJYuPTNKr4NeTyH/6jMV9DJmJIhE3YFZnChzaPzvVBLXC3+Ryy
         viPaZF9cAfcPUpnx+oirLaKd6+lQbVZ8zwP+lbsv7IHf/1UBl4Yg7npJx4y/L3TlYPLP
         yTxs3q1sMLp65LnXSqeCwJzueGfc6DfvwUrAQv+0d84+uGKrjiN2xuL0AgUn4kgpvhRv
         tk8QuAb9eOLbGm5uSI/MImPz+e+n5OGY3atjzoqTfizCSqdssxqHc07dQk8yDbcZnSnM
         egZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731411595; x=1732016395;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zbpR32eMdhLZ9/UcHkTauMhtF31kw+5SFXtcGereRxE=;
        b=XT4oaXbDay+WAvVqLbID2Vnfohrz+oCrp3jbXbSCNhkyaTtj+/oW2JUcFegH50uykk
         KM030ZX4IAnTE9/jy4BeUkj2HeEd86nZlB+CIu2693g4ixe8G04WjtOnaxHTL0pLf6Ui
         soipcyXm+iCYasxbmU8VoUmeJw7rV4usMjA3DTgjxzPtdeNBgOaNROFycJ5omeOpcV8A
         0nx8NrDBG57jHU7ebgxa85jt2b/t/h5im/u2hGUN3oNXozcXat3FGR/uEnDXJCoAtTvb
         0Ghy9E8E6dl1olZ22E2tiBwl0u1Hj1dONcC/tmQqVtIRnn47tLU3YVg9Lhd/6NLGUA6q
         gSFA==
X-Forwarded-Encrypted: i=1; AJvYcCVf+glwMd6ioyAoIj/t0T23UQpUHRdJ/FdPbiwPArMB/cYysIvM/5Ywh4jn/8/ZsNlQPrWoTpNq1PtthwSL@vger.kernel.org, AJvYcCX1dcPH2bIZt4Is5pWbXp6YY+88EAcPHBYTokyDK/GOuQBhrXoxzt4tBCyhhXzywkZFlRDwcGEnAVQs6o8P@vger.kernel.org
X-Gm-Message-State: AOJu0YxHfLBTAfXC66V+yVf3UhhBwlIMhPI/CabOH8306hEadEfvpEqg
	CaN06dL8BKeUUNvzeAP1z1qjy5DJWi1yPNBZtO3FqEO9bUDrs2LS
X-Google-Smtp-Source: AGHT+IEJUWnViOQdsutAsvxmLVA9eieU6zhVNujDU00xOJ4oGnlIL4fPfE4e0fjknXVIEC2gDlvCBQ==
X-Received: by 2002:a17:902:ec92:b0:20c:9da6:65af with SMTP id d9443c01a7336-211aba5f33cmr21703735ad.57.1731411595049;
        Tue, 12 Nov 2024 03:39:55 -0800 (PST)
Received: from archlinux.. ([2405:201:e00c:517f:5e87:9cff:fe63:6000])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-21177e87537sm90857905ad.270.2024.11.12.03.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 03:39:54 -0800 (PST)
From: Mohammed Anees <pvmohammedanees2003@gmail.com>
To: jmoyer@redhat.com,
	bcrl@kvack.org,
	brauner@kernel.org,
	jack@suse.cz,
	viro@zeniv.linux.org.uk,
	willy@infradead.org
Cc: linux-aio@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pvmohammedanees2003@gmail.com
Subject: [PATCH] fs:aio: Remove TODO comment suggesting hash or array usage in  io_cancel()
Date: Tue, 12 Nov 2024 17:08:34 +0530
Message-ID: <20241112113906.15825-1-pvmohammedanees2003@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The comment suggests a hash or array approach to
store the active requests. Currently it iterates
through all the active requests and when found
deletes the requested request, in the linked list.
However io_cancel() isn’t a frequently used operation,
and optimizing it wouldn’t bring a substantial benefit
to real users and the increased complexity of maintaining
a hashtable for this would be significant and will slow
down other operation. Therefore remove this TODO 
to avoid people spending time improving this.

Signed-off-by: Mohammed Anees <pvmohammedanees2003@gmail.com>
---
 fs/aio.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/aio.c b/fs/aio.c
index e8920178b50f..72e3970f4225 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -2191,7 +2191,6 @@ SYSCALL_DEFINE3(io_cancel, aio_context_t, ctx_id, struct iocb __user *, iocb,
 		return -EINVAL;
 
 	spin_lock_irq(&ctx->ctx_lock);
-	/* TODO: use a hash or array, this sucks. */
 	list_for_each_entry(kiocb, &ctx->active_reqs, ki_list) {
 		if (kiocb->ki_res.obj == obj) {
 			ret = kiocb->ki_cancel(&kiocb->rw);
-- 
2.47.0


