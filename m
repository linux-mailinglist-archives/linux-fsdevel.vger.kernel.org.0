Return-Path: <linux-fsdevel+bounces-1299-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC197D8E6B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 08:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CCC6B2138A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Oct 2023 06:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E15548C13;
	Fri, 27 Oct 2023 06:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="izdrcBPX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6B18BFB
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Oct 2023 06:05:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB8691A7;
	Thu, 26 Oct 2023 23:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=oVbebL76c6pNB/fIpdsjTZraPC/lGT/ZH6e5WyTTbGc=; b=izdrcBPXER4dUIv+toGALj1awf
	G186Q6nv2yxki9Pa2jPQlfjIIQUqxFRMuaAkS64VBslZ+UXS3wUKNn4ik2WbLAIG9y94yfYB1G8mo
	GcygmEgelrnkuNmiw7sZiXpQ6KXpheSVT1AhU3SIh+ERI4AiPxg+2rZ4VgWxi3iEW/8Cbpxl8XVNY
	lREVOK8bhhcq5ZUqLrVBo9MSK0+vfVqgu1MJJ0cVUIrogbgpSz9P7v5qQPn2NUOvyC2kNm8DGPxWT
	GnjBW4rZPFZMcUSnpdRdOzhzr3fMjtIwXj0oCq0HTqTSioTqQ/Njzul+VT6etT11PyZtJ+S5WRm8H
	lijxp++Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qwFxz-00FeMg-08;
	Fri, 27 Oct 2023 06:05:07 +0000
Date: Thu, 26 Oct 2023 23:05:07 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>, linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH v2 3/4] exportfs: define FILEID_INO64_GEN* file handle
 types
Message-ID: <ZTtTEw0VMJxoJFyA@infradead.org>
References: <20231023180801.2953446-1-amir73il@gmail.com>
 <20231023180801.2953446-4-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023180801.2953446-4-amir73il@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Oct 23, 2023 at 09:08:00PM +0300, Amir Goldstein wrote:
> Similar to the common FILEID_INO32* file handle types, define common
> FILEID_INO64* file handle types.
> 
> The type values of FILEID_INO64_GEN and FILEID_INO64_GEN_PARENT are the
> values returned by fuse and xfs for 64bit ino encoded file handle types.

Please actually switch xfs to fully use the helpers instead of
duplicating the logic.  Presumable the same for fuse, but for that
I'd need to look at how it works for fuse right now and if there's not
some subtle differences.


