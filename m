Return-Path: <linux-fsdevel+bounces-19146-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4475A8C0A7A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 06:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01AB7283AC4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 May 2024 04:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8DD31482EB;
	Thu,  9 May 2024 04:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="Zb9fEPca"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F571E4A4
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 May 2024 04:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715228827; cv=none; b=NxL9aOSN+gfhHxCTdq3Sn+rmtjBlLgF7MTDEY+Q5kH7fCq3VNdILMfYWn/9OQPczRnGp/Gp4BQXp8yHiv1JGLCfdgdAWMoqTDbV9oN4x7mM3b9McqCDs8eNCQYHljfOJj/iF5jTJ+wH0FduE2ZmQQOUMsn+J0KOPHIl/Ztfe0lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715228827; c=relaxed/simple;
	bh=LyoT4oyf2JkYhdBGq4WX3GtaYvrdFj8xQe8WNaN+o50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B5a2WjdPaaHr+SwPMRygtOJmRiLzPwsT8a7nEXhr94WVeP7OqyLsgffSUT4I3u2cgDKmLnrRN+OKVMfskBEHYagYCoJyirmIfsAyjS3Lkg+6BcqbBJ9T5+oe+gRPbGxnOX8zH0wI8f1cEqU8flsKPlWON7j8NQf/UCWwsZ2iYXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=Zb9fEPca; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-113-2.bstnma.fios.verizon.net [173.48.113.2])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 4494QuFU028579
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 9 May 2024 00:26:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1715228818; bh=cQ75vJGhK5WBcOt8tN6YRPu17x2I/Obo0LVgBKs/kMM=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=Zb9fEPcaTbaGmmiDxvsE04PITbAtDwsL/shHHk/9rv3CFRdReoIh38abuJ2IpkTbT
	 +Q/+wolQ6Dab7uDRCevTc8oenrgJ4rJZ0UKvvrCZsS1HolkMLHeRx24HzPiXkTq/u0
	 Uz8ZkXIJBRNr5FdP5Cda++JoScwOU+TR6X+RTWwpd5TsfCOzuLXL5w+QPam2dxM7BC
	 rk1zMNJDt7ixiwF1g0+f2fw2McHSYtyqNuqHKcwO4JLVrBue1i7AS95N9HRCziu26x
	 mhvwvY0OJcYdkDK8fvxgIGE072WoGPOFIBot2yLYe+1VaH48UUXv1Txgmh9Lid7TLr
	 iOc4/nOxUr/KA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 9A05915C026D; Thu, 09 May 2024 00:26:56 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux-fsdevel@vger.kernel.org,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH 00/30] Remove PG_error flag
Date: Thu,  9 May 2024 00:26:54 -0400
Message-ID: <171522877760.3633898.594946816684974089.b4-ty@mit.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240420025029.2166544-1-willy@infradead.org>
References: <20240420025029.2166544-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sat, 20 Apr 2024 03:49:55 +0100, Matthew Wilcox (Oracle) wrote:
> We've been steadily reducing the number of places which rely on
> PG_error.  There are only two left, so the first five patches remove
> those dependencies.
> 
> Every patch after the jfs patch is independent, and can be taken by the
> respective maintainer immediately.  They might depend on patches I sent
> in the last week or two (eg jfs, ntfs3).
> 
> [...]

Applied, thanks!

[10/30] ext4: Remove calls to to set/clear the folio error flag
        commit: ea4fd933ab4310822e244af28d22ff63785dea0e

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

