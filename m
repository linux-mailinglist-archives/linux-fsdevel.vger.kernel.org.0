Return-Path: <linux-fsdevel+bounces-34669-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ECC69C7940
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 17:50:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EC3DB46030
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 15:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5802014AD2D;
	Wed, 13 Nov 2024 15:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Woz/m7VV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2FA13A268
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Nov 2024 15:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731513005; cv=none; b=kcVW7MlqPZdIuY5A1O2u5A1WjOvphTii0/7IOVxSRTJDqtn9YEOnyqReQLD0/SXlR4pj49xC19tNCL5EPgA3OG+CJlgPRG6bYwB74V2q2GuN3mjeOnes0o71eWyhPml5FRqxYkoGdK2ijkbTZHasudcjD6fzoMoDoE6KYFt43XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731513005; c=relaxed/simple;
	bh=qrf/MX5X0AlGXFJLUG/+BKtBhPdJUqAIibpijCzk5yM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ux9sSNbmsWfKoj+YlS+CqcJiITLY7lLrlh1Ue4dDVUXYQyOJVM6MWtsb6QHOjzYnJJdQi0naCLAgstZz0golEl0DItVIMk449z/88zlz7ORcjVZpuW3jD5p8bHVG59cQBSPCqQMT6I4e8YunRSAZSfpkw/ea7oCtOZ9Ejq3vWos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=Woz/m7VV; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-460e6d331d6so43770561cf.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Nov 2024 07:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1731513003; x=1732117803; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=F31sh03i/CliLI3oNgShFd0ApDGB/QRNyhmfoCFlyGs=;
        b=Woz/m7VV8Y/+/WzjHzxxbfSYuQt+dTFp0g3FGhHI5F053A9RuynSdV8fPTLG5nVwr1
         7auWO8JNKQKKJHYiTM6NoLAhfS8Wsc51TDfn18eErGWkvTsFr0hv2Ns4W9FDCuDV8wZE
         wgW63fYhI73LyQVxAYOUh4/wu+9HV3OufclIQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731513003; x=1732117803;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F31sh03i/CliLI3oNgShFd0ApDGB/QRNyhmfoCFlyGs=;
        b=QTZsf1yyRC3EMPvyo4YUGTvVi3LUlamjjLl57VLXyB3keSlUcjawEvW/ZD99NaPxhs
         J0uzRxDxTjiiejampyOzMiX3DuuPlIVgmIcph3aPwCRe8CkRRzIhPcAHzOOswgkmwhUN
         aFcN3rowG74n8ZcH/6grw5p9YTcvOao1c5IihJUA4UVVI/+xC5/d0sj/kEhy/SGsvVw2
         KxVgiwgKv+6vq88nftH6Wg+dLAyUBq1+TIUEgX/kMlzikl08jzo5KOEjBCnEt2IAQKxI
         N8xqoFG9ogNDum7MY00+zotbtk0O25RKoDL89my7N3xlrNu+g1Pv/bU+dQ+817OkjUQH
         T/sA==
X-Forwarded-Encrypted: i=1; AJvYcCUVwodcEbvrwOwsFLDKPRB3YvfqF7Xz+28T8Hv5I7ognBVSxFGA+hm+h9EtYsQMirYGlVHe5CddpSTQid1Y@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+tir7xDKVM2ZAMV7lQOt3SrIu6F0vIOThYz/6/LuonExDMGYY
	sG8uJPpVNbj1PZJAp0Tft3HiH2y4MMVYgvXjL7socZsfnKtkbE6JOZUhz4FePBPOiR4nWATH8r1
	lf9Ei6cgUt+X+lBdtHALOQ0FrWCQ8pK7F4v07hQ==
X-Google-Smtp-Source: AGHT+IEz2vBQN8hRZ8EkBdXBC1NMCb1WkDSP1kv0lHCN9eUb5EuuKrzEddrDEc5mNi805ys4pKBxJF9Fv++NH94aHFA=
X-Received: by 2002:ac8:5dc6:0:b0:458:4129:1135 with SMTP id
 d75a77b69052e-4630930660fmr304637211cf.9.1731513003130; Wed, 13 Nov 2024
 07:50:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241111-statmount-v4-0-2eaf35d07a80@kernel.org>
 <20241112-antiseptisch-kinowelt-6634948a413e@brauner> <hss5w5in3wj3af3o2x3v3zfaj47gx6w7faeeuvnxwx2uieu3xu@zqqllubl6m4i>
 <63f3aa4b3d69b33f1193f4740f655ce6dae06870.camel@kernel.org> <20241113151848.hta3zax57z7lprxg@quack3>
In-Reply-To: <20241113151848.hta3zax57z7lprxg@quack3>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 13 Nov 2024 16:49:52 +0100
Message-ID: <CAJfpegt5_5z1qSefL-Y7HGo0_j6OZGTQfM74wG6N2Q__vB0DsQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] fs: allow statmount to fetch the fs_subtype and sb_source
To: Jan Kara <jack@suse.cz>
Cc: Jeff Layton <jlayton@kernel.org>, Karel Zak <kzak@redhat.com>, 
	Christian Brauner <brauner@kernel.org>, Ian Kent <raven@themaw.net>, 
	Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Lennart Poettering <lennart@poettering.net>
Content-Type: text/plain; charset="UTF-8"

On Wed, 13 Nov 2024 at 16:18, Jan Kara <jack@suse.cz> wrote:
>
> On Wed 13-11-24 08:45:06, Jeff Layton wrote:
> > On Wed, 2024-11-13 at 12:27 +0100, Karel Zak wrote:
> > > On Tue, Nov 12, 2024 at 02:39:21PM GMT, Christian Brauner wrote:
> > > Next on the wish list is a notification (a file descriptor that can be
> > > used in epoll) that returns a 64-bit ID when there is a change in the
> > > mount node. This will enable us to enhance systemd so that it does not
> > > have to read the entire mount table after every change.
> > >
> >
> > New fanotify events for mount table changes, perhaps?
>
> Now that I'm looking at it I'm not sure fanotify is a great fit for this
> usecase. A lot of fanotify functionality does not really work for virtual
> filesystems such as proc and hence we generally try to discourage use of
> fanotify for them. So just supporting one type of event (like FAN_MODIFY)
> on one file inside proc looks as rather inconsistent interface. But I
> vaguely remember we were discussing some kind of mount event, weren't we?
> Or was that for something else?

Yeah, if memory serves right what we agreed on was that placing a
watch on a mount would result in events being generated for
mount/umount/move_mount directly under that mount.  So this would not
be monitoring the entire namespace as poll on /proc/$$/mountinfo does.
IIRC Lennart said that this is okay and even desirable for systemd,
since it's only interested in a particular set of mounts.

Thanks,
Miklos

