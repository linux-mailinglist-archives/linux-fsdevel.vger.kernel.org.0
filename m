Return-Path: <linux-fsdevel+bounces-24795-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CDAD944D89
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 15:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31E5EB22333
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 13:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0851A3BDD;
	Thu,  1 Aug 2024 13:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K0mcy206"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C570A1A38E7
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 Aug 2024 13:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722520753; cv=none; b=KOzxuHtwEakzVtJvJrp1ITM6UhtBFnYroB75l7lPkc7ApeeVhLdZl4zEx/dudhkatUajg00AFEud0KDdfi/tT3B0+YxG/1yxHzr/LpEJZeTYV5kuoVU1xvRnt+fZ1WEbyswx6YdagIttleJ6KLAj+MW72EMx67c+cId4TA0LxG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722520753; c=relaxed/simple;
	bh=MpNMcGFJ5X/GwjRYuU61MJgNlI8OH/7MgAUOA9PeOLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ioImZmlnN86xOzNc19iz1Bi9ZsfEsVAT1WxsH35i/9J0bV6xvh40mwzb7eE+SFeWKpp8T4zujg64b+JuNPs+UGBUnQG1Dsk3HUpdunAbhu9Bt4GSKack14Z2LTywHLku/nDAVIG/1HVKDyQum8fNLR7uNYrH8+R0jAvDHWKEJeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K0mcy206; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722520750;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MpNMcGFJ5X/GwjRYuU61MJgNlI8OH/7MgAUOA9PeOLc=;
	b=K0mcy206WoOXvEqEOMdMds1ziG8Om3kNHyChAkXpl8PQnWX7ntrA7XDIx22pL7StZpcGS8
	9QFP7Cv0yDOnxL1NS0jqPHrAilyIEoxjuz9Smm4wdgzlBN7i5+9jLWm0q7o67++s+kdnwH
	hV+eCuCjUWateZUKgg42R7XJbfmSg60=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-674-JMTiKpvCMY2YDExVGLVEwQ-1; Thu,
 01 Aug 2024 09:59:07 -0400
X-MC-Unique: JMTiKpvCMY2YDExVGLVEwQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B20571955D52;
	Thu,  1 Aug 2024 13:59:05 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.183])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 7B53B1955D42;
	Thu,  1 Aug 2024 13:59:02 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu,  1 Aug 2024 15:59:05 +0200 (CEST)
Date: Thu, 1 Aug 2024 15:59:01 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Aleksa Sarai <cyphar@cyphar.com>,
	Tycho Andersen <tandersen@netflix.com>,
	Daan De Meyer <daan.j.demeyer@gmail.com>, Tejun Heo <tj@kernel.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH] pidfd: prevent creation of pidfds for kthreads
Message-ID: <20240801135900.GD4038@redhat.com>
References: <20240731-gleis-mehreinnahmen-6bbadd128383@brauner>
 <20240731145132.GC16718@redhat.com>
 <20240801-report-strukturiert-48470c1ac4e8@brauner>
 <20240801080120.GA4038@redhat.com>
 <20240801-clever-mitleid-da9b4142edde@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801-clever-mitleid-da9b4142edde@brauner>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 08/01, Christian Brauner wrote:
>
> On Thu, Aug 01, 2024 at 10:01:20AM GMT, Oleg Nesterov wrote:
> > OK, I won't argue, but ....
> >
> > > you may or may not get notified
> > > via poll when a kthread exits.
> >
> > Why? the exiting kthread should not differ in this respect?
>
> Why do you want to allow it?

Again, I didn't try to "nack" your patch. Just tried to understand
your motivation.

And "may not get notified" above doesn't look right to me...

> > /proc/$pid/status has a "Kthread" field...
>
> Going forward, I don't want to force people to parse basic stuff out of
> procfs. Ideally, they'll be able to mostly rely on pidfd operations
> only.

Agreed.

Oleg.


