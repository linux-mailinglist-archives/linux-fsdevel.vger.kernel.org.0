Return-Path: <linux-fsdevel+bounces-54548-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32904B00D6E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 22:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37D5D1C85469
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 20:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 036082FD594;
	Thu, 10 Jul 2025 20:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="T0cVzz0Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01F32FCE11;
	Thu, 10 Jul 2025 20:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752180908; cv=none; b=SMyXUmMyZh28jmkeSKPnKXYy9Ic3l074zHFpNo3ykw1KBsergtbuuKRP8/aQuMop6EdBpErMB3CaqF70QdJfZhVsy5xwhNxB23wFqpOkBXZF58GA7o475/51QJmvOFBtpjuXJTqRVg/bJUkzBlTvqZiRsVNEUGlP4OJgWj7jxrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752180908; c=relaxed/simple;
	bh=CRx4HESfp5IH1jxIqKZ880FXR29NeZiQcNKgbb5903Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YBQc+8XzJ2VE2GLvq20e7P3fCggWdNczTE5rwa97dUkWElvMftKSZcNH7+weEB1/47TJaN3qGGqREnLsRmaat5Q2QrQdvVGNtCVj5EY6QhuELiqkXzcgd3hEGrlIUHZcQRnkxSti30xi8iw7X8rTLDq284VTwh+OmM4u/k+q3F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=T0cVzz0Y; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=AGcfY8RgH0CT7Il3x69mF4dX1UtEs3VW9Dl2QfSdGgo=; b=T0cVzz0YU8wc2LGCtjvwfgtQSU
	uIje5PDNPdVnF8RKy/Sjiiqtoi2j01T1dkgfGJvimWwhMTOZMFh0cuiBhWH2hEd38tmADjt41Q4I4
	sLpxUQPryu86FIUjQwmdEDa1xqn8XbfCi1S0EaWDUzsMN9xRJ3FZHQfmnVkcjfwXFd7IhEn4BnXeG
	w2tAdmdZD4RT8ziM1YMvQ39ivmQzlyJLTlqdMpv61jP2b93h08JmQoLwTVV7OZRWjhbc7vg/urOGA
	AnFYCofqgmIWKadox5yA7nAUqdEBlZPNSkogRLw6tImLDt9t/xXjD7PswB289kOEGMxb7VhsgXXUs
	eG9P4wSg==;
Received: from [179.118.186.174] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1uZyIB-00F6AY-DS; Thu, 10 Jul 2025 22:54:55 +0200
Message-ID: <00854dc3-538b-4b62-953a-68d0b9ff2295@igalia.com>
Date: Thu, 10 Jul 2025 17:54:49 -0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] ovl: Enable support for casefold filesystems
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Theodore Tso <tytso@mit.edu>,
 Gabriel Krisman Bertazi <krisman@kernel.org>, linux-unionfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 kernel-dev@igalia.com
References: <20250409-tonyk-overlayfs-v1-0-3991616fe9a3@igalia.com>
 <CAOQ4uxiwv8F9p8L98BiX8fPBS-HSpNhJ_dtcZAkqM02RA0LuVQ@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <CAOQ4uxiwv8F9p8L98BiX8fPBS-HSpNhJ_dtcZAkqM02RA0LuVQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Amir,

Sorry for my delay.

Em 09/04/2025 14:17, Amir Goldstein escreveu:
> On Wed, Apr 9, 2025 at 5:01 PM André Almeida <andrealmeid@igalia.com> wrote:
>>
>> Hi all,
>>
>> We would like to support the usage of casefold filesystems with
>> overlayfs. This patchset do some of the work needed for that, but I'm
>> sure there are more places that need to be tweaked so please share your
>> feedback for this work.
>>
>> * Implementation
>>
>> The most obvious place that required change was the strncmp() inside of
>> ovl_cache_entry_find(), that I managed to convert to use d_same_name(),
> 
> That's a very niche part of overlayfs where comparison of names matter.
> 
> Please look very closely at ovl_lookup() and how an overlay entry stack is
> composed from several layers including the option to redirect to different names
> via redirect xattr, so there is really very much to deal with other
> than readdir.
> 
> I suggest that you start with a design proposal of how you intend to tackle this
> task and what are your requirements?
> Any combination of casefold supported layers?
> 

The intended use case here is to use overlayfs as a container layer for 
games. The lower layer will have the common libraries required for 
games, and the upper layer will be a container for the running game, so 
the game will be able to have write permission and even change the 
common libraries if needed without impacting the original libraries. For 
that, we would use case-folded enable ext4 mounting points.

This use case doesn't need layers redirection, or to combine different 
layers of enabled/disable case-fold. We would have just two layers, 
upper and lower, both with case-fold enabled prior to mounting. If the 
layers doesn't agree on the casefold flags/version/status, we can refuse 
mounting it.

To avoid complexity and corner cases, I propose to have this feature 
enabled only for the layout described above: one upper and one lower 
layer, with both layers with the same casefold status and to refuse 
otherwise.

The implementation would be, on top of this patchset, to create 
restrictions on the mounting options if casefold is enabled in a 
mounting point.

Thoughts?

> Thanks,
> Amir.
> 



