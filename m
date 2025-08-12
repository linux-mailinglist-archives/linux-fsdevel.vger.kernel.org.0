Return-Path: <linux-fsdevel+bounces-57451-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 338B8B21BA9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 05:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DD0A19030AD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 03:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7236527602D;
	Tue, 12 Aug 2025 03:31:01 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6A11A76DE
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Aug 2025 03:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754969461; cv=none; b=EEEGOdjGPS130JjV4Ac9bonaY7XiYUNCYuk6PPe1MFbBJS2cVZlxO1sFF5TODzgFFFfzQz8wjYfOo5cFCWJrCxWSJaSkGZoGYnnxQ1ckn9VC4EL+CJgBB9+jeL015wkRfzAw8vrOcJC5MUBB92z1yRMleC+DEA8Wp4fhq0x64NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754969461; c=relaxed/simple;
	bh=rLyckZp6wkoYiW5OVeg3tnt/oi6oTtgFfRq2wqk3oiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KipWPb8ZxQbgSv1CA9LVVHmICdqeWKEoPyfinuweQ0ndhMsxcduh3X3/K6koVqdYM5yJj7tdP37ketn76u+qMiE8X9jjoDwHJikLpy8PJPabKbKNGCJrukkBg158ZO4PiDDXRbsOKt+2CrvsHfW1EplRiMu+JhEnDcYlPGvbsFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ustc.edu; spf=pass smtp.mailfrom=ustc.edu; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ustc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ustc.edu
Received: from localhost (unknown [14.116.239.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1f0ee4a71;
	Tue, 12 Aug 2025 11:25:38 +0800 (GMT+08:00)
From: Chunsheng Luo <luochunsheng@ustc.edu>
To: joannelkoong@gmail.com
Cc: bernd.schubert@fastmail.fm,
	jefflexu@linux.alibaba.com,
	kernel-team@meta.com,
	linux-fsdevel@vger.kernel.org,
	miklos@szeredi.hu,
	willy@infradead.org
Subject: Re: [PATCH] fuse: enable large folios (if writeback cache is unused)
Date: Tue, 12 Aug 2025 11:25:38 +0800
Message-ID: <20250812032538.2734-1-luochunsheng@ustc.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAJnrk1ZLxmgGerHrjqeK-srL7RtRhiiwfvaOc75UBpRuvatcNw@mail.gmail.com>
References: <CAJnrk1ZLxmgGerHrjqeK-srL7RtRhiiwfvaOc75UBpRuvatcNw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a989c4fe5ba03a2kunm8bf119c14b18b
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCHkgdVhlIGB5CGk9PGEhITFYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlKT1VKSk1VSUhCVUhPWVdZFhoPEhUdFFlBWU9LSFVKS0lCQ0NMVUpLS1VLWQ
	Y+

On Mon, Aug 11, 2025 Joanne Koong <joannelkoong@gmail.com> wrote:
>>
>> Large folios are only enabled if the writeback cache isn't on.
>> (Strictlimiting needs to be turned off if the writeback cache is used in
>> conjunction with large folios, else this tanks performance.)
>
> Some ideas for having this work with the writeback cache are
> a) add a fuse sysctl sysadmins can set to turn off strictlimiting for
> all fuse servers mounted after, in the kernel turn on large folios for
> writeback if that sysctl is on
> b) if the fuse server is privileged automatically turn off
> strictlimiting and enable large folios for writeback
> 
> Any thoughts?

Should large folios be enabled based on mount options? Consider adding an 
option in fuse_init_out to explicitly turn on large folios.

Thanks
Chunsheng Luo

