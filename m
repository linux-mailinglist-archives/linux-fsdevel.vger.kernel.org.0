Return-Path: <linux-fsdevel+bounces-14395-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E1D87BBBC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Mar 2024 12:11:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 562D21F23777
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Mar 2024 11:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B0DD6EB5F;
	Thu, 14 Mar 2024 11:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pJTKZ5Cl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE0D6EB51;
	Thu, 14 Mar 2024 11:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710414664; cv=none; b=LfC7Ziffz1OD+20COwsnL3bJZzaJjxrihvn47AmylBBCZGzJMkXsa2vHPLlG76eWhfma1PMWdTNwUNqyjnqYax5aaj++lpggnGodbnRjgA9gXNywiB2FN2KvzCi5oxrZxEpHcPwNBHO0Z7j9dMU17Tsaln4IVJ2FLbJLXcGka6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710414664; c=relaxed/simple;
	bh=TirVO2LNzRlKsBSXnVkqpo51XXbVMdfWDMgCtdL1+r4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mfcdIKLs20/bxUqsS1+5eAhJy7psuLs01uA2CBW+hOF4SPvVG+RXiGYhiXmvByHclSYFIgq04HROzK+Kr3soyyrczq24IbV66tF7hM724ZliW20yEAdIn16Kq+JAQV8MSL7R3RVFjEcYzdIt6u3wxyv8jWXSy76gy9CG+EJIdw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pJTKZ5Cl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CEE3C433C7;
	Thu, 14 Mar 2024 11:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710414664;
	bh=TirVO2LNzRlKsBSXnVkqpo51XXbVMdfWDMgCtdL1+r4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pJTKZ5Cl2yYSVKcaYqA86YnzPhee18t75rgAkG6l1SyvF6E1ktbWoAgZSnRltDBGj
	 WEBcgtt72XH4kXLHnWOHZub5bEPD68pBIEVul0NbMPJsjbbMrtVo+xym4Q9M3Z2lvj
	 yu2Hwh4WxdTr55s47Bp6y8vbR1I8exaBc/DEVA/742X9xJsgNBZH5IQyIciPfZ4VUt
	 W5jSq3V8GiDquwVhRMLxXhFq2ENSnOUyfX4IxPKtENzme5PcQxYxc9hl+Jd3lHr4iv
	 15MyvRw9Ut7U5jLJutg2YHGURf1glfxF/7HvPLolmHFDjFHrwoCnWmzownsNnFHX6O
	 8HbWtYlvvNp4w==
Date: Thu, 14 Mar 2024 12:10:59 +0100
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
	Jens Axboe <axboe@kernel.dk>, "Darrick J. Wong" <djwong@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 01/34] bdev: open block device as files
Message-ID: <20240314-anfassen-teilnahm-20890c4a22c3@brauner>
References: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org>
 <20240123-vfs-bdev-file-v2-1-adbd023e19cc@kernel.org>
 <ZfEQQ9jZZVes0WCZ@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZfEQQ9jZZVes0WCZ@infradead.org>

On Tue, Mar 12, 2024 at 07:32:35PM -0700, Christoph Hellwig wrote:
> Now that this is in mainline it seems to cause blktests to crash
> nbd/003 with a rather non-obvious oops for me:

Ok, will be looking into that next.

