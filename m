Return-Path: <linux-fsdevel+bounces-14071-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE408774DA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Mar 2024 03:05:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C54BE1C209F9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Mar 2024 02:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C6061FB9;
	Sun, 10 Mar 2024 02:05:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA8115AB
	for <linux-fsdevel@vger.kernel.org>; Sun, 10 Mar 2024 02:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710036306; cv=none; b=Rwia3XKu7x4uV3EVK45+GadWgfslIHkc7t6EvlF869Rp3a13sL6vB2hwe5rNhfc45EP5J9tQd1cCsFk7w/jf2i6Cl69jSpFmq34xRhnQ7wSDA2gDoaFADjB+S4Tj5SJyaP+0oYJukrceRLZnEUO3SZllMMNkSN9DEscn/a0jCjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710036306; c=relaxed/simple;
	bh=AB9oIgX15HDPukZy2QrbAYWK+ICd94A+UY4Tldqk2xs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=qSR/vJwHZmWrMger+0iDsGEPT5iRUaMahm4nMWM0BxWQfKfiCKPjC5y+qcM1lDbATQkGyhcAgdE838Hz+AnCz6pq6D72u/Pmp/PNHaO7/4kxGhRJrEe0J4YD7xOnmHiqIvveUA8p49Q4xXsUF8ExTMj9fXeTEPhHriB5ur9t6V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7c874fb29a3so328109339f.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 09 Mar 2024 18:05:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710036304; x=1710641104;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eAtcZ0jcmff76E8g+uUmd6ptddX0gjsk2MQCSo48DN0=;
        b=S/f1WaeEktNLzU/p7yBSdIGiYB6ppUpB+GXI6YvyE3AOdrbQE2p6HkhiE8NPApIq03
         baMOKyJ6JPPynGNh4OxSEQZ1mcxR/3fQyzWV+1JYeEsxFxiJgbU1/trQu3QM8eqehANE
         qrhpyV3D2LUUYQCQkauw3G62Irenz6YY7kZGZNs+rfIruVzhhK7UcQ1UAwsdelBqugll
         Kx/WuNFxx6yaU15jB721DGfwBZKh7VZGFmJtWxOQZYOB0JCQ+b1TfA6UcXkOJyQbYmSJ
         WMNYzpNfSr0ASOmAL1dVI8UKSXwYpteMzMxqi1cMW7NU6dJuO5+9qcyo3uLLi7iN0rGn
         4DhA==
X-Forwarded-Encrypted: i=1; AJvYcCWA6wAXv1PVkwx45k7G5I4mj9AOZM7LTiclxrBDMbVP6P7HferweMj228P5GMTH9jEGbDgKDlwN5QqgkoYVnUYoYcKAbdhDUVvkgAftOA==
X-Gm-Message-State: AOJu0YzfTHubUjKef/UMSC0xZ5oQAfDy5Dr2FniP3arUF4RWZLgkoXGj
	coU9T14/5iRFSg/okAYJ0xRzxiPU+fCQLHA70aAAF5tyVcCZBIyO5/nY9Ko/lRvdTb4QI2R/Nhn
	7UJYaewxenQw8aYgQhODY5uK1F5HPd6TNxeEkuoPL8T1Bux5a40psyvw=
X-Google-Smtp-Source: AGHT+IE6e/IIewGxQAV4bqB6X0atmmjTjDjRrTeEujE/9OhtcHQe4bLNbPc1G6ogefC3EoR0pjUbedvrrFrSIyeg1cQ727HyyOZJ
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2dc5:b0:7c8:b219:4547 with SMTP id
 l5-20020a0566022dc500b007c8b2194547mr3316iow.2.1710036304535; Sat, 09 Mar
 2024 18:05:04 -0800 (PST)
Date: Sat, 09 Mar 2024 18:05:04 -0800
In-Reply-To: <0000000000002a6cba05eb5c7fbd@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007c3484061344da08@google.com>
Subject: Re: [syzbot] [ntfs3?] possible deadlock in map_mft_record
From: syzbot <syzbot+cb1fdea540b46f0ce394@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, anton@tuxera.com, 
	axboe@kernel.dk, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-ntfs-dev@lists.sourceforge.net, ntfs3@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12b28b99180000
start commit:   e4cf7c25bae5 Merge tag 'kbuild-fixes-v6.2' of git://git.ke..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=68e0be42c8ee4bb4
dashboard link: https://syzkaller.appspot.com/bug?extid=cb1fdea540b46f0ce394
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=151db82a480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10f0e670480000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

