Return-Path: <linux-fsdevel+bounces-64015-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD43BD5DF3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 21:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72D4218A5583
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 19:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2428A2D5928;
	Mon, 13 Oct 2025 19:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="qusZC5sh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E2C2C21FE;
	Mon, 13 Oct 2025 19:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760382278; cv=none; b=WOkz6t6vQ3L+eNdBmqjed4uW2nPidWh+wS/ZOzwesCo+z4YKejTjJ3lNMsZSa4P31CHtl9DQWpiTwpysU8wfjDnCQxTWisvR+m2lW+Z8QRlIIBJi6PlaveorsBf8CPzI1rdqrd4sEh2E0icBOt43n7xyawxqv2mg2PKdKdlY804=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760382278; c=relaxed/simple;
	bh=FIsgkB5h5ry6n2BuuRKc7KLJmszdPvD2e0mt/o5qinc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=thOGX3GDFm7YbxoKTi//Y6eYPnSAbaMW8kVqngRGN9qxys3DqD6ZFvizE8juBEVqnxMRhqs9kmgPJ28BxlYDzGEYmmN2MCH367m7cXFMLcXbm5HR3rDUU7cf+qGHFyU9T3Z3YGAqOHQ8fkHynPeLaMJx4/OsXUCU6k7XnEK2HnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=qusZC5sh; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 9E2F014C2D3;
	Mon, 13 Oct 2025 21:04:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1760382272;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/I6JIBH6i2s+KyYmg/95gkYCV7Mkagjj3LtjeEdQzAI=;
	b=qusZC5shpCqfOWYUxaMv2wNmODrBfb7vHdOlMuWw4wNq8DAIZ5LyH1F16/pu/8FsIuuXN5
	zt4hHgGQ0bnv/cbcI2YtIIiT0DsoHpM0BmurlY4UvfLb98FITF7D38xnRo0ZbWQD+nwzVl
	BFJizOk7J/nrQcnjk4caJYCVDqiVhiekB3KHSJ5/5zwGXds6Og4ljZFXeYUdrX4rZErEaz
	5rYl6573bWAmEdNXIuiG55JGXp9TOuemmVxx1IZKdnECCXJAbzl41Bq4Nbc7NWmZMUWO+i
	sqZtaG2dhHtNCdQAYN4xcnjc1DajKnWoeMQI+uHtn7WbKlL0FB8BnRL38WRdYw==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id c5a5a286;
	Mon, 13 Oct 2025 19:04:27 +0000 (UTC)
Date: Tue, 14 Oct 2025 04:04:12 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Eric Sandeen <sandeen@sandeen.net>
Cc: Eric Sandeen <sandeen@redhat.com>, v9fs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	ericvh@kernel.org, lucho@ionkov.net, linux_oss@crudebyte.com,
	eadavis@qq.com
Subject: Re: [PATCH V3 4/4] 9p: convert to the new mount API
Message-ID: <aO1NLCI3kIdgWcvh@codewreck.org>
References: <20251010214222.1347785-1-sandeen@redhat.com>
 <20251010214222.1347785-5-sandeen@redhat.com>
 <aOzT2-e8_p92WfP-@codewreck.org>
 <bc86b13e-1252-4bf0-86f9-77da37f5e37a@sandeen.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bc86b13e-1252-4bf0-86f9-77da37f5e37a@sandeen.net>

Eric Sandeen wrote on Mon, Oct 13, 2025 at 01:46:42PM -0500:
> > ... Which turned out to be needed right away, trying with qemu's 9p
> > export "mount -t 9p -o trans=virtio tmp /mnt" apparently calls
> > p9_virtio_create() with fc->source == NULL, instead of the expected
> > "tmp" string
> > (FWIW I tried '-o trans=tcp 127.0.0.1' and I got the same problem in
> > p9_fd_create_tcp(), might be easier to test with diod if that's what you
> > used)
> 
> I swear I tested this, but you are right, and it fails for me too.
> 
> Oh ... I know what this is :(
> 
> Introducing the "ignore unknown mount options" change in V4 caused it to
> also ignore the unknown "source" option and report success; this made the
> vfs think "source" was already handled in vfs_parse_fs_param() and
> therefore it does not call vfs_parse_fs_param_source(). This has bitten
> me before and it's a bit confusing.
> 
> I'm not sure how I missed this in my V4 testing, I'm very sorry.

No harm done :)

And thanks for the explanation, the vfs parsing being done only if the
fs-specific parsing failed was far from obvious for me!

> > Looking at other filesystems (e.g. fs/nfs/fs_context.c but others are
> > the same) it looks like they all define a fsparam_string "source" option
> > explicitly?...
> 
> Not all of them; filesystems that reject unknown options have "source"
> handled for them in the VFS, but for filesystems like debugfs that
> ignore unknown parameters it had to handle it explicitly. (Other
> filesystems may do so for other reasons I suppose).
> 
> See also a20971c18752 which fixed a20971c18752, though the bug had
> slightly less of an impact.

(I assume the former was 3a987b88a425)

> Yep, this looks correct, I think. It essentially "steals" the string from
> the param and sets it in fc->source since the VFS won't do it for us.

Yes, I copied that from nfs and it looks like debugfs does the same.

> I can't help but feel like there's maybe a better treewide fix for this
> to make it all a bit less opaque, but for now this is what other
> filesystems do, and so I think this is the right fix for my series at
> this point.

Not much better given it does the work twice but we could return -EINVAL
in the case Opt_source statement to optimize for code size...
I'm not sure that's quite clearer though, I'll stick to "doing what
everyone else" does for now and we/someone can revisit this later.

> Would you like me to send an updated patch with this change, or will you
> just fix it on your end?

Happy to roll it in directly, I'll reply again when I find time to
finish testing and push to next.
-- 
Dominique Martinet | Asmadeus

