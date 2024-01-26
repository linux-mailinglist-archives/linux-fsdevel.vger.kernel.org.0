Return-Path: <linux-fsdevel+bounces-9034-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A38CE83D2FF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 04:41:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 407D21F2544E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 03:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42054B661;
	Fri, 26 Jan 2024 03:41:14 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D9DA95E
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jan 2024 03:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706240473; cv=none; b=jmkT6fhiNu43/beq0s9cy6qX0/Kpngpxx2jXktZPz1iCAi/uIX5nEtki8qPEu/xhAoinSHu6QfTw05iSLi8iUyVMvUjI1npMp0qab2KNM+BH/ogv/OMaHNd2p92U2QuzNYLDJ55id8cF75n2gKn1Rp74ajuKT8svcYxPMEbBf7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706240473; c=relaxed/simple;
	bh=DC68Fan9U1mDvvm9HS7/KL5cq/tCfXtYDl7pvERFoFo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=b1k8ChIQSVq8a3qTtsjwi3DQ0uEgVEtKYpb8eCqhxnXQ7QCEBdzEtIhl3KHghvPvcdTJKDz3ePz67HmfgsUgn4xLuuSjRK9rN/tf1Asz+Z8Sa9ntEriQZbOL+gDGhKung5q/i6VJYcUoXdxxl35EZcDuRZgiSkK0MPx5T714Now=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3618e013ec7so83426485ab.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jan 2024 19:41:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706240471; x=1706845271;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DC68Fan9U1mDvvm9HS7/KL5cq/tCfXtYDl7pvERFoFo=;
        b=HKYYK3xtBOCC5DthRtm05ow0bJAj3mepMlGKK2oLjTw0QC1Y8gKUc8r/Tr99anUSpE
         4RBX3gXoAmMqU1jg/ANCnQUE/3BLAnFn9Ztt6uukw0V2t2aCj3Eja2ff9CohpYoG3JtP
         d2roDmitxgd+hrnFqSRZvwM7GqQ8F6WP2X8Cif+QrfuQMsUWFF+HNENmR+Nyxfh+JAx7
         U+VJp5hXCKdPsnjTR0bE6FxTpaR/BZgN5SeevndumcfqzlzxsGg3je4T4yl4356HOvow
         F+yRJHqzQ/ej34NbwH1NPsY6yqqwROwA2If5fN8GVeVBLHR7KeJQ+szW978qmCPsQPiT
         MHjg==
X-Gm-Message-State: AOJu0YwGev7jG4hEFSGsWK1PbXB4qV//8brkJPw/8LxDsaZsi8zPhoug
	gSULvbRyKxS+7G8DeKE9ADt/8IuYiFdW40KVQ6dSCadfHhfwJ5/4I3gRpylmG7JJGr/3HUUdd54
	5wxcBh/ccGwv0oRfZWoxH2AsetxU6X5xMFGbIY3KcQHmWPOLTx1PGMeg=
X-Google-Smtp-Source: AGHT+IFz0qxmvUVhvPOqgIrXUDDVpxna4jQPfuOBVEfPvyygebPqZl5fDHsA4+R5BZ5kDHAvmukq1PwEVID+8OKOegIa7MVTh2wE
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:144b:b0:35f:a338:44ae with SMTP id
 p11-20020a056e02144b00b0035fa33844aemr106434ilo.3.1706240471688; Thu, 25 Jan
 2024 19:41:11 -0800 (PST)
Date: Thu, 25 Jan 2024 19:41:11 -0800
In-Reply-To: <000000000000dfd6a105f71001d7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000376be5060fd11135@google.com>
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

