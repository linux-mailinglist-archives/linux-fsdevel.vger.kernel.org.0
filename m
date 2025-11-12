Return-Path: <linux-fsdevel+bounces-68064-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D79C52E23
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 16:05:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 936BE4A04A6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 14:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EC47340A49;
	Wed, 12 Nov 2025 14:39:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11BC52BEFF3;
	Wed, 12 Nov 2025 14:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762958343; cv=none; b=Vh5dkhxIsZL+c8Znk8PglwXOaJIIGsfWuZv12R9htUnztiQqhwbhQb/sDvGGJ5u8wFR7wThnTc4l/HFhotMEqLYmWe90HNsTE7vXH8UGQJj/AUrugU7IdkTLlqAiLuOIosG2IYv95sErfXPncwQyPTIbMG30f8ZcEqZl+Nv5ISY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762958343; c=relaxed/simple;
	bh=cI8ffqm3gd67ue1Kq31NcC/9D3b2gf4QTsTgwpks86E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LSme3t5zYS/63bAXV0RV/J2VJXNuJqTPmkAd+Nyk7lROy1UN5kM0/h7UKeWXgBskhQIInLIDtm72CaejJUO3ibgMtvq6YC1pvX0Xx1Nj0bXE5ANhUPpmkGNdwmdObeFFiktq07kosGALmXnwuY5B/WaG5L3rDdKDpmD8gtERzZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4372E6732A; Wed, 12 Nov 2025 15:38:58 +0100 (CET)
Date: Wed, 12 Nov 2025 15:38:58 +0100
From: hch <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: hch <hch@lst.de>, Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
	"Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
	Keith Busch <kbusch@kernel.org>, Dave Chinner <david@fromorbit.com>,
	Carlos Maiolino <cem@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: fall back from direct to buffered I/O when stable writes are
 required
Message-ID: <20251112143858.GA3006@lst.de>
References: <aQTcb-0VtWLx6ghD@kbusch-mbp> <20251031164701.GA27481@lst.de> <kpk2od2fuqofdoneqse2l3gvn7wbqx3y4vckmnvl6gc2jcaw4m@hsxqmxshckpj> <20251103122111.GA17600@lst.de> <20251104233824.GO196370@frogsfrogsfrogs> <20251105141130.GB22325@lst.de> <20251105214407.GN196362@frogsfrogsfrogs> <9530fca4-418d-4415-b365-cad04a06449b@wdc.com> <20251106124900.GA6144@lst.de> <aRSXQKgkV55fFtNG@fedora>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRSXQKgkV55fFtNG@fedora>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Nov 12, 2025 at 10:18:40PM +0800, Ming Lei wrote:
> Looks buffer overwrite is actually done by buggy software in guest side,
> why is qemu's trouble? Or will qemu IO emulator write to the IO buffer
> when guest IO is inflight?

It is ultimately caused by the guest.  But just like local software it
is in no way buggy just because you don't like the pattern.


