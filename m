Return-Path: <linux-fsdevel+bounces-57489-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B550AB2226F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 11:11:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67DBF1AA765B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 09:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA04C2E7654;
	Tue, 12 Aug 2025 09:08:28 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A752E0B6E
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Aug 2025 09:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754989708; cv=none; b=p/WcZAZfOlVp0MWTXK6zVUDfmUanlRXnoSxKJvmZ5kD82wpNbdLd6dUeDYUrbc61k8nME7mox1ZH9L+p32/1grpJz4/JbBUNrc1r6SmXHmJDJAlnIzxs4laay8HGHffwLw6cvW9Ietqmfpw3XxwE2u5w1LahRn9EAiJsyEVqarU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754989708; c=relaxed/simple;
	bh=wBJLLZKEoreziNjyb66CBFS26IMufFGfV8EWmpFNaM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GR2HZYRCjaXhyhrsucVplwT6Y9N+uoilkaKnRRK99uW2KlSe5emOwne0T7RtkvpP0C0OoXANY3NFX7vmtvJcvhLijATLQwbb6FTDXw9id2PWIrRZ3j/VmqaBe4qlKybwjtgUuT3m+JBfgTkKLb9l27Tk80GQex1wtMkEtWuo6BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ustc.edu; spf=pass smtp.mailfrom=ustc.edu; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ustc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ustc.edu
Received: from localhost (unknown [14.22.11.162])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1f1bb1d7a;
	Tue, 12 Aug 2025 17:08:19 +0800 (GMT+08:00)
From: Chunsheng Luo <luochunsheng@ustc.edu>
To: bschubert@ddn.com
Cc: fweimer@redhat.com,
	linux-fsdevel@vger.kernel.org,
	luis@igalia.com,
	mszeredi@redhat.com
Subject: Re: [PATCH 1/2] fuse: fix COPY_FILE_RANGE interface
Date: Tue, 12 Aug 2025 17:08:18 +0800
Message-ID: <20250812090818.2810-1-luochunsheng@ustc.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <3bf4f5f5-bfab-47cb-815b-979b56821cc5@ddn.com>
References: <3bf4f5f5-bfab-47cb-815b-979b56821cc5@ddn.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a989d89a0ea03a2kunm27d3630c73b61
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCT0wdVkhLTBlDSkIfQx8dT1YeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlKT1VJSVVKSlVKTUlZV1kWGg8SFR0UWUFZT0tIVUpLSUJNS0pVSktLVUtZBg
	++

On 8/6/25 19:43, Bernd Schubert wrote: 

> On 8/6/25 11:17, Luis Henriques wrote:
>> On Tue, Aug 05 2025, Miklos Szeredi wrote:
>> 
>>> The FUSE protocol uses struct fuse_write_out to convey the return value of
>>> copy_file_range, which is restricted to uint32_t.  But the COPY_FILE_RANGE
>>> interface supports a 64-bit size copies.
>>>
>>> Currently the number of bytes copied is silently truncated to 32-bit, which
>>> is unfortunate at best.
>>>
>>> Introduce a new op COPY_FILE_RANGE_64, which is identical, except the
>>> number of bytes copied is returned in a 64-bit value.
>>>
>>> If the fuse server does not support COPY_FILE_RANGE_64, fall back to
>>> COPY_FILE_RANGE and truncate the size to UINT_MAX - 4096.
>> 
>> I was wondering if it wouldn't make more sense to truncate the size to
>> MAX_RW_COUNT instead.  My reasoning is that, if I understand the code
>> correctly (which is probably a big 'if'!), the VFS will fallback to
>> splice() if the file system does not implement copy_file_range.  And in
>> this case splice() seems to limit the operation to MAX_RW_COUNT.
>
> I personally don't like the hard coded value too much and would use
> 
> inarg.len = min_t(size_t, len, (UINT_MAX - 4096));
> 
> (btw, 0xfffff000 is UINT_MAX - 4095, isn't it?).
> 
> Though that is all nitpick. The worst part that could happen are
> applications that do not handle partial file copy and then wouldn't
> copy the entire file. For these it probably would be better to return
> -ENOSYS.
> 
> LGTM, 
> 
> Reviewed-by: Bernd Schubert <bschubert@ddn.com>

Abot "truncate the size to UINT_MAX - 4096":
4096 refers to PAGE_SIZE (the standard memory page size in most systems)?
If so, wouldn't UINT_MAX & PAGE_MASK be more appropriate? 
like: `#define MAX_RW_COUNT (INT_MAX & PAGE_MASK)`
UINT_MAX & PAGE_MASK ensures the operation does not cross a page boundary.

Thanks
Chunsheng Luo

