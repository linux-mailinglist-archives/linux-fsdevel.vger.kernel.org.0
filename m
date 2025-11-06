Return-Path: <linux-fsdevel+bounces-67304-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 256FBC3B03E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 06 Nov 2025 13:56:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F22E81886693
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Nov 2025 12:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78FDE3314D2;
	Thu,  6 Nov 2025 12:49:09 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB4232B9AF;
	Thu,  6 Nov 2025 12:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762433349; cv=none; b=WTNnhhWYr3nYvzeZ8nHL4xIyRn0W41alKesWwvmtF4Db3VYyeqG/dNr2ePonEQJ/mStkoQ/ynkmUN3pIQMgfyxH3RHsyRk0dYD+dCRsEOmE5wV134uj5lOSATj+8gP70+82XRFxw1wABn4JoxAginnHS5MrWP9b8fJ0DuwI+BUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762433349; c=relaxed/simple;
	bh=AAcmMA1g/UsJicNcMiuPDIq1WYbpJDVtTTqPRl9ZtDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m7w7Ycv3OED4e+Ym+Z2f8VW6woPCFmOLT+vYqte5fhgZ9ao7vMYqorax03khLVNGfUjunpn1SGGDQFXGUgeULY6fh72u4SNrLsGqPzCos4jtJ6lwOmrg230IfIN2Okhh8rhWEDi7HuldckXFmIpM3CSJPAcrvRYtorZk8sDzeZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C090B227A87; Thu,  6 Nov 2025 13:49:00 +0100 (CET)
Date: Thu, 6 Nov 2025 13:49:00 +0100
From: hch <hch@lst.de>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, hch <hch@lst.de>,
	Jan Kara <jack@suse.cz>, Keith Busch <kbusch@kernel.org>,
	Dave Chinner <david@fromorbit.com>,
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
Message-ID: <20251106124900.GA6144@lst.de>
References: <aQPyVtkvTg4W1nyz@dread.disaster.area> <20251031130050.GA15719@lst.de> <aQTcb-0VtWLx6ghD@kbusch-mbp> <20251031164701.GA27481@lst.de> <kpk2od2fuqofdoneqse2l3gvn7wbqx3y4vckmnvl6gc2jcaw4m@hsxqmxshckpj> <20251103122111.GA17600@lst.de> <20251104233824.GO196370@frogsfrogsfrogs> <20251105141130.GB22325@lst.de> <20251105214407.GN196362@frogsfrogsfrogs> <9530fca4-418d-4415-b365-cad04a06449b@wdc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9530fca4-418d-4415-b365-cad04a06449b@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Nov 06, 2025 at 09:50:10AM +0000, Johannes Thumshirn wrote:
> On 11/5/25 10:44 PM, Darrick J. Wong wrote:
> > Just out of curiosity -- is qemu itself mutating the buffers that it is
> > passing down to the lower levels via dio?  Or is it a program in the
> > guest that's mutating buffers that are submitted for dio, which then get
> > zerocopied all the way down to the hypervisor?
> 
> If my memory serves me right it is the guest (or at least can be). I 
> remember a bug report on btrfs where a Windows guest had messed up 
> checksums because of modifying inflight I/O.

qemu passes I/O through, so yes it is guest controller.  Windows is most
famous, but the Linux swap code can trigger it easily too.


