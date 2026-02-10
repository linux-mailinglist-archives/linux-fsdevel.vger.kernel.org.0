Return-Path: <linux-fsdevel+bounces-76832-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OP7sJ/n+imnJPAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76832-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 10:48:41 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E298119165
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 10:48:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6D6483015BB8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Feb 2026 09:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D507E342C88;
	Tue, 10 Feb 2026 09:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bF6enQai"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85D6342148
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Feb 2026 09:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770716907; cv=none; b=UHr4KpER/etclaOJyNAJaAX36rJC0moFNBCzGAm7oAkuCX6zQKxqQ9lKd3Ur5AMuSL4rXVm5y+8cFQqo59fXxVhCvZsBd7Nb1RY68SkKKxpuESdUDZ4m3U9ZsRPVnFHv7xAb2rjV0tiKwutlXYsnWDut6HnZEzZNmWP29qNQp6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770716907; c=relaxed/simple;
	bh=JzjL9KmnIvI+N5fZ4VXxWV6Lk6yV/WK6vGyi7HxNWlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pKDmsIzrdQC/qSfO9909LI0ID5GH9fPAHRnFDn5bLBZ0Tz+eR7iU+6NdxYEOgVSVkpEuQwDUQ5JUO5d6jnD4nOztihcWIsLjdilG/nLkR4u++7ODmeHH2eusDEMN/dp+NkxzyvptoD6zuWUD5ridPEtWXygfHWMZ1nBMziKkM+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bF6enQai; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-480706554beso41558125e9.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Feb 2026 01:48:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1770716903; x=1771321703; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0DlsZoRVip+D7R3X4OfoBB69slLASuqjli/DRTFoTD4=;
        b=bF6enQaiJg/0+N0Rr72kPFL5Ce1noSAAvrL165k907IQJvR9+HgC1pm/NcjhLRHA5q
         Ob0/N5M0uJoRD/2ICfMXAe9Du938FkG62PRwhokJO6rqVwheSz5r/hN8AuiDVs66GW83
         SA3/SlC9ulMcPUEU0wJxU7JHstlH8w3LdDmGD8v7M+o1IbChJYBjsMdig2yVOKLuq7jo
         czFjxVeqWIbu/2qN1v5SDcQMPAFMq8qtszeeBVDq9j6HKCfyDElouFEBZntZEccvJWja
         pc3tU8uxSvpUYlMxJ1Kv8gvpvBp5CymjPdSe2IFZyXnV0VU/e4YBlUWDsQ0u6IStIZxf
         2Nqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770716903; x=1771321703;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0DlsZoRVip+D7R3X4OfoBB69slLASuqjli/DRTFoTD4=;
        b=rAJimJYdPMQnaY4riAxI2aGydw/FbWi613BbeIX4Gs3WGprsCYWcGh+Ap6ieRpsPOB
         D7eKtf8KF1SOHyDmzxC8L2H0EIEhmHya3DkpimtInYlbyiYMw4DS1Xw3wvde3slrdtuR
         fDlCixd5sqaIDDblx1gmqB4vUl+99qHwoZ0qTtrLHsh4WTbQdMttZLnaHOHB47s3/VqW
         +5pqCoQxoXrbzyiPhTYOdnoj/luc/y8FwhhQrMv6PCv5NxVfabSvgupR+Y2B0B8CKCda
         35tX8mFvjkoHV0NHtNOCouBjJ1jj6A1y22sVi4fGDLeaRJUM8A/q84sRHa/oncazbi9J
         ceZA==
X-Forwarded-Encrypted: i=1; AJvYcCXPoT8WN418XKQWneoza6BnB2XIFMjpa/THW/pLffYgMaaUwzMxijU9ExPQVXXAXq9NQA69yjfhL8S5wwkn@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4Uayjmv6N9jYw//26j0+3MjBpBtZK0Bp9O1F6KKKRitJEUDUy
	uOSyQ9KUkda/Io6WMCG2xDiotb2is1NCWGzEce9tl+SCgGEHu1/AEvWj6usaSm4z5OI=
X-Gm-Gg: AZuq6aJ04QLWDBnZanDX9ah3BbQZiVttekppvhEV4+Ijpwfi0rf4eUSmZaIg3FnBGPI
	uCni/mNvXk8x3XHn5rkBqQ8p8DKHqdj4PByXzfootNz+fGG+81crjUTMoxBIV66tbE4nk/F+Hul
	xFUdTVJMmZajTOvHGl8qNB8imsj+sJB+rbM7yG9iBrkCbNtRj9u5a4SsFAw2Ip7401qmLJHvWHI
	wFzKvKww6fuPx/O2laV6rzplJkLXQLKRa6U86lniQnwcU2DOS8Eqswba7EkYE4OpOxAUrhf8ne3
	LbCMp+O9AkTpvyEsqVYddas9M/PoXNntGMMq665Jx582ThordArttHRk3hKZUmtiTbxBq+7UgOD
	f6DE9bMoBGkctEyKYdbMqelaaXC5vr2cCSBe7qixCqA2Zp0PIjelikXW2TdCESGBqoq5bMT9hcX
	WibyYyNiyUspHtHkyWX3uOSTBAXoATYKlo0spszc/2K/HCqP+Qvlkp1Q==
X-Received: by 2002:a05:6000:40e1:b0:435:e440:f518 with SMTP id ffacd0b85a97d-4362938c570mr22915261f8f.54.1770716903032;
        Tue, 10 Feb 2026 01:48:23 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-437699bc1cdsm18679000f8f.7.2026.02.10.01.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 01:48:22 -0800 (PST)
Date: Tue, 10 Feb 2026 10:48:19 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Andrei Vagin <avagin@google.com>
Cc: Kees Cook <kees@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Cyrill Gorcunov <gorcunov@gmail.com>, Mike Rapoport <rppt@kernel.org>, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, criu@lists.linux.dev, Chen Ridong <chenridong@huawei.com>, 
	Christian Brauner <brauner@kernel.org>, David Hildenbrand <david@kernel.org>, 
	Eric Biederman <ebiederm@xmission.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Subject: Re: [PATCH 3/4] mm: synchronize saved_auxv access with arg_lock
Message-ID: <ilki5auwqeipwwolu7zgmj2wn2wd5t4saa5mtazn57egz45xbm@j4rl4bufrs2w>
References: <20260209190605.1564597-1-avagin@google.com>
 <20260209190605.1564597-4-avagin@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6mfjdav2fdcypbkr"
Content-Disposition: inline
In-Reply-To: <20260209190605.1564597-4-avagin@google.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76832-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,linux-foundation.org,gmail.com,mihalicyn.com,vger.kernel.org,kvack.org,lists.linux.dev,huawei.com,xmission.com,oracle.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkoutny@suse.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.com:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,suse.com:email,suse.com:dkim]
X-Rspamd-Queue-Id: 4E298119165
X-Rspamd-Action: no action


--6mfjdav2fdcypbkr
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 3/4] mm: synchronize saved_auxv access with arg_lock
MIME-Version: 1.0

On Mon, Feb 09, 2026 at 07:06:04PM +0000, Andrei Vagin <avagin@google.com> =
wrote:
> The mm->saved_auxv array stores the auxiliary vector, which can be
> modified via prctl(PR_SET_MM_AUXV) or prctl(PR_SET_MM_MAP). Previously,
> accesses to saved_auxv were not synchronized. This was a intentional
> trade-off, as the vector was only used to provide information to
> userspace via /proc/PID/auxv or prctl(PR_GET_AUXV), and consistency
> between the auxv values left to userspace.
>=20
> With the introduction of hardware capability (HWCAP) inheritance during
> execve, the kernel now relies on the contents of saved_auxv to configure
> the execution environment of new processes.  An unsynchronized read
> during execve could result in a new process inheriting an inconsistent
> set of capabilities if the parent process updates its auxiliary vector
> concurrently.
>=20
> While it is still not strictly required to guarantee the consistency of
> auxv values on the kernel side, doing so is relatively straightforward.
> This change implements synchronization using arg_lock.

(For the clarification, I didn't consider the lack of synchronization a
blocker after your previous explanation. Nevertheless)

Thanks for explicit sync.

One little nit is a missing hunk like below.


--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1205,11 +1205,10 @@ struct mm_struct {
                spinlock_t arg_lock; /* protect the below fields */

                unsigned long start_code, end_code, start_data, end_data;
                unsigned long start_brk, brk, start_stack;
                unsigned long arg_start, arg_end, env_start, env_end;
-
                unsigned long saved_auxv[AT_VECTOR_SIZE]; /* for /proc/PID/=
auxv */

 #ifdef CONFIG_ARCH_HAS_ELF_CORE_EFLAGS
                /* the ABI-related flags from the ELF header. Used for core=
 dump */
                unsigned long saved_e_flags;



>=20
> Signed-off-by: Andrei Vagin <avagin@google.com>
> ---
>  fs/exec.c      |  8 ++++++--
>  fs/proc/base.c | 12 +++++++++---
>  kernel/fork.c  |  7 ++++++-
>  kernel/sys.c   | 29 ++++++++++++++---------------
>  4 files changed, 35 insertions(+), 21 deletions(-)

I can say
Reviewed-by: Michal Koutn=FD <mkoutny@suse.com>

--6mfjdav2fdcypbkr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaYr+3xsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+Ahy5AD6AjG6/lGRDcame2K5XvP7
OVrWBpsfcwrnZvTHPoeV5UEBAKfBhTRrU7E6giMU6hZF3QDs2zNto4n4tSR+Kbn1
4ecB
=sc7Y
-----END PGP SIGNATURE-----

--6mfjdav2fdcypbkr--

