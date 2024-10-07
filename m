Return-Path: <linux-fsdevel+bounces-31196-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C91D992FAD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 16:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89F17B23869
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Oct 2024 14:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 301BE1D5AC4;
	Mon,  7 Oct 2024 14:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="XIIXGWix"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2CEF50F;
	Mon,  7 Oct 2024 14:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728312222; cv=none; b=qD919Hq61P9yn6sW5hYNa5mVpyDh2HZIeD6z2XK+dKiHFixsZLOlfkFUqQ8Mn/opdp+NJrtWNX3Ut4JeVgZ4gH+gbKK88FGpabG/lKxYmuTSElIC0e4Lgf8v1pczyDWllxACZLCXJm+UynCofjyzZObmgmmfQlGNKle/Wn75oK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728312222; c=relaxed/simple;
	bh=N4M+eOWjETNZOERVPoielTQsnFZYpl3pg8Ctrd6vcMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aaPws0Nwnf5rZnXecsaEEovRMCrqSnb+Y4GaVoaIy4O4lAjEfBD3Sfc4gP+ypAtHQf4GfViKerqQQz9DrlPu/nmzn93zjFyDtsUPcdh7YRNjYyr26mOzVQgqIlGIuDouTXzatQddP9GYa3vD6YQVWB7l+vbp2z3/S9gvBFWWDZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=XIIXGWix; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=U0jFlQkRXHusmXDOUz3TxSVIDGrlyzNd3JHUTkolowg=; b=XIIXGWixP1+JQD4av6H2emc5OO
	UB22cntWJ8Aiq6TSDPdaMo6wjnN8MQZPNJpC2fL/ZLgMueU6m4ZnngLz1HwKa99E3WElrv26Aaaow
	JwQ1W/ZjuzOPR7LbJKD8rjLD0xw/OCDM+IJjj93XalpFBToiMXRNN9elHSrkAP0CJdGhOkRDQlZHK
	myxCCNUr97T9eUx0VWhp31+sPM0DUITSK+HKi/CHkaVow4gvNkSh3PnRAVtNmUIYgCnKX+2xjkip8
	BJePhfYjWSMnqg60qVmT3Ci7gEgRH3d5jMBSgH/Ge2x3eBhjcCt2IBg69lK7HQ5Agz5OCcrw/O1Tl
	lIEJjBWg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sxoxW-00000001c8w-2zPe;
	Mon, 07 Oct 2024 14:43:38 +0000
Date: Mon, 7 Oct 2024 15:43:38 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: Re: [PATCH v3 2/5] ovl: allocate a container struct ovl_file for ovl
 private context
Message-ID: <20241007144338.GL4017910@ZenIV>
References: <20241007141925.327055-1-amir73il@gmail.com>
 <20241007141925.327055-3-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007141925.327055-3-amir73il@gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Oct 07, 2024 at 04:19:22PM +0200, Amir Goldstein wrote:
> Instead of using ->private_data to point at realfile directly, so
> that we can add more context per ovl open file.

Hmm...  That'll cost you an extra deref to get to underlying file.
Cache footprint might get unpleasant...

