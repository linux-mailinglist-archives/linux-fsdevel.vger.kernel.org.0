Return-Path: <linux-fsdevel+bounces-41320-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4D5A2DF55
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Feb 2025 18:27:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2570C164B79
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Feb 2025 17:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B471E0080;
	Sun,  9 Feb 2025 17:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gdv+Faox"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55788EAC6
	for <linux-fsdevel@vger.kernel.org>; Sun,  9 Feb 2025 17:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739122020; cv=none; b=TC8E8IOu2D2t+4paNdAW68wDx5WXXTY6gZdX0uc8ChrZdfQPXBh8N3zaMtSYEtIjfgN5tBAhm1HjGJQ7RKrxSV5FSmHZvcKhyNCBENDz9b6UuaSqUQjvu0oza5pNPDCsQq33LQbpqrf/x5bjp5wiEQs8RS2JFU8VZOIIAeNHHqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739122020; c=relaxed/simple;
	bh=3KG+Y83CXLaEOM15Q6WqOTQa9qBNTdeztebI0QCGVQk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YmzzMl+5quP+vhEcBrqHSg6v2cf28ONBz7cjCADkdMpqrPSKzLG24F+UQRLFbq7kUv+sLct1lK+iobm7Poyxl20USD7pSACDgudK6n/99S7A/rgxi+cX6bZl1L6EOF1ozidu3BKcGHqDwr4SWY+H09A74PUOuDwjJJhcMcv/P/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=gdv+Faox; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5dccc90a52eso6238318a12.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 09 Feb 2025 09:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1739122015; x=1739726815; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=T7rWMyHpSr2s52jssq674Fk9xNbqQpwV6kSeNvyIkbA=;
        b=gdv+FaoxOuV1lbQpSaNymasS7nr1sTiiFVmOxaP+Ba9xz04CKtChRGqVeJqU/N7XSh
         m0+QDWUacpa+R6TlsiLfdNB/5I+wn7+d0CEP8k2BKXC7iRnPYuY2Zr470+ICXICjjX6K
         KCoyzLeRzPRWXKXF7fYaq4h0GrqDlzsvyYIWc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739122015; x=1739726815;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T7rWMyHpSr2s52jssq674Fk9xNbqQpwV6kSeNvyIkbA=;
        b=G+5djsS/ewITWR0hJc3glJp06/qIVYgfXC2snD4pi70NrY/3cTedJUp/XkxqfEMMdb
         0/baTOriBu4X4+RafmXySpJvdBvbgNUIkS/1B6e3MxBd7Ka+doJKyQsUcnVE4+o0eA9u
         Bt4NzsJjByAaqhT7wW3k7xlB5ouATbeOAXgMSpmxqCppkDHmwBYo6gqNo+2S7oFC3hzl
         ChBvr7AUDzemPc76yGGHkzu6zuFmfIrT0sH+oR0WeFXrOqQR2hwVTOBAgYHXa97JQVoY
         +wudPj19GUy6nENfl1Q6vKJxJCC6HJXRPj7E4cvKkRxdvWeYuuMaeTxbhQD1K591YMcU
         YVPA==
X-Forwarded-Encrypted: i=1; AJvYcCWLRT6YgVAW++IkaH+nZJoRbjJDegukDNwp3Wb7R/DYLQfmaZIZc3040rqvoMvdlflgPFreyT+lx+h+/iqk@vger.kernel.org
X-Gm-Message-State: AOJu0YzqFE5Y56y48ZUiXqi3k7Hd7MY0SKgDmCBIw8fF8fDxIWTd54td
	KHAnQkzWubbujOztvF3IWfyac6BJArkp1uNNXAYtGY0KizaoyLTtiJdFgCgXN29aZWWj6jcorei
	o3iU=
X-Gm-Gg: ASbGncu8JKM6nnBdF085oo/vHf73Lgwa7oQWFD4TPkf43vrDFHRl0lqGROpJ5WdVlGy
	rahaLcZP6CPt/qwY0zQY4lF9i/hf9+b0KqEXXFwt0Hr6Ee59Vzi7d9O3AZtFj3S0qVWOfzNvNtb
	f+OZJLbuzxYNiHZ7r4qEC8joHm08ooAl9lXoeKhDRCb6O0JPXjSIhY/vxmZvlPDhMph9DyBAf3k
	9GuSfzBDO2gZqoIf/zuTt2AwifE30aJWpp+gmNqOoRaRUUERXattNHIDRscNvct1OSn8VvOdt/a
	qajFrkezrQs+r3JB8+HUwrlWtqV6RNqDgTzWLamvcV/mK2pYaHRDRs6Ehblq4601gw==
X-Google-Smtp-Source: AGHT+IHOgV+m5RL8inenZk1WWmKUIGZUOXa7yuTalmwr0C5jNEyPTN3CsR6ngm4DUQw4bD9jnYFmHw==
X-Received: by 2002:a17:906:6a23:b0:ab6:d575:3c4b with SMTP id a640c23a62f3a-ab789c3aee7mr1322560166b.42.1739122015352;
        Sun, 09 Feb 2025 09:26:55 -0800 (PST)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7b4724c38sm170002466b.121.2025.02.09.09.26.54
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Feb 2025 09:26:54 -0800 (PST)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5de84c2f62aso77695a12.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 09 Feb 2025 09:26:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUyAPsR+DQ5ReE1f1pzsh+tjaPE+Q4Pre6oz6RQkZBJzAwM4Jv5r4cWVZ9T145uvBvmgnNMOqJwT2xWWzgU@vger.kernel.org
X-Received: by 2002:a05:6402:3510:b0:5de:5947:ea35 with SMTP id
 4fb4d7f45d1cf-5de5947eab6mr8104437a12.25.1739122013840; Sun, 09 Feb 2025
 09:26:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250209150718.GA17013@redhat.com> <20250209150749.GA16999@redhat.com>
In-Reply-To: <20250209150749.GA16999@redhat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 9 Feb 2025 09:26:37 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgYC-iAp4dw_wN3DBWUB=NzkjT42Dpr46efpKBuF4Nxkg@mail.gmail.com>
X-Gm-Features: AWEUYZkyMQnBA56VTx9VYyWlnOLvTM7NZ8JOwLDkeKyPyeGtE_WZK30npEYLfzM
Message-ID: <CAHk-=wgYC-iAp4dw_wN3DBWUB=NzkjT42Dpr46efpKBuF4Nxkg@mail.gmail.com>
Subject: Re: [PATCH 1/2] pipe: change pipe_write() to never add a zero-sized buffer
To: Oleg Nesterov <oleg@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>, Jeff Layton <jlayton@kernel.org>, 
	David Howells <dhowells@redhat.com>, "Gautham R. Shenoy" <gautham.shenoy@amd.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Mateusz Guzik <mjguzik@gmail.com>, 
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>, Oliver Sang <oliver.sang@intel.com>, 
	Swapnil Sapkal <swapnil.sapkal@amd.com>, WangYuli <wangyuli@uniontech.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 9 Feb 2025 at 07:08, Oleg Nesterov <oleg@redhat.com> wrote:
>
> This is no longer necessary after c73be61cede5 ("pipe: Add general notification
> queue support"), pipe_write() checks pipe_has_watch_queue() and returns -EXDEV
> at the start. And can't help in any case, pipe_write() no longer takes this
> rd_wait.lock spinlock.

Ack. This code all goes back to the two-level locking thing with
notifications using just the spinlock side.

The locking was removed from this code in commit dfaabf916b1c
("fs/pipe: remove unnecessary spinlock from pipe_write()"), but the
"pre-allocate" logic remained.

This patch seems to be the right thing to do and removes the vestiges
of the old model.

But I don't think you need that pipe_buf_assert_len() thing.  And if
you do, please don't make it a pointless inline helper that only hides
what it does.

             Linus

