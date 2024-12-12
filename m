Return-Path: <linux-fsdevel+bounces-37229-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B97709EFCF6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 21:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A94D28B53E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 20:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AC841AB51F;
	Thu, 12 Dec 2024 20:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="U6TXCmay"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D668C18732A;
	Thu, 12 Dec 2024 20:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734034009; cv=none; b=QlHpM+o550FUr19k7wy55Vjrp2/lg3qOwxLVg67oA9nD4J3pb/WX/RsKYaLLc+TMY8g5X4aIalq9CajBt7yujKtv2Mqh6aeOJYPBD8cASZvvNlQPo6Mfol3ZE4pGoMpsCWIyJ5iZ28/98uDw1TQm1y8khtJOQTqvkV53IJaf5yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734034009; c=relaxed/simple;
	bh=ZXmP3fy2fyPYe3mXwL0uJP2ulB4zEPc2D23vSLnZCAA=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=vEqBW9TaWOZ8H6pF4pb3UJgB5zh7PcxsHwCk3Yf/V75N03ida0A65fOhwgU/uEx8wv8ql3lW/6aReYZjxhrFT5eQ0Iz9PtA0zDxy4u0bdR0teGeWr0I9/93Pl+bjKoK8w3Nd8CjVEncBKGC9O8ff+woV4hgsrOAMK8XlIP2LNrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=U6TXCmay; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1734034007;
	bh=ZXmP3fy2fyPYe3mXwL0uJP2ulB4zEPc2D23vSLnZCAA=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=U6TXCmayV3GoDU+ps8oU/MHMEV++ePZODpfW0hrPCM8HUhH2TVj0Pb8llvc80MrsK
	 HsG3huz7q6MP7HrmuXVmzFJx/U64t4K5R8OS95FGRfzyo4BMYWWkDEEI/QeHLExCEI
	 1NZslCiNlXA0WerUUNCZRXjrCTEc0ed4Q7gAkC3E=
Received: by gentwo.org (Postfix, from userid 1003)
	id 2C0CC401F4; Thu, 12 Dec 2024 12:06:47 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 2AF72401C4;
	Thu, 12 Dec 2024 12:06:47 -0800 (PST)
Date: Thu, 12 Dec 2024 12:06:47 -0800 (PST)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: Matthew Wilcox <willy@infradead.org>
cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>, 
    "Darrick J. Wong" <djwong@kernel.org>, linux-mm@kvack.org, 
    linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org, clm@meta.com, 
    linux-kernel@vger.kernel.org, kirill@shutemov.name, bfoster@redhat.com
Subject: Re: [PATCHSET v6 0/12] Uncached buffered IO
In-Reply-To: <Z1s7AGxZKhK1V4qv@casper.infradead.org>
Message-ID: <9ebeb874-8fdf-7bdd-a31e-52d94560365c@gentwo.org>
References: <20241203153232.92224-2-axboe@kernel.dk> <e31a698c-09f0-c551-3dfe-646816905e65@gentwo.org> <668f271f-dc44-49e1-b8dc-08e65e1fec23@kernel.dk> <36599cce-42ba-ddfb-656f-162548fdb300@gentwo.org> <f70b7fa7-f88e-4692-ad07-c1da4aba9300@kernel.dk>
 <20241204055241.GA7820@frogsfrogsfrogs> <Z1gh0lCqkCoUKHtC@infradead.org> <04e11417-cf68-4014-a7f7-e51392352e9d@kernel.dk> <2f79ff03-48ee-54bf-b928-e9519b3edfc7@gentwo.org> <383d3adc-e939-44b2-9110-4db9b4477401@kernel.dk>
 <Z1s7AGxZKhK1V4qv@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 12 Dec 2024, Matthew Wilcox wrote:

> Regardless of the user API name, I like PG_streaming for the folio
> flag name.

Streaming I/O seems to be a good name for this ....


