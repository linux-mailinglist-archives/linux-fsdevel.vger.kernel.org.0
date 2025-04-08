Return-Path: <linux-fsdevel+bounces-45992-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82606A80F4F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 17:09:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 787D6188ED27
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 15:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D071EB194;
	Tue,  8 Apr 2025 15:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manguebit.com header.i=@manguebit.com header.b="KjLe255x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx.manguebit.com (mx.manguebit.com [167.235.159.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB121ADC8D
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Apr 2025 15:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.235.159.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744124759; cv=none; b=srBdzrVp+Y0QqPdjQQYJu4TFa51CkkEMOy1KmvX0pDSapAJ3I4jqp9SNhnnl4rgs4eSTfgTbWfmOZIeCD+L8bxoV2txiYh1EVHwxmvVenM3qDUYmAAroiKXA2rrKelLREIZBT4+OMSXMnwsHy2Cf+1k55N+Hqr2fojOYu7oDK1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744124759; c=relaxed/simple;
	bh=s2X/9rFzJB4T3PChsgKoZEg1SwVf5WwlWcXjxLCBXl0=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Date:
	 MIME-Version:Content-Type; b=ltyvAP7zSoF1o0Yc4P7WpfwV1dvMyARWMcx7EuWZe8rAa33PYUDHnghjol2St0ciORteRh22utbwTGSL+eZtoFDa99NnIXkRpla8/Bq4ghO/ZJaqg3nc7CpgHDEl2O2Wr/Jx61jLGoC3Ot00C9pIPx9/4fZAEYvFfwE3T8UmNhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.com; spf=pass smtp.mailfrom=manguebit.com; dkim=pass (2048-bit key) header.d=manguebit.com header.i=@manguebit.com header.b=KjLe255x; arc=none smtp.client-ip=167.235.159.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manguebit.com
Message-ID: <05f5b9f694ca9b1573ea8e1801098b65@manguebit.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manguebit.com;
	s=dkim; t=1744124755;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1dkAA8mupzq/5aCDd5/oD6P2hZ0bxNUpRBtqdkEU3AI=;
	b=KjLe255xmFm5rKE5iQE2Rdol+nbQi5OqdeQ2rrQDx24FkiykWUHhGzKYsZ1G6iZNcJptAC
	nlAUwtkc5Wg68fLdk1jXyJ9+gTGbZtQnP3T4WHff/p6UI3qoXodq92ULMp512V20NEbMvR
	I67WUUu0v5c6Po0h6P91B1WS0Nq/y6+qlPN//R6x/PPcQHnqFrcnC3JwBmObDZTD1U8SZM
	b0TFKbrvz+/eg8Dm80QM+GewCnHHBKrRk9V7uYsmak0o/WdOXjXn7DxFNHVhDZQOZ9asvI
	bSwIypqpX1d3vbL0oUGj6SqalcPirmFfrwDeqjvxsrI/+kz6jKFiGwc8S7H/rA==
From: Paulo Alcantara <pc@manguebit.com>
To: David Howells <dhowells@redhat.com>
Cc: dhowells@redhat.com, Song Liu <song@kernel.org>, netfs@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] netfs: Let netfs depends on PROC_FS
In-Reply-To: <1478622.1744097510@warthog.procyon.org.uk>
References: <b395436343d8df2efdebb737580fe976@manguebit.com>
 <20250407184730.3568147-1-song@kernel.org>
 <1478622.1744097510@warthog.procyon.org.uk>
Date: Tue, 08 Apr 2025 12:05:52 -0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

David Howells <dhowells@redhat.com> writes:

> Paulo Alcantara <pc@manguebit.com> wrote:
>
>> (2) There's a wrong assumption in the API that @netfs_request_pool and
>> @netfs_subrequest_pool will always be initialized.  For example, we
>> should return an error from netfs_alloc_[sub]rquest() functions in case
>> @mempool == NULL.
>
> No.  The assumption is correct.  The problem is that if the module is built in
> (ie. CONFIG_NETFS_SUPPORT=y), then there is no consequence of netfs_init()
> failing - and fail it does if CONFIG_PROC_FS=n - and 9p, afs and cifs will
> call into it anyway, despite the fact it deinitialised itself.
>
> It should marked be module_init(), not fs_initcall().

Makes sense, thanks.  I tried to reproduce it with cifs.ko and it didn't
oops as netfslib ended up not using the default memory pools as cifs.ko
already provide its own memory pools via netfs_request_ops.

