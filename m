Return-Path: <linux-fsdevel+bounces-71952-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB6F2CD82D1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 06:36:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB8BF302B132
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Dec 2025 05:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56582F5A08;
	Tue, 23 Dec 2025 05:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ung45Q84"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203AA2E6CA8
	for <linux-fsdevel@vger.kernel.org>; Tue, 23 Dec 2025 05:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766468172; cv=none; b=GYkE287EO3YsbRjtmTzz85Tj0eALp7/sKgnXsYTiaIkTMkQ4wXY67bbBkLR/CVuKCpL/x06IEZ4h0TFFBiV9H66TVzbmb8YzLwD8TeEUYApey6y5nCrYOuEgtcqu/VtKGoFIz+O8K6TeFql5hptRA+DuYdznSTvGF7VQikRT25g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766468172; c=relaxed/simple;
	bh=lW+UmIWRSVZ7zpivjjDN2RAk8y2uECMzZoBmWD3afKc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CqRfc5Em9OQDvMJ10+suYMjPgsSttdDCyEA1LFAYHB/whnLa/lNjpir36vZNB+hUn2JiCwG4xrX8DYIfJgTNIK9e3DBRN9Wz7SQuIe1cC8KwENBCB7yP7DpeOXZJrYiKr/Ow/BgX0iOEx4eup8SE+5WrGAjGY9blJyGiIRixMG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ung45Q84; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-34b75fba315so5262574a91.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 Dec 2025 21:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766468169; x=1767072969; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lW+UmIWRSVZ7zpivjjDN2RAk8y2uECMzZoBmWD3afKc=;
        b=Ung45Q84NKJpgXUpj6V9c/ed39FtjE6rEaUqQWkJJFS7fjSzXwil3mKYAY6k0P8R9Z
         ddtgTfoZNL09/7vdeIMFC9JYApmDKSVclj15wMPBUSYzvYzI2V1K6y3+4OrBFi1YYL2i
         Ygo61aSI7PTM3LrIlLqoQR3YIwD47T+aDfeoHcsd1atowsBYoyrx6dnbVIVfEB/MalJF
         2NuWCA0r1bN8toEVguQoOSvqibnOTY8FjNDSkJ/sdULSEVFDzpcjyqioyPm4wEmXqrj1
         ilE8f7MJVCDOQnn9/KIYfxwD2zQKhMHjA+B/jiX/srEFwN0w8KKug3A4yAIpvlDCg4c+
         GzLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766468169; x=1767072969;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lW+UmIWRSVZ7zpivjjDN2RAk8y2uECMzZoBmWD3afKc=;
        b=Kw/Yn1y0sf/opNDHH1UhDBhfPCsrI258psVEIBH6PMfbcu5E2q880fU3YYJFElA0Wz
         TtTZN+12Q/095q+BSKslwDPZwc1zueC/9zo4r3g79FhimW0WwaYQo7tnwu4bL2u5z/cV
         t6JN7z7KZeWC23C6NedhazIknhkSwji5Ix0/UowwY1qLe5ZRidsEWwfzz0b/ppFj5cDM
         weRl9qsnqIBZ+e8RCvBwi+Ke/B0uzr+xxM2oXmQHvc/18VOGClzmLeXa1Q7EtbVIgAFD
         O4I3DgbrX8JIot+W56erlcuK2OYYUX64H+KTDyRbLOsJ375Dz+RUv39lqpGbyhfJDjpW
         85dg==
X-Forwarded-Encrypted: i=1; AJvYcCVdPcMcRQ5rRciB5SW2bDdFHWphYEb9D1erVNFbvgAlBZr0rB25kee3e2x73nbs+0g3i9VG1JQGqNbE0VLA@vger.kernel.org
X-Gm-Message-State: AOJu0Yzua5ebj8RB0DkeVAu4y8xEQjg3wt5Mj11eAFGV/QLeVerMpf3h
	p0zxrA6vwxesDHT6shA6ZP4gOET7dmkJYS1K0KJzSMAHKJxMK8fAuxW4
X-Gm-Gg: AY/fxX53RX/p6urOQ2gPpmBVncBEMsui+AuWLW4Yh+BtbvTpUnNPhpp0mb3XmYFmHL9
	k07FwXRYFvVrKfQ+55T2MO1AKol64CHN+XfxIMI30sOSvMycGcu1jPCr8pEnkbjw7d7vUM9ahCa
	0ImCpoQWLamDwU4gAptvMf5v23I8JpeBnXOu7Kd/XWekSjLMj+yun+42zfsSxlg50Z2SLhOM41i
	ii2lDuCHeFBIGW21XUuYhQnSSd6aIXCkpCxyroTUwUHfynbdcnNlmpeGomKkbzoji49niraEpbM
	vU/5gUJGJSKJHVBoubNsK+vRZCVkP3JI9kPP3PuGGbm6tPnjFFBnxo/b7fmZPPTvqj8gJQje4U+
	qM/OrKBKZuKx7QXMuhTNj46Hbkh+zj089QGANaXGZSnUKAR6L7VEcqg3piwqoLetm+2mJ2QYrg/
	+tKg/YztK6Gg+Mi+PWPGBUP7FgXQwWZLOkMtesQXxhDDTTcyVziN5UaTJSbCZeX/Gt
X-Google-Smtp-Source: AGHT+IH379xsDZ0d7vjKdC6ERRiENfgRNsDKq+A1tK8cXdwsmB2ywvOol5d1N83fquxU7SkCjjJrLg==
X-Received: by 2002:a05:7022:3b8a:b0:11b:79f1:850 with SMTP id a92af1059eb24-121722b7f23mr14589383c88.14.1766468169469;
        Mon, 22 Dec 2025 21:36:09 -0800 (PST)
Received: from ?IPV6:2600:8802:b00:9ce0:637f:5cdc:9df0:d9ab? ([2600:8802:b00:9ce0:637f:5cdc:9df0:d9ab])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1217254ce49sm52556580c88.15.2025.12.22.21.36.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Dec 2025 21:36:09 -0800 (PST)
Message-ID: <e2d34cef-c0f4-4f27-91a0-439f85ed26b5@gmail.com>
Date: Mon, 22 Dec 2025 21:36:08 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/11] fs: return I_DIRTY_* and allow error returns from
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
 <20251223003756.409543-6-hch@lst.de>
Content-Language: en-US
From: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
In-Reply-To: <20251223003756.409543-6-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/22/25 16:37, Christoph Hellwig wrote:
> Change the inode_update_timestamps calling convention, so that instead
> of returning the updated flags that are only needed to calculate the
> I_DIRTY_* flags, return the I_DIRTY_* flags diretly in an argument, and
> reserve the return value to return an error code, which will be needed to
> support non-blocking timestamp updates.
>
> Signed-off-by: Christoph Hellwig<hch@lst.de>

Looks good.

Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>

-ck



