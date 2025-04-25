Return-Path: <linux-fsdevel+bounces-47376-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D0ECA9CD56
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 17:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C71A4A6743
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 15:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6B9289371;
	Fri, 25 Apr 2025 15:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QYkWPO+/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A35218ADE;
	Fri, 25 Apr 2025 15:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745595628; cv=none; b=Sxuw7KtYcbz6d3vmdx194fe1vmlYr3piGGvcbH/4zevDiTTQHLr5yrMbEDIQefVLbicbALiI8IYjn01NYW6/t7SclyPlZmhJmYG9YX2qOKDhKTMQPz55tNq/2pkOM/u+sthUPWl4nKzRiW35W0D0L4UtzmjHoNE1nL00h6H1P9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745595628; c=relaxed/simple;
	bh=xM4Z3LtZ7LXHApwD4pFmA72hVFcFp2bzGljl/jzk/58=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=KFHVPHA9OEuQsR/6UPhtkiHkUnCUMigMk7Kf35KKcdatZSxq1eZn1uV09NfIwK62/0TqawVUCwuewPzwIdI2tOv9zByBkP1g12Hi4KkH4k0v1fFid/tbnDjExyiWKa2Nu0C1lTnJak4GGnHXS5TUrJP2QdgT9jZImWbXr70PoeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QYkWPO+/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3C2BC4CEFA;
	Fri, 25 Apr 2025 15:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745595627;
	bh=xM4Z3LtZ7LXHApwD4pFmA72hVFcFp2bzGljl/jzk/58=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=QYkWPO+/5ZeiSI9UJ43sTd/W+Eh8IQLzXJbIBOEf/tLtASg41adpBCSQ1vltBB/rO
	 OOdykLAaEVC4vQsB63nsaYyY7Jcn1R72Q58OLOwR7YPLjGAC9xlBrm7BxkPDBwxK48
	 xSpd6//JQ5+kU08HDHiH1ErPgua9bcLfmoAZdEeN1st5sukFFXrGf05tkFo7L5Blnu
	 J28B2C7Jr1LQPCogKca9c9lAgzs3M1yEqUU86C6L9oRMx/Kq4tXv3FvuWNKQlyjRX8
	 dZeWwLfrrMsp7NO8hGHKMoTBoXk9ySRhVyParE8TDPK7MWKnl9Cl04Y+ZcvbV75g5a
	 lDZ3t4GURkZMQ==
Date: Fri, 25 Apr 2025 08:40:23 -0700
From: Kees Cook <kees@kernel.org>
To: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>
CC: Heiko Carstens <hca@linux.ibm.com>, gregkh@linuxfoundation.org,
 rafael@kernel.org, dakr@kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>, Xiao Ni <xni@redhat.com>
Subject: Re: [PATCH] devtmpfs: don't use vfs_getattr_nosec to query i_mode
User-Agent: K-9 Mail for Android
In-Reply-To: <20250425133259.GA6626@lst.de>
References: <20250423045941.1667425-1-hch@lst.de> <20250425100304.7180Ea5-hca@linux.ibm.com> <20250425-stehlen-koexistieren-c0f650dcccec@brauner> <20250425133259.GA6626@lst.de>
Message-ID: <D865215C-0373-464C-BB7D-235ECAF16E49@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On April 25, 2025 6:32:59 AM PDT, Christoph Hellwig <hch@lst=2Ede> wrote:
>On Fri, Apr 25, 2025 at 12:12:36PM +0200, Christian Brauner wrote:
>> > That is: if dev_mynode(dev, inode) is not true some random value will=
 be returned=2E
>>=20
>> Don't bother resending, Christoph=2E
>> I've already fixed this with int err =3D 0 in the tree=2E
>
>Thanks!  Let me use this as a platform to rant about our option
>defaults and/or gcc error handling=2E  It seems like ever since we starte=
d
>zeroing on-stack variables by default gcc stopped warnings about using
>uninitialized on-stack variables, leading to tons of these case where
>we don't catch uninitialized variables=2E  Now in this and in many cases
>the code works fine because it assumed zero initialization, but there are
>also cases where it didn't, leading to new bugs=2E

This isn't the case: the feature was explicitly designed in both GCC and C=
lang to not disrupt -Wuninitialized=2E But -Wuninitialized has been so flak=
ey for so long that it is almost useless (there was even -Wmaybe-uninitiali=
zed added to try to cover some of the missed diagnostics)=2E And it's one o=
f the many reasons stack variable zeroing is so important, since so much go=
es undiagnosed=2E :(

>Can we fix this somehow?

Fixing -Wuninitialized would be lovely, but it seems no one has been able =
to for years now=2E =F0=9F=98=AD

--=20
Kees Cook

