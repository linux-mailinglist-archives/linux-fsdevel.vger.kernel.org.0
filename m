Return-Path: <linux-fsdevel+bounces-23005-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D0AB925587
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 10:38:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE21DB22A5B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 08:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EC1513B280;
	Wed,  3 Jul 2024 08:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WAJ1PPOo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5DE13A865
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jul 2024 08:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719995914; cv=none; b=fZDBj77FJlhcAdGO9Ds80in6NjQVofxDr/q/qcq9TuNmNm3UKsgdz6K90XBk7kYZlccAOuuYOIAU6NLZCAwtOIxl5WIuQR6EFKL66Qxe1mXX+DRokJHJG7nALzjuuc06waUVPfF8MIYvDycKWeqyFrajwh33tudvfzi8VUVFt7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719995914; c=relaxed/simple;
	bh=ZqsDHmOmgPaPPb/0WimpKOxmUOQbs6fijKgXtKfjR+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NrbqBuxmyjMriLRJGPfSL9pmMchiZpy9at+1p5S/8tYhWiAQiOZfIcL503yneCOMC7dk5wFfYVE3yPlCC6cM5xy4E8J3nUjz5vdvFxRDzRANuQd09OTJmbiOlT/d/nT4eyYPGwEmdsZV//Zzusp5qbDQPm+BFO/JEjoZSFP9Aik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WAJ1PPOo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5602C32781;
	Wed,  3 Jul 2024 08:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719995914;
	bh=ZqsDHmOmgPaPPb/0WimpKOxmUOQbs6fijKgXtKfjR+0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WAJ1PPOoPr6iL7cAFdfcALN5FcZ61uPnIvoWHK9aXo7fWTV2OqVTrr06iJAa3b5gx
	 Ui88YNCTGhrkX1pDXB79dtAw55p7BcvhmmroW/WhbMAMAu9tqytebBQjbcL15GqfRl
	 xv7VX9SABkfb0zCiORf3K/R6WACj1tZrpXXDmuYILZl6UGLnvWhpMCAaSlrrpeZVuD
	 sqGOz7ENmosrvDsVG7eBcSxUQ+fwQrBnqO5lh0yingqP9UFQ0NErfYMBwZQ8MTo+7N
	 hFtvnkmHpZioZSN1zO1wV31JuvqErUKLxaz7uEwVWJNnO3FG737DVghkelXo1zgyLP
	 AmvKFHcVvG5eQ==
Date: Wed, 3 Jul 2024 10:38:30 +0200
From: Christian Brauner <brauner@kernel.org>
To: Eric Sandeen <sandeen@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [PATCH 0/2] fuse: fix up uid/gid mount option handling
Message-ID: <20240703-nachname-visite-3585e80372a7@brauner>
References: <89e18d62-3b2d-45db-94f3-41edc4232955@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <89e18d62-3b2d-45db-94f3-41edc4232955@redhat.com>

On Tue, Jul 02, 2024 at 05:12:18PM GMT, Eric Sandeen wrote:
> This short series fixes up fuse uid/gid mount option handling.
> 
> First, as was done for tmpfs in 
> 0200679fc795 ("tmpfs: verify {g,u}id mount options correctly")
> it validates that the requested uid and/or gid is representable in
> the filesystem's idmapping. I've shamelessly copied commit description
> and code from that commit.
> 
> Second, it is switched to use the uid/gid mount helpers proposed at
> https://lore.kernel.org/linux-fsdevel/8dca3c11-99f4-446d-a291-35c50ed2dc14@redhat.com/T/#t

Reviewed-by: Christian Brauner <brauner@kernel.org>

