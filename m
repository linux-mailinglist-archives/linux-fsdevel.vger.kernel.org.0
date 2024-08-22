Return-Path: <linux-fsdevel+bounces-26722-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D71EF95B5DB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 15:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1314C1C23286
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 13:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6B71C9457;
	Thu, 22 Aug 2024 13:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="SgcfKAav"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20884181310
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2024 13:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724331877; cv=none; b=fWz5/KGNSOnHNgnFZlMf7Xm+jlIk3VHnwJ1951B/+cEgTyeudW5uiDGzn44r367lXRuqL+C/Aoq3QV/T/s1xmIJQIAxD36XwPN+rl1KstS8RtTaQzO1wPsJdD4adz3JMRM+sXVmdRb0cNdBuXvEwEOAHJv6FpBTNeTTYIm6KvnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724331877; c=relaxed/simple;
	bh=D+1WQ68JOORTtyd+QfOGQg+vLGFePAHV2FySa5bKN30=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B7CLg/A85+4sgReoaBd8rr5ma28bRSMNUvr39rTdy8ZgWueDhaJon4CWxjWeKwU1ZkZzCWSC7nJjh5V53N7TINdrTvdx+XVqlKGMyi4Hu9BudmWfMIzuYQXKjfsxrUVQc646V0tfGOU4JWVQ7o+NUfGQklOkGW96z9tp/EmDWmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=SgcfKAav; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a8695cc91c8so65060966b.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Aug 2024 06:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1724331874; x=1724936674; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HLb82jSgV/hhu3fWmDhL9/8Eb0IU1BoT2mlOlFTBoFw=;
        b=SgcfKAavmM+iADVCdlBwEddRW5KDGcTBiEFLw1KB/0o6dUqqmAYIIRZtBmIU9T1US/
         8TN+2WBu31zCCeIE/nwwfeeYG798Q5KKYh+U+QU6lpiblPblFpcKXZjagFyBj6IUG4HB
         YreSWo/F1NrYDEG+VzUIFWGlsbkIV19i34iW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724331874; x=1724936674;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HLb82jSgV/hhu3fWmDhL9/8Eb0IU1BoT2mlOlFTBoFw=;
        b=ija0aH8YaRp6VX40uMaQxAihHI+lbZQKRoLNzWDq/I5emWBcWYtuqQsG049i87506W
         XyTtQkabg7UnlAf1otK532OS0xEGKXurtYz5Gi7VxaSSUobLKSEpdsI+v+tjUy+h18bD
         H3RMmXriwJ3UYcIH4RXP9LdwNXfAvY9BEnUWwsvdO8hHmF1ShrBX2l6Th1BpNN98PTWv
         XKzVyYwN0FirdQMsy3v5rSEehh4U/NOscYJXMXw7+KrTAQ+QfP7BL99YvlnYNw3hhafq
         Kg7q9Ip770JoEPhZULu8Vv51wrJvnRPQQfXRgRWMmm73tP4vMevwy97AuEGdhMU8n8jx
         p+xg==
X-Forwarded-Encrypted: i=1; AJvYcCU02Rr4lkFaJFdTv7mwaHq0AaZ27HJWMgoIx6Cvh0343OMF89JglZgLq175sTcu5t1tI+PvKG768r1BtLG6@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/GwY11IkzIKjVLE3BjWwof2FePnKZ6i3lPTuCYpqG5hiEVqMW
	bAs1fMRikPNwmMqw0Dy6RwfOVnKuyACtWqDtnYOP81x0rOegZ9AOlSPVoFk54EmmY7RTaaoBQ6T
	E4umJy1xQZQMRRtUS9qJAHXVO5TyClV06jkpjtQ==
X-Google-Smtp-Source: AGHT+IGsRxUoVr4muJ/9PbrSNtMaKnDsQiFUFPrNJQ/sKNunGXBx6l2Y8CIg9xTkIaYzflu0CGRm420SfEdBXu4IJ5A=
X-Received: by 2002:a17:907:2da2:b0:a7a:bae8:f297 with SMTP id
 a640c23a62f3a-a866f2a0205mr473759766b.15.1724331874075; Thu, 22 Aug 2024
 06:04:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <792a3f54b1d528c2b056ae3c4ebaefe46bca8ef9.camel@bitron.ch>
 <ZrY97Pq9xM-fFhU2@casper.infradead.org> <5b54cb7e5bfdd5439c3a431d4f86ad20c9b22e76.camel@bitron.ch>
 <ZreDcghI8t_1iXzQ@casper.infradead.org>
In-Reply-To: <ZreDcghI8t_1iXzQ@casper.infradead.org>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 22 Aug 2024 15:04:22 +0200
Message-ID: <CAJfpegvVc_bZbL1bjcEbEh4+WU=XVS94NMyBPKbcHzAzyxM6_Q@mail.gmail.com>
Subject: Re: [REGRESSION] fuse: copy_file_range() fails with EIO
To: Matthew Wilcox <willy@infradead.org>
Cc: =?UTF-8?Q?J=C3=BCrg_Billeter?= <j@bitron.ch>, 
	linux-fsdevel@vger.kernel.org, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 10 Aug 2024 at 17:12, Matthew Wilcox <willy@infradead.org> wrote:
>
> On Sat, Aug 10, 2024 at 07:56:21AM +0200, J=C3=BCrg Billeter wrote:
> > Thanks for the quick response.
>
> Thanks for the quick test!
>
> > On Fri, 2024-08-09 at 17:03 +0100, Matthew Wilcox wrote:
> > > Do you have CONFIG_DEBUG_VM enabled?  There are some debugging assert=
s
> > > which that will enable that might indicate a problem.
> >
> > With CONFIG_DEBUG_VM enabled, I get:
> >
> > page: refcount:2 mapcount:0 mapping:00000000b2c30835 index:0x0 pfn:0x12=
a113
> > memcg:ffff9d8e3a660800
> > aops:0xffffffff8a056820 ino:21 dentry name:"bash"
> > flags: 0x24000000000022d(locked|referenced|uptodate|lru|workingset|node=
=3D0|zone=3D2)
> > raw: 024000000000022d ffffd9ce04a827c8 ffffd9ce04a84508 ffff9d8e0bbc99f=
0
> > raw: 0000000000000000 0000000000000000 00000002ffffffff ffff9d8e3a66080=
0
> > page dumped because: VM_BUG_ON_FOLIO(folio_test_uptodate(folio))
>
> That's what I suspected was going wrong -- we're trying to end a read on
> a folio that is already uptodate.  Miklos, what the hell is FUSE doing
> here?

Ah, this is the fancy page cache replacement done in fuse_try_move_page().

I understand how this triggers VM_BUG_ON_FOLIO() in folio_end_read().

What I don't understand is how this results in the -EIO that J=C3=BCrg repo=
rted.

Thanks,
Miklos

