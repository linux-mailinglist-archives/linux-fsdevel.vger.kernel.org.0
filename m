Return-Path: <linux-fsdevel+bounces-8938-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D125083C79B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 17:11:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C48DA1C25075
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jan 2024 16:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82620129A6D;
	Thu, 25 Jan 2024 16:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="WpSZFiJC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989981292F0
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jan 2024 16:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706199098; cv=none; b=qVWqihH8ZpR0EmKqbn603VgF82pxb4kY0jL1wuRDE93/B+D1v8aQCUP9PBYruDlazfvcXDkTtTLIYH/csLRd3XRi8Yf22G0g3vkz8rnH2CrxzG5IEGWeMpqWiAl73sE0IoC64vKpC839DMbFfAguUCN1LogOvPDx6IUmoDAeWZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706199098; c=relaxed/simple;
	bh=sJvQIDfKJSXmACGVyDxOuvYeKXaNLXeOpOjnvIPcb60=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=foKx5hg53cdCdvxEczt505yXs/WCI8V1dNpDXoetE6BXBX9KIk9zhG4FhPO0iO4t7r/8Ccjd/689Xte+s3kzpJHyQZ/mD/5Q24uBEzw6kJRPzdY+DUb5/HErlX4ZSsPoRMIEe/pwwAmd5+CVMFPJ97Fhvj/wjQdIq/XGbwrk4b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=WpSZFiJC; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7bbdd28a52aso86958739f.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jan 2024 08:11:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1706199096; x=1706803896; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oXHpAvGT0l+OrcMVhCzIisM9di93nFyOAmu8umEvyYc=;
        b=WpSZFiJC+gCkaTAxVghL+0TziKvTsW3cXquxSB2MDTRybISiN/VP7Ez5bVYU06ZP9/
         TtFdqwmte6uhom2hQRBG7O+XasO47sVCGNXdKmFJzEaRQpIZmJVQm/B5KZO7mckPynIl
         pS9U7LAvO+P0kFe6dFEJu1UQMEYFqDP1sSCq6kyhBsqJ+dzD9KpQez5pWC6n73ClE7RQ
         8dG7YRBNKQABMDWVZKi+jY22+T90d4d41lkkHwz/S0Qg5QGEpMgP4yXE1SbXaj9Q/Nfo
         yeOSJW3b/QugMVgTs8FWYWBCQ/PhmsPb+VKByWydTbLncZshx1pkDtwKeodXldxBh10E
         Ct8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706199096; x=1706803896;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oXHpAvGT0l+OrcMVhCzIisM9di93nFyOAmu8umEvyYc=;
        b=Cflz5LU1U6Uk+0PXxGPR7JhHpYi17PbKxiORYNqNitkz2SFwG47TtvGAyNG3hwsqhP
         6AeWmYlF4YhVKAq0y+ok0huNgvobBzW7JT6PTuQO9ElQ4Xd4/zP8TtPPSHmSrEKoEzPQ
         d5k0kReVBKJzuyZgrE4xcvxQwD8In17vOv6KkUKsu2GoOyu16hQclLdoNfhFfjMSlexf
         D+EjX6NUpn/azDvj+Y7zK5LRm6xYcrnuDyc/w4BpRm3iiNouyPySpcfie2VYOAayGpVS
         0bghgCYdoUGMWNnm8DJ5pNG3LJ0OtA3pHaeJyyqtIkT7TVloWZ5IWHWCDtEZLgEg45ZP
         Ub5g==
X-Gm-Message-State: AOJu0YykCC3a/snOTImFuVreXqJ6howTbtnfvbuovxhOS+XWmvd1mJUz
	62MXjQv8Vg2r7O4cKyX6bUX4BBj1tcWVKryBlY+1v+LvKBlBg7hGbLTUmXxPDSy/Aa8PTBJ0mE1
	u56g=
X-Google-Smtp-Source: AGHT+IEK/ThZ75X0mSLf5JYVYvXq2E1lW6GL1EM0E56z9MRc0RzZ+JHgPgmxc0oiVIA9uU/EKwDlBA==
X-Received: by 2002:a5e:9205:0:b0:7bc:207d:5178 with SMTP id y5-20020a5e9205000000b007bc207d5178mr2457404iop.2.1706199095804;
        Thu, 25 Jan 2024 08:11:35 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id b18-20020a0566380b9200b0046cf80c799fsm4619524jad.120.2024.01.25.08.11.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jan 2024 08:11:35 -0800 (PST)
Message-ID: <11868eb4-0528-4298-b8bc-2621fd1aac83@kernel.dk>
Date: Thu, 25 Jan 2024 09:11:34 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jens Axboe <axboe@kernel.dk>
Subject: Re: [syzbot] [jfs?] INFO: task hung in path_mount (2)
To: Christian Brauner <brauner@kernel.org>
Cc: syzbot <syzbot+fb337a5ea8454f5f1e3f@syzkaller.appspotmail.com>,
 hdanton@sina.com, jack@suse.cz, jfs-discussion@lists.sourceforge.net,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 shaggy@kernel.org, syzkaller-bugs@googlegroups.com
References: <00000000000083513f060340d472@google.com>
 <000000000000e5e71a060fc3e747@google.com>
 <20240125-legten-zugleich-21a988d80b45@brauner>
Content-Language: en-US
In-Reply-To: <20240125-legten-zugleich-21a988d80b45@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Thu, Jan 25, 2024 at 9:08?AM Christian Brauner <brauner@kernel.org> wrote:
>
> On Thu, Jan 25, 2024 at 03:59:03AM -0800, syzbot wrote:
> > syzbot suspects this issue was fixed by commit:
> >
> > commit 6f861765464f43a71462d52026fbddfc858239a5
> > Author: Jan Kara <jack@suse.cz>
> > Date:   Wed Nov 1 17:43:10 2023 +0000
> >
> >     fs: Block writes to mounted block devices
> >
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13175a53e80000
> > start commit:   2ccdd1b13c59 Linux 6.5-rc6
> > git tree:       upstream
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=9c37cc0e4fcc5f8d
> > dashboard link: https://syzkaller.appspot.com/bug?extid=fb337a5ea8454f5f1e3f
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17ba5d53a80000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14265373a80000
> >
> > If the result looks correct, please mark the issue as fixed by replying with:
>
> #syz fix: fs: Block writes to mounted block devices

Like Dave replied a few days ago, I'm kind of skeptical on all of these
bugs being closed by this change. I'm guessing that they are all
resolved now because a) the block writes while mounted option was set to
Y, and b) the actual bug is just masked by that.

Maybe this is fine, but it does seem a bit... sketchy? The bugs aren't
really fixed, and what happens if someone doesn't turn on that option?
If it's required, perhaps it should not be an option at all? Though
that'd seem to be likely to break some funky use cases, whether they are
valid or not.

-- 
Jens Axboe


