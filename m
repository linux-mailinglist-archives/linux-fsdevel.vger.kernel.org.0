Return-Path: <linux-fsdevel+bounces-14077-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E8558775F0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Mar 2024 10:18:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A675281E86
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Mar 2024 09:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 049581EA8A;
	Sun, 10 Mar 2024 09:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="Yz1JSqQ9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5985B1BC49;
	Sun, 10 Mar 2024 09:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710062301; cv=none; b=LH7TbgeTK+PobWNjNM8G++T+82NlAsC4P8fKK4n2T70FP2MRRe7uhDuSxRjkkQ9SlTLuHjW1djan63GI1eVaz3qH24XghAi6A1npfqQ5u8oQr6QBSQyY5GpiPRnUKuGG8fOIuD1zwjRIJ2rHKJs89bcgYTkeWtq15CRVGTa2w8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710062301; c=relaxed/simple;
	bh=4/Etg5IAaCmbmxqxtDclWTx/CGLXoTnwU28WEm0VocA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OTxbQfHt0OWwJ0v4onY154SHC08neG8jMlfidPfvjapcEOFalhqqVjNkCtRH5tZJu/9EzlyoJGV7E4pXgb7V1T2SVkMDfp2W+ey+JokDGaoaBzZXnYDXrsYJ/8KR452OM5063oyhAi8lmV3uhspmXFBBV1oA6n+7/ktkiMfrKVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=Yz1JSqQ9; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1710062288;
	bh=4/Etg5IAaCmbmxqxtDclWTx/CGLXoTnwU28WEm0VocA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Yz1JSqQ9iMbvoFUbuHmRaYiRtps/bZUuKgWK0FcDrfCyxM4eFWcO5PeMGg4tbMZuf
	 7WIWRQw5Hy1O2U9WjFbFjaVwcq3gJ4LSbMRy5C59qi0SYCwxediET+Xc+HJzZmtQo+
	 pRLB2xl8ZxwSjYjL/Qd65Ff8HRV+o892y2pdAO4c=
Date: Sun, 10 Mar 2024 10:18:07 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Joel Granados <j.granados@samsung.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, 
	Kees Cook <keescook@chromium.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v2] sysctl: treewide: constify ctl_table_root::permissions
Message-ID: <e3198416-4d90-4984-88ee-d2fccf96c783@t-8ch.de>
References: <CGME20240223155229eucas1p24a18fa79cda02a703bcceff3bd38c2ba@eucas1p2.samsung.com>
 <20240223-sysctl-const-permissions-v2-1-0f988d0a6548@weissschuh.net>
 <20240303143408.sxrbd7pykmyhwu5f@joelS2.panther.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240303143408.sxrbd7pykmyhwu5f@joelS2.panther.com>

Hi!

On 2024-03-03 15:34:08+0100, Joel Granados wrote:
> Just to be sure I'm following. This is V2 of "[PATCH] sysctl: treewide:
> constify ctl_table_root::set_ownership". Right? I ask, because the
> subject changes slightly.

No, the v1 of this patch is linked in the patch log below.

The patches for ::set_ownership and ::permissions are changing two
different callbacks and both of them are needed.

The v2 for set_ownership is here:
https://lore.kernel.org/lkml/20240223-sysctl-const-ownership-v2-1-f9ba1795aaf2@weissschuh.net/

Regards

> 
> Best
> 
> On Fri, Feb 23, 2024 at 04:52:16PM +0100, Thomas Weißschuh wrote:
> > The permissions callback is not supposed to modify the ctl_table.
> > Enforce this expectation via the typesystem.
> > 
> > The patch was created with the following coccinelle script:
> > 
> >   @@
> >   identifier func, head, ctl;
> >   @@
> > 
> >   int func(
> >     struct ctl_table_header *head,
> >   - struct ctl_table *ctl)
> >   + const struct ctl_table *ctl)
> >   { ... }
> > 
> > (insert_entry() from fs/proc/proc_sysctl.c is a false-positive)
> > 
> > The three changed locations were validated through manually inspection
> > and compilation.
> > 
> > In addition a search for '.permissions =' was done over the full tree to
> > look for places that were missed by coccinelle.
> > None were found.
> > 
> > This change also is a step to put "struct ctl_table" into .rodata
> > throughout the kernel.
> > 
> > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> > ---
> > To: Luis Chamberlain <mcgrof@kernel.org>
> > To: Kees Cook <keescook@chromium.org>
> > To: Joel Granados <j.granados@samsung.com>
> > To: David S. Miller <davem@davemloft.net>
> > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> > 
> > Changes in v2:
> > - flesh out commit messages
> > - Integrate changes to set_ownership and ctl_table_args into a single
> >   series
> > - Link to v1: https://lore.kernel.org/r/20231226-sysctl-const-permissions-v1-1-5cd3c91f6299@weissschuh.net
> > ---
> > The patch is meant to be merged via the sysctl tree.
> > 
> > There is an upcoming series that will introduce a new implementation of
> > .permission which would need to be adapted [0].
> > The adaption would be trivial as the 'table' parameter also not modified
> > there.
> > 
> > This change was originally part of the sysctl-const series [1].
> > To slim down that series and reduce the message load on other
> > maintainers to a minimumble, submit this patch on its own.
> > 
> > [0] https://lore.kernel.org/lkml/20240222160915.315255-1-aleksandr.mikhalitsyn@canonical.com/
> > [1] https://lore.kernel.org/lkml/20231204-const-sysctl-v2-2-7a5060b11447@weissschuh.net/
> > ---
> >  include/linux/sysctl.h | 2 +-
> >  ipc/ipc_sysctl.c       | 2 +-
> >  kernel/ucount.c        | 2 +-
> >  net/sysctl_net.c       | 2 +-
> >  4 files changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
> > index ee7d33b89e9e..0a55b5aade16 100644
> > --- a/include/linux/sysctl.h
> > +++ b/include/linux/sysctl.h
> > @@ -207,7 +207,7 @@ struct ctl_table_root {
> >  	void (*set_ownership)(struct ctl_table_header *head,
> >  			      struct ctl_table *table,
> >  			      kuid_t *uid, kgid_t *gid);
> > -	int (*permissions)(struct ctl_table_header *head, struct ctl_table *table);
> > +	int (*permissions)(struct ctl_table_header *head, const struct ctl_table *table);
> >  };
> >  
> >  #define register_sysctl(path, table)	\
> > diff --git a/ipc/ipc_sysctl.c b/ipc/ipc_sysctl.c
> > index 8c62e443f78b..b087787f608f 100644
> > --- a/ipc/ipc_sysctl.c
> > +++ b/ipc/ipc_sysctl.c
> > @@ -190,7 +190,7 @@ static int set_is_seen(struct ctl_table_set *set)
> >  	return &current->nsproxy->ipc_ns->ipc_set == set;
> >  }
> >  
> > -static int ipc_permissions(struct ctl_table_header *head, struct ctl_table *table)
> > +static int ipc_permissions(struct ctl_table_header *head, const struct ctl_table *table)
> >  {
> >  	int mode = table->mode;
> >  
> > diff --git a/kernel/ucount.c b/kernel/ucount.c
> > index 4aa6166cb856..90300840256b 100644
> > --- a/kernel/ucount.c
> > +++ b/kernel/ucount.c
> > @@ -38,7 +38,7 @@ static int set_is_seen(struct ctl_table_set *set)
> >  }
> >  
> >  static int set_permissions(struct ctl_table_header *head,
> > -				  struct ctl_table *table)
> > +			   const struct ctl_table *table)
> >  {
> >  	struct user_namespace *user_ns =
> >  		container_of(head->set, struct user_namespace, set);
> > diff --git a/net/sysctl_net.c b/net/sysctl_net.c
> > index 051ed5f6fc93..ba9a49de9600 100644
> > --- a/net/sysctl_net.c
> > +++ b/net/sysctl_net.c
> > @@ -40,7 +40,7 @@ static int is_seen(struct ctl_table_set *set)
> >  
> >  /* Return standard mode bits for table entry. */
> >  static int net_ctl_permissions(struct ctl_table_header *head,
> > -			       struct ctl_table *table)
> > +			       const struct ctl_table *table)
> >  {
> >  	struct net *net = container_of(head->set, struct net, sysctls);
> >  
> > 
> > ---
> > base-commit: ffd2cb6b718e189e7e2d5d0c19c25611f92e061a
> > change-id: 20231226-sysctl-const-permissions-d7cfd02a7637
> > 
> > Best regards,
> > -- 
> > Thomas Weißschuh <linux@weissschuh.net>
> > 
> 
> -- 
> 
> Joel Granados



