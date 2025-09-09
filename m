Return-Path: <linux-fsdevel+bounces-60697-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21385B5022C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 18:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB5103B5B9B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 16:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DEAA33A01A;
	Tue,  9 Sep 2025 16:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SO9C87Vt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9A02581;
	Tue,  9 Sep 2025 16:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757434317; cv=none; b=nc6M+WQjZRfLIWIt7H4ZL9pRNaSxlR6JS2jHe6KRrseJpGXSF+8oYzb1rkkCpJm8kp8zhYDVhXMs0UwTcymU1mmvHlD1uLOo2xnoH+GUdGsDUCrCjv+NlYYHCiKiaN75951w5Eoo+KmF0VYRWCCtMIKLyTT4wuwa1LwiRC2rmck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757434317; c=relaxed/simple;
	bh=js/jWU+oRHg6EL1y1KsiH3ZNH4vNpY4QO/wJJQBOThM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=JsYneaNrDoPRgI+cMhVPSQiHudxUAnyXrZc7kaS9C6t0x0/Ukxyzn5Pjj/2gDegok8v5WjaYMHKgTp7NJTU4aUc+go4nmjXQkReQH15AaRWC324GbSGDH26wZMn0gGidgH4iNu9M7DSrbY9wmRdTeDipBg5IxuVea2Io52M4rX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SO9C87Vt; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-30ccea8a199so5569657fac.2;
        Tue, 09 Sep 2025 09:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757434315; x=1758039115; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=etFcAHfQGjj/bNL5YauQ7vtUmcpfGKbQ9fB/iXTWgj4=;
        b=SO9C87Vtuf4KsSIBZWiATBoIVw3uG86g4xnppUpYhA2uNHQ87dlfUhpcemvBCMtGr4
         SM6pWIGj6FFbWiT6snAYDqJ2uU1RX3tw3M9+oJhvAiry50ssY3oR468pHAc5LxKDC4bc
         DQHy7LVtxZmc1w0NyQd58P5kN2JWHJQsK3LzKaauZi8eNnhRmyhr29gqx7Z/2kCCWMht
         MgtDIhq9KqAc30oO54p4pkTCRYpedroshGQEuUWtb1g/csVtdecrXAADfBdu/Fe+lny4
         ccgJYwET+OAl/4bzP7bMZg/cILY6PiSfOoVZ8Fb0e9BfBe7lV394mx25rip5Va7b4IWM
         8QCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757434315; x=1758039115;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=etFcAHfQGjj/bNL5YauQ7vtUmcpfGKbQ9fB/iXTWgj4=;
        b=ZRe7iVrLrWfBHHGxapDj220ye6NZmbY6PK1XHHf+K36Q16CRez9BNsyw9UfjY+886/
         WAtdCCMb20Q2j8ItDEfzytE34C+EJZuEQU36DHOx18EfgytigooOu/mbZi0REeMK6niu
         hRM4/VQ/5iqK1DnmDCnKuAs4TdVbDH7zwlkArfC33dNvRTiO6nSiIXW0wOfp6+vcMxyk
         Ba5tXeswXOi2UuLQ3bOK/q0OhAZP/lII1UYwqjC4ML+kgFNYxBXSJ40DfCI1L+7YPu1x
         GvVpRv3re9RQP8r7aqR7IgR063l5fkC06/5wediS3O1dRBjDFSeV09VlE9+ZtIcZ84Pz
         pzZA==
X-Forwarded-Encrypted: i=1; AJvYcCXdMeiQl0dBhPxiBr7q9qcrpo8GyyOslWtmnEY8HebSpkSn5PO7jYGHHWQ2ypWM1vFcv/BVgGCrYgA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoZDas21UyENabEbl8Ys9SOcsy8dkYaG67959Sb/1wYp/vTjWA
	CQHMoDonEBRX2DzhOnt28GK/iR5ANXrgTX73XcCI1GtAruoVoAoomtnJkyJ+3fJ9OpxfdpZvRGc
	25WrvUsxYlw/iL/o/bOyvwB/Mc7loBvmSmg==
X-Gm-Gg: ASbGncu44PyVsDHUrRAUN14yTuy65Zn5wOsY0jPe2/2aB6dlCyFC0D03eXieoWzYwgq
	RvBoOdxqnXiNPebjePPZuvSDCNIxGS35nDvyhWI+CfwWqrxKCoLfRZYn8QpPe/E1u8bNnE6UhiO
	VR/r6Dy00T+3YKiPwPolHhUp9Boqccgn3xnqkOKNjwV7k/6bK6wPnwJ2kGqP4p8S7v7d0njUfsT
	Rtw+GNqjx4kxXtHIA==
X-Google-Smtp-Source: AGHT+IFVzrIseq70zDPMTJo+cSUlpMZMmdzFvybDR1Je5VSWYcTElJbpESw3HGCsSpia2LM8f9F7hgtStihevMojNkQ=
X-Received: by 2002:a05:6870:1496:b0:319:6233:ba6 with SMTP id
 586e51a60fabf-3226533780amr5929459fac.40.1757434315257; Tue, 09 Sep 2025
 09:11:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALXu0Ufzm66Ors3aBBrua0-8bvwqo-=RCmiK1yof9mMUxyEmCQ@mail.gmail.com>
 <CALXu0Ufgv7RK7gDOK53MJsD+7x4f0+BYYwo2xNXidigxLDeuMg@mail.gmail.com>
 <44250631-2b70-4ce8-b513-a632e70704ed@oracle.com> <aEZ3zza0AsDgjUKq@infradead.org>
 <e5e385fd-d58a-41c7-93d9-95ff727425dd@oracle.com> <aEfD3Gd0E8ykYNlL@infradead.org>
 <CALXu0UfgvZdrotUnyeS6F6qYSOspLg_xwVab8BBO6N3c9SFGfA@mail.gmail.com>
In-Reply-To: <CALXu0UfgvZdrotUnyeS6F6qYSOspLg_xwVab8BBO6N3c9SFGfA@mail.gmail.com>
From: Cedric Blancher <cedric.blancher@gmail.com>
Date: Tue, 9 Sep 2025 18:11:19 +0200
X-Gm-Features: Ac12FXzbsF3a5xsYffeLavcVAGeesi8c1gDuCOtzJN_iAGeVvkh68KeBHUZcx9s
Message-ID: <CALXu0Ue=89nUcDBAdvptAT7gA=3VGvRkAGUb85nJvwr=NUnCfg@mail.gmail.com>
Subject: Re: NFSv4.x export options to mark export as case-insensitive,
 case-preserving? Re: LInux NFSv4.1 client and server- case insensitive
 filesystems supported?
To: linux-fsdevel <linux-fsdevel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>, 
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 9 Sept 2025 at 18:06, Cedric Blancher <cedric.blancher@gmail.com> wrote:
>
> On Tue, 10 Jun 2025 at 07:34, Christoph Hellwig <hch@infradead.org> wrote:
> >
> > On Mon, Jun 09, 2025 at 10:16:24AM -0400, Chuck Lever wrote:
> > > > Date:   Wed May 21 16:50:46 2008 +1000
> > > >
> > > >     dcache: Add case-insensitive support d_ci_add() routine
> > >
> > > My memory must be quite faulty then. I remember there being significant
> > > controversy at the Park City LSF around some patches adding support for
> > > case insensitivity. But so be it -- I must not have paid terribly close
> > > attention due to lack of oxygen.
> >
> > Well, that is when the ext4 CI code landed, which added the unicode
> > normalization, and with that another whole bunch of issues.
>
> Well, no one likes the Han unification, and the mess the Unicode
> consortium made from that,
> But the Chinese are working on a replacement standard for Unicode, so
> that will be a lot of FUN =:-)
>
> > > > That being said no one ever intended any of these to be exported over
> > > > NFS, and I also question the sanity of anyone wanting to use case
> > > > insensitive file systems over NFS.
> > >
> > > My sense is that case insensitivity for NFS exports is for Windows-based
> > > clients
> >
> > I still question the sanity of anyone using a Windows NFS client in
> > general, but even more so on a case insensitive file system :)
>
> Well, if you want one and the same homedir on both Linux and Windows,
> then you have the option between the SMB/CIFS and the Windows NFSv4.2
> driver (I'm not counting the Windows NFSv3 driver due lack of ACL
> support).
> Both, as of September 2025, work fine for us for production usage.
>
> > > Does it, for example, make sense for NFSD to query the file system
> > > on its case sensitivity when it prepares an NFSv3 PATHCONF response?
> > > Or perhaps only for NFSv4, since NFSv4 pretends to have some recognition
> > > of internationalized file names?
> >
> > Linus hates pathconf any anything like it with passion.  Altough we
> > basically got it now with statx by tacking it onto a fast path
> > interface instead, which he now obviously also hates.  But yes, nfsd
> > not beeing able to query lots of attributes, including actual important
> > ones is largely due to the lack of proper VFS interfaces.
>
> What does Linus recommend as an alternative to pathconf()?
>
> Also, AGAIN the question:
> Due lack of a VFS interface and the urgend use case of needing to
> export a case-insensitive filesystem via NFSv4.x,

Just to clarify one of the use cases: If your Windows home dir is on
NFSv4, and try to install software like Chrome, Firefox, VMware as
user in your home dir, then you have a very good chance that all your
DLL files are spelled mixed case, but lookups for the DLLs come in as
either totally uppercase, or all lowercase. Sometimes all lowercase,
except the ".DLL" part.

If the NFSv4 attribute case-insensitive would be set correctly by
Linux nfsd all would be fine, but if not then the software will not
work. Unless you do what Microsoft support suggests: Please use the
Windows NFSv4.1 server, then all-is-fine(TM)!

Ced
-- 
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur

