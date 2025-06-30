Return-Path: <linux-fsdevel+bounces-53332-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9295FAEDD2D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 14:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CD233BD9F8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 12:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB15228A1EB;
	Mon, 30 Jun 2025 12:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E8fEs2A0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76A128A1C9
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 12:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751287068; cv=none; b=QoFcpdXzHLRjk6PE3QkRmyAHTdpw3+Eei97g94D6w4fcdIvq9mx26SRujHng8Tzdc4mPP0bBxE5zknU6kFI9liUCk9PgsM6Wv1RCNHOfi33+lSNDIeTSW4RmU541MwD36syXrfY3UZKHc3o7AR8l20awjkqV/yL+nmQKhKsHiCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751287068; c=relaxed/simple;
	bh=y7K25BVp8J7PZgB9DNoW9Axq4HVd5q5SbvdBpqqvwns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CXr0wTQkw5wIFAYsuHdfkARxcKfMduYUclT51lKdnEGQFuUQtsvVlogBVWmNloA+2uz/FAtfZlwn5Y+wOCTzpcP2sdxBq7ptnK5d7b3/6uijRqd90tfiIV1+4rAWZXdgFiV03iZ1XQxaDUcGRS3SIzBTWwWK6VMNWh24104sOHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E8fEs2A0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751287065;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Lif262s6lJxXAyUAPG/wOgmzfNhGrKy2Fgpgmtk9rAU=;
	b=E8fEs2A0gmB3XPTlJUYHyrT4v7NzPcbyJl1zw5E4FxmIT5niJdzP1wCgyK+kBKPOpOl/VT
	ZFgUF5R9qWAxdRqzW5TArYbXaAkhSmT2xp5zbQo4QyMT9sqjSNL0hH72y9Om/Sqdx6eQ/H
	lIk+F4gULX9wHuN0eZYb3+Gu1jlNVWU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-558-2IT8sbofOgOldCdVq896fg-1; Mon,
 30 Jun 2025 08:37:41 -0400
X-MC-Unique: 2IT8sbofOgOldCdVq896fg-1
X-Mimecast-MFC-AGG-ID: 2IT8sbofOgOldCdVq896fg_1751287058
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3A8571800287;
	Mon, 30 Jun 2025 12:37:38 +0000 (UTC)
Received: from bfoster (unknown [10.22.64.142])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 668A219560AB;
	Mon, 30 Jun 2025 12:37:35 +0000 (UTC)
Date: Mon, 30 Jun 2025 08:41:13 -0400
From: Brian Foster <bfoster@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Joanne Koong <joannelkoong@gmail.com>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-block@vger.kernel.org, gfs2@lists.linux.dev,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH 01/12] iomap: pass more arguments using the iomap
 writeback context
Message-ID: <aGKF6Tfg4M94U3iA@bfoster>
References: <20250627070328.975394-1-hch@lst.de>
 <20250627070328.975394-2-hch@lst.de>
 <aF601H1HVkw-g_Gk@bfoster>
 <20250630054407.GC28532@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630054407.GC28532@lst.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Mon, Jun 30, 2025 at 07:44:07AM +0200, Christoph Hellwig wrote:
> On Fri, Jun 27, 2025 at 11:12:20AM -0400, Brian Foster wrote:
> > I find it slightly annoying that the struct name now implies 'wbc,'
> > which is obviously used by the writeback_control inside it. It would be
> > nice to eventually rename wpc to something more useful, but that's for
> > another patch:
> 
> True, but wbc is already taken by the writeback_control structure.
> Maybe I should just drop the renaming for now?
> 

Yeah, that's what makes it confusing IMO. writeback_ctx looks like it
would be wbc, but it's actually wpc and wbc is something internal. But I
dunno.. it's not like the original struct name is great either.

I was thinking maybe rename the wpc variable name to something like
wbctx (or maybe wbctx and wbctl? *shrug*). Not to say that is elegant by
any stretch, but just to better differentiate from wbc/wpc and make the
code a little easier to read going forward. I don't really have a strong
opinion wrt this series so I don't want to bikeshed too much. Whatever
you want to go with is fine by me.

Brian


