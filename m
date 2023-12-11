Return-Path: <linux-fsdevel+bounces-5512-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DEBC280CFB4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 16:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2EF0B2148B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Dec 2023 15:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C9B4BA8B;
	Mon, 11 Dec 2023 15:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RGlrXRHH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7D04B5BC;
	Mon, 11 Dec 2023 15:36:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E5FAC433C7;
	Mon, 11 Dec 2023 15:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702308983;
	bh=1KvwnOdKn846sf3NBCoHv3K2XeZjYpErYFAYjSoZsuI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RGlrXRHHFeOBWA4wq1r4umoZLQo088nLaUT2d4ZwZMhGf2qAE9mT2Oi0qU63jbd3o
	 XSuRRDg6bJTDWWPj1WPh8QWw0nRaZblP0OxvwwwQsUa1SoaX0ttlI6pK7cgFLIFFUr
	 J00m7LXOZcAyUwmKQGOIRvnpSX6rYOy/CElyn6qmE3RxM14xisAtYWuR4NJwf6SVzI
	 ktv4NZYqVcTFwufwU5qp1tVsp/gDZK0yAXIDmQeV/b9t+szXNlVxIbo3/MaoN93SlN
	 49xRWHkVl7F3oSqllXIGPGqcWMar8akdbOCzFphHB8PYVIPrFurZO1VeH3cHsCo1Y9
	 Mx6PjjtXlTMfA==
Date: Mon, 11 Dec 2023 09:36:21 -0600
From: Seth Forshee <sforshee@kernel.org>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>, miklos@szeredi.hu,
	linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	zohar@linux.ibm.com, paul@paul-moore.com, stefanb@linux.ibm.com,
	jlayton@kernel.org, linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Roberto Sassu <roberto.sassu@huawei.com>
Subject: Re: [RFC][PATCH] overlayfs: Redirect xattr ops on security.evm to
 security.evm_overlayfs
Message-ID: <ZXcsdf6BzszwZc9h@do-x1extreme>
References: <20231208172308.2876481-1-roberto.sassu@huaweicloud.com>
 <CAOQ4uxivpZ+u0A5kE962XST37-ey2Tv9EtddnZQhk3ohRkcQTw@mail.gmail.com>
 <20231208-tauziehen-zerfetzt-026e7ee800a0@brauner>
 <c95b24f27021052209ec6911d2b7e7b20e410f43.camel@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c95b24f27021052209ec6911d2b7e7b20e410f43.camel@huaweicloud.com>

On Mon, Dec 11, 2023 at 03:56:06PM +0100, Roberto Sassu wrote:
> Ok, I will try.
> 
> I explain first how EVM works in general, and then why EVM does not
> work with overlayfs.
> 
> EVM gets called before there is a set/removexattr operation, and after,
> if that operation is successful. Before the set/removexattr operation
> EVM calculates the HMAC on current inode metadata (i_ino, i_generation,
> i_uid, i_gid, i_mode, POSIX ACLs, protected xattrs). Finally, it
> compares the calculated HMAC with the one in security.evm.
> 
> If the verification and the set/removexattr operation are successful,
> EVM calculates again the HMAC (in the post hooks) based on the updated
> inode metadata, and sets security.evm with the new HMAC.
> 
> The problem is the combination of: overlayfs inodes have different
> metadata than the lower/upper inodes; overlayfs calls the VFS to
> set/remove xattrs.

I don't know all of the inner workings of overlayfs in detail, but is it
not true that whatever metadata an overlayfs mount presents for a given
inode is stored in the lower and/or upper filesystem inodes? If the
metadata for those inodes is verified with EVM, why is it also necessary
to verify the metadata at the overlayfs level? If some overlayfs
metadata is currently omitted from the checks on the lower/upper inodes,
is there any reason EVM couldn't start including that its checksums?
Granted that there could be some backwards compatibility issues, but
maybe inclusion of the overlayfs metadata could be opt-in.

Thanks,
Seth

