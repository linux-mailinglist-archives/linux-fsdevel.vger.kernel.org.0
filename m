Return-Path: <linux-fsdevel+bounces-55094-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0492CB06E83
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 09:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D9F51A639E2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 07:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676A3289E36;
	Wed, 16 Jul 2025 07:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PSDuLyle"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150F010A1E;
	Wed, 16 Jul 2025 07:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752649818; cv=none; b=bcQ7lhgOjznxkK9jZsR9aOH+jQgdnmgpMd7szNOImmuqkWlSvd84+cAZiNV4OpA1XWnw54X2m+y8wrgKg/HEVNlVu9FpmO/li3QRyiEXXP3k6LnAs5vEy33Qh5NuPjwkydtHc8aKeAWU++nCyAw43w1CxQHA2vbR4p64YnCEnNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752649818; c=relaxed/simple;
	bh=L0IWw+pObimsgQhEdfzdod00M4PKS+joumWM9k+rX+k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WdVgyK3HRKBcMx46OIXqfmzER2BJc19oMJf/i1ZgYxJp7y+PXSt5MAGfZ+MbeNI+p5z1Tk7sQl6Cm+GthkIquxSMJ6oDJDX/Vk+AMVOC2PaMcg6edFs8/R+MKKjv+uJXK0Dx5xdj9ZTeX8rXXFy7Ca6qjQ7+oWOmyvJD6JtKPB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PSDuLyle; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ae36dc91dc7so1087439966b.2;
        Wed, 16 Jul 2025 00:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752649815; x=1753254615; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I8Hk7abczwVBNJp+GlOJDMvFnGYvrJy6GF0QC+CWzyk=;
        b=PSDuLyle6EYfFptdZsDvaHnJQsNlZLLk9MwBTYXrF1568yiEPlS39rBCF5EFXx+36d
         Z3mJdeTq7bjbCzDj+IBZrr8rxerHTHFNskSwx9zyJttclH0PvxapK+fr68Khf7q/hwhV
         wIyrjGVY3SY0hwROzQwiK98hfCI39UwqqFXkUDlIWJ/JbQHGe/FZacmTYRyOeWfCQwLl
         S07neGTEDeGMze77oA54Ilhf2PlKJ9Rw19jRGnUSjgGQXmyz3xZr0A9NId09zU5Ox9ER
         1MoxBUEaWBI5jAERLMSqdlGVIYlLlp8pcIXgwgn7IVRISG1VGf+LLz2b3+/irUetjKD6
         eX9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752649815; x=1753254615;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I8Hk7abczwVBNJp+GlOJDMvFnGYvrJy6GF0QC+CWzyk=;
        b=dufrZli3ujL1JcY/J3j/qPwOK0oUj9fxtYoiiSeUufZ+Zu+C9JBaMLWPnBqa5eGAuB
         ECy80zHdtCUJe8Rynl88mHD9OEbe3jk7hxK71B8FF1gytlo03Apf4gYqjQfxDT7xtHq4
         c/F34BH4tmI0l0+1Z9MENFTolIbWpQsbb78ceiizZq8JWvcA1EehO3XR9SMxKfqO8BD8
         53dqY8HB1iuiiQyHJk5re/vznMpEAFccda+U/81ony3d9VJyeTXJvPnb5vpQGSNa3bhX
         UtbT07lSMTy/8XTVj3Je8zYOgVH2SYt2QXwjZVuSg88UO6sCu5sGPxZvbfM5QQOyxtwu
         ekqw==
X-Forwarded-Encrypted: i=1; AJvYcCWq8szF0loWQoCI18+9AlC49hN3LExikXA3mlYN6E0ZQDcRLMgQQZYuP87untWnPQpHryCaQqPllhMzsA0O@vger.kernel.org, AJvYcCXEBd4fK2X6bVtfJomSe91pjoy1WZWSf20zBVBq+yEOuUa1Gy3iGhM/xe9yj6e67gF/HeMR0jHimdtpgLk5gg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwdGlShqzNvx8jgppOFbGDPFhrXJ3ypYng7maelBXuO85a0d1sy
	GCWWReCWEYeFtoxBWW2AFSMKUJOcB2rP6Bxas+epO3+ScIFlYCzA8Kf+OZr0awNrRtDbaHC/diR
	gNFp94TqwxnFQn633ehfGI2G0wVa/cZI=
X-Gm-Gg: ASbGnctHX4sJe09S/BDY0wiMMAyJSfsJGsLuOn2ML0JXMFlOzhZFWoY2fHcoXnYvJ7I
	SnJrfHEDb0tjBevJ6Aclt2mUdE35vOKKC1IAW64PShNVKjT+rB2h+BCFCprepqMaw39mHlEJz1F
	R0b7Si3Lc3kcVwWIU0DEe6IPREw4Y0jOTlaku5k0LeGTyvSjO5Nta1NYXpKybixr17dvnzwl7io
	w9bl3sXyfHwfDSyHg==
X-Google-Smtp-Source: AGHT+IHP3sra+kcFLpfN6MZlMPxSKC5HRI4eNf5+L7GSolXybrUhWL85fL5aY+uy5O26NuAl71Os6biMKnoH1tO1iac=
X-Received: by 2002:a17:907:1b29:b0:ae0:b847:438 with SMTP id
 a640c23a62f3a-ae9cddfe60amr127164166b.21.1752649814681; Wed, 16 Jul 2025
 00:10:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716004725.1206467-1-neil@brown.name>
In-Reply-To: <20250716004725.1206467-1-neil@brown.name>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 16 Jul 2025 09:10:03 +0200
X-Gm-Features: Ac12FXx6W0u1ta4J2Dy_tlFCgqUH8ZDUY_A61ZRNlkgoG7slzam8Ej488s0nzF0
Message-ID: <CAOQ4uxhyaJnqPvwpVyonb1QLpyFaeRYr1bUZQkCvN882v4vCaQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/21] ovl: narrow regions protected by i_rw_sem
To: NeilBrown <neil@brown.name>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 2:47=E2=80=AFAM NeilBrown <neil@brown.name> wrote:
>
> More excellent review feedback - more patches :-)
>
> I've chosen to use ovl_parent_lock() here as a temporary and leave the
> debate over naming for the VFS version of the function until all the new
> names are introduced later.

Perfect.

Please push v3 patches to branch pdirops, or to a clean branch
based on vfs-6.17.file, so I can test them.

Thanks,
Amir.


>
>
> Original description:
>
> This series of patches for overlayfs is primarily focussed on preparing
> for some proposed changes to directory locking.  In the new scheme we
> will lock individual dentries in a directory rather than the whole
> directory.
>
> ovl currently will sometimes lock a directory on the upper filesystem
> and do a few different things while holding the lock.  This is
> incompatible with the new scheme.
>
> This series narrows the region of code protected by the directory lock,
> taking it multiple times when necessary.  This theoretically open up the
> possibilty of other changes happening on the upper filesytem between the
> unlock and the lock.  To some extent the patches guard against that by
> checking the dentries still have the expect parent after retaking the
> lock.  In general, I think ovl would have trouble if upperfs were being
> changed independantly, and I don't think the changes here increase the
> problem in any important way.
>
> After this series (with any needed changes) lands I will resubmit my
> change to vfs_rmdir() behaviour to have it drop the lock on error.  ovl
> will be much better positioned to handle that change.  It will come with
> the new "lookup_and_lock" API that I am proposing.
>
> Thanks,
> NeilBrown
>
>  [PATCH v3 01/21] ovl: simplify an error path in ovl_copy_up_workdir()
>  [PATCH v3 02/21] ovl: change ovl_create_index() to take dir locks
>  [PATCH v3 03/21] ovl: Call ovl_create_temp() without lock held.
>  [PATCH v3 04/21] ovl: narrow the locked region in
>  [PATCH v3 05/21] ovl: narrow locking in ovl_create_upper()
>  [PATCH v3 06/21] ovl: narrow locking in ovl_clear_empty()
>  [PATCH v3 07/21] ovl: narrow locking in ovl_create_over_whiteout()
>  [PATCH v3 08/21] ovl: simplify gotos in ovl_rename()
>  [PATCH v3 09/21] ovl: narrow locking in ovl_rename()
>  [PATCH v3 10/21] ovl: narrow locking in ovl_cleanup_whiteouts()
>  [PATCH v3 11/21] ovl: narrow locking in ovl_cleanup_index()
>  [PATCH v3 12/21] ovl: narrow locking in ovl_workdir_create()
>  [PATCH v3 13/21] ovl: narrow locking in ovl_indexdir_cleanup()
>  [PATCH v3 14/21] ovl: narrow locking in ovl_workdir_cleanup_recurse()
>  [PATCH v3 15/21] ovl: change ovl_workdir_cleanup() to take dir lock
>  [PATCH v3 16/21] ovl: narrow locking on ovl_remove_and_whiteout()
>  [PATCH v3 17/21] ovl: change ovl_cleanup_and_whiteout() to take
>  [PATCH v3 18/21] ovl: narrow locking in ovl_whiteout()
>  [PATCH v3 19/21] ovl: narrow locking in ovl_check_rename_whiteout()
>  [PATCH v3 20/21] ovl: change ovl_create_real() to receive dentry
>  [PATCH v3 21/21] ovl: rename ovl_cleanup_unlocked() to ovl_cleanup()

