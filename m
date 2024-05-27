Return-Path: <linux-fsdevel+bounces-20229-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8FB58CFFE0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 14:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B80C1F23035
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 12:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F7A15E5D4;
	Mon, 27 May 2024 12:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h4BqrTUc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948A615EFD5;
	Mon, 27 May 2024 12:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716812346; cv=none; b=ul9qW3D4eVc/jSKlUwAXdhThQf+yJZVgKjANVi7DFxKbmDU89OFwYD9s19AuEdAWrU1JeS4kEpg1rhT+gvENKhE02ZK5DuJC+5wlIdMwsGn/2RRhTemkEDQIDijUsqZ6fJxmPOetWikdZKhxbMI07GRFdqcoLFN+ydsRWkpXg2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716812346; c=relaxed/simple;
	bh=fMUVC1wYfmgk+F283qmAnsiUZxdqaVd6XznWp+CLxmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=durVqEwl6qjRQCiKQ7g6oh6PlrtzWwI7QhlujCmYd7o8JNiZ2WpFwpaQWwhm0+UOJ1pFUEivsMD2dk/eGrJqyHXNlsTk1VwuEg/qyS2kyKK0lsdXbiOnRJ2pP2U0tdL1ktWpSGtz+su+5XBTuI5+00OQCDYyI0ludtRYjdJDvdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h4BqrTUc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F04D5C2BBFC;
	Mon, 27 May 2024 12:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716812346;
	bh=fMUVC1wYfmgk+F283qmAnsiUZxdqaVd6XznWp+CLxmw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h4BqrTUcVVUR/nO1MVwypxsUWquVKtD8crHnsaVQEZsJL6icI8A6k4CjHC/BXClRe
	 89Wb2ziK/WLkqr0LuAyUfz0eHCGsTdxxYx+Eo+GFWNrg9aJBztf7Gan3Z+fZ4lE/vx
	 nDu7U4ldKlpicgAv33PihNGtV2P4NFZkpwcZJvkQ+WAWEYX0R3cikwtoVpYADyFxhx
	 W8ajq8wqp5aS8uQZ8wj+PuS+ZxulDrs4JcYH5G/oHvEhoUnBHK708nmduLo0Ur1cEV
	 EhngvDzkchvKvC75ba0+UEmjtPAVqYtj5kMGa+D1O2fG41qB/CwfLga9NeEbY4N5eB
	 4Uwl8MCnlxdaA==
Date: Mon, 27 May 2024 14:19:01 +0200
From: Christian Brauner <brauner@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Eric Sandeen <sandeen@redhat.com>, linux-renesas-soc@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, David Howells <dhowells@redhat.com>, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] debugfs: ignore auto and noauto options if given
Message-ID: <20240527-pittoresk-kneipen-652000baed56@brauner>
References: <20240522083851.37668-1-wsa+renesas@sang-engineering.com>
 <20240524-glasfaser-gerede-fdff887f8ae2@brauner>
 <20240527100618.np2wqiw5mz7as3vk@ninjato>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240527100618.np2wqiw5mz7as3vk@ninjato>

On Mon, May 27, 2024 at 12:06:18PM +0200, Wolfram Sang wrote:
> Hi Christian,
> 
> > Afaict, the "auto" option has either never existent or it was removed before
> > the new mount api conversion time ago for debugfs.
> 
> Frankly, I have no idea why I put this 'auto' in my fstab ages ago. But
> it seems, I am not the only one[1].
> 
> [1] https://www.ibm.com/docs/en/linux-on-systems?topic=assumptions-debugfs
> 
> > diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
> > index dc51df0b118d..713b6f76e75d 100644
> > --- a/fs/debugfs/inode.c
> > +++ b/fs/debugfs/inode.c
> > @@ -107,8 +107,16 @@ static int debugfs_parse_param(struct fs_context *fc, struct fs_parameter *param
> >         int opt;
> > 
> >         opt = fs_parse(fc, debugfs_param_specs, param, &result);
> > -       if (opt < 0)
> > +       if (opt < 0) {
> > +               /*
> > +                * We might like to report bad mount options here; but
> > +                * traditionally debugfs has ignored all mount options
> > +                */
> > +               if (opt == -ENOPARAM)
> > +                       return 0;
> > +
> >                 return opt;
> > +       }
> > 
> >         switch (opt) {
> >         case Opt_uid:
> > 
> > 
> > Does that fix it for you?
> 
> Yes, it does, thank you.
> 
> Reported-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Thanks, applied. Should be fixed by end of the week.

