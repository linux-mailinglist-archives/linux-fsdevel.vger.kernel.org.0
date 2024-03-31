Return-Path: <linux-fsdevel+bounces-15809-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 825E4893213
	for <lists+linux-fsdevel@lfdr.de>; Sun, 31 Mar 2024 17:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C85E1F213EC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 31 Mar 2024 15:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5BC7144D3E;
	Sun, 31 Mar 2024 15:41:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D938A22079
	for <linux-fsdevel@vger.kernel.org>; Sun, 31 Mar 2024 15:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711899665; cv=none; b=qH6P9f2XW3h7qJXcm1GMcGnRN6T3WMKvZp2Ee8JPXsxSsH2CsYKI+H36zw3z/sriKpa/MnX+owCGYcLweuHe81bG/2Ll83xUPGceiLfayQefx61FYEocT1BIlgkCSvBPC5JbQmWQfb3D5rVY6fClEd5lpPV1NBjm8izPjZ1Oayc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711899665; c=relaxed/simple;
	bh=Qz+nEJwMajHbpH7CBV1E9kYkMSV/cyOeBB4MlSGQNy8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=FDMhc/lodpWggQ8h6Yo5NTs5sLvSwNJqgeMp5j/ywdJI3ON5wnU+ECRjuZ+0Bc+nNb6aVHamCsvB5b4XC3en/CNmlBD7G8wJHr15qZycYqCfihRXl8BGsFexfkpepy/SGfp+z+7BEPTeWUaxuQUKwq4oPmh7JI86Qwu2yY3wMRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7cc0a422d43so384910239f.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 31 Mar 2024 08:41:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711899663; x=1712504463;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RMPIvofFZ0pzeDlA+dJFHUiRuMTw5ZBBa6f9TDeB6IA=;
        b=JUAiQVmPRfopMyICYCN7hVdrSOCBQQAdjDikeBW7JocLq8kj+LJ85uOx08f43Qsffr
         AxaTCCCOgZ3uYh//5pEJjhrBxmaIZNwjBVkjKHn0LjMC/UAogmukUEKHxu3gvtyMX/Uo
         K5lhJaLzDbkgiXAt5zKFt0OP7C7n5YfTnvdS5A02JcMzlMdSiATlXnN5TIRqHWSoGJHN
         Kj5vvVKMIR9Zfa6Kp43itwacs9d2wNSf/u0Q0gqQ2dxQ7snVV/SmGLAtjQNYLVE2KhFF
         N1lQV5L9VciCz1M7AR0ev0Nm+NqC63NWZawoCd1c50niNaQKEg0Icoxo6pAUO/QIvomV
         +ycQ==
X-Forwarded-Encrypted: i=1; AJvYcCUStfwFOrwekJPZ9qHOJNmy2ZB5sARBf6lTKPVHoBwTvdIyUFZYAnpyJOhjB5HT0Qum+X0BIYXunDkpLCyJGfjRuWFLJt6PietkcEeGYQ==
X-Gm-Message-State: AOJu0YwYexNYK2ZulFHCk4nm53KHqnAEbujgwf09xiCJ60RWQXVYDfrz
	cvfm23dQFTRjS+JRbQRFo8LGj1vEeOaA8ULhTX4ZNxy6k5jQXjjDbOKek+OX1xWht0d8zpADV46
	pEfcnlpsLgf5Bw+wdv9hU1vdpgYMmQwNJnGLfY9y2GtW7Q5vsmrQDk80=
X-Google-Smtp-Source: AGHT+IEs3YkKutFNOonb15d5RKFj0anpMUEzpVWKAAfIa29yd9R+rbNaHMJtBfq5H3RMplyKrtWIE7u7ls65Czyj4h0zrEBkTqeb
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:140c:b0:47e:b7a7:f4fe with SMTP id
 k12-20020a056638140c00b0047eb7a7f4femr286348jad.1.1711899663146; Sun, 31 Mar
 2024 08:41:03 -0700 (PDT)
Date: Sun, 31 Mar 2024 08:41:03 -0700
In-Reply-To: <000000000000e05bc805e99789e1@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000504d0d0614f6b3dd@google.com>
Subject: Re: [syzbot] [ntfs3?] kernel BUG in __ntfs_grab_cache_pages
From: syzbot <syzbot+01b3ade7c86f7dd584d7@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, anton@tuxera.com, 
	axboe@kernel.dk, brauner@kernel.org, jack@suse.cz, linkinjeon@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-ntfs-dev@lists.sourceforge.net, ntfs3@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1636d11d180000
start commit:   42dc814987c1 Merge tag 'media/v6.6-2' of git://git.kernel...
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=e4ca82a1bedd37e4
dashboard link: https://syzkaller.appspot.com/bug?extid=01b3ade7c86f7dd584d7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=118cd46c680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=136d04a6680000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

