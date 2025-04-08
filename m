Return-Path: <linux-fsdevel+bounces-45995-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B88A8106F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 17:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8C8116ED4A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 15:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7301DF25D;
	Tue,  8 Apr 2025 15:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OxgyiGVh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C397494
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Apr 2025 15:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744126819; cv=none; b=pQRt3lSVFFvEK6RfBU9LesuNjTK/5AQ2F0FBGOWp8NF/ZaIyhcjFGyqkJ4dDlidSalr6zbBevzk7XNcflGT1eeA0CNlplDeeVs0P90D9GmIH4M5xdbvlLEkPjJ3iBxaxV/EvEUNgz+uWzKd2AbZ5BXKAu0/HdvQOflHEzdvb4Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744126819; c=relaxed/simple;
	bh=tr2GFQHLxDyISA7tcU6h5xEZDPA2OCE1VprXQc2sqNM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DtXC8scb47VLFH9yeaGCoEAnGC1PodsGlJVfdnvd6DNaWhQvDLLOMLz5v6PiPE47p/aI8LYN2/wRV1aHsJgfaKL9QrYtG73tIRhEVV/CSW1IXJg9/TcyyGPGeHtpn4o5srblgNHqLim5zAqDT8gl9Rob2YWS6FMycbPAxfgpIco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OxgyiGVh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744126816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=g4gfSoeyD899RYUElUCd3qC68f8Y+7MAsXHlxR5UuBs=;
	b=OxgyiGVhB0oYFZCpKu65usp5fmjxAxUHgl0+d92tG3YvBeKSF6/Vz1+80I2eIhAzer55yG
	zngLsp7J8k2SLTDs+oxPlF/i23O0o4HldKDIih+msanacox31xHvr/se+E1KD7DPx1GA8U
	d8P1YzbzKbrIyljVJzei98RsAfNk92M=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-94B4CrN0MPO0QpF4-ZZfqQ-1; Tue, 08 Apr 2025 11:40:14 -0400
X-MC-Unique: 94B4CrN0MPO0QpF4-ZZfqQ-1
X-Mimecast-MFC-AGG-ID: 94B4CrN0MPO0QpF4-ZZfqQ_1744126813
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-ac287f28514so496286366b.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 08 Apr 2025 08:40:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744126813; x=1744731613;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g4gfSoeyD899RYUElUCd3qC68f8Y+7MAsXHlxR5UuBs=;
        b=qn20U5yze78loyH7wWHwtUSe/zIWGR8JCkEnM3HAwAZ3z3TX0doVEPLwUWQ9awq/u+
         peW5bq7KJ92yRXj6OZ+tHVAamgRsfUQABbCDUkkrjgCYfCMFTq9Ve6Ez4SDk7TkDkwAC
         bSefi26JHpOLNuRzBq2kFRZkcNX6+toQ1NulucXEGi+yh4DBPTT4uTXINpkHuwiBpWEP
         +FmAiMqCt7zaNvNOBGjzyYvMk4fy3AX+2odUu6HqBykVbuefd2KTixDYgwO8bygoWtFb
         kxumfYSa5n+ZN7KpDLMjYC5BDDtMhUkXiwtiggLKmLFcv1LD9E6VL3SddXOCDiq0B0SC
         Sl/w==
X-Forwarded-Encrypted: i=1; AJvYcCWAtT47R6Rf+ihOvyUcIwIlqmmimEyFfVAZjQM/JTlpQufQpmamI2kuNQ4T1tt+UfPFMDYTABJj3m4Ia/bh@vger.kernel.org
X-Gm-Message-State: AOJu0Yz55wRDPxNO7Og1UTRmFMZ+2NVmoPcoe67bIC/A7JOs8KURSNny
	XjpSEW/x07bq6foS4c/u9KKm2I/cSxkEKag4mUP23dnJr6GwxTvaUlYQ708BU8K6Hl3YjyDq02j
	76/odSyTPrrjgAFatCqGonaN1GWUhAEqIb61gvrDeCTXZ7zpjaVMMISF5Dq9BCuw=
X-Gm-Gg: ASbGnctJUZ05N8XVw/wUACjkqlLCfU+PNKb4/Okv1BxiDlVOWVbDXRximH3/dizSq09
	wI+/1cPygGcDnMDeyj0fD4l1pV9gujMFQyyGxoyInkEaiAEyN19NBjSQD7BzqLoiYmS0lcqD+WY
	ci5GI4GFc0tuo9wUAmlpr4M9sOLHe32jpLDugixicnh+Yo2zlV7bPSbYeGe+s6cz182k+oah4Ek
	VRnL89GGC1fuwIug+Z3XGH/WjuAVecRnM/03RugffGO2PHpCTEK25x+Ptelq+5XKK6m/Ax2NC/O
	K81BKXRdEZX+zvFZtyv87KVnf5yIbJVwJccq3+lmhAcKIiCpz93JBrJr2v1A0vkwTkqvzTFP
X-Received: by 2002:a17:907:2cc5:b0:ac6:fe85:9a45 with SMTP id a640c23a62f3a-ac7d1b9b63dmr1750174666b.51.1744126812973;
        Tue, 08 Apr 2025 08:40:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFislNdk+jIsGmhhkMWGpFlnXUgxPfIzHkFJjpV+b78lIuGyjHEMGyI7Dfk5MwGiI8Kt2yLNA==
X-Received: by 2002:a17:907:2cc5:b0:ac6:fe85:9a45 with SMTP id a640c23a62f3a-ac7d1b9b63dmr1750172966b.51.1744126812603;
        Tue, 08 Apr 2025 08:40:12 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (193-226-212-63.pool.digikabel.hu. [193.226.212.63])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac7c01bb793sm927553766b.161.2025.04.08.08.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 08:40:12 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-unionfs@vger.kernel.org
Cc: Amir Goldstein <amir73il@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	Giuseppe Scrivano <gscrivan@redhat.com>,
	Alexander Larsson <alexl@redhat.com>
Subject: [PATCH v3 0/3] ovl: metacopy/verity fixes and improvements
Date: Tue,  8 Apr 2025 17:40:01 +0200
Message-ID: <20250408154011.673891-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The main purpose of this patchset is allowing metadata/data-only layers to
be usable in user namespaces (without super user privs).  The main use case
is composefs in unprivileged containers.

Will post xfstests testcases shortly.

v3:
 - consistently refuse following redirect/metacopy for upper found through
   index (dropped RVB's due to this change)
 - move redirect/metacopy check into helper
 - remove verity -> metacopy dependency (Amir)
 - stable fixes moved to git://git.kernel.org/pub/scm/linux/kernel/git/overlayfs/vfs.git#ovl-fixes

v2:
 - drop broken hunk in param.c (Amir)
 - patch header improvements (Amir)


---
Miklos Szeredi (3):
  ovl: make redirect/metacopy rejection consistent
  ovl: relax redirect/metacopy requirements for lower -> data redirect
  ovl: don't require "metacopy=on" for "verity"

 Documentation/filesystems/overlayfs.rst |  7 ++
 fs/overlayfs/namei.c                    | 89 +++++++++++++++++--------
 fs/overlayfs/params.c                   | 31 +--------
 3 files changed, 71 insertions(+), 56 deletions(-)

-- 
2.49.0


