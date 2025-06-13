Return-Path: <linux-fsdevel+bounces-51547-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0FF9AD827E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 07:24:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 593FA16DF9C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 05:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C40D253932;
	Fri, 13 Jun 2025 05:24:48 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D354A2F4321;
	Fri, 13 Jun 2025 05:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749792287; cv=none; b=Y4dSFDNNrB8KJwzJ+eLjNFrdL7vFKr1rNeimfUEZAraVUPwEGbxVHZOltaSsZD8cZelhLyMn+IOpNfDdc5iWF6Viqi84nJI4dWjd9A/UlB+d4ZYyQCTsZt2THgl3umBcRWXVbEN8mL9Z9JFLTqQk3DBR0t/bC0qyd2eJo7ESuYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749792287; c=relaxed/simple;
	bh=7V5k6jhlEQ8+LwuAzKPif7dLYrr5rXc21KBwCcttdF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ELCKnVx6EMt0nSJrb4sCrQY2MWfIIcYirfdZSpSiVAI2XW9qPuEjQ1y8DoV7Ent6PVBKL6LNHjj1Tt9Oggw7IhTvZBsv5pRLU5SedYqQczSRODpaThMtUaOkQ5rBiTTvjN8xq2DoKiI3PofYcox9qh0aBS11ak/xWs/9jFtDRyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9C91068CFE; Fri, 13 Jun 2025 07:24:32 +0200 (CEST)
Date: Fri, 13 Jun 2025 07:24:32 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	Ira Weiny <ira.weiny@intel.com>, Christoph Hellwig <hch@lst.de>,
	linux-block@vger.kernel.org, ceph-devel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/5] Remove zero_user()
Message-ID: <20250613052432.GA8802@lst.de>
References: <20250612143443.2848197-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250612143443.2848197-1-willy@infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Jun 12, 2025 at 03:34:36PM +0100, Matthew Wilcox (Oracle) wrote:
> The zero_user() API is almost unused these days.  Finish the job of
> removing it.

Both the block layer users really should use bvec based helpers.
I was planning to get to that this merge window.  Can we queue up
just the other two removals for and remove zero_user after -rc1
to reduce conflicts?


