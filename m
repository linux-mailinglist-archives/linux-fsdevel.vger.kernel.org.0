Return-Path: <linux-fsdevel+bounces-31745-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9937E99AAF3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 20:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB0A21C2226D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 18:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3775F1C6F4D;
	Fri, 11 Oct 2024 18:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lepIQLJp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF6238DF9;
	Fri, 11 Oct 2024 18:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728670969; cv=none; b=rgNcEkF9GYCkyEy4Kg9Ooumdn8UT4S/MBiUtazLuCJXfAUbQ7jCY69r6SxoMtlKREi/rWauqcy3SivNuxex1xAgLGhipU6gvTP4J9b0d7iq9FxFa3sXqVK3/27jdKcdN2YkGjQeHc3VIZiEYtaEBhafkqfs0utlhjmsLe6m5TC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728670969; c=relaxed/simple;
	bh=lY+eP7IcrBtWvP5JHDNuBnRwv6RLNhRsB9IijXj/Q3M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PWzlmpEcejtj9z/F1qO5xuk8uCNAJgSaDHOKx4u33Ld5ABAiCLvsTs+vOByAzjKchJbHlExjoYVHswhpmGF+WJRBi8/leA7uC4+5agtFUOkXkszIHRBWFz0sbSmPmKIhYmIwzw012ZnzPgsVWUXwE3Dn+7cyr/g95FvW+60hiSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lepIQLJp; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-287b8444ff3so967853fac.1;
        Fri, 11 Oct 2024 11:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728670967; x=1729275767; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ccKWzo+/khBP99DcA6IkAImmsAenj5zVpOpXpiBwHG4=;
        b=lepIQLJpvYHdl/Gacrj82OfplwBbyVbFZgmcnwOsk2kDsT5H+xZbzureQSK4+Nh91T
         3NgwCxIWvYiRlZelWdmt3dnJ/s+Ocl+dhCCb008k6KVYhMu6Pf53fDU7pJSxMCCwBHRH
         OK6I3tqca+Ty55yajDHkk6mKfPT8isHuaBnI0qDW/NyjYCSiK7ixMZKSKzzHu44j/TX5
         OoiiMtqXpwKB8upaEgkBRg/FpfA+5XlQbWEHZp3KGwDl0SpDODyZWotc6bz4/fzDzM/Z
         bR51H3GYyAMvAT40R7KIwEhD0fe8AVxW7AYyotkONCK1XLAbZ0FuXyaOuh9O2gOH+YTq
         2NcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728670967; x=1729275767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ccKWzo+/khBP99DcA6IkAImmsAenj5zVpOpXpiBwHG4=;
        b=jB5GgtwMr0rYqXEshcLvvGQy9cc22ApiWq8uZCpv4spcorjazEkepbRRQOga4gnVsy
         twlFzfmCmN9272a0a4fYQ5TtdIAOWl1+pLOBK7KLTbsjdzbI5GVavhI8qKYtu6RWoxvR
         x9eUId80Wmcb/mWrZ3w77Tuz4ciBRnMtozDBqzVlZPTbN9XumHGV1EVpKzzFpEm/IAvI
         93xaU6DshQRSBZhu65poL6vtcOkngrZdB8DqiDqEolX1+N+jDWt57K3bpl3ahF5JQ6cu
         LC2cxxvjJiWkUOKWu0mu7OIoH0u9mtsGaEa3+kyRqTryZdFr2ATI2VoUFr3s/gM0YgXb
         JdlQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBjdoLniG4lDd82kNYbDjy+NkWhkaefRD6h9bvKpBMD8Gi0DYH4o4FmQjqFr7qzyP2ZGkb3YET8TOIVKUt@vger.kernel.org, AJvYcCWqVExxIhJTrrGyOGvzcHL+xup1MxkAE0/fWqH44z/iuE2Tss42voCJSZJWX3dQ1Kfgpho0vVtdzF0J@vger.kernel.org
X-Gm-Message-State: AOJu0YxpQ5KnUTQwoHC1rMXBIXWEFvLUVk2p04COm+e3MosaxZ68MKfe
	/6PncEcoMufR7c68zPcgiM+GHRUbMPbbYH8sBs5RkHB5jqPHyH3JtH4qDwl424iUsKTsJQVwQDt
	m9BiLnSuIXdh+MNpYas9ckZ4i+eE=
X-Google-Smtp-Source: AGHT+IG/4ZU74EL9UQz9wTHk3kgLsTLDAkPfZqVI12s/jnN1AEgq0nLiJEX6JhrZ00vWdJ8n00YDsZgoTI9bAiNTPPg=
X-Received: by 2002:a05:6871:5814:b0:278:25d:d473 with SMTP id
 586e51a60fabf-2886dd589b2mr3711017fac.1.1728670966981; Fri, 11 Oct 2024
 11:22:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011090023.655623-1-amir73il@gmail.com> <A1265158-06E7-40AA-8D61-985557CD9841@oracle.com>
In-Reply-To: <A1265158-06E7-40AA-8D61-985557CD9841@oracle.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 11 Oct 2024 20:22:35 +0200
Message-ID: <CAOQ4uxgX+PqUeLuqD47S5PxeYqJ3OMs0bfmnUE+D7dcnpr-UNw@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] API for exporting connectable file handles to userspace
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Christian Brauner <brauner@kernel.org>, Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>, 
	Aleksa Sarai <cyphar@cyphar.com>, Linux FS Devel <linux-fsdevel@vger.kernel.org>, 
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2024 at 4:24=E2=80=AFPM Chuck Lever III <chuck.lever@oracle=
.com> wrote:
>
>
>
> > On Oct 11, 2024, at 5:00=E2=80=AFAM, Amir Goldstein <amir73il@gmail.com=
> wrote:
> >
> > Christian,
> >
> > These patches bring the NFS connectable file handles feature to
> > userspace servers.
> >
> > They rely on your and Aleksa's changes recently merged to v6.12.
> >
> > This v4 incorporates the review comments on Jeff and Jan (thanks!)
> > and there does not seem to be any objection for this new API, so
> > I think it is ready for staging.
> >
> > The API I chose for encoding conenctable file handles is pretty
> > conventional (AT_HANDLE_CONNECTABLE).
> >
> > open_by_handle_at(2) does not have AT_ flags argument, but also, I find
> > it more useful API that encoding a connectable file handle can mandate
> > the resolving of a connected fd, without having to opt-in for a
> > connected fd independently.
> >
> > I chose to implemnent this by using upper bits in the handle type field
> > It may be that out-of-tree filesystems return a handle type with upper
> > bits set, but AFAIK, no in-tree filesystem does that.
> > I added some warnings just in case we encouter that.
> >
> > I have written an fstest [4] and a man page draft [5] for the feature.
> >
> > Thanks,
> > Amir.
> >
> > Changes since v3 [3]:
> > - Relax WARN_ON in decode and replace with pr_warn in encode (Jeff)
> > - Loose the macro FILEID_USER_TYPE_IS_VALID() (Jan)
> > - Add explicit check for negative type values (Jan)
> > - Added fstest and man-page draft
> >
> > Changes since v2 [2]:
> > - Use bit arithmetics instead of bitfileds (Jeff)
> > - Add assertions about use of high type bits
> >
> > Changes since v1 [1]:
> > - Assert on encode for disconnected path (Jeff)
> > - Don't allow AT_HANDLE_CONNECTABLE with AT_EMPTY_PATH
> > - Drop the O_PATH mount_fd API hack (Jeff)
> > - Encode an explicit "connectable" flag in handle type
> >
> > [1] https://lore.kernel.org/linux-fsdevel/20240919140611.1771651-1-amir=
73il@gmail.com/
> > [2] https://lore.kernel.org/linux-fsdevel/20240923082829.1910210-1-amir=
73il@gmail.com/
> > [3] https://lore.kernel.org/linux-fsdevel/20241008152118.453724-1-amir7=
3il@gmail.com/
> > [4] https://github.com/amir73il/xfstests/commits/connectable-fh/
> > [5] https://github.com/amir73il/man-pages/commits/connectable-fh/
> >
> > Amir Goldstein (3):
> >  fs: prepare for "explicit connectable" file handles
> >  fs: name_to_handle_at() support for "explicit connectable" file
> >    handles
> >  fs: open_by_handle_at() support for decoding "explicit connectable"
> >    file handles
> >
> > fs/exportfs/expfs.c        | 17 ++++++++-
> > fs/fhandle.c               | 75 +++++++++++++++++++++++++++++++++++---
> > include/linux/exportfs.h   | 13 +++++++
> > include/uapi/linux/fcntl.h |  1 +
> > 4 files changed, 98 insertions(+), 8 deletions(-)
> >
> > --
> > 2.34.1
> >
>
> Acked-by: Chuck Lever <chuck.lever@oracle.com <mailto:chuck.lever@oracle.=
com>>
>
> Assuming this is going directly to Christian's tree.
>
> I'm a little concerned about how this new facility might be
> abused to get access to parts of the file system that a user
> is not authorized to access.

That's exactly the sort of thing I would like to be reviewed,
but what makes you feel concerned?

Are you concerned about handcrafted file handles?
Correct me if I am wrong, but I think that any parts of the filesystem
that could be accessed (by user with CAP_DAC_READ_SEARCH)
using a handcrafted connectable file handle, could have also been
accessed by the parent fid part before, so I do not see how connectable
file handles create new ways to get access?

> But follow-up comments from Amir
> suggest that (with the current code) it is difficult or
> impossible to do.
>
> Are there self-tests or unit-tests for exportfs?

There are fstests, particularly, the "exportfs" test group
and I added this one for connectable file handles:

[4] https://github.com/amir73il/xfstests/commits/connectable-fh/

Did you mean another form of unit tests?

Thanks,
Amir.

