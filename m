Return-Path: <linux-fsdevel+bounces-20755-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9269D8D786F
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Jun 2024 23:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B62D31C20CA8
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Jun 2024 21:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35766762FF;
	Sun,  2 Jun 2024 21:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="KfeBfSyq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BF5EDF
	for <linux-fsdevel@vger.kernel.org>; Sun,  2 Jun 2024 21:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717365490; cv=none; b=oqg+WLkedd06PWToZYmxMy+kWktS1KfL9oHe5N7sHkebZCbCJozSht2FgPzYgicmhxp/KkuXgliy2BddJ0tMMKd6kcuoBQuS+JZCJgqHp+qJ9NCeH9JUrenUA1l8PqWFWo+12DINUNelihgNxBs8d8yBLU/CfuDcIiaTxK/BIMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717365490; c=relaxed/simple;
	bh=OmTF5PEtW0hBIPx8ZrNhAJjXqblpoh6fzj255g5ins8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eeioJNryir8q6gpi8Jzj6LqC5SWCunZp63dN4GUC0vuAg7Q+Rvc2mw25795fRwFwNXb4YuoFx+nwu6nCh9BLccJeUwFHlzemEYpUk0iPfnMw0Q6iviT3GloqSFDwjn4HU61PQvN4e3XHfIWbKbR6xd/t4JZ94E36nOztUNNt4rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=KfeBfSyq; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=s9CtVjMIYl42AeqFPqcmqTTQwsKwihr0dawRqDSM1pE=; b=KfeBfSyqnfA7oGPKa/yJV0H94f
	KuSLntyT4NvTrhBGwwGJ9105KTYjEphnkKGSY+SHuRZgorZt6298FdgzOT/nyP9zPraVoYVIvRgCM
	alovigoglFKzrEGakUk7qVH2BPH+PC7OPxtgdF3i/Eu0mrBM41niMB0Dc3D9Y5ALLZNeHJBZH2Ibi
	DSYHqsZrQV9H5wvjJ033OdrdgqIV9UloxdyvdQ89qmz5PvJMpzIXuYmQCxBgpPKV7J+/0qfSqknuN
	CrojX03yVXc5Xd/lPKCz15D1Anu7xzF+DwB5ZYHob0yIl/L5K5bNgA369n7WL+CnRtq8bSw/2yN1S
	4uFdgHaQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1sDtDI-00B1fQ-0B;
	Sun, 02 Jun 2024 21:58:04 +0000
Date: Sun, 2 Jun 2024 22:58:03 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH][RFC] move close_range(2) into fs/file.c, fold
 __close_range() into it
Message-ID: <20240602215803.GE1629371@ZenIV>
References: <20240602204238.GD1629371@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240602204238.GD1629371@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sun, Jun 02, 2024 at 09:42:38PM +0100, Al Viro wrote:
> 	We never had callers for __close_range() except for close_range(2)
> itself.  Nothing of that sort has appeared in four years and if any users
> do show up, we can always separate those suckers again.

BTW, looking through close_range()...  We have

static unsigned int sane_fdtable_size(struct fdtable *fdt, unsigned int max_fds)
{
	unsigned int count;

	count = count_open_files(fdt);
	if (max_fds < NR_OPEN_DEFAULT)
		max_fds = NR_OPEN_DEFAULT;
	return ALIGN(min(count, max_fds), BITS_PER_LONG);
}

which decides how large a table would be needed for descriptors below max_fds
that are opened in fdt.  And we start with finding the last opened descriptor
in fdt (well, rounded up to BITS_PER_LONG, if you look at count_open_files()).

Why do we bother to look at _anything_ past the max_fds?  Does anybody have
objections to the following?

diff --git a/fs/file.c b/fs/file.c
index f9fcebc7c838..4976ede108e0 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -276,20 +276,6 @@ static inline bool fd_is_open(unsigned int fd, const struct fdtable *fdt)
 	return test_bit(fd, fdt->open_fds);
 }
 
-static unsigned int count_open_files(struct fdtable *fdt)
-{
-	unsigned int size = fdt->max_fds;
-	unsigned int i;
-
-	/* Find the last open fd */
-	for (i = size / BITS_PER_LONG; i > 0; ) {
-		if (fdt->open_fds[--i])
-			break;
-	}
-	i = (i + 1) * BITS_PER_LONG;
-	return i;
-}
-
 /*
  * Note that a sane fdtable size always has to be a multiple of
  * BITS_PER_LONG, since we have bitmaps that are sized by this.
@@ -305,12 +291,18 @@ static unsigned int count_open_files(struct fdtable *fdt)
  */
 static unsigned int sane_fdtable_size(struct fdtable *fdt, unsigned int max_fds)
 {
-	unsigned int count;
+	const unsigned int min_words = BITS_TO_LONGS(NR_OPEN_DEFAULT);  // 1
+	unsigned int words;
+
+	if (max_fds <= NR_OPEN_DEFAULT)
+		return NR_OPEN_DEFAULT;
+
+	words = BITS_TO_LONGS(min(max_fds, fdt->max_fds)); // >= min_words
+
+	while (words > min_words && !fdt->open_fds[words - 1])
+		words--;
 
-	count = count_open_files(fdt);
-	if (max_fds < NR_OPEN_DEFAULT)
-		max_fds = NR_OPEN_DEFAULT;
-	return ALIGN(min(count, max_fds), BITS_PER_LONG);
+	return words * BITS_PER_LONG;
 }
 
 /*

