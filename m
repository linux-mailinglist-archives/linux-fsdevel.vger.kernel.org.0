Return-Path: <linux-fsdevel+bounces-63456-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AB6BBBD345
	for <lists+linux-fsdevel@lfdr.de>; Mon, 06 Oct 2025 09:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 802564E852A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Oct 2025 07:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B634825782F;
	Mon,  6 Oct 2025 07:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="wZP6kRgK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from r3-20.sinamail.sina.com.cn (r3-20.sinamail.sina.com.cn [202.108.3.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E731EAF9
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Oct 2025 07:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759735318; cv=none; b=F/6WvVsz0lfrmmft3sN+zOv3OAcMY6EWUX+N+zI6tWsvDl8+WunAhPhBvqciJRqRZ2HwnoSRbL7FfGcqmIplGeMT3IEwGwXSlziHm6QpAL6ewc0KuTFX56VshtgBimk8FJJYtWaFZtdpPWgBX/BkpNwkP+u20aJMlomYV9nlu6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759735318; c=relaxed/simple;
	bh=IS8FP+HFTGX/hKWw0IiRmebLsU4ORkTaoZ293YLvHA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V/OiRz0tN/1H68Q7mRqFXGzekhjlw/y2SR/AKjwER08Cafu1cYl5XJtQ03Ub3leRKxYS7ja3w6MR9miCjZqkUTULDvTjugx77wYPbxY1RQ4rh8+0f/8J7MPWOnffC4XIOTalqf3OVpw+9TSW+e/+w7qbU4/qkvxnYDLkhCaqtrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=wZP6kRgK; arc=none smtp.client-ip=202.108.3.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1759735314;
	bh=l+4oQF7uaD56NnROc22RBOL/qGGAHvdKqWFp59zG2xk=;
	h=From:Subject:Date:Message-ID;
	b=wZP6kRgKtdiiQizg5DacKpNSj1yAdLKo76AuVqRpXRhhWkSKjsg8qy6S8B7XswyJP
	 zduxJEXr0+YRkl/itZQjcKLYdF0YdC1oJb94C8bH2qWNwBK/8xl8RigYKL27DOXrV1
	 k0jLTdEGfSoWt1Ibuug7oQsWckUGpby+OE4VLRTc=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.58.236])
	by sina.com (10.54.253.32) with ESMTP
	id 68E36E0600006DF5; Mon, 6 Oct 2025 15:21:44 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 3463654456658
X-SMAIL-UIID: DA3A89ED1FB64D27A9F663C80BDA8ED2-20251006-152144-1
From: Hillf Danton <hdanton@sina.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: add missing fences to I_NEW handling
Date: Mon,  6 Oct 2025 15:21:08 +0800
Message-ID: <20251006072136.8236-1-hdanton@sina.com>
In-Reply-To: <CAGudoHFi-9qYPnb9xPtGsUq+Mf_8h+uk4iQDo1TggZYPgTv6fA@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 6 Oct 2025 03:16:43 +0200 Mateusz Guzik wrote:
> On Mon, Oct 6, 2025 at 2:57 AM Hillf Danton <hdanton@sina.com> wrote:
> > On Mon,  6 Oct 2025 01:15:26 +0200 Mateusz Guzik wrote:
> > > Suppose there are 2 CPUs racing inode hash lookup func (say ilookup5())
> > > and unlock_new_inode().
> > >
> > > In principle the latter can clear the I_NEW flag before prior stores
> > > into the inode were made visible.
> > >
> > Given difficulty following up here, could you specify why the current
> > mem barrier [1] in unlock_new_inode() is not enough?
> >
> That fence synchronizes against threads which went to sleep.
> 
> In the example I'm providing this did not happen.
> 
>   193 static inline void wait_on_inode(struct inode *inode)
>   194 {
>   195         wait_var_event(inode_state_wait_address(inode, __I_NEW),
>   196                       !(READ_ONCE(inode->i_state) & I_NEW));
> 
>   303 #define wait_var_event(var, condition)                                  \
>   304 do {                                                                    \
>   305         might_sleep();                                                  \
>   306         if (condition)                                                  \
>   307                 break;                                                  \
> 
> I_NEW is tested here without any locks or fences.
> 
Thanks, got it but given the comment of the current mem barrier in
unlock_new_inode(), why did peterZ/Av leave such a huge chance behind?

The condition check in wait_var_event() matches waitqueue_active() in
__wake_up_bit(), and both make it run fast on both the waiter and the
waker sides, no?

