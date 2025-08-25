Return-Path: <linux-fsdevel+bounces-59013-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 427CDB33E95
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 14:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB9AC1A826B1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 12:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D7A26B771;
	Mon, 25 Aug 2025 12:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G4ftXcAQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1FC22A4E5;
	Mon, 25 Aug 2025 12:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756123273; cv=none; b=Z9kl+ToG4Fovgoq+pdYGIV0HcjWJeTwUCme0RBu1FxQ5UWW/QX6hXKuigpOIQfRUuWz6xGefIYzqSmif1TT/9PdoIAI4a4sY9ysacOgNHqPz8wbZi+fDvPFskjiIH6yl9EpyTn7MCe6jVA1gZOEnTAC/irOgs/dZBhE3+act1nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756123273; c=relaxed/simple;
	bh=coPKTGDhD+vmF6gBi7FlpvcCk8kMW+tsVWXxq4ug5/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=drG2adxa+G5WeAVKYEybwjJeKorKIRxbuKmS9khK667YVfUl+Pf27Rlfn/QXaenehmJqA1OZdnW9l0n/5rsF/AvqCidVEVHDiTFyC2YxH78g5lNH5FL7kplDYgDcH+2hy/jzFm0GqOdFUpe4ov/L2tiCeRVdCjz1btamaJrnMww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G4ftXcAQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB09EC116D0;
	Mon, 25 Aug 2025 12:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756123271;
	bh=coPKTGDhD+vmF6gBi7FlpvcCk8kMW+tsVWXxq4ug5/0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G4ftXcAQj9nVXAhf53Q4/KaXLmbbkd7sTsZiuId2nskg7EGyKX5EeZxBxu04q9ZnP
	 x49RdbEsxMoEPmYOF/41EXhjo52rgow5IFG/wHk1V+OzXvHRfzzRdlvMR/AAABddfr
	 qRNJp25k9eH/szL9bTKY8NbzYAH8fsfcdMF48jq8Y/cy8KIhGHpsylEm6JKimrcIB7
	 iOMTeLx94sBDeMRInCJHOCQA/9MXcjS6mWoAVVTDah/yuzN4QDcvAQL1SIHqDrkqeQ
	 AExoalx0xkabeQ39PpoG1gahqDN/vWYKnxC6oewQndNk31SCFRmAVb2xnhQ8PMr1aM
	 9cPLcBOMv7nmQ==
Date: Mon, 25 Aug 2025 14:01:07 +0200
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Anuj Gupta <anuj20.g@samsung.com>, 
	Kanchan Joshi <joshi.k@samsung.com>, linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	io-uring@vger.kernel.org
Subject: Re: [PATCH 1/2] fs: add a FMODE_ flag to indicate IOCB_HAS_METADATA
 availability
Message-ID: <20250825-randbemerkung-machbar-ae3dde406069@brauner>
References: <20250819082517.2038819-1-hch@lst.de>
 <20250819082517.2038819-2-hch@lst.de>
 <20250819-erwirbt-freischaffend-e3d3c1e8967a@brauner>
 <20250819092219.GA6234@lst.de>
 <20250819-verrichten-bagger-d139351bb033@brauner>
 <20250819133447.GA16775@lst.de>
 <20250820-voruntersuchung-fehlzeiten-4dcf7e45c29f@brauner>
 <20250821084213.GA29944@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250821084213.GA29944@lst.de>

On Thu, Aug 21, 2025 at 10:42:13AM +0200, Christoph Hellwig wrote:
> On Wed, Aug 20, 2025 at 11:40:36AM +0200, Christian Brauner wrote:
> > I meant something like this which should effectively be the same thing
> > just that we move the burden of having to use two bits completely into
> > file->f_iocb_flags instead of wasting a file->f_mode bit:
> 
> Yeah, that could work.  But I think the double use of f_iocb_flags is
> a bit confusing.  Another option at least for this case would be to
> have a FOP_ flag, and then check inside the operation if it is supported
> for this particular instance.

Do you want to try something like that? Maybe we can do this for other
FMODE_*-based IOCB_* opt{in,outs}?

