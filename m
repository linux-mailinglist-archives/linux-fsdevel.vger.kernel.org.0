Return-Path: <linux-fsdevel+bounces-32662-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B12CF9ACA8F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2024 14:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEF491C24AA5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2024 12:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE941ADFE4;
	Wed, 23 Oct 2024 12:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DADASAtJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDD31ABEA6;
	Wed, 23 Oct 2024 12:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729687856; cv=none; b=LbOrQklUQOh5dL7JrJuR5ckpCnoAUyso/JV0IhVC9lrYYmapSQDRNtsvBZrsZVpjVAv2psyRflx7gmUgtHqKwWZliFgI1UrVNOF+FJ/0Y0Gb5q0OoTIPZhC5XNS+5CLcE7l9+cGxcaFf5Tb/nf3iA5z7DyZ+aV7vGBHv1jSP/Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729687856; c=relaxed/simple;
	bh=JtM8ltX+fqK4vxdQbbSOAOvMmJXmUSffw/WgXG3DogU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YP+6oG+CHFlLpWkKeIgWLVU3YNzJP2dI5yMkce24mIczsO7YJCYF+gdpfd8kmrR7kQiLI7m33V0R7VaFI2Gm2TYVjR5OulXElabdx9GktoSxcpOGeuDK4Di86eYSEXsaBrhg8N2014BGmQgj7tYjFawY1KFiJPR7vFXdOZ/PKp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DADASAtJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C19CDC4CEC6;
	Wed, 23 Oct 2024 12:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729687855;
	bh=JtM8ltX+fqK4vxdQbbSOAOvMmJXmUSffw/WgXG3DogU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DADASAtJhDYG2hCdAzXX4YGeLaO6INDAuceJzBnrUGJfNFhobLH4HQG8J/gTMtVCY
	 cpQd4skHvcsg/fuwCFDqqyeDLcHr2tL4e9+F28xJfL7iVy8hMHrbdsl8VDMWiI/csQ
	 pXeguNC2tu/07OvHucEVmZLwQAao5+cQc5OLLPfds6x3nxAYSib6WHBqyCRri6FTyA
	 ZaQbhFPvgHfpxHlmTExvnRNjWSZmg1WdDeQ8z3ittIjSVMERkCrXsyQuiY9rXHWWOo
	 3IcXZGfgn4+ly10BhKIxIy9UANN+7TS8DRYr3Sj6OWnz4gTKQP3CaGsf+vMsWg9fE7
	 9xAvS4gTP2JIg==
Date: Wed, 23 Oct 2024 14:50:48 +0200
From: Carlos Maiolino <cem@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	hare@suse.de, martin.petersen@oracle.com, catherine.hoang@oracle.com, 
	mcgrof@kernel.org, ritesh.list@gmail.com, ojaswin@linux.ibm.com, hch@lst.de, 
	brauner@kernel.org, djwong@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	dchinner@redhat.com
Subject: Re: (subset) [PATCH v10 0/8] block atomic writes for xfs
Message-ID: <7wpad2i544hgmqp5ebjbmsosfreqwnmsazczazga622om6gaxi@ye27ugrsqfig>
References: <20241019125113.369994-1-john.g.garry@oracle.com>
 <172937817079.551422.12024377336706116119.b4-ty@kernel.dk>
 <d6d920c6-9a8c-49b7-8d4a-fbeacd6906f0@kernel.dk>
 <e8a3a228-0367-43da-8cad-caaaa207f0e6@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8a3a228-0367-43da-8cad-caaaa207f0e6@oracle.com>

On Wed, Oct 23, 2024 at 01:42:24PM GMT, John Garry wrote:
> On 19/10/2024 23:50, Jens Axboe wrote:
> > > On Sat, 19 Oct 2024 12:51:05 +0000, John Garry wrote:
> > > > This series expands atomic write support to filesystems, specifically
> > > > XFS.
> > > > 
> > > > Initially we will only support writing exactly 1x FS block atomically.
> > > > 
> > > > Since we can now have FS block size > PAGE_SIZE for XFS, we can write
> > > > atomically 4K+ blocks on x86.
> > > > 
> > > > [...]
> > > Applied, thanks!
> > > 
> > > [1/8] block/fs: Pass an iocb to generic_atomic_write_valid()
> > >        commit: 9a8dbdadae509e5717ff6e5aa572ca0974d2101d
> > > [2/8] fs/block: Check for IOCB_DIRECT in generic_atomic_write_valid()
> > >        commit: c3be7ebbbce5201e151f17e28a6c807602f369c9
> > > [3/8] block: Add bdev atomic write limits helpers
> > >        commit: 1eadb157947163ca72ba8963b915fdc099ce6cca
> 
> Thanks Jens
> 
> > These are now sitting in:
> > 
> > git://git.kernel.dk/linux for-6.13/block-atomic
> > 
> > and can be pulled in by the fs/xfs people.
> 
> Carlos, can you kindly consider merging that branch and picking up the iomap
> + xfs changes?

yup, I'll queue them up for 6.12 merge window

Carlos

> 
> Cheers
> 
> 

