Return-Path: <linux-fsdevel+bounces-25386-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1DAC94B52B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 04:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7930C1F2288B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 02:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6CC829402;
	Thu,  8 Aug 2024 02:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="H39ZdK89"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0714CD2FB
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Aug 2024 02:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723085435; cv=none; b=LOhZmIYyMlSdVMdjVqzsZtgMYnz38a+HZJyY2xCuy+q0HdrdvGzw6Wkwlpc/2H+ic7d/Ba4rWLGR9OdddrZiRCD1Z4bxWfxiRF6U3NvndxthNuvKYX8+rtIx/KaXv+5t+bkVJ2IsoEfAMf7jOao1ezr9vkrt5muNbamUNiMH5K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723085435; c=relaxed/simple;
	bh=8q4J2E11RGwmoRfoJutGQwkTLyDHNXtBf/Yp0b2212c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=sr+ix1YXsTqcNO4wWROhRnEHrkdbaUM2qbKL5q6mxrjpCqiFf7ovY6KXCY29YEtrxQCor3x4/R2/cTtdOjfW210EkAJjnuEUf9yOwKZButENwQxs0vOs/5YOoQ7CYT8TMzo8M2A4VOCNvPc/l/asj674WdDx+tfE7Ua4EzhiH0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=H39ZdK89; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=NVwZ51MvvxlPEk0pzMpMvr8fNB4E8VXWqPMFhfBbW3U=; b=H39ZdK89VrvjJx70232W60UQsP
	ZYI34KJRyEPfZeKQ8NIBRKUQX+ynQGRUMu6fqUX0FGkjS8I5Whs9MO+8lojxfeWOIEjZSvvzrIgkI
	QNodv7Gr/t8qBeof1a1Bn4GaEt5wwNtIC1ktrrMCG+6OWh8SyYnMWUVieWk95SoPseEi4gS2wXQiR
	wC8jx+7Yks/stkrjec4d6+XRRPzH9iTXztw0YHDxThXsKxc7VSMs9LF//wcvWN+5LCxDg9gzEOscz
	LXW9PkN/fScPM6YOT/JttLtDBHqDrQVswDEuRcja+10teY4p79+OacUnr5dG1E3c6qO9Ln4jtBKSv
	hQ9htAyg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sbtET-00000002YON-2L9F;
	Thu, 08 Aug 2024 02:50:29 +0000
Date: Thu, 8 Aug 2024 03:50:29 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [RFC] why do we need smp_rmb/smp_wmb pair in
 fd_install()/expand_fdtable()?
Message-ID: <20240808025029.GB5334@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

	Take a look at fs/file.c:expand_fdtable() and fs/file.c:fd_install()

In the end of the former:
        copy_fdtable(new_fdt, cur_fdt);
        rcu_assign_pointer(files->fdt, new_fdt);
        if (cur_fdt != &files->fdtab)
                call_rcu(&cur_fdt->rcu, free_fdtable_rcu);
        /* coupled with smp_rmb() in fd_install() */
        smp_wmb();
        return 1;
the only caller (expand_files()) has
        expanded = expand_fdtable(files, nr);
        files->resize_in_progress = false;

OTOH, in fd_install() there's this:
        if (unlikely(files->resize_in_progress)) {
                rcu_read_unlock_sched();
                spin_lock(&files->file_lock);
                fdt = files_fdtable(files);
                WARN_ON(fdt->fd[fd] != NULL);
                rcu_assign_pointer(fdt->fd[fd], file);
                spin_unlock(&files->file_lock);
                return;
        }
        /* coupled with smp_wmb() in expand_fdtable() */
        smp_rmb();
        fdt = rcu_dereference_sched(files->fdt);

What's the problem with droping both barriers and turning that
into
        expanded = expand_fdtable(files, nr);
        smp_store_release(&files->resize_in_progress, false);
and
        if (unlikely(smp_load_acquire(&files->resize_in_progress))) {
		....
                return;
        }
        fdt = rcu_dereference_sched(files->fdt);
resp.?  Anyone who sees ->resize_in_progress being false will
see all stores prior to setting ->fdt on the expand size...

That went into the tree in 8a81252b774b "fs/file.c: don't acquire
files->file_lock in fd_install()".  I don't remember that having been
discussed back then, but it had been 7 years ago...
<check the thread on lore>
Nobody asked, AFAICS.

Is there any problem with going that way?  Because I'm pretty sure
that it's would be cheaper to use store_release/load_acquire instead
of paying for smp_rmb() on the fd_install() side...

Am I missing something subtle here?

