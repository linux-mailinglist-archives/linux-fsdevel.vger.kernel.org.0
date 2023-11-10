Return-Path: <linux-fsdevel+bounces-2740-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D883C7E8708
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Nov 2023 01:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 323CA28144E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Nov 2023 00:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC191C37;
	Sat, 11 Nov 2023 00:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="AYRe7Uyd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4973415BE
	for <linux-fsdevel@vger.kernel.org>; Sat, 11 Nov 2023 00:55:28 +0000 (UTC)
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086DB448C
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Nov 2023 16:55:26 -0800 (PST)
Received: from letrec.thunk.org ([172.59.192.143])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 3AB0t1E0028402
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Nov 2023 19:55:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1699664106; bh=KGrCo0EAEmidC19jfpkh83o8LjlI6ymESMr0sKB5j0A=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=AYRe7UydBBubaW7sb4UEwm3rmq27RLIsAOoGYn0bEqX7/1DTOMjg7JEYiRuecpWUu
	 7joHrfDoCZgZ+z0fM+sK4zbQEbH0/f5MSfb/7Od0HMKHh+iMIh/q1v27UC+YzDH3Ku
	 sOUC7BVviAOJ3CkkKDHQ34vjxSEPgA4FCQ34q/lKT8G8KlaXP3X8rL83TD+W05shQ6
	 ZZTJGugsZMvxTe8DJ6gEjYxKX747cZtJvG0LmKMVe8vJvoi3w5X5jVIYJoM4nqnVM7
	 eD7+9XtwgkTZaKdI2ktkABOkLQeAQrxvPzYxjUGJBfXimRv0qEnLimiqivcIqkNhPL
	 yUcpVyTbKG9ZA==
Received: by letrec.thunk.org (Postfix, from userid 15806)
	id B4E848C02FA; Fri, 10 Nov 2023 12:08:35 -0500 (EST)
Date: Fri, 10 Nov 2023 12:08:35 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Aleksandr Nogikh <nogikh@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        syzbot <syzbot+b408cd9b40ec25380ee1@syzkaller.appspotmail.com>,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [ext4?] general protection fault in hrtimer_nanosleep
Message-ID: <ZU5jkxVyudIiciNX@mit.edu>
References: <000000000000cfd180060910a687@google.com>
 <875y2lmxys.ffs@tglx>
 <CANp29Y7EQ0cLf23coqFLLRHbA5rJjq0q1-6G7nnhxqBOUA7apw@mail.gmail.com>
 <87r0l8kv1s.ffs@tglx>
 <CANp29Y5BnnYBauXyHmUKrgrn5LZpz8nDuZFTwLLB7WHq4DS6Wg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANp29Y5BnnYBauXyHmUKrgrn5LZpz8nDuZFTwLLB7WHq4DS6Wg@mail.gmail.com>

On Thu, Nov 09, 2023 at 09:00:18PM -0800, Aleksandr Nogikh wrote:
> 
> The reproducer does work on the attached disk image, but definitely
> not very often. I've just run it 10 times or so and got interleaved
> BUG/KFENCE bug reports like this (twice):
> https://pastebin.com/W0TkRsnw
> 
> These seem to be related to ext4 rather than hrtimers though.

So what would be nice is if there was a way to ask the syzkaller
tester to use a different config or to change the reproducer somehow
--- for example, is it *really* necessary to twiddle the bluetooth
subsystem, as demonstrated by the spew in the console?

I've certainly spent hours cutting down the reproducer to a simple C
program which is readable by humans, which makes it *clear* the syzbot
minimizer doesn't do a good job.  Why should a time-limited maintainer
spend hours trying to cut down the reproducer, when a robot should be
able to do that for us?  And when often it doesn't reproduce on
anything via syzbot test, but not when run using KVM, this is why we
need to have a simple way of trigger a test where things are as close
as possible to whatever syzbot is using.

Cheers,

						- Ted

