Return-Path: <linux-fsdevel+bounces-64727-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B5FBF293D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 19:00:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id ED13B34D9C8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 17:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D085E330B31;
	Mon, 20 Oct 2025 17:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QIW234R9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABEEA27BF93
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Oct 2025 17:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760979610; cv=none; b=G/lxQNvBS6CGObpKT9F+rYQ0cDzWEuIMrZbjhzM5pEM1vO0dnO0a+U/+bVE4neroKSC1IVlH2anvqg5FV84phJIDX8ssVho400yjL2ZQ4PPuimn9IgGsBvfFbot85vThVcCVxwfI+fWLiYWp+V9Hprsnl6V5Kx2n6F1jyMPkbws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760979610; c=relaxed/simple;
	bh=EXc0jOYLRmr/3jRYSk2fLCR4EdRJhtPN83IRY/bFlt8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MUJuWuD7x1mV7jio5O9i6/Oh8fRPxhP1AS8duxjYV7L6ew9GhYaT/NbWG3fjIjQUAXAmfJXlMU3XBu7DHl20qIOsTBhrnPQVXkK0IPxriA8MFnFOTMmL9b3KYVBAeJtXmiWH3tdczBm2bEo8UwPP+IpjuRyeUs5Hda8BU8RPSJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QIW234R9; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-87d8fa51993so39902126d6.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Oct 2025 10:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760979607; x=1761584407; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4RSN4YFTB3br2+B3ySD6exiSoPsxEwCTC80by1DxrCk=;
        b=QIW234R9WrrlKJk2HVXisGbrYjBI/eH9cDZ6nuGqUJb351Dw9HZMBHEWsS0MhTrkRk
         yl87JgGgm6rlD/1yygbS30JSKHQ/6z07pgw/4HxYa4TfOwXcgSS4qqVZO7F33j3IFG9b
         b0p22vkt/1RGvQt4WwxJI80tKU9I0tQhTUVyAsvc5IazWbvRl4LqkJZCyeakz5DwLzg0
         j8RncyqIdyh5eUWp04kAy1pV71aDeGRTVHw5gZxfXeWNAuk+GsL0OhCu4gylJtZfXNlI
         ty4l/DrsXepycl2SgRP8hC2kIqc86eYHioc79PuPoy5csO+El7od88krnQtlRk+lc3Ba
         bqNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760979607; x=1761584407;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4RSN4YFTB3br2+B3ySD6exiSoPsxEwCTC80by1DxrCk=;
        b=bVYr/1xShRUna2hKFherpdLC50hr2/IQh5Ucjnb29g0MZbR5B/8WWis8QTmGsxL4st
         ucWGtU8S2ahYer+Gmtt0Cyyz7234jYGuorBmheL0UNR0SWeXvCzM2u/Algyzw03wJZNA
         IKDiBqTm+8J/7+ecp8I5nI/H4jKfdvybmd7sFGWHxQXBLu48dUrZnJ/ZZ3VzFIhUb6ZA
         nUToORK1t4UCPfCxFSz3m4M2EWdbRIsfwf6+yfyILMiGr4VpQEnefv/FENj7BFukeBUQ
         UPYLKDKZ89Ge+P+FLJftswXMZ36/s1sI0HY+WevKvbRy61mIorztfm43R1UBJLGi+shc
         6EJg==
X-Forwarded-Encrypted: i=1; AJvYcCWT3ukXAhFai2oG22TcukNc5BePj6fJhSJDQjYMjypw0NMjpzBPr6O8zexdyofrqlFMnKiF9qBxTSK2KGJl@vger.kernel.org
X-Gm-Message-State: AOJu0YyfpggTfp0OGmf4A8F6QulY50Xt7rjclZb2oQSNCfq9SQlht8cD
	W4XNgRye10lzPzOg5vC6b9iZiLsgLLW8XzO9CQSfOgUrklodOEirD1iAQr/6uQ3Hyfi1C8i3T8T
	BGzJ6h/PONdi2bmrfZi2hvddl4lcpNSY=
X-Gm-Gg: ASbGncvr1kUoqUt/EJj2EKVGpw+C8U642eVR/x0Lc1o36kkCGOkRZbg/5iZOWQAcVbj
	XHaX94npRN6ZtDLc52kGnVM9datqIK/CZrbe6XCK0T6fJ5viPa1+yvA1Va3aZ6nHI2xPnQq5eIU
	ODbck36Ulgb91sn/o6qbgbRD2ksPH9R1ECl8r9X5QW93RDO483TiplnwzOmFsQw5f7P8Vc9JRaH
	g87KeXJ78YGL0/YxxAwNMcQaTq9eQTG5h5N3kJdR8Kk5qwEQm+wIqmYDBeAVNH9exj/hUesV2G4
	IyPe5cPvPw4Bcls14HS4adgHrXpHUlVkIHNybHLHkj3Goqb0xyooYaO5YJspEkfo9xxVriLjtnw
	ruk3SASbLQmAZlTxm2rSbReB3w0NaOnK9ZcJ39rDCpbAKt0sF5ONGRo4bAIoWfaJfS39Co6Xvfa
	k=
X-Google-Smtp-Source: AGHT+IFHQ5iz8/Saro2LRp+bwSIlhkAJVCK9/l8+MswododraUp4Qz/LXmzQtrn4f2pjW8VxdwrV1XzKCjcqyAUk8lg=
X-Received: by 2002:ad4:5cea:0:b0:86b:4ffa:a8b2 with SMTP id
 6a1803df08f44-87c20576935mr170951986d6.22.1760979607465; Mon, 20 Oct 2025
 10:00:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1039410.1760951767@warthog.procyon.org.uk>
In-Reply-To: <1039410.1760951767@warthog.procyon.org.uk>
From: Steve French <smfrench@gmail.com>
Date: Mon, 20 Oct 2025 11:59:56 -0500
X-Gm-Features: AS18NWB_wm78_JKAnPCw2RD98jnwlVQ7_i0H__VeQ2TBjimWfb0DUiLikj1O_Qg
Message-ID: <CAH2r5mtLDTExHRhbr3yyK1Jm1Azq8PyN_TkWsf3gyEWVhybrnw@mail.gmail.com>
Subject: Re: [PATCH] cifs: #include cifsglob.h before trace.h to allow structs
 in tracepoints
To: David Howells <dhowells@redhat.com>
Cc: Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.org>, linux-cifs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Do you have patches in process that will depend on this?

On Mon, Oct 20, 2025 at 4:16=E2=80=AFAM David Howells <dhowells@redhat.com>=
 wrote:
>
>
> Make cifs #include cifsglob.h in advance of #including trace.h so that th=
e
> structures defined in cifsglob.h can be accessed directly by the cifs
> tracepoints rather than the callers having to manually pass in the bits a=
nd
> pieces.
>
> This should allow the tracepoints to be made more efficient to use as wel=
l
> as easier to read in the code.
>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Steve French <sfrench@samba.org>
> cc: Paulo Alcantara <pc@manguebit.org>
> cc: linux-cifs@vger.kernel.org
> cc: linux-fsdevel@vger.kernel.org
> ---
>  fs/smb/client/cifsproto.h |    1 +
>  fs/smb/client/trace.c     |    1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/fs/smb/client/cifsproto.h b/fs/smb/client/cifsproto.h
> index 07dc4d766192..4ef6459de564 100644
> --- a/fs/smb/client/cifsproto.h
> +++ b/fs/smb/client/cifsproto.h
> @@ -9,6 +9,7 @@
>  #define _CIFSPROTO_H
>  #include <linux/nls.h>
>  #include <linux/ctype.h>
> +#include "cifsglob.h"
>  #include "trace.h"
>  #ifdef CONFIG_CIFS_DFS_UPCALL
>  #include "dfs_cache.h"
> diff --git a/fs/smb/client/trace.c b/fs/smb/client/trace.c
> index 465483787193..16b0e719731f 100644
> --- a/fs/smb/client/trace.c
> +++ b/fs/smb/client/trace.c
> @@ -4,5 +4,6 @@
>   *
>   *   Author(s): Steve French <stfrench@microsoft.com>
>   */
> +#include "cifsglob.h"
>  #define CREATE_TRACE_POINTS
>  #include "trace.h"
>
>


--=20
Thanks,

Steve

