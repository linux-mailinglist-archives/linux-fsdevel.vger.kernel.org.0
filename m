Return-Path: <linux-fsdevel+bounces-30638-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0612298CAF1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 03:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38C3D1C22ECF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 01:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF7118039;
	Wed,  2 Oct 2024 01:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="WHMuCLRv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BBB17996;
	Wed,  2 Oct 2024 01:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727833259; cv=none; b=kEYSgi2vAFMnUz4A38RW2kEJgEPId1fkHpyuQ9Z820EbpAzappdLclKmhj2zakCM9MHEb943byQX+QKpHN2QdzXOBZr6GUxC+5S4XGrjLqLvzbjwqqepgsAjv+NQqtx/GY2pMsd2w7kJO5cYVOiBwI82ULFuSFqNIGzHoTepsJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727833259; c=relaxed/simple;
	bh=9jKvMaq8iwbnZtv8Fo4b2JbvDPAWMLpwqbyLe5TtjJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=txrP80JwI11sCO/xldJOIahXAJQiidMko0YRUetWvHLKOLy9JRmMjkXzzrQj2t5t2PKlAR+DHmyXIl1rIJccVO2KyH/YRWcaTVCtdiUc42S/mseKCRIcGQmW3/eo3xRt/6X9YTsO60oqttUcjiRZ+zHDkluOOMbJBO8SzSg28S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=WHMuCLRv; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=F2Ynh9330ndz09vKD3bfokDXM+kkK4ocaOTAo8EIolc=; b=WHMuCLRvFXEcXlePXfpP78nSoI
	pdIzaVDUO+kp6ZgucZEMn7zoZ/xPZIg0VPDELJ74APoMSCD2SlvxyBYkOV8Vf0cB6QWDb2+uSMsqB
	0vCQ6tUBa59spE7md5TZyC8sVAyvOL32Wwh56bqCFkc/VeshQwBhd+IfKv1SzewMLFNAPo4kzXhik
	URDqsN7PQ3W5uFMcMQX9wzLujs61Z3oxAhAGYgDYO4Yu+f6+0qSZFsc1d9wC5FTwYlWoDJ0zTZNLV
	Za/ngr7RwWHMJCgS/BIA13Xx5wXRxH1fXpyf3/IAz4kfByIhz0QZEOmLJE7LIEJjCSXFJdMB8UMPW
	xoR7vesQ==;
Received: from [187.57.199.212] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1svoLq-003eIM-0u; Wed, 02 Oct 2024 03:40:26 +0200
Message-ID: <c547e1aa-f894-409e-9033-f370c5c16171@igalia.com>
Date: Tue, 1 Oct 2024 22:40:17 -0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/10] tmpfs: Add casefold lookup support
To: Gabriel Krisman Bertazi <gabriel@krisman.be>
Cc: Hugh Dickins <hughd@google.com>, Andrew Morton
 <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, kernel-dev@igalia.com,
 Daniel Rosenberg <drosen@google.com>, smcv@collabora.com,
 Christoph Hellwig <hch@lst.de>, Theodore Ts'o <tytso@mit.edu>
References: <20240911144502.115260-1-andrealmeid@igalia.com>
 <20240911144502.115260-8-andrealmeid@igalia.com>
 <87ed5olmmc.fsf@mailhost.krisman.be>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <87ed5olmmc.fsf@mailhost.krisman.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hey Krisman,

Em 12/09/2024 16:04, Gabriel Krisman Bertazi escreveu:
> André Almeida <andrealmeid@igalia.com> writes:
> 

[...]

>> +#if IS_ENABLED(CONFIG_UNICODE)
>> +	if (ctx->encoding) {
>> +		sb->s_encoding = ctx->encoding;
>> +		sb->s_d_op = &shmem_ci_dentry_ops;
>> +		if (ctx->strict_encoding)
>> +			sb->s_encoding_flags = SB_ENC_STRICT_MODE_FL;
>> +	}
>>   #else
>> -	sb->s_flags |= SB_NOUSER;
>> +	sb->s_d_op = &simple_dentry_operations;
> 
> Moving simple_dentry_operations to be set at s_d_op should be a separate
> patch.
> 
> It is a change that has non-obvious side effects (i.e. the way we
> treat the root dentry) so it needs proper review by itself.  It is
> also not related to the rest of the case-insensitive patch.
> 

The idea of setting simple_dentry_operations come from my previous 
approach of having our own shmem_lookup(), replacing simple_lookup(). 
Now that we are settled to keep with simple_lookup() anyway (that 
already sets simple_dentry_operations), I think we don't need this 
change anymore, right?

This will be set for every dentry that doesn't have a 
dentry->d_sb->s_d_op. Case-insensitive mount points will have this set, 
so we don't risk overwriting it.

