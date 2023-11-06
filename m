Return-Path: <linux-fsdevel+bounces-2059-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 482A27E1DD4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 11:03:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 026B22812B8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 10:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B523171C8;
	Mon,  6 Nov 2023 10:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eU7mwfae"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A726168DB
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 10:03:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEB58C433C7;
	Mon,  6 Nov 2023 10:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699265027;
	bh=zqSDVGb3DqGgjuM4pK3W4GvqbV/ZeF3XB2qeBZfY3i8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eU7mwfae1zlAXKXyWC7uPN+KKdPz5qxyLroCTLvbV+egcXkSHzsxIMefKPchvvOeK
	 ZjMngWoD4qKRAq5fdMa+86yJwK6EPe2johr1eW+3J4XjZ6b+9CyIWfEVK3+os9qB0y
	 Nrf5NSk+/0DjnByO8SQx1Q49xnA67tAUYQV/CLkIE7HzRzOdlMArG2I/bQsVyN3Zmm
	 v/kmGW7Da+QshN1C1YnJI4dUapKDWmQQ+jmwP1GcxMdgwwnU7ZbwGQOtVntFWPU97T
	 KkfvVO1L//CpV3Th+PtEcW9vn5BGxt/CofYW8Qh8RrpXDmpGIUnFMReZkuoNMhkbZf
	 dI+vcGOdJyG4A==
Date: Mon, 6 Nov 2023 11:03:37 +0100
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <quwenruo.btrfs@gmx.com>,
	Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/3] fanotify support for btrfs sub-volumes
Message-ID: <20231106-fragment-geweigert-1d80138523e5@brauner>
References: <20231031-anorak-sammeln-8b1c4264f0db@brauner>
 <ZUE0CWQWdpGHm81L@infradead.org>
 <20231101-nutzwert-hackbeil-bbc2fa2898ae@brauner>
 <590e421a-a209-41b6-ad96-33b3d1789643@gmx.com>
 <20231101-neigen-storch-cde3b0671902@brauner>
 <20231102051349.GA3292886@perftesting>
 <20231102-schafsfell-denkzettel-08da41113e24@brauner>
 <ZUUDmu8fTB0hyCQR@infradead.org>
 <20231103-kursleiter-proklamieren-aae0a02aa1a4@brauner>
 <ZUibZgoQa9eNRsk4@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZUibZgoQa9eNRsk4@infradead.org>

> > I would feel much more comfortable if the two filesystems that expose
> > these objects give us something like STATX_SUBVOLUME that userspace can
> > raise in the request mask of statx().
> 
> Except that this doesn't fix any existing code.

But why do we care?
Current code already does need to know it is on a btrfs subvolume. They
all know that btrfs subvolumes are special. They will need to know that
btrfs subvolumes are special in the future even if they were vfsmounts.
They would likely end up with another kind of confusion because suddenly
vfsmounts have device numbers that aren't associated with the superblock
that vfsmount belongs to.

So nothing is really solved by vfsmounts either. The only thing that we
achieved is that we somehow accommodated that st_dev hack. And that I
consider nakable.

> 
> > If userspace requests STATX_SUBVOLUME in the request mask, the two
> > filesystems raise STATX_SUBVOLUME in the statx result mask and then also
> > return the _real_ device number of the superblock and stop exposing that
> > made up device number.
> 
> What is a "real" device number?

The device number of the superblock of the btrfs filesystem and not some
made-up device number.

I care about not making a btrfs specific problem the vfs's problem by
hoisting that whole problem space a level up by mapping subvolumes to
vfsmounts.

