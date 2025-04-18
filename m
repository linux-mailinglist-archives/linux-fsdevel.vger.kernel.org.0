Return-Path: <linux-fsdevel+bounces-46690-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 055DBA93C6E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Apr 2025 19:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E81A8E4881
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Apr 2025 17:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2532A21C9F3;
	Fri, 18 Apr 2025 17:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZTQ3h83o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D36221C18A;
	Fri, 18 Apr 2025 17:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744998988; cv=none; b=F1fCDQszcGF9QUixlGNsOGivH8L6/un5hFLvt2goQgJec/VJDmaY8p/6hAqa4XU1TIlSQys0U9u6VsgwrwdMJ/iCwhBkpkns4zPfIeP2zWS2/eLR+0khrbDFd5JNxFW5zGjt9lrLP/aURYE8bdz0eidi/QmkfkcfYBdY5oS2aC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744998988; c=relaxed/simple;
	bh=bzCLUCLIl/PvkSuBnY0nnpMG9lfSWc3C832Ri1Vg/uU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iluNTHVPGs5iCDnFbgQSDiGN8jSkQkk0w4XDd400Ko/wHlb29mn93zVYj602iFmcTuZPfjTJ1G8o/K/yasCE3cTsvodzFWPlleId/vGlM/BWJJ6nhk5I47zdnHojDu+QffhSABZ+P3A+N6aO0vqNq2MmZLlh12TfZzaJDjj+4dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZTQ3h83o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B06C3C4CEE2;
	Fri, 18 Apr 2025 17:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744998987;
	bh=bzCLUCLIl/PvkSuBnY0nnpMG9lfSWc3C832Ri1Vg/uU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZTQ3h83oDe0zwY+qGu5pqZDrh7DwPzF6EI89tFw74clqZ8tboQn74yk4qrbbejlwg
	 +sen+aced1PhYJli0iJ57MV+MQFY27AAAe3RlxoT0ngwKVP8pPY+gxD+KoGQ6R6VMO
	 Sz3FxZOVpEdNn8ah2tg9FirFbrS7WTeqYTN7ww1PsILxS08H6k511wEwLTZBMa37xi
	 bp/Tg2nd0AJMZJR9Ayj91FZ0ArYF27wdI8YuB7SlEQDzKlAIau46Js/n7BQWwdHDdB
	 b/k47oo7WGOLu2VoBQWM2JEJpOnrigsxMN99JU7sFkbxgqaFEP06UIets4gJZqy9So
	 JXmP5hWbpV8zw==
Date: Fri, 18 Apr 2025 10:56:26 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Carlos Maiolino <cem@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@infradead.org>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Matthew Wilcox <willy@infradead.org>,
	linux-block <linux-block@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	xfs <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH 2/2] xfs: stop using set_blocksize
Message-ID: <aAKSSnYnC3jn-cwz@bombadil.infradead.org>
References: <20250418155458.GR25675@frogsfrogsfrogs>
 <20250418155804.GS25675@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250418155804.GS25675@frogsfrogsfrogs>

On Fri, Apr 18, 2025 at 08:58:04AM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> XFS has its own buffer cache for metadata that uses submit_bio, which
> means that it no longer uses the block device pagecache for anything.
> Create a more lightweight helper that runs the blocksize checks and
> flushes dirty data and use that instead.  No more truncating the
> pagecache because why would XFS care?
> 
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>

Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis

