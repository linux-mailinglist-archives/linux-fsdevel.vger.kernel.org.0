Return-Path: <linux-fsdevel+bounces-8375-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8506835808
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Jan 2024 23:06:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE54D1C20CC0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Jan 2024 22:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1274438DF6;
	Sun, 21 Jan 2024 22:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GnUqPOHA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D479E383B9
	for <linux-fsdevel@vger.kernel.org>; Sun, 21 Jan 2024 22:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705874776; cv=none; b=YA7WsdclWOnQb2orVGC/KM74AnnqWyHDL/IjmultQo1teUcltBo0ks1paHyOVxVs0vg2OtHok8dHiTCQxEn6YjS11J0HaKLQque+j/Ylvp7OMZJ+M6Trc8tTaHfwQ+kRMYK44rB9SwuL6n0qo8UZqrrPrw/342cu9UbMFATp818=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705874776; c=relaxed/simple;
	bh=eKWkdKMEDARbLDRUqfnzbi3sl/rOE8242LOsXnrFZJ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kcD0xb1fANdZxDX5DpIkgYFCMcq2PaOjQ2Bce95PIY9EwsssDd0zP6knxtGXLa1F76DUeDubEd/Fv4QV/kqiNP/sqPr5bCWQVYZYOl0aOhnwiH7om0QkPWtG0cmSYUE9KirrvbfXD+2cX94TjzJP6OHOwmCRGahLnwvP9qQWDfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=GnUqPOHA; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-55a50649ff6so2623125a12.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 21 Jan 2024 14:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1705874772; x=1706479572; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QlVOU0qgbHsfmWmBhtAfMlGMpRk/E6kiXNX1BeiPg/E=;
        b=GnUqPOHACOv4PYToAApEQmo36jT+KsCI++EXCNa7Ki9UF8Ww/dpcOFMpcu2Yv5jhTj
         yoFIKH+UxChATRuCgiX1FFeMSxEoDxNh56tqfH4X176HSyQOhZaZ9uDvkmS+oINfwMb3
         En3gIaOBDci0BdUHoaEzTA1J+OfSnDd/FUPIM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705874772; x=1706479572;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QlVOU0qgbHsfmWmBhtAfMlGMpRk/E6kiXNX1BeiPg/E=;
        b=daqTmkmYWTsXPAjIe7YYnBmG5a5ZhS4PkW5n9SbUPzwE3rapVciqS/lgGYOhy2abf6
         Efkry0H/f4CYyYHNWQEMGYlSQE/H/kynYcDRbxaEsSU9Np2s9qWeZyptGFOmn+HHoiO4
         vIWvBukskC9apNirw4COfpppVkXhSb9PLnWDVPUPWLvCQye6ht8Wij39ZgLxK8ljg+uc
         9fMkANp9wz0o6T8Ta2q0hRsC4oxFfyexSRT2/wqU7/A+TeRx7ciZFTLa4kChp7ca1Jgp
         F8Aep3IaCgwU1cNcbcPihGfeoQO3kJyNJoRuq5X/JcrfKTiriLgWCBl1qF5g2H0v26pj
         /Xuw==
X-Gm-Message-State: AOJu0Yy2i9axmv+hLGYBN5GfskD7omy1iurmWeVWYhITkMtvA7vfiSlL
	4cnqlflHO7ObP9/jHQ80B6e14Z2QYKTUdvMPcbtn6BXSo+jPfA59b/pjLIgKD29WyRS9bAJomxU
	PjGZJMA==
X-Google-Smtp-Source: AGHT+IGQc0TN1RbSohMrzC6uNu5UlDm9dKEM51nf1KAk/woPJJI7sGE4rzgZMhz60+nr9dJ1eu2YTw==
X-Received: by 2002:a05:6402:268b:b0:55c:3468:743a with SMTP id w11-20020a056402268b00b0055c3468743amr465166edd.21.1705874772624;
        Sun, 21 Jan 2024 14:06:12 -0800 (PST)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id i16-20020aa7c9d0000000b005582b9d551csm13524734edt.30.2024.01.21.14.06.12
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Jan 2024 14:06:12 -0800 (PST)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-55a50649ff6so2623114a12.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 21 Jan 2024 14:06:12 -0800 (PST)
X-Received: by 2002:a05:6402:1a2f:b0:55a:6d67:6319 with SMTP id
 be15-20020a0564021a2f00b0055a6d676319mr1539223edb.54.1705874771698; Sun, 21
 Jan 2024 14:06:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a34bqdrz33jw26a5px4ul3eid5zudgaxavc2xqoftk2tywgi5w@ghgoiavnkhtd>
In-Reply-To: <a34bqdrz33jw26a5px4ul3eid5zudgaxavc2xqoftk2tywgi5w@ghgoiavnkhtd>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 21 Jan 2024 14:05:55 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjKjvytH19t2mMHZbkY2bpGurGbG4Tb7xmTjfzA71Lb7g@mail.gmail.com>
Message-ID: <CAHk-=wjKjvytH19t2mMHZbkY2bpGurGbG4Tb7xmTjfzA71Lb7g@mail.gmail.com>
Subject: Re: [GIT PULL] More bcachefs updates for 6.8-rc1
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 21 Jan 2024 at 13:35, Kent Overstreet <kent.overstreet@linux.dev> wrote:
>
> Hi Linus, another small bcachefs pull. Some fixes, Some refactoring,
> some minor features.

I'm taking this, but only because bcachefs is new.

You need to be aware that the merge window is for *merging*. Not for
new development.

And almost all of the code here is new development.

What you send during the merge window is stuff that should all have
been ready *before* the merge window opened, not whatever random
changes you made during it.

Now, fixes happen any time, but for that argument to work they need to
be real fixes. Not "reorganize the code to make things easier to fix"
with the fix being something small on top of a big change.

                Linus

