Return-Path: <linux-fsdevel+bounces-39575-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD856A15B3F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jan 2025 04:37:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52EA5188AE19
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jan 2025 03:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48BFA5789D;
	Sat, 18 Jan 2025 03:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="JgJAPfHi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3014F2F50;
	Sat, 18 Jan 2025 03:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737171449; cv=none; b=iXnhON8Y7LdmE1gySGWBiH3+97jWnF/qPXkjMlpK4Vo7C6bw9j/fuHMv9xso8Ax6GY8Cyq9ORnVmSbzfjCTel7yMkW1jwV+4RPAEHr5mxbvlS9sz8hTeQvav7KrIyqkSLneKz3wEWpcX9AbN0A8NeWa10L/C933GubNyGOPCLmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737171449; c=relaxed/simple;
	bh=QsmzEHN5VmX8x1BO/Et2sEKzyf1LM5z0luOb9m/Hgnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XBMVq7Q0ekSDnOY1jNeCL4apvQQhtPKkUkjlLlEotXb6VC02ESzkvd8pf6c4vo8pRnWpk5E0c1NZjuEEkdtnxTeXDa8FKIkSX8KcpZgG6I2lUvy0EsSS6mYPxX3WasVJ0PH69KFt8OaFXQRcPhYwWt+KysSbTXxeAvWZI7fJ6ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=JgJAPfHi; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=sOnBT1FZVH1E3dZbLAV8Ykudv006fb56LW7qJ+ZnBq4=; b=JgJAPfHiQgn67/6q+E35BJM2xT
	iWVzX9n2mROpuIhO/070UJVJhaxJCDf/YCFfe75lhTRin1BnIgjZc8NS0sVXjSrGeia+EAbruSFIg
	Xk7gjxhhFljeVfXo2MExvasXzLdaxRJLKeFWpLgFpjQpkl1paACkwCmrHdYr2r+3CCa3tMTGTRvCH
	ox4yAglqCcOJzawzMOiOMUQ4eVasBCjXq0jwmTJTztjXEU4x7p9w8NMtaVC7TG80r1j5N17asc/w5
	gtEu+TDqtCs1wZJT3hBabrRKkT+g7HUEkIpjUD9V/nf70KU89JoDTIyFDiJFY9taDVgIDRqjDladv
	dWbnGo0A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tYzeF-00000003nHx-2cw8;
	Sat, 18 Jan 2025 03:37:23 +0000
Date: Sat, 18 Jan 2025 03:37:23 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: Dave Chinner <david@fromorbit.com>, Theodore Ts'o <tytso@mit.edu>,
	lsf-pc@lists.linux-foundation.org,
	Linux Filesystem Development List <linux-fsdevel@vger.kernel.org>,
	bpf@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] time to reconsider tracepoints in the vfs?
Message-ID: <20250118033723.GV1977892@ZenIV>
References: <20250116124949.GA2446417@mit.edu>
 <Z4l3rb11fJqNravu@dread.disaster.area>
 <oidb2ijfx64r4lgpf3ei7teexpa54ngnef3cmq5bsxsgxmtros@7pn2y34ud4l7>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <oidb2ijfx64r4lgpf3ei7teexpa54ngnef3cmq5bsxsgxmtros@7pn2y34ud4l7>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Jan 17, 2025 at 08:07:48PM -0700, Daniel Xu wrote:

> In addition to the points Andrii makes below, tracepoints also have a
> nice documenting property. They tend to get added to "places of
> interest". They're a great starting point for non kernel developers to
> dig into kernel internals. Often times tracepoint naming (as well as the
> exported fields) provide helpful hints.
> 
> At least for me, if I'm mucking around new places (mostly net/) I'll
> tend to go look at the tracepoints to find the interesting codepaths.

Here's one for you:
        trace_ocfs2_file_splice_read(inode, in, in->f_path.dentry,
                                     (unsigned long long)OCFS2_I(inode)->ip_blkno,
                                     in->f_path.dentry->d_name.len,
                                     in->f_path.dentry->d_name.name,
                                     flags);
The trouble is, what happens if your ->splice_read() races
with rename()?  Yes, it is allowed to happen in parallel with
splice(2).  Or with read(2), for that matter.  Or close(2) (and
dup2(2) or exit(2) of something that happens to have the file
opened).

What happens is that
	* you get len and name that might not match each other - you might
see len being 200 and name pointing to 40-byte array inside dentry.
	* you get name that is not guaranteed to be *there* - you might
pick one before rename and have it freed and reused by the time you
try to access it.
	* you get name that points to a string that might be modified
by another CPU right under you (for short names).

Doing that inside ->mkdir() - sure, no problem, the name _is_ stable
there.  Doing that inside ->lookup() - fine on the entry, may be not
safe on the way out.

In filesystems it's living dangerously, but as long as you know what
you are doing you can get away with that (ocfs2 folks hadn't, but
it's not just ocfs2 - similar tracepoints exist for nfs, etc.)...

