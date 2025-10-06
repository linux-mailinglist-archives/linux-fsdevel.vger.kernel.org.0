Return-Path: <linux-fsdevel+bounces-63492-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ABD4DBBE283
	for <lists+linux-fsdevel@lfdr.de>; Mon, 06 Oct 2025 15:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9978018970D7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Oct 2025 13:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 548552D0618;
	Mon,  6 Oct 2025 13:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="suZYBJ5k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from r3-22.sinamail.sina.com.cn (r3-22.sinamail.sina.com.cn [202.108.3.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7798E267B9B
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Oct 2025 13:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759756603; cv=none; b=X+Dxps+gjBWHgrCuolx4lBy7UECVqdOeIpvnJ74grFEUL1r0kwAskIOw1ZDcsP+g2FUq5OWaUx6V3DrZGXn+LksKsRal2cT+6QYVdjCtri5SMfxPzW/8jgFFzpgyS3otBj4UIuzirOCUUl7pKV6E2YEUfIVWXD0zGX0KlC5JtQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759756603; c=relaxed/simple;
	bh=u3cKwQ/hTEFRDr4aDr8z7FfCeyXmAvEuSX0PEbU89WQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UU6crjTl+auAdCxAeXgxQMrjC9QU/HyyYSB6Wc837kE/UBWSUTC1siu+1B+tLLVKgfxZY40cNqa/0WpRbEW8ZnNr0o29bwVky+d23+sTY3/kDzVswxtK3DR38b0guhzURzb5FSbcQrjUKbBAw15Mo3dC1JyML8xuXIuOOnYPlEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=suZYBJ5k; arc=none smtp.client-ip=202.108.3.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1759756598;
	bh=fgLvmbN/6fP7SxWS3f2gpTaHJkF8Nxr/COMwyxv8VTw=;
	h=From:Subject:Date:Message-ID;
	b=suZYBJ5k+oR9j8G6Xf/Na5OlYHhBKunCd2JZAw0YHVdYYz3tNaVgSp2KT/uKBdjNh
	 sUmnAv0qMQlaZlqUeOcUaxweel2SDqLTY+0+oj8yw6qXZjBqtThuN0JQ8MbBCQF7c1
	 n5lKJ4BswWts0E7kVQrpKumPhfsPiQrOCZvrQyBM=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.33) with ESMTP
	id 68E3C106000075F8; Mon, 6 Oct 2025 21:15:52 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 4891596685193
X-SMAIL-UIID: 0E362BD497144BB5BF50782985302B98-20251006-211552-1
From: Hillf Danton <hdanton@sina.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: add missing fences to I_NEW handling
Date: Mon,  6 Oct 2025 21:15:38 +0800
Message-ID: <20251006131543.8283-1-hdanton@sina.com>
In-Reply-To: <CAGudoHFai7eUj3W-wW_8Cb4HFhTH3a=_37kT-eftP-QZv7zdPg@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 6 Oct 2025 12:30:01 +0200 Mateusz Guzik wrote:
> On Mon, Oct 6, 2025 at 9:21 AM Hillf Danton <hdanton@sina.com> wrote:
> > On Mon, 6 Oct 2025 03:16:43 +0200 Mateusz Guzik wrote:
> > > That fence synchronizes against threads which went to sleep.
> > >
> > > In the example I'm providing this did not happen.
> > >
> > >   193 static inline void wait_on_inode(struct inode *inode)
> > >   194 {
> > >   195         wait_var_event(inode_state_wait_address(inode, __I_NEW),
> > >   196                       !(READ_ONCE(inode->i_state) & I_NEW));
> > >
> > >   303 #define wait_var_event(var, condition)                                  \
> > >   304 do {                                                                    \
> > >   305         might_sleep();                                                  \
> > >   306         if (condition)                                                  \
> > >   307                 break;                                                  \
> > >
> > > I_NEW is tested here without any locks or fences.
> > >
> > Thanks, got it but given the comment of the current mem barrier in
> > unlock_new_inode(), why did peterZ/Av leave such a huge chance behind?
> >
> My guess is nobody is perfect -- mistakes happen.
> 
I do not think you are so lucky -- the code has been there for quite a while.

> > The condition check in waitqueue_active() matches waitqueue_active() in
> > __wake_up_bit(), and both make it run fast on both the waiter and the
> > waker sides, no?
> 
Your quotation here is different from my reply [2]. Weird.

    The condition check in wait_var_event() matches waitqueue_active() in
    __wake_up_bit(), and both make it run fast on both the waiter and the
    waker sides, no?

[2] https://lore.kernel.org/lkml/20251006072136.8236-1-hdanton@sina.com/

> So happens the commentary above wait_var_event() explicitly mentions
> you want an acquire fence:
>   299  * The condition should normally use smp_load_acquire() or a similarly
>   300  * ordered access to ensure that any changes to memory made before the
>   301  * condition became true will be visible after the wait completes.

What is missed is recheck -- adding self on to wait queue with a true condition
makes no sense.

 * Wait for a @condition to be true, only re-checking when a wake up is
 * received for the given @var (an arbitrary kernel address which need
 * not be directly related to the given condition, but usually is).
> 
> The commentary about waitqueue_active() says you want and even
> stronger fence (smp_mb) for that one:

Yes, it matches the current code, so your change is not needed.

>    104  * Use either while holding wait_queue_head::lock or when used for wakeups
>    105  * with an extra smp_mb() like::
>    106  *
>    107  *      CPU0 - waker                    CPU1 - waiter
>    108  *
>    109  *                                      for (;;) {
>    110  *      @cond = true; 			   prepare_to_wait(&wq_head, &wait, state);
>    111  *      smp_mb();                         // smp_mb() from set_current_state()
>    112  *      if (waitqueue_active(wq_head))         if (@cond)
>    113  *        wake_up(wq_head);                      break;
>    114  *                                        schedule();
>    115  *                                      }
>    116  *                                      finish_wait(&wq_head, &wait);

