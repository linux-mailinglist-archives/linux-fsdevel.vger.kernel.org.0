Return-Path: <linux-fsdevel+bounces-35714-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4989D773B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 19:19:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E21A282D0D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 18:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E151213A86C;
	Sun, 24 Nov 2024 18:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="LFt4gkS4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2308472;
	Sun, 24 Nov 2024 18:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732472355; cv=none; b=UaRUpWipUnxZUS8y/VUFHi9Jge3Zt+fiddNCvAO7psHlPKSHfXzulWccoaco1u5cLeMSbaJL4dHWIt0u0kM6doSHb20AXKMXfLttUdIaDzjmOLi5Lg9EoYUep48N8uSVTIKe0aUdsE8UL/dAQSBab7ED5oTTOtikbBzbLQ0nPpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732472355; c=relaxed/simple;
	bh=NrWBE+eVf6/bQnfDOwbINHP5NuRpko5suWSXSRKyxCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fEQbYLMuFC76cD47dxLho6b+LSP+EACPcfTVdDfh9c2HYpAPwu+4wl0zZq4brLEXCKaeirVGQKpDhsG2l7ai6rdFMddORNTsQpa9kXyrC2HnyexUEv7Oq/rWsdpwsl48T5oWQS+zGeMlS2+EbWccbWCNdNtqIkT+aU+7PNceElY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=LFt4gkS4; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=IvgTirpIcd/X+b0JRn0paS0cOSU5p0DJfQ0sxfqmEKU=; b=LFt4gkS4h0Gq2Eh3XpPrFiU279
	MWwgzIJIbodTf3CsbMNQ4SxkdExvQAXkV2xMP/XsqtmdPXxZuRaKCJiz9kksAx2IXsaSJWo4y3wgw
	dl/+JzXh+oH8j18vL+udYm7G0hpI/hd10VlOrbMkUeAqlKco7sciKqkEMjm2MVt1263TVXc0iemg1
	f5ow3WG6piB2SN+PGKYIEAKuesB9aSndf51A15Ls9hCSM8dUnT0fcHXAFcZRtmLsWIvAutG8o6gQe
	jXxNiRfczq9eMt18ofr+LVtNXv63qHFWelWlXAWK1K9gWcqKqDyFXslQxNQYvWlvrEiy8L3p5fWGR
	Fhmcmb1Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tFHCO-00000001HYh-44eI;
	Sun, 24 Nov 2024 18:19:09 +0000
Date: Sun, 24 Nov 2024 18:19:08 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 08/26] sev-dev: avoid pointless cred reference count bump
Message-ID: <20241124181908.GV3387508@ZenIV>
References: <20241124-work-cred-v1-0-f352241c3970@kernel.org>
 <20241124-work-cred-v1-8-f352241c3970@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241124-work-cred-v1-8-f352241c3970@kernel.org>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sun, Nov 24, 2024 at 02:43:54PM +0100, Christian Brauner wrote:

>  drivers/crypto/ccp/sev-dev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
> index 187c34b02442dd50640f88713bc5f6f88a1990f4..2e87ca0e292a1c1706a8e878285159b481b68a6f 100644
> --- a/drivers/crypto/ccp/sev-dev.c
> +++ b/drivers/crypto/ccp/sev-dev.c
> @@ -244,7 +244,7 @@ static struct file *open_file_as_root(const char *filename, int flags, umode_t m
>  	if (!cred)
>  		return ERR_PTR(-ENOMEM);
>  	cred->fsuid = GLOBAL_ROOT_UID;
> -	old_cred = override_creds(get_new_cred(cred));
> +	old_cred = override_creds(cred);
>  
>  	fp = file_open_root(&root, filename, flags, mode);
>  	path_put(&root);

Looks sane, but the use of file reads/writes in there does not.

At the very least, this
        nwrite = kernel_write(fp, sev_init_ex_buffer, NV_LENGTH, &offset);
        vfs_fsync(fp, 0);
        filp_close(fp, NULL);

        if (nwrite != NV_LENGTH) {
                dev_err(sev->dev,
                        "SEV: failed to write %u bytes to non volatile memory area, ret %ld\n",
                        NV_LENGTH, nwrite);
                return -EIO;
        }
is either too much or too little - if it's serious about reporting errors,
it would better check what fsync and close return...

Oh, well - unrelated to your patchset, obviously

