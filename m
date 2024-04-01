Return-Path: <linux-fsdevel+bounces-15828-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3747E893C4E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Apr 2024 16:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6F29281806
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Apr 2024 14:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9CB644375;
	Mon,  1 Apr 2024 14:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JpaIjc+Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9499F41A8F;
	Mon,  1 Apr 2024 14:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711982622; cv=none; b=KSIMDVIqaxLm+qgWZvK853Gzs37sggZG6AiMqIWem8c5mn+pbzQNlQZmSuS5KFah+WmTvGGW9w7OMBAJow3v46WHLEo/igzGlqKeFIN+9qlf/SsOr9gJVGZT68Owka+Kym5QfaKPFBY9PMRNQri9fd0KQbJ6qyUnJHdExUUg2sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711982622; c=relaxed/simple;
	bh=Vc6NiOHxNPUEbcLUyvebLrZcsJJh6LzjpaD86Ih2b+0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=erLoN07zyinpokQpXOjVZDjaTzNZtbQvpQPEZGgB3LnYbuBHl9HEMHMb36AzvC8gAdpUo++YdJzkZwULTWNq7qY0pKzBEqv2qnztly/BsBiRHfFTXlRZ1aK052HqLIeLYYJd/vhLs6kB88r8W9sWeo61CIyQ2C0fCmTAUJqUiwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JpaIjc+Z; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6963c0c507eso39223016d6.1;
        Mon, 01 Apr 2024 07:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711982619; x=1712587419; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Vc6NiOHxNPUEbcLUyvebLrZcsJJh6LzjpaD86Ih2b+0=;
        b=JpaIjc+ZNAJq+2U378+Imfr6AB3TZlLUwO4Y+JjMleDx1x9B/4xFw9j1KUM6yyxGs/
         Nv05YL0IczDoPQJRM15M5zf+HIGo4jYJJ4yB7d1oD9i0DbAl0JYwOVQ9ZwpRrET5rJPn
         xWf1c+guSw97t6XzJHbexL0g7Zzau1K4BnsLZ6DUYbUHgP2K384lGeYta6Z5m3DV/S5Z
         tNRar3/yoYg/jP0Co7EPswJmsJiumlqiBVGUAdEAdrm3/ymFynL0BA8LNiY0gbGXuTZu
         Sg2ELVUz6QSssc7l1iYkYHL62h1fAjR7N44ALK1yNeK4lwfYPTjjrZ+P54aChaeYWPdd
         Q7KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711982619; x=1712587419;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vc6NiOHxNPUEbcLUyvebLrZcsJJh6LzjpaD86Ih2b+0=;
        b=ln/wQFKNpcbk31vPpEZyQEQi5x7srAfeRLePHLMu4X+qUsg0qUO5HAhAsuDjqDAlT0
         2lkuGYgIPnsZYVRE3EFBti9xbrWdmOx9uGFgU018c8pE8gONoHMC7fBIT7P0nTLIuVfS
         sk7HjqGsmcGUlBXm7PDTA2oEico83dVXrSu1Dx9t0BtQwKw74IlXoF6SBNEbzfVSte00
         AmAKv2MFEasBuWXGmef6arW60Wv0SlCzmPsvhrZArqt/SllM+wNlM2Yrqxa+MesAcjrZ
         iWIu4sJe31Bu33lZ5C7vjarY2mG4vcvCrUkouXzc2h+CZPb5pZ9yQsqfcDtut8GaiSZz
         5Xew==
X-Forwarded-Encrypted: i=1; AJvYcCWnbq1N45PacJQG+inGFKEGz4w+yat08sblq6TDjd2Fl6HjIf3LRVk8qMrh5tIMj5VvCVoR+3c5MpIJZcKQI1NhyiqZG886uy+6xErhN4ME1P+dAOEGJYZ/ltB/n9Qq11mrVo+99pxi5H/XiF+G0XhBMd+9+e8HAsrZamsFUPnxW+cEo82B2PXg2YXhNk72nWCof9MAkibMF5xOBxt/iL4=
X-Gm-Message-State: AOJu0Yzewk4O7pshwlZ1rMqUDZBCPMzbWyQ/z6SkHPFism/eIkAedcSb
	742e8ml8rIwBBFu1zLcVXA3hK52mFyYVDQP+aAOPdtNTAI71uwAjDwGSX1PXaRvJPl5X/b8oPcU
	Le/Xui76WTYdy1jBew7MRbmfx8PY=
X-Google-Smtp-Source: AGHT+IEj5PHp+PAahd9ICs2conJFjhP/2w0ENPJPsqRrd5GeyeyrfMR8kAs+QQf9J4427JbhyeAo9E72xbgAa7y1jjI=
X-Received: by 2002:a05:6214:84c:b0:696:739c:7296 with SMTP id
 dg12-20020a056214084c00b00696739c7296mr19388342qvb.21.1711982619467; Mon, 01
 Apr 2024 07:43:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240329015351.624249-1-drosen@google.com> <CAOQ4uxhLPw9AKBWmUcom3RUrsov0q39tiNhh2Mw7qJbwKr1yRQ@mail.gmail.com>
 <CA+PiJmQR17nwkHaZXUhw=YRM06TfF14bhozc=nM9cw51aiiB6g@mail.gmail.com>
In-Reply-To: <CA+PiJmQR17nwkHaZXUhw=YRM06TfF14bhozc=nM9cw51aiiB6g@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 1 Apr 2024 17:43:28 +0300
Message-ID: <CAOQ4uxiyS9viEpOwT8f2Np=wuMdWwUqqyHFRrBX9+Acy_i3OHw@mail.gmail.com>
Subject: Re: [RFC PATCH v4 00/36] Fuse-BPF and plans on merging with Fuse Passthrough
To: Daniel Rosenberg <drosen@google.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Joanne Koong <joannelkoong@gmail.com>, Mykola Lysenko <mykolal@fb.com>, 
	Christian Brauner <brauner@kernel.org>, kernel-team@android.com, 
	Bernd Schubert <bschubert@ddn.com>
Content-Type: text/plain; charset="UTF-8"

> >
> > That sounds like a good plan, but also, please remember Miklos' request -
> > please split the patch sets for review to:
> > 1. FUSE-passthrough-all-mode
> > 2. Attach BPF program
> >
> > We FUSE developers must be able to review the FUSE/passthough changes
> > without any BPF code at all (which we have little understanding thereof)
> >
> > As a merge strategy, I think we need to aim for merging all the FUSE
> > passthrough infrastructure needed for passthrough of inode operations
> > strictly before merging any FUSE-BPF specific code.
> >
> > In parallel you may get BPF infrastructure merged, but integrating FUSE+BPF,
> > should be done only after all infrastructure is already merged IMO.
> >
>
> Ok. I'll probably mess around with the module stuff at least, in order
> to work out if everything I need is present on the bpf side. Do you
> know if anyone is actively working on extending the file-backing work
> to something like inode-backing? I don't want to duplicate work there,

I am actively *thinking* about working on passthrough for getattr/getxattr.
As soon as I come up with something concrete I will let you know.

> but I'd be happy to start looking at it. Otherwise I'd focus on the
> bpf end for now. I expect we'll want to be able to optionally set the
> bpf program at the same place where we set the backing file/inode.
> Hence the spit into a file and inode program set. I'm still thinking
> over what the best way to address the programs is...
>

My thoughts were doing something similar to FOPEN_PASSTHROUGH
but in response to LOOKUP request and in that case the fuse inode
will enter passthrough mode early and will not leave passthrough mode
until inode is evicted.

> > Please explain what you mean by that.
> > How are fuse-bpf file operations expected to be used and specifically,
> > How are they expected to extend the current FUSE passthrough functionality?
> >
> > Do you mean that an passthrough setup will include a reference to a bpf
> > program that will be used to decide per read/write/splice operation
> > whether it should be passed through to backing file or sent to server
> > direct_io style?
> >
>
> So in the current fuse-bpf setup, the bpf program does two things. It
> can edit certain parameters, and it can indicate what the next action
> should be. That action could be queuing up the post filter after the
> backing operation, deferring to a userspace pre/post filter, or going
> back to normal fuse operations.
> The latter one isn't currently very well fleshed out. Unless you do
> some specific tracking, under existing fuse-bpf you'd have a node id
> of 0, and userspace can't make much out of that. With that aside,

node id 0 sounds weird.
I was wondering if and how a passthrough lookup operation would work.
The only thing I can think of is that in this setup, fuse must use the backing
file st_ino as the fuse node id, so that the kernel can instantiate a fuse inode
before the server knows about it.

> there's all sorts of caching nightmares to deal with there.
>

Yeh...

> We're only using the parameter changing currently in our use cases. I
> wouldn't be opposed to leaving the falling back to fuse for specific
> operations out of v1 of the bpf enhancements, especially if we have
> the userspace pre/post filters available.
> So you'd optionally specify a bpf program to use with the backing
> file. That would allow you to manipulate some data in the files like
> you might in Fuse itself. For instance, data redaction. You could null
> out location metadata in images, provided a map or something with the
> offsets that should be nulled. You could also prepend some data at the
> beginning of a file by adjusting offsets and attrs and whatnot. I
> could imagine having multiple backing files, and the bpf program
> splitting a read into multiple parts to handle parts of it using
> different backing files, although that's not in the current design.
>

Lots of plans ;)

>
> Can you not read/write without interacting with the server? Or do you
> mean FOPEN_DIRECT_IO sends some file ops to the server even in
> passthrough mode?

FOPEN_DIRECT_IO sends write() and read() to the server even in
passthrough mode.

> At the moment I'm tempted to follow the same
> mechanics passthrough is using. The only exception would be possibly
> tossing back to the server, which I mentioned above. That'd only
> happen for, say, read, if we're not under FOPEN_DIRECT_IO. I've not
> looked too closely at FOPEN_DIRECT_IO. In Fuse bpf we currently have
> bpf mode taking priority. Are there any email threads I should look at
> for more background there?

Maybe this patch set:
https://lore.kernel.org/linux-fsdevel/20240208170603.2078871-1-amir73il@gmail.com/

Bernd and I worked on it together as a prerequisite to fuse passthrough.
Benrd has some followup direct_io re-factoring patches.

Thanks,
Amir.

