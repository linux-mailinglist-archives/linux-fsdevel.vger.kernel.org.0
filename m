Return-Path: <linux-fsdevel+bounces-4153-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 527C77FCF3E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 07:35:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 838531C20BB5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 06:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66AC1079C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 06:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7058171D;
	Tue, 28 Nov 2023 21:44:30 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 47A2D227A87; Wed, 29 Nov 2023 06:44:27 +0100 (CET)
Date: Wed, 29 Nov 2023 06:44:27 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>,
	Chandan Babu R <chandan.babu@oracle.com>,
	Zhang Yi <yi.zhang@huaweicloud.com>,
	Ritesh Harjani <ritesh.list@gmail.com>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 13/13] iomap: map multiple blocks at a time
Message-ID: <20231129054427.GF1385@lst.de>
References: <20231126124720.1249310-1-hch@lst.de> <20231126124720.1249310-14-hch@lst.de> <20231129052535.GO36211@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231129052535.GO36211@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Nov 28, 2023 at 09:25:35PM -0800, Darrick J. Wong wrote:
> > -	case IOMAP_HOLE:
> > -		break;
> > -	default:
> > -		iomap_add_to_ioend(wpc, wbc, folio, inode, pos);
> 
> Hey wait, the previous patch missed the error return here!

Oh.  I guess that's what you get for rebasing and reordering a little
too much..

> > index b8d3b658ad2b03..49d93f53878565 100644
> > --- a/include/linux/iomap.h
> > +++ b/include/linux/iomap.h
> > @@ -309,6 +309,13 @@ struct iomap_writeback_ops {
> >  	/*
> >  	 * Required, maps the blocks so that writeback can be performed on
> >  	 * the range starting at offset.
> > +	 *
> > +	 * Can return arbitrarily large regions, but we need to call into it at
> > +	 * least once per folio to allow the file systems to synchronize with
> > +	 * the write path that could be invalidating mappings.
> 
> Does xfs_map_blocks already return arbitrarily large regions?  I think
> it already does since I see it setting imap.br_blockcount in places.

Yes, it does try to convert the entire underlying delalloc extent.


