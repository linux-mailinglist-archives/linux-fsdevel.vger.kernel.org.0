Return-Path: <linux-fsdevel+bounces-20562-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 512358D5204
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 20:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF3F91F23BDC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 18:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9B5535DB;
	Thu, 30 May 2024 18:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="iw1pGLR2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B1752F92;
	Thu, 30 May 2024 18:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717095319; cv=none; b=MFu5IY2oUao+z5YIgnZUbW0Eo1rHfjoaG74Mu7hxH0dmCIUf6+safNkpBMOz4w38cBYMPVFIR/GtgTAI9sCfZW3Rkt+FNHFVIuUNSXXKhsi3wQUN5YzWCBdVaJcPEWZDz0/NA+EWQWbezjc16oH4lh+sNQ8xY+QlxghHlIKx2WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717095319; c=relaxed/simple;
	bh=4hWBQo8mKhTDOaJg0ytrw+HQ2Vee7IeEmNaUpqVR9Rw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=BYE2m0lyj6iKMgI5c6Brz5+qOu8O9wUdgEJCpUci6iw692X/jMBl+ypEDRbXZTu83oxU9DhUYc+Tp8nzo+azS9fp7Ec/zmd2FKuRD59QeDSlU6uA1MCJaA7PelMOq18dGdgnEe7AXU4rsjWsx3oxiHLGfQL4cVb3eHi2xU3vUGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=iw1pGLR2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7642C32781;
	Thu, 30 May 2024 18:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1717095319;
	bh=4hWBQo8mKhTDOaJg0ytrw+HQ2Vee7IeEmNaUpqVR9Rw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iw1pGLR2r+v8CUGMhN5abhUVsfMLtQajfepQTw58H/C9SEHWTdsQJVctscnEg4Fk2
	 UMUHY7LTTHkyxx+aSBivctH9wxOl3HmMhOYzWmgqAPXp1AKtF81keyxJRcvRMe1mQj
	 IfyrrC1diBcUuv0nb0GJjvggBECt8mTxNLJJOTh0=
Date: Thu, 30 May 2024 11:55:18 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Tejun Heo <tj@kernel.org>
Cc: Kemeng Shi <shikemeng@huaweicloud.com>, willy@infradead.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/8] Add helper functions to remove repeated code and
 improve readability of cgroup writeback
Message-Id: <20240530115518.a4be2d0afa4139e346407583@linux-foundation.org>
In-Reply-To: <ZljG2aq2jRM86BbA@slm.duckdns.org>
References: <20240514125254.142203-1-shikemeng@huaweicloud.com>
	<ZljG2aq2jRM86BbA@slm.duckdns.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 May 2024 08:35:05 -1000 Tejun Heo <tj@kernel.org> wrote:

> Hello,
> 
> Sorry about the long delay. The first seven patches look fine to me and
> improve code readability quite a bit. Andrew, would you mind applying the
> first seven?
> 

Thanks.  All 8 are in the mm-unstable branch of mm.git.  I've added a
note to the eighth, to wait and see how that unfolds.


