Return-Path: <linux-fsdevel+bounces-14399-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F4287BDF4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Mar 2024 14:47:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FBB01F21A3D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Mar 2024 13:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060B36DCE3;
	Thu, 14 Mar 2024 13:46:59 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relay164.nicmail.ru (relay164.nicmail.ru [91.189.117.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8FB85A4E0;
	Thu, 14 Mar 2024 13:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.117.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710424018; cv=none; b=PNawFYe+eteJZBvYrBB9xCXQimcu7L4ca5M7aWOs0IdSRmJVGHtvqqTtKyotPpmf4fIKgw7rvKSeF9vRt7kqc8n+VlRgRjo4A58i8MRBpv3Ccia7n/ZD4qjzWTQPNHgnHE8wpodq/pw7Pr+JQ5+ITf3qJwPLbwR00H/3LT+VRIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710424018; c=relaxed/simple;
	bh=mWnJcYVexJMfzwrrd4FxMxgxlZ0IYRDe5jxh+xgWppc=;
	h=Message-ID:Date:MIME-Version:From:Subject:References:To:Cc:
	 In-Reply-To:Content-Type; b=TVqUykKbglH27ecyJ7OQkX3ruvMv7mrzDFm9iT+Y+lumcgOmGtkKmReE85oZ4ZC7+p6fckMBMtpiu63MCUucfPocfuZt8kIqLfJ+NmRk0ORyYQpsUTWbu/mBo5QWTiL2E/sXIyZ2pqr5pV3Yb4ferHoUkuIshx+5M7fJMuBQF8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ancud.ru; spf=pass smtp.mailfrom=ancud.ru; arc=none smtp.client-ip=91.189.117.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ancud.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ancud.ru
Received: from [10.28.138.148] (port=33962 helo=[192.168.95.111])
	by relay.hosting.mail.nic.ru with esmtp (Exim 5.55)
	(envelope-from <kiryushin@ancud.ru>)
	id 1rklGY-0000IY-G1;
	Thu, 14 Mar 2024 16:37:03 +0300
Received: from [87.245.155.195] (account kiryushin@ancud.ru HELO [192.168.95.111])
	by incarp1101.mail.hosting.nic.ru (Exim 5.55)
	with id 1rklGY-003CBJ-0Q;
	Thu, 14 Mar 2024 16:37:02 +0300
Message-ID: <d296ff1c-dcf7-4813-994b-3c4369debb7d@ancud.ru>
Date: Thu, 14 Mar 2024 16:36:56 +0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Nikita Kiryushin <kiryushin@ancud.ru>
Subject: [PATCH] fanotify: remove unneeded sub-zero check for unsigned value
References: <>
Content-Language: en-US
To: Jan Kara <jack@suse.cz>
Cc: Amir Goldstein <amir73il@gmail.com>, Matthew Bobrowski
 <repnop@google.com>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
In-Reply-To: <>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MS-Exchange-Organization-SCL: -1


Unsigned size_t len in copy_fid_info_to_user is checked
for negative value. This check is redundant as it is
always false.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 5e469c830fdb ("fanotify: copy event fid info to user")
Signed-off-by: Nikita Kiryushin <kiryushin@ancud.ru>
---
  fs/notify/fanotify/fanotify_user.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index fbdc63cc10d9..4201723357cf 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -502,7 +502,7 @@ static int copy_fid_info_to_user(__kernel_fsid_t *fsid, struct fanotify_fh *fh,
  	}
  
  	/* Pad with 0's */
-	WARN_ON_ONCE(len < 0 || len >= FANOTIFY_EVENT_ALIGN);
+	WARN_ON_ONCE(len >= FANOTIFY_EVENT_ALIGN);
  	if (len > 0 && clear_user(buf, len))
  		return -EFAULT;
  
-- 
2.34.1


