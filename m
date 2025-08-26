Return-Path: <linux-fsdevel+bounces-59311-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB613B372FC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 21:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 018EE5E86F0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 19:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B38374288;
	Tue, 26 Aug 2025 19:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="lteV9aXZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F0036CC6B
	for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 19:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756236118; cv=none; b=s0bGLI5NPz5ZMJU8YiDkR0/lJIJpzzj/0JTVrtINw14Qwtk0ZDn2cLGLl0cxntewJB9WAb/N26kg6MvBuXWG/nBEF1+q2G6FEQUcL5EmXQJ4D9Da6n0Rj2r8KnJKm8mre36CPodijWDG3HioUScj1TpNdCFicflCE+dpNg33tDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756236118; c=relaxed/simple;
	bh=O/xOZ1mCmstg5G9amJFO/bjVj7YYzqLq0+dX5+gJKDQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g7J6Rp6Kzs6RARVjr5sRC8umJ2DjDwTWD1SUAlrOv8kjkFhthLEMrS9ISQYbA0hXfaAdZJkTKQkVsdPbIVTAwdlSnqeIwAAmH+2ZuBr+DZyMAL/MZPB3NaaaolShTGDgKH0Rqn7rp9nUlFMPtaK6RBZziRM/5D5BxOHsZdbz/FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=lteV9aXZ; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-71d5fb5e34cso2523207b3.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Aug 2025 12:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1756236115; x=1756840915; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=O/xOZ1mCmstg5G9amJFO/bjVj7YYzqLq0+dX5+gJKDQ=;
        b=lteV9aXZEJNLwQKDq3F+x/Ornysqdj7fLNirr1Fz60zngpqU01nh2TXYDY04Zuse7K
         4guTpz9BNoLVbXKjjWUlwILwYF97dL2s3DAp3177K7KrQ3e0nyYE3zT6YVeVGPZfobHG
         cH8PtYqbiO6uYUipniKN/0lU36EfRBlfgcbW+OPg5HIgN09xDBG9+IR/TszI1rAIxPDN
         /g+y33D3Ks4eQzEFQvkU9Dc5b9t/ttMk0Qs2juU1lhUHK0rCnT2RirQFZbb5MXzoNl13
         m1TyBlWen6VKG69zFK5W1ssJTF7tYFJsbeWDiY9rzyL5nDxTkrL+tiSOLIOTBMKKQHUT
         wkOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756236115; x=1756840915;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O/xOZ1mCmstg5G9amJFO/bjVj7YYzqLq0+dX5+gJKDQ=;
        b=KOKxtvlDlxI/RFHGvLeGbDLCcqp6Y/yX8tnqhb6Iu7qBr8JTKGQjN+hg5jdGWLTLfv
         SSRZbcy0VZcOXDCHxT+CtuJQ1p20cAabp4uu6qAVS/gd+gW62txht6Rw1IXbKtx0HL8m
         A877xsFUHVUNC4UGPyIQrMV9Z1EEAeOy5E24jJ1N3XgcI9fe0GJSo0RptkjNbJN9kIjZ
         OEOzSu2k7piHCBOGBlb4OtOOaNImOzQZK5vK1nNxU9fC5WWWrohEcvLSRLhzB3B8cU9t
         IL7yDY5YjQO05cQUZ4+eMDuhOwyiB+JrHJi2oGJB6GqFXshnW8xis4db/7P4pNcCHC9o
         Z59A==
X-Gm-Message-State: AOJu0YwPjTm835WwFH8aAcJSK9iE1vAjeAdhiNSfiPHUiGVsFle7yE2H
	fcc+WBHjsVh7RzihoVCA8IT2WqlRhkuPsNeW3PWElR9X7LcOnOuksEqQe8Qn6K/gXBk=
X-Gm-Gg: ASbGnctvDGiMdHqcWbkqE90/UoI++DmspxsV2B1GbbEdIF64+BJwblETjzaPc1YFA2B
	H/tLbjVeVTCtYZ04Io0WKdvqhPOmKz2TED5X/9eILlo8tCwmgpD8C5+Vozwmgoje10PDX+7HA80
	4NxlTd1qlznBZZjKLt+/KmeIgoRRSoecHGZgHu7XJsglKp1KWWvDfzqUsh3saj8s7+DcI1d9A6y
	wOkDjByj2dQxgcGDHJ9AVfQwEAH6Ed4ydhKsvh6aCeNwSkjrZGZlC8UgTsemBcm8QLyH3Lo/1xm
	nL5wUZZENreeTh79vE4JI0bqCc7r84hEJO0YucC0GM4NGW4Op5ahI9ebKrwzrZ5RxJBoPldK1z6
	Zfe1unv8tPxIbhg9bFGJZUjl8kA28UORzgbDGDcgM26Xc
X-Google-Smtp-Source: AGHT+IEGt5fyMum9z6Tp8AHDWdI9JLgAQ+PXgNd5UK5zN53LynIPY8mGynAejn1itZ32vzBwTOLsAA==
X-Received: by 2002:a05:690c:91:b0:71f:9a36:d330 with SMTP id 00721157ae682-72132cd7b92mr33724947b3.25.1756236114964;
        Tue, 26 Aug 2025 12:21:54 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:d720:a4a3:6b6c:c5b1])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7211217e559sm13084737b3.59.2025.08.26.12.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 12:21:54 -0700 (PDT)
Message-ID: <c9814854f3b91699fd682a93b8379e8690a06d83.camel@dubeyko.com>
Subject: Re: [PATCH RFC 0/4] Discuss to add return value in hfs_bnode_read*
 and hfs_brec_lenoff
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Chenzhi Yang <yang.chenzhi@vivo.com>, glaubitz@physik.fu-berlin.de, 
	frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 26 Aug 2025 12:21:53 -0700
In-Reply-To: <20250826033557.127367-1-yang.chenzhi@vivo.com>
References: <20250826033557.127367-1-yang.chenzhi@vivo.com>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-08-26 at 11:35 +0800, Chenzhi Yang wrote:
> From: Yang Chenzhi <yang.chenzhi@vivo.com>
>=20
> Hello,
>=20
> This patchset addresses two issues:
>=20
> 1. Unchecked offset/length leading to out-of-bounds memory access.=20
> =C2=A0=C2=A0 syzbot has reported such a bug in hfs_bmap_alloc, and
> hfs_bmap_free
> =C2=A0=C2=A0 has a similar potential problem.=C2=A0=20
>=20
> =C2=A0=C2=A0 To mitigate this, I added offset/length validation in
> `hfs_brec_lenoff`.
>=20
> =C2=A0=C2=A0 This ensures callers always receive valid parameters, and in=
 case
> of
> =C2=A0=C2=A0 invalid values, an error code will be returned instead of ri=
sking
> =C2=A0=C2=A0 memory corruption.
>=20
> 2. Use of uninitialized memory due to early return in hfs_bnode_read.
>=20
> =C2=A0=C2=A0 Recent commits have introduced offset/length validation in
> hfs_bnode_read.=20
> =C2=A0=C2=A0 However, when an invalid offset is detected, the function
> currently=20
> =C2=A0=C2=A0 returns early without initializing the provided buffer.
>=20
> =C2=A0=C2=A0 This leads to a scenario where hfs_bnode_read_u16 may call
> be16_to_cpu
> =C2=A0=C2=A0 on uninitialized data.
>=20
> While there could be multiple ways to fix these issues, adding proper
> error return values to the affected functions seems the safest
> solution.
>=20
> However, this approach would require substantial changes across the
> codebase. In this patch, I only modified a small example function to
> illustrate the idea and seek feedback from the community:=20
> Should we move forward with this direction and extend it more
> broadly?
>=20
> In addition, this patch allows xfstests generic/113 to pass, which
> previously failed.
>=20
> Yang Chenzhi (4):
> =C2=A0 hfs: add hfs_off_and_len_is_valid helper
> =C2=A0 hfs: introduce __hfs_bnode_read* to fix KMSAN uninit-value
> =C2=A0 hfs: restruct hfs_bnode_read
> =C2=A0 hfs: restructure hfs_brec_lenoff into a returned-value version
>=20
> =C2=A0fs/hfs/bfind.c | 12 +++----
> =C2=A0fs/hfs/bnode.c | 87 +++++++++++++++++++++++++++++++++++------------=
-
> --
> =C2=A0fs/hfs/brec.c=C2=A0 | 12 +++++--
> =C2=A0fs/hfs/btree.c | 21 +++++++++---
> =C2=A0fs/hfs/btree.h | 22 ++++++++++++-
> =C2=A05 files changed, 115 insertions(+), 39 deletions(-)

Frankly speaking, I don't see the point to split this fix on several
patches. It's really hard to understand the logic and correctness of
the fix in the current state of patchset. Could you please resend the
fix as one patch? It's not the big modification and one patch will be
more easy to review. Also, as far as I can see, patches depend on each
other and one patch will be more safe than the patchset.

Thanks,
Slava.

