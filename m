Return-Path: <linux-fsdevel+bounces-66559-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2050AC23C1D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 09:22:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2CC194FA8ED
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 08:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 587D632F778;
	Fri, 31 Oct 2025 08:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="FBw4eMw1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A2432F75D;
	Fri, 31 Oct 2025 08:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761897979; cv=none; b=SDNRhha2mwuOzijp4ZdFttTqMYzzflC8+tr9ZBnVUXlSWayrfzj2FK/mighaaSGCgnO4reYxZbNHlvp9tANDOjgUn1xTUQIep17dBWMHd9d9xlDuY2gTula8DYg62XDOG6NlID6nZjFaUVA8QafBaVjLXzwYirjAGgNNkezlJAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761897979; c=relaxed/simple;
	bh=YOmqd7Qrk+F4D8q0rLPzB0CBi5WACVgF9sV3TVqmWIg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ufNo7PjY3MEIl/52JBCVphhZqbQ1HCHfFBFgkhzp4xV0K3t4eqtPfghZt3R8wUcjgD29D6J+S+2mIGODu6IQ/rIkRTboJLrAOvOW8l1lCkE5/FOi3PI+RsRuUNXiRXnpIgVqIs6fawuwlkpbmGt0aroZ42WnHy0JdQ7wPeVSUOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=FBw4eMw1; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=WPFFDy+O21qt5q+XeU/u9iNgDfB/U0qzznfTB3bhtnc=; b=FBw4eMw1Vx0Qh4TP6exSRzkH+I
	jBARV0LN2URl9D9PexOkwawI2ujFhiUUMO26dWxK8PnzWyUsz7brlYu/0GdRurrr5QfTUodGZZz6f
	Tu92KgwEC4UAmaEOiu4lqK6oIncuT709zXQNEprQ2oAoEupORU0G9QlVrigKgYsHBYvHD7dszu1XF
	jkjt1fv0FTO/oVNmzLg0IFbVEQ/HFYkiRgeMxBNX2k3vrmbohon2YHIPWlXSFtW3LSJsEY0Cry+9+
	wF/u650IFMcFN5u/wXyg8Go8zAz3us5jr5ijJasDB8A6TfPOCif/gWAxckkBrw3iNXMfPUOjNDkbY
	3P4GgnuQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEk9H-0000000GtOa-322w;
	Fri, 31 Oct 2025 08:06:15 +0000
Date: Fri, 31 Oct 2025 08:06:15 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: audit@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Subject: [viro@zeniv.linux.org.uk: [RFC] audit reporting (or not reporting)
 pathnames on early failures in syscalls]
Message-ID: <20251031080615.GB2441659@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

OK, that's two misspellings of the list name already;-/

Al, deeply embarrassed and crawling to get some sleep...

----- Forwarded message from Al Viro <viro@zeniv.linux.org.uk> -----

Date: Fri, 31 Oct 2025 07:58:56 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-audit@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Subject: [RFC] audit reporting (or not reporting) pathnames on early failures in syscalls

	FWIW, I've just noticed that a patch in the series I'd been
reordering had the following chunk:
@@ -1421,20 +1421,16 @@ static int do_sys_openat2(int dfd, const char __user *filename,
                          struct open_how *how)
 {
        struct open_flags op;
-       struct filename *tmp;
        int err, fd;
 
        err = build_open_flags(how, &op);
        if (unlikely(err))
                return err;
 
-       tmp = getname(filename);
-       if (IS_ERR(tmp))
-               return PTR_ERR(tmp);
-
        fd = get_unused_fd_flags(how->flags);
        if (likely(fd >= 0)) {
-               struct file *f = do_filp_open(dfd, tmp, &op);
+               struct filename *name __free(putname) = getname(filename);
+               struct file *f = do_filp_open(dfd, name, &op);
                if (IS_ERR(f)) {
                        put_unused_fd(fd);
                        fd = PTR_ERR(f);

	From the VFS or userland POV there's no problem - we would get a
different error reported e.g. in case when *both* EMFILE and ENAMETOOLONG
would be applicable, but that's perfectly fine.  However, from the audit
POV it changes behaviour.

	Consider behaviour of openat2(2).
1.  we do sanity checks on the last ('usize') argument.  If they
fail, we are done.
2.  we copy struct open_how from userland ('how' argument).
If copyin fails, we are done.
3.  we do sanity checks on how->flags, how->resolve and how->mode.
If they fail, we are done.
4.  we copy the pathname to be opened from userland ('filename' argument).
If that fails, or if the pathname is either empty or too long, we are done.
5.  we reserve an unused file descriptor.  If that fails, we are done.
6.  we allocate an empty struct file.  If that fails, we are done.
7.  we finally get around to the business - finding and opening the damn thing.
Which also can fail, of course.

	We are expected to be able to produce a record of failing
syscall.  If we fail on step 4, well, the lack of pathname to come with
the record is to be expected - we have failed to get it, after all.
The same goes for failures on steps 1..3 - we hadn't gotten around to
looking at the pathname yet, so there's no pathname to report.	What (if
anything) makes "insane how->flags" different from "we have too many
descriptors opened already"?  The contents of the pathname is equally
irrelevant in both cases.  Yet in the latter case (failure at step 5)
the pathname would get reported.  Do we need to preserve that behaviour?

	Because the patch quoted above would change it.  It puts the failure
to allocate a descriptor into the same situation as failures on steps 1..3.

	As far as I can see, there are three possible approaches:

1) if the current kernel imports the pathname before some check, that shall
always remain that way, no matter what.  Audit might be happy, but nobody
else would - we'll need to document that constraint and watch out for such
regressions.  And I'm pretty sure that over the years there had been
other such changes that went into mainline unnoticed.

2) reordering is acceptable.  Of course, the pathname import must happen
before we start using it, but that's the only real constraint.  That would
mean the least headache for everyone other than audit folks.

3) import the pathnames as early as possible.  It would mean a non-trivial
amount of churn, but it's at least a definite policy - validity of change
depends only on the resulting code, not the comparison with the earlier
state, as it would in case (1).  From QoI POV it's as nice as audit folks
could possibly ask, but it would cause quite a bit of churn to get there.
Not impossible to do, but I would rather not go there without a need.
Said that, struct filename handling is mostly a decent match to CLASS()
machinery, and all required churn wouldn't be hard to fold into conversion
to that.

	My preference would be (2), obviously.	However, it really depends
upon the kind of requirements audit users have.  Note that currently the
position of pathname import in the sequence is not documented anywhere,
so there's not much audit users can rely upon other than "the current
behaviour is such-and-such, let's hope it doesn't change"... ;-/

	Comments?


----- End forwarded message -----

