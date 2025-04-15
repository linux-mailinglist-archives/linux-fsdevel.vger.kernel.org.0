Return-Path: <linux-fsdevel+bounces-46511-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 657E9A8A701
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 20:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78F391900F72
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 18:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4522192F3;
	Tue, 15 Apr 2025 18:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="NTvbSl/0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5BBA221D8E
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Apr 2025 18:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744742635; cv=none; b=AhYn5lJ+ipLWpeK+wC5hySMIfjZBKAwpZBLKxJCAyKQy5KqKgLY52g7GRL211Gj5IBe6a06+gfddNwVl0QJjxKtaVH2G/NxiW/jXmyOYW9s/M0JG2jezwkloBxfojyCBIRnO7G8whkCrVZImDApRMucvxdZ98R1HXmMCvVg5Kww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744742635; c=relaxed/simple;
	bh=uov5pf2FdkO2Gsa2n0Ob2obAF9nGPbtTncGp38+Ube8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sXwNCufw5hP1Up4FvULO9Way7fAVIYapXO3mrNgcf4kwRGHa8zbq/JItyDQp7hH8vtTqyqo6qeNHpdpQWQlEB/37t4rqrAPYgHGLJbk3bI7Aaw0CGk6hTvW/RnxgYJcTNv/8gTzOG7ev9AJRAHurjc3gS8BGvsJ3UkZRjFGQEb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=NTvbSl/0; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-22548a28d0cso85715335ad.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Apr 2025 11:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1744742633; x=1745347433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vsqX9FF/96tgvWv/MBEvfR9STkMTnr/F/tKaBfVEUTE=;
        b=NTvbSl/0FCKvIYuFCSRMs9xpDRLnv5E6X3e6svvD5SvQdP4O6COvKcGFAXw3JMZQzF
         EsGeMegPa3gU95hy05ZLen8D07n+cpxufvEg+NWA5loM2WCYWi4CQ2HSu1zhdrzJqYqc
         rvUrgonDr5sAnSd00Rzi3EQFBKXDKerTbxEZ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744742633; x=1745347433;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vsqX9FF/96tgvWv/MBEvfR9STkMTnr/F/tKaBfVEUTE=;
        b=JvQ8T4cF3M96hm6f6Om8UtLKKIU/Tz12iqL6dh+CTZUDtVUOvSO8DlM47UFNVVmYQE
         OzN56T6uspEaAWqWlI6FANxHpogomJ72cnaczgCNDuyIAVE0179aG5U1JSY3kgJmwZJJ
         fZs5KzR6kNokSRYdn774ISiAezve3AKyMhkHcil9Q9+QJ8eGoL8ArSCXUm/I0F04VGCS
         rFXR4/qo8eGJ6w55gfXEArw4SuE9ZGSDZB7htkpXXlY37MhKnnvHp7wYpqhPC7d31qSc
         zjqSguwTEaTZhWyePfSQZlPhrD6KllhLPbLjJnb2TY0FvzXz5WKTH8mjNiypB+pS1hxQ
         FYpA==
X-Gm-Message-State: AOJu0YyTZm2PmUFssaK7trSit38eTfQ7gusKcjH/5CpR+X8sEcHZykeX
	mTGCtwXfAeg92ql1EjnbX/GutHfuf/TTU5H4WAOnvbv5Oq5PSb2haWchR2eVcroLOhHIIHTO3aF
	YhwNH2S+GH7B2sDV5YM8DYNN/0Hjp5yKqeRVh1HKEPVOTMBYMftA2rbM5H1G+gUwQBGECncByJ9
	EIndLw+y+6o8Oj1n3n5+2KtPIR+51EUshKpFrDIgfNxnak
X-Gm-Gg: ASbGncvGF6TXgfOra2Q+StZQoXVFsw4VtFB1Cl1FaaFgs4Vv3klaxw1MgxjyzAi58zY
	A9/ObspJ2K86FoRC3aXF+QyjcFB8efVWedGHOw67rf7zJkewX0d1BDPoLdAHBTQm+30pBYJqbtB
	ucwzFZS6lVu7oMX6kO2oV4GP+e9RPXMu4Gb8HKt3H/qrwfDHgnNFmCJwqnhr6B1DexS2poimPcK
	RJ/uqhqX9/7TqAgRCm1EBJaHCHtR+NSsM9A5J6jQxGXFJIxgGy+XEo1VpAX/O8/MacpsAYIcjQn
	mBTPLDDeStQTjqOXOu3deV3qx9gyum+JZhsJk2xttu50uF7f
X-Google-Smtp-Source: AGHT+IEMF7kJ1BVNruMG1QJeIs+nIXZYq+KKJZbOCfzP18tQCrD9H3dYN/X4lmLNx7Ghzq3ksbhYzA==
X-Received: by 2002:a17:902:d4cb:b0:223:5ace:eccf with SMTP id d9443c01a7336-22c319f64d0mr2924155ad.25.1744742632722;
        Tue, 15 Apr 2025 11:43:52 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7ccb7b5sm120514455ad.237.2025.04.15.11.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 11:43:52 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: linux-fsdevel@vger.kernel.org
Cc: Joe Damato <jdamato@fastly.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	linux-kernel@vger.kernel.org (open list)
Subject: [RFC vfs/for-next 0/1] Only set epoll timeout if it's in the future
Date: Tue, 15 Apr 2025 18:43:45 +0000
Message-ID: <20250415184346.39229-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings:

Sending as an RFC against vfs/for-next because I am not sure which
branch to send this against.

It's possible this should be against vfs.fixes with a Fixes
bf3b9f6372c4 ("epoll: Add busy poll support to epoll with socket
fds."), but I am not sure.

The commit message explains the issue in detail, please see the commit
message for details.

If this patch is appropriate, please let me know:
  - which branch to generate the patch against (I suspect vfs/for-next
    is wrong),
  - whether to include the fixes tag mentioned above or if this is
    considered "new code" instead of a bug fix and I'll omit the fixes.

I'll re-send as instructed (without this cover letter)... or not if this
patch is incorrect/not desirable :)

Thanks,
Joe

Joe Damato (1):
  eventpoll: Set epoll timeout if it's in the future

 fs/eventpoll.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)


base-commit: 2e72b1e0aac24a12f3bf3eec620efaca7ab7d4de
-- 
2.43.0


