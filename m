Return-Path: <linux-fsdevel+bounces-51992-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39AD9ADDFF7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 02:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 950ED3A9DFC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 00:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54046BA3F;
	Wed, 18 Jun 2025 00:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SpODyLoq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F9CB67F;
	Wed, 18 Jun 2025 00:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750206273; cv=none; b=kInh825LwZOSKMzmrJ5jHSuV+tt7bfWdkFJZTRFo7zMC2QomKmqTILrecqNRFGZeHjyTzP8qlmXbFfNw9Xau2jAWbSLjv7johq2Zh+fUPX3KAehp2vmJTtpAVv/v9Kt+NO1FQd8+t+4FJjsLfLR/P9r6kZSUMXN78gfWFuNiz7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750206273; c=relaxed/simple;
	bh=zXt5DmrHo97e47mE5opoStzcsKIetqva9mQI4/MGT9M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rUvaqivdlQGT3nJjycSEe9f6yU4gTxiM6OHmouO007+sU0mjqAONBUHQe/R7V4BxDhPQs2USVuA9dMfRFzNQjfeDqO7eUjHvE9Aw5dL5paWx5SJRO7vOBl4w5LixG+c7pBPo7D4x2BdZ1eWNL7f0YhoPcLhpZxPgtDoldUGymuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SpODyLoq; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-453066fad06so47879795e9.2;
        Tue, 17 Jun 2025 17:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750206270; x=1750811070; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XgZNXPKFA1TDIjBFjcM4NUr/afHbKcaGvlKDZetybIs=;
        b=SpODyLoqLzwbIdolBANT9LIJ9chS4RZ1BSYGz2GmkmNf3HWd/YaU4khP+5Y2sVXqCX
         CTmPKshdI4awAtkJA12ghgHeQaM58ebeJTgIvUCpByUcvPuLAGF3zcdeXEuBm8pv4/4N
         2ARXDaEc5jrXtSYWWRAghRo2aHkCIYfs0adI7Y1eJ0Q1H2iDTxsrJ+ZxDfl/fzDTv+0g
         vpHB+hkSyfnNekXcokBGl+5884mutIf9LLspOSYQYc9W/R1CXKxssOi+VjDW+xuQ5FAS
         o6uEh4Je+UzhCV5+eNdxiFOJb7nlfhpmlFtx0l9/gCO7rgDzyltt2ZqNQsCu5duv5o9E
         36iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750206270; x=1750811070;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XgZNXPKFA1TDIjBFjcM4NUr/afHbKcaGvlKDZetybIs=;
        b=XLxkMyBj3v1eeslPnkOdlXpNcTOXtSZFUH+4Z5ct2e2XqzuKYl9ZpdZmTlNRFAaeno
         DS2eJ1uClqBsYxFWABSWoq2gZtB/Ycc63Z93v+eALKUf+BUk91B+i3syjyvGJs5cENH7
         vJsDfWv2somHlyinxgRlDIRmcx81jiji+CwSG2ySfVQmLY+YWDoqYmayXTPaIC8Vy7FM
         BqAu0q3Uect/NZHUrQmbDNZAaNsG+LIiiDRZSfJsF5djJm13Lgg7S+UxRGQvP/eyo3ug
         12ikAFXmHRjsiHHfAFvirN8kaAyIANY3GC4gNQqyEoQwx4+sRH8bPC/pId2NkVCVtNsJ
         Pq2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUcJb4TGQsaGP4IO6U12V8iOlDFW7oJlsmF9Z0PzBu6dRNYvPQa2cevzMRK+ovUZdIETKI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwINrpfGeIDIDvDpPYESsmkcBD5AhDHRyP0hPqwUrtyFRsS4wcL
	FTMg2RDUxs9g1HInW5X9a+uSitIVfgWpON3DUBx1oYiWg4V3Uh1KaX/Z/JEc1LAKkH+hMQTW9mM
	l1uxdeBYefCJKMQBtuXBizaG2vTU3AN4RgQ==
X-Gm-Gg: ASbGncun9th6vQeTjX5e+tGrD91AkATWZtqjZ3B0lqdherealq/JxAwCSwQPQll2Uki
	Exfmk8MnyuC5cjRc2QcRY0L79FwpmCjWRiH17iOYJpVC0IfPMvrw0BB4Zvw1dCEa9zx9HBPfN6g
	wRitaDVnhGjlqXVNzkN7Ow75ZcZzpL6MtoTi+PA1RiPmXXdL+Yb7TRQOhaG2l2Kf+cWwA4nImx
X-Google-Smtp-Source: AGHT+IG7PvPP/qFyPyp24LhOCGlAg6KU1m7Gm6zRAzxA9wUBsAraiJHG+J89R6pXFP29u4WQPfvVm5gDKo93X+fyxAc=
X-Received: by 2002:a05:600c:820c:b0:43c:fa24:8721 with SMTP id
 5b1f17b1804b1-4533caa2186mr149254515e9.17.1750206270074; Tue, 17 Jun 2025
 17:24:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250615003011.GD1880847@ZenIV> <20250615003110.GA3011112@ZenIV>
 <20250615003216.GB3011112@ZenIV> <20250615003321.GC3011112@ZenIV>
 <20250615003507.GD3011112@ZenIV> <20250615004719.GE3011112@ZenIV>
 <CAADnVQLB3viNyMzndwZbfZrpwLNAMcVE+ffwWPqEt5YVa3QaVA@mail.gmail.com> <20250617215353.GL1880847@ZenIV>
In-Reply-To: <20250617215353.GL1880847@ZenIV>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 17 Jun 2025 17:24:19 -0700
X-Gm-Features: Ac12FXzjRN9Z4CX3wbsVYPgrkIbjEikEzvQO7paGtZHXJH5k-Y1sj02vKnLDpss
Message-ID: <CAADnVQK=uJHE9gLjKD7L6J7HOqz=n_RiR0pa+8yZweyG=MY2Ug@mail.gmail.com>
Subject: Re: [bpf_iter] get rid of redundant 3rd argument of prepare_seq_file()
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, Christian Brauner <brauner@kernel.org>, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 17, 2025 at 2:53=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> On Tue, Jun 17, 2025 at 10:31:37AM -0700, Alexei Starovoitov wrote:
> > On Sat, Jun 14, 2025 at 5:47=E2=80=AFPM Al Viro <viro@zeniv.linux.org.u=
k> wrote:
> > >
> > > [don't really care which tree that goes through; right now it's
> > > in viro/vfs.git #work.misc, but if somebody prefers to grab it
> > > through a different tree, just say so]
> > > always equal to __get_seq_info(2nd argument)
> >
> > We'll take it through bpf-next,
> > but it needs a proper commit log that explains the motivation.
> > Just to clean up the code a bit ?
> > or something else?
>
> Umm...  It had been sitting around for a couple of years, but IIRC
> that was from doing data flow analysis for bpf_iter_seq_info.
> I really don't remember details of that code audit, so just chalk
> it up to cleaning the code up a bit.

Applied to bpf-next.

