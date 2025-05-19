Return-Path: <linux-fsdevel+bounces-49463-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D269ABCA72
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 23:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB249179F3D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 21:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B81421B191;
	Mon, 19 May 2025 21:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="HHtJsK+R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3867261D;
	Mon, 19 May 2025 21:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747691829; cv=none; b=JDiC2bPGP+DM/45R6D8yE5m9Y1i803gHORiXpX2ulmVfMHiowkOIScgV7IyatGx+OP6055kJTq2blDO3ntRaxnvHop4doz1SBolt1zGRVuUaGxbeXURbMpTG/+Ly3vYEu3xBRS55U1KhGRXmrI6a/OkYgIGRnNuViRcRQCiFYo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747691829; c=relaxed/simple;
	bh=ZeBADbgjqCbeV4qiUwHj2UBJegbkKLZfRH6vnT5Y4Lw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Dq8h/B2sNmHtgmBeW6EYF3XAYVnFV22ZneAru5OdDwXT5xJ2MKgjVr6Ij8L4kciEr4BwzahTVr0sqxbPqk4yl3X7NqtYW/VWh+y2MOMAC9mpnjAigMAtpWP39F2yt0ZyQC3RWlpK070kwzZDLxSfUpD+WA72xqmQ9uOW8vMRtIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=HHtJsK+R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6781FC4CEE4;
	Mon, 19 May 2025 21:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1747691828;
	bh=ZeBADbgjqCbeV4qiUwHj2UBJegbkKLZfRH6vnT5Y4Lw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HHtJsK+RLMuovnA+1zIaX1T+Nubjt/fvfRkEnuEMq/a9tnLriePLsaWnUdNMj70uE
	 pLC9U9S6jkIgYDrvOgwi8w4MdngRPzNsdkZ+JzUy3IcKDiNr5obX+l1XuU4lvNrGKN
	 PF7aNDOTaxUrc0oniLm7Le4iAalq0AJpdFwnIdtM=
Date: Mon, 19 May 2025 14:57:07 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: David Hildenbrand <david@redhat.com>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara
 <jack@suse.cz>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil
 Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, Pedro Falcato
 <pfalcato@suse.de>, Xu Xin <xu.xin16@zte.com.cn>, Chengming Zhou
 <chengming.zhou@linux.dev>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/4] mm: prevent KSM from completely breaking VMA
 merging
Message-Id: <20250519145707.8f9189a6f845be89d13f6afa@linux-foundation.org>
In-Reply-To: <2be98bcf-abf5-4819-86d4-74d57cac1fcd@lucifer.local>
References: <cover.1747431920.git.lorenzo.stoakes@oracle.com>
	<418d3edbec3a718a7023f1beed5478f5952fc3df.1747431920.git.lorenzo.stoakes@oracle.com>
	<e5d0b98f-6d9c-4409-82cd-7d23dc7c3bda@redhat.com>
	<2be98bcf-abf5-4819-86d4-74d57cac1fcd@lucifer.local>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 May 2025 19:52:00 +0100 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:

> > CCing stable is likely not a good idea at this point (and might be rather
> > hairy).
> 
> We should probably underline to Andrew not to add one :>) but sure can add.

Thank deity for that.

I'll await v2, thanks.  It might be helpful to cc Stefan Roesch on that?



