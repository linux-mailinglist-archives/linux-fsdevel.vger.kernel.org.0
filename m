Return-Path: <linux-fsdevel+bounces-31048-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ACD29913E6
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Oct 2024 04:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBB7B28441E
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Oct 2024 02:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8881C6B4;
	Sat,  5 Oct 2024 02:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QHifNqcN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6581BC4E;
	Sat,  5 Oct 2024 02:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728094810; cv=none; b=IIKmHdBwH2Q0sb6FgtByTTVG9YQHGs8LLXE/iwy/Sor3nTrG82bavNPuvmiGBHthlVroUAs9HCZuv4TgE9MKco1iRLcniVScqobMRueNDpcoCVhSxb/VLQA8D/K3DnPFj2L2H2WERTBCOgO9FmKqaYN1eTnMhAgi47q/zHJ6Z1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728094810; c=relaxed/simple;
	bh=wU4XClndnzxbLyH9ta8o4QvGuR5lm+L6I1Fo6G0m3IA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PRn5UFDv+HyYObhH4FNGSfJcEERFY2GleTVpWFYJ124SyfKikVHVnAgYIEdptdyrf4udVAAsqlWwfXEBQvZz70EsgdaZRpNoxnTqS1k1Hq2lAN4yQKUM6rEN68xjVzIU6GpLw6dw4DOyayG3dPoxCdsN20SOqIkXCA6EPornz7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QHifNqcN; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wU4XClndnzxbLyH9ta8o4QvGuR5lm+L6I1Fo6G0m3IA=; b=QHifNqcNCw33wkXNamAxGdXVBR
	jm5SjMma1a/btyBtFf+wsku5h6eMiL08AO5xTPL53uiWm8qwAuBxncpz/lm30JM6AKIYXoSC/aOOa
	qs/uycabtPXB/oyabpWVbVqBXVFASDcljsTjW5pJghJQpsHfPwHxz5TTheZ3UmiXDP5L2XeloVMLE
	pyx/aseUaEtEqKMNRuCMQ0mT2K2WUgKLSudqpxfnYkdOvpDPNBMoZpjEriFq6gC/ihokMumHCOFjg
	Y5gMzsTeOflN4FTAtRrYcHAq9m7BSIsVQkEmlNq64U1prd1qOxCCFi9Qj6UuRhEB5rUZg6OXLeDxo
	unXw7gIA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1swuOs-0000000Bqyd-2xLY;
	Sat, 05 Oct 2024 02:20:06 +0000
Date: Sat, 5 Oct 2024 03:20:06 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 02/12] iomap: Introduce iomap_read_folio_ops
Message-ID: <ZwCiVmhWm0O5paG4@casper.infradead.org>
References: <cover.1728071257.git.rgoldwyn@suse.com>
 <0bb16341dc43aa7102c1d959ebaecbf1b539e993.1728071257.git.rgoldwyn@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0bb16341dc43aa7102c1d959ebaecbf1b539e993.1728071257.git.rgoldwyn@suse.com>

On Fri, Oct 04, 2024 at 04:04:29PM -0400, Goldwyn Rodrigues wrote:
> iomap_read_folio_ops provide additional functions to allocate or submit
> the bio. Filesystems such as btrfs have additional operations with bios
> such as verifying data checksums. Creating a bio submission hook allows
> the filesystem to process and verify the bio.

But surely you're going to need something similar for writeback too?
So why go to all this trouble to add a new kind of ops instead of making
it part of iomap_ops or iomap_folio_ops?

