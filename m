Return-Path: <linux-fsdevel+bounces-9722-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C20484496A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 22:07:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC41328B155
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 21:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08ECB3986D;
	Wed, 31 Jan 2024 21:07:24 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B5738F97;
	Wed, 31 Jan 2024 21:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706735243; cv=none; b=skGPblt6Ad/TGFIkALukBCB6IX0TxQrJ/8PscdTXLtWoFZQDJlVJGbo65Gf9OCg6tmBUrMPz1A86LR9V/XvAqP63o4d9PAw0Ee0deFwbArX4m4ig0/Uz31UF68NqwCl7XM3MLt/tf/4xLtNxhfx68gPeYia863j25iQp7pXKICg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706735243; c=relaxed/simple;
	bh=g0HPUuyc3xA8aBRoniQjl8dvJBE/1NIN42R2oj0Ub9s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fUJQ4Sp99GoC4lxqTQ/skmiAMLQ9NI0/JARKe74B0ReIw578dN/V8pG2KeOwuAsz30TSXcXQWRmgZAJveNJZ/iYpZC8bLc9nlzZ9nWqh+0Cu1nOTJVAfEXm89KdaW0cyuRpleUl+KRZmK4slzxlrCiuuSgjuwwBzFS3CnZ0PLzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6dc8b280155so114182a34.0;
        Wed, 31 Jan 2024 13:07:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706735241; x=1707340041;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g0HPUuyc3xA8aBRoniQjl8dvJBE/1NIN42R2oj0Ub9s=;
        b=Ri/vSUhUqT3Q8rR6Yt1KqnKa6HANX0YRihyEvI3sGHWmXUlnHClX4d0qRLLbT1aEoT
         KWTpboaPosf+yGq/xNyO1CCDbmJKauh9EzfczJI8LZOqBiaoJujXT8Re8M8ys/9goAZM
         8kDzI4GE4wSUecsl/O5MWqx0nxUWTQwV0bCKmqiSmJbzWOfju3nJ+ZXbjikkb9flZWW8
         E9qjzh0MHsWff77/1Zxn5jtzPeDElMce94cQ33WJkt93uLOjOke684YNWPqx0ZR/fUqg
         IwhJXIMRg4ZOwruRXrL0VLMdQYNvYlKkKrUI10fwtpX+ATQJVwJ0Vy9TfMvGvYH+8wHD
         kDNA==
X-Gm-Message-State: AOJu0YzgQpMqIkpVJeybB16g3TtIbUcPligu/7q0OhtJvcP4XGWAUT2X
	1iBc6+fF1CFDbMIoKQdUj/pHptHalcfOVddjYZHJMgUASOutxVC7mbCr93SR
X-Google-Smtp-Source: AGHT+IF8jsH6w3Jrntxyz+UTAWJ653bvPjVu0dKPaui3DiBTjcn0sucTjygP5Sr18Y8MIV0p0r4HxQ==
X-Received: by 2002:a05:6870:f61e:b0:215:d046:8c62 with SMTP id ek30-20020a056870f61e00b00215d0468c62mr3315922oab.9.1706735241172;
        Wed, 31 Jan 2024 13:07:21 -0800 (PST)
Received: from ?IPV6:2620:0:1000:8411:1d95:ca94:1cbe:1409? ([2620:0:1000:8411:1d95:ca94:1cbe:1409])
        by smtp.gmail.com with ESMTPSA id p16-20020a63e650000000b005d553239b16sm10865231pgj.20.2024.01.31.13.07.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jan 2024 13:07:20 -0800 (PST)
Message-ID: <5eb49324-5c03-4eae-84ff-dcbea494c262@acm.org>
Date: Wed, 31 Jan 2024 13:07:18 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 01/19] fs: Fix rw_hint validation
Content-Language: en-US
To: Christian Brauner <brauner@kernel.org>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Daejun Park <daejun7.park@samsung.com>,
 Kanchan Joshi <joshi.k@samsung.com>, Jeff Layton <jlayton@kernel.org>,
 Chuck Lever <chuck.lever@oracle.com>, Stephen Rothwell
 <sfr@canb.auug.org.au>, Alexander Viro <viro@zeniv.linux.org.uk>
References: <20240130214911.1863909-1-bvanassche@acm.org>
 <20240130214911.1863909-2-bvanassche@acm.org>
 <20240131-skilift-decken-cf3d638ce40c@brauner>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240131-skilift-decken-cf3d638ce40c@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/31/24 05:56, Christian Brauner wrote:
> The fs parts of this should go through a vfs tree as this is vfs infra.
> I can then give you a stable tag that you can merge and base the big
> block and scsci bits on. It'll minimize merge conflicts and makes it
> easier to coordinate imho.
The fs parts have been posted on the fs-devel mailing list. See also
https://lore.kernel.org/all/20240131205237.3540210-1-bvanassche@acm.org/

Thanks,

Bart.

