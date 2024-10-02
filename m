Return-Path: <linux-fsdevel+bounces-30685-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA2D98D440
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 15:14:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0C8D1C210C2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 13:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE971D040E;
	Wed,  2 Oct 2024 13:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="GNHj2end"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697141D0173;
	Wed,  2 Oct 2024 13:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.252.153.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727874874; cv=none; b=BRR+F/ou5gCsrISg8Tb0LeId66mKHmGwEDV/CBn5pZUpAl0jk3szddmQa8PLnV7QCx1Yf+swW5HAMqw1aLInnlliLRtDlMixS81/NCRKYYyrIQxJlyDCyekYCYEysWZgkZvdgKbozyY2WPL5QTBA59g7t6/mErOvH3xiOFiNM/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727874874; c=relaxed/simple;
	bh=b+nDgG7WLX+2se6Fp0D1NFmEWH8bGtdpXxxb1H9o6co=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oMHVlJ7ggyk1UoVn4n11+Hm6Scyu5UkHWq92VTzfa3hGRnAqjZf58vTCk0A7RvAcOVxhSvAotJ19+TvDJyACI6GHvoZOCjOqW2xejF1208KXnmeJNeNioBR3iZtnH478xwzxjDAJDgoAVGSeupBm0J7KIlspAxfK7VnV5qvdRmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net; spf=pass smtp.mailfrom=riseup.net; dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b=GNHj2end; arc=none smtp.client-ip=198.252.153.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riseup.net
Received: from fews02-sea.riseup.net (fews02-sea-pn.riseup.net [10.0.1.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1.riseup.net (Postfix) with ESMTPS id 4XJZqr49s3zDqkd;
	Wed,  2 Oct 2024 13:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
	t=1727874505; bh=b+nDgG7WLX+2se6Fp0D1NFmEWH8bGtdpXxxb1H9o6co=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GNHj2endYHYmqqFIDdOaj/C9Nxi3dxMqpnRG/LgFPGVNZlhl8YVxJSOiv4qA1v8YS
	 1M8Iz2gK8+3NYuLPYfwuL6JPc2bQzj9YSkjcXjepM89ERoKC+C41k0f9ut6OJE1ayD
	 KrUPgki50sG3a2ycr/P5fGSj2kT1B7CJbWyRKDs8=
X-Riseup-User-ID: 6C3AD2BC940CE70F16EFC4C566548BFEBDF454DCF26343DBF88D730095FB120C
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews02-sea.riseup.net (Postfix) with ESMTPSA id 4XJZqZ4z7QzFvfF;
	Wed,  2 Oct 2024 13:08:10 +0000 (UTC)
Message-ID: <b8172037-498b-4607-9c36-5504bc6d0989@riseup.net>
Date: Wed, 2 Oct 2024 10:08:07 -0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/2] unicode: kunit: change tests filename and path
To: Pedro Orlando <porlando@lkcamp.dev>
Cc: Gabriela Bittencourt <gbittencourt@lkcamp.dev>,
 kunit-dev@googlegroups.com, Shuah Khan <skhan@linuxfoundation.org>,
 David Gow <davidgow@google.com>, Gabriel Krisman Bertazi
 <krisman@kernel.org>, ~lkcamp/patches@lists.sr.ht,
 linux-kselftest@vger.kernel.org, Danilo Pereira <dpereira@lkcamp.dev>,
 linux-fsdevel@vger.kernel.org
References: <20240928235825.96961-1-porlando@lkcamp.dev>
 <20240928235825.96961-3-porlando@lkcamp.dev>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@riseup.net>
In-Reply-To: <20240928235825.96961-3-porlando@lkcamp.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Em 28/09/2024 20:58, Pedro Orlando escreveu:
> From: Gabriela Bittencourt <gbittencourt@lkcamp.dev>
> 
> Change utf8 kunit test filename and path to follow the style
> convention on Documentation/dev-tools/kunit/style.rst
> 
> Co-developed-by: Pedro Orlando <porlando@lkcamp.dev>
> Signed-off-by: Pedro Orlando <porlando@lkcamp.dev>
> Co-developed-by: Danilo Pereira <dpereira@lkcamp.dev>
> Signed-off-by: Danilo Pereira <dpereira@lkcamp.dev>
> Signed-off-by: Gabriela Bittencourt <gbittencourt@lkcamp.dev>

I think you missed this in:

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

 From 
https://lore.kernel.org/all/7e831d5b-1bc4-4d6d-99d7-b160cd580528@linuxfoundation.org/

