Return-Path: <linux-fsdevel+bounces-25297-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1598294A7FE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 14:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9C421F27F67
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 12:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D7C1E673E;
	Wed,  7 Aug 2024 12:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="pqYLpOza"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65FF1E6724;
	Wed,  7 Aug 2024 12:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723034633; cv=none; b=adwQI17ne07aXHWOV1izX48FSABKAkJWhQF3A0+ZVw+ehfkJOGhGfm1905geWw9KUm1oRFrvsE3zGxx6n6dHAY/8DSZnMypf8ThkPluV4lCB/W0qBgFRj4p/dnW4mpSQ3P3a3+zTxULyJwDAYNG8E6cIVBlp+nMiGCgODMmtOjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723034633; c=relaxed/simple;
	bh=NjfGtYZkMXlH9Gz7R4iidvpDE+z4KApgy4w5b85nfM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aa2OeCNthsJoDy0EcppU+sEhujitJN0SYvKNZWIIzktZm9/pCcGJUTk0l2CW9YrendIC/YsOwRhIeHlEqkgHQoTpgajKL99g3RZOrdI9agYyyoAmd4USNjqA9Ui5X2XIl7NXeJ4CPk7pvfyoEZ2Hm+KWC2pbZ9NvZ7xgoNYzkMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=pqYLpOza; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=oK96ZzN0iZ1z8fgqxqt+xECg0zUxgIwr02cf2v1SLS0=; b=pqYLpOzasO/KKSbPIB0od2vqI2
	mxW/G+v3mMS4FNnAODKc0oboeqLY3R23x16M3hVcIXlwtG2ljYCZNJ4sf8PRwSJDYIc+AiMApydat
	2HVSGK+IpdXWWHxLTU7xN2okELQCn4wRA9nCu5pEprjFgc+YJV8Pan2ANATcSbsgY9K01BXwYNwSA
	WZWMbO65W9gd6bE2rCVgg0eNkcjeDz6LTYLuaBsWzjDjzPvWVkxr8T96mJv03lIlKgfPseKkzcHvb
	TKekNva3QByh7GHxJHLdy+Zt4PjXE71jElAVeiip95Bt3b3Q8+Lb9lqr8BsF8+9tpwsg8LS45ajXV
	Op6L3bAQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sbg16-00000002LEo-3bQY;
	Wed, 07 Aug 2024 12:43:48 +0000
Date: Wed, 7 Aug 2024 13:43:48 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, jack@suse.cz, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] vfs: avoid spurious dentry ref/unref cycle on open
Message-ID: <20240807124348.GY5334@ZenIV>
References: <20240807033820.GS5334@ZenIV>
 <CAGudoHFJe0X-OD42cWrgTObq=G_AZnqCHWPPGawy0ur1b84HGw@mail.gmail.com>
 <20240807062300.GU5334@ZenIV>
 <20240807063350.GV5334@ZenIV>
 <CAGudoHH29otD9u8Eaxhmc19xuTK2yBdQH4jW11BoS4BzGqkvOw@mail.gmail.com>
 <20240807070552.GW5334@ZenIV>
 <CAGudoHGMF=nt=Dr+0UDVOsd4nfGRr4xC8=oeQqs=Av9s0tXXXA@mail.gmail.com>
 <20240807075218.GX5334@ZenIV>
 <CAGudoHE1dPb4m=FsTPeMBiqittNOmFrD-fJv9CmX8Nx8_=njcQ@mail.gmail.com>
 <CAGudoHFm07iqjhagt-SRFcWsnjqzOtVD4bQC86sKBFEFQRt3kA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGudoHFm07iqjhagt-SRFcWsnjqzOtVD4bQC86sKBFEFQRt3kA@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Aug 07, 2024 at 11:50:50AM +0200, Mateusz Guzik wrote:

> tripping ip:
> vfs_tmpfile+0x162/0x230:
> fsnotify_parent at include/linux/fsnotify.h:81
> (inlined by) fsnotify_file at include/linux/fsnotify.h:131
> (inlined by) fsnotify_open at include/linux/fsnotify.h:401
> (inlined by) vfs_tmpfile at fs/namei.c:3781

Try this for incremental; missed the fact that finish_open() is
used by ->tmpfile() instances, not just ->atomic_open().

Al, crawling back to sleep...

diff --git a/fs/namei.c b/fs/namei.c
index 95345a5beb3a..0536907e8e79 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3776,7 +3776,10 @@ int vfs_tmpfile(struct mnt_idmap *idmap,
 	file->f_path.dentry = child;
 	mode = vfs_prepare_mode(idmap, dir, mode, mode, mode);
 	error = dir->i_op->tmpfile(idmap, dir, file, mode);
-	dput(child);
+	if (file->f_mode & FMODE_OPENED)
+		mntget(parentpath->mnt);
+	else
+		dput(child);
 	if (file->f_mode & FMODE_OPENED)
 		fsnotify_open(file);
 	if (error)

