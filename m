Return-Path: <linux-fsdevel+bounces-19331-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E1928C3368
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 May 2024 21:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF6541C20DBA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 May 2024 19:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB1D20B04;
	Sat, 11 May 2024 19:20:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D751F95E
	for <linux-fsdevel@vger.kernel.org>; Sat, 11 May 2024 19:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715455207; cv=none; b=QKIcPJ68UA7BKymZ6Jc9hc2xqyxH65PNBpe3DcY3gSudo8Paf9m8775fDShlCrB8eXLpbLXeHN04DHSXf3nwHIwxDNld3v2VAG1rE90lePA9wIMhRRkQpYmf/KjVii+2FM55BKkK/gXapjBZGPgqVWbMl3vsN24oVVvGVUcw9hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715455207; c=relaxed/simple;
	bh=+qv5reRo74cVbtPewf0lBZ2jqRG2ETEiX81GoJk+c40=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=EgTrGFCMw3QNHvCiD+ravj5mZBMrlMZFJBwzDl16fYFiC1iA4HIsmswe1PxIIkpi6bBz3D+9E7+To/40EeqtewjTZpvFI2cApIjHrN031lehXeUGU/vPCXYn5nz09NUN5mnMuvQGwjRYTQQR/HGsmdpmyqL6BF20zrG2ndd+Enk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7e1be009e6eso219623539f.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 11 May 2024 12:20:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715455205; x=1716060005;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TU8kylx5Gi7UfPvHnXW2cq5h56a8jRhWapkflJkHeLA=;
        b=cKBY9U4JcuxeC9oNkylbI6mBu4SgpxvIO1Kp11odBhsEAabBTAelEn3rEgbM/ivHsA
         qXQbY3SOiiVyN8qJBPwnOu+pvhRVi2j4iIKsNG0EMsaU624aTfATqYH/T1UoQM8M3YdO
         W40y5mYZEnuCQYGgJj8Atus+v4IqbfJpv9SSnHxCmv6nB6G0so30q2yooIRqFOEFlfgA
         hR28lSEWRJeE9SK4Wehr2ydtsSJH6X8TGvdHod9zJN9QnynkZzMybvx/qsBfTR0/tlRY
         x3NglqyRHjtJ4byITo92tw95Xw87YDHdWp9r+yxEnpgH953nAq0OApRjQGAUdNOGvsAw
         9Ojg==
X-Forwarded-Encrypted: i=1; AJvYcCV/jrOukoMNSPg0XpadvVfHNb5v7bnmbfmPrs0lDBXXMp/p2vmU04pIhfa7d6N6F1tSc/0wPqwZfkPMrK+KVsEfWR04e8lhbd+Tt4m9YQ==
X-Gm-Message-State: AOJu0YxL4E6FvDIeY4SHin1fqbAJkotKfbIGAbPt8A1Dlr062+b/12IS
	7VNcT4ZefL1FIY93AUswqVHQBrYCr51Xj796zoIcrf45HBoONsozQrLNfSQapS11N1KFbne/9P2
	7T6wNxR9feO2fYRqP+5DxgsoVEcp0zZIgQJWXLaYDMg6QPaiLGd2mNb8=
X-Google-Smtp-Source: AGHT+IFQoLKTR0PomMsJmuoyW7oc8rG6EF2EtPkrDu6jPAscIBpu+Im9GhsGHH7rjpezK+/RJ84N2PgFrVl1yUwIXBxs170Q4cH4
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8305:b0:488:e81f:845d with SMTP id
 8926c6da1cb9f-48958e18e34mr397992173.4.1715455205110; Sat, 11 May 2024
 12:20:05 -0700 (PDT)
Date: Sat, 11 May 2024 12:20:05 -0700
In-Reply-To: <000000000000bc3c710617da7605@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002104c60618328a78@google.com>
Subject: Re: [syzbot] [bcachefs?] WARNING in bch2_fs_usage_read_one
From: syzbot <syzbot+b68fa126ff948672f1fd@syzkaller.appspotmail.com>
To: bfoster@redhat.com, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 03ef80b469d5d83530ce1ce15be78a40e5300f9b
Author: Kent Overstreet <kent.overstreet@linux.dev>
Date:   Sat Sep 23 22:41:51 2023 +0000

    bcachefs: Ignore unknown mount options

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=154e823f180000
start commit:   2b84edefcad1 Add linux-next specific files for 20240506
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=174e823f180000
console output: https://syzkaller.appspot.com/x/log.txt?x=134e823f180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b499929e4aaba1af
dashboard link: https://syzkaller.appspot.com/bug?extid=b68fa126ff948672f1fd
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=155c109f180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=136e52b8980000

Reported-by: syzbot+b68fa126ff948672f1fd@syzkaller.appspotmail.com
Fixes: 03ef80b469d5 ("bcachefs: Ignore unknown mount options")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

