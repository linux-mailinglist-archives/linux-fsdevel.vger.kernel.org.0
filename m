Return-Path: <linux-fsdevel+bounces-32679-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D51E9AD4EF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2024 21:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31AC71F21F2E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2024 19:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569511DD0D3;
	Wed, 23 Oct 2024 19:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="Rd6smkGo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4FE83CDA;
	Wed, 23 Oct 2024 19:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729712333; cv=none; b=aDyZmNlFtsv7QoRydby5bjuOw0/zadpE7NJecI2kHw+sOqZ3AzmgLQDpSq4HvQQhzjaIvd1O+oFpLjFiuCuLCxviW8lt2UHapSn1lO2gAwt89eD30JpcxDmLWziRaqVJXOaLtKS6Z4Ol1x8HXo3X3vMHM7Lna5Nt48d+uU69K0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729712333; c=relaxed/simple;
	bh=pZd83N5LKORVi3t9LWs6w8gSvKkToNeI2Gv/S936pGc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q368jhiCy7jNhroKbwZT1yQUZi2cCoREZRmw4mG8LXSI7FiNceo8jtXKumDesfFKqMgASp6Li6QWlC9ftv10dB9pdLE+S7nmKjqHIWQIggvWT9Hes4tQZ1vtL0oK+6HNa4A3LyVae/WAgnmshMLxXxa9unaYKo5Cez6SOgfgeqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=Rd6smkGo; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 814BE20842;
	Wed, 23 Oct 2024 21:38:48 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2XZ8ubZrULdx; Wed, 23 Oct 2024 21:38:47 +0200 (CEST)
Received: from cas-essen-01.secunet.de (rl1.secunet.de [10.53.40.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id D98D32074A;
	Wed, 23 Oct 2024 21:38:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com D98D32074A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1729712327;
	bh=uwlhbuYxhgG8sftTwRRQlyfVeglWzt2ynojBOuu12rQ=;
	h=Date:From:To:CC:Subject:Reply-To:References:In-Reply-To:From;
	b=Rd6smkGo3UJQ1pLzL7bTloWJLbLDhbEfx/WQXzI3icKQNFW1qs2iqBJuHs2YWiA/E
	 3qSyIIR+EQiq8B2VkKciYQuOps51ndNIJ91ukr8QzA69cBmX/V22UzM4ompznfFJBy
	 0IvDk62uc3VPTB4Bglg4NIIWHIQN2kVtuLw4KEk4CFUYtOuS1WZ3lb+qBlsW+8FhPh
	 UHnYhNjwSqcWO06JicLtFIxRXUls7q0pqvkhpme4Fbnd88cOdqcDVXmzaya2xqXRAC
	 cYk5+KcBKjfcAA/oemL1TqA2CuiNkx1PoeQA+BRRymXlJsKp6asyi20pW5wEZpyT2h
	 /Lws9D62X6SMA==
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 23 Oct 2024 21:38:47 +0200
Received: from moon.secunet.de (172.18.149.1) by mbx-essen-01.secunet.de
 (10.53.40.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Oct
 2024 21:38:46 +0200
Date: Wed, 23 Oct 2024 21:38:39 +0200
From: Antony Antony <antony.antony@secunet.com>
To: David Howells <dhowells@redhat.com>
CC: Antony Antony <antony@phenome.org>, Christian Brauner
	<brauner@kernel.org>, Eric Van Hensbergen <ericvh@kernel.org>, "Latchesar
 Ionkov" <lucho@ionkov.net>, Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>, Sedat Dilek
	<sedat.dilek@gmail.com>, Maximilian Bosch <maximilian@mbosch.me>,
	<regressions@lists.linux.dev>, <v9fs@lists.linux.dev>,
	<netfs@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Antony Antony <antony.antony@secunet.com>
Subject: Re: [REGRESSION] 9pfs issues on 6.12-rc1
Message-ID: <ZxlQv5OXjJUbkLah@moon.secunet.de>
Reply-To: <antony.antony@secunet.com>
References: <ZxFQw4OI9rrc7UYc@Antony2201.local>
 <D4LHHUNLG79Y.12PI0X6BEHRHW@mbosch.me>
 <c3eff232-7db4-4e89-af2c-f992f00cd043@leemhuis.info>
 <D4LNG4ZHZM5X.1STBTSTM9LN6E@mbosch.me>
 <CA+icZUVkVcKw+wN1p10zLHpO5gqkpzDU6nH46Nna4qaws_Q5iA@mail.gmail.com>
 <3327438.1729678025@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3327438.1729678025@warthog.procyon.org.uk>
Precedence: first-class
Priority: normal
Organization: secunet
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-01.secunet.de (10.53.40.197)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Wed, Oct 23, 2024 at 11:07:05 +0100, David Howells wrote:
> Hi Antony,
> 
> I think the attached should fix it properly rather than working around it as
> the previous patch did.  If you could give it a whirl?

Yes this also fix the crash.

Tested-by: Antony Antony <antony.antony@secunet.com>

thanks,
-antony

