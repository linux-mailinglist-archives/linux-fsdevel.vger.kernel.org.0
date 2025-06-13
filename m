Return-Path: <linux-fsdevel+bounces-51590-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B4EAD8D28
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 15:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D42983B1954
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 13:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D8818DB24;
	Fri, 13 Jun 2025 13:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sJoCzoOx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4DA17A31C
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Jun 2025 13:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749821708; cv=none; b=hNNdckc8cCDClYkNCZ6abtz/Bppw6+mpa82GIIGz3f0o/wSbIYc93cwcE/fuIUjBqkvwBUIBUDKD0uK4/PA8xmPtWCDHbAYaVHTiES8+0qfyD6eukKsG7Hqferzh73r5v5OFEF5C/p8J7XAw60wgcoX2C3y2Sf0K31pCqS+cz48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749821708; c=relaxed/simple;
	bh=OcfmVHgJ62OoKTspNJ3fWZqVVbnF3/0lhghMq2t0R3E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OSwintOz8s6alRHLB60pFKnmap8P4wyN2lJqj8pAEWcVbAonhH0uAxC8QXEm+cCUAxir2y5cbEpoUHBkjVFS16NUq6cxV6SPKfreAvjGGqgh2nH4lngnioTuHTrEBWUBJW2Hs6w/a8qNVUBu2ps6ovVVc0l3ZPbRRihuDzy/bME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sJoCzoOx; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b26f5f47ba1so1858214a12.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Jun 2025 06:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749821706; x=1750426506; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OcfmVHgJ62OoKTspNJ3fWZqVVbnF3/0lhghMq2t0R3E=;
        b=sJoCzoOxO4UJMAkaFJWX0WnJx6cUvFh3YPyroz7/jV0CZjMQKwj6+fHYP/TjnPxtmd
         ZyiiXFFCT91TdqWZKzhpXuXdB0JnCYlrJXPIMOBNCpl5J0EPwwwM/csk+8U21evf5TKn
         5UXC/kvjz4Rrr0HUmbVkxFDWGf7MVsRS2FuEqdwVqdTaLvjGWjXMSEDDy8GcTbWyhkex
         oXhE0iosl1S86eBTzcvZZruLufxIrOO94J5hX6hVyfllyOMS+69IORGaLXSZd7LkntNf
         ckKmHGE9iZxp4DmbHzC640HW/9IzcJMyQkl2V7xjsgruQne7kEX8F3YV+gZ0YRDURoxz
         52TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749821706; x=1750426506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OcfmVHgJ62OoKTspNJ3fWZqVVbnF3/0lhghMq2t0R3E=;
        b=AiJnMdN/W3a3/nUW1J6qeUVUnfGocAyDlBM0nfd5ncFBGI+I6DwS1gKlw1O73egmmi
         N0kNU8Z9al4BMlh+mkIRCcLhKra3toy1u2YggE6O6fM9SVAhdYkQ+sMw0fpHnxB1TIsM
         oYVVVBBATtGWhmaB+OBl5y4pr9swYqaQZKWgdGMOPYapK+9CCswLL48fXjHa3zMn0BkV
         i+DRu0BtZ7cJNRR6eC9Eowi7yfPuQv/eOs7oZynURqRKi8C5ADnUicqAo7t1y/IlR4eK
         Z81J2pNEAPo4cRlzBUD3RjoLn+tkZVozFIyWtpAzUwCoaXfX4o6puMhYTW+nGV7nfsHM
         vOrg==
X-Gm-Message-State: AOJu0Yw09uWXuUm6JCJpxOQSuPh7MgoKOY9gZKcut4FEL7G+DSekuBmW
	xAT+/2NugxA46YTswgriWZAqWorJA+KQqkAAh2xEqUqI3Ms+KCx5e/+bv7Mq3IIVfT2tsdaI+vv
	rOTaGY+ruPlN5ma2heDT5N+k5eDgC8hi/JzbN7cMb2C3NyBzkVh6bsKI+ZHOrtQ==
X-Gm-Gg: ASbGncvo4vRAGM669/smdMk4EitN2plHziEThrIi+9sGoXrveCk/bsp0dePMuJI3Ghv
	T2TAwPn8fRdEvi5A6dW8y/JdwyXMWmQ3eV5W1IGlfZ0ggG5P8i9Z7jpFHg6ngVCmdie9EBAzL5p
	5UPPNSf5p7+5tEBJ/slMnxDH9X3aUSnAv6CYwR5ZDau4dF4Hv3cDU8qs7aMfnjhe8/qnbOfNFtT
	MHiTzO9
X-Google-Smtp-Source: AGHT+IFWY148VBLrdJRWjOxgyidUxn/vVxlEEEyHxrXeZx/3S8yx4HLi+Mp/jCyWDBMo76vlLYQTJ9MXqSSqQbv0rVo=
X-Received: by 2002:a17:90b:38cd:b0:311:9c9a:58d7 with SMTP id
 98e67ed59e1d1-313d9ec6190mr3836120a91.19.1749821705787; Fri, 13 Jun 2025
 06:35:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEW=TRpJ89GmQym_RHSxyQ=x97btBBaJBT7hOtbQFKyk4jkzDQ@mail.gmail.com>
 <CAEW=TRp9t2dTsp+Fd6szDdSrn4j350j0Yrju0GLtFDzzG7i_xw@mail.gmail.com> <44b12b64-aa03-414d-ab51-86a2eb864b1f@bsbernd.com>
In-Reply-To: <44b12b64-aa03-414d-ab51-86a2eb864b1f@bsbernd.com>
From: Prince Kumar <princer@google.com>
Date: Fri, 13 Jun 2025 19:04:53 +0530
X-Gm-Features: AX0GCFtQDP252JlbEHy3STHSfToxSmUre7lwEjcP7qMrn4qtgFPu5SFaALFbWj8
Message-ID: <CAEW=TRrEw0D3ptgVctbtvLM5er9fe6=oiursdVqfr+Lf5DZLnA@mail.gmail.com>
Subject: Re: [fuse] Getting Unexpected Lookup entries calls after Readdirplus
To: Bernd Schubert <bernd@bsbernd.com>
Cc: linux-fsdevel@vger.kernel.org, Aditi Mittal <aditime@google.com>, 
	Ashmeen Kaur <ashmeen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Got it. Thanks Bernd, for the clarification!

[fuse] in subject - thanks for pointing out, will make sure next time onwar=
ds!

Thanks,
Prince Kumar.


On Fri, Jun 13, 2025 at 6:05=E2=80=AFPM Bernd Schubert <bernd@bsbernd.com> =
wrote:
>
>
>
> On 6/12/25 17:56, Prince Kumar wrote:
> > Gentle reminder!!
>
> It would be ways more visible, if you would add [fuse] to the subject
> line. I only noticed by accident during lunch break when I scanned
> through fsdevel...
>
> >
> > -Prince.
> >
> > On Thu, Jun 5, 2025 at 2:53=E2=80=AFPM Prince Kumar <princer@google.com=
> wrote:
> >>
> >> Hello Team,
> >>
> >> I'm implementing Readdirplus support in GCSFuse
> >> (https://github.com/googlecloudplatform/gcsfuse) and have observed
> >> behavior that seems to contradict my understanding of its purpose.
> >>
> >> When Readdirplus returns ChildInodeEntry, I expect the kernel to use
> >> this information and avoid subsequent lookup calls for those entries.
> >> However, I'm seeing lookup calls persist for these entries unless an
> >> entry_timeout is explicitly set.
> >>
> >> One similar open issue on the libfuse github repo:
> >> https://github.com/libfuse/libfuse/issues/235, which is closed but
> >> seems un-resolved.
> >>
> >> 1. Could you confirm if this is the expected behavior, or a kernel sid=
e issue?
> >> 2. Also, is there a way other than setting entry_timeout, to suppress
> >> these lookup entries calls after the Readdirplus call?
>
> I guess the problem is that there is no readdir-plus system call.
>
> Try something like "strace -f ls -l /tmp"
>
> Results in
>
> getdents64(3, 0x6119da3c3640 /* 28 entries */, 32768) =3D 1768
> statx(AT_FDCWD, "/tmp/snap-private-tmp", AT_STATX_SYNC_AS_STAT|AT_SYMLINK=
_NOFOLLOW|AT_NO_AUTOMOUNT, STATX_MODE|STATX_NLINK|STATX_UID|STATX_GID|STATX=
_MTIME|STATX_SIZE, {stx_mask=3DSTATX_BASIC_STATS|STATX_MNT_ID, stx_attribut=
es=3D0, stx_mode=3DS_IFDIR|0700, stx_size=3D120, ...}) =3D 0
> lgetxattr("/tmp/snap-private-tmp", "security.selinux", 0x6119da3c1f40, 25=
5) =3D -1 ENODATA (No data available)
>
> getdents64() eventually becomes FUSE_READDIRPLUS and libfuse returns
> the entries with their attributes. And these attributes get
> filled into the inodes.
>
> A bit later statx() is called and since there is no cache on the attribut=
es
> it has to assume that the attributes are outdated and fetches them again.
>
> Without cache you would need a single application call, but that syscall
> does not exist.
>
>
> Hope it helps,
> Bernd
>

