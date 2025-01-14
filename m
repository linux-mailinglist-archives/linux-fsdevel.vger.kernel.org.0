Return-Path: <linux-fsdevel+bounces-39135-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 99661A107AD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 14:25:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE6017A2B46
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 13:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C3A236EB2;
	Tue, 14 Jan 2025 13:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MG73pHxx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D968E234D0C
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jan 2025 13:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736861110; cv=none; b=TZ3jT1g783rHl61043XxxW7D82wLCYnrdfIbOynjyBkqIeCT7UR0Te8umAMqslOzCVnUnz1k77qgKdY894L5BolK1HlmF+cTUhiWvGqujwzMdVsX3Ju/FLVTG7kfXwH7KnAY1odlmgrmeJkDkcLIutrNQTzaosfK4o1Qo0ZQIpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736861110; c=relaxed/simple;
	bh=E8AoZV5QSgm9bLiWhijrwsLuz1qoBYuWMl/ZwGLWBlA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FxFo0jQ9QAIml2Gc8hF/Gk5/WGabTMceaeEU0qjcoAGfitwcFfLpp45C34M9APMIqOtJdSRDy//f4H0I18kDr+f6a0Vx6Jqt/GD/uuy/IwUTT00iZjUF/YDE97a2cVeneXdU1LXI87gdQySEM21L2ETpvR3sJe3XotGe1FJmnys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MG73pHxx; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5d3f57582a2so1915382a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jan 2025 05:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736861107; x=1737465907; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E8AoZV5QSgm9bLiWhijrwsLuz1qoBYuWMl/ZwGLWBlA=;
        b=MG73pHxxff5mGIEtDClfE2XygQKYT3AdyAr12RBsEOju7DEAAY+RAtoZ9qmGP6IPw6
         NhUEXL+HaI1kT1Ic53Y2QyuvfD+Rp9W2KF9aFu5ajo6+HQheHvCStnyPOMIHNK8+lcWk
         3Zif3nqbtKYiJk5q6doo2tKAwpyovE2UJE1KKsWBmFMGOLE/bIh/TwZqMMlthgj8eG7Z
         Jbmr1zSF4PObPPuVql3xOVquoKxG/hruSwasNp0JoNYdtRrYerCYO5g/ifUOWk1Wj+D7
         2xWwaMN9JYBdf3Wt7aLl45SSCg0WE+CUPJDJ36CbFXNZUSxOigjDDSFE+K/4JyLEhRU5
         E3mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736861107; x=1737465907;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E8AoZV5QSgm9bLiWhijrwsLuz1qoBYuWMl/ZwGLWBlA=;
        b=N3ue26F1YZijhcTz5fOAn9iRv0ErNJQYQCYYgVwXA5xsDfdO3b+nTLZHDmEJ9ifhAS
         BaPdR2cJZs/jTDHppvboFGfCPzl7J8EdxUUc4cFG5KP06xlh95D5B2a5S9G0eqM/aZAi
         fNAAj8vy4DmltCSkjtGyDgsgsshBCSSAc1U8CLTyaZwbfOffe+6lwvx12CTZM0oZzrnd
         JdqVZtfi5mtv3yMUF2Ga4hdWaYimg7lZKFd7UVnjv+qEzzG/aZcYDCjO7wTFUduXfND/
         Ki8VYH0p+GwIeOq+xPa7GSaECTjidmh/qubF7ECI14K/iDIP5uMpEBVaoHlU//G4cllo
         i55g==
X-Forwarded-Encrypted: i=1; AJvYcCVp7hmRmCuq2T1wS0tK7Q7hDcQYjAubiQlS1A66yjevzIvr7PVj4Z3JHsn+DMXRMpX3qP3QikmFyJ41yCpl@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1TFd959HvYVCFOoDCjjj0rjQNsjmTTveZsPMyjFETi6QZFnO2
	1xoFruWSRFNEnE6TVjWr1/2vEFX3IoLznuJw1LKkDotpT8SBMQMm2nG2DRR+jzpoADVyqfoeU/4
	Yw83LhAZ7H/AQLYDcn5gL71gXEKI=
X-Gm-Gg: ASbGncu/4hN3xKSYfWQWrQhtznWs+qFrSZXEHSHKfptnOKSSw1iUMR3wAVsOhoSVvoI
	SmNzPI4xnkOzrTwZxld+GhN5ahSTPZsZsLLrhKA==
X-Google-Smtp-Source: AGHT+IHe1h2auaaS1BywSg0AAYxGxmeh8jv6DVAXun7itz+nEAD4vbG+OuRZ8HIVMRy7o/yanOO8cfYX28D7Sum8U/c=
X-Received: by 2002:a17:906:99c2:b0:aa6:938a:3c40 with SMTP id
 a640c23a62f3a-ab2c3d4d2c5mr1822957766b.24.1736861106848; Tue, 14 Jan 2025
 05:25:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANT5p=rxLH-D9qSoOWgjYeD87uahmZJMwXp8uNKW66mbv8hmDg@mail.gmail.com>
In-Reply-To: <CANT5p=rxLH-D9qSoOWgjYeD87uahmZJMwXp8uNKW66mbv8hmDg@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 14 Jan 2025 14:24:55 +0100
X-Gm-Features: AbW1kvYfwd1sgIJ-QpvKS-BOMs0QlMN9MyY8-2FxbZu0cU1up3JEh1u7w7Lfm6s
Message-ID: <CAOQ4uxjk_YmSd_pwOkDbSoBdFiBXEBQF01mYyw+xSiCDOjqUOg@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Predictive readahead of dentries
To: Shyam Prasad N <nspmangalore@gmail.com>
Cc: lsf-pc@lists.linux-foundation.org, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-mm@kvack.org, brauner@kernel.org, 
	Matthew Wilcox <willy@infradead.org>, David Howells <dhowells@redhat.com>, 
	Jeff Layton <jlayton@redhat.com>, Steve French <smfrench@gmail.com>, trondmy@kernel.org, 
	Shyam Prasad N <sprasad@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 14, 2025 at 4:38=E2=80=AFAM Shyam Prasad N <nspmangalore@gmail.=
com> wrote:
>
> The Linux kernel does buffered reads and writes using the page cache
> layer, where the filesystem reads and writes are offloaded to the
> VM/MM layer. The VM layer does a predictive readahead of data by
> optionally asking the filesystem to read more data asynchronously than
> what was requested.
>
> The VFS layer maintains a dentry cache which gets populated during
> access of dentries (either during readdir/getdents or during lookup).
> This dentries within a directory actually forms the address space for
> the directory, which is read sequentially during getdents. For network
> filesystems, the dentries are also looked up during revalidate.
>
> During sequential getdents, it makes sense to perform a readahead
> similar to file reads. Even for revalidations and dentry lookups,
> there can be some heuristics that can be maintained to know if the
> lookups within the directory are sequential in nature. With this, the
> dentry cache can be pre-populated for a directory, even before the
> dentries are accessed, thereby boosting the performance. This could
> give even more benefits for network filesystems by avoiding costly
> round trips to the server.
>

I believe you are referring to READDIRPLUS, which is quite common
for network protocols and also supported by FUSE.

Unlike network protocols, FUSE decides by server configuration and
heuristics whether to "fuse_use_readdirplus" - specifically in readdirplus_=
auto
mode, FUSE starts with readdirplus, but if nothing calls lookup on the
directory inode by the time the next getdents call, it stops with readdirpl=
us.

I personally ran into the problem that I would like to control from the
application, which knows if it is doing "ls" or "ls -l" whether a specific
getdents() will use FUSE readdirplus or not, because in some situations
where "ls -l" is not needed that can avoid a lot of unneeded IO.

I do not know if implementing readdirplus (i.e. populate inode and dentry)
makes sense for disk filesystems, but if we do it in VFS level, there has t=
o
be at an API to control or at least opt-out of readdirplus, like with reada=
head.

Thanks,
Amir.

