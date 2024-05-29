Return-Path: <linux-fsdevel+bounces-20402-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 700278D2D28
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 08:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A200C1C212BE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 06:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB6A15FCE8;
	Wed, 29 May 2024 06:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0xSCbsz6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54E315F3F3;
	Wed, 29 May 2024 06:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716963862; cv=none; b=hVCzmQc8piphhmG4VHAjczv3DE9J4VNzQEvv9+rBU1nE6JuSA4IJWsBJ4nYzCTbk7FX8Y3Ftf6NKLJVL6IbhKIJ/g1OHHQT4o8cXGO99nyiw48rAJg/DS07KO+unEd9hXxvKT849B0jG03UxapNIfIznReknpaBxGDCUi+31uiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716963862; c=relaxed/simple;
	bh=pPM9ny+kNaumhJIGu8VXl7ieb63WgdrNQQ2r3r86KrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DdX1Mj5XTaavgOOPFoMOGPw81qR9hNb2GMN+BGc5WsTeJqZ9fDIY2TxvuqYSsPikSLeE/pagbKcrAGyBYRt+TBRUsH75W3ijhUG/vCYfTiTcB3bc+R06kM8Um76QToW0YQmslJpg3kupXC9fDi5gjdhd5bj1/R01p1HFNB95zAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=0xSCbsz6; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pPM9ny+kNaumhJIGu8VXl7ieb63WgdrNQQ2r3r86KrU=; b=0xSCbsz68/CidLV/kgNWdm4vmd
	DcnHmjJHBjSaNDwa/7FUP0m+3soqGA6wk+873Rz5SWPyQWnEI7EN29rP3kiCiGHApMqCzQX/seZvu
	CXlg1l52hShvokbOux46Z1WneHxAEN3EIkXY7xwtt7smMWt9uFUz8ce/yF09LPAuQomDg1MqWJPrY
	Noom52EDsVmhX/jDbfsU2tYaP3iV2+Xs11XVxaEv1MSI83BkG0Tog5UknTKEsvRVq4oiYSSfjPdWO
	x3/Pc+ifQSc/kuzL5jEBbm+66V2MPFr0NeZumYqgKKijtP3hGo6XGtPZGdZLa4Zh3k9XAetf8yHuF
	Nnlq5K3Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCCjS-00000002zuE-2aAy;
	Wed, 29 May 2024 06:24:18 +0000
Date: Tue, 28 May 2024 23:24:18 -0700
From: "hch@infradead.org" <hch@infradead.org>
To: Dave Chinner <david@fromorbit.com>
Cc: "hch@infradead.org" <hch@infradead.org>, Jan Kara <jack@suse.cz>,
	Trond Myklebust <trondmy@hammerspace.com>,
	"chuck.lever@oracle.com" <chuck.lever@oracle.com>,
	"linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"brauner@kernel.org" <brauner@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"alex.aring@gmail.com" <alex.aring@gmail.com>,
	"cyphar@cyphar.com" <cyphar@cyphar.com>,
	"viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
	"jlayton@kernel.org" <jlayton@kernel.org>,
	"amir73il@gmail.com" <amir73il@gmail.com>,
	"linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH RFC v2] fhandle: expose u64 mount id to
 name_to_handle_at(2)
Message-ID: <ZlbKEr15IXO2jxXd@infradead.org>
References: <20240523-exportfs-u64-mount-id-v2-1-f9f959f17eb1@cyphar.com>
 <ZlMADupKkN0ITgG5@infradead.org>
 <30137c868039a3ae17f4ae74d07383099bfa4db8.camel@hammerspace.com>
 <ZlRzNquWNalhYtux@infradead.org>
 <86065f6a4f3d2f3d78f39e7a276a2d6e25bfbc9d.camel@hammerspace.com>
 <ZlS0_DWzGk24GYZA@infradead.org>
 <20240528101152.kyvtx623djnxwonm@quack3>
 <ZlW4a6Zdt9SPTt80@infradead.org>
 <ZlZn/fcphsx8u/Ph@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZlZn/fcphsx8u/Ph@dread.disaster.area>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, May 29, 2024 at 09:25:49AM +1000, Dave Chinner wrote:
> But no-one has bothered to reply or acknowledge my comments so I'll
> point them out again and repeat: Filehandles generated by
> the kernel for unprivileged use *must* be self describing and self
> validating as the kernel must be able to detect and prevent
> unprivelged users from generating custom filehandles that can be
> used to access files outside the restricted scope of their
> container.

We must not generate file handle for unprivileged use at all, as they
bypass all the path based access controls.


