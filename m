Return-Path: <linux-fsdevel+bounces-20227-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 798D98CFF58
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 13:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 184B8B214ED
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 11:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1FC15E5D3;
	Mon, 27 May 2024 11:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Tm3ERKhK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CA4152DF2;
	Mon, 27 May 2024 11:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716810555; cv=none; b=EgUikl6We4iJbD6NLOFrm5jR56T1HbqjVfMwMMUYk0nvoo6Ht1+tL7W00AKXJd35GGggPGHZP65zThW10wViRnqbjngJ/iCmv7YaXGytBn8RL7nCiEgFjTbKmU+keDm4rkxCVbkP0B956bEN+zRuu5cL2mEpaZNJOedZd9H1q98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716810555; c=relaxed/simple;
	bh=S9iEtbcbQ6v8JNb1XyAe+4akSByNCrDVjasdUAlfmI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m299429O67LjZSuUJKlz5KhKwzRPWpHqg0j8VG5oovsEKAdI+4dB/p4scbfDlHF3C3jOKbziqbkcO6l+FlewZfI1lphgqWSwmziNtCFUmxMV+mBBwldO+4oblKtxvPlrMWydemRQf4ryDjVZ95OfQ4K06Par0sNZ0Pu8HEDA2ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Tm3ERKhK; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wOXMdt3Ms8hhij4gL90hWlwMFeUe+WZXW6F2hZtmtd4=; b=Tm3ERKhKPEr55SUkifTtJi4YaA
	Lymh32H6OdTm09tutGPkpCx3vk9ZaoLjojkPSW62G5ivIfGS5S6wCcbWGXBYUa/v8Uecaaek2vOoK
	CTK1v/Hz8FsaL8/m92oNO1kMdY5SE4cD0tZnLkwQckXeyyWBILO8Aiyk6clmNO3uiWhqVFzRY0oCc
	thLGqIOgwJ1LXFx2/XelFS7W8NrkMX0SdAVlcbSsg7dHkYESjacr/jAvf+tr+XArqs7ufEHZGhvWu
	MClZXr2omkgvnfuDHzGpPGfetH09eemjm10RYaapxjjknllMva+wFiZ0y0spoonI2W9cufvxdIzbR
	BnQSgmLA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBYqk-0000000Ek5f-3xs8;
	Mon, 27 May 2024 11:49:10 +0000
Date: Mon, 27 May 2024 04:49:10 -0700
From: "hch@infradead.org" <hch@infradead.org>
To: Trond Myklebust <trondmy@hammerspace.com>
Cc: "cyphar@cyphar.com" <cyphar@cyphar.com>,
	"hch@infradead.org" <hch@infradead.org>,
	"jack@suse.cz" <jack@suse.cz>,
	"brauner@kernel.org" <brauner@kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
	"chuck.lever@oracle.com" <chuck.lever@oracle.com>,
	"alex.aring@gmail.com" <alex.aring@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
	"jlayton@kernel.org" <jlayton@kernel.org>,
	"amir73il@gmail.com" <amir73il@gmail.com>,
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH RFC v2] fhandle: expose u64 mount id to
 name_to_handle_at(2)
Message-ID: <ZlRzNquWNalhYtux@infradead.org>
References: <20240523-exportfs-u64-mount-id-v2-1-f9f959f17eb1@cyphar.com>
 <ZlMADupKkN0ITgG5@infradead.org>
 <30137c868039a3ae17f4ae74d07383099bfa4db8.camel@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30137c868039a3ae17f4ae74d07383099bfa4db8.camel@hammerspace.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Sun, May 26, 2024 at 10:32:39PM +0000, Trond Myklebust wrote:
> I assume the reason is to give the caller a race free way to figure out
> which submount the path resolves to.

But the handle op are global to the file systems (aka super_block).  It
does not matter what mount you use to access it.

Snip random things about userland NFS servers I couldn't care less
about..

