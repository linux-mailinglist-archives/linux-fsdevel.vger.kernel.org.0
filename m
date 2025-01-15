Return-Path: <linux-fsdevel+bounces-39278-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B1ACA12137
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 11:54:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E1577A1831
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 10:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0083205AB6;
	Wed, 15 Jan 2025 10:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eofBAg95"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A685C1DB13A;
	Wed, 15 Jan 2025 10:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736938448; cv=none; b=gJlNyv1Yj5d7EqJC6D6kZR7nYICcXskEJv7qFq8g6zax/Kx6KRLbFFx/fe8kxQ6yggevAmbiQlUW5UeqsPPU8kqPpAn6n0ED7HaKYiSaKH+gSZTKg4g/5Zi8/XnEMsQ1VMng7yojvuSRUwF5qVmSLbdQHfDcLgf3S6neOvZ0sV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736938448; c=relaxed/simple;
	bh=MQe4/keXc+46fXGZkdCLi+dEZsbohQlmd7oj+SQ/xfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BabOA1ZVC2wfMGcyUKywNq/iVMuRfTpWwFl60Vxfa9cDJAL/VXunW12HcvPf5PABgFr+mxAEvO1R5TQBz08eDMDUzGBSEZ7vg5qDUVfq5LVu2O/fYmcwf0vV6DwC52nlM34AXTA/u3Rz6UoFU7ouh6OoHbFBcRcluSlcZfP8Mrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eofBAg95; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C01ADC4CEDF;
	Wed, 15 Jan 2025 10:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736938448;
	bh=MQe4/keXc+46fXGZkdCLi+dEZsbohQlmd7oj+SQ/xfs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eofBAg95qJkrc+sJ9Z4xZc0ZUS5riooC4pdpdjKUyT4Gp9JhgRc23oeY6sQr4B3mW
	 vLSPSCaJ1oDWKrb2gqqQzorULCHbB+zpFvMxD4Qs+w4G9ZzTzZcwthfRyLfUDr5xAC
	 4ywoJDiiWuUw1gK2UCpEJLAOE9WOWnS+mwNknjM7qALncDBwOBxMsRqg3qx0SLrbKX
	 7oGO9XJXWzHaTedmFkfG/fciE8D/6EgnCbBNMVum5tZiv7aviRsavml8jh767dv/ei
	 GGFeHvw1d/jJSddorHSEPaHW1mCh9PWSNdK5HOoaJgxE3u06gHlo58zuhB0+SMvqVw
	 wTVSSVpk7DRYA==
Date: Wed, 15 Jan 2025 11:54:02 +0100
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>, =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	Dave Chinner <david@fromorbit.com>, Kent Overstreet <kent.overstreet@linux.dev>, 
	syzbot+34b68f850391452207df@syzkaller.appspotmail.com, syzbot+360866a59e3c80510a62@syzkaller.appspotmail.com, 
	Ubisectech Sirius <bugreport@ubisectech.com>, Brian Foster <bfoster@redhat.com>, 
	linux-bcachefs@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v1 1/2] landlock: Handle weird files
Message-ID: <20250115-andocken-frequentieren-1ad1ec5bb42b@brauner>
References: <20250110153918.241810-1-mic@digikod.net>
 <20250110.3421eeaaf069@gnoack.org>
 <20250111.PhoHophoh1zi@digikod.net>
 <Z4dgnkCOc_LxMqq2@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z4dgnkCOc_LxMqq2@infradead.org>

On Tue, Jan 14, 2025 at 11:15:42PM -0800, Christoph Hellwig wrote:
> On Sat, Jan 11, 2025 at 04:38:56PM +0100, Mickaël Salaün wrote:
> > I guess it depends on the filesystem implementation.  For instance, XFS
> > returns an error if a weird file is detected [1], whereas bcachefs
> > ignores it (which is considered a bug, but not fixed yet) [2].
> 
> If a filesyste, returns an invalid mode that's a file system bug and
> needs to be fixed there.  Warning in a consumer is perfectly fine.
> But the right action in that case is indeed not to grant the access.

Fyi, anonymous inodes traditionally set the mode to 0 which is
really annoying:

lrwx------ 1 root root  64 15. Jan 11:52 94 -> anon_inode:bpf-prog

> sudo stat -L /proc/1/fd/94
  File: /proc/1/fd/94
  Size: 0               Blocks: 0          IO Block: 4096   weird file
Device: 0,15    Inode: 4120        Links: 1
Access: (0600/?rw-------)  Uid: (    0/    root)   Gid: (    0/    root)
Access: 2024-11-05 17:15:54.404000000 +0100
Modify: 2024-11-05 17:15:54.404000000 +0100
Change: 2024-11-05 17:15:54.404000000 +0100
 Birth: -


