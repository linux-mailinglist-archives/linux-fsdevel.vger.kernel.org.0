Return-Path: <linux-fsdevel+bounces-29452-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 705A5979F49
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 12:29:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3E5EB23440
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 10:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A553215359A;
	Mon, 16 Sep 2024 10:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="AxCEpHgr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5213C08A
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Sep 2024 10:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726482537; cv=none; b=F48xcg+z74755sb/gBe/nJ3nbYmG9cik5tiSDwThtFujufzIksqECuBF6xlHn9zsJ+rVg9BstW+R3+HTr/o3PFhimqLnoBOZEW/aPsDQJfu421H37tQDwkHkEKgfIULAwgd6rp3Y4q3JsXoL6FGzc/hxK00VhTkQ9DwxTIXRn34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726482537; c=relaxed/simple;
	bh=D5CZrjNgcChYL3iYE7wadLaQ/c90wkXnGENz6hSZIJM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uiu+c2jpA40ayXCXlutcz8KI+pPYardTg37Tg+gzEdttyTLJ4EF9kmWrkE5ZOnXBVGUb5T4JWsUKzy40m4C0OSPALARYBEWNriTm8+rBOnozGoX6e66OYrAqnVYHoDdPJ/7Ls//Eu+KK7leVHD9oTTOesDhPe34ERxbNJomntmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=AxCEpHgr; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5c241feb80dso9994157a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Sep 2024 03:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1726482533; x=1727087333; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=StiAmGsUSDtAU0OuSvbZ9L4xqSIPeTrrqj9iN3b3S3s=;
        b=AxCEpHgr0li6L8bkLigDNP3mtU6e/GC715zScIVN0tW6+/ScvCnNV6Fjhfe5PSes2w
         lqHFLysr8jGJP5DxzyGo7BQxWuqJY/tA2bwQX6utWemtMh9dKS5juRVp+97kPTuI8Y5Z
         YM/+VrA01qxB+q3TEFrW7vY2V+Fg9dn6XkS+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726482533; x=1727087333;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=StiAmGsUSDtAU0OuSvbZ9L4xqSIPeTrrqj9iN3b3S3s=;
        b=HU1Hp4FnbKVNPfDcCHfat/ohal1HlYalQwbJfODzC5uYxVgINUE4Fgtg6KcOTW3ZL1
         iq/PsdY1c2lUweLibooqvKX3Y10iewzeRtBYU4+rrAf6WFwjmQ68EuNZdq2iZ/PIJ7WV
         7R0+0jKWH4APPzp4VdXFdICiVyTpVeU1zyVhg1OtImORCDyqk3oQY20f+uSfP3rR+j3f
         Zr9dw1GamfoTL+WKS+m9kzlBX+Z/VOCpMku6JJK1+UPqcBJaPBaKNY7pellEO+tgEflQ
         HYbedX68kM8CBtv7sQgzZ5mJrvsyby75RmZfRAl8A3ipjvjM7ih68Er5cjHC3ijdSLTy
         GOkQ==
X-Gm-Message-State: AOJu0Yyvxj/HZ0XgCxoEosblYHWpHEPYI/wwtLJf4cRapZ55Ppmp+LOl
	dneqODVUdLy/dW8fVG/kSY7QT3YB0SzHEAiN+xxNGW93vgloDn0873SGLl/cuiTPMRGN4/jXi30
	c4zzZlQ==
X-Google-Smtp-Source: AGHT+IGRwunaEr6joUSJCL9G60JZUXjmHo7g/4yUV/qfrd5o8W+UyONxjOx8lxkF9Stx2gGkKBq3TQ==
X-Received: by 2002:a17:907:3f26:b0:a87:370:8dfc with SMTP id a640c23a62f3a-a902a47871dmr1549292766b.14.1726482532588;
        Mon, 16 Sep 2024 03:28:52 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9061321568sm292842366b.191.2024.09.16.03.28.51
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Sep 2024 03:28:51 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5c24ebaa427so7860401a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Sep 2024 03:28:51 -0700 (PDT)
X-Received: by 2002:a05:6402:d06:b0:5c3:d8fb:df6a with SMTP id
 4fb4d7f45d1cf-5c414383763mr16736442a12.14.1726482530833; Mon, 16 Sep 2024
 03:28:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240913-vfs-netfs-39ef6f974061@brauner>
In-Reply-To: <20240913-vfs-netfs-39ef6f974061@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 16 Sep 2024 12:28:34 +0200
X-Gmail-Original-Message-ID: <CAHk-=wjr8fxk20-wx=63mZruW1LTvBvAKya1GQ1EhyzXb-okMA@mail.gmail.com>
Message-ID: <CAHk-=wjr8fxk20-wx=63mZruW1LTvBvAKya1GQ1EhyzXb-okMA@mail.gmail.com>
Subject: Re: [GIT PULL] vfs netfs
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Howells <dhowells@redhat.com>, Steve French <stfrench@microsoft.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 13 Sept 2024 at 18:57, Christian Brauner <brauner@kernel.org> wrote:
>
> /* Conflicts */
>
> Merge conflicts with mainline

Hmm.

My conflict resolution is _similar_, but at the same time decidedly
different. And I'm not sure why yours is different.

> --- a/fs/smb/client/cifssmb.c
> +++ b/fs/smb/client/cifssmb.c
> @@@ -1261,16 -1261,6 +1261,14 @@@ openRetry
>         return rc;
>   }
>
>  +static void cifs_readv_worker(struct work_struct *work)
>  +{
>  +      struct cifs_io_subrequest *rdata =
>  +              container_of(work, struct cifs_io_subrequest, subreq.work);
>  +
> -       netfs_subreq_terminated(&rdata->subreq,
> -                               (rdata->result == 0 || rdata->result == -EAGAIN) ?
> -                               rdata->got_bytes : rdata->result, true);
> ++      netfs_read_subreq_terminated(&rdata->subreq, rdata->result, false);

So here, I have

++      netfs_read_subreq_terminated(&rdata->subreq, rdata->result, true);

with the third argument being 'true' instead of 'false' as in yours.

The reason? That's what commit a68c74865f51 ("cifs: Fix SMB1
readv/writev callback in the same way as SMB2/3") did when it moved
the (originally) netfs_subreq_terminated() into the worker, and it
changed the 'was_async' argument from "false" to a "true".

Now, that change makes little sense to me (a worker thread is not
softirq context), but  that's what commit a68c74865f51 does, and so
that's logically what the merge should do.

> +       rdata->subreq.transferred += rdata->got_bytes;
>  -      netfs_read_subreq_terminated(&rdata->subreq, rdata->result, false);
> ++      trace_netfs_sreq(&rdata->subreq, netfs_sreq_trace_io_progress);

where did this trace_netfs_sreq() come from?

> --- a/fs/smb/client/smb2pdu.c
> +++ b/fs/smb/client/smb2pdu.c
> @@@ -4614,6 -4613,10 +4613,8 @@@ smb2_readv_callback(struct mid_q_entry
>                               server->credits, server->in_flight,
>                               0, cifs_trace_rw_credits_read_response_clear);
>         rdata->credits.value = 0;
> +       rdata->subreq.transferred += rdata->got_bytes;
>  -      if (rdata->subreq.start + rdata->subreq.transferred >= rdata->subreq.rreq->i_size)
>  -              __set_bit(NETFS_SREQ_HIT_EOF, &rdata->subreq.flags);
> +       trace_netfs_sreq(&rdata->subreq, netfs_sreq_trace_io_progress);

And where did this conflict resolution come from? I'm not seeing why
it removes that NETFS_SREQ_HIT_EOF bit logic..

Some searching gets me this:

    https://lore.kernel.org/all/1131388.1726141806@warthog.procyon.org.uk/

which seems to explain your merge resolution, and I'm even inclined to
think that it might be right, but it's not *sensible*.

That whole removal of the NETFS_SREQ_HIT_EOF bit ends up undoing part
of commit ee4cdf7ba857 ("netfs: Speed up buffered reading"), and
doesn't seem to be supported by the changes done on the other side of
the conflict resolution.

IOW, the changes may be *correct*, but they do not seem to be valid as
a conflict resolution, and if they are fixes they should be done as
such separately.

Adding DavidH (and Steve French) to the participants, so that they can
know about my confusion, and maybe send a patch to fix it up properly
with actual explanations. Because I don't want to commit the merge as
you suggest without explanations for why those changes were magically
done independently of what seems to be happening in the development
history.

                 Linus

