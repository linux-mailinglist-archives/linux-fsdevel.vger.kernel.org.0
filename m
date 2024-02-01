Return-Path: <linux-fsdevel+bounces-9879-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 036A9845A97
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 15:49:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC9571F2AF63
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 14:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823FD5F49D;
	Thu,  1 Feb 2024 14:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QdbaEhUm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F875F483;
	Thu,  1 Feb 2024 14:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706798945; cv=none; b=SVLWsLjCL9coN7XhwKmAUVGP/lR2+0yTmgkVdCufPY4dDfQOEU5W2IAmRMRFYRQfaFukCjJHljxuefD66rg7rUK05fzX+wIQaBtVnM1g5K8k9OBwM2KGdDC6lGhyge6VwHhvxym0sZaQApomy8r9rL4+FVo+wPCTWAXUG4FIEgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706798945; c=relaxed/simple;
	bh=r4NsFhRY2AljvQwz6cHeKQhY5odIqHrtJruSfr4qmZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=bQyWAbK4JW7DCy8+7rctNF0tgGoTUL9gNaTipjsjc0rMPULG9Y3ZXrmT9wGAUS9CQqLvKXyv9wX3ZH3M1ZeUvuOFf0RL1QvKtHhEravs8kyE/JK1v3nThk3Px/uumXN8DCvoP5KBOQSpWXZvasgOhHrAdA9MoPQF785Mo1Xbcec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QdbaEhUm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94ACFC43390;
	Thu,  1 Feb 2024 14:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706798944;
	bh=r4NsFhRY2AljvQwz6cHeKQhY5odIqHrtJruSfr4qmZ4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=QdbaEhUmHvyvtW8BLgElIROAlAeVVmx/li1VUkK7Y8+g7/iRUG0o0fDyoz3+BQXvB
	 ymFMW2MBPSJehyIeQmx6zh0AoNkI60eGnFeJkMqqkzvXcwmglVwBZ3DI67Ao9h6ZEp
	 NDOKiHUa63NSq/6TTzCTunMsBvlI4HYaxBaOt9oUQlqTE04/lYZBHKjEa8fmR4aip5
	 y6gAQ/bHHwxiLZkVO74nrPHCkKCxeeeuCk+FzV00K0yx1X0ZnvJCIURXx5ucEcJ9pB
	 Z7PoFUHyXGNrPdXmfgMYJc3cKIXj4iXzSDX3qzh8FWMXAGQQcvFLDJFz2VNrGaN6eV
	 9cWFSR93Q3J3w==
Date: Thu, 1 Feb 2024 15:48:59 +0100
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>
Cc: Jens Axboe <axboe@kernel.dk>, "Darrick J. Wong" <djwong@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 28/34] bdev: make bdev_release() private to block layer
Message-ID: <20240201-aufladen-richten-2cbfca888b89@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240129161933.GH3416@lst.de>
 <20240201102616.kzuflhvyck7xtmc7@quack3>

On Mon, Jan 29, 2024 at 05:19:33PM +0100, Christoph Hellwig wrote:
> On Tue, Jan 23, 2024 at 02:26:45PM +0100, Christian Brauner wrote:
> > and move both of them to the private block header. There's no caller in
> > the tree anymore that uses them directly.
> 
> the subject only takes about a single helper, but then the commit
> message mentions "both".  Seems like the subject is missing a
> "bdev_open_by_dev and".

On Thu, Feb 01, 2024 at 11:26:16AM +0100, Jan Kara wrote:
> On Tue 23-01-24 14:26:45, Christian Brauner wrote:
> > and move both of them to the private block header. There's no caller in
> > the tree anymore that uses them directly.
> > 
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> 
> As Christoph noticed, the changelog needs a bit of work but otherwise feel

Fixed, thanks!

