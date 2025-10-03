Return-Path: <linux-fsdevel+bounces-63400-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D559BBB82C5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 03 Oct 2025 23:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 85DB54E9DD4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Oct 2025 21:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D4D25A651;
	Fri,  3 Oct 2025 21:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CKtHKuj/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3173D25B687
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Oct 2025 21:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759525916; cv=none; b=F+WItmn3lsR16qTDmXXCueeIjdiAOC8sztUR5OUvCrJ2OzfgUrPCuPfHqfU4N4WCQfm1QjdBljNSrxde1gsq4AW3laCw3TtuTi3wsLdJSe5l0e6XO18o7Tw2sAKFPA9XGo6tUAFi8Emz+kck9x4wKRo2DqhKFx/mtjt7HGuG3QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759525916; c=relaxed/simple;
	bh=ZarWfiHXGHHB+8+MSp0i9XDvXuhv0vsLNGhp2CdvMMU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FQriZ7qffwwbApCmGjGeX1BPQxTv6wX5+6tH0yhAbc1FiF0FKST66oozS6C+YHaaKmNincyse74efSpgOF+wZr46pE6oiTIyiSz5rDyqxofcneR7o3kOiUE5+h7nFhoQSf+UdR3Os2Un2T3OC1Wd6BkHBbvFuiX76xs3V95xPaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CKtHKuj/; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-27eceb38eb1so27316135ad.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Oct 2025 14:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759525914; x=1760130714; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=idBH2LpwUFgIevwHzdiFY2NPh0U8IEm5opIuykd/Lyg=;
        b=CKtHKuj/srV5fMgPA/8UKXuZ+AH0o9p4JSfYK6byxC8/tN+tJjWv2sbSwcZC4afpaq
         8NsNQPEy6wd9NJHd5DY3UWlGkw1QPY2FRSZ9j2K9QzhZ/BmnTiKA0O5JCg/j55QM8lqL
         4tIcXPl1Yly/KcgS9D5g0RCFklKjijD2IDHrC/SPSkVv5OmM4FdkzSslmdqNBKRpUBwA
         RrL+BAYMi79h/b7++/24/CMfyTRJNhlOeXxaTJF3LK6zzQUqPcNAqC2db6/H0oGTvZDB
         WOPLnBlCcSJUagCFk+fUUIjTs97puhBjDskZ+bG6jEyyjc7GFthqzL5jfeyhIwI/YOhS
         Fdrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759525914; x=1760130714;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=idBH2LpwUFgIevwHzdiFY2NPh0U8IEm5opIuykd/Lyg=;
        b=LHsl0utEcOjFPqPhI7f3J8MAxmwzYxKEB+caIK49+q5s40Ed+gIO/B32oNSR8jNldK
         ar+n6EO1FyqiX0vD5tiZO2/g1on/4QogFF/shEdv9Mg1AjI1VSCcyX+KZtm9PfOmiYA8
         /ZaN4XuK/c3+BV/xgiCzLMgRKY2qI2hVGFwENpQY1Y0PNv7ah2R2ho5txr1mUwA9EQHx
         FNwV6rfJy61aMlPCCorzJlDpEdv3L/w9wcGy5lf/WS2vSDWzrS8wFg1zF2x3LuINvQjk
         XkcD+0M1MuETSd4SQOHjfcgvijfWgJXMFGbaP1WaTdl9RFPeQ7wCa+93LHEtvhkJX5N4
         uVwg==
X-Forwarded-Encrypted: i=1; AJvYcCV5zUlAjznObbBB/rqu3eImj4NO/2x/WQ/Ycwy1JvXjp00DXkatsUQMhwZCwIgSxlKOenGuimqaQ8+EO5F/@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+M/WfbHs+yWaxC76U3JwueCjSV4djFNCCMiGJ9CG4RjugazF1
	2tfuqjElYBltwdRdXGtBZ9LHn0DODaY1SNpYQ6KY+x4akLHxWhmzLI3nePY7aqudpINqBNt0dze
	hkT4LQSb9HvxgP3bKtw/Fx9+QitGSYaU=
X-Gm-Gg: ASbGnctkj8igD59MhbdNJwNyhMJeaehaRG4GLKVeihALppy2MHgF8KqY3ibETDIuLk8
	XYlIhaPCyJwh6gbFq95yKLwC8UkxsVtCbwDZew/gVrZzDtL8OIPWNfXXp8lw1QZbm6EWoNqeAQE
	7gQyaocldPQ4pcuSkUdOHUzoltROBGhZnCB1VTJdxyiKpwWMrqUxo9i90b+UyEaYEmd+6DVwLnC
	swRhl4FEZ5XMy4bSY7mwuBL9f2WHQuq5AchzsZ0aHQDpSzG+TS0sDo2pU0t8NmONmu0/X9Ma/Iw
	gOEHkwza7kC1t3bH
X-Google-Smtp-Source: AGHT+IESj68bldZNCi4hadzfEkfqbbyvi1Q2I7xucoG5vjfeN4926Z6GVHXgpJPrrPd5ZgEQ+C8FE3WQZyqrwWDH5rM=
X-Received: by 2002:a17:903:230a:b0:24c:965a:f94d with SMTP id
 d9443c01a7336-28e9a62016amr51310735ad.46.1759525914501; Fri, 03 Oct 2025
 14:11:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925151140.57548-1-cel@kernel.org> <CAOQ4uxj-d87B+L+WgbFgmBQqdrYzrPStyfOKtVfcQ19bOEV6CQ@mail.gmail.com>
 <87tt0gqa8f.fsf@mailhost.krisman.be> <28ffeb31-beec-4c7a-ad41-696d0fd54afe@kernel.org>
 <87plb3ra1z.fsf@mailhost.krisman.be> <4a31ae5c-ddb2-40ae-ae8d-747479da69e3@kernel.org>
In-Reply-To: <4a31ae5c-ddb2-40ae-ae8d-747479da69e3@kernel.org>
From: ronnie sahlberg <ronniesahlberg@gmail.com>
Date: Sat, 4 Oct 2025 07:11:42 +1000
X-Gm-Features: AS18NWC1ODU0PD3hd2knk4ObBSOEE8H2Tv-wusAALRmCDLFFlJTzSTlYgqVa4x0
Message-ID: <CAN05THRXfkRMNiE36ksR5ULFC38Ru3PX7Tbv2w-m03=NEk+Hqw@mail.gmail.com>
Subject: Re: [RFC PATCH] fs: Plumb case sensitivity bits into statx
To: Chuck Lever <cel@kernel.org>
Cc: Gabriel Krisman Bertazi <gabriel@krisman.be>, Amir Goldstein <amir73il@gmail.com>, 
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	Volker Lendecke <Volker.Lendecke@sernet.de>, CIFS <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 4 Oct 2025 at 07:05, Chuck Lever <cel@kernel.org> wrote:
>
> On 10/3/25 4:43 PM, Gabriel Krisman Bertazi wrote:
> > Chuck Lever <cel@kernel.org> writes:
> >
> >> On 10/3/25 11:24 AM, Gabriel Krisman Bertazi wrote:
>
> >>> Does the protocol care about unicode version?  For userspace, it would
> >>> be very relevant to expose it, as well as other details such as
> >>> decomposition type.
> >>
> >> For the purposes of indicating case sensitivity and preservation, the
> >> NFS protocol does not currently care about unicode version.
> >>
> >> But this is a very flexible proposal right now. Please recommend what
> >> you'd like to see here. I hope I've given enough leeway that a unicode
> >> version could be provided for other API consumers.
> >
> > But also, encoding version information is filesystem-wide, so it would
> > fit statfs.
>
> ext4 appears to have the ability to set the case folding behavior
> on each directory, that's why I started with statx.

I think that is effectively also the case for cifs.
Perhaps not for normal directories but when following DFS links or reparse
points you can traverse between servers/shares that have different
case handling.
So I think statx would make sense here too.

>
>
> --
> Chuck Lever
>

