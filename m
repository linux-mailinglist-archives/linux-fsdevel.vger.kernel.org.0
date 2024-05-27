Return-Path: <linux-fsdevel+bounces-20271-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6C48D09E0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 20:29:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C336DB21ACF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 18:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 497C415FA7D;
	Mon, 27 May 2024 18:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="OgmCWSW/";
	dkim=pass (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="wYP1mGPJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F405BD518;
	Mon, 27 May 2024 18:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716834539; cv=none; b=J/1dpVnu9tkSY5DR3wpJLK5mDN7f6iz0o0yZrNDEZNHj1CsCpt2uzyXZR/G//oJ2T7uXe8gINbVPfZ2C/96YaSzcFoXIU5Jfmyg7iaTZ43KIXR4oLiQcS032SWfzzn8rTArTjPQ/KTAVY0GDtPQfb9SVBuDpG4XSeQCwWvKb714=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716834539; c=relaxed/simple;
	bh=66j4hp7bp81kgzUG6Keoj1O/LgXXDWQutiaSpZCU8DM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=qDJoHUuFaXdXqV7tfL4P5HEOK8uT3n6EhVwEzMq/nFjnHCaDpuOB/SWlg5BzjS+WdXvl9TspClxyqPbfCPrp3UbY7sBcCyPRAaJShZxNnaqSymQlFIJh1psSm0qasRtWDMCtxzQEBa7mKWeIfXHdj/JT4Ei1SrL0U6RCylhnhBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=OgmCWSW/; dkim=pass (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=wYP1mGPJ; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id CFAC3332FE;
	Mon, 27 May 2024 14:28:56 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
	:to:cc:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=sasl; bh=66j4hp7bp81kgzUG6Keoj1O/LgXXDWQutiaSpZ
	CU8DM=; b=OgmCWSW/T7T+Z9QhuOImpu+4MLdn14A/keuomDewXz2DU0JtMCKViK
	1pqrWxSRHWpSumcgXDJcJt9VdOgALnIymH+8mjyoobW33RaaVE+m5CARrqQ2aovQ
	NzhfJhVNDkrWHB5s++aelsFS2ccVnGdXlgtkK4ZQPRPQKjfTmN7nE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C62DA332FC;
	Mon, 27 May 2024 14:28:56 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=66j4hp7bp81kgzUG6Keoj1O/LgXXDWQutiaSpZCU8DM=; b=wYP1mGPJqHWDh88S8V7+MJGODsV8ZHFrhiwdxOS4e51jJ7MsthZrFiSvEirEv9WVjl4f9tvL+N8y9RBqJdTGyiBwGsR/WXIBVAsSh293nglvPDHLdzMwiUQxxJ92HGnhB7m37GH6qb4/DD0eyIsu6YzRxUSxaxR7b64XkcAHaIQ=
Received: from yoda.fluxnic.net (unknown [184.162.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4097F332FB;
	Mon, 27 May 2024 14:28:56 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
Received: from xanadu (unknown [IPv6:fd17:d3d3:663b:0:9696:df8a:e3:af35])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 291B7CCC583;
	Mon, 27 May 2024 14:28:55 -0400 (EDT)
Date: Mon, 27 May 2024 14:28:55 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
    Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
    kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: cramfs: add MODULE_DESCRIPTION()
In-Reply-To: <20240527-md-fs-cramfs-v1-1-fa697441c8c5@quicinc.com>
Message-ID: <9o69oo79-34ns-ns70-1138-79pq20436188@syhkavp.arg>
References: <20240527-md-fs-cramfs-v1-1-fa697441c8c5@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID:
 FA3D352A-1C56-11EF-9D8C-25B3960A682E-78420484!pb-smtp2.pobox.com

On Mon, 27 May 2024, Jeff Johnson wrote:

> Fix the 'make W=1' warning:
> WARNING: modpost: missing MODULE_DESCRIPTION() in fs/cramfs/cramfs.o
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Reviewed-by: Nicolas Pitre <nico@fluxnic.net>

> ---
>  fs/cramfs/inode.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/cramfs/inode.c b/fs/cramfs/inode.c
> index 460690ca0174..d818ed1bb07e 100644
> --- a/fs/cramfs/inode.c
> +++ b/fs/cramfs/inode.c
> @@ -1003,4 +1003,5 @@ static void __exit exit_cramfs_fs(void)
>  
>  module_init(init_cramfs_fs)
>  module_exit(exit_cramfs_fs)
> +MODULE_DESCRIPTION("Compressed ROM file system support");
>  MODULE_LICENSE("GPL");
> 
> ---
> base-commit: 2bfcfd584ff5ccc8bb7acde19b42570414bf880b
> change-id: 20240527-md-fs-cramfs-10e1276a3662
> 
> 

