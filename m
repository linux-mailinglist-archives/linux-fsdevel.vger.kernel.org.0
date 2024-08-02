Return-Path: <linux-fsdevel+bounces-24849-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F2BD9456AA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2024 05:28:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E1151F24A9C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Aug 2024 03:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD48A955;
	Fri,  2 Aug 2024 03:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gndKFcda"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E78632;
	Fri,  2 Aug 2024 03:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722569295; cv=none; b=SE8nYQcZSnrrTwKUyuJMGwlZgfVQM+RZltFYDdmRQeT3Ij/D78PweCoIIq17TqCyVSuf46rKOlJNU1n0FUkVofqdJA6Zv3rMO+jtnuk///TnxCUTdwMxokIalzK9Mcfn1Kird6AiEn7CI7dB/PTAiO4UuraPKeu7vKq1PRoOsnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722569295; c=relaxed/simple;
	bh=AqRC/eavpLox64IoEZeEvoEasmNJBYMHNUQruJqiQv0=;
	h=Date:From:To:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=WjXMuJcAqoo/rAIOESUV8xKlScMfOp1mRtMb/BvR9O4WgwTYvCYiSC+vMc6z23zE7r3dSW8DeGzcxKox5Szp4GzpryGy+xDZv15K9zEQRcfftQhudX8RbCtmvuenbVS2voB5gMtM0TUdTVj8TIbhmcz8UrTJ357tTl0sWCYkNVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gndKFcda; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78514C32782;
	Fri,  2 Aug 2024 03:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722569294;
	bh=AqRC/eavpLox64IoEZeEvoEasmNJBYMHNUQruJqiQv0=;
	h=Date:From:To:Subject:In-Reply-To:References:From;
	b=gndKFcdaHsNwz1m3QgHdEY0go1uf9qVzBpD5hm+CBCVNQP9ma+J6XFgwOrKuYtR3x
	 gvOKZpdvHH9iGoGF3s3Jrp8EMcEGtsVErs+QmTZNH95JM8K4sFthZ2DxX1VEp6NNJt
	 RsO/4UmNwCLIWzZ4EtsFG0rub1Zmvs8AZwRMnUkAnDKAnY5Gt5MFCqNhll6Lvsx+ps
	 nI9EwjXVkV/DzyndvZ1UzdxcH/jPWMJ9G68FBlaxgg/FweUKjfUButkXzgH6LMeael
	 qNnFaJqogCwQjnCzGstXZpJ+1j7CrFI0j9t+eeqvw3tmtdgW4EWxxTE1WVRgWiXfkR
	 bLgp2wQC3weYQ==
Date: Thu, 01 Aug 2024 20:28:12 -0700
From: Kees Cook <kees@kernel.org>
To: =?UTF-8?Q?Wojciech_G=C5=82adysz?= <wojciech.gladysz@infogain.com>,
 viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
 ebiederm@xmission.com, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_kernel/fs=3A_last_check_f?=
 =?US-ASCII?Q?or_exec_credentials_on_NOEXEC_mount?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20240801120745.13318-1-wojciech.gladysz@infogain.com>
References: <20240801120745.13318-1-wojciech.gladysz@infogain.com>
Message-ID: <C96FCBBF-6D63-431F-AEA8-81B7937CB9B1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On August 1, 2024 5:07:45 AM PDT, "Wojciech G=C5=82adysz" <wojciech=2Eglad=
ysz@infogain=2Ecom> wrote:
>Test case: thread mounts NOEXEC fuse to a file being executed=2E
>WARN_ON_ONCE is triggered yielding panic for some config=2E
>Add a check to security_bprm_creds_for_exec(bprm)=2E

As others have noted, this is racy=2E I would still like to keep the redun=
dant check as-is, but let's lower it from WARN to pr_warn_ratelimited, sinc=
e it's a known race that can be reached from userspace=2E

--=20
Kees Cook

