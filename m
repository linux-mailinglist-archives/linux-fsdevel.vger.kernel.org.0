Return-Path: <linux-fsdevel+bounces-57572-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D424CB2397A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 22:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EBD76E4755
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 20:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21F202D0625;
	Tue, 12 Aug 2025 19:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YDzc6bSY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848572D0603
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Aug 2025 19:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755028763; cv=none; b=jEouam+EzPS4eFXpLx2EigwD+x+QQQ2qbppB1oZhRRIuwT/YZli5ZFLEnk0vabRTLi+uvw20zgpJ+NlhjRui72N8XH0OMt92NM4zwDVKSeMH6kmeMyVGXpF1Mlarh7I469sNKwgkTERIuPbSrlzPPgkFjytK4KvM2LdYJKVOH8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755028763; c=relaxed/simple;
	bh=wEeLcdr4+XtDPrIhOv95wXWYXHBXy3YMC3QM1pKHToY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bgLb3oyqhCd20oHIPX3A/ftWdeObj86kJ3B5Z9zIc0SC2LmISg5GAMuGSykfK9gOyNkm7INQPZVdpBc4zywhMOVcbIHQgiZY+k4AbImsnrgDtux/EX/YKYmGt6KbiKv1HUA4fS5/9hqMUAYPXVaiyvycaigt+9bEfInw3mdCxR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YDzc6bSY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04778C4CEF0;
	Tue, 12 Aug 2025 19:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755028763;
	bh=wEeLcdr4+XtDPrIhOv95wXWYXHBXy3YMC3QM1pKHToY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YDzc6bSY131vqA6wtc6t6keCvloCiidIMjRbQ9RNjS9r5aICoQOuP5VbISWzyNzoc
	 Q32JrPdyBuQuRfcxOOn+jrFfy9gYqyTzDPQD6KHNk3SI4zOxNoDp42inuLpvfWrZqN
	 qiqydQkyZdE2CxpMiTmNMLiFkXWg4JZdhmMDcXCWvYW3RNb4ClMhTC8kdZgescPE8E
	 M2TfASdTFYeOi7h3mocD6eRZkPIA8hiyOZdBudifmStYoMG9dEBE1JusPVtPPnulkv
	 2o75Z4KLF3XtYd2tvzUsiaVREnh1rZ2um0YpHQ1ifxlfXANA2kX3WmQeD+868U7VUv
	 25BIlwJJ+76Qg==
Date: Tue, 12 Aug 2025 12:59:22 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Joanne Koong <joannelkoong@gmail.com>, brauner@kernel.org,
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v2] fuse: keep inode->i_blkbits constant
Message-ID: <20250812195922.GL7942@frogsfrogsfrogs>
References: <20250807175015.515192-1-joannelkoong@gmail.com>
 <CAJfpeguCOxeVX88_zPd1hqziB_C+tmfuDhZP5qO2nKmnb-dTUA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpeguCOxeVX88_zPd1hqziB_C+tmfuDhZP5qO2nKmnb-dTUA@mail.gmail.com>

On Tue, Aug 12, 2025 at 10:27:41AM +0200, Miklos Szeredi wrote:
> On Thu, 7 Aug 2025 at 19:51, Joanne Koong <joannelkoong@gmail.com> wrote:
> >
> > With fuse now using iomap for writeback handling, inode blkbits changes
> > are problematic because iomap relies on inode->i_blkbits for its
> > internal bitmap logic. Currently we change inode->i_blkbits in fuse to
> > match the attr->blksize value passed in by the server.
> >
> > This commit keeps inode->i_blkbits constant in fuse. Any attr->blksize
> > values passed in by the server will not update inode->i_blkbits. The
> > client-side behavior for stat is unaffected, stat will still reflect the
> > blocksize passed in by the server.
> 
> Not quite.  You also need to save ilog2(attr->blksize) in
> fi->orig_i_blkbits and restore it after calling generic_fillattr() in
> fuse_update_get_attr() just like it's done for i_mode and i_ino.

Why is that?  Is the goal here that fstat() should always return the
most recent blocksize the fuse server reported, even if the pagecache
accounting still uses the blocksize first reported when the kernel
created the incore struct inode?

--D

