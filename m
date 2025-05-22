Return-Path: <linux-fsdevel+bounces-49697-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15793AC16C2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 May 2025 00:26:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 935A17AF947
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 22:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6DD72798E4;
	Thu, 22 May 2025 22:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ToVMF8Pc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60842741B8
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 May 2025 22:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747952773; cv=none; b=YQjymywYGMAxfcZltGCRntUYpKoi+GFCYUdptCz20rtjDUZfqmAwTZXRvvbIjP9Gy9wUFXyRDrFJ5DlE09yAHjXtsvA6QSoukQIuNiTWwNvUbeg398EMpvNsV1M6Q+drB/1g/Bh04TfrqvCH8eitO6+TBx3dHL6EkBcXyb0OoHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747952773; c=relaxed/simple;
	bh=ERIIFgKxrnPwjSVA6jXYtUfeYroUqJBM9v+L48OiIjw=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=n/TYlbqhtAhHnNNN7y4e5fEz+enBoJliVs4c2u/6Df4ZqnrECK9/uZK2iYEwka++6WmswR48HzdRQDYr4KaFLfEK/2+d7CiMkcRVQoJ2ldyF2yRnFn09+P36PvlY6aPqvoJ+V1HdtEuUdwCJJ4AqpK4rFPcm9JGWiQLZtDFhw+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ToVMF8Pc; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7c55500d08cso932394885a.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 May 2025 15:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1747952768; x=1748557568; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yW4BwrWRPMGZw+m/ri6EFRKCjP4k+SeXSk6ZWrWvJiA=;
        b=ToVMF8PcVy37DRcyydOqAzRtU8MIfxnsQYcyTujtaPP+6rNuh10GiSxHl8BpEOL7Vl
         xP549yj/DsBJfMi3qCROE0CjVVteyRyHylhdLw04oGcxRiQntTqkGaj0qxDt91en7Yaf
         k+SmxoaFBB+G/5sErCk+bkQleUrTH6XQJe2p+LIipbvb4fbPmu1wnSD2q+VMoi0xxJsW
         gaMrvrcaiHSnHiky9rJUvXODz2114Xg3/bkQmKiZIEtphocJflv5aC1cQ1XzMR2q+5M1
         e5C3pB8Uc+2bJywG7HLAABdlrHUZ45rP3ykqZkmL5ezlodK/YayNjCLBFI5pn3kcMbPH
         Giow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747952768; x=1748557568;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yW4BwrWRPMGZw+m/ri6EFRKCjP4k+SeXSk6ZWrWvJiA=;
        b=YiB7AyYYgn4SNG9crWuJoLOetJb8Qd3aJ6xLEccslp+W+qpVZw8Oi1MfSB6oZRZi1l
         LzWFmWOLZaevi0m47W+dgxm2uaPolP3fpI2KFOaGHFrSTq1ISG5zRgca4uPkmgzYMVE5
         LqYebgXH9xqojhgya1t9clfiN4RdtJLID2WxJhxWjwUHhJ1TEXVWCBuoJoTPOc0Pp9+p
         JGScOBAixTpeUEemEoFUzJI28FJCgNs1JKdB0TQW1Y0qQKmO8MU7Vm7QcgTRsf7jVeEN
         usXxasF3GJzSk7rC9EMIex9LetBri+IdvKFODxptm2f3un1v9RKUACQmD5Sebw1y2F2p
         Y6ig==
X-Forwarded-Encrypted: i=1; AJvYcCWMw6lFmAD17I/e4mrUJ01du6NbcHq+8LMibd/5QPUzpq8rjLtA0S/rQdVA2LMiJL9onygwacCcUWuX8ndS@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6Zmu8T6UKdB/N3Cfwg+zKxH+kuAqWIVoJQnHl0elRXPLxAQTn
	y/UNbgHAm2myHFAujrI/9bG+izL/kt2VxmlpA4Qeu+Gr7NstwqOvbyGNs8UebTGVOw==
X-Gm-Gg: ASbGncsBeWolXKeWij+/y7Dn4EDuiBpMR+z93Jllf3yyKMxP+5yxO8aRTb9J3ztOrRT
	qRLhJZYkL90dvNggZfxtR+X4oAz6CzUEc991MjDTiqZ4vgKQ2ebgwdhKEUVIvx7ctXHw8lvCJC5
	vlwRjvBhWI0qz+dsplOtO2VbNDD86FflJ+FBbbGND/6dS+1Gwi1bjXQOXrPqE7IPaMQqvtvnEkJ
	dgYPB8TfIp5GVRsDgit2wG2LkKpuI0m8zxeyIBt3Nilq9pjKT9Nr3bBgB5T/QW8xvzmMIlP8F2V
	pnS9LM4uqgXpyhXFJSjL9l2cRSdeZLY0pTZHvEG4u5A7bSemEu8g+DXVVDsjkKI/zE3UjHzODEQ
	UJFWVVO6tVgyxW5gPhMIw
X-Google-Smtp-Source: AGHT+IHmIlyqjG6e3vdHM+wi0UqPbDaDdVTY/IdBlClNAbyXhci/B2Ul0PB2ozu0sL7+1EWeTaPM2w==
X-Received: by 2002:a05:620a:408e:b0:7ce:d352:668f with SMTP id af79cd13be357-7ced352670emr1334278485a.47.1747952768087;
        Thu, 22 May 2025 15:26:08 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7cd468b69dfsm1089029585a.79.2025.05.22.15.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 15:26:07 -0700 (PDT)
Date: Thu, 22 May 2025 18:26:07 -0400
Message-ID: <8bf36078ef8f3e884a1d3d8415834680@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250522_1740/pstg-lib:20250522_1730/pstg-pwork:20250522_1740
From: Paul Moore <paul@paul-moore.com>
To: Andrey Albershteyn <aalbersh@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, 
	Matt Turner <mattst88@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Naveen N Rao <naveen@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	"David S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, 
	Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Arnd Bergmann <arnd@arndb.de>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Tyler Hicks <code@tyhicks.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	Amir Goldstein <amir73il@gmail.com>
Cc: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, selinux@vger.kernel.org, ecryptfs@vger.kernel.org, linux-unionfs@vger.kernel.org, linux-xfs@vger.kernel.org, Andrey Albershteyn <aalbersh@kernel.org>
Subject: Re: [PATCH v5 3/7] selinux: implement inode_file_[g|s]etattr hooks
References: <20250513-xattrat-syscall-v5-3-22bb9c6c767f@kernel.org>
In-Reply-To: <20250513-xattrat-syscall-v5-3-22bb9c6c767f@kernel.org>

On May 13, 2025 Andrey Albershteyn <aalbersh@redhat.com> wrote:
> 
> These hooks are called on inode extended attribute retrieval/change.
> 
> Cc: selinux@vger.kernel.org
> Cc: Paul Moore <paul@paul-moore.com>
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> ---
>  security/selinux/hooks.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)

Acked-by: Paul Moore <paul@paul-moore.com>

--
paul-moore.com

