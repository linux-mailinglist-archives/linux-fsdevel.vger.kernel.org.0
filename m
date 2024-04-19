Return-Path: <linux-fsdevel+bounces-17274-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5688AA752
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Apr 2024 05:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B4662824AD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Apr 2024 03:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B226BA41;
	Fri, 19 Apr 2024 03:44:15 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C855C6110
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Apr 2024 03:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713498255; cv=none; b=s2UEiO9SffNtLHzWYerhD75yLOmb7XXSPH+YERceu3Yn7vnPOD/tB3GYaOOuKp1sLwFs9Z83HrUU44kOSo7UXACdIfiaAj8cewsqfj6QoMyU/3IjEApQJz88gfh61PLiv6qCIeHae+iUfzoelaMQar9Ig6sn+WvPLh72IcKXynw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713498255; c=relaxed/simple;
	bh=DC68Fan9U1mDvvm9HS7/KL5cq/tCfXtYDl7pvERFoFo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=hIpVF4qhGIM+Y2ng9wOlU8peY4fZmuU2DZVuKKKX/vORQPZHqeF8DE6R1ZGyE66H9rN3H/uNOeB+k4Cz1J+wPAPQJtnsN9k2fZF6vyv8nLBg+bVvQ8OggqSBrlPTWM/kNIVzkbhv3bTx+7jYtgzDBnb3Z/tCcVfwqExhGmwqRvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7d5f08fdba8so280192439f.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 Apr 2024 20:44:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713498252; x=1714103052;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DC68Fan9U1mDvvm9HS7/KL5cq/tCfXtYDl7pvERFoFo=;
        b=wPeYt+ISwtddNxpCe4kdEoxNtnxoe6wara0Ink0KI+Wq6RaHxFgba7vmInLD4bWtwm
         IJhD7LwlS1hiSL4NwHbSOkKRgbEDYH1aboTEgHY9d9omia9d7ptiii6pZF9ckqIcgpHp
         0A8WiEaJyE3inoM+NHbH/aHS5mKJPwk++iCaTvNnwEp3dHdvNZ1JEAiODuuHcF1xNCHd
         G3GI19JCnXcCYmZvYVwdzDvgyoAVbRCVpxgg6o5x6voaIgDXfss7tTf+h6nDgIueyKD7
         XaWtjsuC7qFYGHIDZvZvGFi8mfHhbqKs8nEDgT2SMbXFP0+wZXy0C2vINzApz+cjUGH3
         wudQ==
X-Forwarded-Encrypted: i=1; AJvYcCWU4kg1DV03tTQVEUaSGXxfwtrcPdWwcf+ULo9CvmvMsL8PBmSFiJlwpq8LeenEv7//8jN4Ro7HXzMMoWHrLpGSH3HugBZrDhgBQLX2nA==
X-Gm-Message-State: AOJu0YzW1u7JuS5CSKbOy1Jz3YqFYnKg/pRR6nhP1niwgd5BHx6wWLXN
	WqAlrzTxiZ6oIJLzyZoWrm32C+73LzPGlnSNjjkPjC7pMl58K0kg0f+hTzG8WVvrYuVhLUwFQbj
	EyHzr42zR17mCssAqJq0IP14IzTlAnlNjb12NsYgUws4mlJubEH76+iA=
X-Google-Smtp-Source: AGHT+IH3iHj+p778Prfz/op9yzVlc6IHlFlrPUAXxBsVYGX2Oi9UKR/mPnmrlFcE5vwiibiZppLH/ePr4F6EWdAQHqQL9B0e0mpp
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:37a6:b0:482:fa6e:648c with SMTP id
 w38-20020a05663837a600b00482fa6e648cmr91745jal.3.1713498251939; Thu, 18 Apr
 2024 20:44:11 -0700 (PDT)
Date: Thu, 18 Apr 2024 20:44:11 -0700
In-Reply-To: <000000000000dfd6a105f71001d7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a1618b06166ae6d9@google.com>
Subject: Re: [syzbot] kernel BUG in ext4_write_inline_data
From: syzbot <syzbot+f4582777a19ec422b517@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, eadavis@qq.com, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	nogikh@google.com, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

This bug is marked as fixed by commit:
ext4: fix race condition between buffer write and page_mkwrite

But I can't find it in the tested trees[1] for more than 90 days.
Is it a correct commit? Please update it by replying:

#syz fix: exact-commit-title

Until then the bug is still considered open and new crashes with
the same signature are ignored.

Kernel: Linux
Dashboard link: https://syzkaller.appspot.com/bug?extid=f4582777a19ec422b517

---
[1] I expect the commit to be present in:

1. for-kernelci branch of
git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git

2. master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git

3. master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git

4. main branch of
git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git

The full list of 9 trees can be found at
https://syzkaller.appspot.com/upstream/repos

