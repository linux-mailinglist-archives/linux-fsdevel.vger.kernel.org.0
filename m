Return-Path: <linux-fsdevel+bounces-52633-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2494AE4B91
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 19:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E01E63B5293
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 17:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7262524DCE8;
	Mon, 23 Jun 2025 17:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="ebXxcMGP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8963D1B4242
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jun 2025 17:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750698202; cv=none; b=FCDAfxnVHlg+DWta5p/ebG63yJAkc/z/9+4AAb4l0D6vAr7W/+ZjCKbmuGMpqODZfXubxpZ56PCMvdjienN5aPA0f+5uDA6SkWwJPLNVGacvYM3hun8iwgUnuSfaeiKEfDDSZP3AtnuM01/jDKTVzh195G4hWgGiuhBQgqHjGeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750698202; c=relaxed/simple;
	bh=WqKeqe0ui/3PYtidl2Jzo+ET00a4MBiFsQAnjmF5mi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JCJu6spuycTHLj7umV6308CfgZNN1S0a6WSYyhJpD4nCZpuxLkFqORWnEneXo8jVUHIlQFhjnIr9CE+LZFJ9PsOzosJwKEryIGAptqmyJ8jGgl//vJoqNUnzMPjz1HSM7DXpqKhKUwOnOAetiylnbpzGulmb0+GhsGu8UWb9t9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=ebXxcMGP; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4WmuDGLWLtkGSCykoSCJTc19hdMKWQHLzuR/G4sydY8=; b=ebXxcMGPcve1x50gcbhW7tIrF0
	9p2aWC/q2bG9azoqf6XEcbeTbRAbtO73sUyVUwJHMhBP5lUVEcy9yrORJMbtkNBf3IkHYm3zPUulU
	QTF2f4y9/WHFTrM/+DFBmQAsJEFI4yR+/KxNqxP/l2u2/awwla013CQK41W7QIvAkssLvYAhy/ghp
	873jwEysq/mbX/m70OVL9Ub7UAQXh2ol/Nl5WBtmatDKfVacyUk/bPkokRbpZxmIRy5ja9W+fRCCc
	UZO7aLPmskDEDiUQubO3TlR04gnYv7gq5MtCSxCNTOMnNd3ES24nrMsxjJx+eCwS8/dMqoGYz4TGE
	T8Za/Kag==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTkZf-0000000ElCp-04UM;
	Mon, 23 Jun 2025 17:03:15 +0000
Date: Mon, 23 Jun 2025 18:03:14 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org,
	ebiederm@xmission.com, jack@suse.cz
Subject: Re: [PATCH v2 17/35] sanitize handling of long-term internal mounts
Message-ID: <20250623170314.GG1880847@ZenIV>
References: <20250623044912.GA1248894@ZenIV>
 <20250623045428.1271612-1-viro@zeniv.linux.org.uk>
 <20250623045428.1271612-17-viro@zeniv.linux.org.uk>
 <CAHk-=wjiSU2Qp-S4Wmx57YbxCVm6d6mwXDjCV2P-XJRexN2fnw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjiSU2Qp-S4Wmx57YbxCVm6d6mwXDjCV2P-XJRexN2fnw@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Jun 23, 2025 at 09:18:33AM -0700, Linus Torvalds wrote:

> I'm not objecting to the patch, and I don't really even have a
> solution: many of the existing cases actually do need the more
> complicated vfs_parse_fs_string() interface because they don't want
> that simple 'strlen()' for size.

I don't know...  7 callers with explicit strlen():
drivers/gpu/drm/i915/gem/i915_gemfs.c:16:       return vfs_parse_fs_string(fc, key, val, strlen(val));
drivers/gpu/drm/v3d/v3d_gemfs.c:12:     return vfs_parse_fs_string(fc, key, val, strlen(val));
fs/namespace.c:1284:            ret = vfs_parse_fs_string(fc, "source",
fs/namespace.c:3799:            err = vfs_parse_fs_string(fc, "subtype",
fs/namespace.c:3802:            err = vfs_parse_fs_string(fc, "source", name, strlen(name));
fs/nfs/fs_context.c:1230:                       ret = vfs_parse_fs_string(fc, "context",
kernel/trace/trace.c:10280:     ret = vfs_parse_fs_string(fc, "source",

3 callers that could as well use strlen(), except that some of them need
to cope with NULL (using 0 for length in that case):
fs/fs_context.c:230:                    ret = vfs_parse_fs_string(fc, key, value, v_len);
fs/nfs/namespace.c:293:         ret = vfs_parse_fs_string(fc, "source", p, buffer + 4096 - p);
fs/smb/client/fs_context.c:785:         ret = vfs_parse_fs_string(fc, key, value, len);

1 caller that really does need len < strlen(s):
fs/afs/mntpt.c:140:                     ret = vfs_parse_fs_string(fc, "source", content, size - 1);

> I just feel that at a minimum you shouldn't implement add_param()
> twice, because some other users *would* want to do that.
> 
> So I wish you had made that a real helper - which would obviously then
> also force a naming change ("fs_context_add_param()".

May the bikeshedding commence ;-)

> Or maybe even go further and some helper to doi that
> "fs_context_for_mount()" _with_ a list of param's to be added?

Vararg, presumably?

> I do think that could be done later (separately), but wanted to just
> mention this because I reacted to this patch.

