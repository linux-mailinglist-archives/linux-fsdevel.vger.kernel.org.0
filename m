Return-Path: <linux-fsdevel+bounces-30009-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 078D5984D80
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2024 00:16:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 386421C23465
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 22:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ACD41A7256;
	Tue, 24 Sep 2024 22:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="OMmuq5N3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300FF155733;
	Tue, 24 Sep 2024 22:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.252.153.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727216201; cv=none; b=U/wA88yRMRW09t8Nvxqu9IDAUowA6VjNRN5au242DYM65OBNvweMUhtrYEMfvKFUbTPNrLZhvqyqweB4agapuLpVvdpFy91UmDkTsq+zcpVvUul7C7ztCL23StDxR2cvQ9r3Xj7n/g8nVw7VZ8qWbjYxpuSw1i4qgTeyNTZReUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727216201; c=relaxed/simple;
	bh=NAzcutetzkcQ7ctSGMyqXC9H/utazFcCNrltc2Vavnc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=ZamJwj5swG+uoY1dLdszNcGNY1E+l9CiF9adEZPxBtSG196xd+v8IQ09YCW1WybH6qw6hHdn/PjyfxRSfr542hTnhA4oPSxJq5H/glUb7Sa9EQxsyFydGj2RNIlIVDbMnZMhs3a7EaxObusDJv1cuXOT47X7MwyfwSQ4Dh84eZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net; spf=pass smtp.mailfrom=riseup.net; dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b=OMmuq5N3; arc=none smtp.client-ip=198.252.153.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riseup.net
Received: from fews01-sea.riseup.net (fews01-sea-pn.riseup.net [10.0.1.109])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1.riseup.net (Postfix) with ESMTPS id 4XCvN70K6VzDqpY;
	Tue, 24 Sep 2024 22:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
	t=1727216199; bh=NAzcutetzkcQ7ctSGMyqXC9H/utazFcCNrltc2Vavnc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=OMmuq5N3lLughmsE5f9AITYXMtB9NfWcdOwTuOIt9lk2lEGZzpZGEkJBBshPQX5wh
	 f70SScM3cw6nnR0zIHYhJNGMth0nRBNmRwOUs8xmGKfbCLYmY4dwEwXq2iz0JndxYJ
	 RT4XQZfGM7Yz4goqBHLdPCNHsyCxF5GTjX+p9lyg=
X-Riseup-User-ID: CF5E84AB0525022E5CD54CEB4C5E38359FA0BECCD1066701FA4B363E2E51B29A
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews01-sea.riseup.net (Postfix) with ESMTPSA id 4XCvN5674FzJsw2;
	Tue, 24 Sep 2024 22:16:37 +0000 (UTC)
Date: Wed, 25 Sep 2024 00:16:32 +0200
From: =?ISO-8859-1?Q?Andr=E9_Almeida?= <andrealmeid@riseup.net>
To: Gabriel Krisman Bertazi <gabriel@krisman.be>
CC: Gabriela Bittencourt <gbittencourt@lkcamp.dev>,
 linux-kselftest@vger.kernel.org,
 Gabriel Krisman Bertazi <krisman@kernel.org>, linux-fsdevel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>, David Gow <davidgow@google.com>,
 kunit-dev@googlegroups.com, porlando@lkcamp.dev, dpereira@lkcamp.dev,
 ~lkcamp/patches@lists.sr.ht
Subject: Re: [PATCH 1/2] unicode: kunit: refactor selftest to kunit tests
In-Reply-To: <87wmj0wx10.fsf@mailhost.krisman.be>
References: <20240923173454.264852-1-gbittencourt@lkcamp.dev> <20240923173454.264852-2-gbittencourt@lkcamp.dev> <eb26f009-37e9-4988-ae86-c349af3f9a6b@riseup.net> <87wmj0wx10.fsf@mailhost.krisman.be>
Message-ID: <982829F8-9DDC-41FC-BE40-6489F931D1CE@riseup.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



Em 24 de setembro de 2024 23:40:27 GMT+02:00, Gabriel Krisman Bertazi <gab=
riel@krisman=2Ebe> escreveu:
>Andr=C3=A9 Almeida <andrealmeid@riseup=2Enet> writes:
>
>> Hey!
>>
>> On 9/23/24 19:34, Gabriela Bittencourt wrote:
>>> Instead of creating 'test' functions, use kunit functions to test
>>> utf-8 support in unicode subsystem=2E
>>
>> I think it would be nice to explain in the commit message what are the
>> benefits of this change, why refactoring into KUnit is a good idea?
>
>TBH, I wouldn't mind dropping this code altogether=2E  We have similar
>coverage in fstests already=2E It was useful when developing fs/unicode
>but nowadays, it seems moot=2E
>

I see, I still find it useful when doing Unicode changes=2E Even if usersp=
ace tests show that something is broken, unit testing might be more precise=
 in that regard=2E

I'm sure David also has some good arguments about that matter too :D

