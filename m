Return-Path: <linux-fsdevel+bounces-63553-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 929F7BC1C46
	for <lists+linux-fsdevel@lfdr.de>; Tue, 07 Oct 2025 16:35:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B8A43ADCE2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Oct 2025 14:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E0151F4C84;
	Tue,  7 Oct 2025 14:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TqhMmO3C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C81A34BA35
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Oct 2025 14:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759847750; cv=none; b=hGG2dcNb9yy+QOmgrCJ6fd6LS1ugq/UJFczJ6NjJ+bs0gPjlBSaTFvVxLqc5bZZBHnPZalP0D36glMHiLrUvlUFMfQwAUoicjLe++jJ6xPx6UCRWKqvZoeIjGud8JC8EaJjYiJIgXEnP9eKUHe24Lj4nKBKw8G3FkKWRfmj4n9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759847750; c=relaxed/simple;
	bh=ddQMm4wD+700e2ki2lu+CmIm7Je2pKn7ZCgyIA/xbKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tiHKKBOotq58wzQTO1IH/NdLftGbQSZ0Ol9Zy6L4yGMVbo0mn4UJnTOqD4p4NRcsTMKfsDz8xEoV2x25H/NIIzaxg2Rd1lC1/G2wAZ9OXVxWoarsvEnQIjavUK+4+fI84s2PIG22KX2OZNosNToNDip8k1q1vgX2JEVOLqjAgwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TqhMmO3C; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759847748;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LTHNDfkzPY8gHjn3H8bW45troKESABjUXMGCPbEvS48=;
	b=TqhMmO3CXU50ImdP+Ry7lXR3bWzIpDvMll2K4qluSPfv0AtzHpGFruEjXnoqn46ANgjIYt
	b7lyDciJRNTRwmY1B2zXfh2aqad4H+/bSOyVdSTo83sdk6TXQngFfYZQ0zeSi40MygWaV5
	AbuKAnc89M5gpbmY1tzSBe3j3nO9o40=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-449-sQDi6061MJaa7kcZzJOSkw-1; Tue,
 07 Oct 2025 10:35:44 -0400
X-MC-Unique: sQDi6061MJaa7kcZzJOSkw-1
X-Mimecast-MFC-AGG-ID: sQDi6061MJaa7kcZzJOSkw_1759847743
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7BC3E1800581;
	Tue,  7 Oct 2025 14:35:43 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.227.6])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 2113F19560A2;
	Tue,  7 Oct 2025 14:35:40 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue,  7 Oct 2025 16:34:22 +0200 (CEST)
Date: Tue, 7 Oct 2025 16:34:19 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: Re: [GIT PULL 05/12 for v6.18] pidfs
Message-ID: <20251007143418.GA12329@redhat.com>
References: <20250926-vfs-618-e880cf3b910f@brauner>
 <20250926-vfs-pidfs-3e8a52b6f08b@brauner>
 <20251001141812.GA31331@redhat.com>
 <20251006-liedgut-leiden-f3d51f4242c2@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251006-liedgut-leiden-f3d51f4242c2@brauner>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 10/06, Christian Brauner wrote:
>
> On Wed, Oct 01, 2025 at 04:18:12PM +0200, Oleg Nesterov wrote:
> > On 09/26, Christian Brauner wrote:
> > >
> > > Oleg Nesterov (3):
> > >       pid: make __task_pid_nr_ns(ns => NULL) safe for zombie callers
> > ...
> > > gaoxiang17 (1):
> > >       pid: Add a judgment for ns null in pid_nr_ns
> >
> > Oh... I already tried to complain twice
> >
> > 	https://lore.kernel.org/all/20250819142557.GA11345@redhat.com/
> > 	https://lore.kernel.org/all/20250901153054.GA5587@redhat.com/
> >
> > One of these patches should be reverted. It doesn't really hurt, but it makes
> > no sense to check ns != NULL twice.
>
> Sorry, those somehow got lost.
> Do you mind sending me a revert?

Thanks, will do.

But which one? I am biased, but I'd prefer to revert 006568ab4c5ca2309ceb36
("pid: Add a judgment for ns null in pid_nr_ns")

Mostly because abdfd4948e45c51b1916 ("pid: make __task_pid_nr_ns(ns => NULL)
safe for zombie callers") tries to explain why this change makes sense and
why it is not easy to avoid ns == NULL.

OK?

Oleg.


