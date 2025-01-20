Return-Path: <linux-fsdevel+bounces-39669-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3105BA16C45
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 13:23:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E0FC3A1EA6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 12:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901B11DF993;
	Mon, 20 Jan 2025 12:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bwn5Xu+0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753091DFFC
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jan 2025 12:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737375814; cv=none; b=NaFFLh9gV4GCtacO3HE9AmCvWm/9MSSrfpHTIvCTdkeT2r4JOqMAYfEUg5W9d6qriiXMFY7BWYVpZiwRDej4jqYY6u6u2z1yNMsGva9NDNZfhr/RxEmuidis9AOFjKGfm5sPfEPn7U0VeDCpHF/yZkOrr88bKOr26zD/5R0BoOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737375814; c=relaxed/simple;
	bh=UaTzTANVudPEZxpSfU2G4TBv9B+w00ZKRmEE6dV8LT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kMVzPz8i0g+HAfmaY9ZFYdKF4CxIGWGuf98m+5t53fbAdwP8S4dDW4gUyChJdmxh6dJT681/3yBuvP31ERrAvGs+DW9DUohF7FzSrWqb9/mz6yo6EBeL/lxmfZlx7zHrIDUMjUiA9elnwMF6ftqTwbg9qR0xZ4Xn0rM3Lsff3SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bwn5Xu+0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737375811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UaTzTANVudPEZxpSfU2G4TBv9B+w00ZKRmEE6dV8LT8=;
	b=Bwn5Xu+0cez+lW8jlmuwLV/tTW1RK7otoLhEOCmkymfFdsrKAuGkmERkNjbIpDs2ZuEKE8
	9Nt3lp0yS9oeKtA+FKUl6qPfYAvLAmnrYj/ANKP9MJ6RQpleIdU45WbQJ9N+qM6csatSmv
	JZTBE7ZxI+WuFqbeViwV6DtyguPofro=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-58-CMDVTjksPZOAiifCjJ6gMg-1; Mon,
 20 Jan 2025 07:23:27 -0500
X-MC-Unique: CMDVTjksPZOAiifCjJ6gMg-1
X-Mimecast-MFC-AGG-ID: CMDVTjksPZOAiifCjJ6gMg
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E0F97195605B;
	Mon, 20 Jan 2025 12:23:25 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.104])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id E142F3003FD9;
	Mon, 20 Jan 2025 12:23:22 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 20 Jan 2025 13:23:00 +0100 (CET)
Date: Mon, 20 Jan 2025 13:22:56 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, Christian Brauner <brauner@kernel.org>,
	WangYuli <wangyuli@uniontech.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [linux-next:master] [pipe_read]  aaec5a95d5:
 stress-ng.poll.ops_per_sec 11.1% regression
Message-ID: <20250120121928.GA7432@redhat.com>
References: <202501201311.6d25a0b9-lkp@intel.com>
 <leot53sdd6es2xsnljub4rr4n3xgusft6huntr437wmaoo5rob@hhbtzrwgxel2>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <leot53sdd6es2xsnljub4rr4n3xgusft6huntr437wmaoo5rob@hhbtzrwgxel2>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 01/20, Mateusz Guzik wrote:
>
> Whatever the long term fate of the patch I think it would be prudent to
> skip it in this merge window.

Perhaps... I'll try to take another look tomorrow.

Just one note right now.

> First two notes:
> 1. the change only considers performing a wake up if the current
> source buf got depleted -- if there is a blocked writer and there is at
> least one byte in the current buf nothing happens, which is where the
> difference in results is coming from

Sorry I don't understand. Unless this patch is buggy, pipe_read() must
always wakeup a blocked writer if the writer can write at least one byte.

The writer can't write to "current" buf = pipe->bufs[tail & mask] if
pipe_full() is still true.

Oleg.


