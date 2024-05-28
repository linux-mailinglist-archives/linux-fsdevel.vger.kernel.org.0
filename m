Return-Path: <linux-fsdevel+bounces-20347-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B50718D1A96
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 14:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 515941F23303
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 12:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC74516D32F;
	Tue, 28 May 2024 12:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dG/8WVC0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04EEE13A242;
	Tue, 28 May 2024 12:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716897862; cv=none; b=B+HX6jVlnlajYtIZ5qwJ/a37UOsFYopdgirouU31nZ/FR5UWM6gAyGqKC0h8ERq1ggMXJfgGh2CbripRUxVgjv76U7nh6sb59QodOgfJf1wf2dqKVbh0sjpDum4vKk0MfGaZN7tC/fsR6gPoZP3bZR8vGHPC+iZccqgU8T4YBh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716897862; c=relaxed/simple;
	bh=58egx2ps+6Wd1SWHNZP2itAP+QAyWA4OV5HwePJdVbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rBgtR9SehTIWMbB59T/tJwkanzocgAla0OG8Eysi/qbpARcoCIv9exjuVWhI9lkvZRZ+C8G+meI5337BHZc4apNbYiR1uWmldy6IgpdNU2LqtJuOMe5AZL9Sv+sceVyQmp0B2X+rodqQdncIKMnKegR1A97eL5yPiTjAxCVcJAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dG/8WVC0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88CA4C3277B;
	Tue, 28 May 2024 12:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716897861;
	bh=58egx2ps+6Wd1SWHNZP2itAP+QAyWA4OV5HwePJdVbY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dG/8WVC00ObIsjXJb4Rbw4GYINkQAmvMhB+ACGZyZPnoB3/5W17IxpBbpRhLMH/Zt
	 RYKOYgWMBur6TREpatnG8wplU6AoVFE98XARvDOmb43Qb+6tZdtrfNyu0/P6kIz8au
	 c+rz3CsefuHcMmUDeaf3FmgKn86NOHJ4aKsNGzIceAAFGpJqRkFFI5/rID5S31ortM
	 B8WbdEi6TkVmwyfZwDexHs5Q7hr0Glk7Piwul4Wl6pxq3R4yOeW251LE90IrJTDdNd
	 YHKmSEmphEyaIUZfA302dT0s6MS5hU6ijm7HwddSKztskCa0cS7q9GIVPNL2F62t6w
	 A9PthY+zBZStw==
Date: Tue, 28 May 2024 14:04:16 +0200
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jan Kara <jack@suse.cz>, Aleksa Sarai <cyphar@cyphar.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Chuck Lever <chuck.lever@oracle.com>, 
	Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
	Alexander Aring <alex.aring@gmail.com>, linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH RFC v2] fhandle: expose u64 mount id to
 name_to_handle_at(2)
Message-ID: <20240528-gipfel-dilemma-948a590a36fd@brauner>
References: <20240523-exportfs-u64-mount-id-v2-1-f9f959f17eb1@cyphar.com>
 <ZlMADupKkN0ITgG5@infradead.org>
 <20240526.184753-detached.length.shallow.contents-jWkMukeD7VAC@cyphar.com>
 <ZlRy7EBaV04F2UaI@infradead.org>
 <20240527133430.ifjo2kksoehtuwrn@quack3>
 <ZlSzotIrVPGrC6vt@infradead.org>
 <20240528-wachdienst-weitreichend-42f8121bf764@brauner>
 <ZlWVkJwwJ0-B-Zyl@infradead.org>
 <20240528-gesell-evakuieren-899c08cbfa06@brauner>
 <ZlW4IWMYxtwbeI7I@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZlW4IWMYxtwbeI7I@infradead.org>

On Tue, May 28, 2024 at 03:55:29AM -0700, Christoph Hellwig wrote:
> On Tue, May 28, 2024 at 11:17:58AM +0200, Christian Brauner wrote:
> > As I've said earlier, independent of the new handle type returning the
> > new mount id is useful and needed because it allows the caller to
> > reliably generate a mount fd for use with open_by_handle_at() via
> > statmount(). That won't be solved by a new handle type and is racy with
> > the old mount id. So I intend to accept a version of this patch.
> 
> The whole point is that with the fsid in the handle we do not even need
> a mount fd for open_by_handle_at.

Can you please explain how opening an fd based on a handle returned from
name_to_handle_at() and not using a mount file descriptor for
open_by_handle_at() would work?

