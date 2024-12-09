Return-Path: <linux-fsdevel+bounces-36729-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9923A9E8BFC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 08:18:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FE4F188585B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 07:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B4921481E;
	Mon,  9 Dec 2024 07:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hRBEKbYf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C6622C6E8
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Dec 2024 07:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733728730; cv=none; b=lmOZy2Wsu/fEWX+FW/5VgMDTORti466gvDoTsmODSM/XlQr2o92PvYyRoeynpUvlrteIQK+fxJeIxdMskx4kK2evE2vpJidfAKEFmHVYIX/gHXYiF35EUfGxBxu4yjYjSO8ZR37yBr4mg3tRmwREoomR6/1EzipP8MIyYVjl97E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733728730; c=relaxed/simple;
	bh=uMn3PEHtxa9mb1g4Zrdm+25LLNfT6zaEb6HQxkupA3s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ufa5ed2GmZ5Zip5sxFrGmWdo4Djup4eOwO+0fVp3iBRg2GMO3/4gHm94K0/5cpFReIE06MF5uE/FbzrVjiUkAl/9pqExsc1SNI2tzeiPL29pOmKFzro0LzJlwEdX6dD1awu/V+ni54bYa4JLrhf9to1k6bGfjwMYD0zulwRgMes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hRBEKbYf; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aa5ec8d6f64so469076066b.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 08 Dec 2024 23:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733728728; x=1734333528; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C2AIvHwbByi+O/Bt+ROIrm3G2sCcmKMr1QnxtzfrTOE=;
        b=hRBEKbYfalklAT5rmOBc28dBh7mp6JDRdp01pH4gitI6XXakEH0+VlAcvPNcfsz4U2
         GJ/BTLpYD/pKAdb6bzdyJWqr1tiyhA75UxQcMvgg1Sl80/izXfzvZzBOdDSl/3r7kvUV
         fX/vk1OeIpTMrgto2qC04rFnmKhwe9/7MBYVGJ50f5eU785755DeYKA6v4fEDqRjkGUU
         h9xAAsyBGxEo8hooIyoqKajfS1XRx+UmnYnzDaTcMEv8Ov/iLixD7bGL16l9uaLwSVWq
         58SFtYMSeva3dl0AqsmFZPkXsAcPRQUvMgcd8qyjQqfhf/2NuPwMZ8iNLLkvYmE+yCAv
         Ricg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733728728; x=1734333528;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C2AIvHwbByi+O/Bt+ROIrm3G2sCcmKMr1QnxtzfrTOE=;
        b=si7q4ayKW1Z6HSE24xq8Sal2Jt/nTcvXQ+l7uy18IRkOSG9rWmsAAZugzjqVrb3TEG
         iCl3GOAkgHhlrifqPibJJpkVUx7moBeXRTAJXcKn7aOSmjuiaDiUV/exy1Mvvr5Tk6aV
         FfkSAwzwTTUiSKYWR/wdI+NWpJPoptYuvyHVUV/4/mhgS3s3UWwJAygwMpWlCGVFRh70
         54+ER84dC1/49A8Xf6YNJrC4HglvXAWkejUKgZEKrkis6jPNBMpwWTnBQOnL4qYDE7jP
         ZZDSz9feg4eb3G4/q8k2vPu3FAoxPqz/5a6Bf25gMcXOh02xKaiCKl+saxSoRY6D5RM1
         BBxw==
X-Gm-Message-State: AOJu0YysMldfHB+p9sFwDYVTK5WcpPqjaRfbv5pnzQ0qSidcKhbyX6hV
	pL4SWe9wNEKWam+UhwbUjBsryT1RuljqsgVgsM1XCw5QJdkBNkrf7iFFnThQINoIwCf5GOyDshg
	IslUmQeC8kdeSaai0aBYUBzgpaeg=
X-Gm-Gg: ASbGncteMMRrRwhqN4R6EYEvhCjJQQ8LKtBRVuZn7knrk2Xlxqxpez+kUWKPNoxVC1u
	Uc12j+GS+x/F2BdjG+guqOpTpwROvlRk=
X-Google-Smtp-Source: AGHT+IF60dtPGzyWx+ApyOuAvepkX4II9gRLRX/dEx0KAVLzrSqpevc1qOMbCDIAuUKtGnEfCh419NWbAtVqJEULLUc=
X-Received: by 2002:a05:6402:1913:b0:5d1:1064:326a with SMTP id
 4fb4d7f45d1cf-5d3be69a19amr30598243a12.15.1733728727505; Sun, 08 Dec 2024
 23:18:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241209035251.GV3387508@ZenIV> <gopibqjep5lcxs2zdwdenw4ynd4dd5jyhok7cpxdinu6h6c53n@zalbyoznwzfb>
 <20241209065859.GW3387508@ZenIV>
In-Reply-To: <20241209065859.GW3387508@ZenIV>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Mon, 9 Dec 2024 08:18:35 +0100
Message-ID: <CAGudoHHAxDpQb9TVTPuBc-NnJkuu3hJJ8iB2Z5QRdSCPiVDLRA@mail.gmail.com>
Subject: Re: [PATCH][RFC] make take_dentry_name_snapshot() lockless
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 7:59=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk> wr=
ote:
>
> On Mon, Dec 09, 2024 at 07:33:00AM +0100, Mateusz Guzik wrote:
> > Is there a problem retaining the lock acquire if things fail?
> >
> > As in maybe loop 2-3 times, but eventually take the lock to guarantee f=
orward
> > progress.
> >
> > I don't think there is a *real* workload where this would be a problem,
> > but with core counts seen today one may be able to purposefuly introduc=
e
> > stalls when running this.
>
> By renaming the poor sucker back and forth in a tight loop?  Would be har=
d
> to trigger on anything short of ramfs...
>
> Hell knows - if anything, I was thinking about a variant that would
> *not* loop at all, but take seq as an argument and return whether it
> had been successful.  That could be adapted to build such thing -
> with "pass ->d_seq sampled value (always even) *or* call it with
> the name stabilized in some other way (e.g. ->d_lock, rename_lock or
> ->s_vfs_rename_mutex held) and pass 1 as argument to suppress checks"
> for calling conventions.
>
> The thing is, when its done to a chain of ancestors of some dentry,
> with rename_lock retries around the entire thing, running into ->d_seq
> change pretty much guarantees that you'll need to retry the whole thing
> anyway.

I'm not caught up on the lists, I presume this came up with grabbing
the name on execve?

Indeed a variant which grabs a seq argument would work nice here,
possibly with a dedicated wrapper handling the locking for standalone
consumers.

The VFS layer is rather inconsistent on the locking front -- as in
some places try a seq-protected op once and resort to locking/erroring
out, others keep looping not having forward progress guarantee at
least in principle.

How much of a problem it is nor is not presumably depends on the
particular case. But my point is if the indefinite looping (however
realistic or hypothetical) can be trivially avoided, it should be.

--=20
Mateusz Guzik <mjguzik gmail.com>

