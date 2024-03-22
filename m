Return-Path: <linux-fsdevel+bounces-15111-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA78F8870EA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 17:31:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 132561C2365A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 16:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C25F5CDF2;
	Fri, 22 Mar 2024 16:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="in9L/Owx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26065D468;
	Fri, 22 Mar 2024 16:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711125105; cv=none; b=JYHU+JSjugnr/rD8Lt6Ud6SvZQIEpQUC7LEs2aT+i05MAWo7efl0O4sHCr7ppjIdL5hJs0sW6e2s4oCuZE21W7Mac+sBoKDpHcWR3SGKj6xtcEFzwXqt4xvOnuxq1IZbT8Sx/MHfT7In6JnNQ9/TNKVDdtV5wv3Kl2mfV7ZPY74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711125105; c=relaxed/simple;
	bh=8LJhxXCQD+wqtKoDkgpPXOqd45cr4Vf2KPCBquLBOjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m51hG468eSifZ5qKyD2lPxylsd+GR+8qimLKm8+6C/D/e+BH2tg0nImlGNv1KsMFwC/FOaedeEt44J/o8R1iqMjyqSEtQFmtP6G9ANqr16Kg4uLXO2JptZ+OmXAoZssawByqqtfcR6VJ7+tYTtPXa6uJkcgLo40SmVfM9lUM7nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=in9L/Owx; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1711125098;
	bh=8LJhxXCQD+wqtKoDkgpPXOqd45cr4Vf2KPCBquLBOjo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=in9L/OwxVLBeWYnkf8nGXvSJmViCoHW5+lzOtfOpf/PwuJqIUlGjqh1QGOQeYRzEf
	 e8RtkjcnB5s8/M5RNO5OAeJkcLiraaToEUIwlJ4kmYdrDaY1e8GY40M3AOHAU9Um4K
	 JbzvoN3HXduDPwuqh3jAVV7/k/IC3UeVMiRF4TQA=
Date: Fri, 22 Mar 2024 17:31:37 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Joel Granados <j.granados@samsung.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, 
	Kees Cook <keescook@chromium.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v3 0/2] sysctl: treewide: prepare ctl_table_root for
 ctl_table constification
Message-ID: <e4de72dc-8dad-4c57-85b3-174272bd1530@t-8ch.de>
References: <CGME20240315181141eucas1p267385cd08f77d720e58b038be06d292e@eucas1p2.samsung.com>
 <20240315-sysctl-const-ownership-v3-0-b86680eae02e@weissschuh.net>
 <20240322124709.w5ntjwb5tbumltoy@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240322124709.w5ntjwb5tbumltoy@joelS2.panther.com>

On 2024-03-22 13:47:09+0100, Joel Granados wrote:
> On Fri, Mar 15, 2024 at 07:11:29PM +0100, Thomas Weißschuh wrote:
> > The two patches were previously submitted on their own.
> > In commit f9436a5d0497
> > ("sysctl: allow to change limits for posix messages queues")
> > a code dependency was introduced between the two callbacks.
> > This code dependency results in a dependency between the two patches, so
> > now they are submitted as a series.
> > 
> > The series is meant to be merged via the sysctl tree.
> > 
> > There is an upcoming series that will introduce a new implementation of
> > .set_ownership and .permissions which would need to be adapted [0].
> > 
> > These changes ere originally part of the sysctl-const series [1].
> > To slim down that series and reduce the message load on other
> > maintainers to a minimum, the patches are split out.
> > 
> > [0] https://lore.kernel.org/lkml/20240222160915.315255-1-aleksandr.mikhalitsyn@canonical.com/
> > [1] https://lore.kernel.org/lkml/20231204-const-sysctl-v2-2-7a5060b11447@weissschuh.net/
> > 
> > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> > ---
> > Changes in v3:
> > - Drop now spurious argument in fs/proc/proc_sysctl.c
> > - Rebase on next-20240315
> > - Incorporate permissions patch.
> > - Link to v2 (ownership): https://lore.kernel.org/r/20240223-sysctl-const-ownership-v2-1-f9ba1795aaf2@weissschuh.net
> > - Link to v1 (permissions): https://lore.kernel.org/r/20231226-sysctl-const-permissions-v1-1-5cd3c91f6299@weissschuh.net
> > 
> > Changes in v2:
> > - Rework commit message
> > - Mention potential conflict with upcoming per-namespace kernel.pid_max
> >   sysctl
> > - Delete unused parameter table
> > - Link to v1: https://lore.kernel.org/r/20231226-sysctl-const-ownership-v1-1-d78fdd744ba1@weissschuh.net
> > 
> > ---
> > Thomas Weißschuh (2):
> >       sysctl: treewide: drop unused argument ctl_table_root::set_ownership(table)
> >       sysctl: treewide: constify argument ctl_table_root::permissions(table)
> > 
> >  fs/proc/proc_sysctl.c  | 2 +-
> >  include/linux/sysctl.h | 3 +--
> >  ipc/ipc_sysctl.c       | 5 ++---
> >  ipc/mq_sysctl.c        | 5 ++---
> >  kernel/ucount.c        | 2 +-
> >  net/sysctl_net.c       | 3 +--
> >  6 files changed, 8 insertions(+), 12 deletions(-)
> > ---
> > base-commit: a1e7655b77e3391b58ac28256789ea45b1685abb
> > change-id: 20231226-sysctl-const-ownership-ff75e67b4eea
> > 
> > Best regards,
> > -- 
> > Thomas Weißschuh <linux@weissschuh.net>
> > 
> 
> Will put this to test and then try to rebase it to 6.9-rc1 once it comes
> out.

Thanks!
Your changes to the commit messages look good.

For my other changes I'm planning to resubmit all of them during the
weekend or next week.


Thomas

