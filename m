Return-Path: <linux-fsdevel+bounces-17691-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57AA18B182C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 02:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 896291C2354E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 00:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954A217C9;
	Thu, 25 Apr 2024 00:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kkXNbYgg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09F2816;
	Thu, 25 Apr 2024 00:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714006170; cv=none; b=ojFNT2s/M+xlsddWMB2sS0QVw8p0baGUS7NkWfKfgIAxcbjtIQ7QtqHChGJmmV8azu8glP6NfJiLbDEt3bsCx8BAhddq5lXmuBc7RXCxgP2ErqvJisk1IN0tpoGCDLExeOVcYUc957+ljQMjc4JGDcdR1rz6aYy203jcylypz0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714006170; c=relaxed/simple;
	bh=1COPJy7SgvKonifSiYRQ/nMCr0ZHQVafrm/XPZJmPtI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NldeoqpLa2nNXeAHlK/mQfuQlvZDgCmIBcqP+OsYNJ3NaBN8QlAcTHfwOPmoDbiU2/as3AodwuK633Qe66zm9BP+1fcDGLDH4AJsU6jWtt0mlg0tFy6DEwgkS7z6PH7iS6CrNaq0PR8yg5QBPMjxKPkYDwyxvIVn53zBFq2QUlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kkXNbYgg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63413C113CD;
	Thu, 25 Apr 2024 00:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714006169;
	bh=1COPJy7SgvKonifSiYRQ/nMCr0ZHQVafrm/XPZJmPtI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kkXNbYggdcPfBFoAIPrNbz3SY5cDwsGcVPdn0N4LPWtE1MRXAxE5lyqc9x4aOmVw8
	 yk91IZF7q2IvmFDeuRlf6vDINGxuh7lnKAe6EDaYKsp+RqhU0/z+ws0xBuc12GnSVM
	 R/FC8BF9y9wnWS766npWtnqnPdtqmszG21uitBzxefXxAUd9mR7TCCb6NsJKqT+loM
	 EApAP0R5ndA62vG5h9EyfaIO6g9fXwqqX2BR4yM84201VNrRY0MZrG/NVSdPbpIe85
	 qlAE/pVI7iQNmg6SfpFrG0Vbs6psZrQ0yXcBAS7mErzAhH030n4OCO/7msPyHxdGwA
	 L9ZdVmjB0oDVg==
Date: Thu, 25 Apr 2024 00:49:27 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: aalbersh@redhat.com, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, fsverity@lists.linux.dev
Subject: Re: [PATCH 08/13] fsverity: expose merkle tree geometry to callers
Message-ID: <20240425004927.GE749176@google.com>
References: <171175867829.1987804.15934006844321506283.stgit@frogsfrogsfrogs>
 <171175867998.1987804.8334701724660862039.stgit@frogsfrogsfrogs>
 <20240405025045.GF1958@quark.localdomain>
 <20240425004545.GU360919@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425004545.GU360919@frogsfrogsfrogs>

On Wed, Apr 24, 2024 at 05:45:45PM -0700, Darrick J. Wong wrote:
> On Thu, Apr 04, 2024 at 10:50:45PM -0400, Eric Biggers wrote:
> > On Fri, Mar 29, 2024 at 05:34:45PM -0700, Darrick J. Wong wrote:
> > > +/**
> > > + * fsverity_merkle_tree_geometry() - return Merkle tree geometry
> > > + * @inode: the inode for which the Merkle tree is being built
> > 
> > This function is actually for inodes that already have fsverity enabled.  So the
> > above comment is misleading.
> 
> How about:
> 
> /**
>  * fsverity_merkle_tree_geometry() - return Merkle tree geometry
>  * @inode: the inode to query
>  * @block_size: size of a merkle tree block, in bytes
>  * @tree_size: size of the merkle tree, in bytes
>  *
>  * Callers are not required to have opened the file.
>  */

Looks okay, but it would be helpful to document that the two output parameters
are outputs, and to document the return value.

- Eric

