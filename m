Return-Path: <linux-fsdevel+bounces-22536-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07143918E2E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 20:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04C391C219F2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 18:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28536190482;
	Wed, 26 Jun 2024 18:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="WYR5M80n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4A119047F
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jun 2024 18:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719426124; cv=none; b=mknxOJ0SqLZSpxUvH8XTJZEnBqewUI0q2mDyau7ilpit/ClVJK9NeP4YZbGvL91Wfi8K7M/RVhPjfOKMjkdqnUyRAN3iI3Sc1XaBY8gjtxem4IKHjiR6kwMjAEoLcP1cX2z9ORXlutq1yzmOYjSixOdCF6XPu6gIcU1zZJhTRAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719426124; c=relaxed/simple;
	bh=3YS7Big+2/C1n1GT5ksDvGFsfPk1yxEJ6lCNmeCFOzU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=HVYpZ7vBzarL8F7JFQGrHni0GG8O3HW+/x1VMV8EWCb80tzjfCU/T/Y2IdAmVDaDF+BTI2vSw0i2/h2tV70TcF4Qp0SEnOq8+3yyhZAya4OZ63WIo4BC2ipCtCQ2gK60zDmaClHN1lhCyj6MCOb035bCnCbkSvu0cIRzXvzzvlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=WYR5M80n; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3d564919cd6so364096b6e.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jun 2024 11:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1719426122; x=1720030922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=rj9KENADcu2MwyNzed99Hja88ioeYiKkCX46p9yHNxM=;
        b=WYR5M80nr4Cl6FGWOKTR8s2Fxe2haZYuRpSNVmhitooQlZnEsLBbF5VT/C4BU1DLy2
         pUebS9DHAvH7qEPWzdUcfhv/ygtpvUjLQaEJLktqo2X0ptjBM09iGArcVr8Rfq7nwalf
         diKg32NOP1ymvU/b0UnE+l5D1WsadGPUynzYBeBiUXn52d0KD7RN2a9TAxyZ/HSReqJ+
         a0JaBd2NYnKY4Yx3wclfCrF+f+LeLPeEsokUMi/qLaosu02Vu1SatAjsavxN9XSa0Gpn
         KZvEq8DaU/rWyexWEKBYOTYcq+6GWKI1TzY/Q/JhgoayPxhmxVDx3wZu+sTYA9ST3HOe
         XIlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719426122; x=1720030922;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rj9KENADcu2MwyNzed99Hja88ioeYiKkCX46p9yHNxM=;
        b=t4K9MDZGWHqCiLBxGc6DZEi0dSacDyP17DEkVglH8EF/AkTfIHEWtJFdwjrXfClXhM
         IZZ86IPiBW62zoMBC96/6ZlyauEESA2gOZGxVEHR1wAJcm1s7/DtXOIC+3vtYcvSg9aS
         E6GVpszY0PXOMbThEV/b9cTpARbShCCO42uxblg/gLBbeEOgdOKmjcq/ZDPTx3m4jTW1
         4hyoPp4fzmdJYKOPJLwwiVasVEycGp11ncOMAsojhWhfDfG5jAjLg1PUefaMIZd1GGQ/
         6bLmJ8y83rob2NUcJsmEVY6f5t7djrSeFB6ypb/9UmeiGK94Yl0WPoP8v+0jdyN7uupV
         Fahw==
X-Forwarded-Encrypted: i=1; AJvYcCWULehGoXcGAqML4Xr4PeH3HbaJqQl5YiY0/r5fwLDqOrSYfvh/uOFmcznuPcgXMzWlqQMJNsbhMBe6ucLSohf5Sp1Gd9u83rGA1M1QZA==
X-Gm-Message-State: AOJu0YyDIjxoJL37hb00IjV4s7Y7OQR+1MyN8xz5CNDhaQzqDJ9SWkcm
	xkUT/KCGbLgdjGPREy+kR1LuY6lln3h2iB4P/4l7eaUMNaLeGc9vS8i0H/297TY=
X-Google-Smtp-Source: AGHT+IFNvf+z97ooYOlFx0M/mpi+HnlcqL8zJDwo6UXEL2Ru47c0XawqIUQ9YOuJe8RkwMIFsyVLpA==
X-Received: by 2002:a05:6808:1806:b0:3d2:2293:9990 with SMTP id 5614622812f47-3d545962d36mr13895083b6e.2.1719426122179;
        Wed, 26 Jun 2024 11:22:02 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-444c2caf5eesm69280521cf.96.2024.06.26.11.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 11:22:01 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: alx@kernel.org,
	linux-man@vger.kernel.org,
	brauner@kernel.org,
	linux-fsdevel@vger.kernel.org,
	mszeredi@redhat.com,
	kernel-team@fb.com
Subject: [PATCH v3 0/2] man-pages: add documentation for statmount/listmount
Date: Wed, 26 Jun 2024 14:21:38 -0400
Message-ID: <cover.1719425922.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

V2: https://lore.kernel.org/linux-fsdevel/cover.1719417184.git.josef@toxicpanda.com/
V1: https://lore.kernel.org/linux-fsdevel/cover.1719341580.git.josef@toxicpanda.com/

v2->v3:
- Removed a spurious \t comment in listmount.2 (took me a while to figure out
  why it was needed in statmount.2 but not listmount.2, it's because it lets you
  know that there's a TS in the manpage).
- Fixed some unbalanced " in both pages
- Removed a EE in the nf section which is apparently not needed

v1->v2:
- Dropped the statx patch as Alejandro already took it (thanks!)
- Reworked everything to use semantic newlines
- Addressed all of the comments on the statmount.2 man page

Got more of the checks to run so found more issues, fixed those up, but no big
changes.  Thanks,

Josef

Josef Bacik (2):
  statmount.2: New page describing the statmount syscall
  listmount.2: New page describing the listmount syscall

 man/man2/listmount.2 | 111 +++++++++++++++++
 man/man2/statmount.2 | 285 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 396 insertions(+)
 create mode 100644 man/man2/listmount.2
 create mode 100644 man/man2/statmount.2

-- 
2.43.0


