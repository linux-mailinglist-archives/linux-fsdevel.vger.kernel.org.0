Return-Path: <linux-fsdevel+bounces-40259-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ACA4A21485
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 23:41:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA0023A33A2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 22:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630891DF97E;
	Tue, 28 Jan 2025 22:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="deIlVFST"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BB718FDD2;
	Tue, 28 Jan 2025 22:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738104090; cv=none; b=gW3/AcVVg8aOJy+iqPI3YP4ahF4wLOtKjNBkHIdtQOpCb9mXT1tnDo5372Rk+PxoFpHJ+Nhh5dLMM+GeVBmeMPEcCCRnAaDY59TgsN5bKpmvyjrD5lYDqh14LuGsuwYFEne7C69CEApkwxxj0qTsKf1YrPEEea555q/i5RFsVKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738104090; c=relaxed/simple;
	bh=oCAuPzkTPQ+lPTAVGoYFz5qqzyuZYZ2mOtVbdm2V98Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pb0/ULFUeksrbJJ0Dir+sywt3VUYfBTThjKhhQAPZk8L1lvyYgWRSgUu3raifk/wbfSwOPFC40R4PdrxYmKzK3cJNJGCfpj8sIePdOGn60Lx0schk2gySHcNL4xrltcIUMqK/2stCBvQDRTenPkZeM3PVbf6ccr3zraY/F8RQHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=deIlVFST; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4YjKyc2SmNz6CmR09;
	Tue, 28 Jan 2025 22:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1738104085; x=1740696086; bh=oCAuPzkTPQ+lPTAVGoYFz5qq
	zyuZYZ2mOtVbdm2V98Y=; b=deIlVFSTvQBjiPE44XW8kCAB413xSStMFBh2gex/
	wxEPwSCVZaj4CR4xiobhgKbT64zoadMSIpYlSZKz1Tq4Azv5AvlGvGDLLCR6kNfj
	s/GONHFHvCU0pRPPlMv2VQ/sjXzeD+QUqLjFdItu+d856i/joeDeUpy5y6VP4yTI
	KKoA/dL56K0KqxXM6ZEXxck+7GUG+UmAGEdzowJjtzrFONYWsmGKzsPp1xURFOPq
	1fW5931litkZGuuHKBjuwh4f1ePAJEQb79u71v5DthwquHt/H6S0PbIAmJRA3KZX
	ik796c0zSn2ZtL3X349zu0yPwqOc6prD7Cz42v6jHmIFiQ==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id iwcDlgTBh3iX; Tue, 28 Jan 2025 22:41:25 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4YjKyV6sGrz6CmQyb;
	Tue, 28 Jan 2025 22:41:22 +0000 (UTC)
Message-ID: <fb27be18-2af6-4f89-b15a-5bd1fb8558e9@acm.org>
Date: Tue, 28 Jan 2025 14:41:20 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] Generalized data temperature estimation
 framework
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
 "slava@dubeyko.com" <slava@dubeyko.com>,
 "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>
Cc: "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 Greg Farnum <gfarnum@ibm.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "javier.gonz@samsung.com" <javier.gonz@samsung.com>
References: <20250123203319.11420-1-slava@dubeyko.com>
 <39de3063-a1c8-4d59-8819-961e5a10cbb9@acm.org>
 <0fbbd5a488cdbd4e1e1d1d79ea43c39582569f5a.camel@ibm.com>
 <833b054b-f179-4bc8-912b-dad057d193cd@acm.org>
 <1a33cb72ace2f427aa5006980b0b4f253d98ce6f.camel@ibm.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <1a33cb72ace2f427aa5006980b0b4f253d98ce6f.camel@ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/27/25 3:42 PM, Viacheslav Dubeyko wrote:
> What do you think?

This sounds like an interesting topic to me, but it's probably easier
to discuss this in person than over email :-)

Bart.


