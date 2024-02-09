Return-Path: <linux-fsdevel+bounces-10909-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5315184F37E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 11:33:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B6F1286A56
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 10:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C792417C65;
	Fri,  9 Feb 2024 10:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Q9F3lFJq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D3825601;
	Fri,  9 Feb 2024 10:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707474803; cv=none; b=mKmap0sxpAG5pzfI2jD/c/sNvZUwk4TwGXoJWaRm8qcu7TDKkXISevPqq1wtikN8ye553iDfmjgVdu7BM+7JnLCZH8IkidXRrsY8WNi/TYIblFrj6DrCQ0kAGnwbGaIRNagUG8vuYXhj2Uxh5Ye8hLnAQ18XDMPOHlTmxE5hLTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707474803; c=relaxed/simple;
	bh=Go74Y4KpozxulQ91EBmfpP6738YgbbhHKR5zS1bU+fI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s4kCpKbVhc1iIWsmXCEbz8EIzsv8F7raEmgzlMjTWGXpn/HN2BiGUehdZZERg2GPl8Wbo5JsQqSHrvVVHLu7zJpt0AYXXWuV3T+m2Gd+KwSrszB8w2QxEg3EBRjYTIGNbFUGhRNpMJP8fgaG4k+rStO9rOSlQLJM88NODwOUmdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Q9F3lFJq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3781C433C7;
	Fri,  9 Feb 2024 10:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707474803;
	bh=Go74Y4KpozxulQ91EBmfpP6738YgbbhHKR5zS1bU+fI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q9F3lFJqSDkjkpsS2qadPxPX+vN09b+powED/qZ8gJAFOxBktZ5Y53jMVa/YkrsQb
	 au0vT/FynlkNBo/9n5F70qVdfiN/fHL1wE4ArGJAUufw8wfB+G+QwPLkI0d7U4oo88
	 1/K7MtXzB3NisDjCV59JMbbuZTFkBR0rTtK5f99w=
Date: Fri, 9 Feb 2024 10:33:20 +0000
From: Greg KH <gregkh@linuxfoundation.org>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Alyssa Ross <hi@alyssa.is>,
	gmaglione@redhat.com, virtio-fs@lists.linux.dev, vgoyal@redhat.com,
	mzxreary@0pointer.de, miklos@szeredi.hu
Subject: Re: [PATCH v2 1/3] virtiofs: forbid newlines in tags
Message-ID: <2024020953-rebel-ooze-2162@gregkh>
References: <20240208193212.731978-1-stefanha@redhat.com>
 <20240208193212.731978-2-stefanha@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208193212.731978-2-stefanha@redhat.com>

On Thu, Feb 08, 2024 at 02:32:09PM -0500, Stefan Hajnoczi wrote:
> Newlines in virtiofs tags are awkward for users and potential vectors
> for string injection attacks.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  fs/fuse/virtio_fs.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> index 5f1be1da92ce..de9a38efdf1e 100644
> --- a/fs/fuse/virtio_fs.c
> +++ b/fs/fuse/virtio_fs.c
> @@ -323,6 +323,16 @@ static int virtio_fs_read_tag(struct virtio_device *vdev, struct virtio_fs *fs)
>  		return -ENOMEM;
>  	memcpy(fs->tag, tag_buf, len);
>  	fs->tag[len] = '\0';
> +
> +	/* While the VIRTIO specification allows any character, newlines are
> +	 * awkward on mount(8) command-lines and cause problems in the sysfs
> +	 * "tag" attr and uevent TAG= properties. Forbid them.
> +	 */
> +	if (strchr(fs->tag, '\n')) {
> +		dev_err(&vdev->dev, "refusing virtiofs tag with newline character\n");

Please don't let userspace spam mthe kernel log if they are the ones
that are setting the tags.  Just make this a debug message instead.

thanks,

greg k-h

