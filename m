Return-Path: <linux-fsdevel+bounces-38336-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B539FFC42
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jan 2025 17:47:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20DFB7A165F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jan 2025 16:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC89316F8F5;
	Thu,  2 Jan 2025 16:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YNosWLNx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88E11547F5
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Jan 2025 16:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735836417; cv=none; b=IcSyMPGncrGGJ7T06yFseb3yV3hrVGnhkDn2ejsMiirdQM07Hi4Wy9BwtMjSwBgpLl4/u6PiO7nnFs2j8gugDuyWBCx/89qChPaWROOExV8cD1CyNn+wEIXC7LZphGO22ilIzpODVij+CoYlzvZtg2cXdJv/9oxCVUIz/Q7CxI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735836417; c=relaxed/simple;
	bh=vSBralXKEkbDGTENaS0tXNCGkrQA1+hZRUw6eVJm2d4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q78uyymoCWDxhwxTiKWcD2ieOKNkdyMpa+mXuUzIMtuy6O6KFRSrQ2QodVi6uv/oQ47fJMKP9qPm5RCLyq/13ZXec4k18m2H9VgZACEwtIja1hsyY5k2E8ajRX0qKNMe6EWKwYb80xQUDfGk4PMj4ETTWx+/eoN+3y2MevBdRnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YNosWLNx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1735836412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6a6y6X/kRd9rFXkuO6T9vl6ii9Qix4XnwodVh9lCTMI=;
	b=YNosWLNxUS2TqQ3YeYfcQ8q65QL1P3uULx4k9al7Lb94yrDNXmOk1guzqYYey95X/riAFj
	ptfL/rJKxXpnfZkcQmeBSAdmo8xmICdsdtNl6FxABblpAijezuH7VqBI2xSOhhUqiqce8G
	Ao085atSibaTZDGHGQrX0FHw7uaODu4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-50-U7qs44G4Pl26gMyTGQJPfg-1; Thu,
 02 Jan 2025 11:46:49 -0500
X-MC-Unique: U7qs44G4Pl26gMyTGQJPfg-1
X-Mimecast-MFC-AGG-ID: U7qs44G4Pl26gMyTGQJPfg
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 840DA19560A2;
	Thu,  2 Jan 2025 16:46:47 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.145])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 94D8419560AA;
	Thu,  2 Jan 2025 16:46:43 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu,  2 Jan 2025 17:46:23 +0100 (CET)
Date: Thu, 2 Jan 2025 17:46:18 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: WangYuli <wangyuli@uniontech.com>
Cc: Manfred Spraul <manfred@colorfullife.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, yushengjin@uniontech.com,
	zhangdandan@uniontech.com, chenyichong@uniontech.com
Subject: Re: [PATCH] pipe_read: don't wake up the writer if the pipe is still
 full
Message-ID: <20250102164617.GB30778@redhat.com>
References: <20250102140715.GA7091@redhat.com>
 <74D957F3D234C8BA+47ec121f-4fea-4693-adeb-ae3d46538834@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74D957F3D234C8BA+47ec121f-4fea-4693-adeb-ae3d46538834@uniontech.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 01/03, WangYuli wrote:
>
> [Adding some of my colleagues who were part of the original submission to
> the CC list for their information.]

OK,

> perhaps we should include a link to the original discussion
>
> Link: https://lore.kernel.org/all/75B06EE0B67747ED+20241225094202.597305-1-wangyuli@uniontech.com/
...
> Reported-by: WangYuli <wangyuli@uniontech.com>

WangYuli, this patch has nothing to do with your original patch and
the discussion above.

> I'm happy to provide more test results for this patch if it's not too late.

Would be great, but I don't think this patch can make any difference
performance-wise in practice. Short reads are not that common, I guess.

> Hmm..
> Initially, the sole purpose of our original patch was to simply check if
> there were any waiting processes in the process wait queue to avoid
> unnecessary wake-ups, for both reads and writes.

Exactly. So once again, this patch is orthogonal to the possible
wq_has_sleeper() optimizations.

> Do you have any suggestions on how we could better
> achieve our original objective?

See
	wakeup_pipe_readers/writers() && pipe_poll()
	https://lore.kernel.org/all/20250102163320.GA17691@redhat.com/

Oleg.


