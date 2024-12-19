Return-Path: <linux-fsdevel+bounces-37878-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3908E9F8614
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 21:42:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1742516C079
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 20:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447411B86DC;
	Thu, 19 Dec 2024 20:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LQORjTvE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465523FD1
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Dec 2024 20:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734640923; cv=none; b=uCpp70pPB0Dskmvy7wv/vCyZJehLS+Uy6rF+kANlgwGYkMmo5WtBlBQ+66/PUV/Z9W74wKGF2Hz/FBZ+fI3xUbHJXUDkPTV3ImeBegkx2SIuZdPnAKk7wVZ91B4PnIqVJmCcILT/m0g2ddmYp1GNP0Lx8ZQSUIVvs74+FAefNxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734640923; c=relaxed/simple;
	bh=Z1m1egMyd7uLxJGjfparaXCkRoiDkGxThAlDRjwBKM8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DvE+CtOae4wszaNWWhg7BhTGcNbvWaW9Knqdd0kkrv1/vuowi0jJ0VlT7eBFRJ2oonUGvUqCPw9fiCC/Wkcpw6JJEKrY4qI0DuoSxwMNRW9zindbPpXb4JVPOSqGBq9e1hbwghtPML+4qfugaCUZiCGyVMfxUlMLcj/nzTjKLz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LQORjTvE; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7b85d5cc39eso107323485a.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Dec 2024 12:42:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734640921; x=1735245721; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z1m1egMyd7uLxJGjfparaXCkRoiDkGxThAlDRjwBKM8=;
        b=LQORjTvE5ok817XsZ5GFSBO2xBbCLVUOIGGdkQd9CLNvgPa5dVXa6amwj14Jib48Bc
         6/PgL7THUdaQ4/UwrjgCpX6aIwmivsEg+HVYTIGCvypI3+Ff1hzSJB+xWFx3/Eg/PeeS
         8HIdn/VuNOdB9ZPCUkTDXNTz3NXZPu+YfG+aw9Uqg9/Ze7whChsdEidWK5nDY4KIPPLI
         zg+uUj97bkcRi6XXsrHfMhMWWrkjdSAT99VFjCsU6XQsmXI9x2jv6QGgKvyQbiEkm21m
         N56ODPB9C+BkjaLyXCuBE/JOrntRKkYzhuvlUFjXNQDqOIw0fg7j0FW9APGOQI7+UVvI
         echg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734640921; x=1735245721;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z1m1egMyd7uLxJGjfparaXCkRoiDkGxThAlDRjwBKM8=;
        b=aI7diGYp+vycbTGw1IxrAaIZMEsifT0bPOHLRkXHCEYUzqdBeIcRcrACAZ51sC9DOs
         07IGWZsYJVrH0WQQjzm7+T2EfFTxB3BwkFSRHU5VFKp5M9oarp2wwswBq27X4AK1uLX4
         1c7Iq7SZJGGL55CyCvWbl3PgPuKwuvtb3z5CsZ9meoQ+msOHruEh5sB8fmdyzGV0QQ5l
         0HfrdtTlbS2wMN4sNv0AbQZGKskz7ynml7nK5WnTRTsf8xa7GkRnmbFc5J3VTMFmbRAF
         JdVWoES6vUDJH5hJlVlrFJTj7NvbDSy2yBPpzDTj0O2/djve+Iole8ACWNPwyIdnQ5Rl
         Auqw==
X-Gm-Message-State: AOJu0YzM7BjeDHClC57eAXr1axeNdflIs3OUO4YjdlOZMFrRBfKVvwk+
	YS/b7UupjY+d0jR+3ExRwCUa750nTTP0j1lO5baFIREp6b116Eh8kY6dtw==
X-Gm-Gg: ASbGnctvwIw4Azg4eNPjyd8tvi+ONtGenjpAQdERvxPtYh49fW57G7XL5oaNnxDPCAl
	Hd1xf06gDalDsvsa2zW+RtOY4GLKlCEE2diT8cK9VVOmY0Q9y4mgfu1XdaLtb0uXCfG/st0891V
	VzLZ6S2JxayirQ93d5t2KrE6N40OBUUx3pZebRH8Ghzb1bHo1uGR1g0nEmDlKbtex8gtXakvDtr
	s7EsQXCUYTwJCm5cdG/qz7tyrh9eROjg53a8gXcmBhzxy+qFce5gPOg+96uXux/4VdQCC7grmhG
	Y6Cqym3wLpsBPJttSaKLLHRbmCVdcBqSaoibTQm1BaaZ4XPGuwgi5NTxS/MgTFc=
X-Google-Smtp-Source: AGHT+IEA4KbdIsDSvCKgaz4ai7UrAAtRGkiAcpkI4vI2dhFH7SAUZP7R0WABlTA+UGgQlA8Jw8RXYg==
X-Received: by 2002:a05:620a:17a2:b0:7b6:bbe8:7d6e with SMTP id af79cd13be357-7b9ba836df6mr44776785a.40.1734640920994;
        Thu, 19 Dec 2024 12:42:00 -0800 (PST)
Received: from localhost.localdomain (lnsm3-toronto63-142-127-175-73.internet.virginmobile.ca. [142.127.175.73])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b9ac2df6d3sm78889585a.46.2024.12.19.12.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 12:42:00 -0800 (PST)
From: Etienne Martineau <etmartin4313@gmail.com>
To: linux-fsdevel@vger.kernel.org,
	miklos@szeredi.hu
Cc: joannelkoong@gmail.com,
	bernd.schubert@fastmail.fm,
	jefflexu@linux.alibaba.com,
	josef@toxicpanda.com,
	laoar.shao@gmail.com,
	senozhatsky@chromium.org,
	jlayton@kernel.org,
	etmartin@cisco.com
Subject: 
Date: Thu, 19 Dec 2024 15:41:48 -0500
Message-Id: <20241219204149.11958-1-etmartin4313@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


This patch is an attempt to simplify the fuse_check_timeout() logic when compare to implementation [1]
Here we are using sysctl_hung_task_timeout_secs for timeout but that can be modified to use the generic sysctls, "default_request_timeout" and "max_request_timeout" from [2]

[1] https://lore.kernel.org/linux-fsdevel/20241218222630.99920-1-joannelkoong@gmail.com/T/#mce54a6209722ceeb53504d2d36bce49024954392
[2] https://lore.kernel.org/linux-fsdevel/20241218222630.99920-1-joannelkoong@gmail.com/T/#m3605b8e87d9b61b9c71d53843ae976aae5a1bd9b



