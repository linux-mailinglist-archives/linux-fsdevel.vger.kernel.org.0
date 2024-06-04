Return-Path: <linux-fsdevel+bounces-20895-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3868FAA18
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 07:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7606E1F253C2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 05:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5774A13FD92;
	Tue,  4 Jun 2024 05:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XCrPu5sT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A879027735;
	Tue,  4 Jun 2024 05:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717479811; cv=none; b=Nuy2MTWurQt3ELtJs0Lg8uwdBQOG7INQ6VdOoezoPzGm4xGLu3lBDMmT7E+A76OXvktx14sXNysbGYD/7OR4ctup9hsV2j94Lu2aaWbJsazfiryGsgkYuKQa+3Y77F8uWidmy3VNwQW+VM11w298igh7pOecY1/rk1RCcllWavc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717479811; c=relaxed/simple;
	bh=K4RIn52C4629tpAJrB1DNztACdKMcNhUOgQZtSagcuc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=ELftq1/jIB5exWgAUPyJqTZk/SY0ITjIagTcQzpY4KSqXuhK0iyKC745vV9HP/O7VsD5u0bXvYr0uZbCjhgsH1kUynkVZ4O61A188AblHjXuuf+w375yxFDGeQAOE/WjprPaL88uM5LfTaj/PHIa0nU5TZulttTyGmNW6SNoppQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XCrPu5sT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82BB1C2BBFC;
	Tue,  4 Jun 2024 05:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717479810;
	bh=K4RIn52C4629tpAJrB1DNztACdKMcNhUOgQZtSagcuc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=XCrPu5sTVtMkHlbQlOUn29wOkTwRKGedBoQliD2UelJ/rWRclj1alcNnY0nvvEIxP
	 /fVdH895VpN3FEAunruYC9TkdrkVG6UYGlYSLS/7nI15Kqysm5ZNhv01HnwhOpqcv4
	 Xzx5QGQn87oRpbMmfCR08dHrVErqE4R0EYbe1LiU7i4fTL0O1HnnwTid+ZtR6p6LYc
	 beRAQZbIvT1nw+ko56xJquvpDzww9otbMoHsq0pVnYrK/ICUDPuc5KsrOUsrmoijFK
	 M+ah0IlnrUlAWML4S7GPADlCoH3B8OxK1o2QTHTmlJhKnyaopG1Ve0grsYhqYIpj6N
	 TJoS89qMZ5S6A==
Date: Mon, 03 Jun 2024 22:43:31 -0700
From: Kees Cook <kees@kernel.org>
To: Christoph Hellwig <hch@lst.de>, Terry Tritton <terry.tritton@linaro.org>
CC: hch@lst.de, "ttritton@google.com" <ttritton@google.com>, edliaw@google.com,
 keescook@chromium.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: Change in splice() behaviour after 5.10?
User-Agent: K-9 Mail for Android
In-Reply-To: <20240604045030.GA29276@lst.de>
References: <CABeuJB1RP8wty0AObsmw+FCWMNyAmrutL-ZXy9ZwnZ8oK1iGSg@mail.gmail.com> <20240604045030.GA29276@lst.de>
Message-ID: <7F3B484F-9555-486A-B19A-5A8EB6442988@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On June 3, 2024 9:50:30 PM PDT, Christoph Hellwig <hch@lst=2Ede> wrote:
>On Mon, Jun 03, 2024 at 10:59:15AM +0100, Terry Tritton wrote:
>> Hi,
>> We've found a change in behaviour while testing the splice07 LTP test=
=2E
>> In versions before 5=2E10 the test will hang on certain combinations bu=
t after
>> 5=2E10 the splice call will return=2E
>> I bisected the change to the following commit:
>>     36e2c7421f02a22f71c9283e55fdb672a9eb58e7
>>     fs: don't allow splice read/write without explicit ops
>>=20
>> There has been some discussion on the LTP github page already:
>>     https://github=2Ecom/linux-test-project/ltp/issues/1156
>
>In that case the return probably is an error because epoll doesn't
>support read_iter/write_iter and thus completely expected=2E
>
>If the underlying bug hasn't been fix in the mean time that probably
>means it will be back if Jens' conversion of all misc file operations
>to the iter based ones every gets merged=2E
>
>If you are interested more in this please discuss it on the relevant
>mailing lists instead of in private mail=2E

Eh? LKML is in CC=2E=2E=2E

I've added fsdevel and Jens now too, though=2E=20

-Kees

--=20
Kees Cook

