Return-Path: <linux-fsdevel+bounces-47245-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D52B2A9AFCF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 15:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 447451B83402
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 13:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76FBF19CC37;
	Thu, 24 Apr 2025 13:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XVUo/GXL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B80019924E
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Apr 2025 13:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745502673; cv=none; b=YL6eqqwG4fEjDvTKSgXiFdASnlNdierLs3lyl7qy29trD2tVePty4mtzpWBPeh1CfD5XkbeJHUHpOFnTkeE4hLjCejyt+fl05y0ga2vvDlvEUHCQ75913F1ckWWceOF6qi/7deqTEmGrO1pqLFU+FPYFXrjy/Mc1/mtjp20P86w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745502673; c=relaxed/simple;
	bh=nI5ruha8myb/Ay2z8D4S6CfkbI2CZov/T/Gc2ecu8mc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OR5CGTls8zJ19GYV/265aCurTorH/d2fKWRDKHdawQhLyp2wLiI6WmP+QTVzwn0KowK7nS2UFe7FElFI32XTkJ374nMnw+WVOr/P36flZMLCWDxt6OYnCOU6/Dp8ksbIZBU0yY9+0lWvoORXvEKWEulAZzggl/wiTuZVECjo9Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XVUo/GXL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745502668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=F850X9Wvb7zvNpfszgH9NKoEboiy7g5mNWn6Fyxim2o=;
	b=XVUo/GXLQO1xvocPd9kYNq60L8bCmU6+Gmd5g8/Awk2lrowmoqDR6W9sYiH8gvF8Q2ANFB
	qZhlN4IGaVwyjz9YOL9kn89hDiM0ktJvN5+v8/oC8KaUOHEuEhsqPDRBkEsySTLVt2eyQa
	Qd3zQlWDfyOLZQHI3WxO9ZZ0E+etQzY=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-qzDwE68WP0GTpDkRCORQ_Q-1; Thu, 24 Apr 2025 09:51:06 -0400
X-MC-Unique: qzDwE68WP0GTpDkRCORQ_Q-1
X-Mimecast-MFC-AGG-ID: qzDwE68WP0GTpDkRCORQ_Q_1745502666
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-72c316b7bfbso349218a34.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Apr 2025 06:51:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745502666; x=1746107466;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F850X9Wvb7zvNpfszgH9NKoEboiy7g5mNWn6Fyxim2o=;
        b=Uz8ihW5xVzMqrbh+GZdXyRlthrN80ItMIpRn6iu1sKL8JX0B9qM3gr3wWMwTuG2fHV
         qKJAi+mIEitI6H5K+JCEAgDsNQCP2dIDCmKAQ8MqIRvPWDGqXfxQWjQrQcP010RmmNvo
         QfIkb5EM1xqroWx5rM6RonWBJEgCPTqqcUSb9yZ7/4nDQNTcUeKXcNoyhxMl16D+bRLR
         o8srXcSTfPmG2OjPbCiWCe/JDxn/7cTfNdaf19CmP4fNW5vXL3By2Ubao9uJqcxghGBl
         lkBHRDm2SXXado0OynEXCp1TwZVkQ8eHd3N2lWiJvQlOIQ5McFefhwHk49oLCNX8UCoS
         tfnA==
X-Gm-Message-State: AOJu0Yyf6aXBlcCQdeCzaIVmNFJ3j7895cuV+Rivt+bpCq3CHu56kR3e
	FsCKGe4jLtqZz+OQR84G0tEqTUqSSx30PX7mkAkgn9py1i1bLv50QkJZR543PTfofb2fsWcejz5
	vgGx108oVPyh1zqgUv5BKaozUASpiex2+8lBJCdpgeWY+o/CXm6IJLjJdkOOI1qc=
X-Gm-Gg: ASbGncu93cOi8LahjVd/6VMPx8I5lA8bnfMrq7D7J0bbDo1eluQAPol/r8PNhGEY1fB
	MXkHe/hiIe1y/pRgfXfZVSRJXOuqNCtH7Qu0743uyPvnLaxmW55fpgSuTCBh5u9SHFxzPHo7/lJ
	YD/fVFaerhNkEVvlDM0AVtIjFvNBZBlsXtkwwNvY4nn2e91F8IEzHWB8kaPsVEV2shqwZgANdSc
	xMk2QsBa6hfonaeJNFuSexXtRmycLBELHZ36GO7voQ/hXoNO2fL8uC8jpQDCrMidHVFqtGq6RPm
	/84eAjyTQn90dVHRIhbkukj35Ahjg5+Z+qXwYeqOL3DjZ1QM/8gpQWM=
X-Received: by 2002:a05:6830:6283:b0:72b:9b1f:2e1d with SMTP id 46e09a7af769-7304da4e008mr1777145a34.2.1745502666121;
        Thu, 24 Apr 2025 06:51:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOIadjNwkxxxrid67bBL9suXr9I5Y503+xGT837WbXF/k+0bW2wrNC0aPEhwyZfHn+pmx4GQ==
X-Received: by 2002:a05:6830:6283:b0:72b:9b1f:2e1d with SMTP id 46e09a7af769-7304da4e008mr1777125a34.2.1745502665796;
        Thu, 24 Apr 2025 06:51:05 -0700 (PDT)
Received: from localhost.localdomain (nwtn-09-2828.dsl.iowatelecom.net. [67.224.43.12])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7304f37b158sm233595a34.49.2025.04.24.06.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 06:51:05 -0700 (PDT)
From: Eric Sandeen <sandeen@redhat.com>
To: linux-f2fs-devel@lists.sourceforge.net
Cc: linux-fsdevel@vger.kernel.org,
	jaegeuk@kernel.org,
	chao@kernel.org,
	lihongbo22@huawei.com
Subject: [PATCH V3 0/7] f2fs: new mount API conversion
Date: Wed, 23 Apr 2025 12:08:44 -0500
Message-ID: <20250423170926.76007-1-sandeen@redhat.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

V3:
- Rebase onto git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git
  dev branch
- Fix up some 0day robot warnings

This is a forward-port of Hongbo's original f2fs mount API conversion,
posted last August at 
https://lore.kernel.org/linux-f2fs-devel/20240814023912.3959299-1-lihongbo22@huawei.com/

I had been trying to approach this with a little less complexity,
but in the end I realized that Hongbo's approach (which follows
the ext4 approach) was a good one, and I was not making any progrss
myself. 😉

In addition to the forward-port, I have also fixed a couple bugs I found
during testing, and some improvements / style choices as well. Hongbo and
I have discussed most of this off-list already, so I'm presenting the
net result here.

This does pass my typical testing which does a large number of random
mounts/remounts with valid and invalid option sets, on f2fs filesystem
images with various features in the on-disk superblock. (I was not able
to test all of this completely, as some options or features require
hardware I dn't have.)

Thanks,
-Eric

(A recap of Hongbo's original cover letter is below, edited slightly for
this series:)

Since many filesystems have done the new mount API conversion,
we introduce the new mount API conversion in f2fs.

The series can be applied on top of the current mainline tree
and the work is based on the patches from Lukas Czerner (has
done this in ext4[1]). His patch give me a lot of ideas.

Here is a high level description of the patchset:

1. Prepare the f2fs mount parameters required by the new mount
API and use it for parsing, while still using the old API to
get mount options string. Split the parameter parsing and
validation of the parse_options helper into two separate
helpers.

  f2fs: Add fs parameter specifications for mount options
  f2fs: move the option parser into handle_mount_opt

2. Remove the use of sb/sbi structure of f2fs from all the
parsing code, because with the new mount API the parsing is
going to be done before we even get the super block. In this
part, we introduce f2fs_fs_context to hold the temporary
options when parsing. For the simple options check, it has
to be done during parsing by using f2fs_fs_context structure.
For the check which needs sb/sbi, we do this during super
block filling.

  f2fs: Allow sbi to be NULL in f2fs_printk
  f2fs: Add f2fs_fs_context to record the mount options
  f2fs: separate the options parsing and options checking

3. Switch the f2fs to use the new mount API for mount and
remount.

  f2fs: introduce fs_context_operation structure
  f2fs: switch to the new mount api

[1] https://lore.kernel.org/all/20211021114508.21407-1-lczerner@redhat.com/


