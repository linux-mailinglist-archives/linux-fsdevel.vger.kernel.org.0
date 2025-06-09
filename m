Return-Path: <linux-fsdevel+bounces-51071-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D233DAD28EA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 23:45:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C10D16E865
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 21:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E19021B90B;
	Mon,  9 Jun 2025 21:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LDVtCqHo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD6EBA45;
	Mon,  9 Jun 2025 21:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749505547; cv=none; b=WA2niG8NYGErKL2xFsnhUGnKjwwNdDiX8gvwDHCYg2GhWKMYKt1YWsXXrdUekBglC7734zxXcnACXoKAhu4JV8Zp9vrVmA0cdsSkVbjf11lqfVsWqAjOvmv7SGjc1Dr1AQ7xu7ODxeFt7R2bFHg7XWWKp1iyklcQzsIT46DMy2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749505547; c=relaxed/simple;
	bh=K+0XowzSc80pyAcnbiMZCSdVchWdRzzUrLWatETbJOE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rogDkE5oTmliNyaJHvmuNccS4luoXS1kqlxOe1gAqPNgQQhGv8NpGzjT+oGQ49K+UQwqk+PWpQ9u00p7w/fl7rwQD5MzgOG0CZpCBrItf8NFd3DT3x+lcICFP+M/kyqIXUF3TrCiMvxrllcKUe6mwxtC6xgQeFwj5qOPT0jZv7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LDVtCqHo; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4a58d95ea53so53778401cf.0;
        Mon, 09 Jun 2025 14:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749505545; x=1750110345; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K+0XowzSc80pyAcnbiMZCSdVchWdRzzUrLWatETbJOE=;
        b=LDVtCqHoDwJabFzimn3fuiSWekq+nqOAP7aUlqaiqF+qPxbF2jpSLxEMa7CeeFfD2Y
         ljaTSvlQFWP22hor9hdBqcC0ENxJotXNeuv69QQhPukPGsn7pzdHOvIPbJNS8lBZqkEy
         sKJbvB9m0p+owYH8kyEp8YexU5CvDNRqBe/bCl0ZdVXQBqMLarKyKJmzLO6NVLIJPGFS
         iurt+1jZfQlnadJaHIsd3eIMfUBy4PpgG7t6ZnZmsKPQSdvx55aT6ofNdQZdVotxRbuP
         5bALytFJuikgf2Y1WGVCMUQWTL7HXnUVmtcfO4dahbUqNWUG8p/We4gbVjoEb7ibxXu/
         42AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749505545; x=1750110345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K+0XowzSc80pyAcnbiMZCSdVchWdRzzUrLWatETbJOE=;
        b=hWtDjO9kOGXeG+F5XS8yrq8E97vQxLn/MZSUaOPE+K7e1P/l+ynyDoiHEqm/Iy728X
         afhkYvGZ+ERwzUxEwmWNrLRgpc8RmDi0veQ5oKHjNMwO8OMqgwdVNHvhUv6Ope5rG03M
         E5RukAMOh6KFIu7xYmyn9Co0IiXz2RrY1WbC4und7g8g/Sq+Ci2VMboO3eJ4mUe2tBoI
         3Wn3MQBL0tnPY7Q+u+WIidD+68DDyfU7R+BPz0brKOxYbl0pp/Jq9sS/0hR7LVmbjC1r
         hKvxdcWE6N+mlvjR9LSpdse8eS8QFLy+CxRHWHTQdBydZP7b7L8hUNofKsfLHjBuhfh4
         FuUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVuoT0DVSUduMkCWViXLLLirSpfcWwzRQOzNf3CayJbcxXnlYhzf6D+3JNr4GlDzbl0JYXNZZwRR0esiJf7@vger.kernel.org, AJvYcCWl/SvQWpnPjBSBCEkzs/5acMRbss9yKv0UP9PyfeEtkIEadKof8OaoSIbe0dPryzNZbWDobs2VLTh5@vger.kernel.org
X-Gm-Message-State: AOJu0YxtxXrm/WWUbtt/Npefnqvvl4jsSmLDSJm26SbIHvKM7LBLBh0m
	2Fy7mCa1OtUULsBFvjJVTOXpT+j00w8gbUgV/dVUVf1wnNVbo94q+kB3KdRaa8E+WFBv90sWTdV
	wkhsMAYKLbqIAAwbYv4VKCmwJg+Av1N8=
X-Gm-Gg: ASbGnctmI6P3OUE1wqjsOmXhrRh08mZlMpZFjKppV8rzdZVXlLw5AGpPA2uQ/myZYlR
	MYaFdUYR/yy6XR3OB9biIhSjBn4KO03OjYLQpMG5oQAchbN70piJ2BQoG2kPFIDW7hjvDg5vu01
	pMMiK7bx6VxVLNuJSJvNhF/mPI+JR0OYTpTtjAJOTYHpY=
X-Google-Smtp-Source: AGHT+IHQ7Vpx1pGMDY1yR2wdbYL18pMXz7SEkhMjdDP6iLsHqpUZE6n3GbDFjrZlzizdYiWA28H8seB79Da0PEBBmx0=
X-Received: by 2002:a05:622a:2303:b0:4a6:f9e3:b08a with SMTP id
 d75a77b69052e-4a708dd2c18mr19740681cf.26.1749505545234; Mon, 09 Jun 2025
 14:45:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606233803.1421259-1-joannelkoong@gmail.com>
 <20250606233803.1421259-3-joannelkoong@gmail.com> <aEZm-tocHd4ITwvr@infradead.org>
In-Reply-To: <aEZm-tocHd4ITwvr@infradead.org>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 9 Jun 2025 14:45:34 -0700
X-Gm-Features: AX0GCFutOw6bA0c_bfm8Espvug7OOfcz6XoLAABE8dFmzIi0V9BQLj4G4NJcPZg
Message-ID: <CAJnrk1Z-ubwmkpnC79OEWAdgumAS7PDtmGaecr8Fopwt0nW-aw@mail.gmail.com>
Subject: Re: [PATCH v1 2/8] iomap: add IOMAP_IN_MEM iomap type
To: Christoph Hellwig <hch@infradead.org>
Cc: miklos@szeredi.hu, djwong@kernel.org, brauner@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	bernd.schubert@fastmail.fm, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 8, 2025 at 9:45=E2=80=AFPM Christoph Hellwig <hch@infradead.org=
> wrote:
>
> On Fri, Jun 06, 2025 at 04:37:57PM -0700, Joanne Koong wrote:
> > Add a new iomap type, IOMAP_IN_MEM, that represents data that resides i=
n
> > memory and does not map to or depend on the block layer and is not
> > embedded inline in an inode. This will be used for example by filesyste=
ms
> > such as FUSE where the data is in memory or needs to be fetched from a
> > server and is not coupled with the block layer. This lets these
> > filesystems use some of the internal features in iomaps such as
> > granular dirty tracking for large folios.
>
> How does this differ from the naming of the existing flags?
>
> Nothing here explains why we need a new type vs reusing the existing
> ones.

I'll update this commit message in v2.

IOMAP_INLINE is the closest in idea to what I'm looking for in that
it's completely independent from block io, but it falls short in a few
ways (described in the reply to Darrick in [1]). In terms of
implementation logic, IOMAP_MAPPED fits great but that's tied in idea
to mapped blocks and we'd be unable to make certain assertions (eg if
the iomap type doesn't use bios, the caller must provide
->read_folio_sync() and ->writeback_folio() callbacks).

[1] https://lore.kernel.org/linux-fsdevel/CAJnrk1aXtMcUsmZPCjre1u2=3DmDPhk5=
W5Jzp8HOS+ASxkby1+Lw@mail.gmail.com/T/#ma71d1befb676b948c34f170aa687738133f=
5907a
>

