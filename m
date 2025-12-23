Return-Path: <linux-fsdevel+bounces-71951-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E164CCD82AE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 06:36:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 361B2301D9E3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 05:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6BB62F49F0;
	Tue, 23 Dec 2025 05:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LxX3T1Ps"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE2A23C4FA
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Dec 2025 05:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766468155; cv=none; b=Zx9SgFv8p7kv4lZ9zcolgIo7u1lvWlULZdSRdWIHa0gCA2oIoq1sa8DrDv8qXGMClNzibfw0VeN2Wsyktbkl0uxJIOtM6KQCsR2oErseOpxVrMwH3y6bxlVGnR5imTJYby1Q23YZeiXxSckEi3IlOKFTTlb19U6KL912ekAKOZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766468155; c=relaxed/simple;
	bh=g9Bt2s+UFC+DeXi/131tDLXltXct0EalOx5ApUtrNkg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q8EvXVQ/reXmZ7s0qaC+sTohXAUgJbSdlkwI+133PFPQ/JZmokP1I8lEvbyuqAiskMNB7yZAU7LxKjPqpJCPJ8fkly6B4N4QNXCnVRUWb1ctBU7ox7Tg0e7+i4uPnM/0HZubBq0xf5HajaUVxFnl7bFNHPkQE3FL9ezYc2PExvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LxX3T1Ps; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-11b6bc976d6so8222831c88.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Dec 2025 21:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766468152; x=1767072952; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1VDWjicrLkuqVcwGv9d1sh+ocm1fa0mGizT1YHR+Z6c=;
        b=LxX3T1PsbL7A9toWeCRP1ZiEISt/so3/Ge3jUHQW4vV4bDI+CFNh2mgvpyMRmaKHoT
         /MVJPZzIUDwB/OoYv1aOhJKvrOm2AivnEB8xW6vyl+8+1t7pR6MlWzwtRfU/GfflqC6K
         3JQu8w0MC9/CxAeX4efBrU98BIUAeM6jx8wPEXyWQR3NDflVWRIrWEIxqQR4++JYkCHY
         bFEz1B+WB9h9jFH2Xqa8kzgS5ZTgD86P5uMkVxwxMjciEze4VsRaDj13pFlXKT13kVUf
         kH4LjKRVTROQaXbg91AnL4dtGRfgA1kC1ZeJH3Do0F3CuIrtVgeWGDs/NQy0SWkny28V
         x0fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766468152; x=1767072952;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1VDWjicrLkuqVcwGv9d1sh+ocm1fa0mGizT1YHR+Z6c=;
        b=Uff1qxQozX4L69KSB3DOVhvzT/MsgIndK4KVIW83iIe11UCsdcGuWTmmxywC5D9VLf
         5qKCuLhMQpxstvrWDptomshnWDJwvmckRHr1whO41Lnm2zR33jGzi//nn+AnGyXuYjx/
         Gvb2w4m4+mrGRLkWiOVuFbs5PxEqXDnTb+DMISsgEeRKuzXMvIhzf1T5Xuc1Dx2Qmx5z
         socgi3onNpjoK93zoQjTC/WC3GSBmHLrRHBtJSUPGu+tSvFgHgNW0P8GKcL/IXLtjIfy
         oG0RFwrmjr8aI7ZvQSpoP15ImnJVrp/fHe4BGn/2ZirGoMCYNU1KioSvphPr3Zd3K1rW
         kkZA==
X-Forwarded-Encrypted: i=1; AJvYcCUPxHuxM7bsZqSZYPXveFqm6492fER64uUuaKeCO5Tzfm4KYgRxnIdphJW4jttBOjHR11EnSmqQ+Fh+DNLj@vger.kernel.org
X-Gm-Message-State: AOJu0YwG3xDZRi1hW2xPYK46yYvE2/mf+7xlV7dhhjIObf8BlJCpBLVf
	HlJDL1XyaHEypjjz2KeEu/pMpeIKV0Sfi1fYe/S26O6M+9DobOkxbRB/
X-Gm-Gg: AY/fxX4GMigOAY1aPO7JlBSdeawVc7bwxMNbw8V6v9BFcz0pdM1Y0SJ3L8RmiYxK2L0
	aCYJyX/xFETxQrRfhOELrUrFvS7MG75NcYgtfeuNyqpt5WvyYNRiR4Him2bEak7duL2ez12rHdV
	e+rVAWs6tjlKsiyLlIMpXlb+M9NKlzzaXMIZ820Ovckkob2um1QJ1+HaooGg+QsZv9le/Rju4GA
	Gw7AkDqDk0epWmw2Ihda9F+FgBfMvXAL4M8av32qMvmYa9JMmft3nrU1i89Q8NDdDjg/4nOlwml
	r7ZV4hUTjw6MblLx2iCj+cFozLxv2Azs2vDoaCk6GHwoY+9zPLy9TjXiPsH8ffArjotw7mbxG19
	LZS6tEiROMQMe4dx9Z9NQPNiS+IruCc84SgR1Fp44GL92ipKWgCcA7GRukjwNcR9AAdYVeOlgQ+
	SWT62XE07ts9Gm7k7y5ZY5sJG4oo9USDAgPoy4OgJRVM1E704R//9RD1sGXA6kSYdV
X-Google-Smtp-Source: AGHT+IFgD3SNwd/4TCZfokt7AW5oqjEJYNTcZgO21z1zxvgYYO/3rgL7QNl7uSOUpz7Nh4qCGFV22A==
X-Received: by 2002:a05:7022:eacd:b0:11a:4ffb:984f with SMTP id a92af1059eb24-12171a85250mr15323051c88.11.1766468151780;
        Mon, 22 Dec 2025 21:35:51 -0800 (PST)
Received: from ?IPV6:2600:8802:b00:9ce0:637f:5cdc:9df0:d9ab? ([2600:8802:b00:9ce0:637f:5cdc:9df0:d9ab])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121725548b5sm54725089c88.17.2025.12.22.21.35.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Dec 2025 21:35:51 -0800 (PST)
Message-ID: <6f297260-3c99-4330-92ab-deeb1fc5d8f7@gmail.com>
Date: Mon, 22 Dec 2025 21:35:50 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/11] fs: delay the actual timestamp updates in
 inode_update_timestamps
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
 <20251223003756.409543-5-hch@lst.de>
Content-Language: en-US
From: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
In-Reply-To: <20251223003756.409543-5-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/22/25 16:37, Christoph Hellwig wrote:
> Perform the actual updates of the inode timestamp at the very end of
> inode_update_timestamps after finishing all checks.  This prepares for
> adding non-blocking timestamp updates where we might bail out instead of
> performing this updates if the update would block.
>
> Signed-off-by: Christoph Hellwig<hch@lst.de>

Looks good.

Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>

-ck



