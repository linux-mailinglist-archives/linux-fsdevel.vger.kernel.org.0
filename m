Return-Path: <linux-fsdevel+bounces-18895-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E72188BE102
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 13:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DC511C20EC3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 11:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E1C15252C;
	Tue,  7 May 2024 11:30:08 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8574E15099F
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 May 2024 11:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715081407; cv=none; b=TVM+yXCo+KuYjKqkStKp7A6xykbzCEATFy0hnWG05IU8EAZHHirrJqpZw1+YFHpPPftdMR7UiAap0J+cQhLImjwcJF0WkddgosqLwST4z6XFfTKZNZUNbHi8U8a1qhf+JmtpEJcE5GkvNiYgcDx8ZZ2HP7M4rCKhJePeq9nBILI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715081407; c=relaxed/simple;
	bh=ouPq1ImQr6BwL9gGhpva3sUJq8ov/1/P2vWzjlb0qCM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=AlDp9iAUIOEjN9FoFzuPbVu7VehzvOElQdBYUFEhTmfcv0nbS6eoRjDT6xu0ydO91eGiC4ky1iopyR194q2JL9ueiC2LGSzOJbfkhSnxJD4WE8CbNd2zP1hT2yL+vUd+qlIVHSlMgF+2fJ7IB6NW4EC11AD4aD4mU4sDcaJQmo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-36c6b24fd6eso34928045ab.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 May 2024 04:30:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715081405; x=1715686205;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4GUfzj+cOjI3lTKUNiWMDeoLyX1063O2jyJpXjnx1eU=;
        b=ageTJ45ZjkiVB9uW7pCN8EIgM7W9lELYnJqIzxgX3qyIWeo8iX3ZBvbnBOTipcVspx
         2OaSCtpEbhMv58aL+XBSi8MRoh8+BjqtU7XDvgZyqak+foDuNB62n/Pi8Q2IV5q3600e
         Ewg1DIT+ZeBi8mUpr4RktQzjZvm9YBCPZ/EwwaKuPkS48IWsNCJ4tPfO7pFZ/JT9R80Z
         WkVeIenWvLwX0NGCM9O2OXFGCL3+v/FFXtjMPDhFCv2kGrNLAqPMdkVx60KV3IFevjk5
         ZDonBajRZxpPRivNHhcBsXdlEsrSBxQIzY3MwFBzed7jqfJ+IQgVN6mXguPNZu5cyJyd
         5ZuQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5A3gsDpw2xvuuaIvPckLCXWPA464lT3hF5xOCFBMmOEnt9AcAoRFEUO2o+w4IG6QXc/GKzrgosk/EZjvH8bmUhEnlvWmj6M9pD7rHMw==
X-Gm-Message-State: AOJu0YxYZgHfFyQE8eFftILHKyq2yhYNLftc9qNLofrZwyEbjvU9pvNP
	110iqLG4gnOWK/jukAXJ2Na+zmJWbmEn4ILbUQ3ukYafSdVs7VbqaVrBYwVGbVXO+yReoKdZhVe
	sPwTFMwUS40Nu4tR/56kXC6ze+CaHjM2gvn00iMBU70TUNQ1oxrDIlMg=
X-Google-Smtp-Source: AGHT+IEEu+uyAPb5jfl94XXMEfkVdZKh2KktG1jPdpJKDY6RdnOaOMt++iU0b26vxR+0bwAPkh+Xj0GoymWHrPs9skgHW8bkTELT
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:216e:b0:36c:4cc9:5923 with SMTP id
 s14-20020a056e02216e00b0036c4cc95923mr740783ilv.2.1715081405751; Tue, 07 May
 2024 04:30:05 -0700 (PDT)
Date: Tue, 07 May 2024 04:30:05 -0700
In-Reply-To: <00000000000067ff3c0617c603c2@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f370b30617db817b@google.com>
Subject: Re: [syzbot] [bcachefs?] UBSAN: shift-out-of-bounds in read_one_super
From: syzbot <syzbot+a8b0fb419355c91dda7f@syzkaller.appspotmail.com>
To: bfoster@redhat.com, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 03ef80b469d5d83530ce1ce15be78a40e5300f9b
Author: Kent Overstreet <kent.overstreet@linux.dev>
Date:   Sat Sep 23 22:41:51 2023 +0000

    bcachefs: Ignore unknown mount options

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=149d2fff180000
start commit:   dd5a440a31fa Linux 6.9-rc7
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=169d2fff180000
console output: https://syzkaller.appspot.com/x/log.txt?x=129d2fff180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9d7ea7de0cb32587
dashboard link: https://syzkaller.appspot.com/bug?extid=a8b0fb419355c91dda7f
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=135bf574980000

Reported-by: syzbot+a8b0fb419355c91dda7f@syzkaller.appspotmail.com
Fixes: 03ef80b469d5 ("bcachefs: Ignore unknown mount options")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

