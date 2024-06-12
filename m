Return-Path: <linux-fsdevel+bounces-21496-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46576904918
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 04:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B2161C2265C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 02:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5DA0EAD7;
	Wed, 12 Jun 2024 02:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="aHkoDEj2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E655BB651;
	Wed, 12 Jun 2024 02:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718159878; cv=none; b=I+gx4J/aCGLIdfIqRmzH7IqihU8Uw7y2HJuLAACsikuR36NnBI346tyb5YtOWCjIY0bNhjuoupHTKChA2QHmmpIQURFWk7UT4aNG7R22g0ywZx25JzZXLUwCLXnidwXrqKaqd+/4rCtSzZZIWrqnr3jLME6LfIlnyy7+O/b/BFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718159878; c=relaxed/simple;
	bh=8TJSDF91JPEtpNQOYKshQofYbHPrOws3DuqRwzONNcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ROwBt1oL2+naOvg8XItj+GAPueL+012M/U+dX+500FS/toQHHvQrT4YuVJePkcL77ts4E8PgJY7Zn4XjjsGXQrahP/+8F2uH81x+80aoZVcYOenjtsmrVveb36RFMc9ZTUoyo6MWOqUszbidbyswufeW1WMI6TFh7tZL6r5Pthk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=aHkoDEj2; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=TcipHWc8SNr6o/D0UUcsakyzLLgeKSo+R3zQgMvpZ6g=; b=aHkoDEj2pEFv5B+kORwT+xARb1
	7ojPndYqAPP0qEKlaiN5OvqLYJFt0mpT3kD8LnvHBlikn/acRUowlNIgUMLp9BP/ivOZyjD86+dr+
	ZpCCnNnrhQs5rHEE3kDFCkZXvYS6i6RSAzLXB593+4ApI/LXNZaSLIGV6fKYBkCTbs15y877Kn84b
	htT8nYHxoXT/0WlW0GvarFCi1Xc1sAtngV6VVi0lCceXt6cAPlz1rHOepnv+rJoNb5NKMcG9JaGjh
	CZ9vnNHIVzqFN9eIYz6lR/Q6Kbwmux2pRJ1Um+q1VnSFn9iVkv4hrYEUgdJiI9D664wRS/2eV7yYM
	ZdXs942Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1sHDrw-00Ee2t-1o;
	Wed, 12 Jun 2024 02:37:48 +0000
Date: Wed, 12 Jun 2024 03:37:48 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: NeilBrown <neilb@suse.de>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>,
	James Clark <james.clark@arm.com>, ltp@lists.linux.it,
	linux-nfs@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] VFS: generate FS_CREATE before FS_OPEN when
 ->atomic_open used.
Message-ID: <20240612023748.GG1629371@ZenIV>
References: <171815791109.14261.10223988071271993465@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171815791109.14261.10223988071271993465@noble.neil.brown.name>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Jun 12, 2024 at 12:05:11PM +1000, NeilBrown wrote:

> For finish_open() there are three cases:
>  - finish_open is used in ->atomic_open handlers.  For these we add a
>    call to fsnotify_open() in do_open() if FMODE_OPENED is set - which
>    means do_dentry_open() has been called. This happens after fsnotify_create().

	Hummm....  There's a bit of behaviour change; in case we fail in
may_open(), we used to get fsnotify_open()+fsnotify_close() and with that
patch we's get fsnotify_close() alone.

	IF we don't care about that, we might as well take fsnotify_open()
out of vfs_open() and, for do_open()/do_tmpfile()/do_o_path(), into
path_openat() itself.  I mean, having
        if (likely(!error)) {
                if (likely(file->f_mode & FMODE_OPENED)) {
			fsnotify_open(file);
                        return file;
		}
in there would be a lot easier to follow...  It would lose fsnotify_open()
in a few more failure exits, but if we don't give a damn about having it
paired with fsnotify_close()...

