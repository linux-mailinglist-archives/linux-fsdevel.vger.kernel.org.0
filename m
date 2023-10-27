Return-Path: <linux-fsdevel+bounces-1323-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5194E7D8FE5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 09:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E27392822D5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 07:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B9CC2E3;
	Fri, 27 Oct 2023 07:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QalpgjWK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C369C13D
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 07:32:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 681CB1AC;
	Fri, 27 Oct 2023 00:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=XUhRTa+EsGph2BWAVH5/gahdxEY1XjevoZ+UMDgxahc=; b=QalpgjWKNZB5f8GyX3gE5UCa1X
	seQTj9WSb67Gq8qsg7gG0ujIzvU7i1GTBkqPjjB9u6E292tnZ1vJVAnBIvJ+bLM+T6722rNdeJb7N
	+OVtkrfrOrN0CGpw5ldaz+WNm8eGEeUAGW1782z1wFHM/ZwLIEigKLnzzQP2XNYehXMMFf3WKbQ2n
	TrEUvM99GYxY3kzar28K+dTurUYc5+6KwrsNx2axsxQHJwkqC96OfOxcGlEJZ7VvXvTsSmN8N3X65
	zFaCdEq1AU9zpEumAndvLCsqwMTCBH4jiRqzhoWBBBId65KYzQGB01dNKroYiEyQ3XMzJxYPWYylv
	sMdxOQ4w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qwHKB-00FnxS-1i;
	Fri, 27 Oct 2023 07:32:07 +0000
Date: Fri, 27 Oct 2023 00:32:07 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>, linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 3/4] exportfs: define FILEID_INO64_GEN* file handle
 types
Message-ID: <ZTtnd6Lis8azPirM@infradead.org>
References: <20231023180801.2953446-1-amir73il@gmail.com>
 <20231023180801.2953446-4-amir73il@gmail.com>
 <ZTtTEw0VMJxoJFyA@infradead.org>
 <CAOQ4uxj_R1KyYJqBXykCDUYZUEdXC3x0j1vZdOXsRcSb6dKaRg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxj_R1KyYJqBXykCDUYZUEdXC3x0j1vZdOXsRcSb6dKaRg@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Oct 27, 2023 at 09:43:01AM +0300, Amir Goldstein wrote:
> > Presumable the same for fuse, but for that
> > I'd need to look at how it works for fuse right now and if there's not
> > some subtle differences.
> >
> 
> There are subtle differences:
> 1. fuse encodes an internal nodeid - not i_ino
> 2. fuse encodes the inode number as [low32,high32]
> 
> It cannot use the generic helper.

That's what I almost feared.  It still should use the common symbolic
name for the format just to make everyones life simpler.

