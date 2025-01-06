Return-Path: <linux-fsdevel+bounces-38460-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27B0CA02ED4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 18:23:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A787A3A3120
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jan 2025 17:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B451DEFF4;
	Mon,  6 Jan 2025 17:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F2D52Krp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F311DE4FE;
	Mon,  6 Jan 2025 17:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736184210; cv=none; b=c/vQ9f79IUYfiCt6hHsoTPUxyiH6X292GAhMHTA7KUKgO7zif1ePckFrhmnakTC1cn4b1TZ6I7BRYR24UCS+qemHZZkbz6nso4nVLNo6sAlg5bAqAGXOsstXgKeZjn4dS02x8IdoVyhjvXhNYxvCNquemvyaAdOwrEbuyytZ3V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736184210; c=relaxed/simple;
	bh=urHZ55AU7/h1ujpGW5V+Z2oQZ2zmoCNcJLo5BCPyeBs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JevNUBUiUlOeFwmZGEIds56XRi4fAxta3CuozhnN4XgoKdRpxzhlLWFEhap+pp4qCp3tIFFuO9QjMSdEz/44/Kx54el0jyB/4sTYb3FYmy1AeF0rfuLXGGNlne7MziqeEq7BC8IEuOgVbRYjnLtzboeg+DfnHU6Ev2yxkyUK8qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F2D52Krp; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4679eacf25cso79450711cf.3;
        Mon, 06 Jan 2025 09:23:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736184207; x=1736789007; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=urHZ55AU7/h1ujpGW5V+Z2oQZ2zmoCNcJLo5BCPyeBs=;
        b=F2D52KrpfC48Xvu5XmvNhC6Q4ahMl0xQl4edbiJw8kktjo1K4UCtY3/SYhwa42DMFm
         ZW3aFplfswjLqJz4ms33wSmUM9adBi+Es9vG5UO5+xcUggQGZ7lIuToSq5nvYsuopSDC
         /STzsY3bedLNFppeuW3gQ7giSbvrBw5Ft25YE2YzVVWIyEHeefqpWJk/LoEoLFdTJxlo
         spoTYnSW3F7olByrEvarw1gkYgTASf6K8F/FNpXjUDkNAWFWbgysxJCukt0lINKxmmEq
         ON6hmzzpGQCQTg4tk7P6xMkdiDtpSyZXeutQ4nG2ipnESeQLUJjckbvGbsVs2TvgW2pw
         s3Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736184207; x=1736789007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=urHZ55AU7/h1ujpGW5V+Z2oQZ2zmoCNcJLo5BCPyeBs=;
        b=IL4fHRb1N+1Yl7PgI66Tff2rEUtgDO+sfrXFVO4m8/88mgonU9IAfqNiM5CWrtuhaN
         fGB2klF58HNec/wA88Oqixj4LfTzProjbYgLH0qK0DzsEYsbc7VVcd64L1pww7oqYEI+
         UnZaD7j6jFpfovUjB3XHBm+ZG3JhYUgZUZyic1q03Ou98Fuhz7Qq7j/DKareSPy/fPYT
         Nbr+WPUf2Aqse7I8rmy7s3iz+cbo7nUAsbszHP1Up6ZokWA4p1X23lh5JHtXgc5wijiT
         orZ6KtrEsCp5IARtGSHhHWWM1ZKiRqwhHuakZYhH5vePWIQSl2PFscHlfIkRRiNjkOxj
         +Yiw==
X-Forwarded-Encrypted: i=1; AJvYcCW1kciVom+FINO+ZNle8mBFaVbT2Ph5nVvhInN/wI6vJyeiF9KmSwTa/tpVv2W8jGo2+Z2CIaaGlWl/bGaU@vger.kernel.org, AJvYcCWajvtUtzfAvCdnk+5DX1cfXyxmn5asq7he+IKlPSDDQTUaf/fxdsuPhE6Ju9Ud+3OlU27EcBU8DVx44rxH@vger.kernel.org
X-Gm-Message-State: AOJu0YxWyA37rZuJmQBx/8a9u7G0k6Y2wltm1vuxi+kkvZ6RrgDVkjQp
	Id8SA4m5gtd14SgaVfxKC8560nPNehsTaBrPA2VK1me8P/NpdA3khZfN9SiKjleNQaeqWs/Y6T6
	UH8wHN9M9RJuCZsj4ubpyoc+Lazs=
X-Gm-Gg: ASbGnctFNQdUzX3DHtJ3IQ8PSse6ozdG5ejHjoy0pBpEeFwpVQ8dRfi9IwCsh8d8pB5
	Cbjjwpv6nscf6i7rS2wExiBmRPNjdHoaptVefwGBx3CClG5zYNAxeLQ==
X-Google-Smtp-Source: AGHT+IEjdHJzoGpastaCk2hvzRsIENAny++UcRfcc1r+XRDVfBTjJIrUXo239L+yBKsItdxvh3aCKhZhtP0tw3DgmaI=
X-Received: by 2002:ac8:5981:0:b0:467:5016:57fa with SMTP id
 d75a77b69052e-46a4a988dd7mr950725101cf.44.1736184207460; Mon, 06 Jan 2025
 09:23:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJnrk1aumuyz9J1ZWReB+diDXffRQFr1Et1UMoyyuBRf+s272g@mail.gmail.com>
 <67786ea9.050a0220.7f35c.0000.GAE@google.com>
In-Reply-To: <67786ea9.050a0220.7f35c.0000.GAE@google.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 6 Jan 2025 09:23:16 -0800
Message-ID: <CAJnrk1ZC4orWTbJAKVuDwmRCRRN-WSM6xpcNiGW48P55nD3r+Q@mail.gmail.com>
Subject: Re: [syzbot] [netfs?] KASAN: slab-use-after-free Read in iov_iter_revert
To: syzbot <syzbot+2625ce08c2659fb9961a@syzkaller.appspotmail.com>
Cc: dhowells@redhat.com, jlayton@kernel.org, josef@toxicpanda.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	miklos@szeredi.hu, mszeredi@redhat.com, netfs@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 3, 2025 at 3:11=E2=80=AFPM syzbot
<syzbot+2625ce08c2659fb9961a@syzkaller.appspotmail.com> wrote:
>
> > On Thu, Jan 2, 2025 at 12:19=E2=80=AFPM syzbot
> > <syzbot+2625ce08c2659fb9961a@syzkaller.appspotmail.com> wrote:
> >>
> >> > #syz test git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fus=
e.git
> >>
> >> want either no args or 2 args (repo, branch), got 1
> >>
> >> > 7a4f5418
> >
> > Sorry for the late reply on this Miklos, didn't realize this was
> > related to my "convert direct io to use folios" change.
> >
> > I think Bernd's fix in 78f2560fc ("fuse: Set *nbytesp=3D0 in
> > fuse_get_user_pages on allocation failure") should have fixed this?
> >
> > #syz test git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.g=
it
>
> want either no args or 2 args (repo, branch), got 1
>
> > for-next

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git
for-next

(added a missing ":" after test)

