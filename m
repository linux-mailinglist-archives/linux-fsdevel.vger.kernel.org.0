Return-Path: <linux-fsdevel+bounces-2752-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 255F77E8AC4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Nov 2023 12:55:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4ED7B20B32
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Nov 2023 11:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A488214017;
	Sat, 11 Nov 2023 11:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uD3myK94"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18605689
	for <linux-fsdevel@vger.kernel.org>; Sat, 11 Nov 2023 11:55:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 423DAC433C7;
	Sat, 11 Nov 2023 11:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1699703720;
	bh=oUghxpRNPEGNJqTMMbcm4KyloCZMi03tXt/sHNuMuYs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uD3myK943JMANfSvHD2O4AN6fdjac+EkJoJwwWqYL7LjqMiNYJpBou45djwR0kmfy
	 Pz4uEXbtRHEfMIYVnC8jplUFVAxiKHeM/XxC1IMtaMd+jVLfypJS/EN/KmIna/DTBV
	 GFKsn/pa74o6QScyXdGX5ccGa29J4ReQLuT0us6s=
Date: Sat, 11 Nov 2023 06:55:18 -0500
From: Greg KH <gregkh@linuxfoundation.org>
To: Vivek Goyal <vgoyal@redhat.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, virtio-fs@redhat.com,
	stefanha@redhat.com, mzxreary@0pointer.de, gmaglione@redhat.com,
	hi@alyssa.is
Subject: Re: [PATCH v2] virtiofs: Export filesystem tags through sysfs
Message-ID: <2023111104-married-unstaffed-973e@gregkh>
References: <20231108213333.132599-1-vgoyal@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231108213333.132599-1-vgoyal@redhat.com>

On Wed, Nov 08, 2023 at 04:33:33PM -0500, Vivek Goyal wrote:
> virtiofs filesystem is mounted using a "tag" which is exported by the
> virtiofs device. virtiofs driver knows about all the available tags but
> these are not exported to user space.
> 
> People have asked these tags to be exported to user space. Most recently
> Lennart Poettering has asked for it as he wants to scan the tags and mount
> virtiofs automatically in certain cases.
> 
> https://gitlab.com/virtio-fs/virtiofsd/-/issues/128
> 
> This patch exports tags through sysfs. One tag is associated with each
> virtiofs device. A new "tag" file appears under virtiofs device dir.
> Actual filesystem tag can be obtained by reading this "tag" file.
> 
> For example, if a virtiofs device exports tag "myfs", a new file "tag"
> will show up here. Tag has a newline char at the end.
> 
> /sys/bus/virtio/devices/virtio<N>/tag
> 
> # cat /sys/bus/virtio/devices/virtio<N>/tag
> myfs
> 
> Note, tag is available at KOBJ_BIND time and not at KOBJ_ADD event time.
> 
> v2:
> - Add a newline char at the end in tag file. (Alyssa Ross)
> - Add a line in commit logs about tag file being available at KOBJ_BIND
>   time and not KOBJ_ADD time.
> 
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  fs/fuse/virtio_fs.c | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)

No documentation for your new sysfs file?  :(


