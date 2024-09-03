Return-Path: <linux-fsdevel+bounces-28359-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44920969C2F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 13:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E74B11F24CC3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 11:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB361A42D1;
	Tue,  3 Sep 2024 11:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g9aekxIN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF1D19F422
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Sep 2024 11:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725363667; cv=none; b=dgpjz31SpAdFW9gHpMnBNgPk0KWMCqcGzacAO8whfvPwzWnuID8s8i3gZr+A0in9QC8nFXrEOjm6clIM8ytp8QDmo5ZjaW5z3f6Uuolp90fOon1Dp8RNRUPSdM7mkJqe3hwRkODuqU2/WDL251OrNtnpU8Fy2oQk7yCRumriA9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725363667; c=relaxed/simple;
	bh=FnNGbnPFqrqYnt32j99x3y4UkgPymQz7PPBh9apRHQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MTlFmutyuLF4ge4z7CKHqlhpwT8oGy2kpzlaoV7CdVKM6LRogAQRE2U+WTnY920x4Yv29FSpvpS7fBcfxn/p67h8+zF3eLnoUxKuR8wLQ7XUik5ep4cTtG3DQw/1QYHmUFsyag02TBJ3i2jm3PsxhXRqpaP4/5dG9QZ27AVARWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g9aekxIN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73724C4CEC5;
	Tue,  3 Sep 2024 11:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725363666;
	bh=FnNGbnPFqrqYnt32j99x3y4UkgPymQz7PPBh9apRHQ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g9aekxIN4awt1y+4hBCOLlJgEH/q8t0ArRWkDdWB+KUcUwil2Top0HsPaKLlnSPkz
	 w5YpJDoPGhbtl0kadjVLY/pweHV8wkkbwUHMQcwcsaJXX7rROiDPH0DTYiu9MeLXup
	 enD0szAY6X8QIUr5ssxORkjCVxZwoXtAUbudDsbDHd4RXSdtq0+1qtZJZ/tWJ8NIap
	 00YqyuSC7as72B4o4iNTXjYYskfEI5ZhcLqG7WUizky0/4UzqGiqlSo6OBxZTtCqlR
	 bZVaVeeKY2XbanB3qzRoJBHwZQLzqgyic9C2Vi3xMdXg+T6AET5+o7puipcmNGmY7T
	 B/X3VnDi1qxwA==
Date: Tue, 3 Sep 2024 13:41:01 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Jeff Layton <jlayton@kernel.org>, 
	Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH RFC 07/20] fs: use must_set_pos()
Message-ID: <20240903-hausrat-gesehen-a36e1e732903@brauner>
References: <20240830-vfs-file-f_version-v1-0-6d3e4816aa7b@kernel.org>
 <20240830-vfs-file-f_version-v1-7-6d3e4816aa7b@kernel.org>
 <20240903113010.atz4odkdmsl7oc2w@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240903113010.atz4odkdmsl7oc2w@quack3>

On Tue, Sep 03, 2024 at 01:30:10PM GMT, Jan Kara wrote:
> On Fri 30-08-24 15:04:48, Christian Brauner wrote:
> > Make generic_file_llseek_size() use must_set_pos(). We'll use
> > must_set_pos() in another helper in a minutes. Remove __maybe_unused
> > from must_set_pos() now that it's used.
> > 
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> 
> Frankly, it would have been a bit easier to review for me if 6 & 7 patches
> were together as one code refactoring patch...

Yeah, I had it that way but the resulting diff was really difficult to read.
I could've probably tried to use a different diff algorithm but this way
was easier.

> 
> > +		guard(spinlock)(&file->f_lock);
> 
> You really love guards, don't you? :) Frankly, in this case I don't see the

Yes. :)

> point and it makes my visual pattern matching fail but I guess I'll get
> used to it. Feel free to add:

I can remove it. I don't mind.

