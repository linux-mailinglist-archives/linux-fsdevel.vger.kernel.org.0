Return-Path: <linux-fsdevel+bounces-63175-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A0BBB0653
	for <lists+linux-fsdevel@lfdr.de>; Wed, 01 Oct 2025 14:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDC321890907
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Oct 2025 12:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086982ECD01;
	Wed,  1 Oct 2025 12:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QS42QBIZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A782EC543
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Oct 2025 12:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759323377; cv=none; b=ASW7T7Abf6BF6garcx048qidFguf8+P2uDQmXQXXuLWdhdaEwql51wsd9FuQpsC7bdLuaoQLTfZ1JXHIaxxMdAcWWE53lhjQAiyRNEPjV9APE/WxAWBIuHk01Coc29Hlz59QBVCLMT/+fqXeku8vXDMIYPO+l0cdAm+OR7SWnY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759323377; c=relaxed/simple;
	bh=e48hKC8RketRNvnBJqh9k7xnd0M5kkzlY/ow5Minm6s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mF7HkJyGkp4Z2HI83a5nFitUurHJLpfMD6BJoEFIWVKNyP3697vnz4IouT0CTgo0D5ZxhMf6xkrEkLmKhoaDGU736vunqVE/Ha+6r9MKMFHSMKRjYTmK9sskAh85H8dIr+I3XIh3CpLYaIrQTjLJf/1nAwGTpuOOxGxR2lfQK1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QS42QBIZ; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b5515eaefceso6941405a12.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Oct 2025 05:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759323375; x=1759928175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KuZd43UueqoDvh56cTTI9JpLcE20lmDhoJuxtDXLHxI=;
        b=QS42QBIZtDZ5eY8wzMDqsa3/7DsMSB2a6yFDbTqW5v86hTS9wixDTqEB621hYcgwbQ
         eOF5cRDLYbpKunDD+I9pFqS2eOO5q+jvSnrZ1mdYCb9mmTlJDFMufDD+wGv30amP3bMD
         K80ux+u13BqCcjZ3Rr6wi3A009UXtsaa5tJLgdXvrfwY/XDMox2Jnpyl4Q2AYgt5BSRI
         mP1rjGWDGMf6i7tcfO2um87ufp3Z1PrmiYfLLS8SbiIkTF4G0cyTIau2QJVC3msvuk9h
         +ZtLXtDMLN8i2ZxbY9qn18zXlKOAIa5ndnSAfdQKhkcMdJrEaaPFz4ItVQ0CXNPHzNqF
         2Yig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759323375; x=1759928175;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KuZd43UueqoDvh56cTTI9JpLcE20lmDhoJuxtDXLHxI=;
        b=tjC9WgNfUaclux81FBM8DJ3QRuoNehkb04oEIaISfinnLqf1EYdk0cz3o2y6g66I6d
         td9i0z2o7XcmKawwcUnwtGwdfgnDFBKg7uTqoi8M5xrF/5rLBV1peqV5mgyNKdIuw9U5
         GwxXpr+OpeCgmLsWO+P5jSzC3RuGjahhb2rce+N+R2AhdBGQK63e18AQvJGw/C1juiV+
         dwFweqVkdzbd4Yc7ciLx5g0uJXvs1/p8aH7QaHIwTvlXkzqO+preexVmYOx5SQhV8d2o
         +epcM0HM4d5VN6W/gJwM9ckEvSsGuAYrIA4oI8Q+rR0uT3fxleAgp2YlUMa7uCsOUOD6
         40BA==
X-Gm-Message-State: AOJu0Yw+ueYUGMQyMfGNuz+QBVvZZnrtX6o8UZ460zma9puNJNp9HAY7
	iMMt6oexRd3yee/QQeru/8JIajt7fhyvRGCyjxB61QAwtZboCJLBFdW3FtjHLw==
X-Gm-Gg: ASbGncusj+0H7jveAYmYowzf2zCHjqUbhiBGgw2mjW+Ev1yCTucrAqcgDrwRYkU9sYd
	bkQ5/BTsMWVvH0uoYCcTDUZ0Bxe63jI227eXPBhZkldrfIR+tToxKuq5Uiv5ojw9hKIOdPrzlHx
	bmQourOAs4xn4D+wI+Edw+AmC7GgNtGYlV8K3WlDttRTvk7H4xy1lcygEQG17TSn5ReSBeVTc+C
	vPxHQsv3ZXYjdGb5Z9Cxrf70TeiYMKMXp+F8kqQELBLrd5OB2urdAdBnkjccatJtFuYMqwcmQSi
	2Xl3STbTfeIYUCP5XHFzkSpcX9epak8Tl/WnVXagG4T7oW5AHMIEfdQmkXkf1vhQKiN5M+fXd5x
	YwI3au3yE5SwOIz5LDEdSOaH9NRnVyt+L7ZFkSpY77vGEG4FEIImTtqxTDyjVihcHIMfhshZ+JF
	aZ36/MqwnKVrZx5Pgzmm9AviFRtbw=
X-Google-Smtp-Source: AGHT+IGUyCWta2IvOu8FsxngQaZysc18Q7e04rBptGtsy21turuP3/XM/YDY7rPXcnNKuZ/akNFxRQ==
X-Received: by 2002:a17:903:380b:b0:271:49f:eaf5 with SMTP id d9443c01a7336-28e7f3117b9mr36640935ad.30.1759323375139;
        Wed, 01 Oct 2025 05:56:15 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:389d:3656:da13:376d:baf4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed6882204sm182615715ad.72.2025.10.01.05.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 05:56:14 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] isofs: fix inode leak caused by disconnected dentries from exportfs
Date: Wed,  1 Oct 2025 18:26:09 +0530
Message-ID: <20251001125609.1792081-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jan,

Thank you for the review. 

You're right - I need to investigate further why these dentries survive until unmount if dput() should destroy DCACHE_DISCONNECTED dentries immediately. 
I'll add more detailed tracing to understand the actual reference counting and dentry state throughout the lifecycle. 
I may have misdiagnosed the root cause even though the fix addresses the symptom

Best Regards
Deepanshu kartikey

