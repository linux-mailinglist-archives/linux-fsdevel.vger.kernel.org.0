Return-Path: <linux-fsdevel+bounces-33067-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6829B3250
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Oct 2024 14:58:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AECD51C222DF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Oct 2024 13:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B231DCB09;
	Mon, 28 Oct 2024 13:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="lqcalzNo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18B5191F91;
	Mon, 28 Oct 2024 13:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730123926; cv=none; b=d5CaeNoZuvF28TLqw819vZEJK7ynY02zl1XZ0d1VxXwWtCGaFNaFzkh2sdsy76brKTr/BdF90L0z35z7qgYs7UJ92Dx2gnWSfJjdHUiBd5/2/ZyNwgox5FQ2SXL7QV+7u8Hk1cNey9cPJmCiF7eoub2mrGZVJlGxNedBunJPyak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730123926; c=relaxed/simple;
	bh=jKlpDLntwOx/bEciULTrygGZaitePsUyKUBtvYE24xk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=newe90kr6q1aAWnF9doc3UrQopJeUy2g40L89oRM//Wea34pFrucKx84r59x2wRfsfSURMZz0uAEIP7qjOAHruWB3E1sqdCpPOB8W/ML4+Gj8bV28E5IRzRYxHv/b1bpr1OjhsawrpujQUbKS0HuORhj5LMB3mo/BvCOdVIXsqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=lqcalzNo; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=vv21Me7Pum0pDrJGfjUfkgjIwMKzfFeJ1meozzE/c8U=; b=lqcalzNoLvMxzvuobOhq89N7Ig
	0M/4OReNTuTRlWMABDaJY8sp24E3pSg+MUf1zZoUUb0tIGLN2+2ndEMBiTCAmNF9UqSTnsobSOcfG
	nDFS6sRG5yY1OGcUEqwIxKFAJqx2azmg9QwVexJCc6g1o9SJzpkdKg1JmJHwBF8JHDuB3blDy8mLk
	hROKUJb1BqkAU2R0GW1c9DSQdkgAxeNJxYHLRlQdUJU27yBicRlROXF9/O3ASlW3hifLG7AHG1DnI
	9Zw3YVqQ2gYC22V0cOSacjdrFlXsDqHMCjphXljEA7ust7DCYt4LmazwYQPp3LgBvyg+J1Wx/h8d5
	HV16zuPg==;
Received: from [189.78.222.89] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1t5QGR-00G6Rl-6O; Mon, 28 Oct 2024 14:58:35 +0100
Message-ID: <6a12e4a2-89ec-404f-ab96-e3cb7731e7e4@igalia.com>
Date: Mon, 28 Oct 2024 10:58:28 -0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/9] tmpfs: Add case-insensitive support for tmpfs
To: Christian Brauner <brauner@kernel.org>
Cc: kernel-dev@igalia.com, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-mm@kvack.org, linux-doc@vger.kernel.org,
 Gabriel Krisman Bertazi <krisman@suse.de>,
 Gabriel Krisman Bertazi <gabriel@krisman.be>,
 Randy Dunlap <rdunlap@infradead.org>,
 Gabriel Krisman Bertazi <krisman@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
 Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>,
 Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>,
 Jonathan Corbet <corbet@lwn.net>, smcv@collabora.com
References: <20241021-tonyk-tmpfs-v8-0-f443d5814194@igalia.com>
 <20241028-weinkarte-weshalb-1495cc5086ab@brauner>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <20241028-weinkarte-weshalb-1495cc5086ab@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Em 28/10/2024 09:37, Christian Brauner escreveu:
> On Mon, 21 Oct 2024 13:37:16 -0300, André Almeida wrote:
>> This patchset adds support for case-insensitive file names lookups in
>> tmpfs. The main difference from other casefold filesystems is that tmpfs
>> has no information on disk, just on RAM, so we can't use mkfs to create a
>> case-insensitive tmpfs.  For this implementation, I opted to have a mount
>> option for casefolding. The rest of the patchset follows a similar approach
>> as ext4 and f2fs.
>>
>> [...]
> 
> Applied to the vfs.tmpfs branch of the vfs/vfs.git tree.
> Patches in the vfs.tmpfs branch should appear in linux-next soon.
> 

Thanks!

