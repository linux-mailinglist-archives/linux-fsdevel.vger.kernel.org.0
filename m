Return-Path: <linux-fsdevel+bounces-12071-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF0A85B020
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 01:46:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDC252842E3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 00:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D0F1754C;
	Tue, 20 Feb 2024 00:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Y9Znxt13"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3908B168B7
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Feb 2024 00:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708390000; cv=none; b=bGPBMsx3y8dcuSM1i9WKtHkrtVEOUU4OaXfjsUb2uGcVXv9kQJu16Rc3dT7HfEEWLYv+QWF5GnjkggN9UGCPNBiBDCju3pev9QeAZ1e6KSgFIkammGfkZKrVwRmLxTy4ZHObXs5VFhGOSeU4hbdIiljNb/EuI1VPjp9GR6T5BrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708390000; c=relaxed/simple;
	bh=IHq7xXBfR4eGA3DLcLa0eHo9G45hHpAI14URLOxAASA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rz4ZhO/MUloykzgPB+7YnV1KBBLu7BIhevIEQHurNYia85b6OIs0GlhE6cFiWy8RwPit4nfoVSvpqPG+iDY7HSTjIl5k4xHzR9Mq/HWAvFiHFs/jv+PuQOHkPVW4tnYFxg5BdnjagwPeZGq8bRRolbvmiGK4CWG+OrbQHexcujc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Y9Znxt13; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mv9ZQ//F10IDMLybAVzm4q32cQ0QAh2PFfBRtBR3SF8=; b=Y9Znxt13RY1mxKIodvRTyUzAOE
	lQ001UIphglXE1tBGwWA/BmA0halGcYeQ4DLRlzNEERb1AztWMmkOHzb/22FgoBRk6Y7G9XR657+m
	ClSP/bgVpJbOsVGSbmNKlZ0R+OCVLstmriNvFED7JxINGwBXrErLNEKWZXsdG6Af+6Vbi+Je9lVOu
	vjdhtyQc8sCqtIdwIWQtREfknmwbjSMOlJK99Q8vDKRMjIrAnbmF/kdvIUli4OT+VCKDTrz5WWqHi
	r+DnrqelC4vDLmz2bQJYoYuHh9k/X1i0NZ/yRai4K3ORPI2jKSTe7qZ9W+B/Ojsx4X3d4nSMJcrDa
	82oLbFRQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcEHL-0000000EDJE-3bve;
	Tue, 20 Feb 2024 00:46:35 +0000
Date: Tue, 20 Feb 2024 00:46:35 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Bill O'Donnell <bodonnel@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org
Subject: Re: [PATCH] efs: convert efs to use the new mount api
Message-ID: <ZdP2a9VZ_GOcABY6@casper.infradead.org>
References: <20240220003318.166143-1-bodonnel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220003318.166143-1-bodonnel@redhat.com>

On Mon, Feb 19, 2024 at 06:33:18PM -0600, Bill O'Donnell wrote:
> Convert the efs filesystem to use the new mount API.

Hey Bill, what testing were you able to do for this?  I found some EFS
images, but they didn't have any symlinks in them, so I wasn't able to
test my rewrite of the symlink handling code.  Do you have a source of
EFS images?

