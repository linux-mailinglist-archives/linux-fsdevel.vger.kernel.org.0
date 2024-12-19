Return-Path: <linux-fsdevel+bounces-37874-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBAC39F8333
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 19:24:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E30CB1886F85
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 18:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404BF1A239F;
	Thu, 19 Dec 2024 18:24:46 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C7D192D66;
	Thu, 19 Dec 2024 18:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734632685; cv=none; b=SZq+W5GgkPcxUK6WQQMF+9e758IIJo/5JZcpNwstqpZdvdIUoiFhfGXjhvrC36dXvpChlfP9t/0Srir/rS6l2cbzWZPMHqKKMzE4TokfTDUVh+u6faxj5u4AiNNG6UsA2kD7yZ/sWG5k3/ABEyrVMHV019DZqpgc1Bs0C8otEQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734632685; c=relaxed/simple;
	bh=wE6o7RX+uyH9QmeeEGrMNKw65gJXFfCrQbeKqWaH3HM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nzylwTao5wegCP6f0dksEKS8ZB4QI6Ud764BoeY0B/2PUPM4hzdRPEA/AIGOOvHI3vYqQUOH9wr/uxx9T9gpf+uPXeh7r6PUxaHl0g6gWwV7PEFqPPYmHpNhc6Z9KRi3aQU/lZ3yYOgY2s8i9maZgPJJv1mMalx6uIk2F2v9MB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id ABCD968AA6; Thu, 19 Dec 2024 19:24:39 +0100 (CET)
Date: Thu, 19 Dec 2024 19:24:39 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>,
	Carlos Maiolino <cem@kernel.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 03/10] iomap: add a IOMAP_F_ANON_WRITE flag
Message-ID: <20241219182439.GA1186@lst.de>
References: <20241219173954.22546-1-hch@lst.de> <20241219173954.22546-4-hch@lst.de> <20241219180208.GC6156@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241219180208.GC6156@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Dec 19, 2024 at 10:02:08AM -0800, Darrick J. Wong wrote:
> Do we need to error the bio instead of submitting it if
> IOMAP_F_ANON_WRITE is set here?  Or are we relying on the block
> layer/device will reject an IO to U64_MAX and produce the EIO for us?

I'd rather not add an error return where we previously didn't for
catching a grave programmer error.  I wonder if I should also drop
the error handling in the writeback submission to be consistent?


