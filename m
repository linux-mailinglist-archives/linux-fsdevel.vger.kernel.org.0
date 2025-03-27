Return-Path: <linux-fsdevel+bounces-45162-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07E61A73E80
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Mar 2025 20:24:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E188175C4B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Mar 2025 19:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF18C18A6DB;
	Thu, 27 Mar 2025 19:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fv8V2g+B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CBC1C5D4C;
	Thu, 27 Mar 2025 19:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743103487; cv=none; b=F6a54OC5hv2qY51+ymU7couT3SBRHr6sjJpsCgN1eDKplx3UPKWmw3noYbO1R6NfBMhKQen/2fDZp2Ohc868dD6RQpfv6fgAAHnG8XaN5naH6q6lEDSX+P5UP9nu2waeYt6rdEfdpNtSXL6s/fQ7L9zmJgQkozVSLLf39025nB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743103487; c=relaxed/simple;
	bh=xCDgRgJ+Yf3Zo6gUXMr9RnA4Ns56kDZwStaXZYX8qjQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=TGY0eEFvkxGjoJN+5xSUCjfxQsEUyWClT9p6ruqlcRLsAkaFwxTMtR81e0oZbaw4LvTKTg0bhrFTg9yxZQTiPI45LW3CYgVLgWSduqcfEBkIEJxeimd4VJ2RV0OEGgFyVN/pi/UbxTqXAPUYtDLqruLTrZVdHLWQ6fVnta6CAzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=fv8V2g+B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 327A4C4CEDD;
	Thu, 27 Mar 2025 19:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1743103486;
	bh=xCDgRgJ+Yf3Zo6gUXMr9RnA4Ns56kDZwStaXZYX8qjQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fv8V2g+BSGKPVcjd2jNjhcee5q0gjgQwa7E4fLrEk3fKZtg2ToIpAD6WR0gu4nwtN
	 NUm5v1RtF10lWcz6lljPShpvPi/hcEjl9lAwyK6Em9gMdhbydmj+lDEMTDaXVRB/Wm
	 OC1GkAafpGt8Y1fT6dXRco27+2Ljly1vZjKIR7mk=
Date: Thu, 27 Mar 2025 12:24:45 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Penglei Jiang <superman.xpt@gmail.com>
Cc: mjguzik@gmail.com, adrian.ratiu@collabora.com, brauner@kernel.org,
 felix.moessbauer@siemens.com, jlayton@kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 lorenzo.stoakes@oracle.com,
 syzbot+02e64be5307d72e9c309@syzkaller.appspotmail.com,
 syzbot+f9238a0a31f9b5603fef@syzkaller.appspotmail.com, tglx@linutronix.de,
 viro@zeniv.linux.org.uk, xu.xin16@zte.com.cn
Subject: Re: [PATCH V2] proc: Fix the issue of proc_mem_open returning NULL
Message-Id: <20250327122445.cbd211c3216aa754917f3677@linux-foundation.org>
In-Reply-To: <20250325041448.43211-1-superman.xpt@gmail.com>
References: <ajipijba74lvxh2qqyxbxtbmlqil2smsuxayym5ipbmjdysxq2@stvu4kt62yzu>
	<20250325041448.43211-1-superman.xpt@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Mar 2025 21:14:48 -0700 Penglei Jiang <superman.xpt@gmail.com> wrote:

> > >  if (IS_ERR(mm))
> > > -return mm == ERR_PTR(-ESRCH) ? NULL : mm;
> > > +return mm;
> > >
> > >  /* ensure this mm_struct can't be freed */
> > >  mmgrab(mm);
> > > --
> > > 2.17.1
> > >
> 
> Mateusz Guzik provides valuable suggestions.
> 
> Complete the missing NULL checks.

proc_mem_open() can return errno, NULL or mm_struct*.  It isn't obvious
why.

While you're in there can you please add documentation to
proc_mem_open() which explains its return values?

