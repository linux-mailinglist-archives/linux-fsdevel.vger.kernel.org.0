Return-Path: <linux-fsdevel+bounces-44618-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C07D4A6AB25
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 17:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B07E38A5C16
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 16:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5187C21C187;
	Thu, 20 Mar 2025 16:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="mAObQXyZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DE51B422A;
	Thu, 20 Mar 2025 16:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742488515; cv=none; b=lXPIKTTdcP4NKM3JaQs8n+tieIEixumb1B83lwQO4NznHqcd7xeAW7U3mXJ3wARWAxiqjkuTlHlhFZikLZUgNCkSCtmgS2qMX+Pi7aODBFRvobdACNQ6ucPh+WF5njn7UFc7mnObvXVo5B0z+CeLjPC3uwDjKncRyXJk7lu9qeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742488515; c=relaxed/simple;
	bh=wTiOFm2ihbPmUXvydsiYuS1a5KHImiTjcV33wRo4U1s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vwb/AOAPTSh3kqhnowkf+uYRxzXaxQRfG/qr8RT3T8XPZ5eZWYJKSTQeB+Gs2u3CM8YViWOWpHiAtQ+XwwUy7pHv+jBej94Efu8VmniWV/mFCMVpimmpQtRxcWjdJiWFSTz3A2w6u0TGjlN8ltpZnh0TDKKJQWa5888UukJFdvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=mAObQXyZ; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4ZJWQS5f5Czm8StQ;
	Thu, 20 Mar 2025 16:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1742488509; x=1745080510; bh=xVaNFOxBpsi6HzakhLZSC05P
	JtCNO8Ldu1l2EZUYP98=; b=mAObQXyZBHrMv1nzFedkSemHhy4ihX70+PHwre5I
	3VzNAxxpwvj/7O/7SdDC9rRCJskvPAY/dSrw2wIjXGkEAy12xw/wRFlo+/EcOm3V
	WJzu0WgApuMnV2pnfoE0jZ1u46iqBghvqzNPbk+n40Okbp2Z3bVHKEieT4fOAvAn
	nGTmSHqVW0UWBcSLhSdde34x+POP2Aam9OdQ+lTBdYb+OaCv/d17cx42AfPkPd4b
	25R0CtHjDyjyoG62SCEG2wy5ICrRkuZf7n0e2vmOZlfqjkhLlgvM6yBsjxTyNuHj
	IEhhOKMufifJe/hIhBSENadNZSikf4f4x7Yx66LT+mDzGA==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 2o5YmMhNtSJ9; Thu, 20 Mar 2025 16:35:09 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4ZJWQ46yrlzlxdd1;
	Thu, 20 Mar 2025 16:34:51 +0000 (UTC)
Message-ID: <7cc6f537-aac4-4bfc-80f0-1829a850d56a@acm.org>
Date: Thu, 20 Mar 2025 09:34:50 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 2/4] blkdev: lift BLK_MAX_BLOCK_SIZE to page cache limit
To: Matthew Wilcox <willy@infradead.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, leon@kernel.org, hch@lst.de,
 kbusch@kernel.org, sagi@grimberg.me, axboe@kernel.dk, joro@8bytes.org,
 brauner@kernel.org, hare@suse.de, david@fromorbit.com, djwong@kernel.org,
 john.g.garry@oracle.com, ritesh.list@gmail.com,
 linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 linux-mm@kvack.org, gost.dev@samsung.com, p.raghav@samsung.com,
 da.gomez@samsung.com, kernel@pankajraghav.com
References: <20250320111328.2841690-1-mcgrof@kernel.org>
 <20250320111328.2841690-3-mcgrof@kernel.org>
 <5459e3e0-656c-4d94-82c7-3880608f9ac8@acm.org>
 <Z9w9FWG2hKCe7mhR@casper.infradead.org>
 <c33c1dab-a0f6-4c36-8732-182f640eff52@acm.org>
 <Z9xB4kZiZfSdFJfV@casper.infradead.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <Z9xB4kZiZfSdFJfV@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/20/25 9:27 AM, Matthew Wilcox wrote:
> On Thu, Mar 20, 2025 at 09:15:23AM -0700, Bart Van Assche wrote:
>> The patch description mentions what has been changed but does not
>> mention why. Shouldn't the description of this patch explain why this
>> change has been made? Shouldn't the description of this patch explain
>> for which applications this change is useful?
> 
> The manufacturer chooses the block size.  If they've made a bad decision,
> their device will presumably not sell well.  We don't need to justify
> their decision in the commit message.

The fact that this change is proposed because there are device
manufacturers that want to produce devices with block sizes larger than
64 KiB would be useful information for the commit message.

Thanks,

Bart.

