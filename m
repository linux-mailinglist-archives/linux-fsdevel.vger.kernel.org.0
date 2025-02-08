Return-Path: <linux-fsdevel+bounces-41294-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E5BA2D803
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Feb 2025 19:23:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 339CD3A546D
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Feb 2025 18:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D0B1F3B8F;
	Sat,  8 Feb 2025 18:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EklgTIVz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E176241107;
	Sat,  8 Feb 2025 18:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739039027; cv=none; b=YqKV3JR3pZJPeY5siF0QblII+SHGeFl4cUklCY17u/l3jWDn/40RScmAdJAXqohVsxLRKty4cQdSeW+ddm7K9urkdQzoA7C2G/LXpajXmjPRHkWkyHKULdfousvGz3YyEudpL8uObcXZ2KBSDCd+5quXXM/chNHB4kASPzbb6RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739039027; c=relaxed/simple;
	bh=jJ+AQLoMjO/x3Ps7vJSk3vzcKF5wiCVgIDoDTv4QQN0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tpKfWvlE9UEY84UZ/xSgNWgOn8d1iN0qUsHv2vOW6VCrORg3IsfMwKHXtJ8j/o3OfkmkWPaBCf4UuFXPjPKi53yvK6DNMKHtkBt9oSXLLBbxaRBZVDgOUqFVzzlbz1mzochyzxlP5mOyo7CobLQMBnlucgfmOJ/8Tw5rlEg1v44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EklgTIVz; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5de4c7720bcso2569447a12.0;
        Sat, 08 Feb 2025 10:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739039024; x=1739643824; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xiNvW4R/VJfrDNayC58/uDi99/+MsHLhziR2BZUzZIU=;
        b=EklgTIVzy8lQ9XhJgkOFefUP4hIp+h6dI7LYOyc5bkFnRgohublN1+6JGFX8MAUNqq
         POp0ByP0ucTmntxJsg6kFNqIypq0zCebnldvHvtvTopIAsDIuBM7ZM5k3nYh6nGlAkNY
         HQRj4z7I+QBylib9FySozfD3IyhnpdkxNow04qEyjspDsw7qGH4cSBACd2eKBhMpDvZ9
         K+6Izz+SLsOxxJ+9VowZ39meowCvRDdZ7egPdUHLm6xQKMg1cNupR3ma7ks9aK0rY1Fg
         Uy0ksg7dpIJmrbAO1+BQ7elWdMx4JfLt9brzqxsxk928I0hi+6cqfnT+ZPJ3sYokYL/i
         JP8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739039024; x=1739643824;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xiNvW4R/VJfrDNayC58/uDi99/+MsHLhziR2BZUzZIU=;
        b=YT7KBalRLshiWJfikSuNZsE4g9apkuuDPSAD9zprG9IKZKwxT9gSr3csM4pWy9T1Jw
         IR2n8sW6CiUstGLmeI5Ic1HYqrg9BN4nacxmyvDFV2L1JHYnd127a8j3+wjE6odHm4mo
         ww/M2dxdSMTqQ01Gf9IgCgJz/CkI/X8/BqE73D/G1Q9Js4EzMq7ZU6E6D+xlK5naIAN1
         ufK/FwCkhrOqhKk4Zu7QkUG65EsfLE+l78ShAY3oUpisLoE0x1NoVKpx7SATJGEcIGlG
         3uDLnY9J55NZberoqhbBWetSBxjRfm+s+MFPeDm8mVfZ3VXGrtRb8pJVTqTMclutZ4lE
         7sMg==
X-Forwarded-Encrypted: i=1; AJvYcCUXWUSsRw4zvBRlrAiQUSvv8lARCYTfqUAAZGWnigSBti1oMbiKab7CI9xWjHkwtORriXf3jA2TbdujdsbT@vger.kernel.org, AJvYcCV90zzD3wwRvWkOIvRSjVKdlflEvuVNFCSqfBgtCVM8JxwtlvczT89x4rnGg4lyhTHNCwZI1cKy1KXQ@vger.kernel.org, AJvYcCX5faQdKkatJzcBRw1vWgmNGOBBnu+7r8pCBMbyWRnhTElgYI9tRuGeznWwpcHO52eXejCBDlAajWcwIh+5aA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxrxu4H8WI6WJxcFt6EYH6WpdWxMWK5ZEERv0uEio3tg9Q30qn8
	KnLLWb3B33M7RKiYjKVIhBMagm/uXVHOhhDLN7Zu4QsQEqWdp8GZV88Ecd00Z1ZBLoLmx4Hwj6l
	H6KaJC4rBp1adiwvM0BCEwZpDK18=
X-Gm-Gg: ASbGnctP7LBLz7+XGrRax8lFiDThrRM75R1hnZ+FuMnQ/WA8uDA3ivz3qGGxD0BfdUa
	EvEY3i+uBhjwlmIW/5PUNL19UaDTPT67VTJJFsIWA1f54c3eYOlYKUb/YdQ+RD072eY3HixL1
X-Google-Smtp-Source: AGHT+IEqNBa82X3gISKr2oPC6+cVGTAfy5ePrlgVkuS7QLpMKuQGaDC6GHpRzb1UEFKg/yyqpP6k609+ra71SKuoP+8=
X-Received: by 2002:a05:6402:2084:b0:5de:44b1:46c with SMTP id
 4fb4d7f45d1cf-5de44feb75cmr7781329a12.7.1739039024125; Sat, 08 Feb 2025
 10:23:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <67a4eae3.050a0220.65602.0000.GAE@google.com> <67a79eb3.050a0220.3d72c.002b.GAE@google.com>
In-Reply-To: <67a79eb3.050a0220.3d72c.002b.GAE@google.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Sat, 8 Feb 2025 19:23:32 +0100
X-Gm-Features: AWEUYZkDy7uFTIlJQohQpCjxxZm_lZu6PPZOEeMY_q1jzs96tEGajm8SZ8cCtOo
Message-ID: <CAGudoHGQo1Y41_91WOUJygHzrmOO4N7PY12vPpFLF=ZEFPvsBQ@mail.gmail.com>
Subject: Re: [syzbot] [ext4?] WARNING in inode_set_cached_link
To: syzbot <syzbot+2cca5ef7e5ed862c0799@syzkaller.appspotmail.com>
Cc: adilger.kernel@dilger.ca, brauner@kernel.org, jack@suse.cz, 
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

For posterity this is expected, the ex4 fix is here:
https://lore.kernel.org/linux-hardening/67a3b38f.050a0220.19061f.05ea.GAE@g=
oogle.com/T/#mb782935cc6926dd5642984189d922135f023ec43

On Sat, Feb 8, 2025 at 7:21=E2=80=AFPM syzbot
<syzbot+2cca5ef7e5ed862c0799@syzkaller.appspotmail.com> wrote:
>
> syzbot has bisected this issue to:
>
> commit 6408a56623761f969537b421d99f045a4cc955b9
> Author: Mateusz Guzik <mjguzik@gmail.com>
> Date:   Tue Feb 4 21:32:07 2025 +0000
>
>     vfs: sanity check the length passed to inode_set_cached_link()
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D152ffca458=
0000
> start commit:   808eb958781e Add linux-next specific files for 20250206
> git tree:       linux-next
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D172ffca458=
0000
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D132ffca458000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D88b25e5d30d57=
6e4
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D2cca5ef7e5ed862=
c0799
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D161241b0580=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D16ee80e458000=
0
>
> Reported-by: syzbot+2cca5ef7e5ed862c0799@syzkaller.appspotmail.com
> Fixes: 6408a5662376 ("vfs: sanity check the length passed to inode_set_ca=
ched_link()")
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisect=
ion



--=20
Mateusz Guzik <mjguzik gmail.com>

