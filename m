Return-Path: <linux-fsdevel+bounces-34418-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEA549C5235
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 10:38:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73C35284AAF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 09:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C7420E026;
	Tue, 12 Nov 2024 09:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GQ6u29rT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30821ABEC2
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Nov 2024 09:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731404287; cv=none; b=D9KyH+G0gJhyvKwEilEY77OguhtB5H0S7GoUlUyLcV2540ATFpTWBkrM2uCVgqgfUP0BZw5EzLJug6UnmcB+vK0uRNGXdxyo3DuuCuzCUM9vyZW6h8/ui8qmg5I9Uuw5Gg9CSD+HIo0Q/iE/INmoty6y0GZNQgEiGUumnlalLc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731404287; c=relaxed/simple;
	bh=+5upNTY8J6UwW0SlP9rqSuzO7iQV1YePnY4n3hJAZ0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qKESVG8G0ntn9/eO2ta0Et90y5ZhtfSZkTLcKEnYEkywnX3IbPWiODfjHK6MDENNp5E34iDqMQyY4C0QLdOXgcMZ14blabhYkWtXA0OXBr4eiQHhmlF2yWe8/fOz+QBuLhkRVwKaUmCBFsyiZBmySLk3QJfnGuU7XSt3GC+A0rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GQ6u29rT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731404284;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1tBjsYHe0nEly7RM3tKlcK4/OR873TNl1UEnRxbQISY=;
	b=GQ6u29rTyB67L1gEI27/ltb5MnzaGrnNxiBepqjH58Qy0t9hyQXhPnC+YK6uB8YMfXbiE9
	A5V7jVsWOKtPTUkFaaO4gy2xfgwDMZ+esGImwxgBHQ5T6kxakykLwrajqBynq/Z8gs9Td2
	oWbigzoSvovcTE7+OU9EIbnqx7Mk/W8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-491-ttpOhooONKmHwN87EvqZtA-1; Tue,
 12 Nov 2024 04:38:01 -0500
X-MC-Unique: ttpOhooONKmHwN87EvqZtA-1
X-Mimecast-MFC-AGG-ID: ttpOhooONKmHwN87EvqZtA
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 25006195609E;
	Tue, 12 Nov 2024 09:37:59 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.223])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CCB501956054;
	Tue, 12 Nov 2024 09:37:55 +0000 (UTC)
Date: Tue, 12 Nov 2024 10:37:52 +0100
From: Karel Zak <kzak@redhat.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, 
	Miklos Szeredi <miklos@szeredi.hu>, Ian Kent <raven@themaw.net>, Josef Bacik <josef@toxicpanda.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v3 0/2] fs: allow statmount to fetch the subtype and
 devname
Message-ID: <y3ijopq5e3zfdsyylmi7bf44otv2algem4mxprnres3x3mwnvl@2zcgj6y5j7rk>
References: <20241107-statmount-v3-0-da5b9744c121@kernel.org>
 <20241111-ruhezeit-renovieren-d78a10af973f@brauner>
 <5418c22b64ac0d8d469d8f9725f1b7685e8daa1b.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5418c22b64ac0d8d469d8f9725f1b7685e8daa1b.camel@kernel.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On Mon, Nov 11, 2024 at 08:42:26AM GMT, Jeff Layton wrote:
> On Mon, 2024-11-11 at 10:17 +0100, Christian Brauner wrote:
> > On Thu, 07 Nov 2024 16:00:05 -0500, Jeff Layton wrote:
> > > Meta has some internal logging that scrapes /proc/self/mountinfo today.
> > > I'd like to convert it to use listmount()/statmount(), so we can do a
> > > better job of monitoring with containers. We're missing some fields
> > > though. This patchset adds them.
> > > 
> > > 
> > 
> > I know Karel has been wanting this for libmount as well. Thanks for
> > doing this! It would be nice if you could also add some selftests!
> > 
> 
> (cc'ing Karel)
> 
> Thanks. We may need to tweak this a bit, based on Miklos' comments
> about how empty strings are handled now, but it shouldn't be too big a
> change.
> 
> I actually have a related question about libmount: glibc doesn't
> currently provide syscall wrappers for statmount() and listmount().
> Would it make sense to have libmount provide those? We could copy the
> wrappers in tools/testing/selftests/filesystems/statmount/statmount.h
> to libmount.h.

I'm not sure if libmount is the right place. The library is complex
and large, and installing it just to get some simple wrappers seems
like overkill.

I believe the issue of "syscall wrappers" should be addressed in a
more generic manner, as the situation of wanting to try or use new
kernel features is quite common. This approach would also simplify
kernel testing.

> Another idea might be to start a new userland header file that is just
> a collection of static inline wrappers for syscalls that aren't
> packaged in glibc.e.g.  pidfd_open also doesn't have glibc bindings, so
> we could add that there too.

Yes, this seems like proper and portable solution. It would be great
if kernel itself will introduce any convention for this.

It's more syscalls without wrappers, sched_setattr, cachestat, kcmp, 
all pidfd_*, etc.

I'm not sure whether to create one collection of all syscalls or add
the wrappers to the appropriate locations (e.g. uapi/linux/mount.h
or introduce uapi/linux/mount_calls.h). The syscalls have dependencies
on specific structs such as 'struct statmount', etc.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


