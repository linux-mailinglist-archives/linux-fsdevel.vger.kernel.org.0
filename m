Return-Path: <linux-fsdevel+bounces-32512-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D22E09A70A6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 19:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88A151F22CC6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 17:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EBD35FEE4;
	Mon, 21 Oct 2024 17:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="DLYdjG4+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9A4198E71
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Oct 2024 17:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729530554; cv=none; b=BM7f4gebcB92z2mMqO0Tr5fPFBWqw9YnatbPPBesBRhVl3XEVZw0tTl0arVZjn0LvclUXUACDhhVunR3iAOJSme+0ks+S/MMasuqvbMQUxWFQFqMLOZyvT5ZcWs4i2k6cn8TGWzjQO6xPJWC4wsi+gHhjX8Unh/0qJJjsZB2ZyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729530554; c=relaxed/simple;
	bh=FRWL5JXpV4zfwG1gF7bfiCjBTHuTfrz71RHd5XquAj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AOLUos+pcZ3skX0Tc/YlpZhyYhqC6hLmEJsnVZqG9Yxc90DlqZ3iOtzQaTxXOVze7FGd/LuuWFKiVUSqdCiZXgYrFetrV3AQn22HyovxefnEiUFCvC8s1GoV+ljdYUayoQfllusHwwyCV3nqCTSZf7KMJRR2FjkMfbBgNRk+oTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=DLYdjG4+; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=gxPYPFhGgg5MMnLIKHKGds1rrRa1DizMYClMdtZfFqE=; b=DLYdjG4+vf/iDO40vurzgIWnTN
	+kigiQXzPINVZuXYEr+RT1ir6XgzS8aI3SgNCEGLv8J9jCVE2rwgScHKdv/lW21P44MhIhZuClwo+
	/MCHbwkpcOY8JYpSwoBGfnNJpzjgc+Ix7Cx0dDkVMqlXP/GPM875JNq0cB+rSeBYxIf84WfNXVqJd
	QFNtwwMo3vlD1YBaoi1QUOMpoLz6pP1Uv1xD9Z29LkndHB505VmJcQVJghIEQdfdnGMVwGj8y9AcF
	VI7ZOrbZToZA3171jzxHLxabTB0id5n/326V+el5iT9ObtF14HFEMpynqkjhBTbmjpHXUK6J/tszT
	8xQn48Bw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t2vu2-00000005yVr-3c4x;
	Mon, 21 Oct 2024 17:09:10 +0000
Date: Mon, 21 Oct 2024 18:09:10 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC][PATCH] getname_maybe_null() - the third variant of
 pathname copy-in
Message-ID: <20241021170910.GB1350452@ZenIV>
References: <20241016050908.GH4017910@ZenIV>
 <20241016-reingehen-glanz-809bd92bf4ab@brauner>
 <20241016140050.GI4017910@ZenIV>
 <20241016-rennen-zeugnis-4ffec497aae7@brauner>
 <20241017235459.GN4017910@ZenIV>
 <20241018-stadien-einweichen-32632029871a@brauner>
 <20241018165158.GA1172273@ZenIV>
 <20241018193822.GB1172273@ZenIV>
 <20241019050322.GD1172273@ZenIV>
 <20241021-stornieren-knarren-df4ad3f4d7f5@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021-stornieren-knarren-df4ad3f4d7f5@brauner>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Oct 21, 2024 at 02:39:58PM +0200, Christian Brauner wrote:

> > See #getname.fixup; on top of #base.getname and IMO worth folding into it.
> 
> Yes, please fold so I can rebase my series on top of it.

OK...  What I have is #base.getname-fixed, with two commits - trivial
"teach filename_lookup() to accept NULL" and introducing getname_maybe_null(),
with fix folded in.

#work.xattr2 and #work.statx2 are on top of that.

