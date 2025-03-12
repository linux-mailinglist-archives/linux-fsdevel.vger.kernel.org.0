Return-Path: <linux-fsdevel+bounces-43796-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1566A5DC03
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 12:52:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C50FB178463
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 11:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4477241129;
	Wed, 12 Mar 2025 11:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="p3uk4WKr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-42ac.mail.infomaniak.ch (smtp-42ac.mail.infomaniak.ch [84.16.66.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1C3241668
	for <linux-fsdevel@vger.kernel.org>; Wed, 12 Mar 2025 11:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741780270; cv=none; b=AUTbmNkZm8XC1U2n8lv6niBJ8am1CtvGNd8LWEYAcaAwSnGYHmxzOGH2HfXOeRn98D5kPekHDGxPf2BeeHIeyxRAWJYS1jk9sd6XUu6Alxr8xNd/JYT30bXD52+YKF7QAkT3hv5JfTL6Cp4I2C5ss9NiuFh5qj6VeaY3R43Gw2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741780270; c=relaxed/simple;
	bh=yDQQJbDVGbfG50mE+/KoSV7qUSKKHNP6T66SoH2sJmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cBab0OUgaUMiw7Th42me2hPTKn0WOmFL/seYz2n//jlVwqFoGw5wEpXbFZbHh+thf02q0p8gHFL+/H7a4uk34tlISqZbix4Oz7jf/oFlPaPn9XbHe2RwzCubiG//AU8b6seA804t98KoDg5WrfvQ2V7khTXYFcfJ1yYOdcw/J4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=p3uk4WKr; arc=none smtp.client-ip=84.16.66.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4ZCTVC40kQzn7B;
	Wed, 12 Mar 2025 12:50:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1741780259;
	bh=nSU70I7zz7mqCCnubEK+ZXs3M/gm6DfYWK9B7hFunyI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p3uk4WKrCm2Y/cEbVV2EVpgjSoo/BxSN61VgLdE0Be717yAoSCdZf7SgFS+jpTqcE
	 r20c4/SO9Uwz91SDf+XBmGaU/LrgaZ5i/k55EaN3WKRBJzvppX9370XlvGPQS0XHIw
	 kSdOB+nrDtPHVZHHCUSJBklhOdmVq587jHGZYe/o=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4ZCTV94VnPztWb;
	Wed, 12 Mar 2025 12:50:57 +0100 (CET)
Date: Wed, 12 Mar 2025 12:50:57 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Song Liu <song@kernel.org>
Cc: Tingmao Wang <m@maowtm.org>, Christian Brauner <brauner@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Jan Kara <jack@suse.cz>, linux-security-module@vger.kernel.org, 
	Matthew Bobrowski <repnop@google.com>, linux-fsdevel@vger.kernel.org, 
	Tycho Andersen <tycho@tycho.pizza>, Kees Cook <kees@kernel.org>, Jeff Xu <jeffxu@google.com>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, Francis Laniel <flaniel@linux.microsoft.com>, 
	Matthieu Buffet <matthieu@buffet.re>, Paul Moore <paul@paul-moore.com>, 
	Kentaro Takeda <takedakn@nttdata.co.jp>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	John Johansen <john.johansen@canonical.com>
Subject: Re: [RFC PATCH 0/9] Landlock supervise: a mechanism for interactive
 permission requests
Message-ID: <20250312.Xoowie7phiza@digikod.net>
References: <cover.1741047969.git.m@maowtm.org>
 <20250304.Choo7foe2eoj@digikod.net>
 <f6ef02c3-ad22-4dc6-b584-93276509dbeb@maowtm.org>
 <CAOQ4uxjz4tGmW3DH3ecBvXEnacQexgM86giXKqoHFGzwzT33bA@mail.gmail.com>
 <1e009b28-1e6b-4b8c-9934-b768cde63c2b@maowtm.org>
 <20250311.Ti7bi9ahshuu@digikod.net>
 <CAPhsuW4YXGFY___8x7my4tUbgyp5N4FHSQpJpKgEDK6r0vphAA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW4YXGFY___8x7my4tUbgyp5N4FHSQpJpKgEDK6r0vphAA@mail.gmail.com>
X-Infomaniak-Routing: alpha

On Tue, Mar 11, 2025 at 01:58:57PM -0700, Song Liu wrote:
> On Tue, Mar 11, 2025 at 12:28 PM Mickaël Salaün <mic@digikod.net> wrote:
> >
> > On Tue, Mar 11, 2025 at 12:42:05AM +0000, Tingmao Wang wrote:
> > > On 3/6/25 17:07, Amir Goldstein wrote:
> > > [...]

> > > --
> > >
> > > For Mickaël,
> > >
> > > Would you be on board with changing Landlock to use the new hooks as
> > > mentioned above?  My thinking is that it shouldn't make any difference in
> > > terms of security - Landlock permissions for e.g. creating/deleting files
> > > are based on the parent, and in fact except for link and rename, the
> > > hook_path_ functions in Landlock don't even use the dentry argument.  If
> > > you're happy with the general direction of this, I can investigate further
> > > and test it out etc.  This change might also reduce the impact of Landlock
> > > on non-landlocked processes, if we avoid holding exclusive inode lock while
> > > evaluating rules / traversing paths...? (Just a thought, not measured)
> 
> I think the filter for process/thread is usually faster than the filter for
> file/path/subtree? Therefore, it is better for landlock to check the filter for
> process/thread first. Did I miss/misunderstand something?

The main reason is because only sandboxed processes should be impacted
by Landlock.  Similarly, only the security policies restricting a
process impact this process.  Using 16 layers would only impact the
process that sandboxed itself (and BTW the impact of the number of
layers would be negligible).  There is not really process filters, only
pointers set or not in tasks' credentials.

