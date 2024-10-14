Return-Path: <linux-fsdevel+bounces-31897-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AFC299CF0E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 16:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2DAC1C23393
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 14:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824601CACE5;
	Mon, 14 Oct 2024 14:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jiqzz6oy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3F51CACD2;
	Mon, 14 Oct 2024 14:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728917242; cv=none; b=fkn8fDTS3EBN3hCDsZ3O9WNtdHCKT1HHUuvJt2xWUbr+9SghErqPq224IwnBIzAJ91IKqBcyHmFKUmFFN47B6gR01U+lWQb4xNwU6mM5Y+sTSqZftuabkikbscXI2yDO5WOLJvN+qPfRylH2X9eadtPWzZ9EVkG+v9mZTCPaSuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728917242; c=relaxed/simple;
	bh=8P4tn6AtgtUwgT6seQZDsuRr8Xb9jTKc/+yfO4Vv8pY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jHPzVXvF/P1JAXPRn/K5NRwI4V3ztNH8cmxvNZWoxtE2OUXJ+p7kS9N/a+RLD64UgQ0J4KUqs7J+YvSVgVUklxhoQcR3zkP8INGFdHToRKeF4moaihe2rH6mEdGFm+xsZRutvrGnVreKaRTF0GVJqca057dlGVDcfVOx87KOa7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jiqzz6oy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BD23C4CEC3;
	Mon, 14 Oct 2024 14:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728917242;
	bh=8P4tn6AtgtUwgT6seQZDsuRr8Xb9jTKc/+yfO4Vv8pY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jiqzz6oy9WZGk6g0JJrXzExaPUQNVhV1lgl5j06/SST5eNCyAYxgv5ZGOMFPXojgQ
	 A0+4jq4c+y3RhhvqL6msuSqI14ZPsgxQE2WLXdOM4Vu3jprk+B1wLlbVQCOCN+sbcW
	 dQxsRsriPAyvchqCTWKZnPV4idWrz9iZZw2a4twD+MBWSDgSqpCas+N7K6xcyyL5a6
	 bYeFX9aVTe9Q2rPKFA+kLrZFo0rBwecQ/EwqWmP2K0rpsQW3uiCZc40ybmoCG3NT9a
	 LeHhKiaRGtvw84HxuhsSYqPlqxKU1Se6XOjAv9daVwOqpDXofLwedsDkwGVn6Fq13v
	 tGf/xwOpsqENA==
Date: Mon, 14 Oct 2024 16:47:17 +0200
From: Christian Brauner <brauner@kernel.org>
To: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: Paul Moore <paul@paul-moore.com>, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org, audit@vger.kernel.org, 
	Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Subject: Re: [RFC PATCH v1 1/7] fs: Add inode_get_ino() and implement
 get_ino() for NFS
Message-ID: <20241014-bestnote-rundweg-ed234af3b86a@brauner>
References: <20241010152649.849254-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241010152649.849254-1-mic@digikod.net>

On Thu, Oct 10, 2024 at 05:26:41PM +0200, Mickaël Salaün wrote:
> When a filesystem manages its own inode numbers, like NFS's fileid shown
> to user space with getattr(), other part of the kernel may still expose
> the private inode->ino through kernel logs and audit.
> 
> Another issue is on 32-bit architectures, on which ino_t is 32 bits,
> whereas the user space's view of an inode number can still be 64 bits.
> 
> Add a new inode_get_ino() helper calling the new struct
> inode_operations' get_ino() when set, to get the user space's view of an
> inode number.  inode_get_ino() is called by generic_fillattr().

I mean, you have to admit that this is a pretty blatant hack and that's
not worthy of a separate inode method, let alone the potential
performance implication that multiple people already brought up.

