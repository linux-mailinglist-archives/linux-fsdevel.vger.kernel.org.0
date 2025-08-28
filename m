Return-Path: <linux-fsdevel+bounces-59521-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75459B3ABBC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 22:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F24FA00625
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 20:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A9E2BE62C;
	Thu, 28 Aug 2025 20:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zetier.com header.i=@zetier.com header.b="YXDx/Lpt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCD62877FA
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Aug 2025 20:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756413442; cv=none; b=eJ0aOjZlCIVOqgPbbAlKgBUSaZW6F3eM15n2IVqt2W4kSmtQgN4GJywhdYiigcuY5YXPOSTXjlNg4+/syRLnYHCGqPMDq+wUN4eOmMlyPguD3RF6cA2xo3yucT2uWD/F3FAuTaAD8QIbkLd12/z+d/YJm80xY64iVcGN+MHSpDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756413442; c=relaxed/simple;
	bh=4A+hHQVDvywK8T/Ae9Z8hdT8p+fMiZHJ8U+tYoMJ1ew=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YptEiF9vxvlTpLWvRJSsWSFqNv5J9tlPb/ZMmVAsQqCtiPzGDlKsshMO+ekXu1wrj8Rwk32P6u5jQsxfRpWkBMamOodPPPwR/+LUOVhIXBZjF9BfuCk0bY6R7gARZWk4Y8h6TytW8qUoV4aI03QMKRp2CuVbXOLfMC5qDTrRaD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zetier.com; spf=pass smtp.mailfrom=zetier.com; dkim=pass (2048-bit key) header.d=zetier.com header.i=@zetier.com header.b=YXDx/Lpt; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zetier.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zetier.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7f7381bd1fcso69738885a.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Aug 2025 13:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zetier.com; s=gm; t=1756413439; x=1757018239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KVnydNepin/bD+gaNKF2yJ3IfALHgiOLd/oO8fikfzw=;
        b=YXDx/Lpt/EW3KmdAPCVDBz7hp27A+icvolI6ULCfVIIi2PeAQVmHCBFTJEwgSNnxAo
         Etl9tsdrLQUXxvR+w+vuidgE+N4XBLiLOMYiQckXYrzEfBddI05X0L61yS5M3vpDbr5i
         xbrk6GeRHwpCFxExZI6cvWbUoijjsiPjFKCGeGnzVmU6jUAqQvwIgAsTO7bgG2ZmDsAh
         ov5+K9ELqpTlg26xLH+9PfkR1lCfVpbZN7JYiuB09b8z2DN1ZC6RAgKwlSBIXyS0UJkd
         rG3npumqnLYcm2noV5VHQh2PTzedweXhdEs65tcXcpQKdhGJDa6vBW98eH21dhFGju+Z
         gPPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756413439; x=1757018239;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KVnydNepin/bD+gaNKF2yJ3IfALHgiOLd/oO8fikfzw=;
        b=MKwMwuMUWmTJQeTJHinIDi4GEIOyYCKNZJxsYsPmuYhG6WZFqLSn5NxpjU8Q6xkQkj
         lcrCpI77wCBKZrxIBUpi9TBtkAjlHA3QkUNkbGjuvzy9DdogYnEHFQg83v1/hVyEgLLR
         gLTMO1nP4332sdVu3ODnDrjqRL+0qrgXIS2vodDKJNv2SA++6cj+puHqFi/7hfKwvTlC
         ZZvltCDvgZiSaoetgzhcGUWpNnfm8xgMYbmgHfEwO6zwDUH6i6vk5AhexvpKihl0I/Je
         bEoIgJpecPpr2v1NeNKECvjuz+eX4Hrhbrmi759y/Pm/7AAHaE5egjTJCjCH6Z8fxjWt
         bdLA==
X-Forwarded-Encrypted: i=1; AJvYcCU10IzY1qSeCmPIdgAewmEiH0fbU5xJjKnkQNtoNyDMCYn9nAJ97MP4/fZx95vB7GyYsQsZox5g72gMxCeF@vger.kernel.org
X-Gm-Message-State: AOJu0YyYKjS57Ouxvs0J82691sqUhgqzEwcTVa6ZTW6U0RL9NyEXxN2s
	hEkiVACpfIahK0DK/tKfK76gBmzxujbKFg3pEfA00y+0wKDKw9w7fBCDgy40aT56C2s=
X-Gm-Gg: ASbGncuF7HR9LTphvL6NBOZG6zFl/92jlNuEoxfWeUANN7xny4HJoOFQtn447H0WdMH
	Ec9bQxpMnWutSk+0BBo9EwWW9vVKsHAUEUvJrKhPQlFgdvW90YaWwDLX9mBbUa5tHXUl0jaYU7g
	dx89uGySK8qbFunkNbiNWyN+baLxIitF87XCCocVDmzpHIdhinuZZ/hPtZoYYnpb5ZNdbld647p
	35g1ZCnHj61rVIQ6jOBFLw+u0GlLlHqUdwrk7nNy1FnYv+C5LSTd+aTC67v9RtWXxBj/rO8ENtq
	tm0ekNmz7oVKw2qG86yhUdCdXBzyyDJdJfFhx1H7gH6FeUmEY4ZcG6s8Ie3OSIYi2VQsS+AmhiR
	6ZldAjRfIK8FX6dnPsrlWzBQGLYMY0Z1U3CwMzyEeSnJwafsx
X-Google-Smtp-Source: AGHT+IFWPGVp0EFtnuGP7IuzsNN7VqWYceEJm3OSNcdsLTKS89hG84EHpmzJ4FBRIi0atJXeDsDiIw==
X-Received: by 2002:a05:620a:1915:b0:7e8:6e2e:84b4 with SMTP id af79cd13be357-7ea11049992mr2638016385a.45.1756413439578;
        Thu, 28 Aug 2025 13:37:19 -0700 (PDT)
Received: from ethanf.zetier.com ([65.222.209.234])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7fc153de18asm45879585a.54.2025.08.28.13.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 13:37:19 -0700 (PDT)
From: Ethan Ferguson <ethan.ferguson@zetier.com>
To: almaz.alexandrovich@paragon-software.com
Cc: ntfs3@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ethan Ferguson <ethan.ferguson@zetier.com>
Subject: [PATCH 0/3] ntfs3: Add support for FS_IOC_{GET,SET}FSLABEL ioctl
Date: Thu, 28 Aug 2025 16:37:13 -0400
Message-Id: <20250828203716.468564-1-ethan.ferguson@zetier.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

Given the FS_IOC_{GET,SET}FSLABEL ioctls are now the de-facto standard
for reading and writing the FS label, implement these ioctls for the
ntfs3 driver.

Use the common FSLABEL_MAX constant instead of a magic number.

Thanks,
Ethan Ferguson

Ethan Ferguson (3):
  ntfs3: transition magic number to shared constant
  ntfs3: add FS_IOC_GETFSLABEL ioctl
  ntfs3: add FS_IOC_SETFSLABEL ioctl

 fs/ntfs3/file.c    | 28 ++++++++++++++++++++++++++++
 fs/ntfs3/ntfs_fs.h |  2 +-
 2 files changed, 29 insertions(+), 1 deletion(-)


base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
-- 
2.34.1


