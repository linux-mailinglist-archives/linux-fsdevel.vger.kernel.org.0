Return-Path: <linux-fsdevel+bounces-20230-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC718CFFED
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 14:22:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D144B2287E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 12:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D5C15E5BD;
	Mon, 27 May 2024 12:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i0+I04OF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5320915DBD8;
	Mon, 27 May 2024 12:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716812553; cv=none; b=d72pYwCQbqcKRfNbN6LMOgi2kOwzol4lFCsDpu9xnFpYs2O8yqf71+41kLEtnUmSMbl4/Y9XjC3aAESkABuZXH8K6DnJuClsFISAn6u8/9WZomQKrrTLZE25X5kuyJk5+4UV/tBBuL2nQEdnmFgFAmuZEhLNMKgiGGfgF2dARX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716812553; c=relaxed/simple;
	bh=yHJzZg9NLe7BwyCieTg7X7Yyi9SCyCbH1Qa/QbiSgek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bWnl9Y7sodbOt11do/pKClNmUAOaoLTa4inZm58+WZYw80ZOsbwFZWx50Q3gLqs0I7ZHlJ2Ity22n0FFub5Nc4q8BSuoytNS7b1pMnqCHXnsQgudWI+WWMUg92rd+Rc06BxMPzY1TqZ2xmDfCOLFqVWHuyiTYseipcqp0iFyoFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i0+I04OF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94775C2BBFC;
	Mon, 27 May 2024 12:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716812552;
	bh=yHJzZg9NLe7BwyCieTg7X7Yyi9SCyCbH1Qa/QbiSgek=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i0+I04OFzv6NUu6oV+j2DKrGONKwRg6EzdprBNtcV3ivr6V0A6rT17APbDPi806ul
	 o4hmK2/55XkPEeKs3wCXBNCWg7EbFt19RVPP4sGYfSE4sYw2CAnRUMCyzyjaM4T1zc
	 xPlQBdiC7qD/cDaC3FUoBP6NY3iuwrNLiSLkAEaAgcHbTKqaxzQx5BeeW2BOsw3Wec
	 fv/ZwyPWIMaLVW9hwfdUzbr+GpmUihxzPeDmucQOhF//ivJFphxOyPJp8VTuyBNRfX
	 k2kFZsvC6FDLS/oo8jz3ONdLMhQKlG2hs3FX9djiUJpnImTGqR042RMbbQBouBgYcZ
	 nv+nh0GiX5njA==
Date: Mon, 27 May 2024 14:22:26 +0200
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Aleksa Sarai <cyphar@cyphar.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Chuck Lever <chuck.lever@oracle.com>, 
	Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
	Alexander Aring <alex.aring@gmail.com>, linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH RFC v2] fhandle: expose u64 mount id to
 name_to_handle_at(2)
Message-ID: <20240527-montag-beruhen-523b74214339@brauner>
References: <20240523-exportfs-u64-mount-id-v2-1-f9f959f17eb1@cyphar.com>
 <ZlMADupKkN0ITgG5@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZlMADupKkN0ITgG5@infradead.org>

On Sun, May 26, 2024 at 02:25:34AM -0700, Christoph Hellwig wrote:
> On Thu, May 23, 2024 at 01:57:32PM -0700, Aleksa Sarai wrote:
> > Now that we provide a unique 64-bit mount ID interface in statx, we can
> > now provide a race-free way for name_to_handle_at(2) to provide a file
> > handle and corresponding mount without needing to worry about racing
> > with /proc/mountinfo parsing.
> 
> file handles are not tied to mounts, they are tied to super_blocks,
> and they can survive reboots or (less relevant) remounts.  This thus
> seems like a very confusing if not wrong interfaces.

I'm not fond of the interface as I've said on an earlier version, but
name_to_handle_at() has always exposed the mount id. IOW, this isn't
adding a new concept to the system call.

