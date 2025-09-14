Return-Path: <linux-fsdevel+bounces-61261-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 021A7B56BFC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Sep 2025 22:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C5161889B48
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Sep 2025 20:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288702E03E6;
	Sun, 14 Sep 2025 20:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="GL0pMDkb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69DDEEAB
	for <linux-fsdevel@vger.kernel.org>; Sun, 14 Sep 2025 20:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757880365; cv=none; b=LVfbvoof9lbmlSI57rOK3+1zfNa/RcyTqeCwn1db5SHNWC7LB3KZvOZQxdJbBYbezU+wsJ3xvmonTNBQL/gbW1u65F41yZ9O2WutpXgI+8CtcJDLXe7G8lAlWZTGt/6lUW3Bv0lU84WijscoZBkUQxm1tI/PBI2ykt9cDyjxi/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757880365; c=relaxed/simple;
	bh=O2E38b2gWRqW0Vi030UMpP30jobKbv8OXvPxaD4mpXM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k66om7FaFRXFRoLVtUUtc6grZ6GdTXty3yq3n72NQ+PcHWUu76O2ZWd3Ia7c6mqzlxIcJG+54/dIanJ8GIgYJ22FnHkCdh5Qrjk1OhzOaCOJStm59UcAtZuanfoUj/AZjSgnV5wPcoipvrF6YxA6vreXv/UXo10oPAHKZU9b8sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=GL0pMDkb; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4b61161c32eso45411621cf.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 14 Sep 2025 13:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1757880360; x=1758485160; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1z1fCVgvl4byzHmGxYYNwDcVgiTn8VRZpWic0P+h9Rw=;
        b=GL0pMDkbIygIUvcW7U7gNU2tNZV+tI+bbT66q8jlS7SfnUTc4LzodEiu8lsBKZBPbA
         5pmjWhOhFlnt40kSukFJsk8reaGRpEj1FJbySB4K59nAjfn4JbMpDZOMHYhkxnIjWnrJ
         1KzpiInk3MEVmSfGprcKqmQ4oeSJhju9aQy8A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757880360; x=1758485160;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1z1fCVgvl4byzHmGxYYNwDcVgiTn8VRZpWic0P+h9Rw=;
        b=vLgfynidggB3SWF+N+xwqA5QZIFP7sF6j0wWpB426j1FYNYnefMDInE24y6wr+MLsM
         +zlfhhL445DSPB+uAWXVxYtk3B1J4qGdrf5NNEJ7FFVyj3d2CCxzUF9CPlt/n6wbwHQn
         pdV96JxvFnrH0vRoWrG0Bf8YSwgnlWw0R0nhy5Oq5ZDYTKXsyuetLcW/wujk7mbYBcrd
         MPKBdodEVFEa8NL3M/knAPOeKq1pSALEo1ChRprHhfFePzAHOZE1/v7aVq+SqUFaO+kZ
         CVkIstM5wrByyl8K0VYViXM6g0klQV8quFP7Y0aE73NmO3lhNIKHzd/68c8gzO7jhrwB
         gQ1g==
X-Forwarded-Encrypted: i=1; AJvYcCXxE/4SgAClJA57tWc7KhR+/AyjNavTPDw5VvDjr4qf6OaX9J92JPuHjZoT9I+NGTqOm24CAJop9VV8ZEoT@vger.kernel.org
X-Gm-Message-State: AOJu0YzlJ3VpI+5+0BkEEDHDOd9+tYg8Jh8YdXVk5fzN4xfru6LE1tzE
	xSzqtHa5PV6nLB89otioL9Al9bVi3tSo/tOUgzcr36f1w7p2dzJYaOPm/XQCG76jQ2lcUB8kZq+
	/obPMxZ42fBUPDNbkvu157eJ6vYe+tiqWMd1nQuZ1sg==
X-Gm-Gg: ASbGnctMlGTFY/tKSLuEApHCGWQUuwmi7h2Hasrg0OHLRbaRWL3m28IpiuYcFmAhdxh
	lwhEPUJXXgIQLHSbLtXd7ZOKUHdc1x7hio4S6YFbO434CeZz2IFA//Xcx+ga5TJIO5VCrJ8Cm1A
	OhnFbn36FvUlE/fcOE6StYpONoqoNZg0M5AVJLPVHU7LQhJH7nWl4iQ/alEUcmeRgyj8oB/QGne
	+oYG6OiKuAaRBotIGLngWZf7BX3l2KQavhUIB8IAQ==
X-Google-Smtp-Source: AGHT+IGQBh29oNO0tCL3/EIb7G9EXGs5VjxWj6e+XiFKB3nyQuOTj0KAe+zCRTjm3jtCaEOUGJZm7EiTdJYRoDP6TSY=
X-Received: by 2002:a05:622a:4c88:b0:4b5:e979:6236 with SMTP id
 d75a77b69052e-4b77d013259mr119756111cf.14.1757880360431; Sun, 14 Sep 2025
 13:06:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908090557.GJ31600@ZenIV> <175747234137.2850467.15661817300242450115@noble.neil.brown.name>
 <20250910072423.GR31600@ZenIV> <20250912054907.GA2537338@ZenIV>
 <CAJfpeguqygkT0UsoSLrsSMod61goDoU6b3Bj2AGT6eYBcW8-ZQ@mail.gmail.com>
 <20250912182936.GY39973@ZenIV> <175773460967.1696783.15803928091939003441@noble.neil.brown.name>
 <20250913050719.GD39973@ZenIV> <CAJfpegvXtXY=Pbxv+dMGFR8mvWN0DUwhSo6NwaVexk6Y6sao+w@mail.gmail.com>
 <20250914195034.GI39973@ZenIV>
In-Reply-To: <20250914195034.GI39973@ZenIV>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Sun, 14 Sep 2025 22:05:49 +0200
X-Gm-Features: Ac12FXx4AY3mopS5XligWPHtmScLzk1MY3PJjZ7I7z5oJQcbKoRwjkrl3UCytU8
Message-ID: <CAJfpegvD7Ch59LJi8ymB6yX2TNMpQxVRLZ3xvsGLbsrktQ88_A@mail.gmail.com>
Subject: Re: ->atomic_open() fun (was Re: [RFC] a possible way of reducing the
 PITA of ->d_name audits)
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: NeilBrown <neil@brown.name>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>, 
	Bernd Schubert <bernd@bsbernd.com>
Content-Type: text/plain; charset="UTF-8"

On Sun, 14 Sept 2025 at 21:50, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Sun, Sep 14, 2025 at 09:01:40PM +0200, Miklos Szeredi wrote:

> > - cached positive (plain or O_CREAT): FUSE_OPEN_REVAL getting nodeid
> > of parent + name + nodeid of child and return opened file or -ESTALE,
> > no locking required
>
> What happens if the latter overlaps with rename?  Or, for a cached
> directory inode, with lookup elsewhere picking the same inode as our
> cached (and possibly invalid, but we don't know that) dentry?

In the overlapping rename case either result is okay: if the open
succeeded, that means open won the race against rename.  If on the
other hand open_reval lost and didn't find the expected child, then
dentry is going to get invalidated and the whole thing retried ending
up with open_atomic or open_creat with no further races possible.

With the stale dentry getting moved by d_splice_alias() it's a
slightly different story.  The dentry starts out stale, but by being
moved to its proper place it becomes uptodate again.  So before
invalidating it, it would make sense to check whether the parent and
the name still matches the one we are looking up.   But that race
happens with plain ->d_revalidate() as well AFAICS, so that wouldn't
be a new thing.

Thanks,
Miklos

