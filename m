Return-Path: <linux-fsdevel+bounces-37985-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8733C9F9B40
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 21:55:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65A9B1895498
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 20:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FACB2236F8;
	Fri, 20 Dec 2024 20:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b="d1fEg+MQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC0019D8A9
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Dec 2024 20:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734728130; cv=none; b=K9gDJ0RgHdfepYGlLG/VZ6lyV8MPPDsLeKTP+lFSZd+FH26OxBdqtO3eiWS2ZXoRvU2qPzGuL0CXvu+vVPIpUr5e30Rb52JhSW2x4mELwh9PNHf4H0gpHXYEbKnKsz5JSgDRHVxmE4t3zp7oz7cd2ZwCmgId+qHiLMKlrgT5e84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734728130; c=relaxed/simple;
	bh=EaAbbNFvZ+Le2Q+431mtajLrRtmFXGPcrPJLchnEkZ4=;
	h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:
	 In-Reply-To:Cc:To:References; b=D6LnFuxZ/DwJ1GVWtJKemo+TbTR1yIVuwlEkcHNKhUhMPUvt8PgxN1L5G9WOd/Ge3ea74cW1gp4MA5ZDzhxUoAX6+Cwq4qJgc/PnrDzO4AXe7J7XVhas7wVfi3jwhO1MOUVuipcCUIANkeaToSsJjDmdlzJ+rzwVK3J6O/hMg9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b=d1fEg+MQ; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-21661be2c2dso19711135ad.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Dec 2024 12:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1734728128; x=1735332928; darn=vger.kernel.org;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=t8Z3ebZirLTObnPLBSRwuf8YPbB4+CRZ6PwECDAKszs=;
        b=d1fEg+MQGQB7xMFEnoxiSDLBwggqksx7xOcPS0zfuykLq9Al8o+OQLaOpwPw5CQkEm
         qjO4gd+ykyTRWWqd+H/duQGkh1k6EJAHBvh4hBLEfi1oWAI31S9ClKzBlQc7SJyiNgB2
         jOjwLNmZbc5PHdiHR7aDsBaplnwK08Oql6ZmQDJF+2tUewX4V6nb1/606/s0tE03OZC9
         Wx4RzE3DbbJXSS/9PeA0Zvmf2j89MutvHX85iOGSHhnIHp78KBUooQtI1GUj4XLEJ/y6
         LnJ3CasUCycNs+li6/yGd7nc++ki4DBEmb9EU4h5Al+L9kuMItasc7okTxHZ52P0Ntv+
         DoFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734728128; x=1735332928;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t8Z3ebZirLTObnPLBSRwuf8YPbB4+CRZ6PwECDAKszs=;
        b=icw3A/EPwC8JB4TJAvL1xXV7sMqWInl+zZdXQOuy4rhGlSiW2qXgjW3zI4gHQqebBc
         v8g2+7JGvbwTsye13T65slQyygQhKWgToOBT1Ez1OOLTnVgUfQJlrWF3Hs7xu78kppmu
         gz598sjp4+Y+eXzaXV/Rv6W1T6gDpSaP1op8Y6UYqa35kPuYt7TAtBgJu+Uw48q7GvRk
         PWiERa+gjRkrL3aEk4pYOqf7+v14vCRqqbUWCnaDjDFGMtDjyJLcbJTCXXBnsRg7u9Pq
         Uc2RcPpwO+GFlVAsfTWkvOZTKJLRN6mXSkkvBtVozKuqhQmaED25X9OiO85xB6BzaIJg
         V5nQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWVJkCisT6sYhOhVZEdw2eL8s4mZxqJa0HYYr7rKfS99up1kR5F/w7rHZCv/ICIzcXx7bliOtbu3p0BTLs@vger.kernel.org
X-Gm-Message-State: AOJu0YxzbJSzVT8PPTLh3/nigYyAK7YRhoYEeEnKHyn+DWVje5dDFLP/
	Qf19a9VpSA7OMUm2m54Mms9rRxnCQypnfMq7OHfrdQ9OyCz3SnWQagF2m/8IDZ0=
X-Gm-Gg: ASbGnctL7RMnEJYEy3A9R7scBxMU7j+S9JeBQ4Yi57/cvGHl1ADLuoxgxft87OFX042
	KYrZFtlq4K+U1Fm+S6JumjbIbnCnXFtBn/ISuLTWmt41Qo255KAhA8GLi2Jr90gsWF1QK1Uww1n
	WfeYeVX//sq7zQ2Yw3jSMwKLdcVZeDgi94hvtE8/L0RwuLsFvS4co8I3AXNIxyXrLQyD2WziZwX
	DEeT6ExzoRbTnLFhEH4fYa4tkVrwVPvWqSFBb9aC/ksgcorP8pWvK8mirPkN3zIlHxhUgVN3mZb
	VNO4DXJfQ9GYiHn5F4psdNkOMk34Dw==
X-Google-Smtp-Source: AGHT+IEYjyHVHXFwwi8XGFpsvRgybiclYWmOxgxiRAESmfoSL7thjroVD1lP0Nnftv1RpDEt6CAchQ==
X-Received: by 2002:a17:902:c407:b0:216:50c6:6b42 with SMTP id d9443c01a7336-219e6f25ddbmr48836355ad.56.1734728128180;
        Fri, 20 Dec 2024 12:55:28 -0800 (PST)
Received: from cabot.adilger.int (S01068c763f81ca4b.cg.shawcable.net. [70.77.200.158])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dca02b3fsm33142885ad.244.2024.12.20.12.55.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Dec 2024 12:55:27 -0800 (PST)
From: Andreas Dilger <adilger@dilger.ca>
Message-Id: <C36B2823-4392-4831-B9D3-0F3C35ADF188@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_D43D194B-9BDF-4EEE-B3E7-9E2F557226BA";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 00/11 RFC] Allow concurrent changes in a directory
Date: Fri, 20 Dec 2024 13:55:24 -0700
In-Reply-To: <20241220030830.272429-1-neilb@suse.de>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
To: NeilBrown <neilb@suse.de>
References: <20241220030830.272429-1-neilb@suse.de>
X-Mailer: Apple Mail (2.3273)


--Apple-Mail=_D43D194B-9BDF-4EEE-B3E7-9E2F557226BA
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Dec 19, 2024, at 7:54 PM, NeilBrown <neilb@suse.de> wrote:
>=20
> A while ago I posted a patchset with a similar goal as this:
>=20
> =
https://lore.kernel.org/all/166147828344.25420.13834885828450967910.stgit@=
noble.brown/
>=20
> and recieved useful feedback.  Here is a new version.
>=20
> This version is not complete.  It does not change rename and does not
> change any filesystem to make use of the new opportunity for
> parallelism.  I'll work on those once the bases functionality is =
agreed
> on.
>=20
> With this series, instead of a filesystem setting a flag to indiciate
> that parallel updates are support, there are now a new set of inode
> operations with a _shared prefix.  If a directory provides a _shared
> interface it will be used with a shared lock on the inode, else the
> current interface will be used with an exclusive lock.

Hi Neil, thanks for the patch.  One minor nit for the next revision
of the cover letter:

> Another motivation is lustre which
> can use a modified ext4 as the storage backend.  One of the current
> modification is to allow concurrent updates in a directory as lustre =
uses a flat directory structure to store data.

This isn't really correct.  Lustre uses a directory tree for the
namespace, but directories might become very large in some cases
with 1M+ cores working in a single directory (hey, I don't write
the applications, I just need to deal with them).  The servers will
only have 500-2000 threads working on a single directory, but the
fine-grained locking on the servers is definitely a big win.

Being able to have parallel locking on the client VFS side would
also be a win, given that large nodes commonly have 192 or 256
cores/threads today.  We know parallel directory locking will be
a win because mounting the filesystem multiple times on a single
client (which the VFS treats as multiple separate filesystems)
and running a multi-threaded benchmark in each mount in parallel
is considerably faster than running the same number of threads in
a single mountpoint.

Cheers, Andreas






--Apple-Mail=_D43D194B-9BDF-4EEE-B3E7-9E2F557226BA
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmdl2b0ACgkQcqXauRfM
H+Dqfw/+NnRjj0Xl+1PLELzk5pj+Rl7pCy4FN0gyvDkpwoFjVWCDqxmrm+pewJZL
pCHoK2iq5cIUkuK4YUcJh3m4JjmFHETepFebj0eIK3j4F0KYTabiDQlaE5pClxtT
v6apdh65svTkhtU3RLy5IKL/OBZi4NhtBxoxlQAnxa7xZGU74J59PGhLt8I55Kr+
aJro74LWRgBJG/j/u75Dno6BI99aLTVH3EwiA43o+sVurlaDD6TCPmkE+spa5rSh
TWjzYl8FnVvJ/43+5wAv7uJE9lMEJej1DSvLg7fq2BqvbkQzedmUDJZTpWh2bYb2
PM9NkSJpywhDKvmuDc8sRUaDwsXkbPo+i2G7MsfhMo2DQyKP/PBk1TWD/ubmc3B7
FkZeiYX9lEmClWpsKSnjBe+KCr4Y/3eNxzrjFFfQo6znnNN/X/ez/Vu9L1e9Nlgg
Hr0eyLrF50WLU5VR1VBieZ/yhYrpfG3vGnI6bBKQGNYF+WyFE//eGdAI7FAwwSiz
BVtj7hZYtmDnhD2P0ZeKLPD7BilpOIv4KngHBDnw96Lmydq1EcYNLiFagptFCnur
9s2+sZ3RRszkA41vz9dtOEmOMHvpoGc0U/d5ThyXrfJd0zxQxtP79VnUi1zSWJEG
M/WfPf0v49DXtxdqjlXH/9hyaczoF8MCq4oIUtiZKs231FWd5tc=
=5abU
-----END PGP SIGNATURE-----

--Apple-Mail=_D43D194B-9BDF-4EEE-B3E7-9E2F557226BA--

