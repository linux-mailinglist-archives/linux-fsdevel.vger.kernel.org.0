Return-Path: <linux-fsdevel+bounces-36380-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB3B9E2AF3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 19:33:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6B76280C8C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Dec 2024 18:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF791FCF54;
	Tue,  3 Dec 2024 18:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="dL/oMqR9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC9F1E868;
	Tue,  3 Dec 2024 18:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733250807; cv=none; b=etnYPUu2TfvY48yA92KdUXXA6q6DAnsD7KkekAB7oBt8jHjDTYTQdVwNrUh1ViL68GcsMgquGlusatzGcsP+mJwMPD0RgIS7xKV7WaiJ6VGjtB6PZ7XBUFPv4Y5+5bGECf5BcMKb0WAUO2JCMJMC/aGFDKDcPOsZDZa37c/icjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733250807; c=relaxed/simple;
	bh=868O7uD1f9/vz3KiNAZ0JgRlmkcGjH7vnu6EqVBnN+8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ZEmXXXhFguKhC1jpjXrq94i4T2OxahCgltuejkZFT/ArdEuHj9VarTTBDwCobGTrj3FHaxR1C98xAH2b/EqguP4jJwpSkzDS2l4HEEdR1oAE4txC6Oc+WshodUPGEeZCLxFBI6N77U735A5AI7tfFyRf7iqyNPLjaJ9ooS4qAYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=dL/oMqR9; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1733250233;
	bh=868O7uD1f9/vz3KiNAZ0JgRlmkcGjH7vnu6EqVBnN+8=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=dL/oMqR9ufu6rFz2kZW6f5BkF23Uq1V/gE76kfoKKZYaBGYPBrGUkOofxNtcMesfU
	 BTnLA5sKHjKKXbCWAyrcz2vEIMEAVqiV/355BZYb/rdHv3PktHzD9+Gp4myMj7rHAw
	 bUGr763gisDAtuIvtPqQ2ChkaLSQyvtOF1j209Y8=
Received: by gentwo.org (Postfix, from userid 1003)
	id 3157A4069A; Tue,  3 Dec 2024 10:23:53 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 2F1BA401E0;
	Tue,  3 Dec 2024 10:23:53 -0800 (PST)
Date: Tue, 3 Dec 2024 10:23:53 -0800 (PST)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: Jens Axboe <axboe@kernel.dk>
cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org, 
    clm@meta.com, linux-kernel@vger.kernel.org, willy@infradead.org, 
    kirill@shutemov.name, bfoster@redhat.com
Subject: Re: [PATCHSET v6 0/12] Uncached buffered IO
In-Reply-To: <20241203153232.92224-2-axboe@kernel.dk>
Message-ID: <e31a698c-09f0-c551-3dfe-646816905e65@gentwo.org>
References: <20241203153232.92224-2-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 3 Dec 2024, Jens Axboe wrote:

>
> So here's a new approach to the same concent, but using the page cache
> as synchronization. That makes RWF_UNCACHED less special, in that it's
> just page cache IO, except it prunes the ranges once IO is completed.


Great idea and someting that is really important these days.

However, one nit that I have is the use of the term "uncached" for a
folio/page. An uncached "page frame" refers to a page frame that requires
accesses not  going through the cpu cache. I.e. device mappings. This is
an established mm/cpu term as far as I can tell.

So maybe be a bit more specific about which cache this is?

PAGE_CACHE_UNCACHED?

or use a different term. It is cached after all but only for a brief
period. So this may be a "TEMPORAL_PAGE" or so? (Similar to the x86
"non-temporal" stores).



