Return-Path: <linux-fsdevel+bounces-46223-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA38A84B97
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 19:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC3F519E32CD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 17:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5616D28C5BD;
	Thu, 10 Apr 2025 17:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="YvqM+2ss"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from common.ash.relay.mailchannels.net (common.ash.relay.mailchannels.net [23.83.222.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9CE20371E;
	Thu, 10 Apr 2025 17:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.222.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744307325; cv=pass; b=O6FJaB95uf6xRU9zM3/lEdg0CSip1aFuvGKYg3+GNBtSIinw4n445ijof8SXFX4oz6r3fX0BWOev97XSPuyFpsBK+RdoRMUK0cdxLBbE0jphGAXe7J1cZ1PnCmmeK93yOruaGxqE0HtNo0KnYMs7cIxGMh1lyLjVleXNM0snQ+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744307325; c=relaxed/simple;
	bh=yxGlbdIg4dViHwy3uxMBlDatd6hs3667ULAim1XWhdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ix/Dme1GUDiX+Y7mRoXvLvsy2ZGXZMJW3Nblnb09nutRi32+0y9OoJDCrHNYNkMuWj1ulC0rNs0x5XoGDwuj4iKrcWMuSkOWRe2uHkCXG9qME+Z0tWf0IKudSSfsebjcqva84aa11/X6WSX8xW5KIDji/pCHvTrDR4pCLb+PfQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=YvqM+2ss; arc=pass smtp.client-ip=23.83.222.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 001E5784B8A;
	Thu, 10 Apr 2025 17:32:44 +0000 (UTC)
Received: from pdx1-sub0-mail-a250.dreamhost.com (100-97-35-35.trex-nlb.outbound.svc.cluster.local [100.97.35.35])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 52B0A784AF6;
	Thu, 10 Apr 2025 17:32:43 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1744306363; a=rsa-sha256;
	cv=none;
	b=JyJXISEdm9FUw7mVqhtX17IyBuYOI/dQDUg7iyD6GlrD/it6ZUa8jlRxA2+j/XSq2NWOkp
	84eJ3m1vtX0i9aEKeJmde1NXIUHatHPRaG0QODtMurIttyJ7x+jQQriaDlO4Jw5m3r3S3n
	hj2gexh6Qb7zbLBnkf9x+RfR/SkyhHSF/FtZR/HzbwZVc4m/VwUCMF8dLXLCw1L0093iRW
	LM+17rWbvYStxVJSFfPkOGY38Z7/YStyyBZs0PU2rPIXtLF+7UZ3lYzJ4ZUjoxNzRi9780
	2xIQPt2zQo36/q945tQk4JcnAt+KDUP/aNbdpfKhnIS3gVOiQ+O0NdlmxnJ0WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1744306363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=lcTCH9aiGqJzfggr32r0X1UsU9A+is5S7inOOX9o5eY=;
	b=PMhbia2QBPQApxDJNPfGgWOyvFMWl4dm1HCCjQQ9tEQSD0Ib2R2HBdxDsHrfu6tw1ognqR
	eCFnf2ByBIF8cbssGJ9MzOTkyo10oW0Cvr+12nAJF0fGZZ3tgb4jKxeol0giulu2bdz+Ww
	lXcwrwg/Y9u9gdVorjhfrVGrb6hSRdq3Aysx/8YoK6Eyrt0d9f5l6IuysbeoMsQKGpJBx+
	gtDvRA+Hd8s7id29zlee23luC6JRTR8mQA+wKfl+NR1oji97NZoAx4JgP2UDe+4irnMR7R
	n8RHw9lusAllFHgPJCwyxlEG4prN1WY8G++HeMnrC8OiFtG464vWQCHRxueQ2w==
ARC-Authentication-Results: i=1;
	rspamd-75b96967bb-8k868;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Thoughtful-Unite: 098cfac60da347e1_1744306363722_3962588475
X-MC-Loop-Signature: 1744306363722:357417711
X-MC-Ingress-Time: 1744306363722
Received: from pdx1-sub0-mail-a250.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.97.35.35 (trex/7.0.3);
	Thu, 10 Apr 2025 17:32:43 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a250.dreamhost.com (Postfix) with ESMTPSA id 4ZYRj527cGz70;
	Thu, 10 Apr 2025 10:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1744306363;
	bh=lcTCH9aiGqJzfggr32r0X1UsU9A+is5S7inOOX9o5eY=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=YvqM+2ssz/SACKKaTcst695zmgpo4d92CYxgxgRhGnlHnE66hdYGQsBFuR1N9dCHH
	 60KirkvbYxy20O/R61o4CELwzAIT4CTTrW7BaeFC17tONX5F6ZWhv4yLcJ2irUmWGE
	 QdQR9HH7yI0Bt1xP7xww5IsPrk/mKUre3ypL4KxcnwvVmIvvvAN+ppwecFbSgIZwUM
	 AymsvQV5EGLU0VQHPgDnPYsUbl9dRYimh4JGLkAmQXGKJ3yCF9RgbY7eDu+9a1xIN4
	 PrH7Vo1+s6CJuiYavdFT9hcInXBJY+cH1YRVUFlf1OsAxrnMpg2YYcY588YpEaJBeW
	 v/t+PukR3IWBQ==
Date: Thu, 10 Apr 2025 10:32:36 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Jan Kara <jack@suse.cz>
Cc: Luis Chamberlain <mcgrof@kernel.org>, brauner@kernel.org, tytso@mit.edu,
	adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	riel@surriel.com, willy@infradead.org, hannes@cmpxchg.org,
	oliver.sang@intel.com, david@redhat.com, axboe@kernel.dk,
	hare@suse.de, david@fromorbit.com, djwong@kernel.org,
	ritesh.list@gmail.com, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-mm@kvack.org,
	gost.dev@samsung.com, p.raghav@samsung.com, da.gomez@samsung.com
Subject: Re: [PATCH v2 6/8] fs/ext4: use sleeping version of
 __find_get_block()
Message-ID: <20250410173236.jk5cksfw5zege5n7@offworld>
Mail-Followup-To: Jan Kara <jack@suse.cz>,
	Luis Chamberlain <mcgrof@kernel.org>, brauner@kernel.org,
	tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	riel@surriel.com, willy@infradead.org, hannes@cmpxchg.org,
	oliver.sang@intel.com, david@redhat.com, axboe@kernel.dk,
	hare@suse.de, david@fromorbit.com, djwong@kernel.org,
	ritesh.list@gmail.com, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-mm@kvack.org,
	gost.dev@samsung.com, p.raghav@samsung.com, da.gomez@samsung.com
References: <20250410014945.2140781-1-mcgrof@kernel.org>
 <20250410014945.2140781-7-mcgrof@kernel.org>
 <g2xj2du3t226jve57mw4wiig4zpqqsvomtbzeu4wk37dfqbp47@3l66fjg736yy>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <g2xj2du3t226jve57mw4wiig4zpqqsvomtbzeu4wk37dfqbp47@3l66fjg736yy>
User-Agent: NeoMutt/20220429

On Thu, 10 Apr 2025, Jan Kara wrote:

>> @@ -860,6 +860,8 @@ struct buffer_head *ext4_getblk(handle_t *handle, struct inode *inode,
>>		return sb_find_get_block(inode->i_sb, map.m_pblk);
>>
>>	/*
>> +	 * Potential TODO: use sb_find_get_block_nonatomic() instead.
>> +	 *
>
>Yes, please. Since we are behind nowait check, we are fine with blocking...

Yes, I will send a follow up that replaces that getblk_unmovable() with
sb_find_get_block_nonatomic().

