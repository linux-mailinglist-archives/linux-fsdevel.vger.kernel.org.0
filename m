Return-Path: <linux-fsdevel+bounces-46943-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D1F2A96CF2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 15:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8EFB440922
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 13:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCDB22836BF;
	Tue, 22 Apr 2025 13:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zx7paoq3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B5F2836A2
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Apr 2025 13:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745328801; cv=none; b=sc5HWaMEt1qMGtcvZJMSo15JiHh9jsn1VXHPPf/7MK0ni1CrbmHtKSOyuhcJhDWqFOmHvMTyhKfvnV2XIn/z5DrrmyUVXYGc97rsjs6m8XyHyS1X8s1wWqtHe79rZzDIpHWiA3FAMJyn1ohIIxn+WwTZtnw2UU20o5aCl49EoRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745328801; c=relaxed/simple;
	bh=tTHHj72jJyHqn6AJfYXUzTOMkQhEfXwhPCF481zV568=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oRwjOQtCBGqWijzOG9l+173uLfuICSWaEOD3MBPBnokgEpv7xp0yk29LW7cyVA2wqBhKpyfGkt+5ZQvV107O2v+1hhIv/RRHX6pkBcWJ1foY0DfEPvA+mz67jNnjEVIh6g6rXMdx+eHdlZAxl6t2llUtnyDFskcw7L5F9iJimL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zx7paoq3; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aca99fc253bso733759766b.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Apr 2025 06:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745328797; x=1745933597; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tTHHj72jJyHqn6AJfYXUzTOMkQhEfXwhPCF481zV568=;
        b=Zx7paoq30XIzXwSPn+1j3jJMZCwxs/UjJzAjn5gV3JW0Wk/Orm7muO6nczYyhxfzPr
         ZLAPiPEmlHja4J3WAd2NFTyi266PXAJxvn2u7LJRv2+//lkDZ1mMyNKwmkNwFrUOGHSP
         6AhzyT/7rF1aV+sP8N1Nk7EhNNUImdLctiPUodBqpWS/LkelieeH/N8j/tUs2WPG6rfQ
         EBMVwwNmRWFJAqEsFp+Kg9lS9jXre8g72vPP4qYfcYv1ObvFvj35sHZkR1M7bDy9+Uu+
         /KnYgDbvtESDDL2SkIkDVSv8pmRVCw590UQ3D/QwjSDRQjR8/V+/0mfGiK9Lzrk2yjMv
         lzgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745328797; x=1745933597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tTHHj72jJyHqn6AJfYXUzTOMkQhEfXwhPCF481zV568=;
        b=rsHLgWU7Qn4RZw8XJ21rGDdOfuo1x3NFxz6/lSuiItk1qJ7PFkXfhA1ZzYz2k8Xgd+
         bGRzCA95dbWHueibcyKxSLVf1rxWtvtFKXMUDBaeTjjEVIC5G7mVcgDcLqjfgKCp1O8y
         QNUvyWY4LHM5eA1ISN/4+T6aU65zbmFjqDu/nJXNq1TJL/N8kQdvdZ1xTTPoghjvOahh
         3rOe61pZeKk76rO5haGi3iIW17F/Ugt6+QtXIIf1qoJp6kllm5ftgcmkDM53xoSJjp6D
         P6zNjgUAUdeoqDT83RuvlwCM4gbMZSOSk4AC/YDvnN6xSkTA91a9Qs8KZU8W+uI1iBhY
         E2+g==
X-Forwarded-Encrypted: i=1; AJvYcCXzG/C8Ygg+sDHYMKQWbIpUs7b6RE13lzIGFhuZSeKiHJzKhn7pYBUkCsrOamn5niRKZhqedG/wjFK/X0PB@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm0sEGK53YZNpritJJlSBmNO0zxG1OLyII24jMse07mt9nqicf
	HvUBfhGMeiOuFBxhM6HsSA5FotCvWkI3b/Wt4X3MCbu27YTP2tUQ+1He/azvt/vToWcE7JhQcKM
	w43RJ83V4mCFysb8WuaE913JR5/k=
X-Gm-Gg: ASbGncuYn0Fx+Z8bnYYRJ8erGynjz2Ku3VS1j8g+IaFGUETzYZtNqXEL+LcirpYu7E4
	J4EG2jVym43lvdWI9+OZ4TLNy6rqipJWVoH7YUPbqMpPA5uuf2zWjizmw2mkA2QFQY7i7K0R77s
	GgEITcpk/9jlYdS/2CTXo0+w==
X-Google-Smtp-Source: AGHT+IGPvJrAR/umAXilnmESQvTQTT7nONvfQrS//Id/yHON7B37BfTou8oelfBH9KVnohyOJe7zrpUt8IUU6WMp2z8=
X-Received: by 2002:a17:906:f5a9:b0:ac3:4373:e8bf with SMTP id
 a640c23a62f3a-acb74ac5194mr1490022066b.10.1745328797104; Tue, 22 Apr 2025
 06:33:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250416-work-mnt_idmap-s_user_ns-v1-0-273bef3a61ec@kernel.org>
 <20250416-work-mnt_idmap-s_user_ns-v1-1-273bef3a61ec@kernel.org> <mzryrjmph2ws7kprtnxj34xqp4cyhfdwpfnltkx4ziugwdqmu7@f4myyqyrmta3>
In-Reply-To: <mzryrjmph2ws7kprtnxj34xqp4cyhfdwpfnltkx4ziugwdqmu7@f4myyqyrmta3>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Tue, 22 Apr 2025 15:33:03 +0200
X-Gm-Features: ATxdqUE_2BPUIp7mDJx98qssPfcwauPxY65yaMGvYNt13d3dm7WhOPDenrQqIY8
Message-ID: <CAGudoHFv6u5DrWbXt6C_LPmzzQ1Gmia6-h1QZ=RDWzct63N_mA@mail.gmail.com>
Subject: Re: [PATCH RFC 1/3] inode: add fastpath for filesystem user namespace retrieval
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Jeff Layton <jlayton@kernel.org>, Josef Bacik <josef@toxicpanda.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 22, 2025 at 12:37=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Wed 16-04-25 15:17:22, Christian Brauner wrote:
> > We currently always chase a pointer inode->i_sb->s_user_ns whenever we
> > need to map a uid/gid which is noticeable during path lookup as noticed
> > by Linus in [1]. In the majority of cases we don't need to bother with
> > that pointer chase because the inode won't be located on a filesystem
> > that's mounted in a user namespace. The user namespace of the superbloc=
k
> > cannot ever change once it's mounted. So introduce and raise IOP_USERNS
> > on all inodes and check for that flag in i_user_ns() when we retrieve
> > the user namespace.
> >
> > Link: https://lore.kernel.org/CAHk-=3DwhJgRDtxTudTQ9HV8BFw5-bBsu+c8Ouwd=
_PrPqPB6_KEQ@mail.gmail.com [1]
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
>
> Some performance numbers would be in place here I guess - in particular
> whether this change indeed improved the speed of path lookup or whether t=
he
> cost just moved elsewhere.

Note that right now path lookup is a raging branchfest, with some
avoidable memory references to boot.

I have a WIP patch to bypass inode permission checks with an
->i_opflag and get over 5% speed up when stating stuff in
/usr/include/linux/. This might be slightly more now.

Anyhow, this bit here probably does not help that much in isolation
and I would not worry about that fact given the overall state.
Demonstrating that this indeed avoids some work in the common case
would be sufficient for me.

To give you a taste: stat(2) specifically around 4.28 mln ops/s on my
box. Based on perf top I estimate sorting out the avoidable
single-threaded slowdowns will bring it above 5 mln.

The slowdowns notably include the dog slow memory allocation (likely
to be sorted out with sheaves), the smp_mb fence in legitimize_mnt and
more.

Part of the problem is LOOKUP_RCU checks all over the place. I presume
the intent was to keep this and refwalk closely tied to reduce code
duplication and make sure all parties get updated as needed. I know
the code would be faster (and I *suspect* cleaner) if this got
refactored into dedicated routines instead. Something to ponder after
the bigger fish is fried.
--=20
Mateusz Guzik <mjguzik gmail.com>

