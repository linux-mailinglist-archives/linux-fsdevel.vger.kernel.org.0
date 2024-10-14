Return-Path: <linux-fsdevel+bounces-31889-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D149799CB96
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 15:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87D161F22B0B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 13:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343F71A726B;
	Mon, 14 Oct 2024 13:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="IXgFt6lR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-42ae.mail.infomaniak.ch (smtp-42ae.mail.infomaniak.ch [84.16.66.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29BB11AA783
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Oct 2024 13:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728912655; cv=none; b=lc9p1PxGPmN+X0aFqGMs8+P+lsgs9b6uLfWwD1W7fBMgexIQB+lPtzVcz1WxP7OWeOFeVI/DCMAFtKZI8tlIxpzwbbHEaSg+aDsw+T6f/H/sYP+UARigUK5Qsq/YsvsglmLdHYitMaquOhwy4rzbkxAOSR58KyNAZxDIW/3QchM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728912655; c=relaxed/simple;
	bh=2UVqbexnqNci3grd/5BSq40pYQ2u6L0Swq8qIQHkBKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Twj1g5RqvDEhBuQj6pod7SQo/5s6KnBbXnhRsWmWBkz5AXj540VD8cAZd/c05Kz+1Oh2E9oUEWmVW3dJHiZpL7LFFON7iszjMgR14rsf37HawD0YJj7qzxskLX2iOyo9y5Y4DqgreR9M0tANqTDm2zsUMjRb8DcPwQdIv9ale3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=IXgFt6lR; arc=none smtp.client-ip=84.16.66.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4XRymB46ZCzY1y;
	Mon, 14 Oct 2024 15:30:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1728912650;
	bh=Po6hgLNsaKhPpGljJr4fPdd1Y7bt7xIfi6p+nTtQGvw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IXgFt6lRv5nmZd4eqoFCNKUKNkWSpMmiDNljyTkl0XRtSYm3240gTMrFL8EKWrkJb
	 t8uAlIcC/5Nk9NxuH7OJB9dwmiPobZxTL4E/sfEZQeEjG9NiCQclAW/2J/sONOu7lE
	 qA9IT52drx1bUvQt37VPI/OPjq+Z2G0FRxIGGt/0=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4XRym96Pn1zTsM;
	Mon, 14 Oct 2024 15:30:49 +0200 (CEST)
Date: Mon, 14 Oct 2024 15:30:45 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Paul Moore <paul@paul-moore.com>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org, audit@vger.kernel.org, 
	Eric Paris <eparis@redhat.com>
Subject: Re: [RFC PATCH v1 2/7] audit: Fix inode numbers
Message-ID: <20241014.Ahhahz2ux0ga@digikod.net>
References: <20241010152649.849254-1-mic@digikod.net>
 <20241010152649.849254-2-mic@digikod.net>
 <CAHC9VhR8AFZN4tU1oAkaHb+CQDCe2_4T4X0oq7xekxCYkFYv6A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhR8AFZN4tU1oAkaHb+CQDCe2_4T4X0oq7xekxCYkFYv6A@mail.gmail.com>
X-Infomaniak-Routing: alpha

On Fri, Oct 11, 2024 at 05:34:21PM -0400, Paul Moore wrote:
> On Thu, Oct 10, 2024 at 11:26 AM Mickaël Salaün <mic@digikod.net> wrote:
> >
> > Use the new inode_get_ino() helper to log the user space's view of
> > inode's numbers instead of the private kernel values.
> >
> > Cc: Paul Moore <paul@paul-moore.com>
> > Cc: Eric Paris <eparis@redhat.com>
> > Signed-off-by: Mickaël Salaün <mic@digikod.net>
> > ---
> >  security/lsm_audit.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> While answering some off-list questions regarding audit, I realized
> we've got similar issues with audit_name->ino and audit_watch->ino.
> It would be nice if you could also fix that in this patchset.

I can do that with the next version, but I'm wondering how it would fit
with the UAPI's struct audit_rule_data which has only 32-bit
fields/values.  Does 64-bit inode filtering currently work?

