Return-Path: <linux-fsdevel+bounces-41797-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB725A3769B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Feb 2025 19:34:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D57943AF69D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Feb 2025 18:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E49619E99A;
	Sun, 16 Feb 2025 18:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qhkEZcjk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09124C80;
	Sun, 16 Feb 2025 18:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739730874; cv=none; b=sMhvT67j+QW8Ovx8l7s2We8HipmczfJXeQ4y65e6TYB18BL4jubfjSAZajZ3PsDCe48f1Wi/zbXu5BJ2ea0yfvGNeiZwbJKrP0If/UdFR8DxMchzs8dMW8EnIcNOxOdHhhEzmMvKG8Nt4QNzfcNiSyc3M//F1WoIGGHzst96RIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739730874; c=relaxed/simple;
	bh=y0Fz58j7vi0VBN3VF5dcI2ryZUzEB/p7OPQmK9Xqs4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BIzf6Vv7k6ZGvptAV9/9m0lImKmE+sYyNMPr/XZlz/vs1Pp2qdUuA8UvlinwxYqzyyuQOC4VWpXrIlDHvedN52E93LjrlLU2k0P4IRiMoWdvwVtrOtQBkWcLIesKjn1lDLVD42z09IOU+KGQqPVhoRHS0pXDMDsr8jvXHJ6dB/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qhkEZcjk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B882BC4CEDD;
	Sun, 16 Feb 2025 18:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739730874;
	bh=y0Fz58j7vi0VBN3VF5dcI2ryZUzEB/p7OPQmK9Xqs4k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qhkEZcjkj3r9bHSG+NDGKeHQJqbR1cuwKVV9KKjlvSyxmm0/3EOkmqMTHElNtj2UA
	 +44kRuf83NjFlmKkc4BzkgnuvP3yLxW5FJ4gaXjO1Z/+MgOjIXGrCv47tuxeiRFY57
	 RVL7KESgbDDRfyeMGLTm9T7wAzM1KULsckrRhzeH66eJ1EX3G0n9zkoaA8gdKYiDzc
	 3C8aHwWsipD1Ocj5QKUzp2lTlkqzXa7+QvAar9a3EHZ7wn8wU4AhGhHgTjNxT1dylB
	 hKO2zDDhJ9ShleSBFKwYYeMf8R3NP14pXt0zDg2npHaHUMGntlVq/YCt7kLY2M3IRK
	 XIdvBM4wh7I8A==
Date: Sun, 16 Feb 2025 10:34:32 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
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
Message-ID: <20250216183432.GA2404@sol.localdomain>
References: <20250216164029.20673-1-pali@kernel.org>
 <20250216164029.20673-2-pali@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250216164029.20673-2-pali@kernel.org>

On Sun, Feb 16, 2025 at 05:40:26PM +0100, Pali Rohár wrote:
> This allows to get or set FS_COMPR_FL and FS_ENCRYPT_FL bits via FS_IOC_FSGETXATTR/FS_IOC_FSSETXATTR API.
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>

Does this really allow setting FS_ENCRYPT_FL via FS_IOC_FSSETXATTR, and how does
this interact with the existing fscrypt support in ext4, f2fs, ubifs, and ceph
which use that flag?  In the fscrypt case it's very intentional that
FS_ENCRYPT_FL can be gotten via FS_IOC_GETFLAGS but not set via FS_IOC_SETFLAGS.
A simple toggle of the flag can't work, as it doesn't provide the needed
information.  Instead there is a separate ioctl (FS_IOC_SET_ENCRYPTION_POLICY)
for enabling encryption which takes additional parameters and only works on
empty directories.

- Eric

