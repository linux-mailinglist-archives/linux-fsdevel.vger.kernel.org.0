Return-Path: <linux-fsdevel+bounces-38431-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9430A02615
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 14:01:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3725A160F60
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 13:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA571DBB19;
	Mon,  6 Jan 2025 13:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="MYLGsR20"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DF52BD10
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Jan 2025 13:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736168512; cv=none; b=H8cgN0oK4RSZYS6dI+SDRMUfaTu/2OoAEpYAQbuI0/I3e9vxt+MHg4vnQl+kFxqt6iEkQSCkQDkaFFUVr9t33zlfyY0+Ur9oBJfTMZivoigx+aFzjjFvqe4kxJRugq+x/vZWTeV+FCqf6ZMTshb4fyxYw1Roo0u8VoGlbxtZ/n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736168512; c=relaxed/simple;
	bh=yCJ2YP0l4KPLC0wgnVjuWLZA7faZQsIPToVD00FBAyA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Z6IuOqGz5CpQ+KFQNd2XMfOVu/phSBbvDpEtjQnIdA/bdAxOH7DLaSB+E3VCQQ9Equ2b8gORmlPC1je3Tb/PtKAPGt94+U7AlyGzk8wgdIV5HyoYZsq9VZ8zxBbex5dSRWjWjQLQ6RgIXEa4aHqrirgU3rRsnjdcN+vaHG3k6OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=MYLGsR20; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4679fc9b5f1so108797741cf.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Jan 2025 05:01:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1736168507; x=1736773307; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vsJhuMGcMDNOj4rZnRSEHTdtXxAFLi16x0I+zjVxebg=;
        b=MYLGsR208G5O4sfQYpENDIKgmETctcXDpVEvHKlnwRCZcq4sImuSp0sN1Mb7XDgerP
         y/wuS7BGcUDD/e0KFP4HbKWtIxs7aqUNa+zImtcu3Q2k38x3l9HOXCZqy42j3IZZC3L5
         D7/5GTrffwrFj8tApFUf5it5f5HUwZaSESMxc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736168507; x=1736773307;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vsJhuMGcMDNOj4rZnRSEHTdtXxAFLi16x0I+zjVxebg=;
        b=LM816lolmP2y7UQevwgNpaiFBCEEqWRY2ChqixhL0jzOGp/cbfAzGKsoUPPjZI8QCF
         VN81ULNq35LEVOOFTRYjfPd6EJ2xFs0OZSyn7TAGFMJIfiJ21ew5JIehqI1t0fnodm3R
         P0/AzIh3ebFZDRZtOXU6q4vU5CyMqNpvgkQ5c9qmNms4iDkVzzrePhWwnHaQ7EBfADfO
         OivF/0dT1Gceq3WuGaDOAcDrWJVGburw+wR5+R6bR42evzIsNBzi8gKwzaud+pnLZEf+
         K0fpMedDidS5g7eZ4f/0IUVSMEH2dVDJMfonOqyN2NdzfloEDqHl/9OlKm2q54PjRNtl
         /poA==
X-Gm-Message-State: AOJu0YxyUvn2lDAFcNiGB42NiYO2MN2UFMBonUTbES8g9NGoRbu2FqtI
	27ZSDxI/Ny5N2d7KMHfbVeBm4mhWOUMPRneFS0W9GHh8cgyWRllc2ztRvwGbWmuqjYY7OQ9cetE
	8A+4ERlxL4myLfZsub0mwE3ANQf4zlE5iPXhGnQ==
X-Gm-Gg: ASbGnctlt9aqVHJyGwICxu5/FJ+3o8uWmXisJyp49EQK+XSkm3gZR920PZZXcVzReDQ
	FKO1SalnTNJDqABu6ruRykuvPPiVWPE0c0uSWiQ==
X-Google-Smtp-Source: AGHT+IFx2IzMP7UjMR6KkmzBLz0806dE98eSP6wwS4+DXa5z3OmCRe63Mm+RL2UvUMJIi2G5uekCG97A4JuZIGs+fZI=
X-Received: by 2002:a05:622a:302:b0:467:7ff3:e4bf with SMTP id
 d75a77b69052e-46a4a9a3e7emr991917841cf.51.1736168507517; Mon, 06 Jan 2025
 05:01:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 6 Jan 2025 14:01:36 +0100
Message-ID: <CAJfpegu7o_X=SBWk_C47dUVUQ1mJZDEGe1MfD0N3wVJoUBWdmg@mail.gmail.com>
Subject: [GIT PULL] fuse fixes for 6.13-rc7
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Christian,

Please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git
tags/fuse-fixes-6.13-rc7

 - Two fixes for the folio conversion added in this cycle

Thanks,
Miklos
---

Bernd Schubert (1):
      fuse: Set *nbytesp=0 in fuse_get_user_pages on allocation failure

Joanne Koong (1):
      fuse: fix direct io folio offset and length calculation

---
 fs/fuse/file.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

