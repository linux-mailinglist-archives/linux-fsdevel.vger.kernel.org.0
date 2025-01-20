Return-Path: <linux-fsdevel+bounces-39672-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13115A16C7A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 13:42:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C15D11889865
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 12:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96FB51E0DB5;
	Mon, 20 Jan 2025 12:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dv6iEKv3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848261DFE14
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jan 2025 12:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737376970; cv=none; b=UMi09iZtSLh4ATBnmsOFtYGIluQwdff3YhQ6Tbxz4MeqLbjnFBX/FlFdREr1vDgGRmB7CtEVlfN57xyfIFcqeDXwKxZKyMSqnt3sUzOplx/7/3104Jm6WJ8BXygM/OHroZswF7l/t+W4gbzJArIqriX9C9zpbmST8i5LP7jG90k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737376970; c=relaxed/simple;
	bh=ljOvUhnQMd/bR+2NO4+rfciOdIOy6YM2mR6nKravZng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JPhYBejDGB9kezrvleg0dUZuHdzQCZW3WRbeRDRUiYfJBLkGAE4X7lxI3dQlHgsGG2rea4WQjyJhf7qCQKZuJ6Y0eIzSPaDflJXOck/fLs8Rk+vGwMMPy0HO0BxBsBbVcjkTXbDgkRJb7jKbWNgnet7M1qstHxqe9+N/WaXWoek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dv6iEKv3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737376967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ljOvUhnQMd/bR+2NO4+rfciOdIOy6YM2mR6nKravZng=;
	b=Dv6iEKv3Nrco62GIP0rTxZJ3MKWxVtQ6QzGc+2BfNw/w0PMB4m9BfaxgpUJ8vIN/5G2ggv
	I9nQH9kejzT2Tp4BzBJ/6q58T8tkrgpHqUoKhZbci2Kepw+FPMBV4T6bN8WtjNZfcueUSc
	fPmNC6Lj2jUP5LnHjj9GHnK6Ab3ExLE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-250-DuTuzjEFNteS6GqyxJJMrg-1; Mon,
 20 Jan 2025 07:42:42 -0500
X-MC-Unique: DuTuzjEFNteS6GqyxJJMrg-1
X-Mimecast-MFC-AGG-ID: DuTuzjEFNteS6GqyxJJMrg
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2BAD21955D89;
	Mon, 20 Jan 2025 12:42:40 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.104])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 220E019560A3;
	Mon, 20 Jan 2025 12:42:35 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 20 Jan 2025 13:42:15 +0100 (CET)
Date: Mon, 20 Jan 2025 13:42:10 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, Christian Brauner <brauner@kernel.org>,
	WangYuli <wangyuli@uniontech.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [linux-next:master] [pipe_read]  aaec5a95d5:
 stress-ng.poll.ops_per_sec 11.1% regression
Message-ID: <20250120124209.GB7432@redhat.com>
References: <202501201311.6d25a0b9-lkp@intel.com>
 <leot53sdd6es2xsnljub4rr4n3xgusft6huntr437wmaoo5rob@hhbtzrwgxel2>
 <20250120121928.GA7432@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250120121928.GA7432@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Forgot to mention...

On 01/20, Oleg Nesterov wrote:
>
> On 01/20, Mateusz Guzik wrote:
> >
> > Whatever the long term fate of the patch I think it would be prudent to
> > skip it in this merge window.
>
> Perhaps... I'll try to take another look tomorrow.
>
> Just one note right now.
>
> > First two notes:
> > 1. the change only considers performing a wake up if the current
> > source buf got depleted -- if there is a blocked writer and there is at
> > least one byte in the current buf nothing happens, which is where the
> > difference in results is coming from
>
> Sorry I don't understand. Unless this patch is buggy, pipe_read() must
> always wakeup a blocked writer if the writer can write at least one byte.
>
> The writer can't write to "current" buf = pipe->bufs[tail & mask] if
> pipe_full() is still true.

But I'll recheck this logic once again tomorrow, perhaps I misread
pipe_write() when I made this patch.

Oleg.


