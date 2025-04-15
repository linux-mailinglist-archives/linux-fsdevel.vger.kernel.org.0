Return-Path: <linux-fsdevel+bounces-46462-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB60A89C6A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 13:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63C691900149
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 11:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682A82973B6;
	Tue, 15 Apr 2025 11:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YMqnwWpq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C142C29114D;
	Tue, 15 Apr 2025 11:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744716308; cv=none; b=QAgmtplA31mkoG9gJwFdIvY2FNtbf9QYBEDJwsuD7ty1N0SPRy2EnMtrxc6+0imItmecP6hZ4lAJ6US6e/4W1CcKyIFl65uP8HOkAJW3SRMA2PrmOyWO6gpsHgOgDK4+4qs984cdnIliA6fMUetyRiyc4VHYo5gpEhU9kTeWpp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744716308; c=relaxed/simple;
	bh=/rUgmsxTiubpnU4tiKPz7mIn0s7yHkK53uNdziHqUc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qO+IHBQDyx0x/sKMULHa1C8QMCUuNAHAY8d4xukt+BeSbDyLq+05OMxoTRxHOnZSJ+R4lLxpH2Cs9sRPyRdfqgoXVzXfxojx0Xh0L2gV20jqZBlsAGxboSdf0bLLdbM7ya+WvSEgcTw4YEInddxPX/+jI2UXNvCbY3/E94Th9jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YMqnwWpq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62BA3C4CEDD;
	Tue, 15 Apr 2025 11:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744716308;
	bh=/rUgmsxTiubpnU4tiKPz7mIn0s7yHkK53uNdziHqUc4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YMqnwWpqfdOaBMsNlf1ZaebJov41jlK388dFvfzIzFz/20AX6RzLOasRgZVjD7ZNu
	 EH727NMGzxie+MH7Jdys4e+9l9fNW2M2No+llatt/Y0Ecubz1mYzz1mYA/R3mW3QmI
	 PXrb+BmXdgyF/PWSV7HVoYJ2Qc0mMn11zI8gctMwIOX9jOeOIFt4kMTtmRAlByxgTS
	 cdqWktgcM3iry/lBRs4ddTMLQlX3td3MQshvJTl9kT7RQt5rPday5xUk/sgYLjAKmB
	 nMz/p3bTSsWSPetNI2wlRFHnWQXxJP5B9suNCzmCrcCAYu1tRop/BJGaRnlpJRsG+f
	 yj/afn9yCsZ+g==
Date: Tue, 15 Apr 2025 13:25:03 +0200
From: Christian Brauner <brauner@kernel.org>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: David Sterba <dsterba@suse.cz>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, 
	now4yreal <now4yreal@foxmail.com>, Jan Kara <jack@suse.com>, Viro <viro@zeniv.linux.org.uk>, 
	Bacik <josef@toxicpanda.com>, Stone <leocstone@gmail.com>, Sandeen <sandeen@redhat.com>, 
	Johnson <jeff.johnson@oss.qualcomm.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Bug Report] OOB-read BUG in HFS+ filesystem
Message-ID: <20250415-deportation-lauftraining-17ff7ee0b6f5@brauner>
References: <tencent_B730B2241BE4152C9D6AA80789EEE1DEE30A@qq.com>
 <20250414-behielt-erholen-e0cd10a4f7af@brauner>
 <Z_0aBN-20w20-UiD@casper.infradead.org>
 <20250414162328.GD16750@twin.jikos.cz>
 <20250415-wohin-anfragen-90b2df73295b@brauner>
 <786f0a0e-8cea-4007-bbae-2225fcca95b4@wdc.com>
 <20250415-razzia-umverteilen-4e8864b62583@brauner>
 <8bd5e290-cfda-4735-a907-27611d1aac67@wdc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8bd5e290-cfda-4735-a907-27611d1aac67@wdc.com>

On Tue, Apr 15, 2025 at 10:23:27AM +0000, Johannes Thumshirn wrote:
> On 15.04.25 11:31, Christian Brauner wrote:
> > On Tue, Apr 15, 2025 at 09:16:58AM +0000, Johannes Thumshirn wrote:
> >> On 15.04.25 09:52, Christian Brauner wrote:
> >>> Ok, I'm open to trying. I'm adding a deprecation message when initating
> >>> a new hfs{plus} context logged to dmesg and then we can try and remove
> >>> it by the end of the year.
> >>>
> >>>
> >>
> >> Just a word of caution though, (at least Intel) Macs have their EFI ESP
> >> partition on HFS+ instead of FAT. I don't own an Apple Silicon Mac so I
> >> can't check if it's there as well.
> > 
> > Yeah, someone mentioned that. Well, then we hopefully have someone
> > stepping up to for maintainership.
> > 
> 
> I hope you aren't considering me here :D. I'm lacking the time to 
> volunteer as a Maintainer but I can offer to look into some fixes.

No no, I'm aware. I'm just saying that if this is really crucial this
Mac use-case then we better find someone to take care of it properly.

