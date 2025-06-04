Return-Path: <linux-fsdevel+bounces-50576-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1470EACD726
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 06:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 821DD7A20AC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 04:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A556A238C25;
	Wed,  4 Jun 2025 04:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KY+PbvZc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF9C1388;
	Wed,  4 Jun 2025 04:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749010915; cv=none; b=q4BV3ENEtoPlqmzebzrSowxXmWbR5JsrHvSOZv4Kg3sVRsIoxDFU885RBFXwePDr+AFzKclLI9JVCEEXmhhj0sa84f9sH8DjfoyAbATmssq2PNCJAxM9I8ALEvQFN0tb42Z4iFaOC1SF5SzS9obGcAvoOE9QXkJNXVDP7BXj28s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749010915; c=relaxed/simple;
	bh=jmb1Fi8ZoY6CJGJNx/3qumvn+jMaoR6ifzalx7l2Slg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=TZi2cn/89by0ikmqxsRvTDmg6xqfUubT/Q3Y8nsLTOdN0x8B6ohbTBwqYZQhwHjhuZzEWgcuov7bT6bqi/9LneIyTGVF6jkcXPsN+/r/h6tY9J3WJltgFiaYIhcSx8rU0O7xNXUCb07n76N3vZADpQpJ5/cDeax7VK46J4Sa71I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KY+PbvZc; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-32a72cb7e4dso67698781fa.0;
        Tue, 03 Jun 2025 21:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749010911; x=1749615711; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3korSg4BV8iGE1dWsrg3byFaUQC/z+f/O1vExZgtK0c=;
        b=KY+PbvZcZcHqRl031l4eIcUIx3Edu7T1lJrtvwtErq39ImumXiyOLKIUQwpygUMDSw
         +OPk3aKyE1BaCZKkKFj97Bt5JQetNDB4xh/5N1lr9aXcCDVKBIcv6sRlnmO4qFV3myTw
         hwuDFD0OG27x2b7g1czhWsVS7CKYQlpdyHN5Ysts+ekwaP7ZR6tf2pA5fakzlA/2WbKA
         DoVI38bKQWEtUuPnHkyAsufrHcCZ7hSw/w71TZ/gI+bwEWD1JbilAUWlEhjaB/HpRL2s
         LcSbD/YfMKn+XaG+aQEQH1Y2pl0ltgbk9ae+ZsLpVQXbga2jIc32bHWYQfW4x9WMPfUP
         5FXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749010911; x=1749615711;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3korSg4BV8iGE1dWsrg3byFaUQC/z+f/O1vExZgtK0c=;
        b=oEpDoGIClKH/8aHmlvOR0tNIqVsR9+gpnI2tpDWXEFcvvtVMk+sq0VpgNHCti7jcZ8
         e9R+FJy6dZ/jsOwquZy6bS0sAT8uwSxhkdUMe6C5srpxkkb7BW4w3wL9XBjbN5b8XcbU
         EOcbmoOPYE87kjwyS/dTcVkO+odPgRisa/gyrkbhuVrQRhrCqLb213iqvqdy2pk8aBwe
         r8siDp9YVH/xMrHymgn2V0MqyACxIajdO4yx26PuVWfEj3o4EZYrJkVuaJ2PqGJD8rVf
         8juSjICk/qytAKv0+aF7vPJswmj4OCuJ9yvnSYeRmB+3IcXrZRta84P0Qb/SSUQVy4H4
         OrgA==
X-Forwarded-Encrypted: i=1; AJvYcCU7cotTmGGEmTbBNgeLPHouROe5IBUYYniRvhQgoWIHNNMgbdapx5dPHpkLm1HEaHgrGCe4TDvofYqHYLIc@vger.kernel.org, AJvYcCVjqsLF0QVVkNAVODV+U2Tdl1xIfEA+s4OAskKO3o1xPy0cl6bWLUSl2UsEwhGNPA++kcwsKxVb3eh+0ztt@vger.kernel.org
X-Gm-Message-State: AOJu0Yxuuu1MSQyXa6OX7Lj3qLQn1dNiR1t6l400cAsBrSZZGB2JzP5K
	YWcgCnoOBphPVab7gxpIwD6sz64OChZGmgfjRGSayFk9cwfdZvyCSSMTD2ntm6Vk+NcvavnRMLl
	/l1Bf0a1R13IA9EKkF01UrmCMkxqb7bM=
X-Gm-Gg: ASbGncv7Y1Yemzqyz2KKcG1dODBSoLYxQgqfeQBBt9sISHiG6iYr1IHf/IiXSwwWBBI
	j6FI83zLRTMVQV9cnE04WsELeH2wG+malKGmwijfmYzPDVOU5WvKx6hgdhBdVIhF/qz23/ryPJd
	wW2TF/3qcqqR5eyjB1ELn2vKD44zR/Sy7qoTnSul2ZhRNeIA==
X-Google-Smtp-Source: AGHT+IHQ/6RiFxDSdWfrJdccyCqO+56xt4aEcaKBaIQgnEEucK89OpKo/2XhcfAGTdYyh1RgLdEbkjQMDUayZtJcMZc=
X-Received: by 2002:a2e:be8e:0:b0:32a:6566:8186 with SMTP id
 38308e7fff4ca-32ac713ef26mr3459771fa.0.1749010911403; Tue, 03 Jun 2025
 21:21:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Luka <luka.2016.cs@gmail.com>
Date: Wed, 4 Jun 2025 12:21:40 +0800
X-Gm-Features: AX0GCFvmqFxN-U5NxZ4lAoORgivsDb1CJ2DqH9brjRYn234JLx6d9-3ml8OgUjY
Message-ID: <CALm_T+0j2FUr-tY5nvBqB6nvt=Dc8GBVfwzwchtrqOCoKw3rkQ@mail.gmail.com>
Subject: [Bug] kernel BUG in may_delete in linux kernel v6.12
To: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
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


Bug Location: may_delete+0x72c/0x730 fs/namei.c:3066

Bug Report: https://hastebin.com/share/amuhawituy.scss

Entire Log: https://hastebin.com/share/oponarusih.perl


Thank you very much for your time and attention. I sincerely apologize
that I am currently unable to provide a reproducer for this issue.
However, I am actively working on reproducing the problem, and I will
make sure to share any findings or reproducing steps with you as soon
as they are available.

I greatly appreciate your efforts in maintaining the Linux kernel and
your attention to this matter.

Best regards,
Luka

