Return-Path: <linux-fsdevel+bounces-8359-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9FDE83353B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Jan 2024 16:25:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 383E5283E02
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Jan 2024 15:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3029811C8F;
	Sat, 20 Jan 2024 15:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S8vAovvF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7E111718;
	Sat, 20 Jan 2024 15:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705764300; cv=none; b=UQFMbaAw54WcfN5OI2VJf8YnLjWQeZcsGUMqsYLho6TfWR4Q0oAbiz4obQZlXYcE8fb/hppKdDXuqeq8msLCoiMgU16CijUMbDJ3lEp12hfgy5S2hQCyP3+qbO/97PNtLeFHkk/U2LFNnsYoPaxvVF1iFCHJbje3gVIwrGSB6YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705764300; c=relaxed/simple;
	bh=pCRTUE89WbCCD8xmHX5KJpuh7NCmdjg63VnRI9107FQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eVkZh7/VIexs8sNavbviYXBM/gu5a0PM2SiVg3sxcALyr8qB/oDeVTs3H0y8el+CtzVi92zawZ8RWFRt6si+OBRhgFDgpJohptqnC2MIpcmW5dKZmEnn1+UH8sbOMo4m1bieVx/GqmJ1E2B0AGkD4ATzSOvBvsRUt8whLjER8R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S8vAovvF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9974C433C7;
	Sat, 20 Jan 2024 15:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705764300;
	bh=pCRTUE89WbCCD8xmHX5KJpuh7NCmdjg63VnRI9107FQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S8vAovvFDeNN/MP7eTI6VSNy9LiWfk8ZbgU6pAJhhVf+w1ITNlN+Ij9GF4IlwvwnN
	 lslSdxTjpv8Djs59EUiEPxyo53WTOO9Od9DUpX02UJbPGiu+tbowG2hhvQSUVSk4IJ
	 fpEOgx5hnKPKpus8MlHoIJ0ATAhBQvP44QVznFapKvi4ugRWaqmhPbyUPBiwpmhlek
	 tPlFpWLsKImQ9tpRoAi+OWACE3IusA/H26YHQb6hCEj3xoTnUWN7UrP2afW9AA3+vE
	 +4PKP4MDr94yQbcODV85VXNHgwtc3XLq7zO1MOwzwOpUfckPxCWNatCAHn8p7DWhlg
	 Y+oisUAICe3pw==
Date: Sat, 20 Jan 2024 16:24:55 +0100
From: Christian Brauner <brauner@kernel.org>
To: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc: mszeredi@redhat.com, stgraber@stgraber.org, 
	linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>, 
	Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
	Bernd Schubert <bschubert@ddn.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 7/9] fs/fuse: drop idmap argument from __fuse_get_acl
Message-ID: <20240120-bersten-anarchie-3b0f4dc63b26@brauner>
References: <20240108120824.122178-1-aleksandr.mikhalitsyn@canonical.com>
 <20240108120824.122178-8-aleksandr.mikhalitsyn@canonical.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240108120824.122178-8-aleksandr.mikhalitsyn@canonical.com>

On Mon, Jan 08, 2024 at 01:08:22PM +0100, Alexander Mikhalitsyn wrote:
> We don't need to have idmap in the __fuse_get_acl as we don't
> have any use for it.
> 
> In the current POSIX ACL implementation, idmapped mounts are
> taken into account on the userspace/kernel border
> (see vfs_set_acl_idmapped_mnt() and vfs_posix_acl_to_xattr()).
> 
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Seth Forshee <sforshee@kernel.org>
> Cc: Miklos Szeredi <miklos@szeredi.hu>
> Cc: Amir Goldstein <amir73il@gmail.com>
> Cc: Bernd Schubert <bschubert@ddn.com>
> Cc: <linux-fsdevel@vger.kernel.org>
> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
> ---

Ah, that probably became obsolete when I did the VFS POSIX ACL api.
Thanks,
Reviewed-by: Christian Brauner <brauner@kernel.org>

