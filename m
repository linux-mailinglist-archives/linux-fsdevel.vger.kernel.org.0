Return-Path: <linux-fsdevel+bounces-43047-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 782BCA4D558
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 08:50:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5466171CA2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 07:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5DB21F867F;
	Tue,  4 Mar 2025 07:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j+H4JNZm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53C21D95B4
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Mar 2025 07:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741074636; cv=none; b=a/KVnEZeoRpFsI7/Wu65Ec2lRrRG7ghOuofrKcXYNqMuJj+RmMEGAsQj2K1DI5F38s2PEp+7VGeY+dAB7lt4C3yLn4+4VgW6exNCi/0fu2kYnVVK6VJQ/w7IIdLJQW8Qnhlu+XDi7nObzujx6U/9YhqN6uguIliDy+/M4GBgZeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741074636; c=relaxed/simple;
	bh=Sx9V8j9WvkTzZy4gRZMU24Z4u6vpVYFz00XeJkl0Ksw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=knPiORb81cPAAPIPxR3acpCa7uQfn4+uOPk5KNVAUVZgi4ZTuyyvHf2phlo8caDtmgPfjXkmIJIrpPT1f7Ceb6OdWtqRrcNxjDl8jnR2qvwtvZIbqehCl8rr2bRdmsFxV7gnRf54iLxlI+BR3OZE9URPWfXsD1GpIy/JGz9BVrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j+H4JNZm; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4750513919eso181201cf.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 03 Mar 2025 23:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741074634; x=1741679434; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7opBnaTkK91zTwVvqpGQooNcrfnRzwyX3+J90n8y+2s=;
        b=j+H4JNZmWF2V49WGRlIJ+hzi9akPpNf5BMsPGkyNk1CWlCu5z16lz9bl9MDgLJ8Bq5
         vt8SigVob2bkmClYkSpr/dnoXfAGCJxS13eYEjpojOYN4Xvug+KKqRlpYgjht0kjUfvP
         reSncC3LyAy7/XTCYAU9CqP3P+IcnKAuuGTWgDsVxa+4078sr3/dHh61+nVRnmCvf7s1
         lgAGC9AxzREN7fqDwfA2ju9TTDYZcmrZEi/su6N8y2S8iGX4yT1zyMpK8snsLyxK778S
         CFGk2gLdjjOCffco/BmLypXwTribBeLxdz7+ZiK7jTSa7JiFDY553beBklDzr9nhwZ7T
         FqGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741074634; x=1741679434;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7opBnaTkK91zTwVvqpGQooNcrfnRzwyX3+J90n8y+2s=;
        b=JZIzmD88rveMgrjG/e7RNIQLBP+uoGS1XsypyGSUOl3UcoRMToszxrdnbeO8Ht+LqJ
         6QYrq+mODbiStUN/edRnmVYgpjtQluJyjzBxpdIX46cm2cksBo2q8CBP8okbN0n0I3Tu
         QWWzI36P067ZMHsKcOwKRWXHwIqlLumU3W1WXLk5NkZqYSJ5UHeB0Xyl2ikdFwyBnP1w
         lseBpe7vY+somJRtvnVPZ8vLTqomy8tbXOVAhM5dHFrkPSlFPdnSLF5Ef1Bly9CWLAlv
         5Pfw1vfNHt+fb7IPOh8VwDZhF40g47ieUpKl4VikTOflqftEgCc6yWm7YvXPfEZ8e2Dg
         i50A==
X-Forwarded-Encrypted: i=1; AJvYcCVRoez5BzBrHEaKKEIVY3fNtaLScvFAJqahadErIJWbJSKat0/iF3IkYe5ZHpkfEC6VH6k+nizO7KDdSXzz@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt/f5FTEogBojlpEmAs7NaXrbUBw2B7AzfMHmw7Y/64Khxb+Z1
	VWWCsRsNEU7k3kUvyaY/HrI0FOdT0pYNFnLQ1E+ZYpv9BWZbH8i5uWmOjTeqxhXH4knkXF/8cKm
	iY9y5EeauEM2X5c88aNzgV+Aijmo=
X-Gm-Gg: ASbGnctf5DjcS5JwTPAhjCspHELXV1bkWDkMCi50NJgQ3W+ARxvhW9jnJM7VjH9bwFR
	pcj4SiU1VxZbsqFqkyjWx8yJoQsydHM/H6ErgaOdRfZ8QT7pFMmPzbGap1B1kanTJtpkOLmbTv9
	gbKe4wGV2dWjlEAek4TwT58T44c06z
X-Google-Smtp-Source: AGHT+IFn0IZQIkkdy03LOu6zWd6AGL559RHNqrnWmiEghvQwBmw26NnyQzgbpbTORBMwWoBfeRg7lX52mGsYVG5CFZE=
X-Received: by 2002:a05:622a:593:b0:474:eec2:56bc with SMTP id
 d75a77b69052e-474eec25b4bmr69452291cf.17.1741074633532; Mon, 03 Mar 2025
 23:50:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Zhiyu Zhang <zhiyuzhang999@gmail.com>
Date: Tue, 4 Mar 2025 15:50:22 +0800
X-Gm-Features: AQ5f1JpkxYI_szKiZKgGQVuSQaGyb6FgXo15L5nLNrC24TOtE5qRgjydwItKYlU
Message-ID: <CALf2hKvaq8B4u5yfrE+BYt7aNguao99mfWxHngA+=o5hwzjdOg@mail.gmail.com>
Subject: [Kernel Bug] BUG: unable to handle kernel paging request in squashfs_cache_delete
To: phillip@squashfs.org.uk, syzkaller <syzkaller@googlegroups.com>, 
	Jan Kara <jack@suse.cz>, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Dear Developers and Maintainers,

We would like to report a Linux kernel bug titled "BUG: unable to
handle kernel paging request in squashfs_cache_delete" on
Linux-6.14-rc2, we also reproduce the PoC on the latest 6.14-rc5. Here
are the relevant attachments:

kernel config: https://drive.google.com/file/d/1s4fpvYKGRUbOcQsv5XZpzU1SVBvqKDZv/view?usp=sharing
report: https://drive.google.com/file/d/1nnlAc-_09lCZIL9gSh4llW5jgFIQ2jfO/view?usp=sharing
syz reproducer:
https://drive.google.com/file/d/13M44vrewnPesGubj5JspZdpnmsPgrFdG/view?usp=sharing
C reproducer: https://drive.google.com/file/d/11JZv7wQ7OInDdId6625EyfFw2jSs4UJc/view?usp=sharing


I assume this vulnerability may be caused by the missing check for
error pointer *cache in fs/squashfs/cache.c:squashfs_cache_delete.
When the kernel fail to mount a squashfs (e.g., out of memory), the
fs/squashfs/super.c:317:squashfs_cache_init will return an error
pointer (e.g., -ENOMEM) and goto failed_mount. However,
squashfs_cache_delete only checks if cache is NULL, resulting further
deference of invalid cache->entries and cache->pages and crash the
kernel.

--- fs/squashfs/cache.c
+++ fs/squashfs/cache.c
@@ -198,6 +198,8 @@
 {
        int i, j;
+        cache = IS_ERR(cache) ? NULL : cache;
+
        if (cache == NULL)
                return;

I tried the patch above, which can avoid kernel panic after SQUASHFS
error. However, I am not sure if my analysis and patch are
appropriate. Could you check this issue. With the verification, I
would like to submit a patch.

Wish you a nice day!

Best,
Zhiyu

