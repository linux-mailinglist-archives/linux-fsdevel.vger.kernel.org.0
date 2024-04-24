Return-Path: <linux-fsdevel+bounces-17648-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E958B0DA0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 17:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6C3028CB11
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 15:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D347D15EFC2;
	Wed, 24 Apr 2024 15:08:35 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF32F15EFC6
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Apr 2024 15:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713971315; cv=none; b=lTNZtAp5pNpb8Mk2bUVdUwOeDubMqOlX9g4LB6UUHDm9hNHhTr+9uej4DzHd9De+ebsJ20AMVr+wHizSuRNvAZclVVoUR5q27UlMfsHMtuABAJTPvhJYjaamCVLasMCUyMzhq9gQT5oaHA8ij/k2ssCsSIoPIBjOGYzEzhTGz9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713971315; c=relaxed/simple;
	bh=qREzu0s42RSSag5nRvYhkWQipCguhNdXRrZs0HQD/xY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=EFEiY8M7P/fjuWRKl6HxJO3JHsoui+TFsbU9P+xLygxgPCdO6oFSqlUHtmBZr6OunK3ZkXQKI9HxW5i6RWaifKgm6HaCqdnIer4zm92a4gadhWh11o9nMjRl25Cc/3TUzOMY027No+aHLuAsr1XbBWGE/vA8bJWehKSBEBjQh0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-281-H7tQNjMuNnWR4Mbvb0LCdw-1; Wed, 24 Apr 2024 16:08:24 +0100
X-MC-Unique: H7tQNjMuNnWR4Mbvb0LCdw-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 24 Apr
 2024 16:07:55 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 24 Apr 2024 16:07:55 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'stsp' <stsp2@yandex.ru>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Eric Biederman <ebiederm@xmission.com>, Alexander Viro
	<viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara
	<jack@suse.cz>, Andy Lutomirski <luto@kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: RE: [PATCH 1/2] fs: reorganize path_openat()
Thread-Topic: [PATCH 1/2] fs: reorganize path_openat()
Thread-Index: AQHalJJk8Yta93gecEuTWlpT1K4OxbF3JeNwgAAM7QCAAFY54A==
Date: Wed, 24 Apr 2024 15:07:55 +0000
Message-ID: <e12149437c4b4e609ccefef66701a082@AcuMS.aculab.com>
References: <20240422084505.3465238-1-stsp2@yandex.ru>
 <858f6fb6afcd450d85d1ff900f82d396@AcuMS.aculab.com>
 <6c9e5914-8dee-4929-b574-f59f50305f4a@yandex.ru>
In-Reply-To: <6c9e5914-8dee-4929-b574-f59f50305f4a@yandex.ru>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

RnJvbTogc3RzcA0KPiBTZW50OiAyNCBBcHJpbCAyMDI0IDExOjU5DQouLi4NCj4gUG9zdGVkIHY0
IHdpdGggdGhpcyBjb2RlIHZlcmJhdGltLg0KDQpOb3BlIC0geW91J3ZlIGp1c3QgcG9zdGVkIGEg
ZGlmZmVyZW50IHZlcnNpb24gb2YgdGhlICd2MScgcGF0Y2guDQpTaG91bGQgYmUgW1BBVENIIHY0
IDEvMl0NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxl
eSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0
aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==


