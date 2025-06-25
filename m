Return-Path: <linux-fsdevel+bounces-52847-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C76C9AE7799
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 08:56:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C582C4A0480
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jun 2025 06:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 940251F7586;
	Wed, 25 Jun 2025 06:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CgIypNKh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CD01DE4D2;
	Wed, 25 Jun 2025 06:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750834592; cv=none; b=qxdf7AW3Yy9CSMOpS5bkx179P3MGbkbWnNaF67mMDFPWYnBwnyPiLQmLk2J1X/v4qb5U7xFeYnSKOHu9mQ7qGM/feRPvT85Nj2eDEsOVVJxbC1bIiYL47p9/lsOj4GLaDL33k4c944CpwNQwHeyPrbcToDyfnqmpykD7wgb4hAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750834592; c=relaxed/simple;
	bh=Uh1WwnNvimTsWyoQ0hTnqc/W/jE8I7xFNWmTFet+yG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qz6lH2Mz0JT88inTB/aLTH33Y0bjN3D3ZdsMcrjvZplbDxecshBQx5QewMyUUvoW+rCK7s740W0R0PZK4KoGXJWzyKJ3MyvHK5Y9/mAmSa0eEKQK/qLgbLuxaM+kc0Ga5LgI06o2chs6AxYODBhBI9UKm9oc7zFbvg6UH9senwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CgIypNKh; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Uh1WwnNvimTsWyoQ0hTnqc/W/jE8I7xFNWmTFet+yG8=; b=CgIypNKhmQ3029o1RKULsD2Xwj
	vR4Dylx++/bDN9hEqSwPvw/3ZAfijYzkWi80sgOWXNcBE7uDwW/nADhc3mj691cB+/aauczS0ueB1
	W1+4ny5XmQr4weZuy0cERCCzvlxXH7Ezo683DTg3ESOh87r42tGjM354mfQfI5d41GxF4fgoRQ4Pm
	LyUNeB4Hq7HT2iCqF9DYpXYKF2aS9MwtV0XMecqbBn51oEpybU8HvkCxJ+dp4WtUnA8iYlsJySN+Q
	YaRTV1EMoqBPLzBiT044IAGB6t7McuLAwZUq0PHXYqREJiEZmCJoBFR4uydwPbtL5TsQvkp98FRm9
	Jjlg8naA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUK3X-00000007k2q-0N1j;
	Wed, 25 Jun 2025 06:56:27 +0000
Date: Tue, 24 Jun 2025 23:56:27 -0700
From: "hch@infradead.org" <hch@infradead.org>
To: =?utf-8?B?6ZmI5rab5rab?= Taotao Chen <chentaotao@didiglobal.com>
Cc: "tytso@mit.edu" <tytso@mit.edu>,
	"hch@infradead.org" <hch@infradead.org>,
	"adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
	"willy@infradead.org" <willy@infradead.org>,
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
Subject: Re: [PATCH v2 0/5] fs: refactor write_begin/write_end and add ext4
 IOCB_DONTCACHE support
Message-ID: <aFudm1ndfN-kTSOx@infradead.org>
References: <20250624121149.2927-1-chentaotao@didiglobal.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624121149.2927-1-chentaotao@didiglobal.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Thanks, I really like the i915 work to stop the shmem abuse.

I still hate it that we just change the write_begin/end ops while still
in the address_space ops vs passing explicit callbacks, because that
means we'll some other version of that abuse back sooner or later :(


