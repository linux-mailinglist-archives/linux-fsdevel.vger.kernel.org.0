Return-Path: <linux-fsdevel+bounces-43459-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14DB8A56D7F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 17:23:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32FE0189199D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Mar 2025 16:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AABA23BCEE;
	Fri,  7 Mar 2025 16:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cmPFGhPC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E9423AE9A;
	Fri,  7 Mar 2025 16:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741364578; cv=none; b=bONrNJstaLCaUKzRdIacn4C96ihQURUrGIUUN9nAJaIwmG0ywqoII61HVNfGUWw3OMCZ/a4bAHzZ1zKEztvju63PSb1Ol0IbCW+6rdhOtkDQe9fMNizES7tGmd5QWabBuwg4kFHb/S97PspFf834/JLjTzBbLeJWH4fspJHfhsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741364578; c=relaxed/simple;
	bh=HehM6Qwewq6SkML/mBRVRIlvDs4DMNnNlMIxTT+m/W4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fBxAceu9x+FRi1WmGYSXo5nWG9w0V3HjENR91sskoF3sXNL8k4pGtqbOt107ZbBM7vvKH5GUh7WWnkLRJReX6bMZIqDxXTVqEsamNu7SSHfXR4Hd53j621ftE+zYcCzdpEGezjyBVUQRyi1W265L1ELloznVMbDH0ZQi0i0yPuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cmPFGhPC; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-abf45d8db04so314179566b.1;
        Fri, 07 Mar 2025 08:22:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741364575; x=1741969375; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oQVqDsHdw/+ZjbpyFQkR95KzV9fVxY5AcxcM0fzGq84=;
        b=cmPFGhPCmZyhKzJKfGzzFonnvHNTTTOPemp76/B0WKwkpd6lmYUS01VvvU6f+/oDAX
         xEn8GayQI7wFBE6mME92JxUP58abutMz5F0XwJIRNEyi/l1VlLvOGJEf7RKNh9kew3cd
         t27bfZnjsoVKtMSEtEKRhpf6B0Lx9w4msvd7Q7Qc7IcFfSy2zU/TduKTqzaheq57Mi9C
         EQcN54mdO7eoT7yAJNowVfpTl3Wwh1EWD8VRj/3agvYXhqnzgipicgMSWLNs9DRwRWf3
         xglwtIdWUIbUe8XdPTmOyD8VBXBXQfXSTndpR8mQU8IQGNco0+UgqrCyjtQSpy1gaogm
         wASA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741364575; x=1741969375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oQVqDsHdw/+ZjbpyFQkR95KzV9fVxY5AcxcM0fzGq84=;
        b=KZuijPUZCc/u5UA8OQgdp04vJTRRlHUA6jbVW4SSd3F7Dv1CNwuWxqPz7p9DFh19cV
         Z3U4WAvGo+nsmvJ3uP+f28leud7QOpNvrcspBG1EZv/yRQlTOInGrF9n0HXlU6nM2tyT
         /HFCL1MxF9mkGxQtlm3dRWPnHu4eW9DUrfu061WUYhI4/KgtRMEoe4sWHwHwGXP9oKad
         joH14WbgzZA1YFzmfMjTGqPvGmH7KgNbXJXqrbsGnDlTrIabdstK31vbZN9m5mCbCswN
         D9aLzYS+wcOJ3BjXph/KV7Rrr9GyF7u0hhaz6J/lrxrJkJWW+yadfNmO1SUAGFqiulYg
         ufvQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4sVqkvWEK1vIG5Kn8QSq2Q2s/3OnNeVqv3c6P1q4IXSJz4SHRNnhZ3ILByOt3aY+1/tqPSPsAtkicklFf@vger.kernel.org, AJvYcCU7SbwFQOdhpD4aDsn2NbR5sbYJSGVNLMChEAIACKSGXLR4tmhzUCmm9JQL6TtWnWzSCkUFIt908UxX@vger.kernel.org, AJvYcCV22tFJDGVGvnq9MrwhrZNa4r5jOXewnkjeyA8n1kOfzRP4CrSpslOrqOKm25Hrnj33CGw6eden7HZ52LgE@vger.kernel.org
X-Gm-Message-State: AOJu0YyTrboCB+8j3EkMHO/VvvKHdaKEcCQiFwJhO13ITAyPnjfYeJVk
	/JlQAz2HawMIt7JFAgq380ubFM1J3/+Eexx0P7bSFLt8Dj5NOY4QOHmFvWj2P0N42ELzgWPPaZq
	aRrVls8MW1u2/PH8fv71FcDQ3ot4=
X-Gm-Gg: ASbGncvl+6keP6Mrtf1D4y72rd7Xin5znCb70V+RLPjuXNu2al4yA9HdqLM9b+4LPbT
	xszHJlp/rG+tqgF4c1ihgh3rn3havLVMbkBH7McRumdyRRn9xfc+dnP6R9jPfub6pTJx7mNMsBH
	V828lTQk2AZXTlwh/S4+4fGQl2ig==
X-Google-Smtp-Source: AGHT+IHC1py7w2m8go5VMq6eI+Rzc42CqWn666RVrn7NRiN5dOLiuz60Rlfmwi8JlB/SJZ4s+09dscdh23QrF/ZPBeM=
X-Received: by 2002:a17:906:4818:b0:ac2:64eb:d4e8 with SMTP id
 a640c23a62f3a-ac264ebd527mr153832166b.0.1741364574933; Fri, 07 Mar 2025
 08:22:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOQ4uxizF1qGpC3+m47Y5C_NSMa84vbBRj6xg7_uS-BTJF0Ycw@mail.gmail.com>
 <67cb1cee.050a0220.15b4b9.0082.GAE@google.com>
In-Reply-To: <67cb1cee.050a0220.15b4b9.0082.GAE@google.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 7 Mar 2025 17:22:43 +0100
X-Gm-Features: AQ5f1Jpm17vwPTL_SLf5SNhsDNjexpxmxQEAhre-BxYX_NNk8s0Ac-GhpzbKKAw
Message-ID: <CAOQ4uxjxbhJPDCBnuMMmkPchFiDOwX82-35jbhbrQkbp2Rsy6g@mail.gmail.com>
Subject: Re: [syzbot] [xfs?] WARNING in fsnotify_file_area_perm
To: syzbot <syzbot+7229071b47908b19d5b7@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, axboe@kernel.dk, brauner@kernel.org, 
	cem@kernel.org, chandan.babu@oracle.com, djwong@kernel.org, jack@suse.cz, 
	josef@toxicpanda.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-xfs@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 7, 2025 at 5:21=E2=80=AFPM syzbot
<syzbot+7229071b47908b19d5b7@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot tried to test the proposed patch but the build/boot failed:
>
> failed to apply patch:
> checking file include/linux/fs.h
> patch: **** unexpected end of file in patch
>
>
>
> Tested on:
>
> commit:         ea33db4d fsnotify: avoid possible deadlock with HSM ho..
> git tree:       https://github.com/amir73il/linux fsnotify-fixes
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dd6b7e15dc5b5e=
776
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D7229071b47908b1=
9d5b7
> compiler:
> userspace arch: arm64
> patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D16fe487858=
0000
>

Let's try again - just the branch - no extra patch:

#syz test: https://github.com/amir73il/linux fsnotify-fixes

Thanks,
Amir

