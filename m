Return-Path: <linux-fsdevel+bounces-50580-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C391ACD749
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 06:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7594718972E4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 04:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E5B261594;
	Wed,  4 Jun 2025 04:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a8NW/ZY0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCC42F22;
	Wed,  4 Jun 2025 04:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749012357; cv=none; b=W4K0Kay7KQIUkA6vQui4nizOHJQTlkYFpsko19hx43zOpNJiEc9VyTr5lPOBYn8wjEUrUZGGh9e/86e85Q4VxWfpPulhKsqpeZHTcQdBFyclTq+vw3AFuE6RQGYS0RPuIhuYFLfoiFU0BFB2eUj2aA0fmk9oteOdtIJZO7bCKKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749012357; c=relaxed/simple;
	bh=2nR/AVBnhgaCsM5plCAiVN0s7r1Lp9wYRCr3fVwRARc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=EQEkvlIo0PJC0DFs0qDlPN2srB10+SW+Y299vp1R/p+1Pjrjvh3jS68wsO/8TcQuktoUAPunLzf8SeeKF3KhiilI2QLXjwKq9+TeKW56bZutwTq6lIWUhIWI3ORnctow3/OYW43L8tk+MkA34fSRXzgQbVJ6ckeAJURQRktOXfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a8NW/ZY0; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5535652f42cso692841e87.2;
        Tue, 03 Jun 2025 21:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749012353; x=1749617153; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Cmo8IB9RnvjYfffSXXFK9NWF3lZt8OAu2EuACFlrmoE=;
        b=a8NW/ZY0W909cArsc5tWAy0kMC6JN+4xIqcWAuApRPr1Hw93J+2DZr2NvIUTIpQVD+
         WWKVzZLwTR7rSB6x8GD0h8uaNW6n4DB+dfsoRrjPlyKp1UeH/Uvhmu9DhzGgzmSJRweH
         F23Aht1wHtYWIArUiuNUjvdciPqtWpkC+dzT1vbGZXzTRI8nGTo1RTTqHT02ev+TAPVt
         cgi3zM+HnhnRgDOCiTNetBonNyedenLATkMSWoIARwE+9YYNraBpYcGBn5VrO9tiacDF
         TM8lXZuvntC/4ZBNVbFdKKT58o5ooHkqvFp6v1o33EiTkCmNlazIQ1CMeXg2DcNc4wv+
         5nXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749012353; x=1749617153;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Cmo8IB9RnvjYfffSXXFK9NWF3lZt8OAu2EuACFlrmoE=;
        b=mirbdEB87EPp89jOjez8SR/0zIi5jmCg+9sxQrrkemsyLwVTfo5dLhhQJDcGtsXK51
         dX1U6MNooyKsnGdvAuJbJj0aJDrUspNbNRf0dpx9fMbV5syXwfjkypMb2YUKYjdVSTMM
         JJa+N/mFHOa/1M+96czTQOzvuBZKz9l9vvlphYsJp4pZcd4+Q6nzLopvnwRThwHoiAAi
         zocY6QEdYsrAc3tCztF8v6jjZ4S3qmf68MMFvlE87kaKOp3Qn2A+flb4tiiEbKaVPtty
         Ia8FU3xNNAAs/7/8pjLhS4hCAIrndehH0/XhCpXRhq2/qL4zhBOwYSIRzvEPBKyeAuUf
         1/ww==
X-Forwarded-Encrypted: i=1; AJvYcCUQTZlJFkbdw75m3Uk+sNvdeYqD083uUvjGMOsSA7JPJQfVvIQQ2iZ75sePuMPjRZZPtGkch+Pg0gUqAwI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3uTV6MSmgSLZchghO/8ZaWCF9ZHWdn51z0zfIhDG0VO0o7Ea8
	E2kBmMDz0Yq64RYTvgTQM4FoWTmgl6CLDfqW6NInGbTOGHcPGBKo6OSnWK1804iJSuxz3t1VM+j
	zIhZBbS/Ms+CXRGeOmeQthZfz3TlrYJzFyN/j
X-Gm-Gg: ASbGncuKubH18BK44/QNnWHhWzTfuz9Aj4TRiOQujuB2v+nv1IHw1F27h8O52toLgDC
	W0vjW0HkPYiyBfLrPIQjxPbzrexMZ9Hhip37keYvHk11dJ/7NtIEVGSc8qBP8lgvVMxnguhzRnG
	KcTWHeDb+yE9mwfi7knZYydBK2mOd9fF2BKNI=
X-Google-Smtp-Source: AGHT+IF0W8BUZP1+OcZD1UzD0skxIcoZ3vLq57Z6fbCBM6rnAAVnLFLzC6Tpb9ZtviU8BYI7bH80e1d+pF30uIqtR10=
X-Received: by 2002:a05:6512:3a84:b0:553:35ad:2f45 with SMTP id
 2adb3069b0e04-55356df1cc1mr367501e87.50.1749012352640; Tue, 03 Jun 2025
 21:45:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Luka <luka.2016.cs@gmail.com>
Date: Wed, 4 Jun 2025 12:45:41 +0800
X-Gm-Features: AX0GCFsMIJQXypb6lUIeMm3RMYr7pxdEgIFaok0PMEtywdLI3oqB-v3h6pqjWsA
Message-ID: <CALm_T+3-6MGiNKRdMedJFTtspM=U+gsgOXy9Mn3pD5jc0shD0w@mail.gmail.com>
Subject: [BUG] WARNING in simple_rmdir in Linux kernel v6.12
To: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Dear Kernel Maintainers,

I am writing to report a potential vulnerability identified in the
upstream Linux Kernel version v6.12, corresponding to the following
commit in the mainline repository:

Git Commit:  adc218676eef25575469234709c2d87185ca223a (tag: v6.12)

This issue was discovered during the testing of the Android 16 AOSP
kernel, which is based on Linux kernel version 6.12, specifically from
the AOSP kernel branch:

AOSP kernel branch: android16-6.12
Manifest path: kernel/common.git
Source URL:  https://android.googlesource.com/kernel/common/+/refs/heads/android16-6.12

Although this kernel branch is used in Android 16 development, its
base is aligned with the upstream Linux v6.12 release. I observed this
issue while conducting stability and fuzzing tests on the Android 16
platform and identified that the root cause lies in the upstream
codebase.


Bug Location: simple_rmdir+0x74/0x168 fs/libfs.c:781

Bug Report: https://hastebin.com/share/akadefefek.css

Entire Log: https://hastebin.com/share/ojebiyetah.perl


Thank you very much for your time and attention. I sincerely apologize
that I am currently unable to provide a reproducer for this issue.
However, I am actively working on reproducing the problem, and I will
make sure to share any findings or reproducing steps with you as soon
as they are available.

I greatly appreciate your efforts in maintaining the Linux kernel and
your attention to this matter.

Best regards,
Luka

