Return-Path: <linux-fsdevel+bounces-10735-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F47A84D963
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 05:34:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C16A11C24399
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 04:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2A867A1C;
	Thu,  8 Feb 2024 04:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PNuW4y3n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16A5679E4;
	Thu,  8 Feb 2024 04:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707366837; cv=none; b=ZMwvzCn03m17a3Tt+vp2ITxiq8p7rYW0bX/5Pc4RlA5sR7tu8o43NUpc80u6UzezbGLL5jIWaCj5hIYWc7tDMBWfLTFF77oLEM1hZl8w1sDM9+399ukwVf+8b2NMrmqBuswhmsezTPSKcrJARWf3N6RF7SCaiTZtweNNBCfqZyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707366837; c=relaxed/simple;
	bh=C7j0tAo/NFqY6hcIUhHuuq4BNMXR+xMhI1f048lYM3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hG2xo2wD5Fx3DgMRSZqFM4KZgq0FrH6RySsYeq1sbO6LX9COlwqLne6rlA1h7UQyoKijDIeqeFnLZ4qJdP4cK07EkPMMeFJFdeOmdwTi2Mwr1jCE8UhWMOc7j+9ZHjdKqosCv+lWg3UmjRcd4/LiK7W9ubAvC03w1pGPbtr2TKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PNuW4y3n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F5B0C433C7;
	Thu,  8 Feb 2024 04:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707366836;
	bh=C7j0tAo/NFqY6hcIUhHuuq4BNMXR+xMhI1f048lYM3w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PNuW4y3n7vxEL/aVwQa7NqH3jMfaa3e7Dbc6zjIgzS2BayymbNMfJl1oXl+3YkN4U
	 dZZRp+mz1u06SpERwRHfZgiavY78SDMUfrSBw47skVMox0TuR+OiWsdirk7TF+ctmS
	 pYRYwQXHZO3QpuC7CRauhCQ0o9aCaSJDS5W0TQ5SZcdyo48LAgMUkR5Ibgxj71DqAf
	 3WyPVbfUNa2Rb7NPEbdhAjPQWX2IXeqNmiCBNC0ryv90iV+svla21lLd8FNlYhAgT8
	 WLMF0xlxkJ+w8SYV2wBXwaOb1BborsqBD9IdWvIrQiyOrdXwytJNw7Vdn6C7SQSjt1
	 36o1Mv+nstsaw==
Date: Wed, 7 Feb 2024 20:33:54 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: wenyang.linux@foxmail.com
Cc: Christian Brauner <brauner@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] eventfd: strictly check the count parameter of
 eventfd_write to avoid inputting illegal strings
Message-ID: <20240208043354.GA85799@sol.localdomain>
References: <tencent_10AAA44731FFFA493F9F5501521F07DD4D0A@qq.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_10AAA44731FFFA493F9F5501521F07DD4D0A@qq.com>

On Wed, Feb 07, 2024 at 12:35:18AM +0800, wenyang.linux@foxmail.com wrote:
> By checking whether count is equal to sizeof(ucnt), such errors
> could be detected. It also follows the requirements of the manual.

Does it?  This is what the eventfd manual page says:

     A write(2) fails with the error EINVAL if the size of the supplied buffer
     is less than 8 bytes, or if an attempt is made to write the value
     0xffffffffffffffff.

So, *technically* it doesn't mention the behavior if the size is greater than 8
bytes.  But one might assume that such writes are accepted, since otherwise it
would have been mentioned that they're rejected, just like writes < 8 bytes.

If the validation is indeed going to be made more strict, the manual page will
need to be fixed alongside it.

- Eric

