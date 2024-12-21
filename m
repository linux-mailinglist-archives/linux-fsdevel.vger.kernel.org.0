Return-Path: <linux-fsdevel+bounces-37997-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A0BB69F9E72
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Dec 2024 06:15:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E3757A14A5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Dec 2024 05:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7E71EBFF9;
	Sat, 21 Dec 2024 05:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NBXpg8Ka"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FFED1DC05D;
	Sat, 21 Dec 2024 05:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734758139; cv=none; b=tTRf2eXtVFJlRkda7dBladHLYp0+UoyC471ndFO4zcXVOQqMxTUv3Qr89YKrFeROmgJ6X1ixIgxSufVl+5mekSbT+ioJkGobEKn407mwjYqHYrvMGOB6sNUrnzKjdiH1hd/yrI6C9u5sXv9J3ToRgp9r2pSb3U4+SR5Ax9mwYqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734758139; c=relaxed/simple;
	bh=6D22z4Q6qM5owg8DKTRELAvvJsU6v0seLUtNWMGH3rc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tTyTQPCN9iagD8LBxoXy1XbFfwexQc/5IGhnsUrrrYr6w967Y19tITkMicl48DJ03eC0RCjL1V/eTk3tm5PxyXW3oO1QevN+VtHMAz7IkzZnakrgjNA72qjYROFl9mJpf9MEACvBLGIs+dm1WIg/evsxm2o+78CBdPs+xJzitU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NBXpg8Ka; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92513C4CED0;
	Sat, 21 Dec 2024 05:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734758138;
	bh=6D22z4Q6qM5owg8DKTRELAvvJsU6v0seLUtNWMGH3rc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NBXpg8KaWOmk5BPV9JRlUwyRpdhTsLRyF3o8nRURr2/sbFbiwU2VhLnOWtq7YJJec
	 Ot/mrxQD51xumkqWjcecDxrOC+vTCvlpENvgKus+wds6XuYQMZ4OjFmYVLVzNmKCQx
	 8Yd4aIB+ofU4wRNrNx2mJNZo6Y8Ig66H3F2PCCchNTw5ieI+yPfxIk0SIIw6/HdH41
	 HX+8wPXoowb5iLRcX7svVCHB1ds6rNhJGAqS3gQxaOmqT1MnGb2nQvhuhzrDVJM+Yw
	 huvvldEYppAd0O00Hj7vzofTkZWWE0+YpLYoWM8cW36gTa9GhYsreT3EctWsy/x6p3
	 x8mJPCbZig5Og==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-30227ccf803so30688031fa.2;
        Fri, 20 Dec 2024 21:15:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWGYreHwMUszy5UgNuZUTksceEcl518AJ8OCVnzRDwaZczjkPJnylw1YUIvjxs7AAhKkbo5MLe1v3qJkA==@vger.kernel.org, AJvYcCWSCIUaRI9WNkoiR2C4CwDdxDzKkhUjTSH29am2r5U/UnABcQSFwFQHAxzlrLY4Ijgk0Ku02IoiyMZI@vger.kernel.org, AJvYcCX4OD0BWgsTIfwCHejzb4Wbs1QjRUOWVphN7WOeL9URPj4Wd0dJr27TxNnLoBnheLQNQnRXsY5uN6l0vcg2rw==@vger.kernel.org, AJvYcCXWuKiJRAxB0ULYb+sV7GQW3R5QzcDVIOgohd8U22CaW687WMlQlXspxjCNEfxPI/wY7hqpCqhapmc2@vger.kernel.org, AJvYcCXpFdprpb/RC2RqVVz3qTWNF9y+ukZIqZaDyfYrWSk4Cffu0OAsqifYTJQqPJDeELEFX5aFQ0U036J4gI3e@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3cvYGpHu0L7ETAVbB0U+iEkcJhrnzUNsk7BsAK0J7EFOH3p13
	xAUbVQXN0SCrUCHNmtL/CaS479CKWBMMbiiCdlaFZ+3Ijv78nPKXhlr9DiUElRB6MQuif8guWJ5
	JMClfEpJGmmWsVCmMwE52dj87PVM=
X-Google-Smtp-Source: AGHT+IFLGvnYDVZLLa6gb/IFLNG+NtJdTz+H8BQtiW/Pv7A9hdRHwl2vjaIxr7x6UhU9lyjaVH3MCdnPjifz3TMcGbU=
X-Received: by 2002:ac2:5682:0:b0:542:2f5a:5f52 with SMTP id
 2adb3069b0e04-5422f5a5f9dmr180818e87.13.1734758137206; Fri, 20 Dec 2024
 21:15:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241213135013.2964079-1-dhowells@redhat.com> <20241213135013.2964079-2-dhowells@redhat.com>
In-Reply-To: <20241213135013.2964079-2-dhowells@redhat.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sat, 21 Dec 2024 14:15:00 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQndCMudAtVRAbfSfnV+XhSMDcnP-s1_GAQh8UiEdLBSg@mail.gmail.com>
Message-ID: <CAK7LNAQndCMudAtVRAbfSfnV+XhSMDcnP-s1_GAQh8UiEdLBSg@mail.gmail.com>
Subject: Re: [PATCH 01/10] kheaders: Ignore silly-rename files
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <christian@brauner.io>, Max Kellermann <max.kellermann@ionos.com>, 
	Ilya Dryomov <idryomov@gmail.com>, Xiubo Li <xiubli@redhat.com>, 
	Trond Myklebust <trondmy@kernel.org>, Jeff Layton <jlayton@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, netfs@lists.linux.dev, linux-afs@lists.infradead.org, 
	linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org, 
	ceph-devel@vger.kernel.org, v9fs@lists.linux.dev, 
	linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Marc Dionne <marc.dionne@auristor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 13, 2024 at 10:50=E2=80=AFPM David Howells <dhowells@redhat.com=
> wrote:
>
> Tell tar to ignore silly-rename files (".__afs*" and ".nfs*") when buildi=
ng
> the header archive.  These occur when a file that is open is unlinked
> locally, but hasn't yet been closed.  Such files are visible to the user
> via the getdents() syscall and so programs may want to do things with the=
m.
>
> During the kernel build, such files may be made during the processing of
> header files and the cleanup may get deferred by fput() which may result =
in
> tar seeing these files when it reads the directory, but they may have
> disappeared by the time it tries to open them, causing tar to fail with a=
n
> error.  Further, we don't want to include them in the tarball if they sti=
ll
> exist.
>
> With CONFIG_HEADERS_INSTALL=3Dy, something like the following may be seen=
:

I am confused.

kernel/gen_kheaders.sh is executed when CONFIG_IKHEADERS is enabled.

How is CONFIG_HEADERS_INSTALL related?



>    find: './kernel/.tmp_cpio_dir/include/dt-bindings/reset/.__afs2080': N=
o such file or directory
>    tar: ./include/linux/greybus/.__afs3C95: File removed before we read i=
t
>
> The find warning doesn't seem to cause a problem.

I picked the following commit.

https://lore.kernel.org/all/20241218202021.17276-1-elsk@google.com/

This shoots the root cause of the 'find' errors.
Does it fix your problems too?


Your patch does not address the 'find' errors.






>
> Fix this by telling tar when called from in gen_kheaders.sh to exclude su=
ch
> files.  This only affects afs and nfs; cifs uses the Windows Hidden
> attribute to prevent the file from being seen.
>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Masahiro Yamada <masahiroy@kernel.org>
> cc: Marc Dionne <marc.dionne@auristor.com>
> cc: linux-afs@lists.infradead.org
> cc: linux-nfs@vger.kernel.org
> cc: linux-kernel@vger.kernel.org
> ---
>  kernel/gen_kheaders.sh | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/kernel/gen_kheaders.sh b/kernel/gen_kheaders.sh
> index 383fd43ac612..7e1340da5aca 100755
> --- a/kernel/gen_kheaders.sh
> +++ b/kernel/gen_kheaders.sh
> @@ -89,6 +89,7 @@ find $cpio_dir -type f -print0 |
>
>  # Create archive and try to normalize metadata for reproducibility.
>  tar "${KBUILD_BUILD_TIMESTAMP:+--mtime=3D$KBUILD_BUILD_TIMESTAMP}" \
> +    --exclude=3D".__afs*" --exclude=3D".nfs*" \
>      --owner=3D0 --group=3D0 --sort=3Dname --numeric-owner --mode=3Du=3Dr=
w,go=3Dr,a+X \
>      -I $XZ -cf $tarfile -C $cpio_dir/ . > /dev/null
>
>


--=20
Best Regards
Masahiro Yamada

