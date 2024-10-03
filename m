Return-Path: <linux-fsdevel+bounces-30918-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD09898FB01
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 01:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F173282DE0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 23:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 138921D0B90;
	Thu,  3 Oct 2024 23:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="G+Is6r/5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5111CF5CE
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Oct 2024 23:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727999241; cv=none; b=j8MXIc8fe8z8PM0jSL8400WAQRyK0WQeAwf8ta64P4MQjPTAMZCxcfspTxcpA8CauNa80IUetR+V2bP3cE71dqzn20xBw7UrW8sg6qeacbckesB+sZV+h7o/kwjqS40WFaUM/KxcwQQYgceCpylQ0oLoV3nL6XFosarrYrfAGkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727999241; c=relaxed/simple;
	bh=z8BNxfcqgUtgoDbZRJvSP9+OZ7yJUjtWVBOa1iyv93E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jp1gBPkF5+2TZWMYK31ORQR68/lNVUKdkn2RKPZILrGIMHAf7RJVxlcSrbUKcHXre2mzAbwlq8Ehjr0Qte1UJ8vQp1p7Xq47rr97cwS08wX3JDTL81P4rjLvuwx4GgBtyDuCM1u7ZV9WYQD1v5AQQ4xD+tVhkvCRXAbR53JL1Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=G+Is6r/5; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=IC/i1h3zGaRR4N6kp/RpMriVh6//M9BYqpP3L5hObmc=; b=G+Is6r/5WdMMTfYazJx1DhVQy7
	StO9Nr0VMTSPHtz0Ro9Em1WwU822yprP8zjOdidNazphv2VyUzQ8gmmj1f1fJUmOpRndEgpcPrCey
	o83su4CEB3wb/Wieri1gJrN73ZCnI1qBgY52y+DO2AV6496ucYVQqY4GwBj7ptgWrV5e3RJhiaVRi
	Mppc3DzGruSnRsOj7VZxTxD2nm6TT53M7AsB5smciJVwPLdb1mbZUMAJ1828VZN/6MkpJ/F0Rp/xm
	FseOapjvfewVdjv10siGu1dbtrC0yGLt1U8IxFXIyaQ9LocyzjPctTyAucgSkisFVF7+RDGwBNOVd
	1Uc4hGMw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1swVXS-00000000cTL-1fUX;
	Thu, 03 Oct 2024 23:47:18 +0000
Date: Fri, 4 Oct 2024 00:47:18 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>,
	Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [RFC][PATCHES] struct fderr
Message-ID: <20241003234718.GA147780@ZenIV>
References: <20241003234534.GM4017910@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241003234534.GM4017910@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Oct 04, 2024 at 12:45:34AM +0100, Al Viro wrote:
> 	* s/FD_ERR/FDERR_ERR/, to have constructor names consistent

Grrr...  That would be s/ERR_FD/ERR_FDERR/, sorry

