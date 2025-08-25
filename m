Return-Path: <linux-fsdevel+bounces-59083-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 377AEB342A6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 16:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21D4316A9DC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 14:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 053952E3B00;
	Mon, 25 Aug 2025 13:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tpCAUO/L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2897278170;
	Mon, 25 Aug 2025 13:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756130272; cv=none; b=OY4l7OfE5D7ffjxpKB95HBLa8tmG509rr0MDFXXqPEfDV6LPFUjBK0vP32OzAIkKjj2BUA+QUEVxfz1ptRcAJHQJem4m1V1W5g4LhfIyDCSfnAAmO15JpBMYUMI2I+4udYO8++/KmbEDAClAy94DTexcVB/sskf8GSXflelLZzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756130272; c=relaxed/simple;
	bh=RD7ZdQoGMjvaubPhFckIDse+M6IQ4kZ8VhNw/j4RLzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CieWb2eJVI1mQ1yrHqBBjU4Nr2rFJytgzkSvK0jsSheXkJhdpw65iY6074csIw8EJ67WVUXBmlkFVZOLyQoFFhsFcxh3Q7dFzXLnaUt19iSC9L2dGglRWktejqlm6iPShR4zgGU6R0JaJ3P+ajBjpTubUye/QwmjeKXBu2f+5hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tpCAUO/L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC3DCC4CEED;
	Mon, 25 Aug 2025 13:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756130272;
	bh=RD7ZdQoGMjvaubPhFckIDse+M6IQ4kZ8VhNw/j4RLzA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tpCAUO/Llr8Fk7D6kmi1YLLsE7fupabtAgCnW4HS6JjV7vqpYaAaaE08fe4/iIw11
	 7h4bNY2TNBmVfO56tX+AZ1Bv/V7p/cWpBbq1AbP95DLD3VFrqRrrAbi1we1BtZk/Cs
	 sqLuc26/H1aXU2hTWWsRym99+YsdRZny+U6zGZ4pM4wejbjoJ1dUDcMq/vZpcQV44a
	 Fy66zEbkb/1a7g6Cc47+J1FszuB+YvgFyoZQRB0DKkjWjJV7o2yCNTF0uCS6Pib/Ii
	 oFlQ62sJ3IICQuYdfZ407lQTSRE71kwK9DKhK8Q2UMcH79zB0F9HwD8zGer8P1QkPf
	 JsS3YhDyGI0Kw==
Date: Mon, 25 Aug 2025 07:57:49 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	snitzer@kernel.org, axboe@kernel.dk, dw@davidwei.uk,
	brauner@kernel.org, martin.petersen@oracle.com, djwong@kernel.org,
	linux-xfs@vger.kernel.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCHv3 3/8] block: align the bio after building it
Message-ID: <aKxr3a74EjiyEUUA@kbusch-mbp>
References: <20250819164922.640964-1-kbusch@meta.com>
 <20250819164922.640964-4-kbusch@meta.com>
 <20250825074606.GE20853@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825074606.GE20853@lst.de>

On Mon, Aug 25, 2025 at 09:46:06AM +0200, Christoph Hellwig wrote:
> On Tue, Aug 19, 2025 at 09:49:17AM -0700, Keith Busch wrote:
> > +
> > +	if (!bio->bi_iter.bi_size)
> > +		return -EFAULT;
> 
> And as bi_size doesn't change in the loop, this should probably move
> above the loop.

The loop also releases pinned pages if necessary. We can't count on the
caller to do that if we return error here.  __blkdev_direct_IO is the
only one that tries to release pages on error, everyone else would leak
them.

