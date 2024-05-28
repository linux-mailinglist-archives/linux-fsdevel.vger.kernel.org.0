Return-Path: <linux-fsdevel+bounces-20316-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C398D1625
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 10:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 236FDB21F2E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 08:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D018013C67B;
	Tue, 28 May 2024 08:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mLomtxRc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B0873441;
	Tue, 28 May 2024 08:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716884428; cv=none; b=MRq4bDo2Jv/XYbrXLXKTl27dG7OkFZh819CccitKel6yR4KPy5Tm74DmBQ8g4tPojGgZgp3nHNd58Eek6/y2tC5AbnQYutJu5jXSDHtde0Duvk6wTcTQ82eCAz5FDp8/lG/YdYOMkN9/jmrfws//Vpa3rzk9l5Poa1XLi6ZiNpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716884428; c=relaxed/simple;
	bh=ef2GWcgmaUf0AdMfddAKzFxmIGHc4piX3DIDo9nhUc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rZsgnG+Nr52vLQ8fTkrAYwzkieikBCg+Jy6YbXS9KdQDbemP939onNCNdY+tdzTzHb0igFddxm8WBN0my9FCuGAJPxbqU4uVPY5sCD1dAym6zcYco8rAso3QoKjwn08U1c9WgsH9C5eUUXT0yF5Dd1GXYU6tiMSeM4YAxdB3Wik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mLomtxRc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94264C3277B;
	Tue, 28 May 2024 08:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716884427;
	bh=ef2GWcgmaUf0AdMfddAKzFxmIGHc4piX3DIDo9nhUc0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mLomtxRcgnHVYUBmz5vFSVIxsxx1PZp4qr26Wmz7Liw21xHXDkjzoB1HlL7xhW+be
	 EbcV452bPfpBt3tb1DNoLXvSaCS79QpKlD7mZAJ73dayzbUgFh0mhIdMP+HFocJTE8
	 J/1G+tULvUsHtvprZmNiuN9rvW4wShG+a34wfgp8YkXi0rpJ82OF+CHXMUbB6fzBgR
	 aQk5nmm1cOXlcANGqqYN3JLLklGLKPYWt7dJhYHMviF5pEJBcTiDj/tp2IlXT1PMPA
	 z2d6WpkNmVLMZVwm0AGxC3T5Z4QbpB/IQCmo0SkE2mWMEitf4PD/Ow8u5ZzGRFIa22
	 oULuaZSQjSCpQ==
Date: Tue, 28 May 2024 10:20:21 +0200
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jan Kara <jack@suse.cz>, Aleksa Sarai <cyphar@cyphar.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Chuck Lever <chuck.lever@oracle.com>, 
	Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
	Alexander Aring <alex.aring@gmail.com>, linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH RFC v2] fhandle: expose u64 mount id to
 name_to_handle_at(2)
Message-ID: <20240528-wachdienst-weitreichend-42f8121bf764@brauner>
References: <20240523-exportfs-u64-mount-id-v2-1-f9f959f17eb1@cyphar.com>
 <ZlMADupKkN0ITgG5@infradead.org>
 <20240526.184753-detached.length.shallow.contents-jWkMukeD7VAC@cyphar.com>
 <ZlRy7EBaV04F2UaI@infradead.org>
 <20240527133430.ifjo2kksoehtuwrn@quack3>
 <ZlSzotIrVPGrC6vt@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZlSzotIrVPGrC6vt@infradead.org>

> Well, how about we fix the thing for real:
> 
>  - allow file systems to provide a uniqueu identifier of at least
>    uuid size (16 bytes) in the superblock or through an export operation
>  - for non-persistent file systems allow to generate one at boot time
>    using the normal uuid generation helpers
>  - add a new flag to name_to_handle_at/open_by_handle_at to include it
>    in the file handle, and thus make the file handle work more like
>    the normal file handle
>  - add code to nfsd to directly make use of this
> 
> This would solve all the problems in this proposal as well as all the
> obvious ones it doesn't solve.

As I've said multiple times on the thread I agree that this is what we
should do next and I would be happy to take patches for this. But
exposing the 64bit mount id doesn't impede or complicate that work. It's
a simple and useful addition that can be done now and doesn't prevent us
from doing the proposed work.

Hell, if you twist my arm I'll even write the patches for this.

