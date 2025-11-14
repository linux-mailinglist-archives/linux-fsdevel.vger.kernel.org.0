Return-Path: <linux-fsdevel+bounces-68481-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E280C5D0C7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 13:16:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 54494357B33
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 12:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC9AE14B950;
	Fri, 14 Nov 2025 12:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SneHrKKF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A8154774
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Nov 2025 12:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763122557; cv=none; b=IG34gKdjyiF19N3mqLKBqGkg2/g5OKfvjC82Sy2azDngMvls8XvMM3DG42BfqjH1lsqO5UCcIDLxAievtI0Kqnpbn2FFU0DP9kYEHuQELKHe/TxSMxlzAlTNNgU3drliJVfuxcgxNoUZL1ozpy79ctVs3kJ2pXmX2kTO+FKdx88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763122557; c=relaxed/simple;
	bh=47PNF5RVuJ3c8BHjRUvOBQJmrdIH6tNxp/wXGr1F1mY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mdyx6ZpKXmzI48QmR+hPo5bx25qxwUT/dGDiY+SHEREaX9zGcizseSjerODXjn2AWEBToe0pS0auNVd4zxC3NmdFMuLjbMaeTayukLhyHdMH3sfFFYHm7/LfHaeShsX7rx4phpLUP4+TVp62jm/J6tDnD58bmcmIi1eG/ThYPYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SneHrKKF; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-640b06fa959so3407268a12.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Nov 2025 04:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763122554; x=1763727354; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S7PXXqBWzJqn3zGwsEpNyZu8WMfzixBgnRapPRgsdvM=;
        b=SneHrKKFVnDueYScYsWsC+x+Eo1saV/U+y0dIYM04JxQ+1XCaHB1m5/KL/EoIbRQc6
         slsTLgqauDk1JqCc9F7NUHGHnvlAlEf8hujjmx9vxveZvG73uy1del5FxWw3v03t/asZ
         3vH/QL0ERlnBhF7NtugZ4jkc7nEJ9HX3gHIZdBI8oMJ76ZZcumRW5W+klcE/2dcDpHOR
         WOTGlDWPRLcnZsnPPH9J5S46CJKyxiRkqjtwp/vChp314BIOEPcCuDc1KPjos83u/ukZ
         mSpszbrz3VXCjVG0X0+cEZA9Lrad6stIqVCZAx9BOSfE1oW1IpRqniG+tqfSeznS3tmI
         DaoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763122554; x=1763727354;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S7PXXqBWzJqn3zGwsEpNyZu8WMfzixBgnRapPRgsdvM=;
        b=PdhDtY869W96OFdCIcnNfSvu4ksww1k+vZJWJCBcC03kxvMa2IERbdy2vOz0p3oPd2
         0/mGjgupdH6y9sSSqIKuGr/zw5VWMtfdtBcJr282wrLIDRTylpBuy0E+GZiQoT+zzdTI
         n8EohCdwlw15D3J2BK7+zSPjV82to72ZECbaKDnn846VTTVcVWQdm5bWfO+ZWnRJ3Sid
         naNC8hSGcHEhmfIVbGovgwK7ZtKWE72+3aXZS0AyEw9Lp3tq7Vm+C+vKh8Ot36avrzGO
         yVJqo1n1tnFZFv0Oqvk3Hw3WzrrfvINnamc/5RH1o+6ZBicJIMl3VE3xcVnY4P74odwu
         sgJg==
X-Forwarded-Encrypted: i=1; AJvYcCXrTpSTqZGQ3RLynW6b39k9QF+SQQjHxm9CVpMas7hPzXgDW7JmyyLYh/6qS13pOkLGSnj5qk80c3yq9AGE@vger.kernel.org
X-Gm-Message-State: AOJu0YzZkTNO1s/QR8gQF5O2/icqRyvYXs7Yy8oa67tEFyp0R3XQX/Jo
	sw5xI5qWEpyyN0gol1ZvbjiWMTESf88OUzrSvBONspE/fbifcsxBh1jlCglPrpSva+xGn9STFbX
	MHAAHRW8tkowuG7/EMMW4Cq60e8k/1J4=
X-Gm-Gg: ASbGncvMWc/hEEG8Je1Uwp/uj2CsO96vSxXLMn5VZ2UXnXXGSBkZYw4tLYhAPmQxE/i
	GBZ8mH1pEziJyz0zWogkxkpaigEX62JpCewz1PCj4ixuDkku4kkXkAvW3e4lQlZwhAKUjY3lFWj
	oMR0NEXZnlKbWOibWcA//Md8S5weMdHQaBcCnAUHnI8Otdygx5KCUSyR06CdIxBnltC8TdpEe8q
	AAXPnGu2L9aqoPFld4//SYnOqA23tbc/2UO2fG96NDpZfCRk47mNs+h3iJT4qoWRtvj8GOyNCn5
	9fcRCOM4e5kydiQxiaB0qqxeFh1L4A==
X-Google-Smtp-Source: AGHT+IGzFauNutjrU2V3aB20Ao5tLDc8f5yniDQzWBbdBv99NzPZX+H4OgBmFD4r8eLpzR3oWyiB94uGg8RieaeaJAM=
X-Received: by 2002:a05:6402:2115:b0:640:ef03:82c9 with SMTP id
 4fb4d7f45d1cf-64350e1fa2cmr2264080a12.11.1763122553522; Fri, 14 Nov 2025
 04:15:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114-work-ovl-cred-guard-prepare-v1-0-4fc1208afa3d@kernel.org>
In-Reply-To: <20251114-work-ovl-cred-guard-prepare-v1-0-4fc1208afa3d@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 14 Nov 2025 13:15:41 +0100
X-Gm-Features: AWmQ_bnStc9yabet7bIV01pOuNjHccizHxm665gq1pv8xM9J20chqME7d-5dp2s
Message-ID: <CAOQ4uxi5OntG9b7d9DZY2cS4xMtXNp7x-gUWespxgubf8UBNJQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] ovl: convert creation credential override to cred guard
To: Christian Brauner <brauner@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 11:15=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
>
> Hey,
>
> This is on top of the overlayfs cleanup guard work I already sent out.
> This cleans up the creation specific credential override.
>
> The current code to override credentials for creation operations is
> pretty difficult to understand as we override the credentials twice:
>
> (1) override with the mounter's credentials
> (2) copy the mounts credentials and override the fs{g,u}id with the inode=
 {u,g}id
>
> And then we elide the revert_creds() because it would be an idempotent
> revert. That elision doesn't buy us anything anymore though because it's
> all reference count less anyway.
>
> The fact that this is done in a function and that the revert is
> happening in the original override makes this a lot to grasp.
>
> By introducing a cleanup guard for the creation case we can make this a
> lot easier to understand and extremely visually prevalent:
>
> with_ovl_creds(dentry->d_sb) {
>         scoped_class(prepare_creds_ovl, cred, dentry, inode, mode) {
>                 if (IS_ERR(cred))
>                         return PTR_ERR(cred);
>
>                 ovl_path_upper(dentry->d_parent, &realparentpath);
>
>                 /* more stuff you want to do */
> }
>
> I think this is a big improvement over what we have now.
>

I agree!

This bonus cleanup looks very good and helps with hairy parts of the
ovl code.

Overall, apart from the reuse of ovl_revert_creds() helper name,
I had only minor comments about suggestions for
CLASS name and helpers, take it or leave it.

Personally, I think I can leave with the minor confusion of the
static do_ovl_ helpers vs. ovl_do_ helpers, so this one is up to Miklos
to stand ground or not.

After rename of ovl_revert_creds(),
Feel free to add to this series as well:
Reviewed-by: Amir Goldstein <amir73il@gmail.com>

This series also passed the ovl sanity tests.

Thanks!
Amir.

