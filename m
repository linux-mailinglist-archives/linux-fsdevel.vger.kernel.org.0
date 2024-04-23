Return-Path: <linux-fsdevel+bounces-17494-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2871E8AE337
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 12:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC1B71F210C0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 10:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 561E9762E8;
	Tue, 23 Apr 2024 10:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b="rFw7Pipw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476A554BF4;
	Tue, 23 Apr 2024 10:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.82.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713869913; cv=none; b=BgV10Osqx5Num1WT5IakzsTOAzku5s6hynLuylIB1hq/WP2z31ZiNcrF4r3HYOGqEP5NXzsvxe2HhGQlwH4JY+B78HgcNzMduN5OS1DASe3iBRIe2FTkUAPlBltXjPyM05AgB0/plEdmUvQoQ93x18Kaxy7wgNnkXThVN+ZDLno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713869913; c=relaxed/simple;
	bh=Rncnh7ZhSNEX3awwKWopqVkmtLCPXwdQ6MAPyaR9g2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wi7u0WBxAmasqD+RZixo4qGFpX95RfIP0gxGYrVSVI1uCEX6oUE63oWjyFnuP9zrurFzoqJSA6OWub8BzBTvUthUIEUJ4AILadJhJRkpLtCUjuVPbrJOLjpnfhoEJ8NRKGgeMpD7V7YvyZltT5RjzE/zG5P5XpZnm9lNrSoPRsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; spf=pass smtp.mailfrom=samba.org; dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b=rFw7Pipw; arc=none smtp.client-ip=144.76.82.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=From:Cc:To:Date:Message-ID;
	bh=mMx9swMS61DtwxCxz+rf6ZcLr+qj4g5NB1qqBI2FYfc=; b=rFw7PipwGvsozchJmgVbvLmwLX
	T83Y5OkcdFKR4FJHKj56blal67tnqCnik8k35+v2kHBp0mzfi2qMECEyENSet0FEu1aFpwu+cl/LG
	fPBBK4GSSNe9eDP3vASmXSLSeA7KYdo5kqLOtFqdzHHtv0KmraBLLFHgKBycdVGEcTdV1JtaU1nN4
	IvWgsuLHHW2GhMqXFwsCsX0pNdOpuyIsIVyWfZwM+TQTfvb5ZjsAXppVYW23l6cSCi1wRkCx3XR1u
	GupEZJjsCF196wdsRb2ThDds7YZ+s2hI6sZF021tr0F/kr04yEHRdj+Y3e7F16N3pxSXNPYahvxKi
	07ToC/Tp0dgFsIZonBoacMZf4pHVkeVF5gnyDsAHbO+Zn4lU3SrcR2JUkAY22HFacy8Dyxc4iQwRx
	WZMtsxN7R91oFswL1VrHHITEbGEJA0rAlVrUt0/+HcHAHyRWPPrIs2AgHSCnyW0plLJmM8+4/EmDy
	Td+OA5fHOLJmYeOKW+4gA6Ej;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1rzDr0-007rgx-0R;
	Tue, 23 Apr 2024 10:58:26 +0000
Message-ID: <a24f8d8c-2e7e-41ff-a640-134501ba4fa2@samba.org>
Date: Tue, 23 Apr 2024 12:58:25 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] implement OA2_INHERIT_CRED flag for openat2()
To: Stas Sergeev <stsp2@yandex.ru>, linux-kernel@vger.kernel.org
Cc: Eric Biederman <ebiederm@xmission.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@kernel.org>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
 Alexander Aring <alex.aring@gmail.com>, linux-fsdevel@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>,
 Linux API Mailing List <linux-api@vger.kernel.org>
References: <20240423104824.10464-1-stsp2@yandex.ru>
Content-Language: en-US, de-DE
From: Stefan Metzmacher <metze@samba.org>
In-Reply-To: <20240423104824.10464-1-stsp2@yandex.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 23.04.24 um 12:48 schrieb Stas Sergeev:
> This patch-set implements the OA2_INHERIT_CRED flag for openat2() syscall.
> It is needed to perform an open operation with the creds that were in
> effect when the dir_fd was opened. This allows the process to pre-open
> some dirs and switch eUID (and other UIDs/GIDs) to the less-privileged
> user, while still retaining the possibility to open/create files within
> the pre-opened directory set.
> 
> Changes in v2:
> - capture full struct cred instead of just fsuid/fsgid.
>    Suggested by Stefan Metzmacher <metze@samba.org>
> 
> CC: Stefan Metzmacher <metze@samba.org>
> CC: Eric Biederman <ebiederm@xmission.com>
> CC: Alexander Viro <viro@zeniv.linux.org.uk>
> CC: Andy Lutomirski <luto@kernel.org>
> CC: Christian Brauner <brauner@kernel.org>
> CC: Jan Kara <jack@suse.cz>
> CC: Jeff Layton <jlayton@kernel.org>
> CC: Chuck Lever <chuck.lever@oracle.com>
> CC: Alexander Aring <alex.aring@gmail.com>
> CC: linux-fsdevel@vger.kernel.org
> CC: linux-kernel@vger.kernel.org

I guess this is something that should cc linux-api@vger.kernel.org ...

metze


