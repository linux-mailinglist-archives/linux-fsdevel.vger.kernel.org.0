Return-Path: <linux-fsdevel+bounces-48730-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46152AB33D1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 11:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9A5D3A523C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 09:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32D325B1EF;
	Mon, 12 May 2025 09:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QtQlFCRr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098CB258CE6
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 May 2025 09:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747042653; cv=none; b=JHCh6f8JQg/8R+5+q2RFv4XRoQ1brBE47C202ux2xkbXQs51CxCeYvVx9KuCUGPvADQ6wWXU9PfQ6mE5PtOnDt5sZ8/Dk+kEpIpv950+bkME65n5D0W0BeSAPFSuByt+v/OAQ1AfKW7uiyZQViVyR3CBOlvCUBrUs86IurnWbm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747042653; c=relaxed/simple;
	bh=GRqicKjG5xFGuKOw2ZiSrB66EKRAQcp8kK4Lhs6mSoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q/chaHV/AX1mzdtvSUFYDzxkRQIJLAOvNhxUc8Hz49QDNmr5ssFHFyLYcewKZL3NcuiCf6uqnJd0zpPuc89egkhWB98Jc+CeZsb6b46zBRa2iHhz8Shlh9dCNAmEvRv2uMbAiJV/KAL8uPG5aQ7WHJwcARORZy3hSClcbEXm7M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QtQlFCRr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E8FCC4CEE7;
	Mon, 12 May 2025 09:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747042652;
	bh=GRqicKjG5xFGuKOw2ZiSrB66EKRAQcp8kK4Lhs6mSoQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QtQlFCRr2RGd7Ds9sGcD6gvH5pQM6B8YgdgF3/NbcI7KhtII0UHAPU3Kkp6kq+Buz
	 pvsbyVLxaGRjNwLBobqmonAPRTR//6jlB8MPd2Qzez81HnIpmDYY0Ww2kw3WdJ77/8
	 n8HS4oREFp4EmL36Aph+vURDxns7pvS0DVtDmaICqMbe2JaDCK1Qj7vGKbsw3txhFe
	 7XfFWwFq0ervAzTdu1t4GTwMFJsVZe59+WUvi1ANrP4fPBvj6hYlbQs8diIYeyNYDJ
	 MyX2ZL7y9JYH/i3uek1cqO8z7iC5OnOMuaZgQqhloYDhM5pWy9OmMk3jJxULphgAZk
	 rCdVkCkrSJyBQ==
Date: Mon, 12 May 2025 11:37:28 +0200
From: Christian Brauner <brauner@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, John Hubbard <jhubbard@nvidia.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 7/8] selftests/filesystems: create setup_userns()
 helper
Message-ID: <20250512-mausefalle-mausefalle-e36a6e5ed3e6@brauner>
References: <20250509133240.529330-1-amir73il@gmail.com>
 <20250509133240.529330-8-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250509133240.529330-8-amir73il@gmail.com>

On Fri, May 09, 2025 at 03:32:39PM +0200, Amir Goldstein wrote:
> Add helper to utils.c and use it in statmount userns tests.
> 
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

