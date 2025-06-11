Return-Path: <linux-fsdevel+bounces-51287-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 924ACAD5317
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 13:07:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F7091896943
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 11:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F8F2E402F;
	Wed, 11 Jun 2025 10:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XvtSYJ9Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABD82E4026;
	Wed, 11 Jun 2025 10:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749639091; cv=none; b=EGvO7loUWSJeaduysr9Ssu31En/UhG15IB9VIW/wV6fj2BYs4WhR9uHbcyemA/ryUHrgW0zNQu9VqzNQ+Tp98wu83XJvMkuLDG0eOwJP1R88Q04ahZoQaYBbtR5O+/2Ws9UOz/FmQXB6HUo1hFGy3mDKtcsVl1ga86LcPi9JXNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749639091; c=relaxed/simple;
	bh=ZYlnhqqM80K0aQrIUjsOlIiBgKKulsWPnzRUBsoBdjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tEy9gxd5AxgaJrBV3gNHrmgdrWGRiFmHVXdR0G32u+tujblzVFE9DCze3egbGynbSUIcyq2LgXj5O3CqkVr8rhcp0UenwwH4u/2nZVksh0eTeHLN/vz2L4xa/Kh0gEbA22PjcJiyr0T8SLVMLwTSG/Fo1AKAeNO8hPdrqFRl+6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XvtSYJ9Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB823C4CEF1;
	Wed, 11 Jun 2025 10:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749639091;
	bh=ZYlnhqqM80K0aQrIUjsOlIiBgKKulsWPnzRUBsoBdjs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XvtSYJ9QKmGQgwaeD76qWVF/4SFSE5uf7GCVofH0MTR6YQuUki1HYeeRwIgrUHVl/
	 +8Mvv8mh83aoHhKrxMUsX4V9dgtv1XrZxF5Lgn7X0eXMAd4van6hcQtjmk9hccTJti
	 K0RBm0T8XK4OvjaVrTqhEq5QgqrtgmaM/9MN1mGEBRARjTiOcDf20MuZSzZRS0HRlw
	 Y5CT/erXmWDHG/p3SScIhOAVnPLvPcLhdnNrIrTAi+pVXwDD0Uixhd8QJFogrJmrWJ
	 bC4hQht1i8h2b0g2dI5YdZCl+3hzqQ76qwypK1GK906LhDj2EcOS1SnyMcdw5Jk10C
	 1+L0Oj/YENcdQ==
Date: Wed, 11 Jun 2025 06:51:29 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
	linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 4/6] fs: introduce RWF_DIRECT to allow using O_DIRECT on
 a per-IO basis
Message-ID: <aElfscsgqhpoyMom@kernel.org>
References: <20250610205737.63343-1-snitzer@kernel.org>
 <20250610205737.63343-5-snitzer@kernel.org>
 <aEkpEXIpr8aYNZ4k@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEkpEXIpr8aYNZ4k@infradead.org>

On Tue, Jun 10, 2025 at 11:58:25PM -0700, Christoph Hellwig wrote:
> On Tue, Jun 10, 2025 at 04:57:35PM -0400, Mike Snitzer wrote:
> > Avoids the need to open code do_iter_readv_writev() purely to request
> > that a sync iocb make use of IOCB_DIRECT.
> > 
> > Care was taken to preserve the long-established value for IOCB_DIRECT
> > (1 << 17) when introducing RWF_DIRECT.
> 
> What is the problem with using vfs_iocb_iter_read instead of
> vfs_iter_read and passing the iocb directly?

Open to whatever.  I just didn't want to open code
do_iter_readv_writev() like my header said at the start.
 
Mike

