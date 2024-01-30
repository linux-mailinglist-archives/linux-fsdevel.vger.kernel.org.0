Return-Path: <linux-fsdevel+bounces-9502-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86FC3841DD1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 09:32:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CF251F2B6DD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 08:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC8952F62;
	Tue, 30 Jan 2024 08:32:19 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3452C57864;
	Tue, 30 Jan 2024 08:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706603539; cv=none; b=Or2/6nFu9rZyqBQgF4LM6PW+v84jr7RpYvP+/UClEsHBSef3pK4AYMrmZz3mm+LvgxdaZItX/uoraOUo0rZYi+pavjkJy5F1Hhz26ulgGkwDJHLov1nQ3M+/sSEMxQbWNllycQk1qtCFD4fK1URUDAutrUfLfXVaJfWRNh+bt94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706603539; c=relaxed/simple;
	bh=+DwowkvmZLEzmvItjU+Mn4NCS9udjMZ4ZpPJHMGWsLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h0LaiycF1ImCyaXGx278Dd7ZR/7+mhHaqEHec3DmQSsAInEQhgFsgjCJFkfEoDBwLSo+1+v0fRJiddA/maegcmnB5rlceoLyxBO9Pcbs2z9gtdJ5cJNE5dLR3VcZgW/Z3i03CGRwYTuhDPauxNi1YtlXIS0Eh0/kj/pR/Ldg1Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 68A3A68C4E; Tue, 30 Jan 2024 09:32:13 +0100 (CET)
Date: Tue, 30 Jan 2024 09:32:13 +0100
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
	Jens Axboe <axboe@kernel.dk>, "Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH v2 31/34] block: use file->f_op to indicate restricted
 writes
Message-ID: <20240130083213.GA23465@lst.de>
References: <20240123-vfs-bdev-file-v2-0-adbd023e19cc@kernel.org> <20240123-vfs-bdev-file-v2-31-adbd023e19cc@kernel.org> <20240129164934.GA4587@lst.de> <20240129-gastmahl-besoldung-33a6261b10d9@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129-gastmahl-besoldung-33a6261b10d9@brauner>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jan 29, 2024 at 06:09:37PM +0100, Christian Brauner wrote:
> I don't think it's that bad and is temporary until we can
> unconditionally disable writing to mounted block devices. Until then we
> can place all of this under #if IS_ENABLED(CONFIG_BLK_DEV_WRITE_MOUNTED)
> in a single location in block/fops.c so its nicely encapsulated and
> confined.

Oh well.  If Jens is fine with this I can live with it even if I don't
like it too much.  I'll probably just clean it up as a follow up.

OTOH I fear we won't be able to unconditionally disable writing to
mounted block devices anytime soon if ever.


