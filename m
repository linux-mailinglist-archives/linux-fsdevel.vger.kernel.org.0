Return-Path: <linux-fsdevel+bounces-49256-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C02A6AB9C9F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 14:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B83C4E50D2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 May 2025 12:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C99A2417C2;
	Fri, 16 May 2025 12:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U6EHBt3S"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71F923E336;
	Fri, 16 May 2025 12:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747399932; cv=none; b=FRquQmnL8TPWMnSBshUxNXtqb/0RSL5f7cbWqF1lbLu0Ib11LAkoXrrrr4aWNNCEpH5bkpSTgZMy2HR3c5yNZYJHI+4oZyEbKveVv6QZ4tKT+W55bF0vAUQxtYR1t4pQANZoMITR+OnC01f2tFiE5wHTsaTU4ykHWGwKPlJG8aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747399932; c=relaxed/simple;
	bh=5XNbJn2Os6XRURBhbHEbR26xbDn53Gzi/Niz2e844T0=;
	h=Date:From:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p8VwVLhe+VW3rqvn8z5yRmSvvxoQ7EnwVP3OHtKh+GmhMmP/cgydIKoU3pWqS2Qc4rIs/f/QZLM7WglQvYTmatSF4viQuCema0w3EiiSYEdcfkt/yMucVS758FLWLmffadkj7kz9VXOHc5WNZ6VRTXYK4Xhuo+53NQymNlflLIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U6EHBt3S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79295C4CEE9;
	Fri, 16 May 2025 12:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747399931;
	bh=5XNbJn2Os6XRURBhbHEbR26xbDn53Gzi/Niz2e844T0=;
	h=Date:From:Cc:Subject:References:In-Reply-To:From;
	b=U6EHBt3SuYdyVL+ZXYeIFCoJPrBp6/N+rm73qneLENMr4zcTsWet/yDGnnlLVE5jv
	 tjh4M38fBOMJICYf4+oAPi2ZK/Vr4byMoACkSEPbeE7WtvAGGI0H5R/4NbuR7dhadx
	 Mo6Q7eERm/3pgjr1V0ycZcDsAm1dMt+Cd/zYnsJpr+OBz06v+3MCbbuRPQqeXDLRcN
	 U4d09CXCtIyDHJtVkrtqrAS2mSQM4NWvI58RWoMVBa5LMM9sKFfnLByVtgOFHv7AmE
	 P2htj2Ooxvm/OVC1mZix50GIlXDVwvXJHeC6phemVUTxq/zjUgizk+kpU1OiPSTiiY
	 k0YSrNioaH61Q==
Date: Fri, 16 May 2025 14:52:05 +0200
From: Alejandro Colomar <alx@kernel.org>
Cc: Alejandro Colomar <alx@kernel.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Rich Felker <dalias@libc.org>, linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, 
	libc-alpha@sourceware.org
Subject: [RFC v1] man/man2/close.2: CAVEATS: Document divergence from
 POSIX.1-2024
Message-ID: <efaffc5a404cf104f225c26dbc96e0001cede8f9.1747399542.git.alx@kernel.org>
X-Mailer: git-send-email 2.49.0
References: <a5tirrssh3t66q4vpwpgmxgxaumhqukw5nyxd4x6bevh7mtuvy@wtwdsb4oloh4>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a5tirrssh3t66q4vpwpgmxgxaumhqukw5nyxd4x6bevh7mtuvy@wtwdsb4oloh4>

POSIX.1-2024 now mandates a behavior different from what Linux (and many
other implementations) does.  It requires that we report EINPROGRESS for
what now is EINTR.

There are no plans to conform to POSIX.1-2024 within the Linux kernel,
so document this divergence.  Keep POSIX.1-2008 as the standard to
which we conform in STANDARDS.

Link: <https://sourceware.org/bugzilla/show_bug.cgi?id=14627>
Link: <https://pubs.opengroup.org/onlinepubs/9799919799/functions/close.html>
Cc: Jan Kara <jack@suse.cz>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Rich Felker <dalias@libc.org>
Cc: <linux-fsdevel@vger.kernel.org>
Cc: <linux-api@vger.kernel.org>
Cc: <libc-alpha@sourceware.org>
Signed-off-by: Alejandro Colomar <alx@kernel.org>
---

Hi,

I've prepared this draft for discussion.  While doing so, I've noticed
the glibc bug ticket, which sounds possibly reasonable: returning 0
instead of reporting an error on EINTR.  That would be an option that
would make us conforming to POSIX.1-2024.  And given that a user can
(and must) do nothing after seeing EINTR, returning 0 wouldn't change
things.

So, I'll leave this patch open for discussion.


Have a lovely day!
Alex

 man/man2/close.2 | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/man/man2/close.2 b/man/man2/close.2
index b25ea4de9..9d5e26eed 100644
--- a/man/man2/close.2
+++ b/man/man2/close.2
@@ -191,10 +191,7 @@ .SS Dealing with error returns from close()
 meaning that the file descriptor was invalid)
 even if they subsequently report an error on return from
 .BR close ().
-POSIX.1 is currently silent on this point,
-but there are plans to mandate this behavior in the next major release
-.\" Issue 8
-of the standard.
+POSIX.1-2008 was silent on this point.
 .P
 A careful programmer who wants to know about I/O errors may precede
 .BR close ()
@@ -206,7 +203,7 @@ .SS Dealing with error returns from close()
 error is a somewhat special case.
 Regarding the
 .B EINTR
-error, POSIX.1-2008 says:
+error, POSIX.1-2008 said:
 .P
 .RS
 If
@@ -243,16 +240,10 @@ .SS Dealing with error returns from close()
 error, and on at least one,
 .BR close ()
 must be called again.
-There are plans to address this conundrum for
-the next major release of the POSIX.1 standard.
-.\" FIXME . for later review when Issue 8 is one day released...
-.\" POSIX proposes further changes for EINTR
-.\" http://austingroupbugs.net/tag_view_page.php?tag_id=8
-.\" http://austingroupbugs.net/view.php?id=529
-.\"
-.\" FIXME .
-.\" Review the following glibc bug later
-.\" https://sourceware.org/bugzilla/show_bug.cgi?id=14627
+.P
+POSIX.1-2024 standardized the behavior of HP-UX,
+making Linux and many other implementations non-conforming.
+There are no plans to change the behavior on Linux.
 .SH SEE ALSO
 .BR close_range (2),
 .BR fcntl (2),

Range-diff against v0:
-:  --------- > 1:  efaffc5a4 man/man2/close.2: CAVEATS: Document divergence from POSIX.1-2024

base-commit: 978b017d93e4e32b752b33877e44a8365644630c
-- 
2.49.0


