Return-Path: <linux-fsdevel+bounces-32026-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC8E99F5E6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 20:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A221BB21A2D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2024 18:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 166812036FA;
	Tue, 15 Oct 2024 18:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OE61ANTZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD072036E2;
	Tue, 15 Oct 2024 18:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729017788; cv=none; b=Y9uI0Bz3n8XAUHi3XTBfwtQf0Yf8Hx6YwW0UtCA5BZ2AMSijl53Mv3PVAN+fOb0tLPvRm+Zp/f5wzHeuaiQHVcUtpLGuovfiGZ5FR+Zds3avjaMFbuk61pWx+KpQXCc+8nrwVdnR3WZJR9YCJ8nTSTI87XmqzO35HQUra0drkm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729017788; c=relaxed/simple;
	bh=FCb+vDpm2kLOi1lFsKziF5MTxBvamRlSSp6TQjZHsck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VqlUp/G6BEAe8UgPZERQi9kiiGfkyiwIuDm8A/D5B7+BGOY/uAWZR16Dc8Hd0m0i6+qHTUFKOqK28R4G1ZyJMysJgqmmmvGlDl2qgt0WmOxfGj8vNu6pcS+4wm/6Qd3RNXuPof6P61mrn3hG4iITl6d18J9bqLH51zRwOQw8bG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OE61ANTZ; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c93109d09aso1109273a12.3;
        Tue, 15 Oct 2024 11:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729017785; x=1729622585; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FCb+vDpm2kLOi1lFsKziF5MTxBvamRlSSp6TQjZHsck=;
        b=OE61ANTZMdjdeAmb5sYcfxXSt20UiOu6d+uXlVNk7WLfh6ADbPyB7rFrjnMJ2o3CUY
         j6pkjqzDP1o/FH9epKToxz2BJzVItW7H4aqfB/048liw4ZvgLjcPCcdD2OuftcK21+Ry
         XFeSG0MPwLhWtjXjtVz+iGCCz1UL7hI0ntaSkCg1crwLPVDUbBBqr519AlGw39sMb2B8
         FU9A/pYLt3LT1xD0UY6u4cYSX/WDx94NzggMxe5MonR1hssRwuKpkPu1L9wvr2yCVoJz
         icF99JmZ0HgIy4ZgIhUnVxr4jU0vKwoIHVI1lGBH/lSkx1xopp4egpTlKMVyOdGwmVN2
         tLHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729017785; x=1729622585;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FCb+vDpm2kLOi1lFsKziF5MTxBvamRlSSp6TQjZHsck=;
        b=vI9wHN8QiUmV3fghoLU5S/jrRXYCXCXq+2kgiCknlwpy2jF92lnSANASXmurFvf1vQ
         muXA9RTTpEWOLvsjHsW7Mswk18aV08tB6McpQc7D7IX7y4fYXvVrc2CPYcynBqV7AEES
         zWA3fvYumvC0n8grUbOgzjwup+2BS7mi285lkrwN1z8AKAnNVn1Q3Iajc7/bJ5bHhTzs
         WwFSRexlnAm6jGPjUy0EGnMdeJRdhN9jRjPPBxFRqi1iLP8mvwP2qTM+4mMlV9GvhMzS
         9733yHJZEXoRidJWRfyTVSXueMFDpKBWF26wc+S16MjMmrMORcgonGwl+ASC9HybJ5iz
         IZlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVt/Ky1Ai7ss0qVnAMZ5bBzCCt0XvhYwlQ7hvpk4KKAY+7rCB0Qyyv1xvFyggUcncNkMthlZHC5wPTPL1bi@vger.kernel.org, AJvYcCWcB9sQIvl+11mJoW1pKB27ia5nmLqIice+MGTEsPZXCSo5whb2clxGbt6UT1qQaeLqli3YjhEITcjM19DF@vger.kernel.org
X-Gm-Message-State: AOJu0YzyHG4/Gop9dDzdptdh/Kz2paIRAn8fbcGyReiPJfIVFmikl0GW
	I9+vqoa3A0/Um8MrjU7oBWs0sZjmEVsurg5evb1hRhxfoMGh3pD5pG+BsaBxfcBM8OccWEBwVlU
	ItaCz7Y53r4pZcSxiaAuzAFdirAP+RGeuxMY=
X-Google-Smtp-Source: AGHT+IFlZHN4OSyJH/1ivNZH7k2p86ZBF7nga3pwyOK63avAuNAFc/E1Vsv0UbIHRy/HQ5AXpbkplJyqQygMaJXBr9o=
X-Received: by 2002:a05:6402:40ca:b0:5c9:4499:2810 with SMTP id
 4fb4d7f45d1cf-5c997d3b63emr25889a12.5.1729017784966; Tue, 15 Oct 2024
 11:43:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJg=8jykEwNO-fsyWFayF7f+ZNd86ZN2fm6DD+tQox7+4oSXSw@mail.gmail.com>
 <CAJg=8jz6BSMAGfoVYSEPVD8XMf86niJ-tr=v-P98SOebwHwpQg@mail.gmail.com>
In-Reply-To: <CAJg=8jz6BSMAGfoVYSEPVD8XMf86niJ-tr=v-P98SOebwHwpQg@mail.gmail.com>
From: Marius Fleischer <fleischermarius@gmail.com>
Date: Tue, 15 Oct 2024 11:42:54 -0700
Message-ID: <CAJg=8jy0hD=Emj-Ya3Xsw8SVnnAAx0ZpyC=gg67i1p_G=fHpjQ@mail.gmail.com>
Subject: Re: WARNING in __brelse
To: Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jan Kara <jack@suse.com>
Cc: harrisonmichaelgreen@gmail.com, syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hi,

Hope you are doing well!

Quick update from our side: The reproducers from the previous email
still trigger the WARNING on v5.15 (commit hash
3a5928702e7120f83f703fd566082bfb59f1a57e). Happy to also test on
other kernel versions if that helps.

Please let us know if there is any other helpful information we can provide.

Wishing you a nice day!

Best,
Marius

On Tue, 11 Jun 2024 at 12:07, Marius Fleischer
<fleischermarius@gmail.com> wrote:
>
> Hi,
>
> Please excuse us for forgetting to attach the following information to
> the previous email.
>
> This bug seems to be related to a bug previously found by syzbot
> (https://syzkaller.appspot.com/bug?extid=7902cd7684bc35306224)
> and fixed (https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c791730f2554a9ebb8f18df9368dc27d4ebc38c2).
> The fixing commit is present in the kernel version that we analyzed,
> yet the reproducer is still able to trigger the bug.
>
> I hope this information helps in further debugging this issue!
>
> Best,
> Marius

