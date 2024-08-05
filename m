Return-Path: <linux-fsdevel+bounces-25003-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54237947A0C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 12:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A4B21F21F87
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Aug 2024 10:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DBFF154BFC;
	Mon,  5 Aug 2024 10:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AwJBCWk6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A33514F12C;
	Mon,  5 Aug 2024 10:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722854785; cv=none; b=GCxkdFsDPgOTa3qTj/yVK5RtO3qosDIl3/hkvCM/sRHO3D2VA1JSKG12Pve20oidXP1EFuG1wGlzw5n3iv4BUlrhcwEeWu6qMMiHvQn160F3C5NmMnchs5VD+/c+N1ULcOFFQV9d/2MoHs0pU3/R4RNq7DNeibSqAIOn0JXeRdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722854785; c=relaxed/simple;
	bh=jQO7PLs5zn7U0IyLuj5k3CxTmsnpi7j53S8xfLpWJ0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FOoUIvRBzyvsQ8X0aMZG4dN2gKt9W32axTMAxI4J9imtzO/o7kbRkCnJH3WWfZFFx4iVkh3AQT2IqBnu4AIAHjSZJ0uN/d2ppWb9SHQDWcxEEHz37V99Utb9kPpOL2+K/pD7sA6fbs+4r/2WzjIbW2jFLDKomBK3+7j3p8qvhmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AwJBCWk6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28BDDC32782;
	Mon,  5 Aug 2024 10:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722854785;
	bh=jQO7PLs5zn7U0IyLuj5k3CxTmsnpi7j53S8xfLpWJ0c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AwJBCWk61BKgerJoLMjkt/nu4FYIFuVUVEpfO3vKmTV5r7vFOS4Ejl+FuOG1sxo/6
	 3XAHE5G8dbc4carbdnfvwP3hEwckw/c1CZce1hHMpTfjivEguohgEc0YvaNlMWt66r
	 X0Gg98U0zje3TnvHbDPCGaHVhGwRDBeq1co6UOme+3Ou6wrbfHidEMFmjSHHH7IR30
	 6NPFclVqpLlwE5RA1YjaNjums4bkoismwNdgxyCMEq/dTtLs3ZHfExGTGApQwo7SvI
	 z4OSrkpZScZzrYPHB2O16dfDrAmJTLHybdmlZOrfZds+0Htp+f611qAjgom4pFtSFF
	 gN4nl3J5v4N1Q==
Date: Mon, 5 Aug 2024 12:46:20 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, Josef Bacik <josef@toxicpanda.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 0/4] fs: try an opportunistic lookup for O_CREAT
 opens too
Message-ID: <20240805-rachsucht-lehrzeit-f1c0c47c2fee@brauner>
References: <20240802-openfast-v1-0-a1cff2a33063@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240802-openfast-v1-0-a1cff2a33063@kernel.org>

>       fs: remove comment about d_rcu_to_refcount
>       fs: add a kerneldoc header over lookup_fast

I took both of these into vfs.misc since they're really unrelated cleanups.

