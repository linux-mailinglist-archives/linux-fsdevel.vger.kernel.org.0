Return-Path: <linux-fsdevel+bounces-59649-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E63E7B3BBC5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 14:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 117571C88135
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 12:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B637C31A041;
	Fri, 29 Aug 2025 12:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lI3+Fesz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730901EB36
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 Aug 2025 12:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756472129; cv=none; b=V+ttchN9t8MZQgagbBkwFV6U3M6ErYlHWrZTxh86brxR8MDW8mQU6q75s2Co9zhmdSfLdBYtSReHU/Rl6Wdnh/oixMmdvrDTFE0wSa9eUrV7+ehFEEOJs5GwASRM+xpKUWEWbeT6caC1/kSkltkLVw+lqjti/ihyyN1NjULow4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756472129; c=relaxed/simple;
	bh=CkGRfZV8A2kcCGcrnjDrxhX6WjenLBqLY4LDfTbIMo8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=du+WG2mCazU+vjuAlHuxOQfPFHQHltuY5WBJ23UyCe4pa2uwNihpStwsqze8F4nx/8esTLRMH7rH01gbaSFda8gFFLCHpyxkwkN+RWMM+dl+DxTnfIrrocKqsob8LK5CeqWbQ8g4WK2OqT7GmqTfx1XRQ8gCNRXhxH7vj/brfLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lI3+Fesz; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-afe84202bc2so300353066b.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Aug 2025 05:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756472126; x=1757076926; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vRj806YN3BtAJzRKPlmJidrrZNEO7NBFfj6pRUHMu9U=;
        b=lI3+FeszrQo8s0jlpdy8YYIN58wbhVL4SS1HtRuR8s9luLOCt6tthrFpprkSX8HHdp
         3B7llebSe/XKvJF/egOskC2tpdgC4/HK/4sPlnUht3c/H3kgPaCMbjCfB4NfH/BSm1Qr
         qcAXnwBDNJSn7fdT55K0lnXpE20GDJ+N74QVPMpiHmx5DiNR9YJV19/V4X477FvVWutA
         PcLXiLcTD4X8+bv7ocFtkDWogtsRaMrwEi9+217orFlMUh9M4LpfZqESKnFMydBK4ZkV
         5clH384AsCfVhffbB7t3NVZeuHhJp4QXjLitQf/6440r6rl0n1kRfTu4WOGA2Eqc50XT
         n8EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756472126; x=1757076926;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vRj806YN3BtAJzRKPlmJidrrZNEO7NBFfj6pRUHMu9U=;
        b=nDqk5AbMzez6KR/U3puKIwmEt50i8429jFIqNhqSyOTfnWVGJN9mJLGSui6UT3qbXA
         2nJprJm/jP2CObQ+bWxHVjpqIXF6/+m0N5AqHJtHdN8FlLzlYxx5G9cenwP8zcl4hWRZ
         Gm2N6QmUeqr+gMDHJL1CofHL1P4NuyVAL9JEIj6ilj0j9VYASGUBqdwtw0ffFvVcRmJe
         R4QNy6HIhGa/bUnB4w/WialreBBFjwaqQIwX6qYP8sqGYPVJpjwfh16lxnGq8DthBxFr
         s+os8petYdODNaRcF5BRYFQ2IJanx+Lh5M/5h7TErJvnl7JMuyJNKMQz7Km6EWvTbttF
         C5yA==
X-Forwarded-Encrypted: i=1; AJvYcCXdJAuJkZ/bx5x40lg1++Z5SKVOkrAklol3QDhnQl+07IzefKYXDWeOjwiiwdM0hX2QunI6wbxKNY08RGDi@vger.kernel.org
X-Gm-Message-State: AOJu0Yyqd0iW8u6LqlBmyiiUufujl8n2uCkhJmiR3sDQzMdbrQg82+UQ
	BeRVZNbEOlWloyWCo+wNZn9zQUkd/Mom+83jL/Qt8+lXTug6IPMRiN2pY96rm32YNMalOtS2y/4
	ueTXlOL7n9hmiVJELH5ODcIpurQCSsWxiPU0CRUQ=
X-Gm-Gg: ASbGncu3U4Vs3tYcq6q3V83foZSNZgG4FAkw0vQFVgoa+ri+lUW31x42j7RSNedjXyb
	QZggd59ABUmwuLfjRjPAyNd409z3OCxvUIIIIJ7Wdd1/EK2hDnJCsajHTEpz2LHCxFrVJi3QUwr
	mYFutqV9dqo1UVHMA8oZf/CKfUOdkfJQ3leK5fx9nPv7w3mraX45ReWX4vsBCL+ADMf277liBAG
	Jnbutt9gwg/fBqXVxXIWyLzimhJ
X-Google-Smtp-Source: AGHT+IGKJ7OfCntx9OHzSo+H5GxkLVsO2mNiz6FVsIWjiSJor9SuS0v0fg/VSDeAGIXOQWAwolCze0sOyyfldOqONk4=
X-Received: by 2002:a17:907:6d0a:b0:afe:cb06:ee16 with SMTP id
 a640c23a62f3a-afecb06f22dmr785192766b.5.1756472125505; Fri, 29 Aug 2025
 05:55:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827194309.1259650-1-amir73il@gmail.com> <xdvs4ljulkgkpdyuum2hwzhpy2jxb7g55lcup7jvlf6rfwjsjt@s63vk6mpyp5e>
In-Reply-To: <xdvs4ljulkgkpdyuum2hwzhpy2jxb7g55lcup7jvlf6rfwjsjt@s63vk6mpyp5e>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 29 Aug 2025 14:55:13 +0200
X-Gm-Features: Ac12FXwdQ8Yx-zHPMpxVb6elSnvtU-Yap7u1ykOhAvjahQL-VqTdACjRj3YZvTQ
Message-ID: <CAOQ4uxi_3nzGf74vi1E3P9imatLv+t1d5FE=jm4YzyAUVEkNyA@mail.gmail.com>
Subject: Re: [PATCH] fhandle: use more consistent rules for decoding file
 handle from userns
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Jeff Layton <jlayton@kernel.org>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 29, 2025 at 12:50=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Wed 27-08-25 21:43:09, Amir Goldstein wrote:
> > Commit 620c266f39493 ("fhandle: relax open_by_handle_at() permission
> > checks") relaxed the coditions for decoding a file handle from non init
> > userns.
> >
> > The conditions are that that decoded dentry is accessible from the user
> > provided mountfd (or to fs root) and that all the ancestors along the
> > path have a valid id mapping in the userns.
> >
> > These conditions are intentionally more strict than the condition that
> > the decoded dentry should be "lookable" by path from the mountfd.
> >
> > For example, the path /home/amir/dir/subdir is lookable by path from
> > unpriv userns of user amir, because /home perms is 755, but the owner o=
f
> > /home does not have a valid id mapping in unpriv userns of user amir.
> >
> > The current code did not check that the decoded dentry itself has a
> > valid id mapping in the userns.  There is no security risk in that,
> > because that final open still performs the needed permission checks,
> > but this is inconsistent with the checks performed on the ancestors,
> > so the behavior can be a bit confusing.
> >
> > Add the check for the decoded dentry itself, so that the entire path,
> > including the last component has a valid id mapping in the userns.
> >
> > Fixes: 620c266f39493 ("fhandle: relax open_by_handle_at() permission ch=
ecks")
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
>
> Yeah, probably it's less surprising this way. Feel free to add:
>

BTW, Jan, I was trying to think about whether we could do
something useful with privileged_wrt_inode_uidgid() for filtering
events that we queue by group->user_ns.

Then users could allow something like:
1. Admin sets up privileged fanotify fd and filesystem watch on
    /home filesystem
2. Enters userns of amir and does ioctl to change group->user_ns
    to user ns of amir
3. Hands over fanotify fd to monitor process running in amir's userns
4. amir's monitor process gets all events on filesystem /home
    whose directory and object uid/gid are mappable to amir's userns
5. With properly configured systems, that we be all the files/dirs under
    /home/amir

I have posted several POCs in the past trying different approaches
for filtering by userns, but I have never tried to take this approach.

Compared to subtree filtering, this could be quite pragmatic? Hmm?

The difference from subtree filtering is that it shifts the responsibility
of making sure that /home/amir and /home/jack have files with uid,gid
in different ranges to the OS/runtime, which is a responsibility that
some systems are already taking care of anyway.

Thanks,
Amir.

