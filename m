Return-Path: <linux-fsdevel+bounces-9563-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 571A1842DED
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 21:33:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C582B1F220EB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 20:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D2765C5E0;
	Tue, 30 Jan 2024 20:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lIuzTLaf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB04D273FB;
	Tue, 30 Jan 2024 20:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706646817; cv=none; b=pPwIMIl/jDgIrFTNEF3CXkDA/8iqU07FfOPQqhbyY3UHoOjeuUg9TDnYWFcdYz6nlbRb4r2cD3EUOFDuHMNh4VTm7Ttz4LyIidvRrZENHjRLqXqZ+gdxV6+ehBd9d1jEErN6JumEJeGrTYzpQcNtUPNnffQOBi088LymJ6YCYCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706646817; c=relaxed/simple;
	bh=9gLly5nSMO7HAGLG55biRNk6bSu5VfxJFyy+lw6JMsE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=I3DmFIi+ixvD7leGNteW/sUoZrwQmt5h77oAcsVFLezBJyAfXU7ESnu0Jl+LQ4hHXje6Ar5n6wpAns+ksITdalictmFzPlUqkHipbo69mxegQATNglmYDAgQmaEcW0vKwCdGeFTxwsTkFkQ0G+vtDDOtLlYh8QwGOmgv3aQOxNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lIuzTLaf; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-46b165745deso1160903137.0;
        Tue, 30 Jan 2024 12:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706646815; x=1707251615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gl6S+h5X5duCZxOHIFlZf9cbhJJlXCS97B8qluDa6Fo=;
        b=lIuzTLaf8TPrNQ1CPEuArNYUGqlHg86UGf4TmlatvhNwdVX8YccFKOdZEJ+eIRe5MP
         guVgh9x5ISF/RZgHhBRi3rfZ837it9zxc5DkOfcLtNQel+nUXYVCOmq3lML6ceSsjaJp
         63QrsVUY1O5GlWf4BirslJ8vlgBcByyZnNkkXdBGnRuQT++AU/m5uvuh8cnD+zEgNkLg
         Ltj9rRssvNFP1qfsLUulFHh/T5Jo69Ui3YBTNdrL1w6SsJ3uO1j2KEMyI4KHaLCsgDO2
         0zpV02zho05m4pna7C5CFp/PIXgR9uz/k5zmSM7zNgTgd20R+Ij6dhtSN7+eONzi0RUO
         EH9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706646815; x=1707251615;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Gl6S+h5X5duCZxOHIFlZf9cbhJJlXCS97B8qluDa6Fo=;
        b=Oh71yCIy+uRnpZxC7rsOb2H6s8csznPQRzU3jwmQpOFCU5pQ0gwyS2RYTdicBd7vUH
         44J4rAp6L7UW06SQwJ9ORpwW36m9zPtQ6z++iPfbkdqj0M6JqTUUb97SyaXJLt0e/BVi
         k0KRvK9L8gVRXieZn/D9uCcV62W9/4FLdyeLwySUz4FQvWm2Gq/d7iC630eAcobAKg6b
         DCmJ71P4FlhV/35LBrkJZe8hk+JgEHwO56Y1IwzqvaFZZrydk650sCJ/GTLQwcNGsxrw
         X05uZOZe18UobdtDpVhK6UTNz6Aim7x+9KaOwcmvHqDkSrVd1szj6eq0pGa9GQF3129m
         t5qw==
X-Gm-Message-State: AOJu0Yy0/ak6s6zEpW4+dd6b9/ZRzWdVOlvTZeUvQA2AOeBicadFSuCh
	Wwhs0zFBKei+1JsTCeg4o7jwBtdOtIDFjf5cmMKgYJ6Tdo01qwzV
X-Google-Smtp-Source: AGHT+IGnLs35Tq5pjgU99zjKmp5t5xNf1KEIT+2QAXcXD1XG3HZaCBraj1YrCi+8U4OFhv+0ZMvuJw==
X-Received: by 2002:a05:6102:492:b0:46b:1fd4:8024 with SMTP id n18-20020a056102049200b0046b1fd48024mr5333967vsa.18.1706646814532;
        Tue, 30 Jan 2024 12:33:34 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVCRgXTxafdHn0X3SBiFyJL5ihtpS2Y7c8OLuPQHyjXeiDROoF6Z6jgOJ58EayoNo7PuRpw9n7/Y8D4DgbmLGB3um7pf/CYRcutKNYyQRsZcrs8gvoFZiSb8skE0KBwpW0j9YWbDQ5lGJplLPRsHLDIz70XsK/e+bGQNLkHKLHwFmiIpgHN/Q5vX5Bw0hQji3UtWUubBfrV0BPRnE5AkGlC87tRIkgsA5sdnwm57zrzTHg+pOD8qQ0nUS+d1EEYLvHZ4jB2LJmhA6L7bJW4l+0INb21N++ZR93SKjJSzw68bl0WRMECqvcpAhwNwCfShv8uF+EnL4xlG9zoOER0xvPBkfLRxDx83rsKK5mOtSxpQOFTk5b5UCSIWNNHDhI4r4/ZJ7zSlV/hSoeJ94l2FZ6BmKiEz8oDghqaybEj2fGK9PP5Dz2Fx1PzhkJ7PuUnoNxc6Nq05JTUo+B5FXCF9JXCRUcer0YVrCDyMwNZXnSm5KBeu7Q7y0PbI/KW2D3NrGEwAjMTuOhsLHGewt5glmUocmP5Q4ePvWPC89+VzcGNLa9L7BFZGTbBpwOLfbBW4vKOpU92lC/yTLPMmjrgGBCe75MMjoDSJM1Nb2h66gS8uYG+8k9TY/PbvEABuSjRhOo6Xk/FJfz0Zd05xUrX3XK8XQXspq2w6//008TyO6qrttjpZx5cks8R+e34jrNcuSmdQPEqpGzymW81fIWLcIfy6ZDktoPCDYVF6LpdTQPuSLpPXSNJycIntg6r/ocUSjKMuZIvwrXNKIgd4wBVuGSwQfwpoFL6l5HKVYsjSy3cZ5YFK7dtVn1j3q16bId8JFjumr65pwHS8sX2HiOyuKq8M+7soJ4ISbkwyV+t+c+PTj7bunCrX4E/nNUh7ls6mF6dcUziMs6FQvxA5w1RjsroVadz/52j6oWe2xExswapF/7S3TWO
Received: from localhost (131.65.194.35.bc.googleusercontent.com. [35.194.65.131])
        by smtp.gmail.com with ESMTPSA id oj12-20020a056214440c00b0068c4b445991sm2621485qvb.67.2024.01.30.12.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 12:33:34 -0800 (PST)
Date: Tue, 30 Jan 2024 15:33:33 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Joe Damato <jdamato@fastly.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, 
 chuck.lever@oracle.com, 
 jlayton@kernel.org, 
 linux-api@vger.kernel.org, 
 brauner@kernel.org, 
 edumazet@google.com, 
 davem@davemloft.net, 
 alexander.duyck@gmail.com, 
 sridhar.samudrala@intel.com, 
 kuba@kernel.org, 
 weiwan@google.com, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Andrew Waterman <waterman@eecs.berkeley.edu>, 
 Arnd Bergmann <arnd@arndb.de>, 
 Dominik Brodowski <linux@dominikbrodowski.net>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jan Kara <jack@suse.cz>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Julien Panis <jpanis@baylibre.com>, 
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, 
 "(open list:FILESYSTEMS \\(VFS and infrastructure\\))" <linux-fsdevel@vger.kernel.org>, 
 Michael Ellerman <mpe@ellerman.id.au>, 
 Nathan Lynch <nathanl@linux.ibm.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Steve French <stfrench@microsoft.com>, 
 Thomas Huth <thuth@redhat.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>
Message-ID: <65b95d1de41cc_ce3aa294fa@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240129190922.GA1315@fastly.com>
References: <20240125225704.12781-1-jdamato@fastly.com>
 <65b52d6381de7_3a9e0b2943d@willemb.c.googlers.com.notmuch>
 <20240129190922.GA1315@fastly.com>
Subject: Re: [PATCH net-next v3 0/3] Per epoll context busy poll support
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Joe Damato wrote:
> On Sat, Jan 27, 2024 at 11:20:51AM -0500, Willem de Bruijn wrote:
> > Joe Damato wrote:
> > > Greetings:
> > > 
> > > Welcome to v3. Cover letter updated from v2 to explain why ioctl and
> > > adjusted my cc_cmd to try to get the correct people in addition to folks
> > > who were added in v1 & v2. Labeled as net-next because it seems networking
> > > related to me even though it is fs code.
> > > 
> > > TL;DR This builds on commit bf3b9f6372c4 ("epoll: Add busy poll support to
> > > epoll with socket fds.") by allowing user applications to enable
> > > epoll-based busy polling and set a busy poll packet budget on a per epoll
> > > context basis.
> > > 
> > > This makes epoll-based busy polling much more usable for user
> > > applications than the current system-wide sysctl and hardcoded budget.
> > > 
> > > To allow for this, two ioctls have been added for epoll contexts for
> > > getting and setting a new struct, struct epoll_params.
> > > 
> > > ioctl was chosen vs a new syscall after reviewing a suggestion by Willem
> > > de Bruijn [1]. I am open to using a new syscall instead of an ioctl, but it
> > > seemed that: 
> > >   - Busy poll affects all existing epoll_wait and epoll_pwait variants in
> > >     the same way, so new verions of many syscalls might be needed. It
> > 
> > There is no need to support a new feature on legacy calls. Applications have
> > to be upgraded to the new ioctl, so they can also be upgraded to the latest
> > epoll_wait variant.
> 
> Sure, that's a fair point. I think we could probably make reasonable
> arguments in both directions about the pros/cons of each approach.
> 
> It's still not clear to me that a new syscall is the best way to go on
> this, and IMO it does not offer a clear advantage. I understand that part
> of the premise of your argument is that ioctls are not recommended, but in
> this particular case it seems like a good use case and there have been
> new ioctls added recently (at least according to git log).
> 
> This makes me think that while their use is not recommended, they can serve
> a purpose in specific use cases. To me, this use case seems very fitting.
> 
> More of a joke and I hate to mention this, but this setting is changing how
> io is done and it seems fitting that this done via an ioctl ;)
> 
> > epoll_pwait extends epoll_wait with a sigmask.
> > epoll_pwait2 extends extends epoll_pwait with nsec resolution timespec.
> > Since they are supersets, nothing is lots by limiting to the most recent API.
> > 
> > In the discussion of epoll_pwait2 the addition of a forward looking flags
> > argument was discussed, but eventually dropped. Based on the argument that
> > adding a syscall is not a big task and does not warrant preemptive code.
> > This decision did receive a suitably snarky comment from Jonathan Corbet [1].
> > 
> > It is definitely more boilerplate, but essentially it is as feasible to add an
> > epoll_pwait3 that takes an optional busy poll argument. In which case, I also
> > believe that it makes more sense to configure the behavior of the syscall
> > directly, than through another syscall and state stored in the kernel.
> 
> I definitely hear what you are saying; I think I'm still not convinced, but
> I am thinking it through.
> 
> In my mind, all of the other busy poll settings are configured by setting
> options on the sockets using various SO_* options, which modify some state
> in the kernel. The existing system-wide busy poll sysctl also does this. It
> feels strange to me to diverge from that pattern just for epoll.

I think the stateful approach for read is because there we do want
to support all variants: read, readv, recv, recvfrom, recvmsg,
recvmmsg. So there is no way to pass it directly.

That said, I don't mean to argue strenously for this API or against
yours. Want to make sure the option space is explored. There does not
seem to be much other feedback. I don't hold a strong opinion either.

> In the case of epoll_pwait2 the addition of a new syscall is an approach
> that I think makes a lot of sense. The new system call is also probably
> better from an end-user usability perspective, as well. For busy poll, I
> don't see a clear reasoning why a new system call is better, but maybe I am
> still missing something.
>
> > I don't think that the usec fine grain busy poll argument is all that useful.
> > Documentation always suggests setting it to 50us or 100us, based on limited
> > data. Main point is to set it to exceed the round-trip delay of whatever the
> > process is trying to wait on. Overestimating is not costly, as the call
> > returns as soon as the condition is met. An epoll_pwait3 flag EPOLL_BUSY_POLL
> > with default 100us might be sufficient.
> > 
> > [1] https://lwn.net/Articles/837816/
> 
> Perhaps I am misunderstanding what you are suggesting, but I am opposed to
> hardcoding a value. If it is currently configurable system-wide and via
> SO_* options for other forms of busy poll, I think it should similarly be
> configurable for epoll busy poll.
> 
> I may yet be convinced by the new syscall argument, but I don't think I'd
> agree on imposing a default. The value can be modified by other forms of
> busy poll and the goal of my changes are to:
>   - make epoll-based busy poll per context
>   - allow applications to configure (within reason) how epoll-based busy
>     poll behaves, like they can do now with the existing SO_* options for
>     other busy poll methods.

Okay. I expected some push back. Was curious if people would come back
with examples of where the full range is actually being used.

> > >     seems much simpler for users to use the correct
> > >     epoll_wait/epoll_pwait for their app and add a call to ioctl to enable
> > >     or disable busy poll as needed. This also probably means less work to
> > >     get an existing epoll app using busy poll.
> > 



