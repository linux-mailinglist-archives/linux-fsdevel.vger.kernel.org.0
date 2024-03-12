Return-Path: <linux-fsdevel+bounces-14212-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 816F587961C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 15:28:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BCCF28667E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 14:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A497B3C7;
	Tue, 12 Mar 2024 14:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m+gGDEle"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578C27AE52;
	Tue, 12 Mar 2024 14:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710253673; cv=none; b=fpWV2gE9eIHvwV8tKOsPP5hLTjQ9FPAqDsmCxTlVIVOxrjJZN9j58XAB25xstKZmyBjSQXQygMIj4phv1TYh3VkFpd1h/EVMkaIT8ffsw71+EWR5tW9v9vUHq3qiTlucY6MGcKbmBKCpOe2U8RXTxkoMuRYFBrVLxSwB5ha0Y8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710253673; c=relaxed/simple;
	bh=ia5sGLObaZjfWV9maN66DnbW2L3HM1N4ncpzuzL3vQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MbMfnSHmmzPlo4dIAzEtR4s9gj3axKealJSPMTna3tK1hgfwGmJNA73BosU/elmBXP/hhmRGrpPhN1Kcde6oco9P7u+pnm6p62wjl1AAT1n688I3lc7leJjsEZ9go9sw2hwt0Yn2mqLszS3LYyNKQJ7nIw9XEyK0oEebOgJy4k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m+gGDEle; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AA00C433F1;
	Tue, 12 Mar 2024 14:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710253672;
	bh=ia5sGLObaZjfWV9maN66DnbW2L3HM1N4ncpzuzL3vQ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m+gGDEleISZSlqhvG0P+VDshS56A9d3MBQe+lHYVMfYhM1/AWyUb7V8DYllltCLKR
	 p1ltK7SAWsqIlYcukpwnevNYd5LuEvaB82GYaVDQaCktCNwHapvJQ3EASWLY5uNENv
	 Y6RCnImJsEY8ESPqb5Nn5sjmHskarVSHpUrKoly/rlKlztG3fo/FH+qu76pzxhb2L7
	 2KV6XEDYohXWumLodqDX4QuwKFgFn8FofomKuNjHlnijWndQ0L6HiXx3ijfny/qZXZ
	 ecB3eAE/fnB19xEV9cKAljbQAe0SSn9xJSDu7YIZZbP+HYC1e51Xv8ShI9IUtNR/eh
	 g3Pw0+k4zQ7Ww==
Date: Tue, 12 Mar 2024 15:27:48 +0100
From: Christian Brauner <brauner@kernel.org>
To: David Sterba <dsterba@suse.cz>
Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, 
	Kent Overstreet <kent.overstreet@linux.dev>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"linux-bcachefs@vger.kernel.org" <linux-bcachefs@vger.kernel.org>, "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
	Miklos Szeredi <mszeredi@redhat.com>, David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v2] statx: stx_subvol
Message-ID: <20240312-ruhephase-belegen-d4ab0b192203@brauner>
References: <20240308022914.196982-1-kent.overstreet@linux.dev>
 <2f598709-fccb-4364-bf15-f9c171b440aa@wdc.com>
 <20240311-zugeparkt-mulden-48b143bf51e0@brauner>
 <20240311224259.GV2604@twin.jikos.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240311224259.GV2604@twin.jikos.cz>

On Mon, Mar 11, 2024 at 11:43:00PM +0100, David Sterba wrote:
> On Mon, Mar 11, 2024 at 02:43:11PM +0100, Christian Brauner wrote:
> > On Mon, Mar 11, 2024 at 08:12:33AM +0000, Johannes Thumshirn wrote:
> > > On 08.03.24 03:29, Kent Overstreet wrote:
> > > > Add a new statx field for (sub)volume identifiers, as implemented by
> > > > btrfs and bcachefs.
> > > > 
> > > > This includes bcachefs support; we'll definitely want btrfs support as
> > > > well.
> > > 
> > > For btrfs you can add the following:
> > > 
> > > 
> > >  From 82343b7cb2a947bca43234c443b9c22339367f68 Mon Sep 17 00:00:00 2001
> > > From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> > > Date: Mon, 11 Mar 2024 09:09:36 +0100
> > > Subject: [PATCH] btrfs: provide subvolume id for statx
> > > 
> > > Add the inode's subvolume id to the newly proposed statx subvol field.
> > > 
> > > Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> > > ---
> > 
> > Thanks, will fold, once I hear from Josef.
> 
> We're OK with it.

Thanks!

