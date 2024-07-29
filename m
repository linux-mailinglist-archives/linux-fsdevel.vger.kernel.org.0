Return-Path: <linux-fsdevel+bounces-24496-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F1EAD93FC63
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 19:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E59BB22C2C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 17:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B6416B74C;
	Mon, 29 Jul 2024 17:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.ucla.edu header.i=@cs.ucla.edu header.b="TVl6AUMh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.cs.ucla.edu (mail.cs.ucla.edu [131.179.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3826E15B542
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jul 2024 17:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.179.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722273798; cv=none; b=X+NjV5ONLQ4mWb4dv7aOgeasx0Sc4V+tmE7OnirVtKLMFOh/HU0n5qCGLttx+bVMOBt0oZuBsGl35yNuq8j55bMjoo/RZobv8MLM95zIgiQKooczsDe5qJnezypfTHjv5lkXderWCqfV414L7MOUofAdcP3RHO7YCv8lTbwZxZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722273798; c=relaxed/simple;
	bh=Ok8zBeQ4hJwhTpKdNivnCdL3jiToMB2Z0syXSl0Exzk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l/u89Ac1McHXjhXdAyWkTaSbtECjDSm8H3+4p9vmEaWVOX8lweU/Zc6aS9fGnjdJWHRPZfngO7o38PeR8DSKK21z++nzF0R84DPDzw2GHMGr3xL/flhBxG/EN9m02B8glyq2+RFIFWBEl20Zs43jRCMkTM75+8q1c5FyJ9iARps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.ucla.edu; spf=pass smtp.mailfrom=cs.ucla.edu; dkim=pass (2048-bit key) header.d=cs.ucla.edu header.i=@cs.ucla.edu header.b=TVl6AUMh; arc=none smtp.client-ip=131.179.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.ucla.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.ucla.edu
Received: from localhost (localhost [127.0.0.1])
	by mail.cs.ucla.edu (Postfix) with ESMTP id 1E3613C011BD4;
	Mon, 29 Jul 2024 10:23:10 -0700 (PDT)
Received: from mail.cs.ucla.edu ([127.0.0.1])
 by localhost (mail.cs.ucla.edu [127.0.0.1]) (amavis, port 10032) with ESMTP
 id Xdfg4zSHVV5k; Mon, 29 Jul 2024 10:23:09 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.cs.ucla.edu (Postfix) with ESMTP id BB28C3C011BD8;
	Mon, 29 Jul 2024 10:23:09 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.cs.ucla.edu BB28C3C011BD8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cs.ucla.edu;
	s=9D0B346E-2AEB-11ED-9476-E14B719DCE6C; t=1722273789;
	bh=Kv5fMYPSuWGayO+d9BiKB36G/fC5C4qkwFAB4LiTGEM=;
	h=Message-ID:Date:MIME-Version:To:From;
	b=TVl6AUMhX9tIrbA9Jj0yPjd4VvZFBbYDpUmuJ4LnYwx0L/P5HeeJJoUcl5zp6sQ2G
	 bVnnf6knyvJPEdzIDueVXrkeO/kY9JfvToce3sPiU9THAteVum4Q1NE6aZ4IntTzY0
	 e1kewErEJ32m4uIFeMCRJBBDKTfDU8WzDFmJqaUcQyRBjsrgG4CRHEfqY08t2wcyEh
	 XSDLDrQTXEek9adq7m5PPh0NF6oWU9hDlDLuGWM/6zUe/fyBihsVzGplsoMi8F0z7L
	 HGo9OwgbTs1SZukzh015gwYaX0rnWAFPxE2S+F9HPkkucFCRkbCGqaJI/V5CSUGyGH
	 KCRWHgv5gcXJQ==
X-Virus-Scanned: amavis at mail.cs.ucla.edu
Received: from mail.cs.ucla.edu ([127.0.0.1])
 by localhost (mail.cs.ucla.edu [127.0.0.1]) (amavis, port 10026) with ESMTP
 id bOGFQ9bM6_9G; Mon, 29 Jul 2024 10:23:09 -0700 (PDT)
Received: from [192.168.254.12] (unknown [47.154.17.165])
	by mail.cs.ucla.edu (Postfix) with ESMTPSA id 989A43C011BC5;
	Mon, 29 Jul 2024 10:23:09 -0700 (PDT)
Message-ID: <91e405eb-0f55-4ffc-a01d-660e2e5d0b84@cs.ucla.edu>
Date: Mon, 29 Jul 2024 10:23:09 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: posix_fallocate behavior in glibc
To: Christoph Hellwig <hch@lst.de>
Cc: Trond Myklebust <trondmy@hammerspace.com>, libc-alpha@sourceware.org,
 linux-fsdevel@vger.kernel.org
References: <20240729160951.GA30183@lst.de>
Content-Language: en-US
From: Paul Eggert <eggert@cs.ucla.edu>
Organization: UCLA Computer Science Department
In-Reply-To: <20240729160951.GA30183@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-07-29 09:09, Christoph Hellwig wrote:

> How can we get rid of this glibc fallback that turns the implementations
> non-conformant and increases write amplication for no good reason?

The simplest solution would be to remove the broken fallback in glibc. A 
more conservative possibility would be to use the fallback only on file 
system types that lack native fallocate and where the fallback is known 
to work (which are they?). Perhaps you could propose a patch along 
either line.

