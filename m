Return-Path: <linux-fsdevel+bounces-56718-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 76625B1AD7C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 07:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D672B7AA889
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 05:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6109C2135D1;
	Tue,  5 Aug 2025 05:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="vcUc10On"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF092AD0B;
	Tue,  5 Aug 2025 05:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754370496; cv=none; b=XtjNpWIj9Au4uLIsceLcRLCUrxOBHFcH53z2NFdidLm5aNz8snqd2bJXTWVzUayn588YTrj2RAXG7QbQo2hZ7mjDXZ5CIIJLgezYbX0GwvUvAGRo06m0YrGr/h3nrHYIkQy7zDNnUAN9sTNwABb2lC7KswYLSqLo8Gy4N/AGb20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754370496; c=relaxed/simple;
	bh=BJsYSkptW/Gg0j+GjEzbmB5TlwxyI1N0SYcghDZO9HU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iputEOgK6tKOilffj2sWtzXGip9k2C6Q8R/krr20OzRbKdhWFzVgTgrTDCpDBuuPtO0BvfIpGDmSSpJUsXz9durvR8n9epLppGQiQvAGdPFU5LoFEGArhP6qslhl32qwVRt6azj2e/feLGxXBESYUA6zQUcEeS935BYU2IVlRAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=vcUc10On; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
	bh=ly6DSdUr2XbxUhMhtav5my3WakhtZnB56NBTKhEPeCM=; b=vcUc10OnYD2Riy40ESV/uGoLxI
	Il4eRKfMWEvKa/ujC2PPuZcXvE4wyNLMmiRogn6UJPyYcG1DWBezUBPs6fzwRdfRTHmTRuqxNL4nm
	viOW1systuSjbJYKYLUHlJ9A1K0hahi8cB749ZIDWa89m2k9Wa12urbOWGaWJ2wvb2B14kljHYL8P
	v3ay+FX+5QOqsyQMJO6r2lZed33gURFTwt8N0QxTDNGWC6OQ40QunsOBf59mks7AjxSFOeKYc4WAC
	wG2DJK0qdx7TK3vnkygovoD6eeP8pp1CgtOifKqs+WDaAfAtAZ+w7y37KPrd/paoBmKQ+I9t1CXOr
	Yf9IFTvQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uj9uD-0000000HQPe-1q0O;
	Tue, 05 Aug 2025 05:08:09 +0000
Date: Tue, 5 Aug 2025 06:08:09 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>,
	Theodore Tso <tytso@mit.edu>,
	Gabriel Krisman Bertazi <krisman@kernel.org>,
	linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	kernel-dev@igalia.com
Subject: Re: [PATCH RFC v2 2/8] ovl: Create ovl_strcmp() with casefold support
Message-ID: <20250805050809.GA222315@ZenIV>
References: <20250805-tonyk-overlayfs-v2-0-0e54281da318@igalia.com>
 <20250805-tonyk-overlayfs-v2-2-0e54281da318@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250805-tonyk-overlayfs-v2-2-0e54281da318@igalia.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Aug 05, 2025 at 12:09:06AM -0300, André Almeida wrote:

> +static int ovl_strcmp(const char *str, struct ovl_cache_entry *p, int len)

> +	if (p->map && !is_dot_dotdot(str, len)) {
> +		dst = kmalloc(OVL_NAME_LEN, GFP_KERNEL);

...`

> +	kfree(dst);
> +
> +	return cmp;
> +}
> +

> @@ -107,7 +145,7 @@ static struct ovl_cache_entry *ovl_cache_entry_find(struct rb_root *root,
>  	while (node) {
>  		struct ovl_cache_entry *p = ovl_cache_entry_from_node(node);
>  
> -		cmp = strncmp(name, p->name, len);
> +		cmp = ovl_strcmp(name, p, len);
>  		if (cmp > 0)
>  			node = p->node.rb_right;
>  		else if (cmp < 0 || len < p->len)

Am I misreading that, or do really we get a kmalloc()/kfree() for each
sodding tree node we traverse on rbtree lookup here?

