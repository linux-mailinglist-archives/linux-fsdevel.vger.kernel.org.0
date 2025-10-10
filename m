Return-Path: <linux-fsdevel+bounces-63792-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B50BCDEB6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 18:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 567CB189BEF2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Oct 2025 16:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14ADC2FBDF6;
	Fri, 10 Oct 2025 16:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dXjcz+CH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1AB4266595
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Oct 2025 16:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760112407; cv=none; b=dmsk1BMnD+fmRWL15vg04kpvAGJfJ+VgsYkc/LA07JFK+jaPpNaGlbXI2aXOwucbWV9AeEpxIHmyvxCftR4NqP9PozbDQFY4wPiFEc8EIpzJWX0A1Lfnud7JXH8+wsmHWkoGgo9mnxbmPsURfQpo9JY2su223RveZvoF8yfgXUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760112407; c=relaxed/simple;
	bh=IBKRs8NxX2KWV2z0LGyqgKOMivcipimjpZpOscOhTNE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SbFi/kLP09xKGUoNRxwuE+FIgEZ/EKPmyWb3WL7dcGsSgqQJdunI0wJSNBvRYEkb49AYtGXJY2+w6wd22N8ircjzCpbf2yeJQ220R+0IpKOUTc3VmmkpZaqv1hck0+tIsJi8HEcyLLnSUrAZZXwoaG6R9R7drIMOxc6aTUoJYX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dXjcz+CH; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-63cf0638c1dso625936d50.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Oct 2025 09:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760112405; x=1760717205; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fp12jPQLKHpAtsfH0wirGai124eQvnJsGvFLw1Tx6tc=;
        b=dXjcz+CHL9h++TrV383QJ9eTPkR9t/jC9SUxsQFlnm6gyxOQee7wBqyuGKDbpCHVVG
         O8lMfTbWHzDI8l/2zPChzO3t0ADgmK1/DLWBqCsR1mntHq3kNaFphgDpknH+Y3zQVXmb
         ZxR9Na6Ef3hLKZsUsvkhhfwQc5dOB+YNMT1Gk1F6hHsMgpCJbZStsda8AoAA4E3Sg5s5
         mZafebqisq3gLFEb0D6hg7g7wr7EBQUv/JwOFdR/4lsVKKf4ya0GPcoPkz1yqn6LSqqe
         y801ohUm3ATcd3DRQwhxuosi3V0SU25rns/fnvRohS/R2rH+A0Hbu4/JTGCs8e+76Q88
         QQ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760112405; x=1760717205;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fp12jPQLKHpAtsfH0wirGai124eQvnJsGvFLw1Tx6tc=;
        b=uZP8jqrROS4z7h6viQ6UgnMsP6AdBFWxFBv5lp0/Pe/US6DW2KX7fcwq4gOJMCbPQm
         eIBMXZY/8eGV/Evet3/q8EjfMT4eTjl4WLs+Vynj3t2NyVQS0Pw+v0NaK/fG+gDQivJC
         40JFozjntQbpisbkuK/MOOWr4sZNWTYRd0LcWHcs4as7Ig4fx7a29c0tFg0X8MbHwOiQ
         WHkzHJn1PtxljLgjyOHPrCoqkVeKwBAlLm+WyR0xnxBLe5b7y6aaY9kN973jbhhzbmyW
         zjornAIczz5Hx2tW5MitnajDB1wsKbFhm4ZPHIU7py6Ivx2snSrQyEhkw+WpdhYJ66He
         4xlg==
X-Forwarded-Encrypted: i=1; AJvYcCWZ2+Glj/QG8AInh2DKFpeFWhkfEy2XaTPEu09ItgYXEkX713tnH1dYV0bM9Sxe/jeDfIA/cg9FcaNxpwqC@vger.kernel.org
X-Gm-Message-State: AOJu0YyILzWZCEBKkkN+T1Q/cvABxpmBaNGlroVmfcV9oROxvLh3hDZ4
	ZC4hTA0BMFYQcuBOY/pEmlm3zrSXMhaHuBOJnVe817he3Zj7Eg80LS+2K+iULSRP9wlunhZytTt
	gpQcDwY0h+0yhg8tB5YaL4ttxxjU958nb1lUqdis=
X-Gm-Gg: ASbGncvVKw3RjTghjYl7VCicIc8GQY73KmxiEK5u2O0P6Xx7VPBEXCykWMaQiT05U2D
	/vf78AT5B9naRhJ4LmtZ745jSC6OSEuCRRq7+PI4s04H/j8P/qfqMe4zmfX/62Fi0wDg/c5ubnW
	wKDoZzYO0xZZNWsHImuICMtURjDalhbxRIoZ+9ittNLSdnTA5Bfx2ZXpqRvKcG0aXCIYkr3vs1d
	dLYeWJH16g2Ec749bMQlAEx
X-Google-Smtp-Source: AGHT+IE4dk1H9DszW1O9cVXYFFigWOgcXsXjBoAmJdpywlxbTBznMKixkOFEwyOd7UI8V5CNqE3/AEmEal+CSAIkS50=
X-Received: by 2002:a05:690e:200e:b0:633:c066:6a6c with SMTP id
 956f58d0204a3-63ccb89811bmr9511136d50.20.1760112388097; Fri, 10 Oct 2025
 09:06:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a5f67878-33ca-4433-9c05-f508f0ca5d0a@I-love.SAKURA.ne.jp> <CAK+_RL=ybNZz3z-Fqxhxg+0fnuA1iRd=MbTCZ=M3KbSjFzEnVg@mail.gmail.com>
In-Reply-To: <CAK+_RL=ybNZz3z-Fqxhxg+0fnuA1iRd=MbTCZ=M3KbSjFzEnVg@mail.gmail.com>
From: Tigran Aivazian <aivazian.tigran@gmail.com>
Date: Fri, 10 Oct 2025 17:06:17 +0100
X-Gm-Features: AS18NWD21inyGdSICE1B8lkGaaJz_weOFSnWayxqoG0RjRoZD9pydUQu5UVRzzQ
Message-ID: <CAK+_RLkaet_oCHAb1gCTStLyzA5oaiqKHHi=dCFLsM+vydN2FA@mail.gmail.com>
Subject: Re: [PATCH] bfs: Verify inode mode when loading from disk
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 10 Oct 2025 at 16:44, Tigran Aivazian <aivazian.tigran@gmail.com> wrote:
> Thank you, but logically this code should simply be inside the "else"
> clause of the previous checks, which already check for BFS_VDIR and
> BFS_VREG, I think.

Actually, I would first of all print the value of vtype, because that
is where the
corruption comes from, and print i_mode as %07o, not %04o. So, I would
suggest a patch like this.

Reviewed-by: Tigran Aivazian <aivazian.tigran@gmail.com>

diff -urN a/fs/bfs/inode.c b/fs/bfs/inode.c
--- a/fs/bfs/inode.c    2025-10-10 16:52:40.968468556 +0100
+++ b/fs/bfs/inode.c    2025-10-10 16:54:09.904052351 +0100
@@ -71,6 +71,11 @@
                inode->i_op = &bfs_file_inops;
                inode->i_fop = &bfs_file_operations;
                inode->i_mapping->a_ops = &bfs_aops;
+       } else {
+               brelse(bh);
+               printf("Bad file type vtype=%u mode=0%07o %s:%08lx\n",
+                       le32_to_cpu(di->i_vtype), inode->i_mode,
inode->i_sb->s_id, ino);
+               goto error;
        }

        BFS_I(inode)->i_sblock =  le32_to_cpu(di->i_sblock);

