Return-Path: <linux-fsdevel+bounces-14134-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D03F78781CB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 15:40:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58B1AB20C08
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Mar 2024 14:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57527405EC;
	Mon, 11 Mar 2024 14:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="FtwoKkDH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF173FB8F
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Mar 2024 14:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710167994; cv=none; b=QlPyQk8YknzbwdDjxxwepLulvQGEZbKix2cY38secZYlNlI64rT+jodxbDcGYl7fC1pMRuVsw2736EOi6K0q3HroA0quFdEOlu7DsVF8jFqMzeHsEng/mj0eueIymJa8ZGsOllO4UE6Gs9ghD1c9VBwhhRSxgwQH81yo95S2dv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710167994; c=relaxed/simple;
	bh=u4RbZxYkIUcZLlV/Aac1nmArqd0mIIwdpdWDUU4vGBc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jm8/sFvWTjYFfaqdccitwrhu4i9f28nAe70B82MViUdufUF8GIrZSpenJlxPLj1DhfxBERd+Oik55hwJf7vJnCk+QL3rLT/T5xhwBDcBoGIEmIBTTCpUTDlJeXLDCKm3xs49Ctqzicq0/zMXo67GzLosJtcXapbbaJc0dxeqiJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=FtwoKkDH; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a4627a7233aso169129766b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 Mar 2024 07:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1710167991; x=1710772791; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HtzqfIQsJolmXYNugXTjr3G7HqidI6CITo9smjLyZOw=;
        b=FtwoKkDHraZU1QoV8Gum7FNgNNK37LfUzLn/WibufGarZSGcL8edRvDxuPyl2KGgjV
         hhRPWMJ4XjwgyCaT/VMpMPhN80X90X9eptqmTeE/4uxl+De2zMxiWc+fAGlp/IMWujoH
         Pvcy0fRPRV3nf3vzu+ussZJOxEjjULlZ3x+V0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710167991; x=1710772791;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HtzqfIQsJolmXYNugXTjr3G7HqidI6CITo9smjLyZOw=;
        b=uY6GaB3Y+SgNMEZ0Y6dq22iVOp4fCEOXX0fufBy/0ZPROwM8aDglVYGwZWhtpMxYkV
         eCRNkV7RwT8H9ZOR2YmTXq3X/372RbohwGZ1FitK/sdrsVhrxdFoI5RZNKdt9eT5lGjN
         I9QC6wShrg4uJVJQIGjO+d0/fri/rIq2ocCk7zEK8jvaw7DmkoDgehd+3jx3eBZk38oc
         wuHy1vMu26iC9D8AYIEtBJ83H97b4J14FeSPZwC05ZgJ6K9F+gx5JGfyRnfIRFqCJg9w
         O03scRWQyar5hf7KvKCotVV0YCGZjs0ynPOf7mcUkcepQ4wwT7Ds63zOs8/wFUU2mh+F
         jqcA==
X-Forwarded-Encrypted: i=1; AJvYcCUnb68NeEWYsvjiE5qhwWOz0dsxZY1y44e9Gp636d4LDDm5+ovJ5Y7z9Zevnvk3vwxYdI7wLNEnsD2UFDq5MtdoWfIz2e+GtvHwfX1osg==
X-Gm-Message-State: AOJu0YyLfnfk5hxPLM0odlm2o3TQfGjjNXj/0+GFLVTYwKVJXPiRT8hv
	TalKRNacympbSsQYCFEFsq7eWQruV/koFpicBMQ6nxpfaQTyaZnqg6tVSvMaTRjQ7ZuaAQe9N/y
	cXcUKAN0SSf3tG5OcJ3bo2IgjTFNehc7Xxwpf8ZaoSwabqncgOIg=
X-Google-Smtp-Source: AGHT+IGf4wdVDNSe9F8sTHDMC/cjLnlVXjyWLYFxWYXRm2kSRwP0f2EzEVpHJ2uhZASUIGetXgmhSfoQf15nQCRa0/A=
X-Received: by 2002:a17:906:9c8e:b0:a46:13d3:e5e6 with SMTP id
 fj14-20020a1709069c8e00b00a4613d3e5e6mr5401892ejc.0.1710167990841; Mon, 11
 Mar 2024 07:39:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307160225.23841-1-lhenriques@suse.de> <20240307160225.23841-4-lhenriques@suse.de>
 <CAJfpegtQSi0GFzUEDqdeOAq7BN2KvDV8i3oBFvPOCKfJJOBd2g@mail.gmail.com>
 <87le6p6oqe.fsf@suse.de> <CAJfpeguN9nMJGJzx8sgwP=P9rJFVkYF5rVZOi_wNu7mj_jfBsA@mail.gmail.com>
 <20240311-weltmeere-gesiegt-798c4201c3f8@brauner>
In-Reply-To: <20240311-weltmeere-gesiegt-798c4201c3f8@brauner>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 11 Mar 2024 15:39:39 +0100
Message-ID: <CAJfpegsn-jMY2J8Wd2Q9qmZFqxR6fAwZ4auoK+-uyxaK+F-0rw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] ovl: fix the parsing of empty string mount parameters
To: Christian Brauner <brauner@kernel.org>
Cc: Luis Henriques <lhenriques@suse.de>, "Theodore Ts'o" <tytso@mit.edu>, 
	Andreas Dilger <adilger.kernel@dilger.ca>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 11 Mar 2024 at 14:25, Christian Brauner <brauner@kernel.org> wrote:

> Yeah, so with that I do agree. But have you read my reply to the other
> thread? I'd like to hear your thoughs on that. The problem is that
> mount(8) currently does:
>
> fsconfig(3, FSCONFIG_SET_FLAG, "usrjquota", NULL, 0) = -1 EINVAL (Invalid argument)
>
> for both -o usrjquota and -o usrjquota=

For "-o usrjquota" this seems right.

For "-o usrjquota=" it doesn't.  Flags should never have that "=", so
this seems buggy in more than one ways.

> So we need a clear contract with userspace or the in-kernel solution
> proposed here. I see the following options:
>
> (1) Userspace must know that mount options such as "usrjquota" that can
>     have no value must be specified as "usrjquota=" when passed to
>     mount(8). This in turn means we need to tell Karel to update
>     mount(8) to recognize this and infer from "usrjquota=" that it must
>     be passed as FSCONFIG_SET_STRING.

Yes, this is what I'm thinking.  Of course this only works if there
are no backward compatibility issues, if "-o usrjquota" worked in the
past and some systems out there relied on this, then this is not
sufficient.
>
> (2) We use the proposed in-kernel solution where relevant filesystems
>     get the ability to declare this both as a string or as a flag value
>     in their parameter parsing code. That's not a VFS generic thing.
>     It's a per-fs thing.

This encourages inconsistency between filesystems, but if there's no
other way to preserve backward compatibility, then...

>
> (3) We burden mount(8) with knowing what mount options are string
>     options that are allowed to be empty. This is clearly the least
>     preferable one, imho.
>
> (4) We add a sentinel such as "usrjquota=default" or
>     "usrjquota=auto" as a VFS level keyword.

I don't really understand how this last one is supposed to fix the issue.

> In any case, we need to document what we want:
>
> https://github.com/brauner/man-pages-md/blob/main/fsconfig.md

What's the plan with these?  It would be good if "man fsconfig" would
finally work.

Thanks,
Miklos

