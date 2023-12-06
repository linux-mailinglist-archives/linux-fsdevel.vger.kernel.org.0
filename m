Return-Path: <linux-fsdevel+bounces-4989-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ABCC3806FF3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 13:38:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 563D31F21215
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 12:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2AB636AE4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 12:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Akaf99O5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE62210B
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Dec 2023 03:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701860726;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ty0j+r5L+r6LT8rFnUkaIbcoEHNkHsvnWoF/ZMGSfD0=;
	b=Akaf99O5MGQIAGonsWLHytp5FFv5ftjTh+QrGS1r8lP6K8XE7FqVzgDd7skURUK7SwqHr9
	2QqlJDzBkLGlcDtyoKi+MCr9xRgVVqYiR/TAxho0dgAT0EXXX9BTvfYXaVRDu2dhE8Za1v
	gZof2LWolrLzAQz7DbhEn8RP6Txm2pU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-542-h578pkMkOqmLT8vInGhnRA-1; Wed, 06 Dec 2023 06:05:23 -0500
X-MC-Unique: h578pkMkOqmLT8vInGhnRA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6496685A58A;
	Wed,  6 Dec 2023 11:05:22 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.39.192.186])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 162A23C2E;
	Wed,  6 Dec 2023 11:05:19 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: libc-alpha@sourceware.org,  linux-man <linux-man@vger.kernel.org>,
  Alejandro Colomar <alx@kernel.org>,  Linux API
 <linux-api@vger.kernel.org>,  linux-fsdevel@vger.kernel.org,  Karel Zak
 <kzak@redhat.com>,  Ian Kent <raven@themaw.net>,  David Howells
 <dhowells@redhat.com>,  Christian Brauner <christian@brauner.io>,  Amir
 Goldstein <amir73il@gmail.com>,  Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC] proposed libc interface and man page for listmount
References: <CAJfpeguMViqawKfJtM7_M9=m+6WsTcPfa_18t_rM9iuMG096RA@mail.gmail.com>
Date: Wed, 06 Dec 2023 12:05:18 +0100
In-Reply-To: <CAJfpeguMViqawKfJtM7_M9=m+6WsTcPfa_18t_rM9iuMG096RA@mail.gmail.com>
	(Miklos Szeredi's message of "Tue, 5 Dec 2023 17:27:58 +0100")
Message-ID: <87cyvjd21d.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

* Miklos Szeredi:

> Attaching the proposed man page for listing mounts (based on the new
> listmount() syscall).
>
> The raw interface is:
>
>        syscall(__NR_listmount, const struct mnt_id_req __user *, req,
>                   u64 __user *, buf, size_t, bufsize, unsigned int, flags);
>
> The proposed libc API is.
>
>        struct listmount *listmount_start(uint64_t mnt_id, unsigned int flags);
>        uint64_t listmount_next(struct listmount *lm);
>        void listmount_end(struct listmount *lm);
>
> I'm on the opinion that no wrapper is needed for the raw syscall, just
> like there isn't one for getdents(2).

We do have a wrapper for getdents64.  It's useful because if you modify
the directory, you care about the buffer boundary because you should
rewind after processing the current buffer.  The inotify facility also
exposes a sequence of variably sized objects to applications, but does
not add a new system call for that.  That's just an aside, though.

The existing functions dealing with /proc/mounts or /etc/fstab are
called setmntent, getmntent or getmntment_r (the former with a bad
implementation, the latter with a bad interface), and endmntent.  This
follows the pattern of NSS enumeration interfaces, except that in the
mntent case, there is an explicit file handle, so a thread-safe
implementation is possible in principle.  Your proposed interface is
similar, so that's good.

I would also like to see a comment from the Hurd folks.  Presumably they
have something similar already for enumerating translators?

Thanks,
Florian


