Return-Path: <linux-fsdevel+bounces-43703-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C311DA5BFB6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Mar 2025 12:49:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22BF83A5653
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Mar 2025 11:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6F0253F0E;
	Tue, 11 Mar 2025 11:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="afnQ3xQ+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B32BF9CB
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Mar 2025 11:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741693752; cv=none; b=FMfjPO0fnpy3+kvGdNEyphjaN6bnhLFMhTip6l/VUmKdjVIvaHAVfYIcMPh6HMlMJFdw36SchAyHvX0pZlUVXw26rxWIJ7CoT29HCd4ljFt2nagrhR6Uv9DSFeXAV+yfscHnp+pko5d58QKmNMlMNUWTcmezuoNmhzlFsshOyBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741693752; c=relaxed/simple;
	bh=RtjSiZtx5omuFVg3avMcut1p0gnfZssAhseajHHPr5c=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=RLqx/xKvfeWQEXUhgpuwhq1DC8w4GtmjWWUXrEjBQST9uHiTqavncspieUfKwTWNXqnto+mHISlpINYm0EXAA8KNKj341Y/5gtDgeYsDZVbNTKq4dVY8DaOSrV1SLbEMBEShUEJnnqTRkg+ma1TT+yf5DrD3XGo1rrBVU1iQiPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=afnQ3xQ+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DD17C4CEE9;
	Tue, 11 Mar 2025 11:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741693751;
	bh=RtjSiZtx5omuFVg3avMcut1p0gnfZssAhseajHHPr5c=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=afnQ3xQ+6T+/rweyszaV5KAUraFYtibSpTjHU75K27TTjSpEkxIHS0Oc2LY93X0zf
	 YHY/9Ay7ij4v3QvW6AIIkcTrKgwwRVx5u1LslNyvrttk1uWwwenGQ90C8pqsiJ71in
	 jMrQ96ygv9MeGn+V9Al3uiv5i5Y5ETKByDdZbMQE+dn8GX7K/IcPyG4osmWUgXcmyZ
	 +FTbs0I6dcnBPvmwsd+Rv7YgjSBaCfagYXcZDG+b34KZjpddOuoFjNM2HrFEyDfb/l
	 H2zNr7/tVpYnK0WQFlsDPBWWAnEhapmk7YBUUyX+Mg/9/3vO30lj/SF7iH4SmBZi7d
	 koA2mpxEztEUA==
Message-ID: <e633ffab-0731-433f-82e4-44477b1f96e9@kernel.org>
Date: Tue, 11 Mar 2025 19:49:08 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/4] f2fs: Remove f2fs_write_meta_page()
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Jaegeuk Kim <jaegeuk@kernel.org>
References: <20250307182151.3397003-1-willy@infradead.org>
 <20250307182151.3397003-4-willy@infradead.org>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250307182151.3397003-4-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/8/25 02:21, Matthew Wilcox (Oracle) wrote:
> Mappings which implement writepages should not implement writepage
> as it can only harm writeback patterns.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

