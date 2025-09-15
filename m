Return-Path: <linux-fsdevel+bounces-61353-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B7CB57A01
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 14:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95063166A4F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 12:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E774A3054EC;
	Mon, 15 Sep 2025 12:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TxAMSbmx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530B72FE063
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 12:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757938230; cv=none; b=rwQbX2+U0dmEdI6kTXg53giK4YRP6GjZhWf9fp3FaTYr9VplJ42vvVT1Bna1BPh6MLRbc9b+GAhXqG/cnZ7GMVXAn/gczWPyjI8++X8NPjMgKy1N1p93mjU6isKEUzdL7I87HrMD8257ih4zDRYbyJ6J3dTqg9BkFZHL3TaJ8DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757938230; c=relaxed/simple;
	bh=UJxlllb+SxLt+7MHmifdBvR8Aniq/CrFkAFN2gGFMPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HxW6DVg/+tog1FT79jwyy9DfwkLb7YnNAB2hC288ov3lZtQ3AMBfppFWUVUfIRHdXzKaBCwoWIt6Bn7tNE4nEbnwZodjdKJGkJ8nUiZD8dfm/6+mcMlULT/fRR1t/QAXtG6nLBU3OqKAfbE23IComTCp9wOGn6wpCrepBe0SGwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TxAMSbmx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65EBFC4CEF1;
	Mon, 15 Sep 2025 12:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757938229;
	bh=UJxlllb+SxLt+7MHmifdBvR8Aniq/CrFkAFN2gGFMPU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TxAMSbmxTmoYdH4+oKB0NHC8wSoKAEOU5xPP2drr2X6vaCRCIwqldB15IvQw3Y9Aj
	 SIm42syq4yGwIEW9x5WMxw0p+roktaYANDtMvqODgVH7DHdnufmtnEZ/fhskmuU7fh
	 Lo2FU//Hf6/SR8DVTl9tNW+x6zp60QC8hG70Srnpmd5XUsLi1HrViQ5jQvHKOF6xng
	 +Tvv+jUOgjIrcU36pVOUfs2SHjJj94CqUvfEuCLv4Bmm1MX/VQUhg24yJDVusXd5eu
	 6UIt3gBs8Ca+nq1bmrjXeqzxR78QFLSYHp7fCi0DTAYLwreXMf8GsyAFEzoPLxElgu
	 BC1TIyg4tblIg==
Date: Mon, 15 Sep 2025 14:10:26 +0200
From: Christian Brauner <brauner@kernel.org>
To: NeilBrown <neilb@ownmail.net>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 4/6] VFS: unify old_mnt_idmap and new_mnt_idmap in
 renamedata
Message-ID: <20250915-prasseln-fachjargon-25f106c2da6b@brauner>
References: <20250906050015.3158851-1-neilb@ownmail.net>
 <20250906050015.3158851-5-neilb@ownmail.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250906050015.3158851-5-neilb@ownmail.net>

On Sat, Sep 06, 2025 at 02:57:08PM +1000, NeilBrown wrote:
> From: NeilBrown <neil@brown.name>
> 
> A rename can only rename within a single mount.  Callers of vfs_rename()
> must and do ensure this is the case.
> 
> So there is no point in having two mnt_idmaps in renamedata as they are
> always the same.  Only one of them is passed to ->rename in any case.
> 
> This patch replaces both with a single "mnt_idmap" and changes all
> callers.
> 
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: NeilBrown <neil@brown.name>
> ---

Hah, thanks. I'm stealing this now.

