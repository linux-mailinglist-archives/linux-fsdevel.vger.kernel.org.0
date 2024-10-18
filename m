Return-Path: <linux-fsdevel+bounces-32378-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A049A4772
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 21:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1C90B221B2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 19:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16057206053;
	Fri, 18 Oct 2024 19:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="PSxZvMdx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84D9817;
	Fri, 18 Oct 2024 19:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729281251; cv=none; b=Kx93OPvRliLhFeJKnn2tLeBfHpaJ1SOetYtRa3IveizfAHBj6m5ZouQYmrVD1y5rj27kHK+PZjzPcjrjqO8vPKCWp6CHhsAJUqK48Zwl1LHPU5XGOVFao0Stjpn9Lpuxa+GwweN/Vf+rzdv3d1xeqXwIO+GGn69/79hBFS/8U3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729281251; c=relaxed/simple;
	bh=Zc1GMAPbqbBFMAhCjhHu4P/ht4QtHqZLxVD54TPhoQ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lLmRLB/oYxylu2w6NTR5bn9jiarkZp4nh8hHIDbuHtf3TMt6Lcj7IWHtcisGGY2B/7CsRZ3vQNI95Nm1GHTbrTMpE8OK5wV+1ON/hPj5CYWeosCW00kPhBMydKZZUiLTM5ZXF0JePHqId3yGrRtxOTvm5Wyg3WUpOUg+nLck/jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=PSxZvMdx; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=nB5M+mC8Q2nMTyMamAEftSBXwqi0D929KudvpC8sj+E=; b=PSxZvMdx/o8rjtNY1V+tSdDUzK
	2AC8kbnBcM3kDuaLMRNjlytzE5mcDviZdxENtSh7JcsVJQGqb/LWzVTEsEHVQOdKnxSsGjA2OrS2c
	9tL6GfRWuKTQHhwyp3e6g5XHoskNGULwfRZIQIsTjIqxGtEYZ4r/57NzNzxldeeexdzfP61L8EQu1
	YzLCjn23Q1HgMPRG2hWN+ZfDkdggrnT7S5Bb/Ji5+3Czg5CLTZO7EbLKo/7iBc2SyL2GSD5uW0Dyv
	I3WpYUHZMxiR/z3ErrORcTBhfDTadMwGVeIU7FOP2zuQTl3fBq+Kg0xyKPDoprMF2lsowf70C/fkI
	mG2FEJMQ==;
Received: from [179.118.186.49] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1t1t2O-00CD6c-PI; Fri, 18 Oct 2024 21:53:29 +0200
Message-ID: <30d2230f-cbfa-42ba-a24a-8ad7a4ad236e@igalia.com>
Date: Fri, 18 Oct 2024 16:53:21 -0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/9] tmpfs: Add case-insensitive support for tmpfs
To: Gabriel Krisman Bertazi <gabriel@krisman.be>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>,
 Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>,
 Jonathan Corbet <corbet@lwn.net>, smcv@collabora.com, kernel-dev@igalia.com,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-mm@kvack.org, linux-doc@vger.kernel.org
References: <20241017-tonyk-tmpfs-v7-0-a9c056f8391f@igalia.com>
 <87frotyyyw.fsf@mailhost.krisman.be>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <87frotyyyw.fsf@mailhost.krisman.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Em 18/10/2024 16:48, Gabriel Krisman Bertazi escreveu:
> André Almeida <andrealmeid@igalia.com> writes:
> 
>> Hi,
>>
>> This patchset adds support for case-insensitive file names lookups in
>> tmpfs. The main difference from other casefold filesystems is that tmpfs
>> has no information on disk, just on RAM, so we can't use mkfs to create a
>> case-insensitive tmpfs.  For this implementation, I opted to have a mount
>> option for casefolding. The rest of the patchset follows a similar approach
>> as ext4 and f2fs.
> 
> Hi André,
> 
> The series looks good to me now. Thanks for the changes.  Let's see what
> others think.
> 

Cool, thank you very much for the help with the review :)

