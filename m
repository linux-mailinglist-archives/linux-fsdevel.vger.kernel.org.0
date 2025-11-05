Return-Path: <linux-fsdevel+bounces-67121-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C45FC35B7B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 13:55:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E8F994F1B7A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 12:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8A03161B5;
	Wed,  5 Nov 2025 12:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AGrDXE0O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B5E315D30;
	Wed,  5 Nov 2025 12:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762347336; cv=none; b=Q+KCEdWKi0d2V23wL0Dbt+n+Hqmi++fQ4CTbCfU/cpL1lLjRQ76UUBnTFvsB91fO8RuAxDx3pAjDAboATNg1+903nH+6je9HJ/HEbf/Pk5Yb8UV5oJJEk1xeBHq/KSINeEYo6a+/qBumx7kNlSCG02Vts6NbEmU/wC+PKT4kIM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762347336; c=relaxed/simple;
	bh=8e4qJfCLwhzYXtGgrCM5lFjzkOOxH/tYAT1to8BQFHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kP5U1tXNvzq23rCPkwCjr0irp8W1gid+Ii5PYw4Yn9qjgAqrSLjKsSru6d0q3tYHbNCGhXg7xxp+102mDEuagKJEx6nYw9+UOw0KCOBOr6L7a5goBaB/a2Lc0nUILdsH4Qo5Ca5fQVrye3q786IHcniNMRHZb2Fs4oCaCV123ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=AGrDXE0O; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8e4qJfCLwhzYXtGgrCM5lFjzkOOxH/tYAT1to8BQFHU=; b=AGrDXE0O0SJXNtEu7dam2Gndvf
	5Jcg1adaPRQFdjaPLG859NnZ2KvC4je7vymWT6yHpNq5lKe2VmbSWLLaLp1l7FwMsI2zY/MoK91so
	Sgr5ga2wXzTEimwgoBYhIYdw8VR+i0/3KNBPYkuxInBXRJQoI3IefW+ts0+B5Sf7F2X+NNRm//jhM
	wlQ479RLhbt3WeM3NYB3vm6xaSW0/eQHa19/SLqaLA5//ZyVdus/C0T6ukJGfjjo7JnPPRNQDcd4+
	b3rWorwA/xpXmjKgNQF9nDirmAcOwCLryCKvOpMs63NfLwOdKg4sKL/krFmH+eArz9/gTMV9ynxHa
	fP1eHe2w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGd30-0000000DiLH-1dxH;
	Wed, 05 Nov 2025 12:55:34 +0000
Date: Wed, 5 Nov 2025 04:55:34 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] fs: start to split up fs.h
Message-ID: <aQtJRisTtkX-Jzen@infradead.org>
References: <20251104-work-fs-header-v1-0-fb39a2efe39e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104-work-fs-header-v1-0-fb39a2efe39e@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Nov 04, 2025 at 03:46:31PM +0100, Christian Brauner wrote:
> Take first steps to split up fs.h. Add fs_super_types.h and fs_super.h
> headers that contain the types and functions associated with super
> blocks respectively.

We have this nice concept called directories for namespace prefixes.
Why not include/linux/fs/*.h for all these split out bits?


