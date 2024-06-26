Return-Path: <linux-fsdevel+bounces-22544-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D413A9198CF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 22:16:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6630FB21E87
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 20:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E4818FDCF;
	Wed, 26 Jun 2024 20:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C1Scr18s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA57E15CD63
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jun 2024 20:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719432963; cv=none; b=P1BheZZB2nZ8fBgZJ0cYKe73MumeBNmyafD8tGZL4LFU0BrFPVsB5caZYxrIf8i5vs0ZvJgQG+QBjM7KnTKWDyNGI5W3zi+gx/gX0X56gnAuetXn2da9KVT1hRQA60WNNKxdZbwYE/SXC5gYJHhNGaxKnMe8UjMr6L2c3TrmDmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719432963; c=relaxed/simple;
	bh=Edk9KaveOFb77WSFKm9P132fNZq9OZCsMRe+lxtXnNA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eNlFYCAU4m+bVwBoDUKu1vHczrY8/NECd278D9u3TFyDMYhm9JP9/tBAkNOx5B4xZRfpO9du8tcSEQEZG0rk3p6CYteoUHFms2Ej8SZj0rsqW8dK9B6QRaw1ILSiDulOICFfb4/pJk+W1hp2KFTsz0bjAgryaqIIousx3iIOAIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C1Scr18s; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719432960;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZX2AGcRMmoaPmdp0U9TEIQ7B80WrvLquACg08mJmXsI=;
	b=C1Scr18skJn/tkxXY2x+n1vXwXosY7VJjm72GKM/K8F2qKgfqW25vY85ub5vjrN4DKK7DM
	HsL4Jh+XEDSr0U3oMrvJI5cqkvm74PSbA2OxQCBuShzXLNyRDHSPJB+wdvOzS+Ubz4KrBH
	4NpyhoVnuffY7yOcDK7VorNOYZgWZ+s=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-421-mOHaVul1MM2MVvR-EKEN5Q-1; Wed, 26 Jun 2024 16:15:59 -0400
X-MC-Unique: mOHaVul1MM2MVvR-EKEN5Q-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6b508715363so111575356d6.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jun 2024 13:15:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719432958; x=1720037758;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZX2AGcRMmoaPmdp0U9TEIQ7B80WrvLquACg08mJmXsI=;
        b=nJxMPKBf+k6jQ0B26Y4O9PUP1zFfdZJ2GikXSlNI5X/Tbx7yyr+ALDwcmejaE8hSPy
         eEaAd0dsgiC1Nlxsj3xrgjRqavht+oD9zx2REu3xs5PHD/IQ4eBy0o+mBlbwEp/v04Mt
         Okz71R7eIx+LJ30+8HwJ42pTNdCqWkDPthh+DYeVFV2lGCfZGOYdMpvk2wdY4UZLSP+q
         ZdLZF1pUl+yQe+qR0PFk09PfbZKLguYE/06LVmirVOLa1Ba3m9BGY1+PT6buvjVV7u8J
         e7uHZOrHZmkqo5QP2rbegG4Ko2iF0TTxnlC66YPltuaTodpt3tIHqSvcqjt9h/wTSpDo
         8O7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUXNgm6HZHMSWbEDq/ClwMy+jsaGlOJYwoYGHoM+cpIn+bR2Z+hP0o+B0dMUE8UTki3geU7PivfzBQrW6BRpYFxTprCy3AC4VTsH2tR+A==
X-Gm-Message-State: AOJu0YwEErjjLtEPXk3YPyi3I/kBsf4uhjUtfoSmYBsfC3yURibtS831
	qsHAAHVzlD4ww/T/AWTVWi2AeC/aNDBIXzY8BLeto04nK6/gIJgJTCkqqpkqTZirq8BLpgopicB
	vdi9u3XChddqUy16ZH7d0tK//pzNIHP7g3n/wISMAc6JWiL1tp0YZQz87z50dNcg=
X-Received: by 2002:a05:6214:18c5:b0:6b0:910a:8c1e with SMTP id 6a1803df08f44-6b5409f4631mr106503486d6.36.1719432958646;
        Wed, 26 Jun 2024 13:15:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwZqOsqHTw4VypxWFI1V8GoYqGEwdbd8AMzxpFaZTVNMdtx8iar2ZPTbvrWpJUZAg/Mc3/Zw==
X-Received: by 2002:a05:6214:18c5:b0:6b0:910a:8c1e with SMTP id 6a1803df08f44-6b5409f4631mr106503336d6.36.1719432958350;
        Wed, 26 Jun 2024 13:15:58 -0700 (PDT)
Received: from localhost.localdomain ([174.91.39.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b51ecfef30sm57710316d6.17.2024.06.26.13.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 13:15:58 -0700 (PDT)
From: Lucas Karpinski <lkarpins@redhat.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz
Cc: raven@themaw.net,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lucas Karpinski <lkarpins@redhat.com>
Subject: [RFC v3 0/1] fs/namespace: defer RCU sync for MNT_DETACH umount 
Date: Wed, 26 Jun 2024 16:07:48 -0400
Message-ID: <20240626201129.272750-2-lkarpins@redhat.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,                                            
                                                   
Attached is v3 of the umount optimization. Please take a look at v1 for
the original introduction to the problem. Al made it clear in the
RFC v1 that if a filesystem is shut down by umount(2), that the
shut down needs to be completed before the return from the syscall. In 
the RFC v2, it was pointed out that call_rcu can block within an 
interrupt context. This RFC v3 addresses both that and removes 
unneccesary code by taking advantage of mntput for the cleanup of lazy 
umounts.                                           
                                                   
Lucas                                              
                                                   
v3:                                                
- Removed unneeded code for lazy umount case.      
- Don't block within interrupt context.            
v2:                                                
- Only defer releasing umount'ed filesystems for lazy umounts
v1:                                                
https://lore.kernel.org/all/20230119205521.497401-1-echanude@redhat.com/

Lucas Karpinski (1):
  fs/namespace: remove RCU sync for MNT_DETACH umount

 fs/namespace.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

-- 
2.45.2


