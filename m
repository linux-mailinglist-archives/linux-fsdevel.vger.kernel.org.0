Return-Path: <linux-fsdevel+bounces-47267-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3051DA9B1F6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 17:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C55841B82B9E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 15:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D2B2701DA;
	Thu, 24 Apr 2025 15:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CeQ5yqyZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECFA1A2C25;
	Thu, 24 Apr 2025 15:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745507998; cv=none; b=RxauJ/pbmyKvLvZhVNQ2XUlUEoYn4mu8wmKiA+RU2XJ2P3f73cZdjK0909oNbG9D1tjEl/XkJ5QEWRup7IMERgpKcdsnY/N4pKXbwjNVCl0irpbk7zYfoZmrxrQ3hiKZeDLLA7dzCIpEEqtk1hf5/DU0kknQA8XAtHTZOGPKMnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745507998; c=relaxed/simple;
	bh=OaIt+oPFIwrNW1AyH61jeSoLrjM1Bj6CTZp1hIuiA2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s7eBzDHncQl/I7H7rPeZKL6pR/X4UDOL3OkQg+ax0ki31GZhhh5UjCinGmGXeT562lFxyod75KAzJst6xiHSbQf6aN/yd9fbnkQgMBF6FnPvRDqf9QGjs5xjlFw8WgMKbFu1UXAaAv2Pzbr4PVQhyM0Ies6j1S7u1Lkbfkmw9eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CeQ5yqyZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDE74C4CEEB;
	Thu, 24 Apr 2025 15:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745507997;
	bh=OaIt+oPFIwrNW1AyH61jeSoLrjM1Bj6CTZp1hIuiA2k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CeQ5yqyZ5C9YJCmMRayGMjPBy53kBChW2t6uPABn8m/KyMSb8XR897KHBQ7eYC+NX
	 bzpX2MOKPbA5nJ682JCu0W9DDtLmkgDNahwQW4aiNzJevkISOpZY/sCfIc5CPxDl0h
	 pEJpeZn6TUVpNbgXLAJh3Xbkyze9NSBGha732FSx7XoIKI4jyyRlxiWv2suz0x/nu3
	 VtZwwftvy385Ds4RPERIe2xpvhVxUmCPZbIJYZH5Zh9y9b0+em+MHmvZdPlHx2wD/l
	 NHW2J7MNGf06wUiGNMMr9OswRQNV+hFb2/XF3yaHks0kxQRBf3EQgmcT1V3W7VnEnm
	 EUboae0jGYp8Q==
Date: Thu, 24 Apr 2025 17:19:51 +0200
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org, 
	David Rheinsberg <david@readahead.eu>, Jan Kara <jack@suse.cz>, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>, Luca Boccassi <bluca@debian.org>, 
	Lennart Poettering <lennart@poettering.net>, Daan De Meyer <daan.j.demeyer@gmail.com>, 
	Mike Yuan <me@yhndnzj.com>
Subject: Re: [PATCH RFC 1/4] pidfs: register pid in pidfs
Message-ID: <20250424-absatz-ergibt-156db3269145@brauner>
References: <20250424-work-pidfs-net-v1-0-0dc97227d854@kernel.org>
 <20250424-work-pidfs-net-v1-1-0dc97227d854@kernel.org>
 <20250424132437.GA15583@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250424132437.GA15583@redhat.com>

On Thu, Apr 24, 2025 at 03:24:38PM +0200, Oleg Nesterov wrote:
> On 04/24, Christian Brauner wrote:
> >
> > + * pidfs_register_pid - pin a struct pid through pidfs
> > + * @pid: pid to pin
> > + *
> > + * Pin a struct pid through pidfs. Needs to be paired with
> > + * pidfds_put_put() to not risk leaking the pidfs dentry and inode.
>       ^^^^^^^^^^^^^^
> 
> pidfs_put_pid ;)

Dammmit, thanks!

