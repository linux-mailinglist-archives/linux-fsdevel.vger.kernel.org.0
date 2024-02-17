Return-Path: <linux-fsdevel+bounces-11925-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A6F8592DD
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Feb 2024 21:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EAC8B2234F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Feb 2024 20:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7DC7FBC2;
	Sat, 17 Feb 2024 20:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IClDwX8P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999991D6A4
	for <linux-fsdevel@vger.kernel.org>; Sat, 17 Feb 2024 20:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708203407; cv=none; b=Ii/XHmNfEo8vPNJIVKWTYM+aDDUYvvRG/XfFeluq7Rm/7V3ZPh6v5rIgSSPl5VbK61oYY+c4QLML10E5i2pHrxW/Ff6Qyw4Tw6VWjaPl3RT0JxXoIwdiQD7CRQBKDiPqu6CK5asuBySvBqlXy64+DAzoBwR4dUDGvCfdLzgzg9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708203407; c=relaxed/simple;
	bh=sLnpjWXtHn126dH9KY5lksXlS3Xddlz8ALRfxjqvHNU=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=uc0THMdByLH3T+aoig8/At2kfzaxwNIxegg1yyRa6akRioOfvC2KuBFMtH0pXz9m8rJoJQ1mIOB3iicfo7eopbeF8s/ioH8/wGvdkgoJSNm28UuAS9Nq4KeS2cJel1xsYliTncrNYaEJiTFxU+Ov0QvHEcoU8HbVAkFDa7dox9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IClDwX8P; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 17 Feb 2024 15:56:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708203403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=GYlD62MZzIuZyNCsoCfXEkfgZAjvXmKUf8f+PmRt0x0=;
	b=IClDwX8PwFz8TqHo/Dc040UtCcGSrFLKn3Y3H7StwbQPuPCUyXm0RVGdsqj1W6W+jlSh1e
	++XfSHkoKXHoj267dMZVhVJS3MeldXBnR0lT6SvHT4HJj8GkYOVIGUHfQdHOZhlIZmDr0u
	75US7yEmqDJWL9XjUiEzpXT475cpyc8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	lsf-pc@lists.linux-foundation.org
Subject: [LSF TOPIC] beyond uidmapping, & towards a better security model
Message-ID: <tixdzlcmitz2kvyamswcpnydeypunkify5aifsmfihpecvat7d@pmgcepiilpi6>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT

AKA - integer identifiers considered harmful

Any time you've got a namespace that's just integers, if you ever end up
needing to subdivide it you're going to have a bad time.

This comes up all over the place - for another example, consider ioctl
numbering, where keeping them organized and collision free is a major
headache.

For UIDs, we need to be able to subdivide the UID namespace for e.g.
containers and mounting filesystems as an unprivileged user - but since
we just have an integer identifier, this requires complicated remapping
and updating and maintaining a global table.

Subdividing a UID to create new permissions domains should be a cheap,
easy operation, and it's not.

The solution (originally from plan9, of course) is - UIDs shouldn't be
numbers, they should be strings; and additionally, the strings should be
paths.

Then, if 'alice' is a user, 'alice.foo' and 'alice.bar' would be
subusers, created by alice without any privileged operations or mucking
with outside system state, and 'alice' would be superuser w.r.t.
'alice.foo' and 'alice.bar'.

What's this get us?

Much better, easier to use sandboxing - and maybe we can kill off a
_whole_ lot of other stuff, too.

Apparmour and selinux are fundamentally just about sandboxing programs
so they can't own everything owned by the user they're run by.

But if we have an easy way to say "exec this program as a subuser of the
current user..."

Then we can control what that program can access with just our existing
UNIX permission and acls.

This would be a pretty radical change, and there's a number of things to
explore - lots of brainstorming to do.

 - How can we do this without breaking absolutely everything? Obviously,
   any syscalls that communicate in terms of UIDs and GIDs are a
   problem; can we come up with a compat layer so that most stuff more
   or less still works?

 - How can we do this a way that's the most orthogonal, that gets us the
   most bang for our buck? How can we kill off as much security model
   stupidity as possible? How can we make sandboxing _dead easy_ for new
   applications?

Cheers,
Kent

