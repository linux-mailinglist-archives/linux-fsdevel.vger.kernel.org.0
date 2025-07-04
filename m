Return-Path: <linux-fsdevel+bounces-53977-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E528AF9ACA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 20:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E35A15A3037
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 18:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5A45214A79;
	Fri,  4 Jul 2025 18:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S9vEpLGo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C68213E94
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Jul 2025 18:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751654049; cv=none; b=SBQcd5PCWGHwxuxEVRb8nbhuTvtaPv+lmD99wh5qcBDzRXY6vkY1jPfWPWnEavfxMGxrEY6m0q9pM4pvoJa6RTUdLcT4ovgir0a+cB4wWGNluXfNyARuq3QVG5VR7dIQ6AvPnU+VxS3R1xs4QiZZgNSaDeD9sFYSDeKMiplTXc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751654049; c=relaxed/simple;
	bh=jVN9RXUo6VUVVgL7pwbZUh2pzAUhiUSxq5zm3qodkOs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aztfXGDhLUeUK/uhm1+eN8cwRFpx+jLUokygw0WrkGQTXmEkJ8MMp/nbteFKftX/dn3YoY8rVKqb5z+ki8pnhKTJvWw35LjSRY4mNKEpnBU1a8bwfyfSe47Ap0fUpZS5LS3pVTGNgVUtYM2cGtMiuVy2NhgWN1RT17aGNHLcC4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S9vEpLGo; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e7387d4a336so996326276.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Jul 2025 11:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751654047; x=1752258847; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cPOzFMPRUvzMl8oDkYK01Tjt4jC2hjEzPMy0+YmaTOg=;
        b=S9vEpLGoMZ0hIHRAnwnx/eBVAfOrCiazJ+VBvIsW9U2jWW5ebFYCL+1FZmJSgMw59W
         eDLvhxVkHJpkPlYkdjSxhcmMR73K/onm72pLpF4M4rAe56EEJsqvyoqPBTFbCsqPEadm
         yh3TvqhibcajnEGgh06vtpZJ5s+5kd7oq++UZU/VTBx5zq2aU4n2RspRcDJxiF6xS/Sf
         JWxZ4fC3LM8ZSN/o6gSg+sO+u5u9+bbf73TAfVvKfu6nMIOtahY7UpNJxTMhr13WIjCj
         F5BROOHJI3s6K+eOSwvHvkZuvUIeDN6gYNeKi/gr64r+7khstr+9zwWn1e6UlDADyIk2
         ZduA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751654047; x=1752258847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cPOzFMPRUvzMl8oDkYK01Tjt4jC2hjEzPMy0+YmaTOg=;
        b=JrF4fAMDw7WTREKUlzn8AsapficxX13Kjf856yXM8/nKCWvPL0VFb4bEg6JacaMzCd
         q3NzbQdBkD+7WTfYbmle3D0wIcqPDHqoYa2PrlHPDpIZqNxA8d5V0I9m89z8zraLIaiU
         x/iJuNfBIosZvopBTX3hDaqOTJH+I1ssjsPZcp+nvhxJUtfAGw40lBLLE5KqZ5Ebwd4o
         wcEWvxc6//lcsWSojwEgoNhSOkmFiQIXc2bONNg1/j+HNj4ao6kasDLm2ylePIb7UTFZ
         MEmEiRc7VdLX7QbRBFRCVCrerla5l5e1xJlI6KJ15X8aUkZq0cdkKI2b3qoEpORGgOc3
         C/DQ==
X-Gm-Message-State: AOJu0YxFTCkcS3SYxsVMW/+5Dqznql7EUcg5ALimsghhgZuzqKVrISWA
	ZCNPC894LhIIUTsq/sGlsoobhDC4u7jA6HOAppbAQQ0fMMqTmcpl3GTGLB4vAAEvisfJeUbLbiW
	L9NzdWA8dPrmN0kgZt0EzMwJdI1Om2e4=
X-Gm-Gg: ASbGncuuzASG9BzWCYGBuy9ebZg0WG6xi7NTmJcYF+mlrR37jvWDi1CzMKc5KQK61iM
	Er60uzNCfRaa4YPyHpdWG1muhfpCMp5UymHFIBijxVyDJ0x9GSxOgWvoCNQPZewxz4OnG09dAd/
	GD+SKDHA1xyR2V65TpCFAUhLN2XqTu6Q1/pwn7qJw6cdQ7
X-Google-Smtp-Source: AGHT+IGFtGvSjQTkvO2fwxBaeAO5TKYTsTRv/D1iG9Ds+NC8hLJDF33OOSZV4+P52c0gFgHXn2kZlcGQRLKMT3afNd4=
X-Received: by 2002:a05:6902:490e:b0:e85:1e91:562c with SMTP id
 3f1490d57ef6-e899e4a93bemr4744768276.14.1751654046651; Fri, 04 Jul 2025
 11:34:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702212917.GK3406663@ZenIV> <b3ff59d4-c6c3-4b48-97e3-d32e98c12de7@broadcom.com>
 <CAAmqgVMmgW4PWy289P4a8N0FSZA+cHybNkKbLzFx_qBQtu8ZHA@mail.gmail.com>
 <CABPRKS8+SabBbobxxtY8ZCK7ix_VLVE1do7SpcRQhO3ctTY19Q@mail.gmail.com> <20250704042504.GQ1880847@ZenIV>
In-Reply-To: <20250704042504.GQ1880847@ZenIV>
From: Justin Tee <justintee8345@gmail.com>
Date: Fri, 4 Jul 2025 11:33:09 -0700
X-Gm-Features: Ac12FXz6aqt1bp7DFBQEP0iHAG3RwBJ1z11a6IhDAGw5IqhYGBsTHYE-sLJCTO4
Message-ID: <CABPRKS89iGUC5nih40yc9uRMkkfjZUafAN59WQBzpGC3vK_MkQ@mail.gmail.com>
Subject: Re: [PATCH 11/11] lpfc: don't use file->f_path.dentry for comparisons
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, James Smart <james.smart@broadcom.com>, 
	Justin Tee <justin.tee@broadcom.com>, Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Sure, but I'd rather do that as a followup.
Yeup, that=E2=80=99s fine.

> Speaking of other fun followups
> in the same area: no point storing most of those dentries; debugfs_remove=
()
> takes the entire subtree out, no need to remove them one-by-one and that
> was the only use they were left...  Something along the lines of
> diff below:
Very cool, thanks!  We=E2=80=99ll take that diff too (:

Also, may we actually move this enum declaration to lpfc_debugfs.h
instead of lpfc_debugfs.c?
enum {
        writeGuard =3D 1,
        writeApp,
        writeRef,
        readGuard,
        readApp,
        readRef,
        InjErrLBA,
        InjErrNPortID,
        InjErrWWPN,
};

