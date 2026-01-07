Return-Path: <linux-fsdevel+bounces-72633-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A0427CFE878
	for <lists+linux-fsdevel@lfdr.de>; Wed, 07 Jan 2026 16:20:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A893A30E1398
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jan 2026 15:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF0FF34CFCE;
	Wed,  7 Jan 2026 15:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eb9MqU4t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805F434BA54
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Jan 2026 15:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767798322; cv=none; b=YDenXWWUQC6B53Lt9Ag8gGARyZ8w21oski9ITjRyxxLNruJULtIWjq/Vkq3HDsOKBb3ai0qTxXjLq/sfexxemkPZJrl9lgXNHoChliHT/i5IlcxaVi0Q+1B76UmAWDCi8rtqYYIHQjK8h00w9IbpwatEZ3rzr+ydI+qlDbGApnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767798322; c=relaxed/simple;
	bh=XUNlvItxm3TZLUaQyYhBph0TR2dFw3Yccpa/GJ53Gbs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TXnWiH1kBhfpWxDNvSGcPYSyYhdhj2s6xbXEkZ++ElpKAq5qGPW4h8CwmwCubI5c4JN6fwtanGfd2K2kiW8B8onyRuOc1fn6HJSWOYooxG9Hc3bvYjPNYkx4MOw1rsJjS3kN9cnuf9GVQr5PquVB7zfBeLB1ZDajy6z7nw0irFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eb9MqU4t; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-64b83949fdaso3460089a12.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Jan 2026 07:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767798319; x=1768403119; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8VKA2k4TAi/PruQ5v8EVVWKfLEydGdRE1MHXVZIlbOc=;
        b=eb9MqU4tNpvaWbN1cmvwEdPm3+mu7YLCqZeINs7nyKUgfewQuTchKepze+yxawae4v
         BEQY+MhaapchoKkhZooQhVQgzzrxFWcQ5ivRnK9ko/E+iIgamgSBByZtF7XrbuRAndT9
         4YcOuEtOzNd5/ky21DblgqMVLGF2VwZlYi5ZjRpXCsh/akbRKFgaN1DVp9M5vBdfSigz
         k7NwZW87LpeTXaJg9I03zEgB/pb1idfWp+LL181fHQ6D0SParxKA0wWdZWHFKWzKu/he
         Io8THnWV8BNctPjPe+RwJtJ0jqxq8sSQLX4AlYPIuQcuO3UxsrX/7ZNiPUdwnvfhWLMv
         51Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767798319; x=1768403119;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8VKA2k4TAi/PruQ5v8EVVWKfLEydGdRE1MHXVZIlbOc=;
        b=i2fvC8qgzrSniJAjwn0/ARJGTsHtWPpZNyuWMMJ760R9AeopNySWnZKEhtxMbc/IjH
         JQb7yF+dreJ30z0xSy5BwR+Q4+3THzG+ys2rZHSr6art++u950AYZ9f+7IuR8CDRzeAR
         7UWnnq8thhYsGJbzusc2P+lzf7AY9kYjoqscLTtM+aV4Nqw2ovxW7emP7AJL8/mV6PvN
         J4RlcuSXKQ0nd9Ok8jOohSLaGhsq7xC4vt6VB4WDfKXWuqoUciGhI/RgDxPNY1y/Dana
         kCrIIjX3/dLiL66MOf+dk3ekvAuvC38ncf44W8cnZB5gDTl7pYCj9JGcr7+iufk0pvgl
         Lq9g==
X-Forwarded-Encrypted: i=1; AJvYcCUUUTs+OSV2oJcBVHu6J11nF8ECxfDLr3VwoIUYf+L8wjky5f3h8ucWP7yzIRdl6n/L7ne+3wh8XwbndT3i@vger.kernel.org
X-Gm-Message-State: AOJu0Yzda1JxuXlQPTE9hILQftXXyR7SgEbD8M4KeFWbH2Z+YToxRVwL
	yevpuo+1cpsGU5XYeBaiFJ1ZgK3QrsSsuKRD1UU7T4EIiWJvwOSxr2YmvhiF3AveJRqMdcPNN+g
	jDDr2Z+kQcwJwcEpvbNAzmz1ZAniy3CA=
X-Gm-Gg: AY/fxX7z4sAkk0h6gZLdl7lfUfbYFjCu8wE6J5Stx+EzP/GkY8egq+6AjqroNEV+C7j
	3PT7BKkfLXd74WIyvi/21gJbJJFb9zZgCX8XKzp4PdZTxl2bk23q/ux881lew2HK0laGPJN+UIa
	sTiiqhbRChGX2syDadx+zFKQsi6vRAOrj+uSuZlYw7BmNawdR+431WEFx2gg83GxnPeYWvzO15Y
	n/g3n5l+mRJdwkGWdHkEEPdC72I3L6XomjjcUs+uwNzm1nmelg6T8Bhxkqrjm2/Wg7kmP8PLykq
	0H17/tBsCdgZpjdOhIU6tCdX
X-Google-Smtp-Source: AGHT+IEYPCItVP18gJyiC6huUadmBpCyJdQsMYnN64bYxRyDxrW51lj98bBR88bjEOUi3cRWoN+pmyJLyM6tVBaGOLY=
X-Received: by 2002:a05:6402:2549:b0:64d:540e:c68e with SMTP id
 4fb4d7f45d1cf-65097e6e03emr2514495a12.26.1767798318615; Wed, 07 Jan 2026
 07:05:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <00000000000051d14405fadad8cc@google.com> <695e743e.050a0220.1c677c.036a.GAE@google.com>
In-Reply-To: <695e743e.050a0220.1c677c.036a.GAE@google.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 7 Jan 2026 16:05:06 +0100
X-Gm-Features: AQt7F2ooQ4Rwqgo6fiCzY0yGLSJ0RbAhIBUySnvDnGFLhTl8lxZv74ynRZW1Frw
Message-ID: <CAGudoHFNST2hJFqMGDMC=jOfs9qBrLNO1uxwS_deRfintFCKmg@mail.gmail.com>
Subject: Re: [syzbot] [jfs?] KASAN: user-memory-access Write in __destroy_inode
To: syzbot <syzbot+dcc068159182a4c31ca3@syzkaller.appspotmail.com>
Cc: brauner@kernel.org, dmantipov@yandex.ru, jack@suse.cz, 
	jfs-discussion@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org, shaggy@kernel.org, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 7, 2026 at 3:57=E2=80=AFPM syzbot
<syzbot+dcc068159182a4c31ca3@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit dca3aa666fbd71118905d88bb1c353881002b647
> Author: Mateusz Guzik <mjguzik@gmail.com>
> Date:   Sun Nov 9 12:19:31 2025 +0000
>
>     fs: move inode fields used during fast path lookup closer together
>

I don't know what the bug is, at best this patch has an unintended
side-effect of neutering the reproducer.

> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D1480019a58=
0000
> start commit:   6146a0f1dfae Linux 6.18-rc4
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3De46b8a1c64546=
5a9
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Ddcc068159182a4c=
31ca3
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D15ef4532580=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D179c1e1458000=
0
>
> If the result looks correct, please mark the issue as fixed by replying w=
ith:
>
> #syz fix: fs: move inode fields used during fast path lookup closer toget=
her
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisect=
ion

