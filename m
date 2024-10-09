Return-Path: <linux-fsdevel+bounces-31459-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C3D99703F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 18:01:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFD75282432
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2024 16:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B421E230B;
	Wed,  9 Oct 2024 15:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="m/8DD3Rb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730D11E22F1
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Oct 2024 15:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728488171; cv=none; b=QYoDdzxwrXEucQkmsZ7sulCFqcWcX059+zeHYd5hGyK8yahE4lFhRdXXy1gu9PXmAZ79kat3qxMFfY3IttzPUfQKQ3VRNMzctkxKfpjZchFgdKL4PBtct1h8BstGS4jfpZPg8G6D719sp1Xudpnjj2F5Nk51QJepISQNGGSwjho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728488171; c=relaxed/simple;
	bh=DJXUO7xJ8zxZ3vj2D2uL4aUr2UI+2aKxMjs90Um1Cuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k/DR18VlNeHAqAsCGHcFlBI8VwufqU7av79gGCZPsRz2FnObmCWAIZNRyD48z9PkqlyqBnJp+amY3pzNO9rF+dJlUTVo26Bbi/K/x136Xj7FVZhG1VAqyTWo/s4XznGtxJK8TCp6VQrxaqTtxBR/TjGdsAFF/q1d2RjzyldS0bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=m/8DD3Rb; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=KV2K+QhfdPpHR2pDsRVaxuinonxIZWZKFTLa5FUEZVg=; b=m/8DD3Rb6kuLNCpDnIc+r1vzMZ
	Gb/gN1n66J++FvIZ0Mt4Xk4IFVig6Vm4x2SEHnoBFDNznC0aNTjx9M9ddFHcQustO64c8vh7Lm2Tj
	E6HkXkodtScnEG/uLiLuRrES1q5sDXtOdRsuKMD8QHW7ZyqIuoJff10cBn18goHAtS+BG9KL0hIJD
	b9On2FPyTlHITcUPOrIBKFys+5RDCtCndc70oDzycO+msq3Vicwh+M/AC4qsj2MiEWJ5xHWdhZ/ic
	iUSjooU9gHRrxTmxHeqMK4E7nOwCxEttvyRwoyF3zMw9jcCChZkqI9IWmDPwWfQxKrGVlVssRx5L0
	qqd6bJ4A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1syYjN-00000002Bdy-3Aah;
	Wed, 09 Oct 2024 15:36:05 +0000
Date: Wed, 9 Oct 2024 16:36:05 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: Steven Price <steven.price@arm.com>, linux-fsdevel@vger.kernel.org,
	torvalds@linux-foundation.org
Subject: Re: [PATCH v3 10/11] make __set_open_fd() set cloexec state as well
Message-ID: <20241009153605.GA4017910@ZenIV>
References: <20241007173912.GR4017910@ZenIV>
 <20241007174358.396114-1-viro@zeniv.linux.org.uk>
 <20241007174358.396114-10-viro@zeniv.linux.org.uk>
 <f042b2db-df1f-4dcb-8eab-44583d0da0f6@arm.com>
 <20241009-unsachlich-otter-d17f60a780ba@brauner>
 <20241009152411.GZ4017910@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009152411.GZ4017910@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Oct 09, 2024 at 04:24:11PM +0100, Al Viro wrote:

> Wait, folded it _where_?  And how did it end up pushed to -next in the
> first place?
> 
> <checks vfs/vfs.git>

Preferred variant force-pushed to #work.fdtable, and pushed to vfs/vfs.git#work.fdtable
as well.

