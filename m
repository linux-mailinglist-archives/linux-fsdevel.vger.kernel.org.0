Return-Path: <linux-fsdevel+bounces-22357-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA658916976
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 15:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E56C1F21DFD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 13:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0BC416726E;
	Tue, 25 Jun 2024 13:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iaaRAEgt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95171607B3
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jun 2024 13:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719323542; cv=none; b=DV+zMLLaHIIQtSz4xxh9E7UEWrc/DfxFJVptsiDVddK4lVbndaWQBZvmk8tnbhFzEuAOQ0v/Rz8Z7mjno3utqO0uiXKE0iLJjqmMhOugI3B2UbgGgFcrfY6NoouWci/LYVEvuIlf7XHPhXZZ3MSdCTnW04yrXq1+1rvK4kUUBLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719323542; c=relaxed/simple;
	bh=Wxh6uiXAMO4I3DTDXfJXRI4F8TQaeJleQ/G2AmIRyms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CnauuF3XZa5HSOpY4yxstbpT8XUgfjEi3bQeh4roofl3Vz+wFH1xqv1uKf//wukR0lp/Z4QaVLriyEVy9DAavmjkdpX/an6URCLHwK/BxhsK26syk6Z0LNnX3XsJscn6s2XmpABDbNF03iOTGpDiHAEDETQ571Q5uGAflXaQg48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iaaRAEgt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719323539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/TyBaAkDLc1Y8EqDMhzWflhZ7MKBd9UB9CBjBKtwPYg=;
	b=iaaRAEgts61G00I0tjTUSv7NEgQ5+qxosuoTqe5A/5iyoKD9GnFwsz1XUnqqdzkEMXRoYF
	meruDM3EzT0AzYteA01mgEk+aHk9qu28mv1POaJSgUZy2bqD7uyBVpVLhZ03yygTveyAxD
	En6vQrsBq6z56CDhrDUFAH/U7w4S7vg=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-261-SpSGJ6dVNSuUpb5vv-8QsQ-1; Tue,
 25 Jun 2024 09:52:14 -0400
X-MC-Unique: SpSGJ6dVNSuUpb5vv-8QsQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CD89219560B3;
	Tue, 25 Jun 2024 13:52:08 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.185])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8F8BF1956050;
	Tue, 25 Jun 2024 13:52:06 +0000 (UTC)
Date: Tue, 25 Jun 2024 15:52:03 +0200
From: Karel Zak <kzak@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Josef Bacik <josef@toxicpanda.com>, 
	linux-fsdevel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 0/4] Add the ability to query mount options in statmount
Message-ID: <5j2codcdntgdt4wpvzgbadg4r5obckor37kk4sglora2qv5kwu@wsezhlieuduj>
References: <cover.1719257716.git.josef@toxicpanda.com>
 <20240625-tragbar-sitzgelegenheit-48f310320058@brauner>
 <20240625130008.GA2945924@perftesting>
 <CAJfpeguAarrLmXq+54Tj3Bf3+5uhq4kXOfVytEAOmh8RpUDE6w@mail.gmail.com>
 <20240625-beackern-bahnstation-290299dade30@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625-beackern-bahnstation-290299dade30@brauner>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Tue, Jun 25, 2024 at 03:35:17PM GMT, Christian Brauner wrote:
> On Tue, Jun 25, 2024 at 03:04:40PM GMT, Miklos Szeredi wrote:
> > On Tue, 25 Jun 2024 at 15:00, Josef Bacik <josef@toxicpanda.com> wrote:
> > 
> > > We could go this way I suppose, but again this is a lot of work, and honestly I
> > > just want to log mount options into some database so I can go looking for people
> > > doing weird shit on my giant fleet of machines/containers.  Would the iter thing
> > > make the overlayfs thing better?  Yeah for sure.  Do we care?  I don't think so,
> > > we just want all the options, and we can all strsep/strtok with a comma.
> > 
> > I think we can live with the monolithic option block.  However I'd
> > prefer the separator to be a null character, thus the options could be
> > sent unescaped.  That way the iterator will be a lot simpler to
> > implement.
> 
> For libmount it means writing a new parser and Karel prefers the ","
> format so I would like to keep the current format.
 
Sorry for the misunderstanding. I had a chat with Christian about it
when I was out of my office (and phone chats are not ideal for this).

I thought Miklos had suggested using a space (" ") as the separator, but
after reading the entire email thread, I now understand that Miklos'
suggestion is to use \0 (zero) as the options separator.

I have no issue with using \0, as it will make things much simpler.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


