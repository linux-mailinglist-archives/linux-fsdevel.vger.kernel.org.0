Return-Path: <linux-fsdevel+bounces-37087-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3049ED6BD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 20:45:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D832C18841E6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2024 19:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E081DE3BE;
	Wed, 11 Dec 2024 19:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j8eslGPY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C561E2594A3
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Dec 2024 19:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733946345; cv=none; b=J0/VH9jY51YqK/Srs4tcmITOxADTwnpxKzuKlyHME/HtYRrqWIBOsdk8VNDzUIFJjF0VPLm63biKqbpkQGlhhmud0Z7XrFbnK1G2AQ6NZoa8cwEfxGPp4OyH0ch3OZnZwaUNmfUs0H4RMVFvPSl28lZMLwf7bi/F90yWdwUZ5Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733946345; c=relaxed/simple;
	bh=ZpJCDRpds2AhlQ/WVnfoOXMDXjbBxll05n7/Nvtb6Y0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZPGN3yFhWPkukj2QLdbgnvCZC36wnf5Ib0rStbMltgzEwkcqwA7dtN3JghAjlYCwG8/vJNjEUMXBg7PkI2TuOge2qFAprZROY7Mp6Ju5q8JKwXsglsHjQfgQwGxZIy8ii2ro2POhCLNKqiNUy6dBoE2QD2pVvW4HBN84f7qFBeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j8eslGPY; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6d888c38841so56155806d6.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Dec 2024 11:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733946342; x=1734551142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZpJCDRpds2AhlQ/WVnfoOXMDXjbBxll05n7/Nvtb6Y0=;
        b=j8eslGPYIiqMVlUoUWdRTNTHvDSipenixOe0KxLdgQWMkCI0mg191iyigs7/OobpFq
         RfabwZ0syRHSFZyQw+zBVoi2Qq7FrQDMOAKlJtAFhGLi0dN23Dbo4kldlhEfiXi8Ko/k
         PWI2lvjTMsvMZdROmCj+Hg+7s6sK0PsWJMazitoptPIRFoHj1oE4+ykOqu/1zry5ZM2O
         3+g6lldBZChVC4421xUvVhJczMUuaihvHZRSB4dnkRRWtDnGwrwaHEqAIrT3MlZ1sQxx
         B4SvWKC9XTUKL0kWfYsbITii3IT9GxmUNhmNtf7969RQUUCELDb3Fw8sUDsy5QZiYNH9
         FhPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733946342; x=1734551142;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZpJCDRpds2AhlQ/WVnfoOXMDXjbBxll05n7/Nvtb6Y0=;
        b=g1pX7SQoTJv2WJ2dz7O8upF0CUpxS4ZinMMusXJZVg+RhKhAmDrnwW5+KzvCW4qnxw
         6mwhmE9b8kIZqsyYsbh+dgcSJCuUw4cieQWu+ryxKeiJMJzvDtOpYUIZTYivOqi9peSl
         6GN5atKbmzqpeGn4tGKyXasdbDUjeIndDTgc2WZBOlC5jbYCdiilVAhVmMIYCplsug4M
         onh1tkDugCLA+AGt2RLHpADsVmPuWcAjNnnlxy9zIG7x6bxZq1rclPLHi+SBI2T8MBxz
         aivJBK1GIEZcMHDpgm9TbYq9fb8lGRraabLZxP9YiP6JfL2u457MIqcv0XiU33fH1c0a
         BwVg==
X-Gm-Message-State: AOJu0YwTK22DMAONpoGLU3i34bnDdKV7y0vuHPD2rs3w/LJXlJjrvenL
	9whqbJ+BcYJ5SAccfu91pqyWPj7D8dHFN4xcx/Psou8Yd1JuZJVB6bZ0Jw==
X-Gm-Gg: ASbGnctSh0MLT0+KyaUU/m7kJ/ahqqbVf+h0D96lwVZCtG+ajYLuZ3O71cEl/RBFnk3
	0O7x4Ph48F9PlIkmgfiB91CPAnCRgMsy9wVGQn8nLMJMBPGBtEHaJJWDgbGvj8zKJx88U9eqxzG
	zomIhyMZFsu/ZJq0p67PG1Xu3oV4SC8DZyfcVsgqs5MaL9ANPk7RKAJ3BfUjwo2LVuzNVVhgo1C
	SBfWBPjpSy+/khD5Zs/xJVArPHOR1Lo4Z97rr/I6uNssZVxFxhnqAItFtoE515jjo3T4i/hbYU1
	QfLVTKQM7JZkuelfJZUkpotIlL6WjStj74i4SpOnUXXFD4NlOgulcUzI/KS+
X-Google-Smtp-Source: AGHT+IG5MCduO3sZyK59XBPNg2Hg0ihi+OdIBFyOU9aLE3dumwx98xSwlYbw6jPtH3spYPAG1cN+vQ==
X-Received: by 2002:a05:6214:c43:b0:6d9:2e24:9da8 with SMTP id 6a1803df08f44-6dae39822c9mr7496666d6.37.1733946342488;
        Wed, 11 Dec 2024 11:45:42 -0800 (PST)
Received: from localhost.localdomain (lnsm3-toronto63-142-127-175-73.internet.virginmobile.ca. [142.127.175.73])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8da9fdecesm73063626d6.77.2024.12.11.11.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 11:45:42 -0800 (PST)
From: etmartin4313@gmail.com
To: linux-fsdevel@vger.kernel.org,
	miklos@szeredi.hu
Cc: joannelkoong@gmail.com,
	bernd.schubert@fastmail.fm,
	jefflexu@linux.alibaba.com,
	josef@toxicpanda.com,
	laoar.shao@gmail.com,
	senozhatsky@chromium.org,
	etmartin@cisco.com
Subject: [PATCH v2] fuse: Abort connection if FUSE server get stuck 
Date: Wed, 11 Dec 2024 14:45:21 -0500
Message-Id: <20241211194522.31977-1-etmartin4313@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When HUNG_TASK_PANIC is _not_ set, this patch doesn't take any action hence it's
still possible to observe stack dumps ( as before ) whenever a FUSE server stop
responding.

This issue is seen in the 5.4 / 5.10 and 6.6 stable branch and IMO we need a
solution that can easily be backported.

Following Bernd's comment on the previous implementation [3], this patch now leverage
the fuse_check_timeout() logic from Joanne [1] with minor modifications:
 - Runs from a work queue instead of a timer to address the deadlock reported by Sergey [2]
 - Use time_after() for jiffies arithmetic
 - Add chained work to kick back the timer logic
 - Set the timeout to be half the HUNG_TASK_TIMEOUT period in order to stay under the radar

I've been running some tests on rc1 and so far things looks good.

[1] https://lore.kernel.org/linux-fsdevel/20241114191332.669127-3-joannelkoong@gmail.com/
[2] https://lore.kernel.org/linux-fsdevel/20241203110147.GD886051@google.com/
[3] https://lore.kernel.org/linux-fsdevel/20241210171621.64645-1-etmartin4313@gmail.com/T/#m8f6f370d39087adcd4a7b325fc0562eebab7b998

thanks,
Etienne



