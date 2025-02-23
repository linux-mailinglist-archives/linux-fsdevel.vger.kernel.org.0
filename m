Return-Path: <linux-fsdevel+bounces-42363-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDECFA40F98
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Feb 2025 16:45:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58C3618938C1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Feb 2025 15:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD5B35BAF0;
	Sun, 23 Feb 2025 15:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gCtnGQRB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0990717D2;
	Sun, 23 Feb 2025 15:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740325532; cv=none; b=JYqOW10R8KH7mJXhItBkjETtBKqHGYzQHYXwtdnNCCtYk1I2AfFrkN8ltAs5gBjtH+jN+Zn7I9MssQglgu+hp8K/SYr7SNY5YvwdeyoLCJ9/OGc5NXjW8IAogHtVrMF0wwY0Q7PfS7bmkZHhCwxpVEdvYyLZJnguA4lJU1vRFDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740325532; c=relaxed/simple;
	bh=QFi71j3t7L8FalzRGOLODni9crxX2Z9gNtF3Bz8Bfls=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UdP7tViDO6fg3eCPb6b0HE5/hbGS+wxcucxmcss0RUbcuuC6vygrjT1moSEWqUTS8/Hf6G2RNsk6GIU8iKMHcNbADUTSD+wp5V5XkuJWKOZBCESr7xSYeUYyn0i9FU7CNUgWH5tT/Kd0xEAgdIM1UYV5udh52DgzBQs3g/ALzkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gCtnGQRB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B128C4CEDD;
	Sun, 23 Feb 2025 15:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740325530;
	bh=QFi71j3t7L8FalzRGOLODni9crxX2Z9gNtF3Bz8Bfls=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=gCtnGQRB93IVr5xoC+Y9aqkyT2Da66sbYPg5tlOexCaL+X66C5hrOLKP8Uh4AlyUg
	 CEvFRlD4xgqZkvteDGw70NVG48LK/Ao1R1Ho/YQOeiQvzc7MRq76Bh+2EAxpIEzSjh
	 ZmlDxgOdRYhagWgVMpzdRfqbNxMkZFh5Ga7bDv9qD/dxjn20UkZBe6SjTHdXeFxfmZ
	 FjLvjJtjKVR0F+6A6bkSE/LHdW+yokJoU29olVgqiBIQk10+eBQU2Mb/QkSrSBjLJw
	 m6Dkt6Nu2UDLl8JizT071BmQ2bqMpmNzx+CDRk8GMN8whmPctyid+VN8Nh/aRupdHY
	 j6aokvNpOsntg==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-307bc125e2eso33914741fa.3;
        Sun, 23 Feb 2025 07:45:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW6Pi4CYrYDgE6wgqIwEyPZxB1t438pDFKXrZu99uVTy/iCsVgQ/JENS7HFSzIkI68EMA+msk3tyirYoqwf@vger.kernel.org, AJvYcCX86skN5vD5Oifa3afzAj7owJC7+jXds6ROpYVcscI/n3Yx1g4sQAV+8kmgT7VI9vMOwEpIAX3GCblHAxdVEQ==@vger.kernel.org, AJvYcCXZa5ixDkM+QmlHt3Kef+gbHA2IiWcnWAQKEwRrosBw7fQjzx7bm1Q8Na0P+lFFrZq80wuT04lLygc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCktxkdx03BJOP0UUnXa9Gmd1Hn7fSgoQ060oe9OxoR2olFMjk
	25hzTz+1l79kr8rKLgjou+4Hk74OUsBjsIGc22uAUyABMMsxGK5HJNB6zcL8NqbxcVQZUq0TRsY
	irJB/zp/hD1HIa9lEhixRD+jXAfo=
X-Google-Smtp-Source: AGHT+IFPMG1zOPXS0E5ESbB2FCi44a1GD+soKxuNdFM7CWZAbww6yk48RaVa8jHEiiIG+yMbKGz+XJIMUJAv4H6qa4s=
X-Received: by 2002:a05:6512:ba5:b0:543:9a61:a2e5 with SMTP id
 2adb3069b0e04-54838ef78cemr4226110e87.23.1740325528840; Sun, 23 Feb 2025
 07:45:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <67bafe23.050a0220.bbfd1.0017.GAE@google.com>
In-Reply-To: <67bafe23.050a0220.bbfd1.0017.GAE@google.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sun, 23 Feb 2025 16:45:17 +0100
X-Gmail-Original-Message-ID: <CAMj1kXG1mhe1_eB0oeWukpA_FMTzH5F6zFFszpDTr_x2smvzig@mail.gmail.com>
X-Gm-Features: AWEUYZlq56gSuDcK4AMca3N4fpNm-cMsBQvbloeKgU8qj87zK9lNdlTlqURLZ-8
Message-ID: <CAMj1kXG1mhe1_eB0oeWukpA_FMTzH5F6zFFszpDTr_x2smvzig@mail.gmail.com>
Subject: Re: [syzbot] [efi?] [fs?] BUG: unable to handle kernel paging request
 in efivarfs_pm_notify
To: syzbot <syzbot+00d13e505ef530a45100@syzkaller.appspotmail.com>
Cc: jk@ozlabs.org, linux-efi@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

#syz test:
git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci

--- a/fs/efivarfs/super.c
+++ b/fs/efivarfs/super.c
@@ -367,6 +367,8 @@ static int efivarfs_fill_super(struct super_block
*sb, struct fs_context *fc)
        if (err)
                return err;

+       register_pm_notifier(&sfi->pm_nb);
+
        return efivar_init(efivarfs_callback, sb, true);
 }

@@ -552,7 +554,6 @@ static int efivarfs_init_fs_context(struct fs_context *fc)

        sfi->pm_nb.notifier_call = efivarfs_pm_notify;
        sfi->pm_nb.priority = 0;
-       register_pm_notifier(&sfi->pm_nb);

        return 0;
 }

