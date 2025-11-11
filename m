Return-Path: <linux-fsdevel+bounces-67870-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EF3F9C4CA69
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 10:27:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 813D84F7ACD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 09:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA3322F25E8;
	Tue, 11 Nov 2025 09:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Ctp6Ovrm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C092F1FCF;
	Tue, 11 Nov 2025 09:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762852974; cv=none; b=FdXbhe1qSyDhGlx233zZGpsKLSed0W7L2rzxzqqXmXqwaC4pj5snwgHsNijgm8YyOIgR0mzahXvujOte5YH1SXQLNeZU2uaKrlQf0MOAoc+zPjJvc+Je07EMbkC8pNlRzToARNrVsl0RdhMwrvi+hOnn93JBNzZbHh93kBmbXUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762852974; c=relaxed/simple;
	bh=p9uT5LhYuBjH+4JyrxTaYxUmHijhBh4UdewuaPfrgMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mtxQvz0MYTEhhhaFG9yUqEKK/1nXuXTJpxp73PWV1jGlHe6MOSBUVeG9CQkTiaV3pvUxLpi6wVQ2QSHrSpPaOd8yujVouBfFLM8y3Gbqu3G/t366Q/AfdxpfSkGT6OGM/veutDcakAOPQ6Ct1br6Fblugf/FGdhuBq2Ur9yK+bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Ctp6Ovrm; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=bCwfGiKgiQS98umgjWmA+KBFsrU1nv1bSQtZVL8GWA8=; b=Ctp6OvrmDlcVhrBE/X7ZoCQ3Mm
	Xi1Kuu3v9A9ck3YoCXmK1op9I0Yetdw8qK2AI5vba1hMAaukWnfiIROdNGM8k5hNagIn8U6f/DbXc
	7SZCLXg+DPFvAEv7YeV+N51icIvjvJ4BA9fxzcVndktupx8dikc0ru0OeO7NEL1neFlRBRclduioP
	+A1kk/KvWFGGdvC4O13Hn/THru23xl8DN4aVx/jxZMA3LSZjPRX+yCV6jcDqkkisGDgxSNnWutSwz
	Dcn0UUwFkqHJ9NqIOreSg8eqyHMhfZXRsou5CfivhK1+HdjFA+eAI2Bchqrs8kQSodD9NTx+AIU8l
	Ejvj79bw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIkaK-0000000EqIA-1xuT;
	Tue, 11 Nov 2025 09:22:44 +0000
Date: Tue, 11 Nov 2025 09:22:44 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: bot+bpf-ci@kernel.org
Cc: linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org,
	brauner@kernel.org, jack@suse.cz, raven@themaw.net,
	miklos@szeredi.hu, neil@brown.name, a.hindborg@kernel.org,
	linux-mm@kvack.org, linux-efi@vger.kernel.org,
	ocfs2-devel@lists.linux.dev, kees@kernel.org, rostedt@goodmis.org,
	gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
	paul@paul-moore.com, casey@schaufler-ca.com,
	linuxppc-dev@lists.ozlabs.org, john.johansen@canonical.com,
	selinux@vger.kernel.org, borntraeger@linux.ibm.com,
	bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
	daniel@iogearbox.net, martin.lau@kernel.org, eddyz87@gmail.com,
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCH v3 36/50] functionfs: switch to simple_remove_by_name()
Message-ID: <20251111092244.GS2441659@ZenIV>
References: <20251111065520.2847791-37-viro@zeniv.linux.org.uk>
 <20754dba9be498daeda5fe856e7276c9c91c271999320ae32331adb25a47cd4f@mail.kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20754dba9be498daeda5fe856e7276c9c91c271999320ae32331adb25a47cd4f@mail.kernel.org>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Nov 11, 2025 at 07:53:16AM +0000, bot+bpf-ci@kernel.org wrote:

> When ffs_epfiles_create() calls ffs_epfiles_destroy(epfiles, i - 1) after
> the first ffs_sb_create_file() call fails (when i=1), it passes count=0.
> The initialization loop starts at i=1, so epfiles[0].ffs is never
> initialized.

Incorrect.  The loop in question is

	epfile = epfiles;
	for (i = 1; i <= count; ++i, ++epfile) {
		epfile->ffs = ffs;
		mutex_init(&epfile->mutex);
		mutex_init(&epfile->dmabufs_mutex);
		INIT_LIST_HEAD(&epfile->dmabufs);
		if (ffs->user_flags & FUNCTIONFS_VIRTUAL_ADDR)
			sprintf(epfile->name, "ep%02x", ffs->eps_addrmap[i]);
		else   
			sprintf(epfile->name, "ep%u", i);
		err = ffs_sb_create_file(ffs->sb, epfile->name,
					 epfile, &ffs_epfile_operations);
		if (err) {
			ffs_epfiles_destroy(epfiles, i - 1);
			return err;
		}
	}

and invariant maintained through the loop is epfile == epfiles + (i - 1).
We start with i == 1 and epfile == epfiles, modify neither variable in
the loop body and increment both i and epfile by the same amount in
the step.

In other words, on the first pass through the loop we access epfiles[0],
not epfiles[1].  Granted, the loop could've been more idiomatic, but
it is actually correct.

