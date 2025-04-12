Return-Path: <linux-fsdevel+bounces-46323-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C462A86F0E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Apr 2025 21:08:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7924819E10FF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Apr 2025 19:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E7921A42F;
	Sat, 12 Apr 2025 19:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FqO05KlE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B2019415E
	for <linux-fsdevel@vger.kernel.org>; Sat, 12 Apr 2025 19:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744484873; cv=none; b=UBhItoVBguBiHdPEUz40fyNq34m9FyjKbf5BgH/m8ZQDO805kp0u+bwcLNLW1V34yb9pmcWlMvRSupUKBtK/TiwWLaQJkc1rRkLODbLt37+dPl0y5CzSRTwgAPr2UeN8rKazCX61kLdowyJqpJ1B/kJ4JKTyBOYZSBbvzM4rqJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744484873; c=relaxed/simple;
	bh=LM4Y2I66wt8z3nQIZru/3jsXUlk20qXkrMEf05PQKFk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Dmk6E7N6jHMZi0uT6LJlz22xDDdVHlQRwenipCWWXtXe/CzjPQU55Y0zzNTBDdYC3k5y7SwEeOX+lwaDUsN2olg2ivxQ76Hzbr7U5bONPta3IbCTltk0RpUCvpAKbYxobS/zOz3byrdWwY1ZV3YvifLmtlxoLCOL+SMw5sNhYdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FqO05KlE; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-86b9e93123aso210317241.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 12 Apr 2025 12:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744484870; x=1745089670; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2uqS8Y0JeeNJp+EZoySeyRD8ao4RjMPXd9tkoghzbAA=;
        b=FqO05KlEwXTBrWAaZszjZwxE4voq7bdqTDjhQ251ZM8ZKMyoaaniVKhmdvAVo0wLfD
         Y3qZdkdst8AcECPvMe/YLTPX3ExxwjxLopBAb+o1CSUnMDMqqDXU2D8VwsX3lKMFZA74
         X486ywGSspHBB2PueKenW+3wAFBoZStvk5Z2HHk1nCE0mbmuNjCTwIXZMm/L0rDMPy9I
         4pXLAMOqI2G6xkF4Lrq+CJYyZLLFNOlQ2rypLsDPA661ohza4BhAiWFdyU5/w2tYjL4r
         QKjvfke1GD10+kHHCM+/EpO7GpmcEeapCWpuf1+nSDglJMQfKfLyV6qf7gKK6CoETTi1
         c03Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744484870; x=1745089670;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2uqS8Y0JeeNJp+EZoySeyRD8ao4RjMPXd9tkoghzbAA=;
        b=HxbRO+G2ScjUUBr1uDwg30KVa0xIUhSe4FcInVt2CxPmNCLKDgS06SovrxU1DRhkq4
         dI1CDKLTSX1pjhw2XJygIY7Df1Quh2O0mzBokYyAPAoVxtMrweFgPNO9r2OEqa3zz4op
         rR0WCt6MpxdtnT9XpnZ5nekQE4ujjx70hKD9IT6uva6zoQxGRLPQWqxXmYjkU0ZCUA7l
         VPpf+EU4jjIM6RWwFc05rQMLN/8rLeF9kMDruGBYHDnrRB8na2sWEyPKYszgvMFNTBqd
         WE051OBYoRdyLrBn5ISy+asGT8Dct8wr15wKcBej5VkHYEj2O6AGM0pLvXAekWdEwNFO
         C7OA==
X-Forwarded-Encrypted: i=1; AJvYcCWAJBjB+gyzy/1EH8vIZZZO3FnL98Ck8UL1IGOoqcK2o4pV10wtEf5Un80e9unPjqVBcxf/nfD9158XJ2k2@vger.kernel.org
X-Gm-Message-State: AOJu0YwqQv2fDOERhfztbUQI7A1MsRRJWanJ5SQcHmun0S/0vuNsejA0
	qRMHBSFHw1D6sjDGS8qXy/4EhtuQ6hwqhXx+A6wJ5pmMpFPb/Dlr1Gc/R2dVkXPwmHKgPUWWXi3
	e08tU0GMDKyH+8qiVMJc+uVV/UQ==
X-Gm-Gg: ASbGncvwazD9Zp4uD1WVcuPMXK6cVxindT/fevgNLQJnXt0Ea4l70pjTgpyUTR0Buiz
	VX3phXywNa0sIbBbG9Kq/ysy7894xketXvmQ89QYFFl/TTqovRtNYERqjXHBEIzsJeCZCgfSsvf
	0/277lyAWebRWQ11su3fmebHw=
X-Google-Smtp-Source: AGHT+IG0k+yhiUDsMVLkTuLC6kSDyeEJ84uZ4WA2XWYY1KbUy6V+3ZAbK1JX89b7gE6FzLIFEx93nYU8og6BgBz4HiI=
X-Received: by 2002:a05:6102:3e28:b0:4b9:ba6d:86c1 with SMTP id
 ada2fe7eead31-4c9e768918emr1550739137.1.1744484870238; Sat, 12 Apr 2025
 12:07:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Chenyuan Yang <chenyuan0y@gmail.com>
Date: Sat, 12 Apr 2025 14:07:39 -0500
X-Gm-Features: ATxdqUEU84qA93WFjYZD-conKUCSsApMtwG5XxM0OfTP-Hfdm9RGr15WA6pQlZ0
Message-ID: <CALGdzuomL+AACikTfBYBU4nCMXGU-eRvSYwdY-b_6n0mUekBOg@mail.gmail.com>
Subject: Question Regarding Optional ->prepare_read Callback in NETFS
To: dhowells@redhat.com, pc@manguebit.com
Cc: netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Dear NETFS Developers,

I am writing to clarify whether the ->prepare_read callback can be
NULL for a backing filesystem that does not supply it. In particular,
should we assume that the pointer may be NULL and thus require an
explicit check before invoking it?

For context, commit 904abff4b1b9 ("netfs: Fix read-retry for fs with
no ->prepare_read()") introduced a similar check in the read-retry
path. I am proposing that we apply the same consideration to the code
in netfs_single_cache_prepare_read. Here is the relevant patch snippet
for reference:

 fs/netfs/read_single.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/netfs/read_single.c b/fs/netfs/read_single.c
index fea0ecdecc53..68a5ff1c3d06 100644
--- a/fs/netfs/read_single.c
+++ b/fs/netfs/read_single.c
@@ -63,7 +63,7 @@ static void netfs_single_cache_prepare_read(struct
netfs_io_request *rreq,
 {
  struct netfs_cache_resources *cres = &rreq->cache_resources;

- if (!cres->ops) {
+ if (!cres->ops || !cres->ops->prepare_read) {
  subreq->source = NETFS_DOWNLOAD_FROM_SERVER;
  return;
  }

Could you please confirm if this is the intended design, or if any
adjustments are needed?

Thank you for your time and assistance.

Best regards,
Chenyuan

