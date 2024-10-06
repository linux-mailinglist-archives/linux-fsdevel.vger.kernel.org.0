Return-Path: <linux-fsdevel+bounces-31128-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC9F991F30
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Oct 2024 16:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78B69281E8E
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Oct 2024 14:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AEC01422D2;
	Sun,  6 Oct 2024 14:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Ym5kQUjt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D51313665B;
	Sun,  6 Oct 2024 14:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728226751; cv=none; b=CAOwwh6gb30/XCz20wY6THnt+XsX3rWA4UTewhgl9S2ONFITJwwh4TQ6ae9IFKyfLv13HG00kBxk3JKVO3fyU+j9BkDXKt9iu8E8T/nMg9FqPu1Kco0+NKnhQ+0s1OT0lg1Q35RHA+G8JKhMPXEbBn4CPPVUfGAAlUWwWnxP4OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728226751; c=relaxed/simple;
	bh=aZIyK0YX9RB1Yi01JNjPLgy28xsvKkXz8fEnxnLlZXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nTe3evuaU83hpFrcByrBYXIagFW8KLVCgCnfYmoSThpYCbCr4VdHJxFxxENj/sLaXqTM1Gqr1i6EL9CgY9coLqptFahPp1dcIdZqwaRC243olr36SZvpXfeyXmWAbMnUUBX3OBKMD0Sw2k+dfwFImAEnJn/UqGnUCH/nxoEikow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Ym5kQUjt; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=QjaM5k9qqJvchGVL0bXBB8KvEd+WrkzXBDa2YMdrjdE=; b=Ym5kQUjtP6Dd9OwFUXGvXnWioY
	wZDDdxmGBO5Nh6hBKstzXXUHYdcnxEuktG17KW4lqXwW2x5sqvFM7mFPaNJPWOFyxIz+rbVF9HNs5
	sTl+zw6W+PsAb83XpQOTAgQaZFbLwWTz5Ne0oSzir8MLlnz1+bijsRoiBOGoSSyv908vaVW3H3Mtc
	dnd09+IPd5K6u683QoytSS3TepbbHEzHzcYWNO3tMcVIXt/bmeK6F6o+DoP4sVS3lmun60RRoABep
	5azAeIBPC110DvZjWc43lgMUVLlpFwZAKrqbKELDkwbyv27ERTUmyioMtaoYcIdEXgGOo3Stavnop
	RNNpg/bw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sxSiu-00000001MPd-0X0j;
	Sun, 06 Oct 2024 14:59:04 +0000
Date: Sun, 6 Oct 2024 15:59:04 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: kernel test robot <oliver.sang@intel.com>
Cc: Christian =?iso-8859-1?Q?G=F6ttsche?= <cgzones@googlemail.com>,
	oe-lkp@lists.linux.dev, lkp@intel.com,
	linux-fsdevel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	Christian Brauner <brauner@kernel.org>, linux-alpha@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
	audit@vger.kernel.org, linux-api@vger.kernel.org,
	linux-arch@vger.kernel.org
Subject: Re: [viro-vfs:work.xattr2] [fs/xattr]  64d47e878a:
 xfstests.xfs.046.fail
Message-ID: <20241006145904.GE4017910@ZenIV>
References: <202410062250.ee92fca7-oliver.sang@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202410062250.ee92fca7-oliver.sang@intel.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sun, Oct 06, 2024 at 10:20:57PM +0800, kernel test robot wrote:

> xfs/046       - output mismatch (see /lkp/benchmarks/xfstests/results//xfs/046.out.bad)
>     --- tests/xfs/046.out	2024-09-30 21:13:44.000000000 +0000
>     +++ /lkp/benchmarks/xfstests/results//xfs/046.out.bad	2024-10-06 05:31:50.379495110 +0000
>     @@ -34,4 +34,8 @@
>      xfsrestore: restore complete: SECS seconds elapsed
>      xfsrestore: Restore Status: SUCCESS
>      Comparing listing of dump directory with restore directory
>     +ls: /fs/scratch/dumpdir/sub/a-link: No such file or directory
>     +ls: /fs/scratch/dumpdir/sub/b-link: No such file or directory
>     +ls: /fs/scratch/restoredir/dumpdir/sub/a-link: No such file or directory
>     +ls: /fs/scratch/restoredir/dumpdir/sub/b-link: No such file or directory
>     ...
>     (Run 'diff -u /lkp/benchmarks/xfstests/tests/xfs/046.out /lkp/benchmarks/xfstests/results//xfs/046.out.bad'  to see the entire diff)
> Ran: xfs/046
> Failures: xfs/046
> Failed 1 of 1 tests

*stares*

D'oh...  Inverted sense for AT_SYMLINK_NOFOLLOW => LOOKUP_FLAGS...

Try this:

diff --git a/fs/xattr.c b/fs/xattr.c
index 0b506b6565b7..b96cca3f4bf8 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -721,7 +721,7 @@ static int path_setxattrat(int dfd, const char __user *pathname,
 	if ((at_flags & ~(AT_SYMLINK_NOFOLLOW | AT_EMPTY_PATH)) != 0)
 		return -EINVAL;
 
-	if (at_flags & AT_SYMLINK_NOFOLLOW)
+	if (!(at_flags & AT_SYMLINK_NOFOLLOW))
 		lookup_flags = LOOKUP_FOLLOW;
 
 	error = setxattr_copy(name, &ctx);
@@ -880,7 +880,7 @@ static ssize_t path_getxattrat(int dfd, const char __user *pathname,
 		return file_getxattr(fd_file(f), &ctx);
 	} else {
 		int lookup_flags = 0;
-		if (at_flags & AT_SYMLINK_NOFOLLOW)
+		if (!(at_flags & AT_SYMLINK_NOFOLLOW))
 			lookup_flags = LOOKUP_FOLLOW;
 		return filename_getxattr(dfd, filename, lookup_flags, &ctx);
 	}

