Return-Path: <linux-fsdevel+bounces-65701-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EAF1C0D5AE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 13:01:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2B0124F6A35
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 11:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE1F2F7461;
	Mon, 27 Oct 2025 11:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AOewutWB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0ED2E2EEE
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Oct 2025 11:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761566267; cv=none; b=p+QnZAWD5R7Hs04narsHqPnLyhs7fbp8O1RvcY6U5ebTOoM/wYJDQsZ5IG/84t9pd37DAKkyxri9fwAm5eo4Cr/upi8mgUq6F22MVROZLMKFcVd/mNkqdxkoSH0/R93FlrYqKKv6X99E5fALPbGbJHCDPwofqcQbtXYv6YmJh7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761566267; c=relaxed/simple;
	bh=X/YRT3VYVQqffQQNZRHkBdGv+a6Gavg2kFI3+ns3fgk=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Zun48YWhcGid9CGOjKRXuByk1FeJVB2oETR1LUqNnerqGS3mQ0Z9BL4Hk0bBQvS/0y7uj2tFihZVDDG+NrTTb4Qt1X2vK3Uq/p6vZxG3Oe/BPtHScrw275sEpNZdXwyw2A/mhYD7mD7C3f9MzrgbqdkJVTKronEpzUEaj3fFHA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AOewutWB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73975C4CEF1;
	Mon, 27 Oct 2025 11:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761566267;
	bh=X/YRT3VYVQqffQQNZRHkBdGv+a6Gavg2kFI3+ns3fgk=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=AOewutWBGHLzYkqG/ZVV2ev1jfPjsY/zPRJIwsa4zLRoTwB1hDGbQ8x7hso2qEm6S
	 WiTuJRpCxD4WJxp0O/VOwYdfrvbBxtuvij3xuxaD3RMwvD+w+O4WkHL7uLFnI8P0b1
	 MKwhKpLbAQXUXUx1dZIRZTWoD6zOp8mhI9KsSRI+kQ+N8VJQgUdTJBT/yRSpItbujV
	 /re619m0jermgwnEGIU2oRqtlgOphSDS26VDBCr0Y6OYkxJHF4wQRkWR+9/xweQhUk
	 8870Kts5+BW58dVKUzrpOM8mMyCtdTSRCQK6mXERq/H2wrGZGeTGle/jsucuPw08ld
	 41paf0I71dw2g==
Message-ID: <f72e6db4-362a-4937-884f-7b28a5a4e9dd@kernel.org>
Date: Mon, 27 Oct 2025 19:57:43 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH 05/10] f2fs: Use folio_next_pos()
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
References: <20251024170822.1427218-1-willy@infradead.org>
 <20251024170822.1427218-6-willy@infradead.org>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20251024170822.1427218-6-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/25/25 01:08, Matthew Wilcox (Oracle) wrote:
> This is one instruction more efficient than open-coding folio_pos() +
> folio_size().  It's the equivalent of (x + y) << z rather than
> x << z + y << z.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
> Cc: Chao Yu <chao@kernel.org>
> Cc: linux-f2fs-devel@lists.sourceforge.net

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

