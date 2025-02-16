Return-Path: <linux-fsdevel+bounces-41798-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E783BA376FD
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Feb 2025 19:49:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7110165ABD
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Feb 2025 18:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E891A238A;
	Sun, 16 Feb 2025 18:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fCJUU/5h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3DA32C8B;
	Sun, 16 Feb 2025 18:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739731760; cv=none; b=ir8NKPdZtFpyapVZEpo5+7gWlISRzSo5RfMm/uKbJDstdUDAbmEZWwO5XagElP/ySW8TkyIsK8oR/7kunRVS3Joya18tbfzxLh27sPRCOsaiJ5Z2s5oSHa4mFhSm4ZsvcnQMjwtQyD2TJMpttc4CxrjGoqkqs9ClY2dcQc+gR38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739731760; c=relaxed/simple;
	bh=6SJKxdr3CHZodxSX4Pw6E6iSXqrdPMgfMqdFeaPKRJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AE5/EQztV7USc6gR+jeGIcRX26ONJla6v8tIucx+j/H4BuAMFSHEwMREMuEeIKyiP65cQXqrH0sqSMto//Pe4YYLzRNxQ+HK33Pn+oRaNi+2c2g0e9Q1Q9WgQbsS3z/BoS5LDyGHqNhlbNQvyCEu+0IZ3H5jMY/EWiK9X+2ley4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fCJUU/5h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED970C4CEDD;
	Sun, 16 Feb 2025 18:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739731760;
	bh=6SJKxdr3CHZodxSX4Pw6E6iSXqrdPMgfMqdFeaPKRJI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fCJUU/5havBVpgmwHCcK6kNYnX2SSuc6XSM+PIq7vEo0tdLqde/ulHJxwfyVlN/7a
	 I/PiPRfvnZjkxeXWYMfrFRKLBDjYU/64mzj0qdxFUrjm2gAV016W7cxFsnxlP4KZPV
	 fnTsQovPjDHQaiXaiUul1ZtlqqOBSbD680lf8xrdmSGrCpGD5Ln+QnuR6sVa6eFooQ
	 nfGZ1o3QrXtscA3gURVOUaa9wGg/8FF3uIqCJE7fHLgp7tvGIGR3pLhuP7agKVD3zu
	 KajPFtaEBT1WJfNguhWHSHPWbCRgnTtJst6d9IJtfTMRiEgVCQuZ00YuKrItmveMA/
	 lSR8TMhrVAXXQ==
Received: by pali.im (Postfix)
	id E0AC17FD; Sun, 16 Feb 2025 19:49:07 +0100 (CET)
Date: Sun, 16 Feb 2025 19:49:07 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	ronnie sahlberg <ronniesahlberg@gmail.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Steve French <sfrench@samba.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org, linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/4] fs: Add FS_XFLAG_COMPRESSED & FS_XFLAG_ENCRYPTED
 for FS_IOC_FS[GS]ETXATTR API
Message-ID: <20250216184907.wuezls5brv3syosa@pali>
References: <20250216164029.20673-1-pali@kernel.org>
 <20250216164029.20673-2-pali@kernel.org>
 <20250216183432.GA2404@sol.localdomain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250216183432.GA2404@sol.localdomain>
User-Agent: NeoMutt/20180716

On Sunday 16 February 2025 10:34:32 Eric Biggers wrote:
> On Sun, Feb 16, 2025 at 05:40:26PM +0100, Pali Rohár wrote:
> > This allows to get or set FS_COMPR_FL and FS_ENCRYPT_FL bits via FS_IOC_FSGETXATTR/FS_IOC_FSSETXATTR API.
> > 
> > Signed-off-by: Pali Rohár <pali@kernel.org>
> 
> Does this really allow setting FS_ENCRYPT_FL via FS_IOC_FSSETXATTR, and how does
> this interact with the existing fscrypt support in ext4, f2fs, ubifs, and ceph
> which use that flag?  In the fscrypt case it's very intentional that
> FS_ENCRYPT_FL can be gotten via FS_IOC_GETFLAGS but not set via FS_IOC_SETFLAGS.
> A simple toggle of the flag can't work, as it doesn't provide the needed
> information.  Instead there is a separate ioctl (FS_IOC_SET_ENCRYPTION_POLICY)
> for enabling encryption which takes additional parameters and only works on
> empty directories.
> 
> - Eric

This encrypt flag I have not implemented in the last cifs patch.
For SMB it needs to use additional SMB IOCTL which is not supported yet.
So I have not looked at that deeply yet.

I tested only that setting and clearing compression bit is working over
cifs SMB client, via that additional SMB IOCTL.

