Return-Path: <linux-fsdevel+bounces-31446-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE224996E59
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 16:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70B811F23809
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 14:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF9619D8AD;
	Wed,  9 Oct 2024 14:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b="XCsbWaw+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z7Xq8f54"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E78612EBEA;
	Wed,  9 Oct 2024 14:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728484900; cv=none; b=A9BsV9n3RRxUFBcuT7YnWnvAtZkFevWDgI4Ld85R7U05fNwBAvbS2sOhwIbBI1sLG5HQAifd24nZBRmwX1xJmicXfP16HtGeNIIwfYdHqmH0VYhslpO7PRdGEcT4C75AjJpZSO6ECIM7MEmlg+BX0KcCXkd/DOkCL8tTm+FH3bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728484900; c=relaxed/simple;
	bh=u2FRO9vskIoxXceY8cQW+YxBEPZRpNdHpFLeQASaWmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mSYXqnKXoNCJg2FRBY9zJ0TWUUW4QmDeqKqCJOQyNk7K+yytL8wr5cIgy6s/FinRL6KlJn0y9ULiaGEWq8Wc9A3muF1E40rQH/SUTJd4g2WRr+058QD78YIikXmFqHpVqMMo75ZwzzlfVsPbEOqh5xX478V6hzs0kdfCQzIMvv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.pizza; spf=pass smtp.mailfrom=tycho.pizza; dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b=XCsbWaw+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z7Xq8f54; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.pizza
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tycho.pizza
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AB13D254006B;
	Wed,  9 Oct 2024 10:41:36 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Wed, 09 Oct 2024 10:41:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1728484896;
	 x=1728571296; bh=htYGirbttd3S0J/hRAVHjRvjVcCGGy2hTpcEQpIMag8=; b=
	XCsbWaw+QQklO62sUPscXPuXOxMRZ8fbzaRZT4RiXFPj9UeoSXi0Rj3wuKrS1zae
	DRmBOfEsZTM1d11MOknHVRekdPUsKmwyjnEX5cKCWg9GuxfwnkdC6GoxAdAn3wUd
	vtjkNhBEGAn3OC0chdN7q6e656UTVRGRD96ozl7zSMw/rPxmXqXrdKYHAjIbuXYB
	mOCfD3J3xSYpHB6UQSpnt5OALUEV0J1a8Pdoa4gTrDtOwlbE5fLLBPy2Mn7qA1NC
	SFM6YfRX0RND5BMN7tgMBiZCWsv3ba9fhzNEikeJ8AJDjVwv2Uvvd2QiLd+r4r/b
	4qyxqgtFZ3QJOq+Dycm7Vg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728484896; x=
	1728571296; bh=htYGirbttd3S0J/hRAVHjRvjVcCGGy2hTpcEQpIMag8=; b=Z
	7Xq8f54Fx88RyAhXxZzR6KH4WTdA+hbK7kpofuNR5dFRSAeXdKU4YGjya+8KW4Fa
	KMCc03APdRVYgh9QQ6z6plNLAGH782ZdOyAiunN0aP5Y+FgCVhNAkkL4DgwMZeQt
	E+4Kv3v5IscubEwjVxJFds8cmV360jTf4qtX68gWDfUl7EdcsLe+j5WXV51Jaf4W
	+/y3uTF+ngHgPJkLz7SuV4R3U4P5Lo1lk42EyskwqF5hDakOQRzdTSWaRbVWKm+Z
	QB0HPHKuQr5L/fSHBfkK8KFLST80kuHovvNFLNtVlBE3qmaE1SaMBqyBl+bzvI/0
	8S6VQZdde7j3w6QSuhI3w==
X-ME-Sender: <xms:H5YGZ9g26ZgDKlPV2XXD-CRwD8dLS0Ly97XVfS4Ge9fb6c0Xh-QtFQ>
    <xme:H5YGZyCGqMmfEGa1D37ANrM6XyuSdbKlBL2e4DPQYdUS57Bd9fQ967c1qfQAjgPB-
    1GxEcORtMXNxpY62FU>
X-ME-Received: <xmr:H5YGZ9EzIqJvcypC5hRkHCTvjcC114vWRNMt5yjRuwPIP9qA7x_GAp6Pulk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeffedgkeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdej
    necuhfhrohhmpefvhigthhhoucetnhguvghrshgvnhcuoehthigthhhosehthigthhhord
    hpihiiiigrqeenucggtffrrghtthgvrhhnpeettddvheefffetkeejieehhfehieekgedv
    jeelieehkeefueevheehteegteevgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehthigthhhosehthigthhhordhpihiiiigrpdhnsggprhgt
    phhtthhopedugedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepiigshihsiigvkh
    esihhnrdifrgifrdhplhdprhgtphhtthhopegvsghivgguvghrmhesgihmihhsshhiohhn
    rdgtohhmpdhrtghpthhtohepvhhirhhoseiivghnihhvrdhlihhnuhigrdhorhhgrdhukh
    dprhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehj
    rggtkhesshhushgvrdgtiidprhgtphhtthhopehkvggvsheskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepjhhlrgihthhonheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghh
    uhgtkhdrlhgvvhgvrhesohhrrggtlhgvrdgtohhmpdhrtghpthhtoheprghlvgigrdgrrh
    hinhhgsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:H5YGZyRCrQpJ1KGINVpYG8GsXNQtJdjZdP6u4k-ps7443HAFZfwPNg>
    <xmx:H5YGZ6xFpaIuNg7lx0y59-6XZdACev6OJFP2iLs2SRtTC_hbGOE96Q>
    <xmx:H5YGZ47ObaAHInewBzNcgyskejYeymSr_FYascmZ46vvDE_bLCZq9A>
    <xmx:H5YGZ_wX2veF9ZbPiEYGBaRr8oFbNsf3W5vjqAPFtGUfOhzJKUTV3A>
    <xmx:IJYGZ_KzD9v1L6bUczRwB2OUjE8cOaRIi7jevFS-sJJJo8Z2J3ylXUF6>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Oct 2024 10:41:33 -0400 (EDT)
Date: Wed, 9 Oct 2024 08:41:31 -0600
From: Tycho Andersen <tycho@tycho.pizza>
To: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Kees Cook <kees@kernel.org>, Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Alexander Aring <alex.aring@gmail.com>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Tycho Andersen <tandersen@netflix.com>,
	Aleksa Sarai <cyphar@cyphar.com>
Subject: Re: [RFC] exec: add a flag for "reasonable" execveat() comm
Message-ID: <ZwaWG/ult2P7HR5A@tycho.pizza>
References: <20240924141001.116584-1-tycho@tycho.pizza>
 <87msjx9ciw.fsf@email.froward.int.ebiederm.org>
 <Zv1aA4I6r4py-8yW@kawka3.in.waw.pl>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zv1aA4I6r4py-8yW@kawka3.in.waw.pl>

On Wed, Oct 02, 2024 at 02:34:43PM +0000, Zbigniew Jędrzejewski-Szmek wrote:
> On Tue, Sep 24, 2024 at 12:39:35PM -0500, Eric W. Biederman wrote:
> > Tycho Andersen <tycho@tycho.pizza> writes:
> > 
> > > From: Tycho Andersen <tandersen@netflix.com>
> > >
> > > Zbigniew mentioned at Linux Plumber's that systemd is interested in
> > > switching to execveat() for service execution, but can't, because the
> > > contents of /proc/pid/comm are the file descriptor which was used,
> > > instead of the path to the binary. This makes the output of tools like
> > > top and ps useless, especially in a world where most fds are opened
> > > CLOEXEC so the number is truly meaningless.
> > >
> > > This patch adds an AT_ flag to fix up /proc/pid/comm to instead be the
> > > contents of argv[0], instead of the fdno.
> 
> I tried this version (with a local modification to drop the flag and
> enable the new codepath if get_user_arg_ptr(argv, 0) returns nonnull
> as suggested later in the thread), and it seems to work as expected.
> In particular, 'pgrep' finds for the original name in case of
> symlinks.

Here is a version that only affects /proc/pid/comm, without a flag. We
still have to do the dance of keeping the user argv0 before actually
doing __set_task_comm(), since we want to surface the resulting fault
if people pass a bad argv0. Thoughts?

Tycho



diff --git a/fs/exec.c b/fs/exec.c
index dad402d55681..61de8a71f316 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1416,7 +1416,16 @@ int begin_new_exec(struct linux_binprm * bprm)
 		set_dumpable(current->mm, SUID_DUMP_USER);
 
 	perf_event_exec();
-	__set_task_comm(me, kbasename(bprm->filename), true);
+
+	/*
+	 * If fdpath was set, execveat() made up a path that will
+	 * probably not be useful to admins running ps or similar.
+	 * Let's fix it up to be something reasonable.
+	 */
+	if (bprm->argv0)
+		__set_task_comm(me, kbasename(bprm->argv0), true);
+	else
+		__set_task_comm(me, kbasename(bprm->filename), true);
 
 	/* An exec changes our domain. We are no longer part of the thread
 	   group */
@@ -1566,9 +1575,30 @@ static void free_bprm(struct linux_binprm *bprm)
 	if (bprm->interp != bprm->filename)
 		kfree(bprm->interp);
 	kfree(bprm->fdpath);
+	kfree(bprm->argv0);
 	kfree(bprm);
 }
 
+static int bprm_add_fixup_comm(struct linux_binprm *bprm, struct user_arg_ptr argv)
+{
+	const char __user *p = get_user_arg_ptr(argv, 0);
+
+	/*
+	 * In keeping with the logic in do_execveat_common(), we say p == NULL
+	 * => "" for comm.
+	 */
+	if (!p) {
+		bprm->argv0 = kstrdup("", GFP_KERNEL);
+		return 0;
+	}
+
+	bprm->argv0 = strndup_user(p, MAX_ARG_STRLEN);
+	if (bprm->argv0)
+		return 0;
+
+	return -EFAULT;
+}
+
 static struct linux_binprm *alloc_bprm(int fd, struct filename *filename, int flags)
 {
 	struct linux_binprm *bprm;
@@ -1975,6 +2005,10 @@ static int do_execveat_common(int fd, struct filename *filename,
 		goto out_ret;
 	}
 
+	retval = bprm_add_fixup_comm(bprm, argv);
+	if (retval != 0)
+		goto out_free;
+
 	retval = count(argv, MAX_ARG_STRINGS);
 	if (retval == 0)
 		pr_warn_once("process '%s' launched '%s' with NULL argv: empty string added\n",
diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
index e6c00e860951..0cd1f2d0e8c6 100644
--- a/include/linux/binfmts.h
+++ b/include/linux/binfmts.h
@@ -55,6 +55,7 @@ struct linux_binprm {
 				   of the time same as filename, but could be
 				   different for binfmt_{misc,script} */
 	const char *fdpath;	/* generated filename for execveat */
+	const char *argv0;	/* argv0 from execveat */
 	unsigned interp_flags;
 	int execfd;		/* File descriptor of the executable */
 	unsigned long loader, exec;

