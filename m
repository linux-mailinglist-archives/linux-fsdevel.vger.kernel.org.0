Return-Path: <linux-fsdevel+bounces-17690-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A0C8B1826
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 02:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 144541C224ED
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 00:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E27E5227;
	Thu, 25 Apr 2024 00:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PfTVS/CN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864663C0B;
	Thu, 25 Apr 2024 00:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714005990; cv=none; b=rZ60cZc7gJzjgspSsQOUDdCnZPyWcDZjSscKyv1RrDkeqmIqdxuP7rMca0nNhDnVMcM6JKVPRxxzesA0D25+8V/0Y8zHBgkpPpAH8EegztccTsodcemYX4TeOTlFJ+9zEPQFaFwHzQsxy0DBrb4N5mfBCU1usii6ImmecW4a0nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714005990; c=relaxed/simple;
	bh=/Wlzju9d4sbreuF2QUsdeAPVVk6i5sHfi9rwUsP0HGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sWXpsJRw+E4aXlo3mxroRDLvsP8/YUPBaLQJcnv6v3kB8iaQQn11a9ftutD49wecS9cmwEzO7A22iLeWfY5/uC46Y0D0N4VhO9f8TOiC6Iv7obSGzhvbo0+zrETNDfjobtEugyo8lCGWFf1JV9/kLlesIlihjcftl2w9HNYIGDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PfTVS/CN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BF1DC113CD;
	Thu, 25 Apr 2024 00:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714005990;
	bh=/Wlzju9d4sbreuF2QUsdeAPVVk6i5sHfi9rwUsP0HGg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PfTVS/CNe/QRee5WQOHqxv4lCDjo35edWERxnY0lfXUbeh2kWgfyngteq0P+Mx7NN
	 1Wala4s2Zi231f7qhd7pHtXUJ69GGx3L3Vr77NmY5AtB3wn38IrfKJ5iW4zET6NhN+
	 Ld4Ot7dR12tXd+B1N8tRYDs2wMCDunpeZcKQPytim1pdWBVmK4T8cJY5Ah84JQ4iYc
	 6IzUztDhXfB7+loJQ69h1Txw4nSIZwUb90Ka063Wo2wGbkZiTLQFmmlInJKy92d/wc
	 1sbTHGTN8f1JlBNK+65E5wA4K8QL4Di386ul0iGcPYmjQi8foyOEP969/Md3l9oV3T
	 NfwINNfsnMwkA==
Date: Wed, 24 Apr 2024 17:46:29 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: aalbersh@redhat.com, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, fsverity@lists.linux.dev
Subject: Re: [PATCH 09/13] fsverity: box up the write_merkle_tree_block
 parameters too
Message-ID: <20240425004629.GV360919@frogsfrogsfrogs>
References: <171175867829.1987804.15934006844321506283.stgit@frogsfrogsfrogs>
 <171175868014.1987804.14065724867005749327.stgit@frogsfrogsfrogs>
 <20240405025254.GG1958@quark.localdomain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405025254.GG1958@quark.localdomain>

On Thu, Apr 04, 2024 at 10:52:54PM -0400, Eric Biggers wrote:
> On Fri, Mar 29, 2024 at 05:35:01PM -0700, Darrick J. Wong wrote:
> > From: Darrick J. Wong <djwong@kernel.org>
> > 
> > Box up the tree write request parameters into a structure so that we can
> > add more in the next few patches.
> 
> This patch actually already adds the struct fields for new parameters.  They
> should go in later patches.

Apparently we don't need the level or log size parameters anymore,
so I'll remove them.

--D

> - Eric
> 

