Return-Path: <linux-fsdevel+bounces-39741-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26816A1739B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 21:32:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 705BF1887EF2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2025 20:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61BBB1EEA5F;
	Mon, 20 Jan 2025 20:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DPflXO5f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D501EB9FF
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jan 2025 20:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737405118; cv=none; b=XLvAOWsPNHOh9lGmz7gqYOMNRv64E3Gd6t9wJEgKZLSoBBPch9InmxbozdQjC4/UTeue/axhW8Kc8GUehwIy/u900mQtGLE0GYf6bIyva6nrkfb2Gf/VNmhGmTNGp0CXFpgzitNutsmDoUdTvQXpYF3lAFDylsb7T8oCzZgfpC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737405118; c=relaxed/simple;
	bh=UXQRV6DOGwJTkKBaBzpTH5rImNq0yk7LUt6n0baV8OY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LRtHsQcA/wh6ADQ3KKI34mOJxpOjUjx8jOZgePsz77fcUlQQAhHpmv1J4D3xMbL/Xwgn5htb7hDvbeegTdzTherh12fyBi/ohhXWasuK4kaMnzgTLHOujRBQjHVVFrlfyCHyMzirmV5YY9wJZ3EtWGg2fZE8UlKN3D+ue+px3r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DPflXO5f; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737405116;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UXQRV6DOGwJTkKBaBzpTH5rImNq0yk7LUt6n0baV8OY=;
	b=DPflXO5fkR0gibckeoaG/WR4nBZo70+pEWM/uEUHoL4/VTqAeXKuajJZsmuqNLKCUmIDyh
	Cwn9VABdYdLszUVpPZFF6+/JNCfwOb3/zrKlfvEJ28DsqaJpIoZAO/TJFJTAsaSWHtv32i
	AVILWrgJxy5wwNo/P9R2NWziWjeZSqY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-362-iHnsydcWPvOW678gFUxgLQ-1; Mon,
 20 Jan 2025 15:31:50 -0500
X-MC-Unique: iHnsydcWPvOW678gFUxgLQ-1
X-Mimecast-MFC-AGG-ID: iHnsydcWPvOW678gFUxgLQ
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C15461955DC0;
	Mon, 20 Jan 2025 20:31:48 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.104])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 3134C195608A;
	Mon, 20 Jan 2025 20:31:45 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 20 Jan 2025 21:31:23 +0100 (CET)
Date: Mon, 20 Jan 2025 21:31:19 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, Christian Brauner <brauner@kernel.org>,
	WangYuli <wangyuli@uniontech.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [linux-next:master] [pipe_read] aaec5a95d5:
 stress-ng.poll.ops_per_sec 11.1% regression
Message-ID: <20250120203118.GF7432@redhat.com>
References: <202501201311.6d25a0b9-lkp@intel.com>
 <leot53sdd6es2xsnljub4rr4n3xgusft6huntr437wmaoo5rob@hhbtzrwgxel2>
 <20250120121928.GA7432@redhat.com>
 <20250120124209.GB7432@redhat.com>
 <CAGudoHFOsRWT0nKRKqFwgHdAhs0NOEO4y-q7Gg4cjm9KBxQc9A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGudoHFOsRWT0nKRKqFwgHdAhs0NOEO4y-q7Gg4cjm9KBxQc9A@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Mateusz,

I'm afraid my emails can look as if I am trying to deny the problem.
No. Just I think we need to understand why exactly this patch makes
a difference.

On 01/20, Mateusz Guzik wrote:
>
> While I'm too tired to dig into the code at the momen,

Me too.

> I checked how often the sucker goess off cpu, like so: bpftrace -e
> 'kprobe:schedule { @[kstack()] = count(); }'
>
> With your patch I reliably get about 38 mln calls from pipe_read.
> Without your patch this drops to about 17 mln, as in less than half.

Heh ;) I don't use bpftrace, but with the help of printk() I too noticed
the difference (although not that big) when I tried to understand the 1st
report https://lore.kernel.org/all/202501101015.90874b3a-lkp@intel.com/

Not that I really understand this difference, but I am not really surpised.
With this patch the writers have more CPU (due to unnecessary wakeups).

What really surprises me is that (with or without this patch) the readers
call wait_event/schedule MUUUUUUUUUUUUCH more than the writers.

I guess this is because sender() and receiver() are not "symmetric",
sender() writes to the "random" fd, while receiver() always reads from
the same ctx->in_fds[0]... Still not clear to me.

And I don't understand what workload this logic tries to simulate, but
this doesn't matter.

Oleg.


