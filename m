Return-Path: <linux-fsdevel+bounces-55165-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D51A4B076EA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 15:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B814616CE75
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jul 2025 13:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC3E1BE871;
	Wed, 16 Jul 2025 13:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fQ5iknWv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521F91B983F
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Jul 2025 13:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752672523; cv=none; b=jo1ECg6dFj/jaWIrdGGxizUku5jQj+qo2grU3I/fp87R0TZWqN5fTY77iAz33A+Sr5tVO791NhtMQGI70COFf5xV9vky96ff3dhv1ij0a70uvbwn5gf+lQhO++g0kbqyhrUnVgV0b9kaWPYoFRVHGmKIL6l3Bs8bysCfRI6IJIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752672523; c=relaxed/simple;
	bh=ZvnQZzT/0ERc65pIF5ph5o3wVOBy6yH9acH53bXE+/I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MmxyXKKIKN3yrDFK7uEjTjINePWrB0ZiIyH0Y4evwVVJS321BYh+a0DeaheGDgrczDtyU6aTpaDuFKHQiJWjH8pJ0kxkc/LHJo+gW1ZwukU29kz2R1P6n3oxy78gu+4mw1ZRhfduKzCtUNz0Y6xw4pNzQ/ikoygyy8GSZd33X9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fQ5iknWv; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e8b3cc12dceso4782740276.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Jul 2025 06:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752672521; x=1753277321; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YgYvlMgntF/mXkjZyec0wmh/bim6VIeOCoxNtvZSME4=;
        b=fQ5iknWv35IQWGonZhgQtXjfTlmvzhB5CoVN12cBqjX5dfglb9Af0W5tzYU1Rh4oqL
         SUGsODvvukRudfk662/BYAF3Vu2R304to8O30/fQE7Ovg+SoVSqrOtjwFsizK7oYyu0p
         hYsimyJkYlpm28VEuea4MoVBsSJzDPLjtHmTMxjkO+6ocb9nEvVO2bq4PIgBmZBxGc4U
         WNguVWuhtaTqOfLCMUQUaNBFV0j0r+kYZsXTYILD0i6ySLHzuJ/ZoaSsg/FLbHaMbz5V
         3P4VoHWwpK8Yn9daDL/e2bkOoGvLyELGCrqWksP0lCfc6KvdLs86lqDRk/7ylRgVEpS9
         sk5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752672521; x=1753277321;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YgYvlMgntF/mXkjZyec0wmh/bim6VIeOCoxNtvZSME4=;
        b=QQPdGtlQDMB4pvV1vbL66xXRQDdjtsiKZp1a3qIeejMetOvmdIReZnX21NVFJcmich
         Djio8NoBX4DvfhxzVCECJ3R1ZPRYWGwrjj/PlT6TeAoSloeYpP7WCr6JlP3zUYljI1dX
         RANe4jXCeH+nPmv8Wf0DQfLuUCCOPkI/Fft6OMzvbBeTr3yyFZBcJmVC0uctheIhAh2q
         bwrqGRl9Qy9KsoBAUk41ShjTz93NxgbLUsvToD+kSrX7AeOzKs4zkcZyTS8HEBcofSui
         ipuYg6+hfPHoIA+Hvqo0bfKFx+QS2TpCFxghiRvlamzIQbeRD1+L5cLCYzGkOuEmrw04
         gIcA==
X-Forwarded-Encrypted: i=1; AJvYcCWFxnJAyDdC3zcEgWn+Wj91pGAvDW1CnBa7DYPI6It6oE2fKyX1p/WByjz8DQ2OsTBdeg2XChfTTHwUcqpv@vger.kernel.org
X-Gm-Message-State: AOJu0YzHz6Q+6EYOc5ghdNP3goZTrprRoGTiqQlllopZu5evusMmqqDC
	jtMeRvJt+UbCeDqGyQZ0hWd1DriXE4j5jULj7KrCzwyIwKtBARfKjR/8VPv0vD9diabS7yufkaV
	Bw2w8v4lDyeCJlm7qUgfOf7HLbHZlh3A=
X-Gm-Gg: ASbGncutnZ89y6OY0dfaJ4ckFAVPXDTz/MnEySwQm6dp7LU16Mcj4SVUwqUjaZ4Rd4g
	C2oFrAAYkl0PEdOUahngepJsBUOx4frdNpGvr7I4+WmyNhRa589M+c89O4YY/7cSFKmFaJImFj7
	aoCsNEOdKBO1MZHbMmDwVR/qzEub0b6LFBQ+PNAIw/cR0HxcR3HKO5qfsQ6otCjX//V8JEgfU=
X-Google-Smtp-Source: AGHT+IGwK78wKd/jRQ8fmyIYziWonzdPwhNYbWeY5KEYv3E6krIIrR+65tuNe/zM+rnW781q5VriZMebLr2ZNeGL6FU=
X-Received: by 2002:a05:6902:6905:b0:e8b:c571:cc76 with SMTP id
 3f1490d57ef6-e8bc571cf56mr1570492276.38.1752672520914; Wed, 16 Jul 2025
 06:28:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716125304.1189790-1-alex.fcyrx@gmail.com> <20250716131250.GC2580412@ZenIV>
In-Reply-To: <20250716131250.GC2580412@ZenIV>
From: Alex <alex.fcyrx@gmail.com>
Date: Wed, 16 Jul 2025 21:28:29 +0800
X-Gm-Features: Ac12FXztMNTC3LV9qemKaqoCXN4ZCUYn0s1d7Q1rGCjF2Xg8tzyhtttfF5d64hs
Message-ID: <CAKawSAmp668+zUcaThnnhMtU8hmyTOKifHqxfE02WKYYpWxVHg@mail.gmail.com>
Subject: Re: [PATCH] fs: Remove obsolete logic in i_size_read/write
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: brauner@kernel.org, jack@suse.cz, torvalds@linux-foundation.org, 
	paulmck@kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 9:12=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> On Wed, Jul 16, 2025 at 08:53:04PM +0800, Alex wrote:
> > The logic is used to protect load/store tearing on 32 bit platforms,
> > for example, after i_size_read returned, there is no guarantee that
> > inode->size won't be changed. Therefore, READ/WRITE_ONCE suffice, which
> > is already implied by smp_load_acquire/smp_store_release.
>
> Sorry, what?  The problem is not a _later_ change, it's getting the
> upper and lower 32bit halves from different values.
>
> Before: position is 0xffffffff
> After: position is 0x100000000
> The value that might be returned by your variant: 0x1ffffffff.

I mean the sequence lock here is used to only avoid load/store tearing,
smp_load_acquire/smp_store_release already protects that.

