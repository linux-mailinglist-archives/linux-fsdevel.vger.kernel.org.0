Return-Path: <linux-fsdevel+bounces-10297-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A0A849A0A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 13:24:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 010211C22CA7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 12:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D14F1BC3A;
	Mon,  5 Feb 2024 12:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Enx0eywT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829661B976;
	Mon,  5 Feb 2024 12:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707135882; cv=none; b=n9sI5CY8KvzbawRwVgB14PlcZqbzYmdHBQd37PhGNBX2FId0zhF1DLcl+UhLvNDCdNLSkbV8JM+dELaFCEmWVIEdiWzTydoSWkwbBITCxnYitL7++IJ+8z7HvoRw+6RCONYYSBl95N6aSCrszd7KqFEpGV65/+eHRWFbBfDcbKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707135882; c=relaxed/simple;
	bh=DYSz3/AmfUCUNrCIHwggkc9ZvrhbsImaXeH24bFVUgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hi53tIxZtt4hlEbvzlr4WHMZ6aiRxcL8BY3Ur4XprqwpOlexc1o0ZPl5dmRyB1XMABGak+o6VGXlUFtoRs3Rt710jgq0dnoJUv8ydNLypvog7jWgIHRG1SVTyOBui25AgD+oAQWOAclMdi9M3o+tW9jUo6setaynn/OmY4xfi8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Enx0eywT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F1F8C433C7;
	Mon,  5 Feb 2024 12:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707135882;
	bh=DYSz3/AmfUCUNrCIHwggkc9ZvrhbsImaXeH24bFVUgc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Enx0eywTr3URLdjIomMnSkIsxboOeHJqEuDNXIBir2bSTQq6hu6xAqW0WB5GoUHsL
	 +hql6+cdsqmc5jTgHTiVxCX2XYmX9JkLkNpFdSsken6BbU3R5Mnaa7EvrpAdS2ZJY1
	 ZgEB6zVM2wSe6V6ZjiEItiJYdghMgtr4SYY665I9rpycCNMimmVhLqCeACFRKdwc1W
	 DLADeSwaLPkYpsZRT/OuQvH7KcbCJ+WmX8fH7dRLwNlOgfcN6FNvHarxoBa9l5pYCl
	 qMjHFQ58PObJu2FULsU2slA3aPi05hHCnajeusNXVD795rBljciXbqS7VxIG+836F4
	 lmHtHb7kRFf9g==
Date: Mon, 5 Feb 2024 13:24:37 +0100
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, linux-ext4@vger.kernel.org, linux-nfs@vger.kernel.org, 
	Miklos Szeredi <miklos@szeredi.hu>, linux-cifs@vger.kernel.org
Subject: Re: [PATCH 01/13] fs/super.c: don't drop ->s_user_ns until we free
 struct super_block itself
Message-ID: <20240205-ursprung-sonnig-70018d629239@brauner>
References: <20240204021436.GH2087318@ZenIV>
 <20240204021739.1157830-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240204021739.1157830-1-viro@zeniv.linux.org.uk>

On Sun, Feb 04, 2024 at 02:17:27AM +0000, Al Viro wrote:
> Avoids fun races in RCU pathwalk...  Same goes for freeing LSM shite
> hanging off super_block's arse.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Hah, I once had the same patch for the userns bit because I was
wondering about that,

Reviewed-by: Christian Brauner <brauner@kernel.org>

(Independent of whether or not this is pretty the s_user_ns should
probably be a separate type so it can't be confused with other
namespaces when checking permissions. Maybe I should respin my series
for that if I find the time.)

