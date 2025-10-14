Return-Path: <linux-fsdevel+bounces-64075-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 882BEBD750E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 06:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E41A718A6F07
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 04:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C3130CDBB;
	Tue, 14 Oct 2025 04:49:13 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807322D8DA3;
	Tue, 14 Oct 2025 04:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760417352; cv=none; b=YfnCMvV5o78U+iqiK2YIB7Q9F29g17lA15pHERiZWz/r+sykIZuVuVssH0kUkN66nbI5uNRzzaJprw8xts0DYLzsTAJj50U7CP80gUqH3ljiFOmX6a5DXIDemK4nZiSHzapSdLcYriyLq1NGStW8XGapNMPyn8jvCVNBFbdkXLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760417352; c=relaxed/simple;
	bh=3oPnSADyAPkXRYmeLfhLFu+3WjNt9gQRS1Wdz3aKtn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H4274M41et/FuhA0GCL51sMoXSBsgAJMv2Dujh39kAelmd0P8psTL7dk5/qVgxzhadOuEOQ4gkKbr20Lloh75gieHBizPiBAASE6JCofPCObp9spRXfHOtjZqQWYW0baAtSqmdZiR/lBJvKSsn4uzRuLjrEf3LlD9uU0RWhCG3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id D0523227A8E; Tue, 14 Oct 2025 06:49:06 +0200 (CEST)
Date: Tue, 14 Oct 2025 06:49:06 +0200
From: Christoph Hellwig <hch@lst.de>
To: David Hildenbrand <david@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>,
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
	Josef Bacik <josef@toxicpanda.com>, Jan Kara <jack@suse.cz>,
	linux-block@vger.kernel.org, v9fs@lists.linux.dev,
	linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
	ocfs2-devel@lists.linux.dev, linux-xfs@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 06/10] mm,btrfs: add a filemap_fdatawrite_kick_nr helper
Message-ID: <20251014044906.GB30978@lst.de>
References: <20251013025808.4111128-1-hch@lst.de> <20251013025808.4111128-7-hch@lst.de> <41f5cd92-6bd8-46d4-afce-3c14a1cd48dc@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41f5cd92-6bd8-46d4-afce-3c14a1cd48dc@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Oct 13, 2025 at 02:48:48PM +0200, David Hildenbrand wrote:
>>   +/*
>> + * Start writeback on @nr_to_write pages from @mapping.  No one but the existing
>> + * btrfs caller should be using this.  Talk to linux-mm if you think adding a
>> + * new caller is a good idea.
>> + */
>
> Nit: We seem to prefer proper kerneldoc for filemap_fdatawrite* functions.

Because this is mentioned as only export for btrfs and using
EXPORT_SYMBOL_FOR_MODULES I explicitly do not want it to show up in
the generated documentation, so this was intentional.  Unless we want
to make this a fully supported part of the API, in which case the export
type should change, and it should grow a kerneldoc comment.


