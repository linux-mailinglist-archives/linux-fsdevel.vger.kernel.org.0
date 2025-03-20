Return-Path: <linux-fsdevel+bounces-44569-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F8EA6A6DC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 14:07:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F84716DFC4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Mar 2025 13:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE721DF247;
	Thu, 20 Mar 2025 13:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J4tQQU3P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C4129A1;
	Thu, 20 Mar 2025 13:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742475983; cv=none; b=V9ZegP2f2emBYng6Rw61V1mFiy1sqK44tYHtYyoLVpsoMhyNy4iCEnMmXj0apCMTLwuF9kXxzNEFxZhaOJJ0rj/uwf7SFNky5cHTF5nnZ9lveoIm5e18/LubMc49J2FPfI+gFktgHVd2r6f3FGJ4IELzhPYc2oC8lh7m/6lCHNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742475983; c=relaxed/simple;
	bh=tcq3Zpp8Cjo3AgGj7Pb+Yz8TsC7q7a54VIwoPlnJTwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GMihnH+N54lXGJZDwauqGsgwsyXi6Mx13RcmZ8dJr0a6TU+0jmZ0COCJSH8uBENhEYTSwsTuua89iWHw2ETwsHZnVrsZUuPTqqWaGuWBw4LBp92nSNTWhG8mNGuvuph2QeMmSLO9MtzDeb9BnXP6r0lhILhCd/SHc+9WtTUJ7w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J4tQQU3P; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5fcef5dc742so191255eaf.1;
        Thu, 20 Mar 2025 06:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742475980; x=1743080780; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ygMKS1E4qG7XXUm9+PlSPlMx++048YekvAsHTICfd2g=;
        b=J4tQQU3PiNTHa5T/VgVdMAnxFP6b5U6E2vCO3a/cEKYtMOXchib/DO4PS4NbTfjNN1
         xz6/fdYA7TFlLN9T79QA/JLqnJmx1aMtIbPlWSm9ETCg/YdexlIM4aHGh+xpn9qh1xww
         jTTzx8YGjE77LjBGispuxr3yx40qSNVbyebXW/CPUTCbDNU2xek5N04YudF3oO5jPGxd
         avn5usaYfVWfGdsKfwxQhdaiNMTLPboKf08G3U75EsqCsYFkadjvPGXIxoh+f99YQhs4
         ozMgsw0sn67JXhOsK25Qkaw3qOKmkwqjIRSG9KyAYtQUhpTt4UisXkh/3cCjvvWbPZ72
         +pNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742475980; x=1743080780;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ygMKS1E4qG7XXUm9+PlSPlMx++048YekvAsHTICfd2g=;
        b=NTVqe42kD+tS9gFi6V6e3YQfMzjS9G+D3sR3dVHFChcWRWJCDpoApEIyKaSOU70Lkf
         dx75v0LRhyiH+DioAQL6mm72Dua4VhcoiAZkwMhvzi/IFTIpf+yGTGPbkigfMfv/mhfR
         jtLQAC/Je8HJ6dCeqzL4BJ3uMRCLwNLZxFBZBiA2sKlOR5gZKXdX6oS9d1HOCBEut/vW
         hhJALWWdUat1pAKK1EEMwusPD/nNh73gBQSBCjiukCDDzpeOVt0Zj0tTe3i+QmHwbnZs
         46bnt/lACO0r4MkGfEwrmF7nLLoXeWBTel3bEHVlKIYI5hOUnRA/zhJZx0P6VpWFSUvr
         +Zkg==
X-Forwarded-Encrypted: i=1; AJvYcCUFSxHz8qaEZeCYdANPIewg8CnWUEwaqWApmvw3dgcterSHpwuN42sF7KIo37dV1rSWIcfDgTIZSgsku+jcBg==@vger.kernel.org, AJvYcCWsXk730e+VxfgrhfZbOijp/RAEaBXp+vi2+K/6PYpxLAKG1iEEIF40bYEhCxEuzQlDaWd5F6rFoDM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+txZ0twHt8u7Qnh29anqLA15YyDtMXVJ70JpMMoAMooiOtKAf
	WHTcgN3tW0Him/qIvgKJ21unEOTUfm1gIByO85Ox095RDtmXzTnL
X-Gm-Gg: ASbGnctGaNZmS/YJOB9pX1Lepkz1YH7z1jLeefAMH1/Q1q8ZYarDNoimJshIjvMOXvK
	EQYP8UqCQ6xo8V8vTPJzAtC72JhlCFbw7OYsX2slgBA7PyN4JEujX2XiXbQAYu5jFHC3s032mRh
	Q+jSTg1kMM3rfBR9yGc/AP5HuNymh3p+p6GV7xP53Pp7dRlmrxkVB946GUbQm+mIyr/9o3lJqXq
	YmKBjFI+ejNhRB+JUPN0WyKPBD61gp2BFnxeGVx4qw0MbD2vAQqHX7UtEmEjENv+p21jzDISpY0
	fCbsaGyjIpSstEJfyGwWIoh40Klf3IBmvYVwfUXSUQQ6YS2Sm1TvOhc4
X-Google-Smtp-Source: AGHT+IGwV/c5mK56KHQxiHSoNgxmTQNI/mLVJS2gCgNQJZUDy/VIz4gmSfPgUjFHygDx7IJsokEffQ==
X-Received: by 2002:a4a:cb17:0:b0:602:2e4f:94f3 with SMTP id 006d021491bc7-6022e4f9a49mr581029eaf.2.1742475979896;
        Thu, 20 Mar 2025 06:06:19 -0700 (PDT)
Received: from Borg-550 ([2603:8080:1500:3d89:30eb:b380:b0a9:db6a])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-601db69d4dbsm3012548eaf.19.2025.03.20.06.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 06:06:19 -0700 (PDT)
Sender: John Groves <grovesaustin@gmail.com>
Date: Thu, 20 Mar 2025 08:06:17 -0500
From: John Groves <John@groves.net>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, 
	Amir Goldstein <amir73il@gmail.com>, Bernd Schubert <bernd.schubert@fastmail.fm>, 
	Stefan Hajnoczi <shajnocz@redhat.com>, Josef Bacik <josef@toxicpanda.com>, 
	John Groves <jgroves@micron.com>, linux-fsdevel@vger.kernel.org, linux-cxl@vger.kernel.org, 
	Aravind Ramesh <arramesh@micron.com>, Ajay Joshi <ajayjoshi@micron.com>, 
	Eishan Mirakhur <emirakhur@micron.com>
Subject: Re: famfs port to fuse - questions
Message-ID: <eqcigeptla4obqqaix737tfqmkjdet3fzmq2kqttm5etab2us5@vqignnrha2m5>
References: <20250224152535.42380-1-john@groves.net>
 <CAJnrk1bJ5jE5qWdRju6xz+DipYHUrj8w4PdL80J1M6ujMxXJ1g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1bJ5jE5qWdRju6xz+DipYHUrj8w4PdL80J1M6ujMxXJ1g@mail.gmail.com>

On 25/02/24 03:40PM, Joanne Koong wrote:
> On Mon, Feb 24, 2025 at 7:25 AM John Groves <John@groves.net> wrote:
> >
> > Miklos et. al.:
> >
> > Here are some specific questions related to the famfs port into fuse [1][2]
> > that I hope Miklos (and others) can give me feedback on soonish.
> >
> > This work is active and serious, although you haven't heard much from me
> > recently. I'm showing a famfs poster at Usenix FAST '25 this week [3].
> >
> > I'm generally following the approach in [1] - in a famfs file system,
> > LOOKUP is followed by GET_FMAP to retrieve the famfs file/dax metadata.
> > It's tempting to merge the fmap into the LOOKUP reply, but this seems like
> > an optimization to consider once basic function is established.
> >
> > Q: Do you think it makes sense to make the famfs fmap an optional,
> >    variable sized addition to the LOOKUP response?
> >
> > Whenever an fmap references a dax device that isn't already known to the
> > famfs/fuse kernel code, a GET_DAXDEV message is sent, with the reply
> > providing the info required to open teh daxdev. A file becomes available
> > when the fmap is complete and all referenced daxdevs are "opened".
> >
> > Q: Any heartburn here?
> >
> > When GET_FMAP is separate from LOOKUP, READDIRPLUS won't add value unless it
> > receives fmaps as part of the attributes (i.e. lookups) that come back in
> > its response - since a READDIRPLUS that gets 12 files will still need 12
> > GET_FMAP messages/responses to be complete. Merging fmaps as optional,
> > variable-length components of the READDIRPLUS response buffers could
> > eventualy make sense, but a cleaner solution intially would seem to be
> > to disable READDIRPLUS in famfs. But...
> >
> 
> Hi John,
> 
> > * The libfuse/kernel ABI appears to allow low-level fuse servers that don't
> >   support READDIRPLUS...
> > * But libfuse doesn't look at conn->want for the READDIRPLUS related
> >   capabilities
> > * I have overridden that, but the kernel still sends the READDIRPLUS
> >   messages. It's possible I'm doing something hinky, and I'll keep looking
> >   for it.
> 
> On the kernel side, FUSE_READDIR / FUSE_READDIRPLUS requests are sent
> in fuse_readdir_uncached(). I don't see anything there that skips
> sending readdir / readdirplus requests if the server doesn't have
> .readdir / .readdirplus implemented. For some request types (eg
> FUSE_RENAME2, FUSE_LINK, FUSE_FSYNCDIR, FUSE_CREATE, ...), we do track
> if a request type isn't implemented by the server and then skip
> sending that request in the future (for example, see fuse_tmpfile()).
> If we wanted to do this skipping for readdir as well, it'd probably
> look something like
> 
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -870,6 +870,9 @@ struct fuse_conn {
>         /* Is link not implemented by fs? */
>         unsigned int no_link:1;
> 
> +       /* Is readdir/readdirplus not implemented by fs? */
> +       unsigned int no_readdir:1;
> +
>         /* Use io_uring for communication */
>         unsigned int io_uring;
> 
> diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
> index 17ce9636a2b1..176d6ce953e5 100644
> --- a/fs/fuse/readdir.c
> +++ b/fs/fuse/readdir.c
> @@ -341,6 +341,9 @@ static int fuse_readdir_uncached(struct file
> *file, struct dir_context *ctx)
>         u64 attr_version = 0, evict_ctr = 0;
>         bool locked;
> 
> +       if (fm->fc->no_readdir)
> +               return -ENOSYS;
> +
>         folio = folio_alloc(GFP_KERNEL, 0);
>         if (!folio)
>                 return -ENOMEM;
> @@ -376,6 +379,8 @@ static int fuse_readdir_uncached(struct file
> *file, struct dir_context *ctx)
>                         res = parse_dirfile(folio_address(folio), res, file,
>                                             ctx);
>                 }
> +       } else if (res == -ENOSYS) {
> +               fm->fc->no_readdir = 1;
>         }
> 
>         folio_put(folio);
> 
> > * When I just return -ENOSYS to READDIRPLUS, things don't work well. Still
> >   looking into this.
> >
> > Q: Do you know whether the current fuse kernel mod can handle a low-level
> >    fuse server that doesn't support READDIRPLUS? This may be broken.
> 
> From what I see, the fuse kernel code can handle servers that don't
> support readdir/readdirplus. The fuse readdir path gets invoked from
> file_operations->iterate_shared callback, which from what i see, the
> only ramification of this always returning an error is that the
> syscalls calling into this (eg getdents(), readdir()) fail.

Thanks for doing some of the digging Joanne. I'm not sure what was going wrong
a few weeks ago when I initially disabled readdirplus, but I have it working 
now - in fact I now have famfs "fully" working under fuse (for some definition
of fully ;).

I have a gnarly rebase plus some documentation to write, but I may go ahead 
and share branches this week, in case anybody wants to take a look. That will
be a fuse kernel branch, and a famfs user space branch...

Also: any plans for a fuse BOF at LSFMM?

<snip>

Thanks,
John


