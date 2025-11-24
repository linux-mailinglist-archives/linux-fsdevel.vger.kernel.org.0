Return-Path: <linux-fsdevel+bounces-69615-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A0BC7EBA1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 01:57:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C05924E1AD8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 00:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 918A01ADC83;
	Mon, 24 Nov 2025 00:57:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98CF19AD5C
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Nov 2025 00:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763945825; cv=none; b=G0urMs5DkUgpQts0aV4dpMYvRylxIqHUfzfk6cJfHlYTjBaKmEzpjY/Zc0xV6Waq12mK2I66OTmW1JsS0ErMzYj0e5VeUDkUq/6xYb4OhtzjhvYdxhgNtZdCOAC35IHBTR1uwFJmQ37orioGlZ2nbyVdKnMW/+dIhXXriFVsS8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763945825; c=relaxed/simple;
	bh=dpCiPzAIeVgX5++J/5+WfZ2c/FVoGFonloJu10MAfFQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=WnrmpOdozYK1Q6b075ETem4lclGxI344wFukThk/xP1VcoGalQTHe0mli8nUJNuyOBppI4oC7KfSk3PSI+3Dbi9eHUGV90p56OxjrZDcWvKCPQATg21wZB+LqfHhPp7bmGP2+JezO8VYl3mMH4saWfkMlQQtfopsmlvdRQnUK5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-43321627eabso40246685ab.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 23 Nov 2025 16:57:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763945823; x=1764550623;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m/4fCOC4PpktK3rYrYe8yxO/WowO2dsX2aVI3vzm/Hk=;
        b=SmTiem0qcLrDCWOFYkG634d/DzN3/1aM6bVWA4+yX7sgEDFsU9q/NEXzrNJWQm2rcP
         0Y6uPRQuYErnKMgiUZsawnuj0oo9rzt180j2rY7MS7H47EN5r8SQ/qZvkdWmbGX0P339
         1LYpZ8iAh1QC0Ln1GN/lW2GPJqZoArxYmufe4WKsK6NTCgDtwg3B3mYnHhi3D7iR/IDS
         tmslB+x169jtGJCOKMrznz09/0adDRMiPa5al3M90uv3hq8SNv9CCAJ6Lt6jXP1Fqaw1
         PeSot1/H3GI/4V8tj7ZkbM3TkgsbsBIS9PsimYZZjOI0EP9VwUsvUgufcSf21OGKxDD3
         8YVA==
X-Forwarded-Encrypted: i=1; AJvYcCX2mU/p8c30PeEjk42lwm92Mmv+WBJDIPnBlqx0RHYSzXgtbZYYBR6fq8d65wrRAnYFB04Z6pwbpglJR4wo@vger.kernel.org
X-Gm-Message-State: AOJu0YxZNqmAya920HfehivPdXW5rLR3MYkn+sQKkjc9vpL2NKVKDAto
	Y6fQ68769ghkexI3yHJHgUpiUrjQFvaADtfGQi6JJk9WC7GLgr97s20wnxgaJ5kS0+ARxgZtUBB
	5D6S4/RtPLGZRe8hq8fhFylTUxcfGEGpRaUmypqtMd4tqv4n9nXXyB+BhY54=
X-Google-Smtp-Source: AGHT+IGDPJeEfOF4zHJaIy56M2IFQH/x2aTvGnfAbNijVQ5EyaL/z4SquIw9K3hsr4+SARQmeqYdjSBb3AaU8xegrWbXWCIsBGSe
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:19cf:b0:434:96ea:ff8f with SMTP id
 e9e14a558f8ab-435b98f0a6cmr78245265ab.39.1763945822935; Sun, 23 Nov 2025
 16:57:02 -0800 (PST)
Date: Sun, 23 Nov 2025 16:57:02 -0800
In-Reply-To: <6q2lk36d7ylpqu2vyb3tonxniebiwdhdygbudoi5osmy2ebdtx@4luyu7tw46sv>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6923ad5e.a70a0220.d98e3.0072.GAE@google.com>
Subject: Re: [syzbot] [ntfs3?] INFO: task hung in __start_renaming
From: syzbot <syzbot+2fefb910d2c20c0698d8@syzkaller.appspotmail.com>
To: agruenba@redhat.com, almaz.alexandrovich@paragon-software.com, 
	brauner@kernel.org, dhowells@redhat.com, gfs2@lists.linux.dev, jack@suse.cz, 
	linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, marc.dionne@auristor.com, mjguzik@gmail.com, 
	ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+2fefb910d2c20c0698d8@syzkaller.appspotmail.com
Tested-by: syzbot+2fefb910d2c20c0698d8@syzkaller.appspotmail.com

Tested on:

commit:         d724c6f8 Add linux-next specific files for 20251121
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13f3d8b4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=68d11c703cf8e4a0
dashboard link: https://syzkaller.appspot.com/bug?extid=2fefb910d2c20c0698d8
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1347d612580000

Note: testing is done by a robot and is best-effort only.

