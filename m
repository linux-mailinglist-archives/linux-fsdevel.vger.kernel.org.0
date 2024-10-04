Return-Path: <linux-fsdevel+bounces-31019-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA22990FC7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 22:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 455A21F23062
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 20:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA4F1DE4FD;
	Fri,  4 Oct 2024 19:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aveOjx9+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E931DE3C0
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Oct 2024 19:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728070224; cv=none; b=cKYvUc4KvVkJIAWDZnTV6ZY2snQwRCZnfK3+75PYsielmlEWQ4uO7A1Iy4PtOjuwS8Ezu/0ZnmYlqdzJ89ZobjXcWuKyxnvqzWXIjDY0vvW/FbvmG+RChofEqGWfpvgXMCDN/aJAfUcFE25RGqayYuvM5q/JWC5Lx7PTESHccJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728070224; c=relaxed/simple;
	bh=B3vUUCJGsKA7mZnavt4trN1cRu21gZHx5EKJyIUKwvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f4flCIyGrieKk4BqhfTqj6aihI8XWcrqEW6H+jtKrKR8zMqOWAyx/2rSj8QUqZB+CnGW8MnWSfDRdm2NFSzgInhxZ7DI5Wqw/HPHXCWhfoez3XyTdYq0VPmNZdrwHZVRorK1ixynfti8lW99sIdpv+os+GA0Jmlc0TDhiniOm1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aveOjx9+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728070222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eBJUsA54LDTHRivkwXp0/G9Nmh/C5aglOwfA6E1tGOY=;
	b=aveOjx9+NakYV6x54AvUQoSS704Dko6Am9OJ2W7aFaGtkmnw7zntUwj8txCO1fdldOuTD8
	iQ17qDgQsq/UfVBBqOU6OnL3AcV2CmMuhs2r657hP0MVtlM7nSD0BbUyoyLb4ARiMocRKc
	xF0JEjkszQHKaxDMBpvP8jkYil5OtHM=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-590-xqOW-Z1VMEinNVQb3FmpKg-1; Fri,
 04 Oct 2024 15:30:19 -0400
X-MC-Unique: xqOW-Z1VMEinNVQb3FmpKg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 37DCE19560BF;
	Fri,  4 Oct 2024 19:30:17 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.210])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 6765919560A3;
	Fri,  4 Oct 2024 19:30:14 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri,  4 Oct 2024 21:30:03 +0200 (CEST)
Date: Fri, 4 Oct 2024 21:29:59 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Luca Boccassi <luca.boccassi@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>, linux-kernel@vger.kernel.org,
	paul@paul-moore.com, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] pidfd: add ioctl to retrieve pid info
Message-ID: <20241004192958.GA28441@redhat.com>
References: <20241002142516.110567-1-luca.boccassi@gmail.com>
 <20241004-signal-erfolg-c76d6fdeee1c@brauner>
 <CAMw=ZnRt3Zvmf9Nt0sDHGPUn06HP3NE3at=x+infO=Ms4gYDGA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMw=ZnRt3Zvmf9Nt0sDHGPUn06HP3NE3at=x+infO=Ms4gYDGA@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

I wasn't CC'ed, so I didn't see the patch, but looking at Christian's
reply ...

On 10/04, Luca Boccassi wrote:
> On Fri, 4 Oct 2024 at 10:29, Christian Brauner <brauner@kernel.org> wrote:
> >
> > On Wed, Oct 02, 2024 at 03:24:33PM GMT, luca.boccassi@gmail.com wrote:
> > > +             info.pid = pid_nr_ns(pid, task_active_pid_ns(task));
> >
> > I think this is wrong what this should return is the pid of the process
> > as seen from the caller's pid namespace.

Agreed,

> Thanks for the review, I applied the rest of the comments in v2 (I
> think at least), but for this one I can't tell, how should I do it?

I guess Christian meant you should simply use

		info.pid = task_pid_vnr(task);

task_pid_vnr(task) returns the task's pid in the caller's namespace.

Oleg.


