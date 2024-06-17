Return-Path: <linux-fsdevel+bounces-21842-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 760F490B7F9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jun 2024 19:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C0EB2826FD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jun 2024 17:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6500016DEC4;
	Mon, 17 Jun 2024 17:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=debian.org header.i=@debian.org header.b="G3Q9mHiQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kvr.at (smtp.kvr.at [83.65.151.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4CA616DC32;
	Mon, 17 Jun 2024 17:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.65.151.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718645190; cv=none; b=B97/DI1faEptk4GNm8qRAYSytVM0kqbZCbjdhhpAQwpNHhQ49mLGjNH//Dzw+lZUl64mDudCCSoX/bpUaIqDrDuueKrQs7UAyvM0Zpk/oVXfNXG/2w4+aoUDQICnO5O5OUIhgulF5WUwexRYSN2uoiom2GWV9kZ+HBTZvnWbfGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718645190; c=relaxed/simple;
	bh=eroIsAP7wOvBXsB8a4Z+fCWgoahxgGvp7mSRwrsG1DM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Egg3QYuOZj7xPW3jDzeBCK1oPcOdhfgcAVbkG//ZL7H/wBDuRCHo83XJsSeBQGqW3jUq9w/jPvvye0h0jO1qnQd+uyB7mUHq0JUmlQZTjC7/qw5uMTPa8t/rN2TZG6gGWXo6eiVR1XykkZZRXfkqeVHZFQ6Ms8Vy6OfPafuq0qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (4096-bit key) header.d=debian.org header.i=@debian.org header.b=G3Q9mHiQ; arc=none smtp.client-ip=83.65.151.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=20200417.ckk.user; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
	From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=eroIsAP7wOvBXsB8a4Z+fCWgoahxgGvp7mSRwrsG1DM=; b=G3Q9mHiQA7hyoCjPxO4ITg3mvy
	jLmhcIeKAJMMFq4TmBvjfR0asmDuEwTKF92FMLIiHvj88/r9KO+Pc5oqHBspeV6gCO/rjLrcC5YoA
	oVxP02MWaepETm8JAVEoj8fkd4MOqCSOJj9KHYKD6vuDBc7yP9+bR+KRHupqDmn6hmYlZRkLcBPkG
	ETWWjNKPVG+72f+z+GKGoL41/iJH1Gzc27FuUPxSmVko2xliUfFL9Wx0dWmdxWz0qq437vQUVCCa7
	+cm4vz/G6TuiUHLn9zdND5+W0FISCaFyE932jzgBcp0sgTUnR9gyANminHUF3Bs2qaGxDZJeGs/7E
	avHSdiDvVRTq2lu9PycGcdEQhQX/XhpToO2NdbOFsHjTuOC7R8utV5syBjD98TtudBs1Y9i95vtAO
	wchqjgKEOFrX4bC75vIgg1UjNFydAMrQ/EfyZJOU7/rOk4fKqoXkx38hzOZ5qg7VDSO1gDmce5i0i
	DtC77QzVzvKMGApRmI3pQVGg1LqszGbpU9xcWOxq61d8dWuVgo9J6KKI2h+Grd1KcY+fkbRu2evun
	ix12GQk95O4yu72jkd0WPlHiXv9flF+Qr7nUkL5BYHTpko80qWGJEu4+w0ArgrqkiUfJU9DKNOYX1
	iWOqv7aANppxW5tbVgM02dQqJJXr6Epu8rwrgsacc=;
Received: from [192.168.0.7] (port=58816)
	by smtp.kvr.at with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.97)
	(envelope-from <ckk@debian.org>)
	id 1sJFsf-00000006mK8-1MJu;
	Mon, 17 Jun 2024 19:10:56 +0200
Message-ID: <57e56ca5-bbbc-495a-926e-54d7e2f5e76c@debian.org>
Date: Mon, 17 Jun 2024 19:10:56 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 40/40] 9p: Use netfslib read/write_iter
To: David Howells <dhowells@redhat.com>
Cc: Andrea Righi <andrea.righi@canonical.com>,
 Eric Van Hensbergen <ericvh@kernel.org>, linux-afs@lists.infradead.org,
 linux-cifs@vger.kernel.org, v9fs@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Luca Boccassi <bluca@debian.org>,
 TJ <linux@iam.tj>, Emanuele Rocca <ema@debian.org>
References: <Zj0ErxVBE3DYT2Ea@gpd>
 <20231221132400.1601991-1-dhowells@redhat.com>
 <20231221132400.1601991-41-dhowells@redhat.com>
 <531994.1716450257@warthog.procyon.org.uk> <ZlnnkzXiPPuEK7EM@ariel.home>
Content-Language: en-US
From: Christian Kastner <ckk@debian.org>
Autocrypt: addr=ckk@debian.org; keydata=
 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
In-Reply-To: <ZlnnkzXiPPuEK7EM@ariel.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 2024-05-31 17:06, Emanuele Rocca wrote:
> Meanwhile TJ (in CC) has been doing a lot of further investigation and
> opened https://bugzilla.kernel.org/show_bug.cgi?id=218916.

just to loop back to the MLs: in the referenced bug, TJ posted an
analysis and and added a patch that fixed the issue for multiple testers.

Best,
Christian

