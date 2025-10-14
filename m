Return-Path: <linux-fsdevel+bounces-64074-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77DB8BD74ED
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 06:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D28D318A685F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 04:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAAA530DD18;
	Tue, 14 Oct 2025 04:47:31 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF40F3043C9;
	Tue, 14 Oct 2025 04:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760417251; cv=none; b=e7m+B2iDs4+GvQ1fDMQaPFlMw7NMROXFqpKzE0gHAL/ByYTsJLNa6heQHbqwicdugFXTzLODtsIybNqNbradaY0mK5N0nSNLBonjtrdnHnxeUFS05quR7Meh59olSoX3PmG2fQ8GqOcbIpMDPpsqO8t9kdF2VmSqw0iD9NlxmAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760417251; c=relaxed/simple;
	bh=e/3FaYR0ZaWuyDsuRhZr8iu+QgZJWlrOblSp/C49OGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VQZEQRxEh0ICuTgJOFwyEJlW2NjhK8VBaZui4cqYEzJV9XUWsy7zjU96Vh0LWEip/UHzPImLXe4AfADPGsRLaqLVUNlb3zGLvTHvJWSBVWRIXX2/3Mq4tzHPU99YsO8gKodbDjpmVGO5bKYSUMUzCEM3pRqLXJPof8L47tS6xqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id D9DED227A88; Tue, 14 Oct 2025 06:47:23 +0200 (CEST)
Date: Tue, 14 Oct 2025 06:47:23 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jan Kara <jack@suse.cz>
Cc: Damien Le Moal <dlemoal@kernel.org>, Christoph Hellwig <hch@lst.de>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>, linux-block@vger.kernel.org,
	v9fs@lists.linux.dev, linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	jfs-discussion@lists.sourceforge.net, ocfs2-devel@lists.linux.dev,
	linux-xfs@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 06/10] mm,btrfs: add a filemap_fdatawrite_kick_nr helper
Message-ID: <20251014044723.GA30978@lst.de>
References: <20251013025808.4111128-1-hch@lst.de> <20251013025808.4111128-7-hch@lst.de> <74593bac-929b-4496-80e0-43d0f54d6b4c@kernel.org> <4bcpiwrhbrraau7nlp6mxbffprtnlv3piqyn7xkm7j2txxqlmn@3knyilc526ts>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4bcpiwrhbrraau7nlp6mxbffprtnlv3piqyn7xkm7j2txxqlmn@3knyilc526ts>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Oct 13, 2025 at 01:58:15PM +0200, Jan Kara wrote:
> I don't love filemap_fdatawrite_kick_nr() either. Your
> filemap_fdatawrite_nrpages() is better but so far we had the distinction
> that filemap_fdatawrite* is for data integrity writeback and filemap_flush
> is for memory cleaning writeback. And in some places this is important
> distinction which I'd like to keep obvious in the naming. So I'd prefer
> something like filemap_flush_nrpages() (to stay consistent with previous
> naming) or if Christoph doesn't like flush (as that's kind of overloaded
> word) we could have filemap_writeback_nrpages().

Not a big fan of flush, but the important point in this series is
to have consistent naming.  If we don't like the kick naming
we should standardize on _flush (or whatever) and have the _range and
_nrpages variants of whatever we pick for the base name.

Anyone with strong feelings and or good ideas about naming please speak
up now.

