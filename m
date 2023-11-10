Return-Path: <linux-fsdevel+bounces-2723-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F5937E7C80
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Nov 2023 14:23:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD781B20D1B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Nov 2023 13:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A935E199DC;
	Fri, 10 Nov 2023 13:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BoI3D7Ab"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FAC418E16
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Nov 2023 13:23:21 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B198A751F
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Nov 2023 05:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=GACQSF8NRl/NrGMg3A8j/EAingrg8V76JXOgvttSRkY=; b=BoI3D7AbH30C43IT+8DnbyiVA0
	35eOYTfGzd3WOnHXOdnkHtmXCEfGOcAZkmXnnHEIkhlzczFQl1oxpzuuq7/NUk66q+JcnWjIQ14as
	l2XqR6dLytVscqAg8Fb8/UN8CeVSn77R0+ZxuEfUgnua2ZCEyMda4u9xSs3UzvGRFgPlwr6copx0C
	hjtwgjbh/byVxVDdGoh6lQHd21k5BWOu2XdbP4ievULsCFCqiPxZSWCcDDMOqPCNWWsizF+CjwPwe
	nOcXQr7i0C+XzOxtIQg0nwZ8hwno+Udl8jk25dDusa/fb64RtNwuloioljiKo8tXruq9iJZz2k1cn
	3IBOxWog==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1r1RTZ-00DeBL-M0; Fri, 10 Nov 2023 13:23:09 +0000
Date: Fri, 10 Nov 2023 13:23:09 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Hannes Reinecke <hare@suse.de>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Pankaj Raghav <p.raghav@samsung.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 3/7] buffer: Fix grow_buffers() for block size >
 PAGE_SIZE
Message-ID: <ZU4uvQRHC5+2xOUL@casper.infradead.org>
References: <20231109210608.2252323-1-willy@infradead.org>
 <20231109210608.2252323-4-willy@infradead.org>
 <CAKFNMokB=jtjLTnu_qTKUvCbrxACq3X2+gQzJOqJkB68pO_Ogg@mail.gmail.com>
 <CAKFNMok+xpU7FiWdnUOJS_5EKboKEn7+WXvquHJMiE69-t78yg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKFNMok+xpU7FiWdnUOJS_5EKboKEn7+WXvquHJMiE69-t78yg@mail.gmail.com>

On Fri, Nov 10, 2023 at 08:29:41PM +0900, Ryusuke Konishi wrote:
> On Fri, Nov 10, 2023 at 3:37 PM Ryusuke Konishi wrote:
> > > +       return grow_dev_folio(bdev, block, pos / PAGE_SIZE, size, gfp);
> >
> > "pos" has a loff_t type (= long long type).
> > Was it okay to do C division directly on 32-bit architectures?
> 
> Similar to the comment for patch 5/7, can we safely use the generally
> less expensive shift operation "pos >> PAGE_SHIFT" here ?

If your compiler sees x / 4096 and doesn't optimise it to x >> 12,
you need a better compiler.

