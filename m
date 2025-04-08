Return-Path: <linux-fsdevel+bounces-45976-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A27DA801F8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 13:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C55E462516
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 11:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 547A2268C61;
	Tue,  8 Apr 2025 11:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="scpJC7kU";
	dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b="EanyYM60"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB87F2288CB;
	Tue,  8 Apr 2025 11:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.171.160.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744111964; cv=none; b=Sj1mBrI998QNECUjXopMMrODpmaedX5KMRf32hLP+9B+e1y831Eth9ni8Ro6DNuUeLbMldJFOj9CMpEpBeBiqpyGVTOQKTJETBTcae8JG0dQUVQZ54i38xaw6eXY/hk8x3+HcFJutx23cysamqrn9pjnezp2cTXFMwe2tKEBo9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744111964; c=relaxed/simple;
	bh=Xs8PJBU/iWCgCOVJ5fPwYHizshTqxB2SddH3d9H0hhA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gP3c8OIlEO80AYETU/yp0R02/wblCMv4x8QLgBCuHACzItSTyuvBBxDeXtxtgYrdnFmYG5FcpKnyv0xHlw761AMFYpzX+UuXbSYM/kNeqSF1ABefyvq7/btX8Jmfa2vrzx42mFQSjILPrWUmALge8eJRO1nBtzK4lT9m5rLXEn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp; spf=pass smtp.mailfrom=parknet.co.jp; dkim=pass (2048-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=scpJC7kU; dkim=permerror (0-bit key) header.d=parknet.co.jp header.i=@parknet.co.jp header.b=EanyYM60; arc=none smtp.client-ip=210.171.160.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.parknet.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=parknet.co.jp
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
	by mail.parknet.co.jp (Postfix) with ESMTPSA id 73FA0209655E;
	Tue,  8 Apr 2025 20:27:29 +0900 (JST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114; t=1744111649;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eclY3tA3zystiASLWhhinS2NZVbTVtIRsNQzHJbWjV8=;
	b=scpJC7kU+WJfI3elD0AmrrqQ8rv47m1hGbnZUq85ivFjNcDWY/U97xKL0wlQmsEe2nWnF6
	fyJKqaNccL1Pw1r979uRPcjsUcuPOMkVxi+flIpbQzN+9OR9eI2I8b2HNXQwYAeIbsVyR8
	dCbg1DmfDIHv0wK4GVgOw1Smcwb5YaO1EY9L2VSGuG03Ib/cFVzmg+6E1hNqNY3MmDrJrA
	oH8EYt3Nc/IarHvcO8tpH4dHazuqkaX/c+cgSixzOEuL7M8fudqoTRCTsoqnOl8qnrCKVB
	taZx6tI2yi3/pIhFIXoWzIFYetpkf5DN+4Z7gPc9X1EOmtWHRKeNLBonAO+hDA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=parknet.co.jp;
	s=20250114-ed25519; t=1744111649;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eclY3tA3zystiASLWhhinS2NZVbTVtIRsNQzHJbWjV8=;
	b=EanyYM601dLl/HVbStSWN7E3LzgFC4FXwl7RqTj6e4QefxQtMl+mdSR4uWjIE2NS7vfJBt
	QdYS73GWOQIzGVDQ==
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
	by ibmpc.myhome.or.jp (8.18.1/8.18.1/Debian-6) with ESMTPS id 538BRS7U473091
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 8 Apr 2025 20:27:29 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
	by devron.myhome.or.jp (8.18.1/8.18.1/Debian-6) with ESMTPS id 538BRSTY1314074
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 8 Apr 2025 20:27:28 +0900
Received: (from hirofumi@localhost)
	by devron.myhome.or.jp (8.18.1/8.18.1/Submit) id 538BRRVC1314073;
	Tue, 8 Apr 2025 20:27:27 +0900
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To: Phillip Lougher <phillip@squashfs.org.uk>
Cc: Jan Kara <jack@suse.cz>, Andreas Gruenbacher <agruenba@redhat.com>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo
 <sj1557.seo@samsung.com>,
        Carlos Maiolino <cem@kernel.org>,
        "Darrick J.
 Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: Recent changes mean sb_min_blocksize() can now fail
In-Reply-To: <86290c9b-ba40-4ebd-96c1-d3a258abe9d4@squashfs.org.uk>
References: <86290c9b-ba40-4ebd-96c1-d3a258abe9d4@squashfs.org.uk>
Date: Tue, 08 Apr 2025 20:27:27 +0900
Message-ID: <87zfgqq4f4.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Lougher <phillip@squashfs.org.uk> writes:

> A recent (post 6.14) change to the kernel means sb_min_blocksize() can now fail,
> and any filesystem which doesn't check the result may behave unexpectedly as a
> result.  This change has recently affected Squashfs, and checking the kernel code,
> a number of other filesystems including isofs, gfs2, exfat, fat and xfs do not
> check the result.  This is a courtesy email to warn others of this change.
>
> The following emails give the relevant details.
>
> https://lore.kernel.org/all/2a13ea1c-08df-4807-83d4-241831b7a2ec@squashfs.org.uk/
> https://lore.kernel.org/all/129d4f39-6922-44e9-8b1c-6455ee564dda@squashfs.org.uk/

Thanks. FATfs should have no issue.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

