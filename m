Return-Path: <linux-fsdevel+bounces-67315-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 04B64C3B823
	for <lists+linux-fsdevel@lfdr.de>; Thu, 06 Nov 2025 14:59:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A71404FCE73
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Nov 2025 13:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5DFC332904;
	Thu,  6 Nov 2025 13:52:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725C9303CB4;
	Thu,  6 Nov 2025 13:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762437145; cv=none; b=toOJifeStrlwgFOPtljAd7DR7aWJkcz20IEhcoGi8TMnTACFtrN6OlY5EMZaMdILJ7skJkTr03+ksC4Jk1pKF+VTfsubiwp/ihrYdogW9hP04F19WeQ7BnUXYlX54/PoaS7tEhhvwsVW4r9dnta9BKtmB2bV3f1ZpP5GJj54kIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762437145; c=relaxed/simple;
	bh=oWDHkFTVXZZsXOi4gtkmtUtQVoQsLeLNoQFUWNDUZ5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WT7a7Ex/RU258HuaI5hQs34F1TFv57LL/IcNPGeZzGBwdxJDvoRvgcQo2tm268W+6qXL1kiNLsJfNDCcipC/gPZ9n7d3hRt9A4p5ZUHfGpQLgCYlHBzAnL6QRNAlTtYCYTngY8zg86N72ZrUMpEy8cndDq/vCOxScOratXeTPTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 13794227A87; Thu,  6 Nov 2025 14:52:13 +0100 (CET)
Date: Thu, 6 Nov 2025 14:52:12 +0100
From: Christoph Hellwig <hch@lst.de>
To: Florian Weimer <fweimer@redhat.com>
Cc: Hans Holmberg <hans.holmberg@wdc.com>, linux-xfs@vger.kernel.org,
	Carlos Maiolino <cem@kernel.org>,
	Dave Chinner <david@fromorbit.com>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, libc-alpha@sourceware.org
Subject: Re: [RFC] xfs: fake fallocate success for always CoW inodes
Message-ID: <20251106135212.GA10477@lst.de>
References: <20251106133530.12927-1-hans.holmberg@wdc.com> <lhuikfngtlv.fsf@oldenburg.str.redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <lhuikfngtlv.fsf@oldenburg.str.redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Nov 06, 2025 at 02:48:12PM +0100, Florian Weimer wrote:
> * Hans Holmberg:
> 
> > We don't support preallocations for CoW inodes and we currently fail
> > with -EOPNOTSUPP, but this causes an issue for users of glibc's
> > posix_fallocate[1]. If fallocate fails, posix_fallocate falls back on
> > writing actual data into the range to try to allocate blocks that way.
> > That does not actually gurantee anything for CoW inodes however as we
> > write out of place.
> 
> Why doesn't fallocate trigger the copy instead?  Isn't this what the
> user is requesting?

What copy?


