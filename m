Return-Path: <linux-fsdevel+bounces-19251-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E2078C1E9A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2024 09:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CECBF1C2111E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 May 2024 07:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B389E15E7E2;
	Fri, 10 May 2024 07:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="pOYYVDPa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC47E5490E;
	Fri, 10 May 2024 07:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715324560; cv=none; b=FI4d7B6LsUbX85hMYghkOE8up3NJXszulboSltQ12gfKqerWWLVkEGSmgmLDyvvnwndnNqnovHs12omh+Xj03Vmgh3lnJ8Q+9dwg9Y1zyaJoSWb4rfZi7GCl4LM4q+G2+KSpkfWrmefQpBCVK9bhPjt65j65ENJ7kCDyUXvHFFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715324560; c=relaxed/simple;
	bh=I9q2/LE7OixOeEBOotIdBWSBIomAbjME2L8JXihXNWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ucLKuSkAzrLZrLzHj8eEFumCWzAC9ja3exzK0Wl0Eg3ZOPgg8cQ+TYOOo4sO78PezrKaNVFK7DxEK9d6IysNIQyniApQgcWzY22l5YqlFxElZu+hrnGrlNromT15mb5Fpd8njWbfuddC93zC3Gvq//OAJpBH3Fa6uq8JbDbOqzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=pOYYVDPa; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=9BEIrQ+9MvvMRnuPmQrJgc1/AxggZCBl/hYSbaTzqVY=; b=pOYYVDPa7cVJDbdcvYoD4wfRNM
	xwNDLjiie4qeT3z15wFQqeGABjlPtifo1iQjjPye49GUPseiI6nXut1fWigs5y4sT044H9jFKJ75k
	QCcTDjW7uASr80yCwVSwB1qOsZZgEJuIJhj479327r5LuU9RM8MTDYYSshbyMcn1D7M04+Wo88WQq
	jiBgRAvAT9kaJ6lJdXRT3jQ3azXQ0aA6VCYuKZigc0ohSdSFDIlgfHC29mEfdgHOEsKwoCDyC5qcp
	KS8dQJdHFljNZtVfyKUiEefcvnfx5Lr6jEo4Z5r2zviNJ5csO4xAhSr3NDZsDRMYWI4ue1rjjfaNk
	/+H/Eybg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s5KGy-002BnN-1U;
	Fri, 10 May 2024 07:02:28 +0000
Date: Fri, 10 May 2024 08:02:28 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Justin Stitt <justinstitt@google.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Nathan Chancellor <nathan@kernel.org>,
	Bill Wendling <morbo@google.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] libfs: fix accidental overflow in offset calculation
Message-ID: <20240510070228.GY2118490@ZenIV>
References: <20240510-b4-sio-libfs-v1-1-e747affb1da7@google.com>
 <20240510004906.GU2118490@ZenIV>
 <20240510010451.GV2118490@ZenIV>
 <6oq7du4gkj3mvgzgnmqn7x44ccd3go2d22agay36chzvuv3zyt@4fktkazj4cvw>
 <20240510044805.GW2118490@ZenIV>
 <20240510063312.GX2118490@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510063312.GX2118490@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, May 10, 2024 at 07:33:12AM +0100, Al Viro wrote:

> As the matter of fact, it would be interesting to find out
> which instances, if any, do *not* have that relationship
> between SEEK_CUR and SEEK_SET.  If such are rare, it might
> make sense to mark them as such in file_operations and
> have vfs_llseek() check that - it would've killed a whole
> lot of boilerplate.  And there it a careful handling of
> overflow checks (or a clear comment explaining what's
> going on) would make a lot more sense.
> 
> IF we know that an instance deals with SEEK_CUR as SEEK_SET to
> offset + ->f_pos, we can translate SEEK_CUR into SEEK_SET
> in the caller.

FWIW, weird instances do exist.

kernel/printk/printk.c:devkmsg_llseek(), for example.  Or this
gem in drivers/fsi/i2cr-scom.c:
static loff_t i2cr_scom_llseek(struct file *file, loff_t offset, int whence)
{
        switch (whence) {
        case SEEK_CUR:
                break;
        case SEEK_SET:
                file->f_pos = offset;
                break;
        default:
                return -EINVAL;
        }

        return offset;
}
SEEK_CUR handling in particular is just plain bogus: lseek(fd, -9, SEEK_CUR)
doing nothing to current position and returning EBADF.  Even if you've done
lseek(fd, 9, SEEK_SET) just before that...

I suspect that some of those might be outright bugs; /dev/kmsg one probably
isn't, but by the look of it those should be rare.

Then there's orangefs_dir_llseek(), with strange handling of SEEK_SET
(but not SEEK_CUR); might or might not be a bug...

From the quick look it does appear that it might be a project worth
attempting - exceptions are very rare.

