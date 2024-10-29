Return-Path: <linux-fsdevel+bounces-33156-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D889B51E7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Oct 2024 19:35:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E18F12846A7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Oct 2024 18:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BABE31DE2BD;
	Tue, 29 Oct 2024 18:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="CDaAVqwi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A872107
	for <linux-fsdevel@vger.kernel.org>; Tue, 29 Oct 2024 18:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730226925; cv=none; b=pRwQQcW191rlTuKaD5yqlXv3uXF1upqqww6mr+MQXMk0PG1/2ogEBP64oYervvXx0zDlkfEKqHUPukghZRHRuLHj48IjfNN5YpLi/Eg/Oj3J9XkMrybEPdwyqoyZ8q+y1hxdBxuLsgnUlH2+yW75TfGhZZ8En4mbxQ+g+aQnTqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730226925; c=relaxed/simple;
	bh=+iqYIi3fwsAvBkJf7U8kHNswPErM7yBmHfXSoC8W7oE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JNAcPaDi5FQmKOrkbp/QUZs3CB3ujt5/tzjc9CR4GGtI36SzTTeIdDqaHcbVJR4LNAKuV7ziwzMlTNOs5YsitVFJMj3Ognz47bHMUkIS+7z51fsrDH+ALR75PVbKRI/ad1Swr1T2SMAloCpvD5kRisiJn8NmiWWIUGDIVUDJd+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=CDaAVqwi; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6mbrucKfWhBH6GsqNiv/sVAddyOIlYKgONIdO2A3cnk=; b=CDaAVqwihOAkdEZYWyTZAlczed
	Pj8nq5mo8Qoc24j8ofEq6lS8kAGcLazkVauDMei5Tlrby0F/0SxwfGdA5LaTABnfA+DH754BKr/h7
	qTGUM7I76hqrZb9U6CEfI9OZrAb960jigcWhILYHeb7lyaqmn3/2ZVce7yG/ELOOe8TU1idqu64B9
	wGAwFlTs6UwxZhZP//wOHwsohfUCy+SY3N7QL2bfes6o8uAeFzIQsMIEBvy3i+7Btft6wcEfS1NI8
	G3kHlGH5XtIWaUiL57sl8jPtVLMuF2OsNi4KaV/Tyr+nCsNpO7KwL0qPL43RKi1lq/tOM0V+Lxa9K
	wFi6ytnw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t5r3o-000000098QY-256O;
	Tue, 29 Oct 2024 18:35:20 +0000
Date: Tue, 29 Oct 2024 18:35:20 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: David Disseldorp <ddiss@suse.de>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH] initramfs: avoid filename buffer overrun
Message-ID: <20241029183520.GE1350452@ZenIV>
References: <20241029124837.30673-1-ddiss@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029124837.30673-1-ddiss@suse.de>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Oct 29, 2024 at 12:48:37PM +0000, David Disseldorp wrote:

> When extracting an initramfs cpio archive, the kernel's do_name() path
> handler assumes a zero-terminated path at @collected, passing it
> directly to filp_open() / init_mkdir() / init_mknod().
> 
> If a specially crafted cpio entry carries

... /linuxrc with whatever code they want to run as root before anything
else in userland, you are already FUBAR.

> a non-zero-terminated filename
> and is followed by uninitialized memory, then a file may be created with
> trailing characters that represent the uninitialized memory. Symlink
> filename fields handled in do_symlink() won't overrun past the data
> segment, due to the explicit zero-termination of the symlink target.

... or that.
 
> Fix filename buffer overrun by skipping over any cpio entries where the
> field doesn't carry a zero-terminator at the expected (name_len - 1)
> offset.
> 
> Fixes: 1da177e4c3f41 ("Linux-2.6.12-rc2")
> Signed-off-by: David Disseldorp <ddiss@suse.de>

[snip]

> +	if (collected[name_len - 1] != '\0') {
> +		pr_err("Skipping symlink without nulterm: %.*s\n",
> +		       (int)name_len, collected);

I'm not sure pr_err() and continue is a good approach here -
you'd been given a corrupted image, so there's no point trying
to do anything further with it.  Have it return 1, at least,
and preferably use error("buggered symlink") in addition or
instead of your pr_err().

FWIW, it's _not_ about trying to stop an attack - if you get there with
image contents controlled by attacker, you have already hopelessly lost;
no buffer overruns are needed.

It does catch corrupted images, which is the right thing to do, but it's
not a security issue.

