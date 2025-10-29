Return-Path: <linux-fsdevel+bounces-66356-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4670AC1CB5A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 19:12:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 384464E04F6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 18:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B992335502B;
	Wed, 29 Oct 2025 18:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VtJ7xI4j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6FD35504C;
	Wed, 29 Oct 2025 18:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761761534; cv=none; b=ZzcZ6ChwFOtPFzWVx+Jl5WD6ujTiWicSKtcCwBs1MYUrJR7cEx9IyHprziX5cDEed0A2jRHjMsShUcSyQzXOHL5Vg8Cza+R/VWb25FiZXp7C578vA+vHkoen3a2TDLOqYYMMQM+uT/PvKEgxc065nyam9SvEWvId86g3v5HRds0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761761534; c=relaxed/simple;
	bh=onCConTm8h8xq2Fs7P5qtQyMLMcrtU5tyC4aX0oTjUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RSUMNudzsBVG7q4fae6jh3NE0JYbr7teUYtVSCpmp+zljzUCFtstyPSrHdaLSFbYVjc6ifGuJborYkDPvVcOLRYt4B+iSaePEttC0mGtu6DrHDE8Gufd2ljJegiVH8ArC/o7JBqQWgfMzmmKvKmm0d2q7+4PTudycGWD54xVnVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VtJ7xI4j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEC1EC4CEF8;
	Wed, 29 Oct 2025 18:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761761534;
	bh=onCConTm8h8xq2Fs7P5qtQyMLMcrtU5tyC4aX0oTjUA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VtJ7xI4j2sLLLtTdHC71KozFmw2yooLE1nkAXJlaw5c2QytWOXRpOroVeuRrPJoqt
	 idw5fwS+cRjhxBZW3lNLhx1A3T28lVlCLOdct0XLuNLexuVpMdFIQHOYCoClu17TRk
	 +UB0jHLphpI3quG6/0E8LZ1uI/YtI1nF9oIbyVue4+Z2gHwJXWXex4o7liYQFc4GiM
	 gGDL+KuO+VJ6T7ZgwhWrm+228+FfGoICDi++s7CsEbO9bXPAgV8ga9WrWwuYBPOhaD
	 d9DqFYZxmx4wr1jsnPdnnUYlt4IRMsXlWJRaEmi03Wedp92rMSduYd1YiBC1WAyCr0
	 0MqnLzxcnzadQ==
Date: Wed, 29 Oct 2025 11:12:13 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Carlos Maiolino <cem@kernel.org>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-raid@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 2/4] fs: return writeback errors for IOCB_DONTCACHE in
 generic_write_sync
Message-ID: <20251029181213.GI3356773@frogsfrogsfrogs>
References: <20251029071537.1127397-1-hch@lst.de>
 <20251029071537.1127397-3-hch@lst.de>
 <20251029160101.GE3356773@frogsfrogsfrogs>
 <20251029163708.GC26985@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251029163708.GC26985@lst.de>

On Wed, Oct 29, 2025 at 05:37:08PM +0100, Christoph Hellwig wrote:
> On Wed, Oct 29, 2025 at 09:01:01AM -0700, Darrick J. Wong wrote:
> > Hum.  So we kick writeback but don't wait for any of it to start, and
> > immediately sample wberr.  Does that mean that in the "bdev died" case,
> > the newly initiated writeback will have failed so quickly that
> > file_check_and_advance_wb_err will see that?
> 
> Yes, this is primarily about catching errors in the submission path
> before it reaches the device, which are returned synchronously.

Ah, ok.

> > Or are we only reflecting
> > past write failures back to userspace on the *second* write after the
> > device dies?
> > 
> > It would be helpful to know which fstests break, btw.
> 
> generic/252 generic/329 xfs/237

Would you mind putting that in the commit message as a breadcrumb for
anyone who comes looking later?

--D

