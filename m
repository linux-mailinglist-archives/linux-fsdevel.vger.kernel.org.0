Return-Path: <linux-fsdevel+bounces-16498-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E217089E4F3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 23:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 983AA1F22E66
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 21:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE55158A29;
	Tue,  9 Apr 2024 21:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="VJCJkhDg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED1F763F1
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Apr 2024 21:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712698194; cv=none; b=CyXtHjf9UPDNspsz/O90DweBORSO6zrkJITxj1BllcMnt4ITsHIyvjzGCVw5j+DFTDKNwJedUJBk37ebXZmMpsz+N5JirsSWqOfxb8/mIQWFW0IUXkN2R3gaS1kTLgn5N3ha/TwiFP3A7/MzRBPfmBkUpInglUkyo+uX38z3Fq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712698194; c=relaxed/simple;
	bh=Ubqqm63lKdnzIJduqL2oJ1Vi2+iIgr/cKwTszXup7q0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uAtmeF7iTvu5TWIfFqfVEtR93ftx8dChwinqslqBWNm4OCaWrpm4iWW1q46/26Kg1HzvMQD8srPu7cOsmOIfXURZ8m8mlcQS4ZcQWFlouOtepSvWiXUUy80nQsl5Iln9ssDz6Wbs36z0EtXcvFrdtj9iCkeIBlvuqn5z8W6PY7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=VJCJkhDg; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6eaf1005fcaso4202322b3a.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Apr 2024 14:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1712698191; x=1713302991; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lppOhDLhaTktGl6lazMPAeBs02NfwHMeHSnwbowOWTw=;
        b=VJCJkhDga/OfKWeKbdrV+Saj9YmigCMLGWF6BfgnQH3eH/S5yBIWflk+OPpwtREuOe
         sCZzrABd56f1+kvK3UE8lUjqkbdw9/DIVfraZRmuWWGFbeUgR5nF1Jggriy2kyc8BiT3
         WG0uqYH+QFP3PCBjxaLWrN9sbyBXT4g4Gjvx+s2sjOqCW92mtMNHWnyE+tbS9iOmvjtL
         83ocso+vIOzA3YcvmGz8c5BsZDEQZ1yPXn1dlslF78q4D70zvWDphBajBYEfoPJVIDLd
         tOuVrVGhru5QLUAMuspZ6FEnkvqGtKz1qHoqCWn6fMtLS5aODbw1gspxqRiPljuVMG94
         tlxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712698191; x=1713302991;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lppOhDLhaTktGl6lazMPAeBs02NfwHMeHSnwbowOWTw=;
        b=xO9zYC3TJvIITKijjah5LScO7y5KfvJcSmbr8i2riK6mRrS8mDgfVwh+fwcXQkix1q
         aE+fkAx/TrsnDxBmGJqTlOdRyqbsp2uPmZoVkRzy3sk3ncuf8FkBZFHMy+zDj7XXbzuT
         mfBYQ3oor7BJd3m/UseVQroEKdy/xwr3wXKWCKqlvYlWMd60W5B9NwBqHqcz7mvuYNZX
         +srZL3G8zzHALcMp5m/4MeamVQBI7cC3zI0ZMCJFIwKmJEtYccqjDnMRPzQEWQQ1Qlv4
         sRw0ZEvPL0ujA7glzySaKwz+sBAYvrHeH91/Ldm/RSp/OP4A9g78a3FFzo/XjXotJo+J
         qqdA==
X-Forwarded-Encrypted: i=1; AJvYcCXQj9AgV2noGItghwh40Pe0Q+VSRqfxp/QtmDsN8Ld2eb7SVnfBF7ME1r3uQ8KBUiXjduE3QMkLR1RDK9F7cYGvIP59/lsHtxe609QBww==
X-Gm-Message-State: AOJu0Yw2ZKxhCkvq4oNjASEc0Z/y2ymgDDUsJTHYlLDdIPKuGGyOAhdc
	Z24Teh0Gm7jEDH2ZebZznGLSF6Lc3bmvedQdohvt+lGmus6UpyHjaf3bP5G5soU=
X-Google-Smtp-Source: AGHT+IFvOqPyH50nuc2JACoXyF6q2DKJ9ivcnsRna4tGd1/cjZ8p4v7GhrD65qleDU/qtwwIyhj4CQ==
X-Received: by 2002:a05:6a00:14d1:b0:6ec:faef:dd28 with SMTP id w17-20020a056a0014d100b006ecfaefdd28mr932086pfu.23.1712698191116;
        Tue, 09 Apr 2024 14:29:51 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-56-237.pa.nsw.optusnet.com.au. [49.181.56.237])
        by smtp.gmail.com with ESMTPSA id x12-20020a056a00270c00b006ed048a7323sm8006356pfv.86.2024.04.09.14.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 14:29:50 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1ruJ2J-009xO3-3A;
	Wed, 10 Apr 2024 07:29:47 +1000
Date: Wed, 10 Apr 2024 07:29:47 +1000
From: Dave Chinner <david@fromorbit.com>
To: syzbot <syzbot+b417f0468b73945887f0@syzkaller.appspotmail.com>
Cc: chandan.babu@oracle.com, dwmw2@infradead.org,
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
	linux-xfs@vger.kernel.org, richard@nod.at,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [ext4?] [jffs2?] [xfs?] kernel BUG in
 unrefer_xattr_datum
Message-ID: <ZhWzS47ZvqF2WriS@dread.disaster.area>
References: <0000000000002444e20615a20456@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000002444e20615a20456@google.com>

On Mon, Apr 08, 2024 at 09:04:18PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    707081b61156 Merge branch 'for-next/core', remote-tracking..
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
> console output: https://syzkaller.appspot.com/x/log.txt?x=1562c52d180000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=caeac3f3565b057a
> dashboard link: https://syzkaller.appspot.com/bug?extid=b417f0468b73945887f0
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> userspace arch: arm64
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14e74805180000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1613cca9180000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/6cad68bf7532/disk-707081b6.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/1a27e5400778/vmlinux-707081b6.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/67dfc53755d0/Image-707081b6.gz.xz
> mounted in repro #1: https://storage.googleapis.com/syzbot-assets/f039597bec42/mount_0.gz
> mounted in repro #2: https://storage.googleapis.com/syzbot-assets/b3fe5cff7c96/mount_4.gz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+b417f0468b73945887f0@syzkaller.appspotmail.com
> 
> jffs2: nextblock 0x0001d000, expected at 0001f000
> jffs2: argh. node added in wrong place at 0x0001e03c(2)
> jffs2: nextblock 0x0001d000, expected at 0001f000

Nothing to do with XFS or ext4 - they are simply being mounted with
invalid mount options at the same time.

#syz set subsystems: jffs2

-- 
Dave Chinner
david@fromorbit.com

