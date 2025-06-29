Return-Path: <linux-fsdevel+bounces-53233-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED338AECF4D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Jun 2025 19:47:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 210B5172C47
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Jun 2025 17:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F1D1DD525;
	Sun, 29 Jun 2025 17:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="GhinoR63"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CDD13790B
	for <linux-fsdevel@vger.kernel.org>; Sun, 29 Jun 2025 17:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751219273; cv=none; b=aesr9IEewZnjQV6g27P7gFuzX3EgKnpuD4WJyhKmNNXB4HgDfQFnZHw74HwmJKmbuHEnPUOWLqliTgz2R99SOeArM+TI4Zp4B19okco+QunpJzTU+Luc3kuRcq4Pd3pW2R1Z2YCv1QgAVlWwzB7R8J4A8C4QRloO+sd5FhAV5IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751219273; c=relaxed/simple;
	bh=slv2rX2jSvnmaz7bigE/Deten1xM6TZD4kOVZGhDwag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bjHXTPMcpYMYlvI0HpiPGA9Hg9MYyVnYJ3VBqJy0VGQvkwjMP8mBmzvmlWjGzkgbanlD3dGJubZyd5KPuTQ6/guFndFFSjM5N68wIOA1khz4JsTsm/R/TwV6Dlj7Q4LjdNgB4Ua/lkQkQOmWMAGgXI0UTbc000gQPrQwhqACA4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=GhinoR63; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=NCg+JgnrdUg/+k3GDnsw4RmX4B1TS+ZKzg+y2WETO+g=; b=GhinoR63yVoZ493+443ZQ3joL8
	yVI3oNEzUX+wCfP17x+Ufk16aIc7IWTC/5cBdNJbSN8oQ3g/Q4IClbjQHBElmnrG/jGMPuY/MjLNR
	PNCNSO6/JFd7AiIQwOq2RA5mhcBFJlUX3lxJUsSfG7WMZzWRi+hzdxNKM6vqCUI9X0RTWNyLI6jIR
	PVGN0PiZcZ8WM21dwIARgkMzYx97jJwZv3tIVNj0AEZDJA8jIY7TWV5rYekEFetZ/cTQrBc8Tz1II
	WRgKajIrpZtHnEyJE47alHjU2QzFCYZnMeigfevTrdgOlFoi+0Fk4Onb1PKs6JCKS8Ik55wuXVZBP
	y473FV/A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uVw82-00000001xV8-4ASl;
	Sun, 29 Jun 2025 17:47:47 +0000
Date: Sun, 29 Jun 2025 18:47:46 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org,
	ebiederm@xmission.com, jack@suse.cz,
	David Howells <dhowells@redhat.com>
Subject: Re: [RFC] vfs_parse_fs_string() calling conventions change (was Re:
 [PATCH v2 17/35] sanitize handling of long-term internal mounts)
Message-ID: <20250629174746.GA439998@ZenIV>
References: <20250623044912.GA1248894@ZenIV>
 <20250623045428.1271612-1-viro@zeniv.linux.org.uk>
 <20250623045428.1271612-17-viro@zeniv.linux.org.uk>
 <CAHk-=wjiSU2Qp-S4Wmx57YbxCVm6d6mwXDjCV2P-XJRexN2fnw@mail.gmail.com>
 <20250623170314.GG1880847@ZenIV>
 <20250628075849.GA1959766@ZenIV>
 <20250628162825.GW1880847@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250628162825.GW1880847@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sat, Jun 28, 2025 at 05:28:25PM +0100, Al Viro wrote:
> On Sat, Jun 28, 2025 at 08:58:49AM +0100, Al Viro wrote:
> > Yes, it's a flagday change.  Compiler will immediately catch any place
> > that needs to be converted, and D/f/porting.rst part should be clear
> > enough.
> > 
> > How about something like the following (completely untested), on top of -rc3?
> > Objections, anyone?
>  
> After fixing a braino (s/QSTR_INIT/QSTR_LEN/) it even builds and seems to work...

While we are at it, there are at least some open-coded instances.  IMO
that part of do_nfs4_mount() is better this way, and I wonder if we should
add vfs_parse_fs_printf(fc, key, fmt, ...) as well...

diff --git a/fs/nfs/nfs4super.c b/fs/nfs/nfs4super.c
index b29a26923ce0..92ac12cee26e 100644
--- a/fs/nfs/nfs4super.c
+++ b/fs/nfs/nfs4super.c
@@ -158,12 +158,6 @@ static int do_nfs4_mount(struct nfs_server *server,
 		.dirfd	= -1,
 	};
 
-	struct fs_parameter param_fsc = {
-		.key	= "fsc",
-		.type	= fs_value_is_string,
-		.dirfd	= -1,
-	};
-
 	if (IS_ERR(server))
 		return PTR_ERR(server);
 
@@ -181,15 +175,7 @@ static int do_nfs4_mount(struct nfs_server *server,
 	root_ctx->server = server;
 
 	if (ctx->fscache_uniq) {
-		len = strlen(ctx->fscache_uniq);
-		param_fsc.size = len;
-		param_fsc.string = kmemdup_nul(ctx->fscache_uniq, len, GFP_KERNEL);
-		if (param_fsc.string == NULL) {
-			put_fs_context(root_fc);
-			return -ENOMEM;
-		}
-		ret = vfs_parse_fs_param(root_fc, &param_fsc);
-		kfree(param_fsc.string);
+		ret = vfs_parse_fs_string(root_fc, "fsc", ctx->fscache_uniq);
 		if (ret < 0) {
 			put_fs_context(root_fc);
 			return ret;

