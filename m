Return-Path: <linux-fsdevel+bounces-42445-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E02A42709
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 16:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 959C816E4F8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 15:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17912221F00;
	Mon, 24 Feb 2025 15:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="O8Jw2vA0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAC619C54F
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 15:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740412417; cv=none; b=LMiPWhOGGq19ezSKPXZqPKiBbyi+FBJ7bjT2eU2f+O+LRYyVVdgeZAnmCI57Eorac1XwQdfWUOSW3C7B+uUJQu3/mKOs0kBtGDBkwKe+bnq2vdM7TWWi0KAxvvphL02cGBuYZT5Kk4TfqgxLsdcCDwH16hjnXa+ERkR+vXEaGaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740412417; c=relaxed/simple;
	bh=I7jnrlX/Ldw+GklquSutNmiAocpVckRr1f1vBwwp13o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TelLB7pwlwhjKPLPcajC/kTjarvaaLu8Es1w4vF94LlxwmxJ6ERgu0Vf8b1T82wFe5eZIuRPOksW86nJplI/7W/cVvzFqrAPFnSJLF31QQ54OVRqAy6w4AmjTCmzOSrqZ8J1G6ycKdyzTXhvSKj7gAKYHq6YAJrbHAL20YFH/Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=O8Jw2vA0; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-472049c72afso46811901cf.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 24 Feb 2025 07:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1740412414; x=1741017214; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+SFMdPQiZtN6wacFF7EpvAX3p6BY7hIQduF91WeU8pw=;
        b=O8Jw2vA0FETYX8O3u9PiJew5X6kddrdFqAudbqGu99OYnb9Ng2YsARBccqX1PlGT+l
         uXSPGxlY7G5yhJlQctL2UnFDUbrTxD5BGZGRJKNTWClRovWPKAnqsHMXHk6CTWi8TC0u
         JvCGfBYWRzjci1E82WY/sCKZod2UVQGOknYt4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740412414; x=1741017214;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+SFMdPQiZtN6wacFF7EpvAX3p6BY7hIQduF91WeU8pw=;
        b=W4Yj9fP5n6dtlFCOikcNjrjqJysNjuhqFwz+mpaHzavbC/WNDB0cMFSRAkrM5ruZdS
         T+oPcRA+uJJ1zeF2aC7bH4+rnjg9rGuFZo2OHYmRzN5V9xUOhMDZjEXFSug1NjvzZoaL
         wWOV7SpUE9oNlmJkS7PSBjx1SFq1yUhieyd32rZojuLIP0dUZveDfc+rUhinzVJTbZis
         o2bMADaAjmGEaRbjJj4qMKqRr5N851VRpBHIU7SbL24Q0WXc34IZfOevh3A+wOuaUFXS
         DC9VKjv3Ol9zzDwmhnKAbKLIhtjAqXW8UIvaWNW8luXZOL9JLuPeSooaoMPdryqUU+X2
         HOmw==
X-Forwarded-Encrypted: i=1; AJvYcCVfKOs6TkBHvz929DQXWsGmb7PvE3p37sbMtIGHuON0+mdzxLA1u7V6T7cbPXt6NVtFQ2Qo8xfEVbe2dGB3@vger.kernel.org
X-Gm-Message-State: AOJu0YyLuRklxY1XPpPR4xn6AzOh5sUEf3w9b7+7DtRz5Qxr7idR2k4C
	XxyDJhF10sdmtriw3sWlUgbEE7SK7wRw3vj1tuLMKMKWmA2iATREATvM0N07chv0b31+ZQKtqyo
	F95PR5BOCL0PmvhFqhVXo6oPpFaNPs3PqHgRCdkP49r4AXJ5I
X-Gm-Gg: ASbGncuUX0b/7cseORityXcwFyQWuVPBUqEfnUL+xO9iTkqWr5A6dtpBGOa9Q4B6ihh
	HdwY7vtRLlOi8p4ZDyDrLjvEnMlVR8UOextalIESJS5Phul+HlghWJh1ElZTq5DdXdiovdHJYkA
	4lUwXtfP/p
X-Google-Smtp-Source: AGHT+IH4XYo2qdYqSk0Bxi2I40WP+HHA37E8m4NoTgiY8bYtiYy5VfCiYxBMS3crIBWX0qfdTPkRbNdfBDsyhapuzyU=
X-Received: by 2002:a05:622a:1814:b0:472:67:aeb0 with SMTP id
 d75a77b69052e-472228be6f3mr166141541cf.17.1740412414132; Mon, 24 Feb 2025
 07:53:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a8828676-210a-99e8-30d7-6076f334ed71@virtuozzo.com>
 <CAOQ4uxgZ08ePA5WFOYFoLZaq_-Kjr-haNzBN5Aj3MfF=f9pjdg@mail.gmail.com>
 <1bb71cbf-0a10-34c7-409d-914058e102f6@virtuozzo.com> <CAOQ4uxieqnKENV_kJYwfcnPjNdVuqH3BnKVx_zLz=N_PdAguNg@mail.gmail.com>
 <dc696835-bbb5-ed4e-8708-bc828d415a2b@virtuozzo.com> <CAOQ4uxg0XVEEzc+HyyC63WWZuA2AsRjJmbZBuNimtj=t+quVyg@mail.gmail.com>
 <20200922210445.GG57620@redhat.com> <CAOQ4uxg_FV8U833qVkgPaAWJ4MNcnGoy9Gci41bmak4_ROSc3g@mail.gmail.com>
 <CAJfpegvNZ6Z7uhuTdQ6quBaTOYNkAP8W_4yUY4L2JRAEKxEwOQ@mail.gmail.com>
 <CAOQ4uxiJ3qxb_XNWdmQPZ3omT3fjEhoMfG=3CSKucvoJbj6JSg@mail.gmail.com>
 <CAOQ4uxi2w+S4yy3yiBvGpJYSqC6GOTAZQzzjygaH3TjH7Uc4+Q@mail.gmail.com>
 <CAJfpegv3ndPNZOLP2rPrVSMiomOiSJBjsBFwwrCcmfZT08PjpQ@mail.gmail.com> <CAOQ4uxj3=iSUSJfnfkMJVfAeOXAZMRb=k6VSJEWH5uv9Z3Gu8A@mail.gmail.com>
In-Reply-To: <CAOQ4uxj3=iSUSJfnfkMJVfAeOXAZMRb=k6VSJEWH5uv9Z3Gu8A@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 24 Feb 2025 16:53:23 +0100
X-Gm-Features: AWEUYZn8Nk110LsY0JcF0HI9ASTkvhi_tZ7GzKct1dSTGHmatbYVsMMPU9TYWUw
Message-ID: <CAJfpegtAjnyx2AVNNx9wk-yg+2mh6wfNxgbRoqG8SNpm-kVkug@mail.gmail.com>
Subject: Re: LOOKUP_HANDLE and FUSE passthrough (was: Persistent FUSE file handles)
To: Amir Goldstein <amir73il@gmail.com>
Cc: Vivek Goyal <vgoyal@redhat.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	Hanna Reitz <hreitz@redhat.com>, Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Type: text/plain; charset="UTF-8"

On Thu, 20 Feb 2025 at 16:51, Amir Goldstein <amir73il@gmail.com> wrote:

> - readdirplus passthrough iterates on backing dir inode and populates
>   fuse inodes with nodeid that is taken from backing dir's children ino
>   (hence 1-to-1 mapping from all backing inodes to fuse ino/nodeid)

If nodeid == st_ino, then in theory no LOOKUP is needed, the kernel
can just assume that the fuse server can look up the object based on
st_ino.  The problem with that is: looking up by st_ino can only be
done by doing a complete scan of the filesystem, which is often not
practical.

> - stat()/getattr() on those children is served directly from backing inodes
> - Let's call one those kernel instantiated child inodes C1
> - Before any fuse command is sent to server with nodeid C1, server needs
>   to be notified about the entry that only the kernel knows about
> - kernel could send a regular LOOKUP for the child and expect to get
>   a nodeid from the server that is matching C1 or mark the inode bad

A regular LOOKUP assumes that the parent is already known by the
server.  Of course, this could be done recursively up to the fs root,
but it looks really tricky due to locking assumptions.

>
> Open questions:
> 1. Is a regular LOOKUP appropriate here or if this needs to be a new
>     INSTANTIATE command which tells the server about the C1 nodeid.

How would this INSTANTIATE work?   Telling the server about the nodeid
won't help, it has the same problems as if the server was just using
the nodeid (st_ino) directly.

> 2. Does this need to be a LOOKUP_HANDLE command to verify that
>     not only the server's child has the same ino as the kernel's child but
>     also that they have the same file handle.

Hmm, you mean the kernel queries the backing inode's fh, then sends a
LOOKUP_HANDLE with that fh?

I guess that might work.

> 3. What is the proper API for binding a backing id to a fuse inode
>    regardless of readdirplus?
>    Extend the regular LOOKUP out args?

Yes, this is how I'd imagine this (which doesn't mean it's the best option).

>    Require LOOKUP_HANDLE and use its out args?
> 4. When a child fuse inode is instantiated via readdirplus passthrough
>     it automatically passthrough getattr(). What about other inode ops?
>     are they decided only after the response of LOOKUP/INSTANTIATE?
> 5. Does this response need to reaffirm the binding to the backing inode
>     and if not, association is broken and getattr passthrough is stopped?

I don't know. It would be good to see what this will be used for.

>
> I have a WIP branch [1] with some of the concepts implemented.
> only compile tested!

Will have a look...

Thanks,
Miklos

