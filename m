Return-Path: <linux-fsdevel+bounces-42760-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC6AA482CF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2025 16:22:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE16D3AAAB1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2025 15:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB0EF26AABD;
	Thu, 27 Feb 2025 15:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m5Z+0LQ/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079EB259493;
	Thu, 27 Feb 2025 15:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740669764; cv=none; b=B4AxDb+dNCa8rFRiqO3SUExGyxg39wojL6ravjj/yIDgWvXyfBS09D5JWD7WQYHdIFrZR/mGyLTRNL6fWKmF2hCEHXejMvVe7WsrvLnG/ahbGTiZj8bO00W/6BM89Zb84rHP8G0/W5xUd8wRsE9Bygn/9hrgzwiSllaJ5AROYaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740669764; c=relaxed/simple;
	bh=1SVxacu8ATtmAP908NS6+KKXwalFxj5EJQoy7daa6ks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FAEr9ngd0mtMuUi970ChuyGjEtVhDiQe9Q01zLkjTis0QoFR6OvQgkx0g2YJ36bfbrHL2+lRJRV92YoIIStfTFLVG9L9RcWB4JPYV+Sz77en7+95VA7pFNgboYKP/gzad0OBc5j8X13og9ZMaPrIbG6tOZkmlatfRhFYsPrjGPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m5Z+0LQ/; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2235908a30aso15710155ad.3;
        Thu, 27 Feb 2025 07:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740669761; x=1741274561; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g7a/cAUhkti68XpQh7UWKw8QuI4mozU9EgVOFOHErTo=;
        b=m5Z+0LQ/1bQxZP63sf3Ar4qrc7rtQGG6mmp5ZO5aPPlEM7ntfXnkhQnLH6US9fA+gP
         bMXZb2RiILo+S+a2zCDEtfO6BFbqRaougQvlggUQavWEn/3y8Hc2gl2wXuyZ7CwPeyPj
         eQFyld2HkPIY33hLPX7+gFGb1L++msVEDQVdt8+O94LAjWZBPClWM2wIvT0f8UGKJA1h
         HA2g/Fn7A3/wG+CTKg97kV9lSudUnNJ+oCtK6Pdi8+cisrwehxg0FTXeDwT+SjTdJps8
         dUsuiwQ2sa4KN7Up0RJcsA3MSMiXRx0747EnlTyR0OJjysWVS15PMAx7pfVdgc0Qhc5h
         llTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740669761; x=1741274561;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g7a/cAUhkti68XpQh7UWKw8QuI4mozU9EgVOFOHErTo=;
        b=QCZevnXeO1n6oGMW+WKMav6QNl1HenyErC9+t9EEukBesF0oS97L1b7B93NZbQM4GP
         BZTTrEM7CHKrG6B4v5vv3lbg7ZmO+ZInER/sZQQ1To5O29RRsu0jMVq69XfxMis6EoAR
         HGKtq7Oa9CxFoLq3ecS/axuOIgvz/u6Gm0T7KWdd1hdeJH9OOfnn3l2w/dn/l3ssjRhR
         u5iTHnKqwaFYgqoVIqWGE9rxsnCs3F9xoSVLzQEgy6eL3EV5IBaSELRjKNw7j5n6GIIs
         Z2pXCWSdRQgweG9aq28xKnYF8IyGdHLcxpV5o2M3Ah7grbSG1pgYDk6xkhv8kmYwQAVp
         qicQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJXqg/Z/k/J5Ggeup7/QqN0Iu2au/j5DQbQO0vsfFdlbGxJga2s1waTVt1Xy45YCq8xNAX7npLhg==@vger.kernel.org, AJvYcCUXVHQ3v/PqkoQ43c6eIG6FltBqZhLkiGLwJ6qi/gKvv/VsGqK7+Aj+3cmK7WN4cPND9Ocys0jR8WJ2OeFViBO6qCCDYZXK@vger.kernel.org, AJvYcCXUkz0Ow/YW44Ox84CyxgLIXrXGlHCEovD2ZSJXHdvsEE07xyDI7x6OqbZbBL9spE3Oa9ihU1z1cAzaUnd0@vger.kernel.org
X-Gm-Message-State: AOJu0YzhbjI3CZyOb2SVoeCOglbn+6RQI2tIUaMLYRGQCA1Sd3UiZEsx
	MYKr4Nqg4mJ3SGyT7/C7HjLXwBM2eJmoPvZg9tJnyrLEOXx4KMIjRShwMiX2aOBjAMAQ/E3toUK
	ObVoQDAVHRw4twB0+JF0+XtyWJGI=
X-Gm-Gg: ASbGncu1Ok6LWtY9LoEAWymmE7mSpuDfkwsVFU4/PmFrNNF0XgcVlua2XN/vaceH4xy
	5a7iuoAXpBb7Ha2T3e93hVpOyTGQN5aJpByzsKnlF8qF0p1PstFNLbkdIoeX1E8m57W/eC2Ywxk
	eAwa7gCZc=
X-Google-Smtp-Source: AGHT+IE+w5fusJYoHQ3wPbckiON8o5BwLP3W2r4hHKOfZZFZkBYr77XbwtHjwHWjmZo9lBiybVv+m3pNyWzdDCAbP74=
X-Received: by 2002:a17:902:f706:b0:21f:6584:208d with SMTP id
 d9443c01a7336-22320213441mr131908065ad.43.1740669761190; Thu, 27 Feb 2025
 07:22:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224154836.958915-1-mszeredi@redhat.com> <4a98d88878a18dd02b3df5822030617a@paul-moore.com>
In-Reply-To: <4a98d88878a18dd02b3df5822030617a@paul-moore.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 27 Feb 2025 10:22:29 -0500
X-Gm-Features: AQ5f1JpcFANpUeCWvjxniU8h27ug25dYTeV4rnjCDFZymbqEOfkmhYqddoMbtPQ
Message-ID: <CAEjxPJ5V9z87c6pHVRemKxENoNq9TvqpQ3tJpLEbP4QEViZTHQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: add FILE__WATCH_MOUNTNS
To: Paul Moore <paul@paul-moore.com>
Cc: Miklos Szeredi <mszeredi@redhat.com>, selinux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 3:19=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Feb 24, 2025 Miklos Szeredi <mszeredi@redhat.com> wrote:
> >
> > Watching mount namespaces for changes (mount, umount, move mount) was a=
dded
> > by previous patches.
> >
> > This patch adds the file/watch_mountns permission that can be applied t=
o
> > nsfs files (/proc/$$/ns/mnt), making it possible to allow or deny watch=
ing
> > a particular namespace for changes.
> >
> > Suggested-by: Paul Moore <paul@paul-moore.com>
> > Link: https://lore.kernel.org/all/CAHC9VhTOmCjCSE2H0zwPOmpFopheexVb6jyo=
vz92ZtpKtoVv6A@mail.gmail.com/
> > Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> > ---
> >  security/selinux/hooks.c            | 3 +++
> >  security/selinux/include/classmap.h | 2 +-
> >  2 files changed, 4 insertions(+), 1 deletion(-)
>
> Thanks Miklos, this looks good to me.  VFS folks / Christian, can you
> merge this into the associated FSNOTIFY_OBJ_TYPE_MNTNS branch you are
> targeting for linux-next?
>
> Acked-by: Paul Moore <paul@paul-moore.com>

I'm not objecting to this patch, but just for awareness, this adds the
permission for all file-related classes, including dir(ectory), and we
are almost out of space in the access vector at which point we'll need
to introduce a file2 class or similar (as with process2).

