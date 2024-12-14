Return-Path: <linux-fsdevel+bounces-37401-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D0809F1C18
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Dec 2024 03:29:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 875F6163B3E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Dec 2024 02:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14BF0179A3;
	Sat, 14 Dec 2024 02:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FUVYOhAs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5151C36
	for <linux-fsdevel@vger.kernel.org>; Sat, 14 Dec 2024 02:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734143378; cv=none; b=E4PtUsB7eh2CZIp0wzyLaPVAhAp46KuKII1+c8JhDWAP5hOvqOl96jvk4Z/ivwEXzzJBSV+W6X5C1ElB7yqXbnrQPvtsFW/a3v2C1U55OUushNr860d0C2XSlAy4M79OWZbv6SYLdgp3xdiHK2ho/YxHPGVWq89nS4YDK03zIrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734143378; c=relaxed/simple;
	bh=HTZTT/+8exdvkhEqxHqebH5Tea7JCX3zoRd7sFAeX+4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=joShH0ua4maVg1UbK8dNWWf2iLP7xdehZfh6JBJSMB97NfRb/Xz2qa5ltnLb6qoMMa22Rjhp93sqsqPu9xpFLzQV3ByYOXbjt6CKhgQ+RuPzkyN60kf5iaiUUXmC6IUkOjg9+JoI3giZ4NGGDtSAeHoUMqte4Im+TgYGkTgcj24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FUVYOhAs; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6ef81222be7so23422277b3.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2024 18:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734143376; x=1734748176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Nvhkh5+Xf0kute1+WX6WKFjTQrxmO4MOBXJxUOgDte8=;
        b=FUVYOhAstJ9eHTzvLHi3x5LvNyYqxDeAJjXmLRoQLyalTYcm9/UIcpMjJ7wr4fNvb7
         9e1v4bb+ur1r9bXqygKBLthtfac1/rYg26b6J6uhfoZt/RzKwx3vlCTdLSZmQzYAHiwO
         py8hrPOFL4V8UY9C6jEQYDzkTGv8AwgXmkwgQg4+IUxKtMYaUUoJT5BPYf3SZVNCU4Dt
         2ygr/2Wvzhya4rI45JQzAqNzpJis8Ht0GR4TPBqS+5E/gqgJRnh+qZwOTwJSQqZPBlMe
         YeB2FT3SmALiLSsAEebQbdht1OjkT1RIf/RtPndUlk7ub08lVhPHjghyexoEhy3FxE2s
         o3eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734143376; x=1734748176;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nvhkh5+Xf0kute1+WX6WKFjTQrxmO4MOBXJxUOgDte8=;
        b=FfKr61zU7uzfsyM1MIpQwBpgV92nelRh9Z/GqkjhaC1om0pIxrdysKRPn4n0O3C7pp
         RpwH3yQan+0jH4dwOXrDgFtcBq4YLKr7qRwlzV2r1HBw6FMuUCwCsMj6ugg1B7//vjIy
         xcY6/JqNOt2Y+E+N+kYKURkdKGF2mFCY9URddw3Vr6gyId0u0vDAifVJ1S2Ng0jh2JiA
         O4GweJUAlLPruaeD8vG4MkuSsqZcJc9HflKSNBAefYHZpZbZKkkltM5jGd98xm9EjE60
         KCcH4yaF9h74LO4qr19JRnEmhF0rxO/AMie3gcacIZg5tkCcnEUav/kndZ5u+YZS4dOO
         JNGw==
X-Forwarded-Encrypted: i=1; AJvYcCVoEEZBBrrKmb3oDejpEvO8srOQXxfJgGh9mRLXxImCZkKFSOsTSkZf92/igjEOleBnw29g13CosLh7xSqR@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn+yNmrOt3JzURZ7HxWS4qtuCO04yC4iAfh51sKKDVzE5v87Vt
	UkgfwAfhy8nrS4oGl1hohkCLdlfbccDmhg8b0IYCfYtDylWo6swh
X-Gm-Gg: ASbGncvrAW4FDbVb5ujH4dYMygqDc7I8gTQJ0llhuoKHmefO7TUAz+Im/sYJ5A6gk2t
	VhhW3EKyI37niSt1tH1s0FnFUdkRrSHEIw13chiD1hsccavJ67p6Nvs0VY0Gxz3j3R6pjh48Gpt
	NmTAVy/ROmBhprX9Jt9B6PM0J88GdTz1Fzv/pJujXQSAKdozVeNo3pdEGHf00hdckORfY3gK22G
	WweM8YO1aXzbL+/s65dT2bqIa/XEPT8rsvj/7146KRZNkJwcm17Fjuxk1rquK6h+BIJXV+36ckr
	uWmTrrOdZFkcLy6T
X-Google-Smtp-Source: AGHT+IGngOt8UilZpjTzbTDem4+ZyD40ltr4xslge9D4Ov0QJwrMZ/QKGfojXdAUKlv39n4bxcleWA==
X-Received: by 2002:a05:690c:6605:b0:6ef:69b2:eac with SMTP id 00721157ae682-6f279ad9b44mr47612237b3.4.1734143375730;
        Fri, 13 Dec 2024 18:29:35 -0800 (PST)
Received: from localhost (fwdproxy-nha-115.fbsv.net. [2a03:2880:25ff:73::face:b00c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f289033123sm2123787b3.64.2024.12.13.18.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 18:29:35 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	linux-fsdevel@vger.kernel.org
Cc: josef@toxicpanda.com,
	bernd.schubert@fastmail.fm,
	jefflexu@linux.alibaba.com,
	laoar.shao@gmail.com,
	jlayton@kernel.org,
	senozhatsky@chromium.org,
	tfiga@chromium.org,
	bgeffon@google.com,
	etmartin4313@gmail.com,
	kernel-team@meta.com
Subject: [PATCH v10 0/2] fuse: add kernel-enforced request timeout option
Date: Fri, 13 Dec 2024 18:28:25 -0800
Message-ID: <20241214022827.1773071-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are situations where fuse servers can become unresponsive or
stuck, for example if the server is in a deadlock. Currently, there's
no good way to detect if a server is stuck and needs to be killed
manually.

This patchset adds a timeout option where if the server does not reply to a
request by the time the timeout elapses, the connection will be aborted.
This patchset also adds two dynamically configurable fuse sysctls
"default_request_timeout" and "max_request_timeout" for controlling/enforcing
timeout behavior system-wide.

Existing systems running fuse servers will not be affected unless they
explicitly opt into the timeout.

v9:
https://lore.kernel.org/linux-fsdevel/20241114191332.669127-1-joannelkoong@gmail.com/
Changes from v9 -> v10:
* Use delayed workqueues instead of timers (Sergey and Jeff)
* Change granularity to seconds instead of minutes (Sergey and Jeff)
* Use time_after() api for checking jiffies expiration (Sergey)
* Change timer check to run every 15 secs instead of every min
* Update documentation wording to be more clear

v8:
https://lore.kernel.org/linux-fsdevel/20241011191320.91592-1-joannelkoong@gmail.com/
Changes from v8 -> v9:
* Fix comment for u16 fs_parse_result, ULONG_MAX instead of U32_MAX, fix
  spacing (Bernd)

v7:
https://lore.kernel.org/linux-fsdevel/20241007184258.2837492-1-joannelkoong@gmail.com/
Changes from v7 -> v8:
* Use existing lists for checking expirations (Miklos)

v6:
https://lore.kernel.org/linux-fsdevel/20240830162649.3849586-1-joannelkoong@gmail.com/
Changes from v6 -> v7:
- Make timer per-connection instead of per-request (Miklos)
- Make default granularity of time minutes instead of seconds
- Removed the reviewed-bys since the interface of this has changed (now
  minutes, instead of seconds)

v5:
https://lore.kernel.org/linux-fsdevel/20240826203234.4079338-1-joannelkoong@gmail.com/
Changes from v5 -> v6:
- Gate sysctl.o behind CONFIG_SYSCTL in makefile (kernel test robot)
- Reword/clarify last sentence in cover letter (Miklos)

v4:
https://lore.kernel.org/linux-fsdevel/20240813232241.2369855-1-joannelkoong@gmail.com/
Changes from v4 -> v5:
- Change timeout behavior from aborting request to aborting connection
  (Miklos)
- Clarify wording for sysctl documentation (Jingbo)

v3:
https://lore.kernel.org/linux-fsdevel/20240808190110.3188039-1-joannelkoong@gmail.com/
Changes from v3 -> v4:
- Fix wording on some comments to make it more clear
- Use simpler logic for timer (eg remove extra if checks, use mod timer API)
  (Josef)
- Sanity-check should be on FR_FINISHING not FR_FINISHED (Jingbo)
- Fix comment for "processing queue", add req->fpq = NULL safeguard  (Bernd)

v2:
https://lore.kernel.org/linux-fsdevel/20240730002348.3431931-1-joannelkoong@gmail.com/
Changes from v2 -> v3:
- Disarm / rearm timer in dev_do_read to handle race conditions (Bernrd)
- Disarm timer in error handling for fatal interrupt (Yafang)
- Clean up do_fuse_request_end (Jingbo)
- Add timer for notify retrieve requests 
- Fix kernel test robot errors for #define no-op functions

v1:
https://lore.kernel.org/linux-fsdevel/20240717213458.1613347-1-joannelkoong@gmail.com/
Changes from v1 -> v2:
- Add timeout for background requests
- Handle resend race condition
- Add sysctls

Joanne Koong (2):
  fuse: add kernel-enforced timeout option for requests
  fuse: add default_request_timeout and max_request_timeout sysctls

 Documentation/admin-guide/sysctl/fs.rst | 25 ++++++++
 fs/fuse/dev.c                           | 83 +++++++++++++++++++++++++
 fs/fuse/fuse_i.h                        | 32 ++++++++++
 fs/fuse/inode.c                         | 35 +++++++++++
 fs/fuse/sysctl.c                        | 14 +++++
 5 files changed, 189 insertions(+)

-- 
2.43.5


