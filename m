Return-Path: <linux-fsdevel+bounces-17940-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0E68B408A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 21:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEA5C1C22BB8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 19:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF9C23758;
	Fri, 26 Apr 2024 19:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JfLqtMOA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BD82032A
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Apr 2024 19:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714161346; cv=none; b=fr3/Fos5qy/W4L4n+Ar20SoofyNbNlWwggHBIafAqG/TCyvB9oafZDgtosdInlD3Qd024W1XBxSbcn/ZyR9CIOXpVz+WrkofdFGFsUz9q9TLG/fl61YAGh+VxfLD1I4wiAa2adR6hBmf8BrLajfrBfJ2OiT1H1hAzSNxiyDA8+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714161346; c=relaxed/simple;
	bh=Bh5o0QdcQIobo/H4Wrn5STRyPNZ8pLWIRgzThTjZWXU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EbFfFYRr/3kMIh1QcqHBX8IvYdZrI8oHnltd191tmenqPGpTJtIkimNzj6OpVs6IB+QZHypihEi5FtcgmkNX82m90vKcR+DJaRERXqO7AocznnOORLmfi2IDevOUReYc4uUf7yTYvRAZkrw2w9aGJMaYyCQUhUie2sQRONUsb7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JfLqtMOA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714161343;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=V3u1azg8RiBR7RNxMnu2p6fl2vMhqNcvKFIRuvtoG54=;
	b=JfLqtMOAIqb4p5uf6q5I1L/9RtCAL+vmYNuTrIJW2++LK0pKGR+5jNQgMTiQzx7hDzciu8
	N+K70A26kUfZBjaUEQoEkSeohmF+JsnStvugnoh6W0e1y3s1yOHU4sFZkflBqrXKqExBH/
	2qYn5M26Sl+CQVks23d6D6oZWBQbobA=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-Sx3a6OVPOriOGosXja4ulg-1; Fri, 26 Apr 2024 15:55:41 -0400
X-MC-Unique: Sx3a6OVPOriOGosXja4ulg-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6a0b09ab450so15772536d6.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Apr 2024 12:55:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714161341; x=1714766141;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V3u1azg8RiBR7RNxMnu2p6fl2vMhqNcvKFIRuvtoG54=;
        b=SSgprYKwGtlTWOGXX/0eRGm47Z5bRWRboM+TotdTisP+GV7GTKuVoLA2q/CNcowWy3
         jyaGCnnyhr+3dF4XuWPgDS7v0c+LaAr2oFFVjs887aymlR8y7g0y9hsD3OF5gsHPFnYO
         wXwV62r3qifPEjLjKtAEvH57mr0+SR/nvkkHnwdgrpP9utxlkxaaPrIO+K4dhqawN/cI
         6mVzGu3i+LKRFzdRxskdIDYdaBudgQHmNoVMFxJqXyr7st40ia82o3zBYj/f2nj4Vzgw
         6D12AcMPU54/cFr7bmj6blmffZq0lgYaUWMdCAO3PS4USeGpc+AwD71ZNuzLeHlPfwZl
         1BlQ==
X-Gm-Message-State: AOJu0Yw8zUfEsC+MXiMZvvy1NZkYDIet3wojQDKX/Pv1bgvsBElJ6F5C
	6oGMgVWfUjEaf6afob4i+7B4mNtj45vY/VNpUqCaf6bdCxWF+7sMcCEkPcnFzkC/axHBg2Ox0IL
	/gTKdXJrKXqdjjaFm+TkrzGoqGXs+YXrg/rulVT8aa907jZb0J1RfenFTwcGJzFI=
X-Received: by 2002:ad4:5f45:0:b0:69c:b191:4f29 with SMTP id p5-20020ad45f45000000b0069cb1914f29mr6643381qvg.9.1714161341203;
        Fri, 26 Apr 2024 12:55:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsTEUnZCwn9PILopxcKLFrJt9zb3VN0/23eZXduDoVAbWUmnL2jQVvEnhp9S23TE9mXYK+fw==
X-Received: by 2002:ad4:5f45:0:b0:69c:b191:4f29 with SMTP id p5-20020ad45f45000000b0069cb1914f29mr6643366qvg.9.1714161340964;
        Fri, 26 Apr 2024 12:55:40 -0700 (PDT)
Received: from fedora.redhat.com ([142.189.203.61])
        by smtp.gmail.com with ESMTPSA id v3-20020ad45343000000b006a0404ce6afsm1882268qvs.140.2024.04.26.12.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 12:55:40 -0700 (PDT)
From: Lucas Karpinski <lkarpins@redhat.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	alexl@redhat.com,
	echanude@redhat.com,
	ikent@redhat.com,
	Lucas Karpinski <lkarpins@redhat.com>
Subject: [RFC v2 0/1] fs/namespace: defer RCU sync for MNT_DETACH umount
Date: Fri, 26 Apr 2024 15:53:47 -0400
Message-ID: <20240426195429.28547-1-lkarpins@redhat.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,                                            
                                                   
Attached is v2 of the umount optimization. Please take a look at v1 for
the original introduction to the problem. Al made it clear in the
previous RFC that if a filesystem is shut down by umount(2), that the
shut down needs to be completed before the return from the syscall.
                                                   
The change in this version looks to address that by only deferring the
release on lazy umounts.                           
                                                   
Lucas                                              
                                                   
v2:                                                
- Only defer releasing umount'ed filesystems for lazy umounts
v1: https://lore.kernel.org/all/20230119205521.497401-1-echanude@redhat.com/

Lucas Karpinski (1):
  fs/namespace: defer RCU sync for MNT_DETACH umount

 fs/namespace.c | 51 ++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 45 insertions(+), 6 deletions(-)

-- 
2.44.0


