Return-Path: <linux-fsdevel+bounces-39930-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9FF5A1A498
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 13:56:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00CEE3A7A21
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 12:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD0F20F07C;
	Thu, 23 Jan 2025 12:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cCRjEH7m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B975E20E6F0
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jan 2025 12:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737637007; cv=none; b=g2IzSCNmex1hfwcmconiLrVgsqMoKzlGA1bBUyLmNHDPB0SSQU1l2YJg0uSHJaVHHyQ63Q7oZZpUI4ls+2oHJaVA+ZcMO164WqyDp3pSuaqiHL+2xBb43jGJfHXD7bPZbK806u9902QbYQPV4A5+QCZAOl/dacOP1Fo3RlpO/bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737637007; c=relaxed/simple;
	bh=uNA4qMy5D/nSQ/qCnJsdSnhHTssNBm2lRMEc44lDcNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZLK2srT2gMU5TZEo1k9jusQpOejSMprtrvZkbQrUfVOl/yI8/xjdFJhanzOhSmgEBK1//23KBV0GiJrzMXph4u7ptspAqHfo5bQ8X2MXIIKPilExbbp4xfoqBst85VxbnVzMCpDwSNPzMHRLUJk/ZzRW/lHwKPbrdgdjBVry4fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cCRjEH7m; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737637004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uNA4qMy5D/nSQ/qCnJsdSnhHTssNBm2lRMEc44lDcNI=;
	b=cCRjEH7mgOuP9CI7g+/DyU3yYTEaLDPo0s/pZVGoaE9MYN7a5Xcf8OLnP4XjJv7JTSbTRo
	lhtu+wx9WOjf82CasaYIhdAm/IAp/HacIrX0XpRQ3gwTpLdA7eeQHtQ1JbtXW+A5YdQr4F
	6hsYi4Sw39V8LbmT+mo5Qlp1YPBqDok=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-561-RiA7HC03OAuSWWDVQ0D7Cw-1; Thu,
 23 Jan 2025 07:56:40 -0500
X-MC-Unique: RiA7HC03OAuSWWDVQ0D7Cw-1
X-Mimecast-MFC-AGG-ID: RiA7HC03OAuSWWDVQ0D7Cw
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E67181955DE0;
	Thu, 23 Jan 2025 12:56:37 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.64])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 0C658195608A;
	Thu, 23 Jan 2025 12:56:34 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu, 23 Jan 2025 13:56:11 +0100 (CET)
Date: Thu, 23 Jan 2025 13:56:08 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, Christian Brauner <brauner@kernel.org>,
	WangYuli <wangyuli@uniontech.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [linux-next:master] [pipe_read] aaec5a95d5:
 stress-ng.poll.ops_per_sec 11.1% regression
Message-ID: <20250123125607.GA16498@redhat.com>
References: <202501201311.6d25a0b9-lkp@intel.com>
 <leot53sdd6es2xsnljub4rr4n3xgusft6huntr437wmaoo5rob@hhbtzrwgxel2>
 <20250120121928.GA7432@redhat.com>
 <20250120124209.GB7432@redhat.com>
 <CAGudoHFOsRWT0nKRKqFwgHdAhs0NOEO4y-q7Gg4cjm9KBxQc9A@mail.gmail.com>
 <20250120203118.GF7432@redhat.com>
 <CAGudoHHb5qsiTDQ8XO8mjVH6NOQ1T0V5Y-+Ug80mkpLTdiAsCA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHHb5qsiTDQ8XO8mjVH6NOQ1T0V5Y-+Ug80mkpLTdiAsCA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Sorry for delay,

On 01/20, Mateusz Guzik wrote:
>
> On Mon, Jan 20, 2025 at 9:31 PM Oleg Nesterov <oleg@redhat.com> wrote:
> > I'm afraid my emails can look as if I am trying to deny the problem.
> > No. Just I think we need to understand why exactly this patch makes
> > a difference.
> >
>
> I agree.
>
> I was going to state there is 0 urgency as long as the patch does not
> make the merge window, but it just did.

Yes...

> So one would preferably survey a bunch of real workloads, see what
> happens with real pipes with both policies -- the early wake up is
> basically a tradeoff and it very well may be it is worth it in the
> real world.

The problem is that this early wakeup is not intended, the code is
not supposed to do this. So in some sense this patch fixes the
intended/documented "avoid unnecessary wakeups" logic.

Now I can reproduce the hackbench's slowdown on my laptop, but still
don't understand it... I'll try to think more on Weekend, then I'll
discuss the possible revert with Linus who wrote that code and
reviewed this patch.

Thanks for your investigations,

Oleg.


