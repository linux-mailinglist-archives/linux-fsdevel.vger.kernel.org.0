Return-Path: <linux-fsdevel+bounces-58963-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FEF6B33811
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 09:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4E37168AAD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 07:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D610B299943;
	Mon, 25 Aug 2025 07:47:50 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0151E28F1;
	Mon, 25 Aug 2025 07:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756108070; cv=none; b=mZfGuHmBdYRxKlWCT1szXhQDzS5WGFI4UT0qKVHMjcnGYRJAOSvOkN/3mmFaPxibtlG4QL0EfXJ567pW9k9rRL83cQvwMmF7acT4bpvpYa0nR6ZmKQCb+YJ26b76E9+VmCu/tLk4UygncDCqv23VfhQz1Of098/yR/OauUsPosI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756108070; c=relaxed/simple;
	bh=QKU7esTWyDUdMoZwVQgLnHgWqiU0SSVuZEwfI6EgotQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HwGGxxV//Ar4eqSTFFkdSAgWAwWLW55d1I9OrPYRtFu4ECkWqYLwFrFGRhLgqaN66A/7aSu9pgyLe6Qj/TLLtL0B+zLdShsbW/IsqJJJG4DxAEAOQ5CKyLp16MoMp/tqxaCf69ThIICPqg2gbqje3NuxvNXvoH55C3voD2F8d5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 50C3968AA6; Mon, 25 Aug 2025 09:47:45 +0200 (CEST)
Date: Mon, 25 Aug 2025 09:47:44 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, snitzer@kernel.org, axboe@kernel.dk,
	dw@davidwei.uk, brauner@kernel.org, hch@lst.de,
	martin.petersen@oracle.com, djwong@kernel.org,
	linux-xfs@vger.kernel.org, viro@zeniv.linux.org.uk,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv3 3/8] block: align the bio after building it
Message-ID: <20250825074744.GF20853@lst.de>
References: <20250819164922.640964-1-kbusch@meta.com> <20250819164922.640964-4-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819164922.640964-4-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

Also with this we should be able to drop the iov_iter_alignment check
for always COW inodes in xfs_file_dio_write.  If you don't feel like
doing that yourself I can add it to my todo list.


