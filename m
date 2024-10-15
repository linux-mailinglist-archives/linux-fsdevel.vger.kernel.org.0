Return-Path: <linux-fsdevel+bounces-31989-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FCD599EDCD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 15:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8FE4B23BBF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 13:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF411AF0DF;
	Tue, 15 Oct 2024 13:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="aCtdZ9mg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C721B2186;
	Tue, 15 Oct 2024 13:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728999412; cv=none; b=VESfDXAR6EmUIgtvKyiWg4EIye4vHKwBrPCo8AhQMClCybRDH0LfZ2m/wv5fls9Ts3J6yZ6fWEDm3gSM7TTuriGNt2gsw9DdyyWMu+6XQw3gD+qobXlPaxAURj7VJVLw9kvH9NAFL8YWIy6NVSq1+n/GnPAVwXn1OiMuhgL/o2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728999412; c=relaxed/simple;
	bh=1o+mpm3TwP32msRXHLP7zEzdbkFDP0OejQgTcO9tZqA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kGHWHHhmEAJFqpwPszNpR5Y5HNfPBpXcoWtraZRCW7h9SyCeqjC96AE+t1Z/RkWSsJ3PU+hTQQWfPxV4bF8H2bj2GoXJF2hAL4BVuJqZTL0m63UmDJy7nLyWmYrXh8E+u0MEHE2L+zjygefKqzRNn5CcFqS51+bFgULgj3hcI88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=aCtdZ9mg; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net D1CF6418B6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1728999410; bh=/9PBSSXDLd3URlyiOb3FwjVfJcT0hVdJJ4SMwSlMcI0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=aCtdZ9mgJcGC4FCS+8I43hg5h8/oRvOS9p40s1OLNt8VfVgetMFkDZrT26qvg4dBQ
	 LWco3ljJS9e8RRMNWRYNbsFMCo+sQM5fiZEPg+xPoLLZ3khJUd+nt4/JhNUnz6eJiy
	 OxMmgZyh3RfaO7qddLM6xM27S+Ah7NTAM2dNxHpQz82EI4ReOPwOwW5NRGfL6/xULI
	 /iRcbQTm3jEBMKFs9M0k5s1G3yxvc5lyM0fr1KiG6TYX/Jw2O4ZgeE0KiR5Ju1UC6J
	 KJ7eq1K+d+MHQCAWfKIYCTbEJK13mOBYHvblKmB4XfWOmUPjLkDTVt+RnCaXTSyxdW
	 /DbtTJAQS9hTA==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id D1CF6418B6;
	Tue, 15 Oct 2024 13:36:49 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Dongliang Mu <dzm91@hust.edu.cn>, David Howells <dhowells@redhat.com>,
 Jeff Layton <jlayton@kernel.org>
Cc: hust-os-kernel-patches@googlegroups.com, Dongliang Mu
 <dzm91@hust.edu.cn>, netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: fix a reference of a removed file
In-Reply-To: <20241015092356.1526387-1-dzm91@hust.edu.cn>
References: <20241015092356.1526387-1-dzm91@hust.edu.cn>
Date: Tue, 15 Oct 2024 07:36:49 -0600
Message-ID: <87jze9qyha.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dongliang Mu <dzm91@hust.edu.cn> writes:

> Since 86b374d061ee ("netfs: Remove fs/netfs/io.c") removed
> fs/netfs/io.c, we need to delete its reference in the documentation.
>
> Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
> ---
>  Documentation/filesystems/netfs_library.rst | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/Documentation/filesystems/netfs_library.rst b/Documentation/filesystems/netfs_library.rst
> index f0d2cb257bb8..73f0bfd7e903 100644
> --- a/Documentation/filesystems/netfs_library.rst
> +++ b/Documentation/filesystems/netfs_library.rst
> @@ -592,4 +592,3 @@ API Function Reference
>  
>  .. kernel-doc:: include/linux/netfs.h
>  .. kernel-doc:: fs/netfs/buffered_read.c
> -.. kernel-doc:: fs/netfs/io.c

Already fixed by 368196e50194 in linux-next.

Thanks,

jon

