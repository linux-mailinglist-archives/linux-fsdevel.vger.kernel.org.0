Return-Path: <linux-fsdevel+bounces-1100-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD9F7D54E1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 17:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE0E71C20880
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 15:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C066C2E659;
	Tue, 24 Oct 2023 15:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="d0OntYfe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FDF2E625
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 15:10:36 +0000 (UTC)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF5B910FA;
	Tue, 24 Oct 2023 08:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Ql2eltEQ8DJZApzT9fh9fzvtNpsHZrs3XNxvxh5UtMA=; b=d0OntYfe0ymPyU6quYfPhRqgcF
	OJxFCZ5PfPy9fB8HnMowNXML29uvEblIoET9udJzrwy3YZNOSsCcVkDS0LucMMqBEVLLiD10NcX5e
	I/xRRf+bmH+76vuIlWn/kMLFmrZjvjcGdbCSf+EOJTcR8TTNYr6h75dXk0j//BJdNgN1od94Uk9S3
	64Y1a2TvoE8Fll/xUUBIjP/3MUkVG7iixoNXWS1+M/koff/mE514g9i13gkaHcPiwUScwKBMgMgSW
	o4WN7pu1SJ9RLUvGq4V28TCcm/xcfitWI36hYIpYm5sXYf3R6z11gWbx6ALlpmiIm9HQlTeif7uo5
	86yxe23A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1qvJ35-0039Gq-9s; Tue, 24 Oct 2023 15:10:27 +0000
Date: Tue, 24 Oct 2023 16:10:27 +0100
From: Matthew Wilcox <willy@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Ilya Dryomov <idryomov@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/3] filemap: add a per-mapping stable writes flag
Message-ID: <ZTfeYzvFV7QoVT1z@casper.infradead.org>
References: <20231024064416.897956-1-hch@lst.de>
 <20231024064416.897956-2-hch@lst.de>
 <20231024150053.GY3195650@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024150053.GY3195650@frogsfrogsfrogs>

On Tue, Oct 24, 2023 at 08:00:53AM -0700, Darrick J. Wong wrote:
> On Tue, Oct 24, 2023 at 08:44:14AM +0200, Christoph Hellwig wrote:
> > Add a per-address_space AS_STABLE_WRITES flag to control the behavior
> > in a more fine grained way.  The existing SB_I_STABLE_WRITES is kept
> > to initialize AS_STABLE_WRITES to the existing default which covers
> > most cases.
> 
> For a hot second I wondered if we could get rid of SB_I_STABLE_WRITES
> too, but then had an AHA moment when I saw that NFS also sets it.

I mean, we could if we're short on flags, or it just offends our
aesthetics to have it.  NFS (and others) would just have to
call mapping_set_stable_writes() in their inode initialisation
routines.  I don't personally find it a big deal either way.

