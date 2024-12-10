Return-Path: <linux-fsdevel+bounces-36913-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D81789EAF86
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 12:15:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A29801888539
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 11:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FDFA225403;
	Tue, 10 Dec 2024 11:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Xr2bLjiU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF3D212D75;
	Tue, 10 Dec 2024 11:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733829017; cv=none; b=O23UpkwweaoCBKvO+ceK/bfwIjZRctMGRi2m8GJpDf8EY8lrxBWLynxEJtxfUVkb9RtjuhTq4f7+WrL6AEvODuFmYmkzRzJ45VwaZpYIZj5Vqy2oB8PHOyZ/lhyLf04yZIXNO3EfslK/LoajfsC7UHHUcc7NSwPMvW0yErPuEl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733829017; c=relaxed/simple;
	bh=gf25texq9C3Dmbh/TtwEq/oy9OQsVE27LKR9a8BC02U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jhfN1xeJGFnSMmf254O7V81xz4ztU3wANVGEMkKiCfKVlWkFX/+z9CvGQLqnFx/5N76vYJR1sQzxuSG6289Vm7k6MI+AMKvopH8VA+wSL47g1GximAJY2yBltle/teCaEaxBANpXonmeN+VM/O6rYvHLwBzjK5JrxmtunowsLoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Xr2bLjiU; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=e9e07hwQlKHQNMUUVWbYd995qemIyLnz5bmr+VEdN5I=; b=Xr2bLjiUdM1UixtWjgQH+yjyyr
	MwYdCbPcfryKkcqYDfugDtNVtBd7mkR9EZRCfaBdAI78Hf8ClyPV7/hy5VN2H13iSsyG7sYxTpR4R
	OOlHz1jqVlv2WF7yPc/6hlvs5jCvp/P8m/kyVkJ/KM+0/TBFaFcEJU/VdZXHasb8Gw7PRfFXmxn6M
	trB8K1nzT3V9x6e2JNYrntmlm92AEnsApGBS6TJ/PVvOfmQLxUweSgCYTeZWe73NhxKALJAwfXzhx
	25/AZpV7UQ08VtNwzhtScjk0W3cYRR5mA3/pO+Bh+4zMH2yI9RVjmG6mH2NjfnyTtdiBCNsCu17uM
	XScVQ7VA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tKy84-0000000BGNf-2eGP;
	Tue, 10 Dec 2024 11:10:12 +0000
Date: Tue, 10 Dec 2024 03:10:12 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Erin Shepherd <erin.shepherd@e43.eu>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
	stable <stable@kernel.org>, Greg KH <gregkh@linuxfoundation.org>,
	Jens Axboe <axboe@kernel.dk>, Shaohua Li <shli@fb.com>
Subject: Re: [PATCH 0/4] exportfs: add flag to allow marking export
 operations as only supporting file handles
Message-ID: <Z1ghlNpEOQ8jmZnW@infradead.org>
References: <20241206160358.GC7820@frogsfrogsfrogs>
 <CAOQ4uxgzWZ_X8S6dnWSwU=o5QKR_azq=5fe2Qw8gavLuTOy7Aw@mail.gmail.com>
 <Z1ahFxFtksuThilS@infradead.org>
 <CAOQ4uxiEnEC87pVBhfNcjduHOZWfbEoB8HKVbjNHtkaWA5d-JA@mail.gmail.com>
 <Z1b00KG2O6YMuh_r@infradead.org>
 <CAOQ4uxjcVuq+PCoMos5Vi=t_S1OgJEM5wQ6Za2Ue9_FOq31m9Q@mail.gmail.com>
 <15628525-629f-49a4-a821-92092e2fa8cb@oracle.com>
 <d74572123acf8e09174a29897c3074f5d46e4ede.camel@kernel.org>
 <337ca572-2bfb-4bb5-b71c-daf7ac5e9d56@oracle.com>
 <20241210-gekonnt-pigmente-6d44d768469f@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210-gekonnt-pigmente-6d44d768469f@brauner>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Dec 10, 2024 at 11:13:16AM +0100, Christian Brauner wrote:
> So I'm happy to drop the exportfs preliminary we have now preventing
> kernfs from being exported but then Christoph and you should figure out
> what the security implications of allowing kernfs instances to be
> exported areare because I'm not an NFS export expert.

I'm pretty sure you can do all kinds of really stupid things with it,
and very few if any useful ones.  But the litmus tests is if those are
things that only the kernel nfs server can do vs things that a userland
nfs (or other protocol) server could do the open by handle syscalls.
Because if they aren't specific to the kernel nfs server they are just
random policy for privileged actions.


