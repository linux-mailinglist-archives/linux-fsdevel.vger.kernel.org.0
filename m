Return-Path: <linux-fsdevel+bounces-66844-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2716C2D52D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 18:01:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7929A189A140
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 17:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E20031AF24;
	Mon,  3 Nov 2025 16:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="AKx8k3U9";
	dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="UzNzfMyW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3741528750A;
	Mon,  3 Nov 2025 16:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.171.160.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762188980; cv=none; b=pJx/w19RYkJ3VBEXMIvvUf31yTFeuh1KSRUTO32/cvExRRkrhCwUcD1c7Q0s3YHOdidRDETJkWHZw0OxC7PO8OXrw721FRlxRn6M4ADk6+4rHyVrx4kEOnjFguplDTkxh0BX9SNxGw+FztsShGmX3OPbYRumQB4wKQZsxzB5wBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762188980; c=relaxed/simple;
	bh=rUdhc9/dZGIPnjRxxoKqxJEAxeMc/H4w+8L2UFjmxzo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sxcFw7f0Lylbe4cpLzLDFry/Up77DpqvForG2L1YdGyOFSRYDrflbJLq2QsUs2HAIregAErondp3BGJNlXLZ9m3+tMX+y4hd0Ap2JN/FgXR+YiK+pidzFum3Rg4R+VID/byrwjGgJoxMA3RHN2dWJ/wxRBwqZVvH590soeQmy8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp; spf=pass smtp.mailfrom=parknet.co.jp; dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=AKx8k3U9; dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=UzNzfMyW; arc=none smtp.client-ip=210.171.160.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id B1F892051576;
	Tue,  4 Nov 2025 01:56:09 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114; t=1762188970;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V3y+4DVGUspp58JJWY2SOnaLsTUPZnxETW8fSaQHj9Y=;
	b=AKx8k3U9AjJf5i9G34VdNUXwSa4+qoC8VJAITSzTioOXQuZHi4tcaYqIBnB69AsiFHlXHn
	aKg3PZTxJNRyjK5u+w+pymmkoU4LG41JRrHuYHQiCkmfTCz8YPuBBcENdPeRt/DWVhoNpA
	7SQi4ZJe4zzZwuL2HoHRKCSvUKXRTY9xXrG3eQp/e+8b26xtC8q3TZgojk5Ytz6IatD/Uz
	HYL5SNrqkwcmK1mtbybpsHLkjElgpyXPqg2kBFRbjt+oz7T7kkpPw1MJNA4eOG38BZzZOo
	IfbKIS1jQQp8aGTMRzd3PPFbtLRtVrq64rSlo9tjJTyrcMPzdIO1wSb5kb++vQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114-ed25519; t=1762188970;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V3y+4DVGUspp58JJWY2SOnaLsTUPZnxETW8fSaQHj9Y=;
	b=UzNzfMyW6oVv2Xlx7iJyGeZa1lzjOal6Bnu7ppOxhsUxiUbNl1GY6q6xFP+veTL7EhrULo
	joOV7X6jU/nhkDBA==
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (8.18.1/8.18.1/Debian-7) with ESMTPS id 5A3Gu8J7034550
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 4 Nov 2025 01:56:09 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
	by devron.myhome.or.jp (8.18.1/8.18.1/Debian-7) with ESMTPS id 5A3Gu72F110914
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 4 Nov 2025 01:56:08 +0900
Received: (from hirofumi@localhost)
	by devron.myhome.or.jp (8.18.1/8.18.1/Submit) id 5A3Gu52E110913;
	Tue, 4 Nov 2025 01:56:05 +0900
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: Yongpeng Yang <yangyongpeng.storage@gmail.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo
 <sj1557.seo@samsung.com>, Jan Kara <jack@suse.cz>,
        Carlos Maiolino
 <cem@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>,
        Alexander
 Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Christoph Hellwig <hch@infradead.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        stable@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        "Darrick
 J . Wong" <djwong@kernel.org>,
        Yongpeng Yang <yangyongpeng@xiaomi.com>
Subject: Re: [PATCH v5 1/5] vfat: fix missing sb_min_blocksize() return
 value checks
In-Reply-To: <20251103164722.151563-2-yangyongpeng.storage@gmail.com>
References: <20251103164722.151563-2-yangyongpeng.storage@gmail.com>
Date: Tue, 04 Nov 2025 01:56:05 +0900
Message-ID: <871pmfoy1m.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Yongpeng Yang <yangyongpeng.storage@gmail.com> writes:

> Fixes: a64e5a596067bd ("bdev: add back PAGE_SIZE block size validation
> for sb_set_blocksize()")

Looks like inserted a strange '\n'? Otherwise looks good.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

