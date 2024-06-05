Return-Path: <linux-fsdevel+bounces-21049-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CEC08FD169
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 17:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E6AD1C2142C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2024 15:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBCD63D548;
	Wed,  5 Jun 2024 15:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bwPGMecg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05C419D891;
	Wed,  5 Jun 2024 15:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717600239; cv=none; b=NbbUaAU22kMjHA2hOiTUP33viqSWK4UauTj1t8AFbWk436JWsaR5nddG+ub2NOBvZq160Lz7uxBDKeKNwlyZI3glsN6g6A+FH3KLxSWWdu9KXpkfwGxUHeNtrGo9q5BasfkEG/+LY8q89HyprTtVyfd7AjnfmtEvI56hUmbmmPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717600239; c=relaxed/simple;
	bh=SiSRiLqVQvkgjbroyhbLKTPsZvrrL6hgIXaNmPPH5Hc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L6FqSUQh8iBknU/3oIuRieY6UoNPVkGL7Wpwi6bstwcuUU0z2Vu7d8+ir1fZd9p0GnzhK/DzcDTEeeb8LFAcj74TLNcgi11I2M/DRXvzWXqJEHKBrh+aqEh/dROwtpMU9uK4WtxlmGt+Vj2+KijdIDzsPbrRfmXRGXwKZDik+PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bwPGMecg; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-57a31d63b6bso3280881a12.0;
        Wed, 05 Jun 2024 08:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717600236; x=1718205036; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SiSRiLqVQvkgjbroyhbLKTPsZvrrL6hgIXaNmPPH5Hc=;
        b=bwPGMecgqov+HbunlNCZf5WZWYiDwfsYJtC9UyUDeXTf/GbSY+epnZ/zP1ZvebpM/j
         T0h65xiRNSqczRHE6lNsrj3gFTu4XAD8zF/pXTbB7/G7UGAHPmW11izTIIMxrPJVF/Oe
         ZMTKPaubNICp9gQrjI59Pff0+Tm6b1U+AMjYVORTtiMvokyejX3ClwyrpcG/myzEDhi6
         C0laUD8resYIuHtx375GfjAchndfsiFlV/4O4pXl2d57oLPQWm3L/Re3t27ERLkYroQU
         7Tqrgjf5XMstMGqRO7hCmKGNclRMQdJxASmcgMKBORJT67K5gKn8waeNfMmYakx+tORZ
         +6uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717600236; x=1718205036;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SiSRiLqVQvkgjbroyhbLKTPsZvrrL6hgIXaNmPPH5Hc=;
        b=nuTNnoiq4gGQs5QknXUopueR28d0yHtFU8u1PKi4Ixg+AP0FX8sER00ETo9jh9rjgE
         iPwNyg5OUazWI/FaV9FtqW8LMWojFr2WATb0BqqJFcVsyj0VbNszo3Qojt8t8Yg59Xm1
         V1BgGZLvtm5SIX3KiIjsZLteKAir+knENqdOIodmGE8uvdMFxRdbp1eGxTDFj8KF4fy4
         mUjaRjom0Rwde+5bzUhZLavfnUSJMtMHUqcZi/m1izSyy8zteKp/DDRl5WwLqcWNA+0L
         7znTdDh+Fg/s8ZevJotl1Wl6tkyNy8zzBdWb5hNL15WyNoZRRDaZNEcwn4VT+Z1fAHH+
         ibHg==
X-Forwarded-Encrypted: i=1; AJvYcCWlGAM2w3hKf6syL0wgELFnCxB7ONNnRlwozoXSSs/5r9kJKuTwatvBPaqCakqWNPIqk8LPPgkuBfm3ZakzUl01WlQNfTe85hld44qrykF7ayWNOyecAGjkxQZcxkN+j5oo8rlcnuMKRnKiVw==
X-Gm-Message-State: AOJu0Yx9HWvxKKd8zy/MjkfLtlTWjMGiPiHVVXE7phJPaPgjnryQaLYJ
	N/n5PDLsiGxzEqOo0P13csaLZQ+qm464ZWJb5EvbN3lXVSK/b/aiOKeuGCzVaiWJRB82B9jIJNc
	nSqkH17okulkzgvcLZdcLqD1tnGU=
X-Google-Smtp-Source: AGHT+IGRImTrlF9tKlBBgLVkRuBVevowWXm72ttizbamHPcLJEzMxuXdmC7xfDoNWP+ZeKqDN+efam3m0IuhieyYeuo=
X-Received: by 2002:a50:9548:0:b0:57a:31eb:83da with SMTP id
 4fb4d7f45d1cf-57a8b7c6240mr1913836a12.30.1717600235863; Wed, 05 Jun 2024
 08:10:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240604155257.109500-1-mjguzik@gmail.com> <20240604155257.109500-4-mjguzik@gmail.com>
 <20240605-sonnabend-busbahnhof-3f93ffcac846@brauner>
In-Reply-To: <20240605-sonnabend-busbahnhof-3f93ffcac846@brauner>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 5 Jun 2024 17:10:23 +0200
Message-ID: <CAGudoHG-YVNui5NW7hx8dXJiYaM_L5_uMQB2bmwRVkOg03NKFw@mail.gmail.com>
Subject: Re: [PATCH 3/3] vfs: shave a branch in getname_flags
To: Christian Brauner <brauner@kernel.org>
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 5, 2024 at 5:03=E2=80=AFPM Christian Brauner <brauner@kernel.or=
g> wrote:
>
> On Tue, Jun 04, 2024 at 05:52:57PM +0200, Mateusz Guzik wrote:
> > Check for an error while copying and no path in one branch.
>
> Fine to move that check up but we need to redo it after we recopied.
> It's extremely unlikely but the contents could've changed iirc. I can
> fix that up though.

Oh I see, you mean the buffer might have initially been too big so it
landed in the zmalloc fallback, but by that time userspace might have
played games and slapped a NUL char in there.

Fair, but also trivial to fix up, so I would appreciate if you sorted
it out, especially since you offered :)

--=20
Mateusz Guzik <mjguzik gmail.com>

