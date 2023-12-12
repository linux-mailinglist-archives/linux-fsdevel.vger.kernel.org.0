Return-Path: <linux-fsdevel+bounces-5700-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1EC280EFF5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 16:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 551B3B20E8A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 15:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F8F75432;
	Tue, 12 Dec 2023 15:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eVfUKNx7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F8BF3;
	Tue, 12 Dec 2023 07:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hJFVEyxAqaTyWKn0xSoqtwuxX6IerRG8qVGzGaggA8w=; b=eVfUKNx7/zwo0Jk2745c8DeHo7
	jfdzDxn3mUmUlDnLLxBVOcyh2AwO1sarWBBQ3lZ0oVuNEwQkVEFl5cl0ug7S5ZnP2S8Gjy8/vMHO5
	yiwOgVoZglwFhIkNpijSLvb6/eZS6Ra2SZdHovI6kYsvtHLuBh/4nRswsA04x3YNKZ8GklgBiUxNP
	XPfJx7dYDDO7OekU/2bEJjDJhNXxmnrwrgnAXftScECU4kXCjj18edbJCSo13/rerkQ7+CodIy33Z
	iloe7U278Oi8ZvdZg9v4rxyYR/S8ouHhc2lCnYMe+nF8dsJ+jAkhwvFNPG/kzRrReBWxJ1YAqCil7
	PhskmXsQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rD4XG-00C1V5-06;
	Tue, 12 Dec 2023 15:19:02 +0000
Date: Tue, 12 Dec 2023 07:19:02 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Christoph Hellwig <hch@infradead.org>,
	John Garry <john.g.garry@oracle.com>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>, linux-ext4@vger.kernel.org,
	Ritesh Harjani <ritesh.list@gmail.com>,
	linux-kernel@vger.kernel.org,
	"Darrick J . Wong" <djwong@kernel.org>, linux-block@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	dchinner@redhat.com
Subject: Re: [RFC 0/7] ext4: Allocator changes for atomic write support with
 DIO
Message-ID: <ZXh55vLzrs9VTGHc@infradead.org>
References: <cover.1701339358.git.ojaswin@linux.ibm.com>
 <8c06c139-f994-442b-925e-e177ef2c5adb@oracle.com>
 <ZW3WZ6prrdsPc55Z@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
 <de90e79b-83f2-428f-bac6-0754708aa4a8@oracle.com>
 <ZXbqVs0TdoDcJ352@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
 <c4cf3924-f67d-4f04-8460-054dbad70b93@oracle.com>
 <ZXhb0tKFvAge/GWf@infradead.org>
 <20231212151613.GA142380@mit.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212151613.GA142380@mit.edu>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Dec 12, 2023 at 10:16:13AM -0500, Theodore Ts'o wrote:
> On Tue, Dec 12, 2023 at 05:10:42AM -0800, Christoph Hellwig wrote:
> > On Tue, Dec 12, 2023 at 07:46:51AM +0000, John Garry wrote:
> > > It is assumed that the user will fallocate/dd the complete file before
> > > issuing atomic writes, and we will have extent alignment and length as
> > > required.
> > 
> > I don't think that's a long time maintainable usage model.
> 
> For databases that are trying to use this to significantly improve
> their performance by eliminating double writes, the allocation and
> writes are being done by a single process.  So for *that* use case, it
> is quite maintainable.

That's not the freaking point.  We need to have proper kernel interfaces
that don't rely on intimate knowledge and control of details.  We need
to build proper genral purpose interfaces and not layer hacks on top of
hacks.


