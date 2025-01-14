Return-Path: <linux-fsdevel+bounces-39120-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F52A1023E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 09:39:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F779166068
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 08:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D84F3DABE8;
	Tue, 14 Jan 2025 08:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="dI6MpSbr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19862500BD
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jan 2025 08:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736843943; cv=none; b=UPXIuSylmNplyAGrmSD8USYGLNxP3L74D7IWg162UNJPtomL5YD1/QHKNPZog3vXq/4CwZR/2RjI66PUQG42pZ+s+qZRJ3ssi9AO05rQRWkHOReHr4YudngYPgSF4cesPCbRTzIsljxRv5Onee6U19+n9kAjac7EIY9Y55sa5Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736843943; c=relaxed/simple;
	bh=AA3a5lQ28Qzg+T5Ly1w11cJxc9xXvuRMLoCNx1APCV4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mh9PJ2oDP1Z+wTmJ1DkxFyJVMuj4PuVIm14I9Sm4aaCHfT549fnolbKAyZ/okzI4mAOUw5bfR69wFH3Z2LeDIy0XWwZRynb/IcKqurCz+arcKof3Hb1uBUl4tgRJjtrQurOBgAmwsNa5XVvxPOF8Xv6FrJLMoEbSaN4wyOwwVqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=dI6MpSbr; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4678664e22fso50301551cf.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jan 2025 00:39:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1736843939; x=1737448739; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/9gXrJEdxE9BES3C0tahnLqshk2xWlO7dk0aSnzTxp4=;
        b=dI6MpSbrQSr9V62mO8Mwef2A9JJoxEYc9ZE1py5Vi5xge/c5Luq5FXXFsKqlsrV4X8
         90+uJQJID7Y0RwpkcSxHj2RW3xYmw5XMh52GA1l1lCuuQbTjjH/piIt4FhGDbQqhYLfV
         gENyrr4Flqx7R0hsDDnxsb/lo2H+e04dhhj0Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736843939; x=1737448739;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/9gXrJEdxE9BES3C0tahnLqshk2xWlO7dk0aSnzTxp4=;
        b=CpTE86pu6+w48Mxvuvi9G8qro2DJvzTN6gWQntKpsa7RKEVa+LxZ+baNME+9+//zxC
         Kb7Ux8SsOsUaPA31m6yUB2+M7AMbc01UVNTu0e/TX2k76E7oAd+jqPKH4pUC1XgV1/oj
         TWWdi9GTG0hAXY3KkdyHPyWKGq+FAOtJkKJ2thYy1YyJbqjwOm54Bsfb4+E831ZN4grk
         mOJxgwlJWT4QAlpfoOATbN+p9YtZgIIk2RgqhYbchjk5DlDpk5TOd5UqXqe+kM92Imuk
         /zJ3PlQxCeNoQo2OcnMIkdSwEsqg2Dw/xQB6um3OI9g2/6yxM+ZGztYldFB54Z8WyPAz
         SfGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEBhuJHiB+oxhcImRTSVxSS21Ng90xoHs3kI8u7FSC2Mji2X16+m0p4XUfFeiSyXaUL+NgSsSO+UvqXLIx@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5z/Bn9YvNsky3bVQcRQIRtnwPdfL5YoNi8LdFlQmh+tufewsI
	vlJrh25mOtSvf25TwmNrj+jQNCn7FCT90xVPOFqDZrBVaggNzjSzeRhc4BFLacsERUq2HTYa8Lp
	BOjUNfgEj4FkW/6Rq062+qc6bF6TnLcwxEDKdlA==
X-Gm-Gg: ASbGncsAkYW9FjdUTl9YD+8qcY4wrnIMWyiDQOWsDN2A4lB0iaRdAeyCSJyPM5rhVMO
	USueH9PpMhaxJ5ON4uqZFUl4++1rU5q8fiGah
X-Google-Smtp-Source: AGHT+IEJKDfnmsXjSbFk5D88FYMeWl9RkltEjwsUS/7pNDJcXGKcBjcxurJLDulzVtLc0VGVXfFFxYlJlx5xsv+P8Ng=
X-Received: by 2002:a05:622a:180c:b0:467:4fc5:9d72 with SMTP id
 d75a77b69052e-46c710e4d0bmr411318271cf.36.1736843939597; Tue, 14 Jan 2025
 00:38:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <hftauqdz22ujgkkgrf6jbpxuubfoms42kn5l5nuft3slfp7eaz@yy6uslmp37pn>
 <CAJnrk1aPCCjbKm+Ay9dz3HezCFehKDfsDidgsRyAMzen8Dk=-w@mail.gmail.com>
 <c04b73a2-b33e-4306-afb9-0fab8655615b@redhat.com> <CAJfpegtzDvjrH75oXS-d3t+BdZegduVYY_4Apc4bBoRcMiO-PQ@mail.gmail.com>
 <gvgtvxjfxoyr4jqqtcpfuxnx3y6etbgxfhcee25gmoiagqyxkq@ejnt3gokkbjt>
 <791d4056-cac1-4477-a8e3-3a2392ed34db@redhat.com> <plvffraql4fq4i6xehw6aklzmdyw3wvhlhkveneajzq7sqzs6h@t7beg2xup2b4>
 <1fdc9d50-584c-45f4-9acd-3041d0b4b804@redhat.com> <54ebdef4205781d3351e4a38e5551046482dbba0.camel@kernel.org>
 <ccefea7b-88a5-4472-94cd-1e320bf90b44@redhat.com> <e3kipe2qcuuvyefnwpo4z5h4q5mwf2mmf6jy6g2whnceze3nsf@uid2mlj5qfog>
 <2848b566-3cae-4e89-916c-241508054402@redhat.com> <dfd5427e2b4434355dd75d5fbe2460a656aba94e.camel@kernel.org>
In-Reply-To: <dfd5427e2b4434355dd75d5fbe2460a656aba94e.camel@kernel.org>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 14 Jan 2025 09:38:48 +0100
X-Gm-Features: AbW1kva92yO2fTIr2fmGoiS8vGjhFf6j-l_b4bVMDNUI_zrX-XtZj908q4CRcag
Message-ID: <CAJfpegs_YMuyBGpSnNKo7bz8_s7cOwn2we+UwhUYBfjAqO4w+g@mail.gmail.com>
Subject: Re: [PATCH v6 4/5] mm/migrate: skip migrating folios under writeback
 with AS_WRITEBACK_INDETERMINATE mappings
To: Jeff Layton <jlayton@kernel.org>
Cc: David Hildenbrand <david@redhat.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Joanne Koong <joannelkoong@gmail.com>, Bernd Schubert <bernd.schubert@fastmail.fm>, 
	Zi Yan <ziy@nvidia.com>, linux-fsdevel@vger.kernel.org, jefflexu@linux.alibaba.com, 
	josef@toxicpanda.com, linux-mm@kvack.org, kernel-team@meta.com, 
	Matthew Wilcox <willy@infradead.org>, Oscar Salvador <osalvador@suse.de>, 
	Michal Hocko <mhocko@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 13 Jan 2025 at 22:44, Jeff Layton <jlayton@kernel.org> wrote:

> What if we were to allow the kernel to kill off an unprivileged FUSE
> server that was "misbehaving" [1], clean any dirty pagecache pages that
> it has, and set writeback errors on the corresponding FUSE inodes [2]?
> We'd still need a rather long timeout (on the order of at least a
> minute or so, by default).

How would this be different from Joanne's current request timeout patch?

I think it makes sense, but it *has* to be opt in, for the same reason
that NFS soft timeout is opt in, so it can't really solve the page
migration issue generally.

Also page reading has exactly the same issues, so fixing writeback is
not enough.

Maybe an explicit callback from the migration code to the filesystem
would work. I.e. move the complexity of dealing with migration for
problematic filesystems (netfs/fuse) to the filesystem itself.  I'm
not sure how this would actually look, as I'm unfamiliar with the
details of page migration, but I guess it shouldn't be too difficult
to implement for fuse at least.

Thanks,
Miklos






>
> Would that be enough to assuage concerns about unprivileged servers
> pinning pages indefinitely? Buggy servers are still a problem, but
> there's not much we can do about that.
>
> There are a lot of details we'd have to sort out, so I'm also
> interested in whether anyone (Miklos? Bernd?) would find this basic
> approach objectionable.
>
> [1]: for some definition of misbehavior. Probably a writeback
> timeout of some sort but maybe there would be other criteria too.
>
> [2]: or maybe just make them eligible to be cleaned without talking to
> the server, should the VM wish it.
> --
> Jeff Layton <jlayton@kernel.org>

