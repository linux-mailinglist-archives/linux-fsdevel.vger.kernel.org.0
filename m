Return-Path: <linux-fsdevel+bounces-33399-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF629B8929
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 03:15:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E3561C2169E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Nov 2024 02:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 559F513665A;
	Fri,  1 Nov 2024 02:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="mMSovBIq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A48F17C91;
	Fri,  1 Nov 2024 02:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730427294; cv=none; b=XYEuELifQkYNPHJRvcE/rGUE7o/xQVEv/yJAk7b7hXjFaZsvZjDRJkTGBdCDvWmXuue/7nI5u0JJNGOkHupiMKjJwgussgKEAW3sqADV6WnMlt+YXfuyJt35qnjYGYHhbZt9U+YlCJrbX3giPcy/LIZVV8TSF3y1QEvAgGVKJ3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730427294; c=relaxed/simple;
	bh=WiLZE8rRRBEflPzLN5uejNR50UoaoGgoQNJ1aHXz76Q=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=pPIrfU+k3+h9d5wRHpoDuC6to4U/D17SBXpxtMmRmqE7KLVN1dzw7jLSU6GpAmi4KLbC2HODq0FwOzvZ4lZx6MruRDd518FpIraFjUtDHEIXQ40q1Mcblio/J3IGwVSOnVA73wQHOKkvXy3aL7GPcAqUSNguSFTqY7b2+Pi2pws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=mMSovBIq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCBEFC4CEC3;
	Fri,  1 Nov 2024 02:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1730427294;
	bh=WiLZE8rRRBEflPzLN5uejNR50UoaoGgoQNJ1aHXz76Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mMSovBIqrt7WpcLtd3la/CDCmBAEEi0YiiNRn35A2r49mo8RPOa8UB71UDjrbto/t
	 nRmA2Lb6z1Vy0t5umVTrim/zthXoli+UsBx/ILbdYCpFWEICSbEreBHJvoZotzpY5L
	 a9GHqXgIwlxg6D+erXduWaqMVUt5TOl5QkJuanX8=
Date: Thu, 31 Oct 2024 19:14:53 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Qingjie Xing <xqjcool@gmail.com>
Cc: christophe.jaillet@wanadoo.fr, willy@infradead.org, brauner@kernel.org,
 adobriyan@gmail.com, viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] proc: Add a way to make proc files writable
Message-Id: <20241031191453.a4c55e8b2bfb4bf8349f4287@linux-foundation.org>
In-Reply-To: <20241101013920.28378-1-xqjcool@gmail.com>
References: <20241101013920.28378-1-xqjcool@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 31 Oct 2024 18:39:20 -0700 Qingjie Xing <xqjcool@gmail.com> wrote:

> Provide an extra function, proc_create_single_write_data() that
> act like its non-write version but also set a write method in
> the proc_dir_entry struct. Alse provide a macro
> proc_create_single_write to reduces the boilerplate code in the callers.
> 

Please fully describe the reason for making this change.

Also, we are reluctant to add a new interface to Linux unless we add
new users of that interface at the same time.

Thanks.

