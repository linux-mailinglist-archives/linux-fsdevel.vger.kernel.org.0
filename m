Return-Path: <linux-fsdevel+bounces-41839-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D4A2A38086
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 11:47:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3E09188B2C4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 10:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF98D2163BC;
	Mon, 17 Feb 2025 10:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tf4StfT7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2694323CE;
	Mon, 17 Feb 2025 10:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739789233; cv=none; b=CrsH5ldMrR+rb395S1c5K3b0dsh87eNmSv63ZZ4lIKbB72kOL49iopYuHyI4G9lmq4/4lTX2Otp35FgV4ys8S2J9jE6Z/QCHl4UHBl5MTTyECkwclatwJt8b7vkqn8d78oPat7dpHK84EzG7WDCkiAHWvi6iBHAVuD322SMkQJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739789233; c=relaxed/simple;
	bh=m0eu/J6cjoH/9kExBeNQUyT4sDALyThgc8mo3UQVqPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EJVkJYpj4x46cMsbZGl1DBsZZ5MwZDhPVCBRTNhGboIdIH7x4KhrsxNeWDLA1ih/RHP2cpK4RmVszb5NzPImImZtYqZxHjEimMT+KHvnJKxIhdUa7iqTgB1syaRr8D6Bn8COscPh7sOi2cMj5ljUUTjI9/QPMUoCklMYcwybBh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tf4StfT7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47F34C4CED1;
	Mon, 17 Feb 2025 10:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739789232;
	bh=m0eu/J6cjoH/9kExBeNQUyT4sDALyThgc8mo3UQVqPA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tf4StfT7ijmySEOzvZRxt4MetwcA28DYA0UrfZuAECjFeXsDetNJOfNfUPDzJT/8x
	 U02GpjZKJFIrXfllc6dt+Ea6TNSTphfxemHaecRKTkyEhlwk/U4rA+4PZCrBNA37uR
	 fU5IFh5f//mY46kBHNrkEZeHAQ1zRVrRBsRPuI0uxOZmlQKVUuEqZagF0719JOwn8a
	 3DGBQTOzhfTQinCrrPeDYzrKjSayojA4LyOsfcWqnjJn8cCbpy/9DSS25uP0sHN//U
	 N8Sv5yWbRJ1H4hfSCXwml5BDs97dDKyfZKiJCvN5xW9jxSVX9PZzaY3tJsniY1Ga6q
	 BbRj479VCxIkA==
Date: Mon, 17 Feb 2025 11:47:08 +0100
From: Christian Brauner <brauner@kernel.org>
To: NeilBrown <neilb@suse.de>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3 RFC v2] change ->mkdir() and vfs_mkdir() to return a
 dentry
Message-ID: <20250217-gummihammer-kryptisch-548d0dab31a3@brauner>
References: <20250217053727.3368579-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250217053727.3368579-1-neilb@suse.de>

On Mon, Feb 17, 2025 at 04:30:02PM +1100, NeilBrown wrote:
> Here is a second attempt at this change.  Guided by Al I have handled
> other file systems which don't return a hashed positive dentry on success.
> 
> It is not always possible to provide a reliable answer.  One example is
> that cifs might find, after successfully creating a directory, that the
> name now leads to a non-directory (due to a race with another client).
> So callers of vfs_mkdir() need to cope with successful mkdir but no
> usable dentry.  There is nothing they can do to recover and must
> continue gracefully.  This failre mode is detected by the returned
> dentry being unhashed.
> 
> ORIGINAL DESCRIPTION - updated to reflect changes.
> 
> This is a small set of patches which are needed before we can make the
> locking on directory operations more fine grained.  I think they are
> useful even if we don't go that direction.
> 
> Some callers of vfs_mkdir() need to operate on the resulting directory
> but cannot be guaranteed that the dentry will be hashed and positive on
> success - another dentry might have been used.
> 
> This patch changes ->mkdir to return a dentry, changes several

Thanks for doing that.

> filesystems to return the correct dentry, and changes vfs_mkdir() to
> return that dentry, only performing a lookup as a last resort.
> 
> I have not Cc: the developers of all the individual filesystems NFS.  I
> or kernel-test-robot have build-tested all the changes.  If anyone sees
> this on fs-devel and wants to provide a pre-emptive ack I will collect
> those and avoid further posting for those fs.

Once I'll merge this into async.dir it'll show up in fs-next which means
it'll get additional xfstest testing.

