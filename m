Return-Path: <linux-fsdevel+bounces-11368-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F37A8531AD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 14:22:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DC33B22AA2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 13:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D6E55E43;
	Tue, 13 Feb 2024 13:22:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A9855E41
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Feb 2024 13:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707830524; cv=none; b=fpKBf/jvdfasEcYQwMI4T+cKH9M+cU7PbgEcPQfy/SOTnTEuv+H1dt4j6T+bYK3YtxrAJgEHdB0vV0qP5XcRaPHYvzuJfueFbG1U5AbAyE0/qM3P1YZWVHtM2CuwdSmjS5O9mi3QmtlUf1fwPLznz93s3w/pq3WeCqvZVtSkgIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707830524; c=relaxed/simple;
	bh=WCWqpEWxIIzybG/fHZHmHyhLo+i18DFBT57pGNH7hN4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Emk/F4eihXm0+PaYqcgcGiDUWO5H7IRRSw+ycq706vMyqSpd5cGIZ3YQn1KYqz4Z9HrTbbsQqkYyrnju1qJviJVf6QzuK49Swoh2dBWqaMtwtDfoXJtgzDgvZQVFiOO6q3aCAuI3wv8YuUObBrPsOcdgRm9otbfCGfOUSLZLClY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-363befae30fso39798945ab.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Feb 2024 05:22:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707830522; x=1708435322;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gYC1BcP9cXtmRiUh/zwpL7m1Q5/5Z9cxadj63ttyamk=;
        b=cmKgWl0WVIKKht5BZyf5bfZLJH/Det5GPKg6uhxen9a4oUtB0aDKCXxuz5Sn/r1wMQ
         6Uzi0PTIZDWvXpTmut3rzhZbMzUZXYrI6pQe9PcMOfWhOhkOwgOSlIWiX54PnUxCx4ei
         LJYw1R1yZHRGpI2C53gvUtv/lnwMi2TFkzVjet7dGlQjyB5rN/B1Txovw8FdWmsx9HRc
         YGmi7q1lRRw1Gs0iprhcAQWmHVW8uFlVDALw9hivZsfp+34hYwWF5+03TGdiIhUmgK/D
         0oKM+dkWlTM9AhQ9HQ2E/48JuAc+Yungt2378q6WX4C+CVl9TSrlRNjX0Z2Uvcfyg5tS
         zqaA==
X-Forwarded-Encrypted: i=1; AJvYcCU3Ypdsjaud9BOTSBgJ6zYZMj/WE2vP7Tk9dUmVmfgXMzHgtJVNhF+vTf89yXDM4ZcE0iBwYGARuNjRxyup2LmvGcDMX9zzuk4vJtH7Yw==
X-Gm-Message-State: AOJu0Ywb7fIIUl9ShY3LeZqb69TRWstNMOMiSRwyGfrc1R7AqWXXmfqH
	ekktk3yZFi7EqxhhnXwDyyWTHIbIggnnXoclUienkEgPKRBd5PTe2cZjQg48FkC4nDS4/ff2+hG
	DrzjbdCQ8bc6l99sBmu8Vtg38OzZEV0YB+KW572YCHXCyLhlk8KH+tpk=
X-Google-Smtp-Source: AGHT+IGXI9Iojtpc1dEyKuCK0zBZZu4EdKWp8NMzR1lQhvbivqq5MzT9OLkVQE3n8Drb6/z7HxEtFBz5mx7G+UHYnIpXgZl/rNDk
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d8c:b0:363:cc38:db22 with SMTP id
 h12-20020a056e021d8c00b00363cc38db22mr845029ila.3.1707830522756; Tue, 13 Feb
 2024 05:22:02 -0800 (PST)
Date: Tue, 13 Feb 2024 05:22:02 -0800
In-Reply-To: <0000000000000faabc05ee84f596@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a545940611434746@google.com>
Subject: Re: [syzbot] [btrfs?] WARNING in btrfs_create_pending_block_groups
From: syzbot <syzbot+5fd11a1f057a67a03a1b@syzkaller.appspotmail.com>
To: anand.jain@oracle.com, brauner@kernel.org, clm@fb.com, dsterba@suse.com, 
	johannes.thumshirn@wdc.com, josef@toxicpanda.com, linux-btrfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit a1912f712188291f9d7d434fba155461f1ebef66
Author: Josef Bacik <josef@toxicpanda.com>
Date:   Wed Nov 22 17:17:55 2023 +0000

    btrfs: remove code for inode_cache and recovery mount options

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=113ba042180000
start commit:   a4d7d7011219 Merge tag 'spi-fix-v6.4-rc5' of git://git.ker..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=7474de833c217bf4
dashboard link: https://syzkaller.appspot.com/bug?extid=5fd11a1f057a67a03a1b
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17887659280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13ac4e93280000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: btrfs: remove code for inode_cache and recovery mount options

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

