Return-Path: <linux-fsdevel+bounces-38729-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65BF6A074C3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 12:33:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8310C3A7235
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 11:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E89216E00;
	Thu,  9 Jan 2025 11:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="m1C9ZDLM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834B520409A
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Jan 2025 11:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736422394; cv=none; b=YQQ/54UvbiMrzK6Qn2qgEHYBuahDpUtRR0idHET+YUj22QjiuGziHXlEBftf5o0GrVvMOo6C2Vl2Vd99lsHyFYwdj+oFYlyyHHfLhD1a5i6xTiuClvjZThccxTAooLMPolRZOE12OWnQhb7yKVNzWbDW+90wpO7/fief+b/0PFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736422394; c=relaxed/simple;
	bh=4DhZ7h+hC/wW/6sKaxaXfjhYlhEkQwNVKexSkchilg8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I23RmttrgMyQvHnEC6EobnOii/fckBbhdUSnAEDM+uzl4YTl+SHXyOPWc7Bz/kVtqPATkNfVNpTd2vLZCg1yi2grHAF8OIoWoNVEno9ZNc2TQL3WprXmyiHj7AYrQbTVgnGb/3yoa4ZVGqUyuH6Igsbwm4s7CEZU1NUhouDlunw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=m1C9ZDLM; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-467a37a2a53so7832031cf.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Jan 2025 03:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1736422391; x=1737027191; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WNvfIFwlqP4QKBZDPopcva26qRyXQCS+MMSSoxP4bMA=;
        b=m1C9ZDLMUIb8thLAPVkZpyIIzUkGpIRedwqoAbL8gy+YNpsIiZ6HZuZsf5n1cHVk2/
         QT2egSaB6+TjEKoTyW2ufCYR0iPRt78Tk4eVkWNx6P56ph2mBRyRzQrYexxZrdeQ+JYj
         67/7b+TtJGy/RjU80eRSPayNDA275vukivfUg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736422391; x=1737027191;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WNvfIFwlqP4QKBZDPopcva26qRyXQCS+MMSSoxP4bMA=;
        b=bbLkUu/8II3ej8Shk7WSbuuf8exhGhKFi2f55dOsj/5mVJ/ELf/X/kdlODDt5VpKqP
         rKtwucXuMvvUDKfaupsEcMHrSKewc/61Jp5LU4yqaASTU1Qjj2ulnCo1/2ZzhpHNs7cY
         V5x9gxC1eND99BtJK6p5cB5qRrl4OMK4QFen0MIvJXS+fu+hnAjAcAtKcF4l4PoM19QF
         axev9j1l82cneeijTF1qB2sd03e/9Jw1O7Xml3NHA530lWrW8xEkN+WMG0D0dJs5oeyS
         p3NYBUdUnvpon9TEh5/k0pSi3p0NCjdwexa7TnME9njmpl4kScthtSYRoJ2zr+TJGHwL
         JuaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGqI6iRkYI70HSQUmwKy0NLnPeTWsPK2fDoc5LJemvsQiclZ3SFUEbZg6GGU+DCDYNQQcrEd25GC7SnH4J@vger.kernel.org
X-Gm-Message-State: AOJu0Yzcod9CCFPzWeDEHpbz6buPUAIH37HkdCd3l4Ed6x6zlk3vcMZr
	gzRJzSh3TR0PCBJ1DASV5TH+IbuOmLpy0NuqNGmyhnkxGWNaqC49FUdke9DlgXA00Jw6TtDn2Q9
	csHq9W4OP/qB3hMZVRQzEVyq5B/jNJJESFXM7fQ==
X-Gm-Gg: ASbGncv0w5OC/Wb8TxjzjvkA3s4wIamFuGM2E9fHQxPEKllC1n6veLYtnFEqp/J8qka
	V8ysBvOtOZAXfgUU22Uo8dILTjNJyY/aguZkRDw==
X-Google-Smtp-Source: AGHT+IFwF+BHLu4NVU2ZonM0UoppSCIW2Fzyjm5SsBV4QT8oZYr6lhlTVclwDivrwtcyfckItJp3sye8V8YUGJ57Tio=
X-Received: by 2002:ac8:584e:0:b0:467:7295:b75f with SMTP id
 d75a77b69052e-46c71083e8amr105665531cf.38.1736422391181; Thu, 09 Jan 2025
 03:33:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000003d5bc30617238b6d@google.com> <677ee31c.050a0220.25a300.01a2.GAE@google.com>
In-Reply-To: <677ee31c.050a0220.25a300.01a2.GAE@google.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 9 Jan 2025 12:33:00 +0100
X-Gm-Features: AbW1kvZzJ5lz6Eb3KKrjH-1AAR6UFCjTUY-4txNP5rEFXavvONhHexqYFfIR2Cw
Message-ID: <CAJfpeguhqz7dGeEc7H_xT6aCXR6e5ZPsTwWwe-oxamLaNkW6=g@mail.gmail.com>
Subject: Re: [syzbot] [overlayfs?] BUG: unable to handle kernel NULL pointer
 dereference in __lookup_slow (3)
To: syzbot <syzbot+94891a5155abdf6821b7@syzkaller.appspotmail.com>
Cc: aivazian.tigran@gmail.com, amir73il@gmail.com, andrew.kanner@gmail.com, 
	kovalev@altlinux.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	stable@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syz dup: BUG: unable to handle kernel NULL pointer dereference in
lookup_one_unlocked

On Wed, 8 Jan 2025 at 21:42, syzbot
<syzbot+94891a5155abdf6821b7@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit c8b359dddb418c60df1a69beea01d1b3322bfe83
> Author: Vasiliy Kovalev <kovalev@altlinux.org>
> Date:   Tue Nov 19 15:58:17 2024 +0000
>
>     ovl: Filter invalid inodes with missing lookup function
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14ef4dc4580000
> start commit:   20371ba12063 Merge tag 'drm-fixes-2024-08-30' of https://g..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=d806687521800cad
> dashboard link: https://syzkaller.appspot.com/bug?extid=94891a5155abdf6821b7
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1673fcb7980000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15223467980000
>
> If the result looks correct, please mark the issue as fixed by replying with:
>
> #syz fix: ovl: Filter invalid inodes with missing lookup function
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

