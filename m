Return-Path: <linux-fsdevel+bounces-56663-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5E4B1A6C5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 17:56:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38B3B3AD512
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 15:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F4D27702A;
	Mon,  4 Aug 2025 15:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Z4MU14OB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283D714AD20;
	Mon,  4 Aug 2025 15:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754322755; cv=none; b=jcb5eeojH/aiEPDToyUnGkVvILBIWGBHwKZicZR3KglxZPJwxxd+Kl3stW1jMLw+x0EP/2z+jucCdVvBYJ3WtfmXVPv3/M+W1OjTfXW23r4ylpudHb8IWpkxpNXEIgtgCgcv7GAWIkbnL2LQ2ejkIDAW5B1Cjs+bxfc0CESYWuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754322755; c=relaxed/simple;
	bh=PXfTV3Ext2asW/XhJtPEC7nTQ9od7occwTqoK5qo9QE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PlmRRKpj9si1RT+bJKndQDBZwIJcawO0PQkfFQMqpwwZthm+2arVhbEOd3d884LUt+yWIggOBHHJV5acyU+WpDw56AZKbvLPN2auUNgwkylsvhs93JsencbsqmbEnLQq9Uv1uzUg+p86icZ6V14UuROpgIXygNa6lVReWqge/Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Z4MU14OB; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ns7rlHXoCwloogZwv8OFLPweSRGbius7I2ZVzURSBuc=; b=Z4MU14OBqmJt2Sc9JYKvBx3dyP
	jg7JJdQ75RRVPvMFRF/OTbnHL8CM1o/glrt3DR+Xlnk58ZDcXfGQwedPkEiKkmgZgLAqd5J2l0VPQ
	G/92foAeM2htz3lUiUYZ4mw9KlbsrFlYIwr6zeV9iashn/zTONIaaZioOwaO5hAfgDGOZQkpjTfFi
	tPZklBvEmHmZot55sa3yZ1YfcvPL1GYpvD7x1YztvUgrSeeSn0gh2YZ1sNolSci6dD8ZY98CFR4bJ
	UULnv5O6mYeQjmz2u98+8QiroTPuXeNuMh96Uv3x1h1NeEwpeZuHDdK/SwQZanyYmh7+3Yr9cyEfs
	w6mGivRQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uixUD-0000000CPvz-0WLt;
	Mon, 04 Aug 2025 15:52:29 +0000
Date: Mon, 4 Aug 2025 16:52:29 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
	Jan Kara <jack@suse.cz>, Sargun Dhillon <sargun@sargun.me>,
	Kees Cook <kees@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] fs: always return zero on success from replace_fd()
Message-ID: <20250804155229.GY222315@ZenIV>
References: <20250804-fix-receive_fd_replace-v2-1-ecb28c7b9129@linutronix.de>
 <20250804-rundum-anwalt-10c3b9c11f8e@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250804-rundum-anwalt-10c3b9c11f8e@brauner>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Aug 04, 2025 at 02:33:13PM +0200, Christian Brauner wrote:

> +       guard(spinlock)(&files->file_lock);
>         err = expand_files(files, fd);
>         if (unlikely(err < 0))
> -               goto out_unlock;
> -       return do_dup2(files, file, fd, flags);
> +               return err;
> +       err = do_dup2(files, file, fd, flags);
> +       if (err < 0)
> +               return err;
> 
> -out_unlock:
> -       spin_unlock(&files->file_lock);
> -       return err;
> +       return 0;
>  }

NAK.  This is broken - do_dup2() drops ->file_lock.  And that's why I
loathe the guard() - it's too easy to get confused *and* assume that
it will DTRT, no need to check carefully.

