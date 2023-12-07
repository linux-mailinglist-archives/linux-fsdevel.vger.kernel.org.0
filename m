Return-Path: <linux-fsdevel+bounces-5198-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A2C80927D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 21:38:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2019A1C2034E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 20:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8085456382
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 20:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="FxKFJRCu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 196951722;
	Thu,  7 Dec 2023 11:29:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1701977352;
	bh=JuJloSRYXjA2oIDQV1X7RGwKVA9U4q49HgjpAUaVGYM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FxKFJRCuqDnU/Ho0VDQzvmW3byzsLgcZVA9sT6w303p3QuCsW0wReO2n2cE4cz3YZ
	 qXAHXyHHt+UesEQnqTCtRy6MwhAEn/K4sweiWeE0ELtj1dkWZr+EERStt13tx9GZHc
	 4YzFRcPH3sTcZJJGDsJScltp4smN4dAaPR48B8KY=
Date: Thu, 7 Dec 2023 20:29:11 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Joel Granados <j.granados@samsung.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, 
	Kees Cook <keescook@chromium.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Iurii Zaikin <yzaikin@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 13/18] sysctl: move sysctl type to ctl_table_header
Message-ID: <d5fa824e-9f0a-461f-b56f-bcad5b7792ae@t-8ch.de>
References: <20231204-const-sysctl-v2-0-7a5060b11447@weissschuh.net>
 <20231204-const-sysctl-v2-13-7a5060b11447@weissschuh.net>
 <ZW+lQqOSYFfeh8z2@bombadil.infradead.org>
 <4a93cdb4-031c-4f77-8697-ce7fb42afa4a@t-8ch.de>
 <CAB=NE6UCP05MgHF85TK+t2yvbOoaW_8Yu6QEyaYMdJcGayVjFQ@mail.gmail.com>
 <CGME20231206055317eucas1p204b75bda8cb2fc068dea0fc5bcfcf0b2@eucas1p2.samsung.com>
 <0450d705-3739-4b6d-a1f2-b22d54617de1@t-8ch.de>
 <20231207121437.mfu3gegorsyqvihf@localhost>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231207121437.mfu3gegorsyqvihf@localhost>

On 2023-12-07 13:14:37+0100, Joel Granados wrote:
> On Wed, Dec 06, 2023 at 06:53:10AM +0100, Thomas Weißschuh wrote:
> > On 2023-12-05 14:50:01-0800, Luis Chamberlain wrote:
> > > On Tue, Dec 5, 2023 at 2:41 PM Thomas Weißschuh <linux@weissschuh.net> wrote:
> > > >
> > > > On 2023-12-05 14:33:38-0800, Luis Chamberlain wrote:
> > > > > On Mon, Dec 04, 2023 at 08:52:26AM +0100, Thomas Weißschuh wrote:
> > > > > > @@ -231,7 +231,8 @@ static int insert_header(struct ctl_dir *dir, struct ctl_table_header *header)
> > > > > >             return -EROFS;
> > > > > >
> > > > > >     /* Am I creating a permanently empty directory? */
> > > > > > -   if (sysctl_is_perm_empty_ctl_header(header)) {
> > > > > > +   if (header->ctl_table == sysctl_mount_point ||
> > > > > > +       sysctl_is_perm_empty_ctl_header(header)) {
> > > > > >             if (!RB_EMPTY_ROOT(&dir->root))
> > > > > >                     return -EINVAL;
> > > > > >             sysctl_set_perm_empty_ctl_header(dir_h);
> > > > >
> > > > > While you're at it.
> > > >
> > > > This hunk is completely gone in v3/the code that you merged.
> > > 
> > > It is worse in that it is not obvious:
> > > 
> > > +       if (table == sysctl_mount_point)
> > > +               sysctl_set_perm_empty_ctl_header(head);
> > > 
> > > > Which kind of unsafety do you envision here?
> > > 
> > > Making the code obvious during patch review hy this is needed /
> > > special, and if we special case this, why not remove enum, and make it
> > > specific to only that one table. The catch is that it is not
> > > immediately obvious that we actually call
> > > sysctl_set_perm_empty_ctl_header() in other places, and it begs the
> > > question if this can be cleaned up somehow.
> > 
> > Making it specific won't work because the flag needs to be transferred
> > from the leaf table to the table representing the directory.
> > 
> > What do you think of the aproach taken in the attached patch?
> > (On top of current sysctl-next, including my series)

> What would this new patch be fixing again? I could not follow ?

This patch improves upon and replaces the patch you asked to submit on
its own:  "sysctl: move sysctl type to ctl_table_header".

The current code and my original patch have to work around the fact that
the "empty" flag is first registered on a *leaf* ctl_table and from
there has to be transferred to the *directory* ctl_table somehow.
Which is confusing, at least it was for me and evidently also Luis.

The new code just directly sets the flag on the directory ctl_table and
gets rid of some now-dead code.
I should have written a proper changelog...

> Additionally, this might be another reason to set this patch aside :)

I hope we get this one in, it seems cleaner now.
If you agree I can send it as a proper standalone preparation patch.

> > 
> > Note: Current sysctl-next ist still based on v6.6.
> 
> > From 2fb9887fb2a5024c2620f2d694bc6dcc32afde67 Mon Sep 17 00:00:00 2001
> > From: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
> > Date: Wed, 6 Dec 2023 06:17:22 +0100
> > Subject: [PATCH] sysctl: simplify handling of permanently empty directories
> > 
> > ---
> >  fs/proc/proc_sysctl.c  | 76 +++++++++++++++++++-----------------------
> >  include/linux/sysctl.h | 13 ++------
> >  2 files changed, 36 insertions(+), 53 deletions(-)

> [..]

