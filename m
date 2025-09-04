Return-Path: <linux-fsdevel+bounces-60260-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6641B438EA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 12:36:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E55A03BDB58
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 10:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FFFE2F99AA;
	Thu,  4 Sep 2025 10:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="k8EF2jV4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A699E2F747B
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Sep 2025 10:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756982139; cv=none; b=r1Dg/1pMuEFSoL+dF7bMPVGid8CM/n/d77upeOjs2aAXF3qLRF4BN+RfPXNP4uUIsbb6rQGYa9I7++zD2FWTh1fF72O0fmoEtWfmeUXvJzXs4/cY6LhiASZ0+LjxU10hFHGEyrdc2tAJLc5SQ6MJawYlANgbbGSzoRfhwD/o93c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756982139; c=relaxed/simple;
	bh=tWzjEhv9/rxMpJSZAAM3NQw7wWCFIiaxAvsM2aiU140=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AU4dg1BZ6aKSTG+dXXKAvWyB96dEj19VJNZuqBVFJfYBwXMi+4gzd08v1/eiusccHozVrcwJcR6HWVffl3k1yDldNYOSesFSW0R7YwV9xnb9mJjvSSxZt7/iszMz6jRYE8KwvcHUX/0SwO4t4Qa2EMlwEXKjYhh7CD3jfQp7EAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=k8EF2jV4; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4b340966720so6083021cf.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Sep 2025 03:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1756982136; x=1757586936; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sIT1GMxTTZjV+tjvdw2PLkynYW7Friq1YzQm9eXThLM=;
        b=k8EF2jV4RQTPBKEQ7XvNuwlkfwiL9QwGFvGbXiVYxIv75VnVUI1VtGLYCOz+BK25YB
         1Xjyp58jom+qusmqTb46QG2her2LzcA4+XV0PRXBxyrGN5FjGZMglvyBqXQutrBlneSx
         cdLnCfwrA6Gl9Md7BFA/0/h670dg/z8MS1eA8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756982136; x=1757586936;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sIT1GMxTTZjV+tjvdw2PLkynYW7Friq1YzQm9eXThLM=;
        b=FrftdRrQiz9F3R7av6Xzu3lzKf2fXy9ewkVjsP8b+BZLoYxKNAKxjll/pY1ujtqGYU
         2r/819xgTytcZVD8hBo1vfyToCSMqHF7g04VlsDIk92WENZlrebmGTTkmxdLSrKK/Qa0
         buAhanVhSf6FtaxwTTHGU+BciztPabYNswCqcXWeJYlY2xm+4urZkF1y5N1sAOa1UrUy
         MmiaOZw+9bgFDbRoWN1pFL/pMXPzfzD7BK0fttwDn7t6rGgvI4eHmnmkNbK5QhVGc2uC
         LoyzhdYAEF25gFmhtijNzN29d89wYEVv6zXL6dvdr727Enf5gOpr5KNknvPJNZuaWy3E
         9OYg==
X-Forwarded-Encrypted: i=1; AJvYcCX4O3WILAJ/USYYjCTWvSZHuA0l3z/+9hUp532upn0G0aYfB2XMjSPlD0paJ+DaY2SsRgE/fHefVT9HBTq3@vger.kernel.org
X-Gm-Message-State: AOJu0YzBKE0l5CRgE3dWKTMiQ36P7Gu/NXoJFbuKGjYDmMOuV2hBUBuE
	aj+RK5axx6IXjvelMh5bWB/AueLhHw2GHDVvLo/d+FPZ47Rdf3vhhZbSjhcRSAwLaGghVeezSzo
	yRC0ggEhDdnjhNtfWf659w8Gd1lIp0lUpmKKe3YgweA==
X-Gm-Gg: ASbGnctoye0lVIZbiaPdfnA96JQo6dxP5gY1bsDdMzEYH3kVElLa6YAn0gEM3XVaFOx
	PlaEiHaX1WytBXh4pJv8zBTBfQM9pR3+jhwRacZUcaQ0K9AAKVLfgD4PP05t6lXxZL303dAdknV
	wvBUaBHZxtEjFj7qVdYydYLNDqVeQtibgIBAqaIrIbqpwWUobkKp0f0qv/nHR8BNA/FIBN951f9
	KxZgS4INW/ndUIgGU+k
X-Google-Smtp-Source: AGHT+IE8b+WVUyYiDsb3sJ2/++lZTDAoyvJNn+yDWmThqVPmyxuZCjPkXBTY5Q0FEFEIT3NktWO01J553MjTdGLOlSU=
X-Received: by 2002:a05:622a:3d3:b0:4b0:d8b9:22f3 with SMTP id
 d75a77b69052e-4b31da18b0cmr253664021cf.53.1756982136387; Thu, 04 Sep 2025
 03:35:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828162951.60437-1-luis@igalia.com> <20250828162951.60437-3-luis@igalia.com>
In-Reply-To: <20250828162951.60437-3-luis@igalia.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 4 Sep 2025 12:35:25 +0200
X-Gm-Features: Ac12FXwki24EEJbvrrFSSYg1PXao5OhBfkZpU5iyQOXB5Rz6B_OrHnyIr90LObQ
Message-ID: <CAJfpegtmmxNozcevgP335nyZui3OAYBkvt-OqA7ei+WTNopbrg@mail.gmail.com>
Subject: Re: [RFC PATCH v5 2/2] fuse: new work queue to invalidate dentries
 from old epochs
To: Luis Henriques <luis@igalia.com>
Cc: Bernd Schubert <bernd@bsbernd.com>, Laura Promberger <laura.promberger@cern.ch>, 
	Dave Chinner <david@fromorbit.com>, Matt Harvey <mharvey@jumptrading.com>, 
	linux-fsdevel@vger.kernel.org, kernel-dev@igalia.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 28 Aug 2025 at 18:30, Luis Henriques <luis@igalia.com> wrote:
>
> With the infrastructure introduced to periodically invalidate expired
> dentries, it is now possible to add an extra work queue to invalidate
> dentries when an epoch is incremented.  This work queue will only be
> triggered when the 'inval_wq' parameter is set.
>
> Signed-off-by: Luis Henriques <luis@igalia.com>
> ---
>  fs/fuse/dev.c    |  7 ++++---
>  fs/fuse/dir.c    | 34 ++++++++++++++++++++++++++++++++++
>  fs/fuse/fuse_i.h |  4 ++++
>  fs/fuse/inode.c  | 41 ++++++++++++++++++++++-------------------
>  4 files changed, 64 insertions(+), 22 deletions(-)
>
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index e80cd8f2c049..48c5c01c3e5b 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -2033,13 +2033,14 @@ static int fuse_notify_resend(struct fuse_conn *fc)
>
>  /*
>   * Increments the fuse connection epoch.  This will result of dentries from
> - * previous epochs to be invalidated.
> - *
> - * XXX optimization: add call to shrink_dcache_sb()?

I guess it wouldn't hurt.   Definitely simpler, so I'd opt for this.

>  void fuse_conn_put(struct fuse_conn *fc)
>  {
> -       if (refcount_dec_and_test(&fc->count)) {
> -               struct fuse_iqueue *fiq = &fc->iq;
> -               struct fuse_sync_bucket *bucket;
> -
> -               if (IS_ENABLED(CONFIG_FUSE_DAX))
> -                       fuse_dax_conn_free(fc);
> -               if (fc->timeout.req_timeout)
> -                       cancel_delayed_work_sync(&fc->timeout.work);
> -               if (fiq->ops->release)
> -                       fiq->ops->release(fiq);
> -               put_pid_ns(fc->pid_ns);
> -               bucket = rcu_dereference_protected(fc->curr_bucket, 1);
> -               if (bucket) {
> -                       WARN_ON(atomic_read(&bucket->count) != 1);
> -                       kfree(bucket);
> -               }
> -               if (IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
> -                       fuse_backing_files_free(fc);
> -               call_rcu(&fc->rcu, delayed_release);
> +       struct fuse_iqueue *fiq = &fc->iq;
> +       struct fuse_sync_bucket *bucket;
> +
> +       if (!refcount_dec_and_test(&fc->count))
> +               return;

Please don't do this.  It's difficult to see what actually changed this way.

Thanks,
Miklos

