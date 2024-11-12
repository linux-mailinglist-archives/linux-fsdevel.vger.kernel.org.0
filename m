Return-Path: <linux-fsdevel+bounces-34445-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDCB59C58AD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 14:12:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91EBC2812CA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 13:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA35D13F435;
	Tue, 12 Nov 2024 13:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZZlhlzTw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36237136358;
	Tue, 12 Nov 2024 13:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731417127; cv=none; b=shVaVw6wLAOyxofZCrbEJU91J5IJBKGlrD2RaPMA9p13qPu6ZgaTKgsYsoLyvBby0wF2hTUS0cN9T/lxu4bdRL8PVL6aA+EWoFymCPeD9tTDsIwWyaNzTRenIJclVlZbEzNhYYX4uIiJ1dbJzHFsQgk2+c6pNsM9PbeGqfrLN/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731417127; c=relaxed/simple;
	bh=6fuAdoWePiWW119uoihPQFWCRSJej2BXfkodlTvw0jg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X+GdLbXOKzEsCgdNFNpnr5tS1uZxlwLCHVfKAmqoPBFJcreLrZQf1MKtXope20zhKCghswIF518xxMWUvZOUGdWKtvVujyl4+G/T/JT8zkXn7W5GfmBDwn7KACklKQeioVNQzHF9dr7Wq2qWAFe25nbDINB2OJqnQaCK7WGY/QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZZlhlzTw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54C60C4CECD;
	Tue, 12 Nov 2024 13:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731417126;
	bh=6fuAdoWePiWW119uoihPQFWCRSJej2BXfkodlTvw0jg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZZlhlzTwMlsuqSYRUFs9RCfYB2z9J4Nc5KQBj3Sy5huJc4zwLia02RDw+R/9LCWOr
	 JgyqJ1cJ3OOvL+HYWlaMM3MQYTubDRddOE5DWk1BJZr2PSDNINvr6MiBu8+O3weV9X
	 JKEpuE+trs0NnmzK01GgxaAsFuCsI62vLxMDhZTnm+uvoke3dMsUJ51sEeCVUzNomx
	 616lDdIXp4eTbBmm0tOfpCEjE6VcsMvLi3MuyBZ7YTTtpDnsp67LRbtXBR+CxKQzp0
	 Skr2/fTkOjck5fuQkuoHx86P/pwD0gDi8R3RodDW+LzDROY0GaijYH5fy1iVW0hW2f
	 O44EQxcHyep8g==
Date: Tue, 12 Nov 2024 14:12:00 +0100
From: Christian Brauner <brauner@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Jeff Layton <jlayton@kernel.org>, Karel Zak <kzak@redhat.com>, 
	Ian Kent <raven@themaw.net>, Josef Bacik <josef@toxicpanda.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v3 0/2] fs: allow statmount to fetch the subtype and
 devname
Message-ID: <20241112-muskel-furios-7a25e5794b0c@brauner>
References: <20241107-statmount-v3-0-da5b9744c121@kernel.org>
 <20241111-ruhezeit-renovieren-d78a10af973f@brauner>
 <5418c22b64ac0d8d469d8f9725f1b7685e8daa1b.camel@kernel.org>
 <20241112-vielzahl-grasen-51280e378f23@brauner>
 <CAJfpegs5t_ea5yEOAEbeq07i--VeoN6ZnvFyM=Tyxss7gtTZig@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJfpegs5t_ea5yEOAEbeq07i--VeoN6ZnvFyM=Tyxss7gtTZig@mail.gmail.com>

On Tue, Nov 12, 2024 at 11:24:45AM +0100, Miklos Szeredi wrote:
> On Tue, 12 Nov 2024 at 10:42, Christian Brauner <brauner@kernel.org> wrote:
> >
> > On Mon, Nov 11, 2024 at 08:42:26AM -0500, Jeff Layton wrote:
> 
> > > It's error-prone and a pain to roll these yourself, and that would make
> >
> > As with most system calls.
> 
> Also couldn't the kernel tree have a man2 directory, where all the
> syscall man pages could be maintained?   I think it would very much
> make sense to update the man page together with the kernel API change.

I keep saying that over and over as well. IMHO, we should integrate the
system call manpages into the kernel tree. So fully agreed.

