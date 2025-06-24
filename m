Return-Path: <linux-fsdevel+bounces-52767-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27763AE6590
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 14:53:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C380E407133
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 12:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF0C299AB3;
	Tue, 24 Jun 2025 12:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SvGrCJky"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A9E2980A1;
	Tue, 24 Jun 2025 12:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750769608; cv=none; b=ZDJbd93IjPcxtBwtpRQ98TMxzZ+OJz6FMx6QcD2gJ4gJ4rDdenyvUhSpqNryNInKAe6pljx4k0n8UG/KZjn2bXywzikudroPljTcKvxpMHOv5Cp1ZpC8NUTf/KPB9oZz6jX/GNWNqNSSc36QenM02S0t99t8I2+U9RQUymUBxx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750769608; c=relaxed/simple;
	bh=lDhi+BIDGL5bKLP98ouQ4UZdNdMsRKpcE2ec84G9+Fs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sQrUY9H+y2uQbD0uwpiJq9Eqt2PpWFJiNtjc1B1T1G3uymU9eVd0YW/BeEJu/J0Akwnka5MLYmGUHCV/BECUKii0Nq5pFtqZrdlORr5y8p+m1KYeYuqVPbnnwB/SPhXEoAugQhd2S5qAfUVBb3Ryw5zdE9f90d0OQVk/URIugmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SvGrCJky; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=CA0gRHgVNTMmOjEFtJrjmYAGBNlumVx52ytcBXwtLbg=; b=SvGrCJkyHUkMDWLbncCrTbiOjh
	Dou6AeoGwYupemLSL1zUA8qNSk8Nbf0aoIOdQ3tgLjPs151dIEwglExc5T8LF0mXXN5s6BDJw33/5
	Ppz6grfi0RcQtQuP/hw3jxkulraB3D3tqUvPoWGV6KZKCEIXLzsAa3l3NapGk827B4BrLNJDvdk7R
	tvYobWi/+SX+b9zqFth5AwXv+BT9UYrH2oHbspGStbfb9i41hdakfNxF4VACldGWfDMpUfNJmekaG
	6BlA4wKLvKJokDhqOLwy9aGIqlAVHdJe944XvxTYb0RNzkUNaBJ51tuKCBNQP8eC3CzoDl0lEgG+A
	n3IbIxGA==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uU39M-00000006c80-2n5d;
	Tue, 24 Jun 2025 12:53:20 +0000
Date: Tue, 24 Jun 2025 13:53:20 +0100
From: Matthew Wilcox <willy@infradead.org>
To: =?utf-8?B?6ZmI5rab5rab?= Taotao Chen <chentaotao@didiglobal.com>
Cc: "tytso@mit.edu" <tytso@mit.edu>,
	"hch@infradead.org" <hch@infradead.org>,
	"adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
	"brauner@kernel.org" <brauner@kernel.org>,
	"jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>,
	"rodrigo.vivi@intel.com" <rodrigo.vivi@intel.com>,
	"tursulin@ursulin.net" <tursulin@ursulin.net>,
	"airlied@gmail.com" <airlied@gmail.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"chentao325@qq.com" <chentao325@qq.com>
Subject: Re: [PATCH v2 5/5] ext4: declare support for FOP_DONTCACHE
Message-ID: <aFqfwHofm_eXb5zw@casper.infradead.org>
References: <20250624121149.2927-1-chentaotao@didiglobal.com>
 <20250624121149.2927-6-chentaotao@didiglobal.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250624121149.2927-6-chentaotao@didiglobal.com>

On Tue, Jun 24, 2025 at 12:12:10PM +0000, 陈涛涛 Taotao Chen wrote:
> From: Taotao Chen <chentaotao@didiglobal.com>
> 
> Set the FOP_DONTCACHE flag in ext4_file_operations to indicate that
> ext4 supports IOCB_DONTCACHE handling in buffered write paths.

I think this patch should be combined with the previous patch so we
see all the change needed to support DONTCACHE in one patch.

