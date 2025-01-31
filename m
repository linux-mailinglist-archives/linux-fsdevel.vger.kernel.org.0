Return-Path: <linux-fsdevel+bounces-40498-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB335A23F37
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2025 15:39:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE2533A4080
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2025 14:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A791DDC3A;
	Fri, 31 Jan 2025 14:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="cJpqOS8h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A314502A
	for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jan 2025 14:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738334386; cv=none; b=X1xuzSSRGdOnxm5dtlqRqA21WxebEp1RhRftbJ7wRrrGLqgjkVc6/WNKq2wldGlNXIda0sNZbbF8Qp9e6PGzAT64FIbqmZTSdBRe2T/UcecBGFkNYKfD3/PH74k14zxMzVSX/wCnbvqCtpXmn79kAdndxQn4gDYsqBKjLrM9ghM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738334386; c=relaxed/simple;
	bh=6xsGyvdgrzA9tWzH0xf7HP+L4ODLpgpCkWElzj+vao4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GOYsLUuMGBipoGVxk8BAj8QBZJIabLC5J0bJZ4WGO7jvcAAXDAitRLGFeCc5Ywalpi4W05SYcL9pPx0c8dAOLQjevt8vSwsFz5uLLDju9im30pnOyiT4CpZXiiUZVKLnCBpcvMtKgAmx4VM9fiL/Q+5Q6GyIwW5L0wRoThbMeac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=cJpqOS8h; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6eff5f6fe07so7936887b3.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jan 2025 06:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1738334384; x=1738939184; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1l+aerKYBDSo/0m7wIE29H/4F+oEOdV4WNPtkzjhXyA=;
        b=cJpqOS8hizaavXzfy0LQOznD8LK1H2i1d3tbpwUx3PK4Qc7HoMpFr7SQnCtUo6+KEH
         nAriUDBpVdxDcazOFLl8gPb96kbw312Az4ZjwuP/yGwvsjAQStBABdSlcZ4Q+HGIXIsF
         mkCPnh6T6x6/+wrSCCfdufWa2HZVJsdRLS3knu9nN0/JxM9qUDSfze1eckP1hDCYDNFR
         6LG0kd0CJMGvYu1dsGzHHVwgrKhNUYxQVSqNgtRjjnnd0QPZemQkuJBvBhYn8zwAmrkG
         fpm71cr0cB9zBlwD1SBAldP0QnTcBGkStY/CbvXS8/9fxFuci7FzbI23zGSfBQQF6dWB
         D/xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738334384; x=1738939184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1l+aerKYBDSo/0m7wIE29H/4F+oEOdV4WNPtkzjhXyA=;
        b=AXba4VFbIDCqgHhLDK2koqzmrseyX+XEmntgIXS7pir4HgrO52Em73SBSJLtgXldlN
         epabZoNWB+5fSGUwlyl2MMhS77P6WZEuRswNJjeCEj9jnJD9GlaDOM3PbigD7TLAzSK2
         BmmXF0Req19wuBbEvLpiWDEqwgbp5AT5/PhpjPjCeVMhcNQL2yY0ffVlXONxwO3kvisY
         rTLUEMHbR5vcOVZvoqmqXRkomHqvYHk7xcBCoD6YaSLdXvk+YUg98fzBD4jY3m55hyxN
         WzBx1cR4RqkTZKxDuNW6WT0qeTXKYBMOk52Ri4EKbWxgKTFFSqjfd/JMIC6KlJUvsMzr
         yTxA==
X-Forwarded-Encrypted: i=1; AJvYcCUkehqB8X3jLjviJ1xnqSTdFrls2o8nLULRJwPcFj4+2O9nqYSGTf6a1VR+DbTCzt+FJ4KHFIUT79xtl6tY@vger.kernel.org
X-Gm-Message-State: AOJu0YwSC9jFyhP0fuWzCQlGVYUBtXU2qedbTZX618pJeHfDDXEJM9nn
	s1vgnI03Mu+KmElM3QgPrKNwOO0+yOSlMT8xGJeFcNHoyKxvk4W4SSd8UbpTWdEQMvD6ZMxdaT8
	D68kWVnKCzayH5jppwtWfuwrne6XI6qfFRngG
X-Gm-Gg: ASbGncujn+dwC6eoAtFJ2OSg6Z//6RqzBBqn4qs/wLjptxG8H02Cy5ccKyVFueRlpq3
	NJvvfy056680PM+rQnHPVZcuxWInzG7Vhg8Q2QyJIGHXOhXmOh8kXeUdlTRgYQMF6Isobhbk=
X-Google-Smtp-Source: AGHT+IHyZy2tWc2K57qbPizzQYtbfS/OLJCGfMsN3B8yddb8SJjDjY6kW2T7VzcXc7cUBMqnl5g6oMciW+s0Cp9InaY=
X-Received: by 2002:a05:690c:610a:b0:6e2:41fa:9d4 with SMTP id
 00721157ae682-6f8c19b2dfbmr61453817b3.15.1738334382440; Fri, 31 Jan 2025
 06:39:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250129165803.72138-1-mszeredi@redhat.com> <20250129165803.72138-3-mszeredi@redhat.com>
 <CAHC9VhTOmCjCSE2H0zwPOmpFopheexVb6jyovz92ZtpKtoVv6A@mail.gmail.com> <20250131-durften-weitblick-075d05e8f616@brauner>
In-Reply-To: <20250131-durften-weitblick-075d05e8f616@brauner>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 31 Jan 2025 09:39:31 -0500
X-Gm-Features: AWEUYZlrbsxtsOAhUhJ0t0oHP88q3hy5Zk9DmREI8o_1taIviZd-nzn82eg0l6Y
Message-ID: <CAHC9VhTSt-UoGOZvez8WPLxv4s6UQqJgDb5M4hWeTUeJY2oz3w@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] fanotify: notify on mount attach and detach
To: Christian Brauner <brauner@kernel.org>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org, 
	Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, Karel Zak <kzak@redhat.com>, 
	Lennart Poettering <lennart@poettering.net>, Ian Kent <raven@themaw.net>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, selinux@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux-refpolicy@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 31, 2025 at 7:09=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
> On Thu, Jan 30, 2025 at 04:05:53PM -0500, Paul Moore wrote:
> >
> > Now back to the merge into the VFS tree ... I was very surprised to
> > open this patchset and see that Christian had merged v5 after less
> > than 24 hours (at least according to the email timestamps that I see)
> > and without an explicit ACK for the SELinux changes.  I've mentioned
> > this to you before Christian, please do not merge any SELinux, LSM
> > framework, or audit related patches without an explicit ACK.  I
>
> Things go into the tree for testing when the VFS side is ready for
> testing. We're at v5 and the patchset has gone through four iterations
> over multiple months. It will go into linux-next and fs-next now for as
> much expsure as possible.
>
> I'm not sure what the confusion between merging things into a tree and
> sending things upstream is. I have explained this to you before. The
> application message is also pretty clear about that.

I'm not sure what the confusion is around my explicit request that you
refrain from merging anything that touches the LSM framework, SELinux,
or the audit subsystem without an explicit ACK.  I have explained this
to you before.

For the record, your application/merge email makes no statement about
only sending patches to Linus that have been ACK'd by all relevant
parties.  The only statement I can see in your email that remotely
relates to ACKs is this:

  "It's encouraged to provide Acked-bys and Reviewed-bys
   even though the patch has now been applied. If possible
   patch trailers will be updated."

... which once again makes no claims about holding back changes that
have not been properly ACK'd.

--=20
paul-moore.com

