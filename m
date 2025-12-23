Return-Path: <linux-fsdevel+bounces-71954-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F56CD82F8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 06:37:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2EBBC30131E5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 05:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C0C2F39A4;
	Tue, 23 Dec 2025 05:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m1L+FowU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5083009C3
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Dec 2025 05:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766468242; cv=none; b=T3v1s+QOj/DvXB7UPsfvsrXkyqK9dIeVfA74WlGy3Dw4vxypz+YwMt0fm2NeDa57EzrJEA/QzD+YhtGeZ4QlEAkMWOsgR4vuH85S0Jtppdtpy9w3DbJTAREM7WjMAuBAf8CA/+AiSbY/66URwkrUVTo3naWDEy/xjEOY+QbHbeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766468242; c=relaxed/simple;
	bh=PhRs88mwlwkazk+ENj6MoiJDiZn71PTbJFD0EWthhgk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SofpC52g4DAykYo4BvSTGGNdAtT0gywyfoUPsXFdmiqvjpwyyy5++RrgmbEcsyg00lwPgH4qT1lx6fBvdlbpo7pMB8vNNXiYriOqtdUjnMltWCcRzy+RV2FMUxLOPuLdnILQXw95/k9wL3ZtuDPu4A2RKQmKz7kWhVg1n38E884=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m1L+FowU; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-29f30233d8aso57588855ad.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Dec 2025 21:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766468238; x=1767073038; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A82QF1EkZtulULncIKG5BayS1YlCBJFC1tpTXCRjsWA=;
        b=m1L+FowUPIMlYK4jS0rqd66lJOxSEu9UNgALQ5BaPsZY0mYIff/6weYhiZEE+MrrkM
         9aobe9ahzY2NcVvdmuxqVWtMOkmapJ04qlH+b0btXifJRKnEEtPaUiqLsELDhj6jt70w
         EK7sGlcQ5d76EwzvypNKWSgDYHmPE+8BHcUbIBj4EI4NxbY3KKCwI4ZDp1KQgpy98Bs5
         C6GPDqRf9SXQuuaRHvzF4K3LE21rBYkM/shcj4phJZQDM3tLR9Z+daG+i6MPaX8M21Le
         aEgz9SUcfIi+tbtgXj18ewhgT+GqS2CX4Nhkk1K9SsmOF/RYGt1NhIV1GMZhSPb1cXVy
         zIHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766468238; x=1767073038;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A82QF1EkZtulULncIKG5BayS1YlCBJFC1tpTXCRjsWA=;
        b=iKYweiwsUI50XXcY8E1NDSG6bn1KFvfk9TfS+QJ11VcyQlNIggZFPS9Ux0tqA/US/O
         Ox1J4rMo9uvLd5FLS7l4Cj4IFPoaAAZR23YiW+ZDn2PxAGICcDYWYcTOyETVYDdeTTxT
         kLRFe/fw/IVWwoXw9yXcJ44WXZ1WOhNE4XSzgGQ3djHOaseoVcBLiwrXDJaI1924za/6
         FilN7iYW+Be7+aYxNaz6P4VOR+po58/RTRDhZDfcwPMjyZH29bviXdQsFaJ+HiMQXnaF
         KC5zEMxIO3E4eRmoerJexoSd0yrY0UvDMO11i/ccZYxZ86Rgl9lW92f13iwxmm0/JbjV
         widw==
X-Forwarded-Encrypted: i=1; AJvYcCWbX90sk6ZlJArtjPIPisOWfnXNGIvAi+6CWMCM6bg/XCfFVuzsi3wcLkJ66alpFqQwu/2BxaZjFHBKMFfi@vger.kernel.org
X-Gm-Message-State: AOJu0YybLANqUD0ASBew63I++PPBOxuddWERN72x9mpXWcUMqC5hVmXc
	SK+GJtMx1gfaL8zYDXxnklRSyWVf8Gu/28KGRx5gJe3svpBiyWcMto16
X-Gm-Gg: AY/fxX4kA59Y+AH5gpSI51phRtZM7p+lVpCd3m5rVMxqlXD4vQV1BPyEfFQ1VR6Ku+h
	HKjz0vxOpEIUsjNkSZ+hl44qk4sbjw97O0GcfZ/xzePhqRBusxjKu2y0vnxnVVcMJpMEs+jBSIB
	uBs3cSW9kzNeoCQ45W19xDZt9Xd7ZKpNDXs4HPcp8c/YojpS3GKbA42pJ+3vxLqCL7cLQ19VEnI
	8lIBrCkzwmfNm+xRxn5SP0u7nK4bmV9MEOaXjBN0AHpYNeDTY7oF4Pnk1Y2JnxvUob+whGiADQ/
	iq0/El5NnQ/Pk73cZiGgtF6bq1WowgMrRlhDi4aglejXKHPOuvh0yfqnhG7HZT9Hp+Nj5JbBESW
	o0DfSL8bSPnVKcI6yo4g+KFJXaBOoGjyAjMiNml5cmUhQAzuHFlKWzgRr2MoF3dgbFbzVle4/S4
	P6EiUuovhHAsIyIigqyyTljHB+JMoFNQYsqqf9ekZWuGzp5vCpKyQliv1OkpqBSVrAz5Pl7iEeZ
	Jg=
X-Google-Smtp-Source: AGHT+IFuAa1bEi9iXQ/fVsFOwY92P7NTqag0Itb/bLEcgCW/+Bj05+w6CIPRTwzaf559s5BnxudUFg==
X-Received: by 2002:a05:7022:1e01:b0:11a:5ee1:fd8a with SMTP id a92af1059eb24-121722ab372mr13830811c88.13.1766468237569;
        Mon, 22 Dec 2025 21:37:17 -0800 (PST)
Received: from ?IPV6:2600:8802:b00:9ce0:637f:5cdc:9df0:d9ab? ([2600:8802:b00:9ce0:637f:5cdc:9df0:d9ab])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724cfd95sm52514131c88.1.2025.12.22.21.37.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Dec 2025 21:37:17 -0800 (PST)
Message-ID: <5789c903-d3f6-4c41-b342-8d29387688e5@gmail.com>
Date: Mon, 22 Dec 2025 21:37:16 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/11] fs: add a ->sync_lazytime method
To: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, David Sterba <dsterba@suse.com>,
 Jan Kara <jack@suse.cz>, Mike Marshall <hubcap@omnibond.com>,
 Martin Brandenburg <martin@omnibond.com>, Carlos Maiolino <cem@kernel.org>,
 Stefan Roesch <shr@fb.com>, Jeff Layton <jlayton@kernel.org>,
 linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev,
 io-uring@vger.kernel.org, devel@lists.orangefs.org,
 linux-unionfs@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org
References: <20251223003756.409543-1-hch@lst.de>
 <20251223003756.409543-8-hch@lst.de>
Content-Language: en-US
From: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
In-Reply-To: <20251223003756.409543-8-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/22/25 16:37, Christoph Hellwig wrote:
> Allow the file system to explicitly implement lazytime syncing instead
> of pigging back on generic inode dirtying.  This allows to simplify
> the XFS implementation and prepares for non-blocking lazytime timestamp
> updates.
>
> Signed-off-by: Christoph Hellwig<hch@lst.de>
> Reviewed-by: Jeff Layton<jlayton@kernel.org>


Looks good.

Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>

-ck


