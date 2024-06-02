Return-Path: <linux-fsdevel+bounces-20754-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD058D7833
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Jun 2024 23:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF06D1C20926
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Jun 2024 21:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E86D378C63;
	Sun,  2 Jun 2024 21:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YlFw7FEI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3866981F;
	Sun,  2 Jun 2024 21:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717362067; cv=none; b=bflaFbda+U/J1G2ntYjrX2HksHXfD0iSLxXvERsG4EutLJZB5FkYAYaJsQomiqDdCcTx2AYxgxPCAUf8tLdUDN/vPi5mYSNUC1DPpU10s+XuSXip7t90gHjjveEOgvKVgMeh6USXLKko+y9GS6XIQb15WHtMR90E7Moz+3Fzno0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717362067; c=relaxed/simple;
	bh=k/3sBuwIV6ID/OscxKudLmKyOpFZQEpPNipeD0Obe9k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uYiLzyPkFX1UKucIQFeasxsJSbBuNTrMyptcaodmnA/eIR8WW41e2kZbi5qhrsGUcAI6cB3GRWACO32VBruZhsrkrp7knh2DW4xwcVsH2EsLY7CsrFS5qmEaurrdxU3twcTcyyPzV1gXe/AApJjC/j0y1MwRNiao/5Y3bqIAoaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YlFw7FEI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE453C2BBFC;
	Sun,  2 Jun 2024 21:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717362066;
	bh=k/3sBuwIV6ID/OscxKudLmKyOpFZQEpPNipeD0Obe9k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YlFw7FEIv3pXvUQaT6EZC9zS0bJR7hVnPfTdV/RC2ZojX8H7Ks+SGj7mpkTb51JNJ
	 PqQCQX8gkiv7h4Bzx4ez17RnwJ/6cqOt7Lf2CEf7PZbkqPL2FT7DQmSxriRinlI38t
	 TJ0Iltq1PWcvhkbzzf7COu3q1By/a1u8Mr4l6AK/fLwnYHAPhSdR0StM/F7BrEy61B
	 2FGBZ4EnI59UNdR09fVM5QWydVoc9u5sVDNy/G2ka3vvz+frUh5wmYvz5m/W1IkOR/
	 vTRgx9WnaCPC2r/lq+E7FD8JD+fHJ32QtBX+A0fcYoyLaYx8hus3zwQGdXmmh6EmQp
	 KKHZkGC4WzgPQ==
Message-ID: <62801b52-eeee-4044-b68f-d3657f714ac2@kernel.org>
Date: Sun, 2 Jun 2024 22:01:01 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH 5/6] bpftool: Make task comm always be NUL-terminated
To: Yafang Shao <laoar.shao@gmail.com>, torvalds@linux-foundation.org
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, audit@vger.kernel.org,
 linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
 bpf@vger.kernel.org
References: <20240602023754.25443-1-laoar.shao@gmail.com>
 <20240602023754.25443-6-laoar.shao@gmail.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20240602023754.25443-6-laoar.shao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/06/2024 03:37, Yafang Shao wrote:
> Let's explicitly ensure the destination string is NUL-terminated. This way,
> it won't be affected by changes to the source string.
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Cc: Quentin Monnet <qmo@kernel.org>

The change looks good to me, thank you.

Reviewed-by: Quentin Monnet <qmo@kernel.org>

