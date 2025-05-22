Return-Path: <linux-fsdevel+bounces-49672-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F4075AC0B8F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 14:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E57DE7B4786
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 May 2025 12:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B14428B3F3;
	Thu, 22 May 2025 12:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JCAH2++4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF0BE571;
	Thu, 22 May 2025 12:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747916655; cv=none; b=Eaj13MxbzYFgVDcfm1xeqfVfXeR+rdcj/ULlF+JJoNxT4rqrSwcoYWcBiI8SUOCx6l/R47Hb4SN1HOrowPMdM73ctHBObzN6z70iHLbyqHd+PognANRghT1BkHPV6dpasM1FPsl9eZoUxWEBes5JEh+Cv8JnZrVPc0iZWblm/3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747916655; c=relaxed/simple;
	bh=azDe2h+2bgAu+YrZ2s2giiVuXtQz0QVolcglDEZZjYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WGjr2arrhiXCuF7DIsCw5CrsI4xF0UVqA8Vdt7YXlSE9WPvnuQy5CjKJ2GAdtXSIn2Edy5JIabIZSp4qnHmD6TzphzcxEdkKAWWm1I0kym3+04xqaPVcHgE45WMzSxA+95hIrCQ48aYQLgJuEDJ9/G6eNDcQtcQnUjDvRNnHlqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JCAH2++4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12627C4CEED;
	Thu, 22 May 2025 12:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747916655;
	bh=azDe2h+2bgAu+YrZ2s2giiVuXtQz0QVolcglDEZZjYM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JCAH2++4OfxibRSKHcSwBiAsHD4IpCbW+8g9UIng+BVxcVjYbiVZ2mHM2r2ZggLiU
	 EtCfESlpCXSgMQO/hO27NbeF2bWizLIzDsTsCVH2/KV/txg8hMmH19fUb1G9HsXGcH
	 LkUBPd8HLa6TTNJ8QtcCe1Dv5ffBMVFmuX8WsbT1JK+YMMMxvar6l8n9fjIp8fQ3ZH
	 BWSaKPV6QePhh2Ve9JovWhBFjv/4wTCfP6fVBqTuuS71q6p8g/jpEJFmATW6FhfbFg
	 n96uDCpxrv9ZUcCscGNfS/BrWufy95zr+deB2bOOvagCFlP4GcRA9iI8khnY94hne7
	 ckTiDTjV3/o7Q==
Date: Thu, 22 May 2025 14:24:10 +0200
From: Christian Brauner <brauner@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: syzbot <syzbot+52cd651546d11d2af06b@syzkaller.appspotmail.com>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Al Viro <viro@zeniv.linux.org.uk>, jk@ozlabs.org, 
	linux-efi@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [fs?] [efi?] BUG: unable to handle kernel paging
 request in alloc_fs_context
Message-ID: <20250522-exotisch-chloren-3fa7b7ce5266@brauner>
References: <6820e1f6.050a0220.f2294.003c.GAE@google.com>
 <CAMj1kXEg88Q5GCV+YW13UT4eDEzMpnKW8ReJNDjLqX7xeXaw=w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXEg88Q5GCV+YW13UT4eDEzMpnKW8ReJNDjLqX7xeXaw=w@mail.gmail.com>

On Wed, May 21, 2025 at 07:28:34PM +0200, Ard Biesheuvel wrote:
> (cc James, Al, Christian)
> 
> Please see the splat below.
> 
> The NULL dereference is due to get_cred() in alloc_fs_context()
> attempting to increment current->cred->usage while current->cred ==
> NULL, and this is a result of the fact that PM notifier call chain is
> called while the task is exiting.
> 
> IIRC, the intent was for commit
> 
>   11092db5b573 efivarfs: fix NULL dereference on resume
> 
> to be replaced at some point with something more robust; might that
> address this issue as well?

Yes. It's in the merge queue for v6.16 which kills off all that
vfs_kern_mount() stuff.

