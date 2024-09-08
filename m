Return-Path: <linux-fsdevel+bounces-28908-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA2E97060D
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Sep 2024 11:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96F6C28254F
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Sep 2024 09:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DCA8146A96;
	Sun,  8 Sep 2024 09:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K/Fc/ul1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA9A1B85DC;
	Sun,  8 Sep 2024 09:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725787671; cv=none; b=ui2dgaVH17/YvddDJeh89FqH1rvCak1Mra2mo/ikgyzxDkZLW+nnb3R8au/O+2cY3B15WAv6wQyRLflMsAAJhmFR7Horh9j7pDFm/9Nl7uLRJv22r5IRLdpTUvOCgIYsV2yLu6LB7d0w9UhEr4gK9bUz6XQVBTpZQRI4aPfxO+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725787671; c=relaxed/simple;
	bh=vCkW6jzRHY2geB9TlROg9NExkkVvGa+4Mp029GMoc4s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VPHuP4jnYdsDnjdif3RL+0hbL+Jp1FfwQkE4SO1UiJpxd1wPlE4ROEO2zppiPm0YINUDRdjnhYgtSB5Ga0+HYeh0osxaKfoNLohxc7HLMqA5bq14AFked+8TBWS/OUnB9XyTpl98Xg9JWZN4Zfyf1hya/vL6RDadHzk6cxGTzIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K/Fc/ul1; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5c3d8d3ebbdso4633811a12.0;
        Sun, 08 Sep 2024 02:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725787668; x=1726392468; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sMIg3Phaiaih7OBmofRKIXRXo86YxKJvUDO8CKa+ZDE=;
        b=K/Fc/ul1OSCcecqsfbGqq0QgsBazVZ/Tidlkjirwq/f9aPCUd7Pq8nNjIwmaxSg5Gc
         Lf/b/qTFSHO0kbaFfvadI0+NWIhN4pI4RRJgDsvydFd80l7HeTQz9rgc2fcPFcR61BHe
         BsZf4f9pYXQwswcOg188rj775ZdEOlHSd5pAWyP4t2xd1k0gFMsymBNOB4CbvXlts5jv
         ftaNEvjKxJJ8eYbvv3THZ2zFN+5oC++AGzfPgy7A6ICkEt/cs6x2hManpeA+4nVhUMus
         jUFjhwsvg8pTtDz8siT6L/NFkBMSYX7ORlb9gDyhV0KnAEe1Nhj8/Ff27yxEJF3djLnt
         ZdGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725787668; x=1726392468;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sMIg3Phaiaih7OBmofRKIXRXo86YxKJvUDO8CKa+ZDE=;
        b=pGvzeHInXYyzXPgnxLX5CGGuybEYVCgaELyM7T2iXOQbiLS3JfbZFrZ/wSOMCioZVL
         RWN2vdxXwjdut9V6MM9BYnsiavizo1gFAULT5IRwrY/vNi4VmtdmKSwim8XgRFqvEA/g
         59FPatnHakF2vf5EDNrUKWFOs6Ylx3JUgDLTTVXEtm+f3zX8oVoPaXlX41TaVlihfq86
         5+1jl6httvf1vK89ox62cTpkUIWjIxoxssnPx2tpbeH8skJgZWkpiEsn4n1RC9JDMpru
         Y8Y2tPqA8KeNDHH8YfDe9NepL8OcIWWwIH6Kt/e7fFzB07JpEPzVgCJXgivZi+Lbjlld
         6q7A==
X-Forwarded-Encrypted: i=1; AJvYcCUae0TCAH/ZRa1ImU/BM1egzIj5hPyuanRs/m1FHgl6Gbn7+xyJInuIYrQAL2xW2Ajq1nqn1ly6i/735UiP@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu1ZfdBYtzeDFiyJ7D2pvPIc/NnldAMNl98sTK8jD1wINCw/jd
	1XgUIgumdayMXgLwQH4HWYeUch4CvV67BQD//kFXL3ZTxzFji3VwVQA8
X-Google-Smtp-Source: AGHT+IHZF01SXR2omQWh99Kn9B2X+7iMBsoHVgblIh1VccS3gX78f4ZrWTUZlBzOwnQJyytB3+c6pQ==
X-Received: by 2002:a05:6402:51d4:b0:5be:d595:5413 with SMTP id 4fb4d7f45d1cf-5c3db967a6dmr8639017a12.3.1725787667858;
        Sun, 08 Sep 2024 02:27:47 -0700 (PDT)
Received: from p183 ([46.53.251.102])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3ebd424e5sm1588913a12.10.2024.09.08.02.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 02:27:47 -0700 (PDT)
Date: Sun, 8 Sep 2024 12:27:45 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH] proc: fold kmalloc() + strcpy() into kmemdup()
Message-ID: <90af27c1-0b86-47a6-a6c8-61a58b8aa747@p183>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

strcpy() will recalculate string length second time which is
unnecessary in this case.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/proc/generic.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/fs/proc/generic.c
+++ b/fs/proc/generic.c
@@ -464,9 +464,9 @@ struct proc_dir_entry *proc_symlink(const char *name,
 			  (S_IFLNK | S_IRUGO | S_IWUGO | S_IXUGO),1);
 
 	if (ent) {
-		ent->data = kmalloc((ent->size=strlen(dest))+1, GFP_KERNEL);
+		ent->size = strlen(dest);
+		ent->data = kmemdup(dest, ent->size + 1, GFP_KERNEL);
 		if (ent->data) {
-			strcpy((char*)ent->data,dest);
 			ent->proc_iops = &proc_link_inode_operations;
 			ent = proc_register(parent, ent);
 		} else {

