Return-Path: <linux-fsdevel+bounces-19864-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 072128CA72A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 05:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56C19281CA6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 May 2024 03:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00FAC208B8;
	Tue, 21 May 2024 03:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JdsKkIx6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0492117722
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 May 2024 03:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716263916; cv=none; b=UAXvRazBq760eBtxZHjJrrShcW03gST+h5qMiOpkovbKG5lQEF5ntXeRMRO85TROAGyZ/5EMBKdW+VTG9wcBjWD0el/eTMcEwUg3oWBvvJ7zeEyeX34SkWimr5H6c3ch5ms8QuMpcKbExii8eLNgszcXOLAm3dHQEs0OuPZyFcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716263916; c=relaxed/simple;
	bh=YBMO9ThdY4oBDQDpyZFjfmc9ukJfQ3Ce77GE0efaK5k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FSdu3a8rV7TaRmWEl1AkucDOauvUl/SXQOb05EFw4u4OxOMCXsSvi/VF2EwbhUKVa0Qv3d6Fj5uKEzqAzQyGPMe01XDfuE3mQM7uFDIGL+y4teeKwj6KlfgzQOzuvNLBk7S9e/Jv4VCZ+WSH9RiqULKoTFCzZdgYCWTTXBkqq5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JdsKkIx6; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-4df3f7b93a7so1044485e0c.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 May 2024 20:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716263914; x=1716868714; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YBMO9ThdY4oBDQDpyZFjfmc9ukJfQ3Ce77GE0efaK5k=;
        b=JdsKkIx6aeDUKMuvLHGPk4KrsmCkwCLWbpc5GC4VrFLgi4fYQRvRbmJE2xALr/gBZ3
         V0PiBPBpW5oAUqo2HnkRThW0Yl6PuqCBV7mtmTjCaFJeYPEjVBIPV1EC8tdU1YHWgWjJ
         EwjcCrqla1sNc6mBn1CJ/mSWWjiPIKDYic6prKlX1qrVmy7HNHtzF+fsLkMAxbtiRoxn
         PtptCjU3j/WnOaW/aI8pMobAQtCLEir3MnOyIuLOgZpWN57nrkG/TuWaN4cmggXE8Yui
         FuAfmpg//IACv62xVlpmz9/MgxPe0+EDnrsXq0JhuQrl+xu96qwvxU+4qLDNbR3VKqHR
         weCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716263914; x=1716868714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YBMO9ThdY4oBDQDpyZFjfmc9ukJfQ3Ce77GE0efaK5k=;
        b=ZuvkG6IvqNUQAAYgL6+Vcgfm+yg+BOH58smGO8Cdrieqp6PyM/LSC+xBt5KjZsGJ5W
         m3fJByN8ZzTbRGv3gYjXerV7T5YRGEad1q1LJZ1azvD5kvM0689e4+ByIU8f2xiOJGDt
         Hx+zUkYuyMG+i2+tmwD1G+Ng6CsbI+oTkqKDd6GVKZTTcVSVsjejiYAKTRX4VAGlWu+C
         NKKXFaCLctS5UHTc9qWDTzxadRDa7W7TvqSuk6OQJnbbEuEc1rRoUwEpipgSrc4dE/6F
         y7TGNPluIVqPeiHJr71D5ZGIDsIPWWrZajnAR97AWwiOwTn3yewriM/Ai5ZnRXfh4XXu
         fvbg==
X-Gm-Message-State: AOJu0Yx8Un0xpnH1y1OSDgNCD/m5I7yHM0OsR/0RBD/8RdTakNuhm2ZJ
	shlTwe94leYlY6AJijK2n1Wpm3fCGR8QDYH7PChro0qlTfoO7RTCuRzEC1S2AD+d/KnFPBeAcio
	IxuQVxlR6asxjwI06CqfeOv5N9aorgNNE
X-Google-Smtp-Source: AGHT+IGv8do3kegu7KGiOHjrqdzRhhaL+APY9iyLAXC0/GjdwEOOMe1nYGHyOTv9gwYMlNQt6CxoIN18jh9qnvI+f68=
X-Received: by 2002:a05:6122:3128:b0:4db:1b9d:c70a with SMTP id
 71dfb90a1353d-4df88180aefmr31631346e0c.0.1716263913798; Mon, 20 May 2024
 20:58:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPSOpYs6Axo03bKGP1=zaJ9+f=boHvpmYj2GmQL1M3wUQnkyPw@mail.gmail.com>
In-Reply-To: <CAPSOpYs6Axo03bKGP1=zaJ9+f=boHvpmYj2GmQL1M3wUQnkyPw@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 21 May 2024 06:58:21 +0300
Message-ID: <CAOQ4uxjCaCJKOYrgY31+4=EiEVh3TZS2mAgSkNz746b-2Yh0Lw@mail.gmail.com>
Subject: Re: fanotify and files being moved or deleted
To: Jonathan Gilbert <logic@deltaq.org>
Cc: linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 4:04=E2=80=AFAM Jonathan Gilbert <logic@deltaq.org>=
 wrote:
>
> Hello :-)
>
> I want to use fanotify to construct a best-effort log of changes to
> the filesystem over time. It would be super useful if events like
> FAN_MOVE_SELF and FAN_DELETE_SELF could report the path that the file
> _was_ at just prior to the event. Reporting an FID value is of limited
> use, because even if it still exists, looking up the name (e.g. by
> open_by_handle_at, the way fatrace does) will only reveal the new name
> after a FAN_MOVE_SELF -- and after a FAN_DELETE_SELF, the file no
> longer has any path!
>
> I understand that in terms of a strictly accurate reconstruction of
> changes over time, fanotify events are of limited use, because they
> aren't guaranteed to be ordered and from what I have read it seems it
> is possible for some changes to "slip through" from time to time. But,
> this is not a problem for my use case.
>
> I have no idea what things are available where in the kernel code that
> generates these events, but in the course of writing the code that
> reads the event data that gets sent to an fanotify fd, I was thinking
> that the simplest way to achieve this would be for FAN_MOVE_SELF and
> FAN_DELETE_SELF events to have associated info structures with paths
> in them. FAN_DELETE_SELF could provide an info structure with the path
> that just got unlinked, and FAN_MOVE_SELF could provide two info
> structures, one for the old path and one for the new.
>
> Of course, it is possible that this information isn't currently
> available at the spot where the events are being generated!

This statement is correct for FAN_DELETE_SELF.

>
> But, this would be immensely useful to my use case. Any possibility?
>

FAN_DELETE emitted for every unlink() has the unlinked file name -
a file can have many names (i.e. hardlinks) will almost always come
before the final FAN_DELETE_SELF, which is emitted only when st_nlink
drops to zero.and last file reference is closed.

I say almost always, because moving over a file, can also unlink it,
so either FAN_DELETE or FAN_RENAME should be observed
before FAN_DELETE_SELF and those should be enough for your
purpose.

FAN_MOVE_SELF could in theory have info about source and target
file names, same as FAN_RENAME because it is being generated
within the exact same fsnotify_move() hook, but that's the reason
that FAN_RENAME is enough for your purpose.

FAN_MOVE_SELF intentionally does not carry this information
so that watchers of FAN_MOVE_SELF could get all the move events
merged and get a single move event with the FID after a series of
many renames.

Thanks,
Amir.

