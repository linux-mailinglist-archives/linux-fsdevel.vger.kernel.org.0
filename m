Return-Path: <linux-fsdevel+bounces-22691-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D98B91B134
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 23:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F22C71F24E65
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 21:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A259B1A01DB;
	Thu, 27 Jun 2024 21:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="vQo+tPQu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D97E2139AC
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jun 2024 21:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719522813; cv=none; b=c7FhToNLp+AXdBbVznnGw36sij45fWrFXxVPiM14X1dUyPACe88ZQMP+XFsUrZp5ulJIGqC3CGhcPR2ly0X2qThSni3FFjsCc2pqcWj+ipKZHGSsUvdvKYW6hfDa/ubkKL9V/vhbIoB5hxlqCQC8iJQO6faWO2w7zx6wu/kPRis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719522813; c=relaxed/simple;
	bh=9Trd0OtGq7Qi9P1JmTPvm73CnIAbpl5EL1jRvg/A+A8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=BIlfh1ERmsDWAbdijTPprVbEudnwQ3+kcOYmSIeH+eiMLhh94A6u4yrZjAGaNTMKEg10GWZN1pLLTJLDKMfs51HGrlUvcYiIHcjB2+Z4toDpwDuwuRH0XD7RTQuo3Ssu0HgBVrIeM9z8N42tJYMiUg3b/flkqwxZt6PP6FIQ+LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=vQo+tPQu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14A15C2BBFC;
	Thu, 27 Jun 2024 21:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1719522812;
	bh=9Trd0OtGq7Qi9P1JmTPvm73CnIAbpl5EL1jRvg/A+A8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vQo+tPQuBS+D8aCZO4Ae9+jOe6f6pJjs7Om0bGTSdek0ui8SGvSNdjQjqWkUFJgJX
	 nrovL/3Zu/jwOjJJe9ZEc5WrbzAdEeuHiKtWBpnqKgxXGN14TUJPyQS472kdkXds4N
	 yWDV+Bbn2CQV5XygTyTLogSW4MFsXzhO9i1qUExU=
Date: Thu, 27 Jun 2024 14:13:31 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: zippermonkey <zzippermonkey@outlook.com>
Cc: zhangpengpeng0808@gmail.com, bruzzhang@tencent.com, jack@suse.cz,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, vernhao@tencent.com,
 willy@infradead.org, zigiwang@tencent.com
Subject: Re: [PATCH 0/10] mm: Fix various readahead quirks
Message-Id: <20240627141331.30bc97bef0d1acfe38f2880f@linux-foundation.org>
In-Reply-To: <SYBP282MB2224ADAC7D8A689BCC18F78AB9D72@SYBP282MB2224.AUSP282.PROD.OUTLOOK.COM>
References: <513c13ea-3568-441c-972c-c5427d076cb9@gmail.com>
	<SYBP282MB2224ADAC7D8A689BCC18F78AB9D72@SYBP282MB2224.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Jun 2024 14:10:48 +0800 zippermonkey <zzippermonkey@outlook.com> wrote:

> Tested-by: Zhang Peng <bruzzhang@tencent.com>

Thanks.  I added this to the changelogs and pasted your testing results
into the [0/N] description.


