Return-Path: <linux-fsdevel+bounces-10776-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0EB384E387
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 15:57:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCB451C250FB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 14:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3D67AE59;
	Thu,  8 Feb 2024 14:57:11 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A9A6BB36
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Feb 2024 14:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707404231; cv=none; b=LozbZPUS7+43NdZz0zTQsyFtYFnc9Ov9U6/RszzaJn05RzrMT1NpAYK/Nyc4nxijh+R7lDXm9Y6EJ0xRAjWBuI0C5dkUsIXmVABZCjdyYrqJMv6woK55o8KRd8BC+NHC8sU4Q/mvIUR3IanhYfDFzDluBe2Hujq9qd/KIqJCbrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707404231; c=relaxed/simple;
	bh=EcT89sa0CxyQPOU9UiYTX07w8+mCU891y6BBe80654o=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=AyGXS2XcegOVzB+RjyOIC/3sbnZadkRkoEHoREc4XE/1p8Tgn31r0ffwwu6kjg+ryk2kzj8+lpMTto+hNyYKb1+EAZNtOvE6TQnq10btR4TQnx8VI5XD4H+iEu0csjqHrknpQqQ6qW4lFDxxx+zfoGClaC7cbca5dZroudeEhSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7c414467bc2so37438739f.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Feb 2024 06:57:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707404229; x=1708009029;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LcJiD/mRara/hhLkrTg732ODmYQ+uP41FmyKJ/8GEkU=;
        b=i5d6kJvjhjg8PszS/T4VU/yyDRMBm6SNva0vaRC73se/YkGn6LR5ftgcHxtfFfUoYG
         0riP6Hi9ZZjB2nEfXi/61T6jQ267JP8GoGDePMCuPGDmhTe3FVnsuU7Sq76Vt6ZNtQFW
         2WGFu2hXiLuLH3Di3WjEAFXILz9hYa+0jr99rVPbdQKwsR6T+nHJ0pcvhbQaslLgftzK
         VGGwZGXvFH6jBt8LCYrWh+mideQf49WjSOQksr839jqHTeozjCxReLOgxphqF9o6jVSf
         kazI0qXlOh6Mr9DeA8mO2VaySaYQmx7Xnj6WkPJZ+4SQ7X0c0ZMGbivcQJh99CRKU54A
         65wQ==
X-Gm-Message-State: AOJu0YzBnfgDn0SsxydFkWWVN2ogXunFldVBLQXFkuzKcC2f32GY+ujc
	IaI9k3kNA6I6h0P+a88CUx9lAiQSjFldONCn9bEiK5RTF1j28lUyQK9dvsvZM85bYkZB4BWr12x
	6los7QjoAhU7UdCUfR7YSQWJseWMu8wKTLWyqNxCDalcfwzAbhFTjRmQ=
X-Google-Smtp-Source: AGHT+IGRyXJH9KkquSL5YHNP2ZJcCXVn/DbIJyhV1FaZoSlUL5Enc9Ksfp/fkqadCiyOutNlQQ+CpnxukUxtJAJgJUaWJqCk16IZ
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2d8a:b0:7c0:2e8f:8a3a with SMTP id
 k10-20020a0566022d8a00b007c02e8f8a3amr413393iow.4.1707404229237; Thu, 08 Feb
 2024 06:57:09 -0800 (PST)
Date: Thu, 08 Feb 2024 06:57:09 -0800
In-Reply-To: <0000000000001e48350610dbc5c5@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009263050610e00681@google.com>
Subject: Re: [syzbot] [gfs2?] general protection fault in gfs2_rindex_update
From: syzbot <syzbot+74edb1a3ea8f1c65a086@syzkaller.appspotmail.com>
To: agruenba@redhat.com, cluster-devel@redhat.com, gfs2@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rpeterso@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit de3f906f0af0c3f5d862b07df4d020c9322cd9c3
Author: Andreas Gruenbacher <agruenba@redhat.com>
Date:   Thu Jun 2 20:15:02 2022 +0000

    gfs2: Revert 'Fix "truncate in progress" hang'

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15f06904180000
start commit:   547ab8fc4cb0 Merge tag 'loongarch-fixes-6.8-2' of git://gi..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=17f06904180000
console output: https://syzkaller.appspot.com/x/log.txt?x=13f06904180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=89a5d896b14c4565
dashboard link: https://syzkaller.appspot.com/bug?extid=74edb1a3ea8f1c65a086
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11395147e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=126ff68fe80000

Reported-by: syzbot+74edb1a3ea8f1c65a086@syzkaller.appspotmail.com
Fixes: de3f906f0af0 ("gfs2: Revert 'Fix "truncate in progress" hang'")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

