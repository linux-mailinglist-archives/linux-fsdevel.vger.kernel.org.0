Return-Path: <linux-fsdevel+bounces-56880-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3570BB1CC50
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 21:08:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69C6B562C07
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 19:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B09029E116;
	Wed,  6 Aug 2025 19:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="BgCUrZDX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFE826E146;
	Wed,  6 Aug 2025 19:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754507278; cv=none; b=tNbOM+a4F/m2WPVjE8Q9LBpFOfBCWmiMh02eKPfJEqyVDVTUJdDB9b5EqimNOf5YdBfh6ajRF3FV3HkdoV6decyk4szP5ok6xFM2Ku8kvb0LPuZmyURCDfs+yGpyUDOW8wwAG/ZU9T6lM7GwsVlWQZB0kKhLCpq7jrviPlVLkMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754507278; c=relaxed/simple;
	bh=jmimWuNcqknVwhXUmpqEa5mi8TRiO/cSWqnEwfDINsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LlUUrbN6eLuQIpHljAoHczKtln38Y0cYfbtrx8tY57o9LcVlLVCkX+MDktvvUQupCIQwu0RBXn+F1SZLWOCQje0rxqrGPf9N+lY5eyQZj2N7QIn2ch8nsEEWS4pFum5yuz1I3Z6OKyv9MPp6y6uyRN1ptOmgHzYh0FKcj30jyAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=BgCUrZDX; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=EXAP3aa/vPgba/QaTkBMehKxqQb1QYUqRQFCYaCyzQE=; b=BgCUrZDX0lIPPqClVkKnnrmsb6
	VWquIg1weHpD4IopANIur1D5bstkjL9VBP9q/yLvgDslaQMLXw/GBtmWQYLIDHrY6BdWFd+ddFHd2
	8YugzjVE8p+uFM8iue1YxmQEvJIUQ2gyoyepqDyJvjA0m0fC16ryNw5fCTkuab+DpwSk2AfpceDPi
	HvCDo+lzs0dwFIrdqr5FlXKCAkHbMvqDwz3wxbMqCaKM8XKe79PepmOqMekbxUoKFfDB6ALBhs7Pq
	SvBPFsr8RZhtDO1u2AL1Q7t/uG9+a9Ze7AMyif0nw3oKq3TjJE3AGYCOYjk7CKHuoZ2eVggQ3tm38
	PKYMZHwQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujjUN-0000000EJY4-2HYA;
	Wed, 06 Aug 2025 19:07:51 +0000
Date: Wed, 6 Aug 2025 20:07:51 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	David Howells <dhowells@redhat.com>, Shuah Khan <shuah@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 1/2] fscontext: do not consume log entries when
 returning -EMSGSIZE
Message-ID: <20250806190751.GG222315@ZenIV>
References: <20250807-fscontext-log-cleanups-v3-0-8d91d6242dc3@cyphar.com>
 <20250807-fscontext-log-cleanups-v3-1-8d91d6242dc3@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250807-fscontext-log-cleanups-v3-1-8d91d6242dc3@cyphar.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Aug 07, 2025 at 03:55:23AM +1000, Aleksa Sarai wrote:

> -		goto err_free;
> -	ret = -EFAULT;
> -	if (copy_to_user(_buf, p, n) != 0)
> -		goto err_free;
> +	if (copy_to_user(_buf, p, n))
> +		n = -EFAULT;
>  	ret = n;
> -
> -err_free:
>  	if (need_free)
>  		kfree(p);
>  	return ret;

Minor nit: seeing that there's only one path to that return, I would
rather turn it into
	return n;
and dropped the assignment to ret a few lines above.  Anyway, that's
trivially done when applying...

Anyway, who's carrying fscontext-related stuff this cycle?  I've got
a short series in that area, but there won't be much from me around
there - a plenty of tree-in-dcache stuff, quite a bit of mount-related
work, etc., but not a lot around the options-parsing machinery.

Christian, do you have any plans around that area?

