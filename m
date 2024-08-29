Return-Path: <linux-fsdevel+bounces-27810-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A48C9643EE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 14:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36FB028634B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 12:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E44C19309C;
	Thu, 29 Aug 2024 12:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TzbZXlSw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071B816D300;
	Thu, 29 Aug 2024 12:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724933317; cv=none; b=qZDOOCa8PSh4pxjXoRvzRzVZin+wK0F8jOiQptYwcek/MipUd9mGOpYmaSlf0xBRpMXqn7HrCFu25p20Av44D5/9mLztonFRGoNB7BAzX5YzN1txksbsFoDVrbBiQR3n9byguqQKpMMTQ3R2iWGa5iocn1g4bX/sY7ShqBChtYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724933317; c=relaxed/simple;
	bh=2SZ4w3HmQZKF9leGXOpc3uWRQCOEUBftuvZc6PwMW9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Svz3BTH0KJH2ALV/zYkjlkCIzNvhqzAjokaRRk3sUe7SBIO5us5aCH4KDXr8EHCufrW6yAtdrmlTZBvjqOsNpRepnNH0iKmXVdpfw5hnY8K1qmvO4xgKrj93YkvTMGg0TyUPsjJGatLWKlWkNqEtGCh3d/y2RSl12dyszrhn2F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TzbZXlSw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6477EC4CEC1;
	Thu, 29 Aug 2024 12:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724933316;
	bh=2SZ4w3HmQZKF9leGXOpc3uWRQCOEUBftuvZc6PwMW9w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TzbZXlSwNfN70LSKXvrZLAa3jlrXONrIVJZ2ndZo9vB4HepPvEp7WF2p7oqiCm3f0
	 zQFQiJ+VtSqjH73nolgWmqwyykAnGxbiLcu4jCdyLWa240d2l3KRoZgnfEPTvIKozt
	 bI9R3Kv7WluzFekWkla32KttyXbMhLE/BkC6MR/BiRMejAzOObdI9E32EFx7+uXndz
	 ybA3a3MIPAlxQnV5doFIVYjBK7SnOoOc0p7GkMOK2UxrsJQddj9oNM8uAiMzIcgLNh
	 4B10v/CDxM0UlyRmQTmOP6HzB23I2n1kVdrPqRjGd/FujC9J75wOxJZXqiJsgAmt7w
	 YsT89c0a9dnPA==
Date: Thu, 29 Aug 2024 14:08:31 +0200
From: Christian Brauner <brauner@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>, 
	mszeredi@redhat.com, stgraber@stgraber.org, linux-fsdevel@vger.kernel.org, 
	Seth Forshee <sforshee@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
	Bernd Schubert <bschubert@ddn.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/9] fs/fuse: add FUSE_OWNER_UID_GID_EXT extension
Message-ID: <20240829-hurtig-vakuum-5011fdeca0ed@brauner>
References: <20240108120824.122178-1-aleksandr.mikhalitsyn@canonical.com>
 <20240108120824.122178-3-aleksandr.mikhalitsyn@canonical.com>
 <CAJfpegtixg+NRv=hUhvkjxFaLqb_Vhb6DSxmRNxXD-GHAGiHGg@mail.gmail.com>
 <CAEivzxeva5ipjihSrMa4u=uk9sDm9DNg9cLoYg0O6=eU2jLNQQ@mail.gmail.com>
 <CAJfpegsqPz+8iDVZmmSHn09LZ9fMwyYzb+Kib4258y8jSafsYQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJfpegsqPz+8iDVZmmSHn09LZ9fMwyYzb+Kib4258y8jSafsYQ@mail.gmail.com>

On Thu, Aug 29, 2024 at 10:24:42AM GMT, Miklos Szeredi wrote:
> On Thu, 18 Jul 2024 at 21:12, Aleksandr Mikhalitsyn
> <aleksandr.mikhalitsyn@canonical.com> wrote:
> 
> > This was a first Christian's idea when he originally proposed a
> > patchset for cephfs [2]. The problem with this
> > approach is that we don't have an idmapping provided in all
> > inode_operations, we only have it where it is supposed to be.
> > To workaround that, Christian suggested applying a mapping only when
> > we have mnt_idmap, but if not just leave uid/gid as it is.
> > This, of course, leads to inconsistencies between different
> > inode_operations, for example ->lookup (idmapping is not applied) and
> > ->symlink (idmapping is applied).
> > This inconsistency, really, is not a big deal usually, but... what if
> > a server does UID/GID-based permission checks? Then it is a problem,
> > obviously.
> 
> Is it even sensible to do UID/GID-based permission checks in the
> server if idmapping is enabled?

It really makes no sense.

> 
> If not, then we should just somehow disable that configuration (i.e.
> by the server having to opt into idmapping), and then we can just use
> the in_h.[ugi]d for creates, no?

Fwiw, that's what the patchset is doing. It's only supported if the
server sets "default_permissions".

