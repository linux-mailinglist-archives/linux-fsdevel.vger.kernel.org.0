Return-Path: <linux-fsdevel+bounces-32055-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2095F99FCFD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 02:16:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9967286B47
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2024 00:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91913AD31;
	Wed, 16 Oct 2024 00:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="dGDehaZp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868454A1B
	for <linux-fsdevel@vger.kernel.org>; Wed, 16 Oct 2024 00:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729037770; cv=none; b=I8aaKbgpQGe+OsN5Bt1NBpEbOcOHwy6JX4m4FfMVEFNW40YQHZ/fdZ4J2cqWzxlbfAi07cwabSvGubTslhhVjs5BaEhvkDSyi0/8EvEad1codkl5331cIv8G6BL8T2Le/9shtN48eKXBuxBUX7CobLcMrCCOaOUsAepz1zjhUd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729037770; c=relaxed/simple;
	bh=0RR+M6O+iq8XIjRHinrWxf3DoFEOcB1Lx9Es2nZTe7Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WcXwJUChUskcsPOo84nWkXka9D2t2l7kk7fN6PDs/DcG1C0W5Aogeb8yZ7PrjyCM5Y+9v5zfvhnVrrM6MBvlLhyywkSVhGRFAvwjN53TFvw3j268q+3vCaSrEWiQR9xgOv5d94P/z8xsk6xIwyL3pgLEaa9zasOtlC3RwyYelN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=dGDehaZp; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6e2f4c1f79bso52392517b3.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Oct 2024 17:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1729037767; x=1729642567; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VwIVXsv+0K/tRmuz74E0Mk7+OGVGSOJtC2LxGockSrQ=;
        b=dGDehaZpDW550MqhEsubuL0aypwzrX+ohNp1JqHP0Hs+rHzC4CpkSSKRsfZRBvPO8a
         ERfYEh4QNBihDwgaASzOEhV5vbi/OiluvS6YRM9iURxg2dEET4bQwOUnXT9N8qIz2HbF
         Nbho2eXwGJBggUJYqhvi+W06qM5lqkOpo5KTGQ31gI1NUgU2dsC1g/orSbwv+Cgaa3Zc
         WW4vwAvsdn+gg1Vaii/eU4In/QbMrCXhEXDouaJhpW+tSmpzwn8CXxbR86q5vg2V2prR
         yS8I3d+5o5pG9m2HdnyLWnF4jQDeEieodCU+/uWQKn/nfBD3zLVvnV7/MrI36nCOIa8f
         /Euw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729037767; x=1729642567;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VwIVXsv+0K/tRmuz74E0Mk7+OGVGSOJtC2LxGockSrQ=;
        b=X++R3A12nuDO+5g0wlByk82spYGfpqaLPaMdoA+SA8SudHfu8AbvZ2eNcY7z2L319/
         cDCc5NnFnHuvekhhAPacFpsCf0eQGQNcW6q6WLaS9FeTxiTtZ/bLxwdFTH4QKg8o7e6Y
         70wdwbusKMNCNq8Are9zG2KIPNhJuY1HGaLmjF+xBvaaXYBDfXBMSlcsJJmz68ZORvfk
         nSykA5O6cQKTBbjWv+ouxRqBPAJrCbPXryr/E2Ln3N3BnstHK5POeMH1bxcyb/dP257/
         DAUvAusIUBSlgfLb2RH7C/LRNwrsjPlR/Xg9OeBsAwhGBXWWQ42oVDIarF9DAEsmRMT+
         0oHQ==
X-Forwarded-Encrypted: i=1; AJvYcCW07yZsBwYvCd3c4rT9ndk7rsskPIIPER3tRVLeMkTmqS73lNmNDj/L5i3soDAWfVA5kXZw5IuvaNSaKMNm@vger.kernel.org
X-Gm-Message-State: AOJu0YwgLYR6V5v8N7WFqWUOj8kxXv5OmlvGueEWjUuvOBd2OmmGB+jg
	RwUhxsF+ooUK73aTyZFQSJARN2usC1NqBvWRr/XA/3orUGUl9JEPpNbaFX8/R6XkA7LkI+eoFWX
	676WOOBKJlSglevP+4XBEd+z5HJLgzDsHV12n
X-Google-Smtp-Source: AGHT+IESf3Jz8ORecE7b8c1bkUbZCtOoJ2cisSrtY1CixXa6d/r44qsu/muJ6kPqg3NbhmLKJVsXrujBGNQ70iaASHI=
X-Received: by 2002:a05:690c:5719:b0:6e2:50a:f43b with SMTP id
 00721157ae682-6e347b368c0mr95998737b3.35.1729037767509; Tue, 15 Oct 2024
 17:16:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010152649.849254-1-mic@digikod.net> <ZwkaVLOFElypvSDX@infradead.org>
 <20241011.ieghie3Aiye4@digikod.net> <ZwkgDd1JO2kZBobc@infradead.org>
 <20241011.yai6KiDa7ieg@digikod.net> <Zwkm5HADvc5743di@infradead.org>
 <20241011.aetou9haeCah@digikod.net> <Zwk4pYzkzydwLRV_@infradead.org>
 <20241011.uu1Bieghaiwu@digikod.net> <05cb94c0dda9e1b23fe566c6ecd71b3d1739b95b.camel@kernel.org>
 <20241014-turmbau-ansah-37d96a5fd780@brauner>
In-Reply-To: <20241014-turmbau-ansah-37d96a5fd780@brauner>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 15 Oct 2024 20:15:56 -0400
Message-ID: <CAHC9VhRdkByXa7SA9LqNrRyU6EfhezHENdrToQxYJCakPS-YcA@mail.gmail.com>
Subject: Re: [RFC PATCH v1 1/7] fs: Add inode_get_ino() and implement
 get_ino() for NFS
To: Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org, 
	audit@vger.kernel.org, Trond Myklebust <trondmy@kernel.org>, 
	Anna Schumaker <anna@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 10:45=E2=80=AFAM Christian Brauner <brauner@kernel.=
org> wrote:
> On Sun, Oct 13, 2024 at 06:17:43AM -0400, Jeff Layton wrote:
> > On Fri, 2024-10-11 at 17:30 +0200, Micka=C3=ABl Sala=C3=BCn wrote:
> > > On Fri, Oct 11, 2024 at 07:39:33AM -0700, Christoph Hellwig wrote:
> > > > On Fri, Oct 11, 2024 at 03:52:42PM +0200, Micka=C3=ABl Sala=C3=BCn =
wrote:

...

> > A better solution here would be to make inode->i_ino a u64, and just
> > fix up all of the places that touch it to expect that. Then, just
>
> I would like us to try and see to make this happen. I really dislike
> that struct inode is full of non-explicity types.

Presumably this would include moving all of the filesystems to use
inode->i_ino instead of their own private file ID number, e.g. the NFS
issue pointed out in the original patch?  If not, I think most of us
in the LSM/audit space still have a need for a filesystem agnostic way
to determine the inode number from an inode struct.

--=20
paul-moore.com

