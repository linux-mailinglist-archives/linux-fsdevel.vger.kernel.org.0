Return-Path: <linux-fsdevel+bounces-32592-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C57B9AB3F1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 18:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC0081F22F3D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 16:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 046DF1BC061;
	Tue, 22 Oct 2024 16:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ZKFHH9OO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27D51B5820
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Oct 2024 16:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729614454; cv=none; b=EVQ2x0r97AgUT+pTUn+6HttplHqrtcC3iuq6s+9FORdrlQUmVqn7JfFbrxD4OwkbmDINLJzxV3G5Ncn+ZwPOp/GZMJ4tbJFzLncJzri1A54F3QLhYmjU9qG/nHNebwzaiPz/XWyVDYlWyJaI0eldLaUYVAqQoHEi5xysjVwV30I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729614454; c=relaxed/simple;
	bh=YetXmpo1FU87tQbfMy3tmCWhG8Jq9L1beNcjzGpdrnw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JWehhhTuFr6X0VZhl6+DRM6mIs4Rkz/n495tgD6rDtv/OtZfiPDO+/kQsclWLRlzAW0fc5QydgV5pAG3r3vAD+CnG/F+EJdx9Nu8yvSdXoJdCO9iro8qAISkxVDgYeBn0SiHdFc0s/Lym6OewsYoNOHr3lKAf1kAR7376p6o+6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ZKFHH9OO; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e29327636f3so5793881276.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Oct 2024 09:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1729614452; x=1730219252; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IfcQit/uWdai0Gz1OYnQOrro3YmwaBdxtR4cFYi7qqc=;
        b=ZKFHH9OOHDNsUqpTPg1WWwHvZ129r2jsVgULvDny9/dW3/qppYYdqAfs33pFenZj0W
         bI9wWgoy+NZ3/n4z0mnnWAdvGoC77hYmxLdbbYtp1QContGSh0skZJ+aEK7fOfRdP4uR
         aWtuN3Oc9o4H+ZtosbduzzEs25AhK9RXpRXpXVSWc+GzpvfzZ6pwQp020mYqAZrJ2DYU
         Py6QPNNB4cxX3gsjmL9d5y+xgNAclzT4HDfPiwNtBCgIJp3AMexHftypJzVKiYpR+fBN
         v9P5RFGsg78/CFjnh/fT6lRwr1kbhGaXiKvSAn9djphmjA7CcQntNbTAJPy40iekF45K
         hHPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729614452; x=1730219252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IfcQit/uWdai0Gz1OYnQOrro3YmwaBdxtR4cFYi7qqc=;
        b=LFIc9cK8JChcZ0FoSrRQ7SsDdyDnOg/LRtOfVkS31Y5egXwuoqHWfXHLcT1TQxZSYO
         0T+t9FiP34ATNh5wqi87ioAfSvt2eHmNfb7FaiAlM9BHlLOO1AvLAQiO5jvtNnOaO14p
         ImU8HHdVAAoYv/2z7sTvJI2yUgiwgxoy5Pi9tBpuuIDZTAYEXC2wjBpPz1Bpq4Rr6h0W
         cKQGuroBCLMPgehrDxhIok9OsagoX93gQvVTS+apPLkkoPLQaEUyvLxb7b2zv+canTbp
         t64TblhStROBORUe86HdTXrVTl5oEa+TyiyToogt+S7azmbVyJ1u7lOqXfxdWgAlrA2w
         kJpg==
X-Forwarded-Encrypted: i=1; AJvYcCUQ5fSIveQ+RLKfBbPw4M6Agf2u+n9TYgQ92BFBOEjWEW4IpeIExusqnVnTYT8aUoC29l4F29M38/Mx93Fo@vger.kernel.org
X-Gm-Message-State: AOJu0YyPjzjzWGLooP0G9uQ/9fpIyM+VAnV0iC6TMWAOCWlvqCfV2bCA
	CU/bxAoODXA2YYh9sg/hdD6N6ki/0I+7ku3CLTWvM2TwRvi3ZElvj72XyT6jSUrBDtPWfrbqiiT
	ggAdZ+oD23c4QjtqsGhxYAWGOoZwKoAmTVVWT
X-Google-Smtp-Source: AGHT+IH6teBDteuKX1IfTUU7aOF/brFPLWkJN/2yz4gkMpur17JiIyAYiy3u4lW9412aaSoQIXj6qPi46aPfQzyDatk=
X-Received: by 2002:a05:6902:723:b0:e2b:d610:9d61 with SMTP id
 3f1490d57ef6-e2bd610a475mr10370763276.43.1729614452032; Tue, 22 Oct 2024
 09:27:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241018161415.3845146-1-roberto.sassu@huaweicloud.com>
 <CAHC9VhQP7gBa4AV-Hbh4Bq4fRU6toRmjccv52dGoU-s+MqsmfQ@mail.gmail.com> <20241021200636.308f155a72f8a4d1e26f82b8@linux-foundation.org>
In-Reply-To: <20241021200636.308f155a72f8a4d1e26f82b8@linux-foundation.org>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 22 Oct 2024 12:27:21 -0400
Message-ID: <CAHC9VhRxXAj3ee0z7eMAiDYJ858xOgRyBTwCjvTRfNzDqt6yVw@mail.gmail.com>
Subject: Re: [PATCH v2] mm: Split critical region in remap_file_pages() and
 invoke LSMs in between
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
	Roberto Sassu <roberto.sassu@huaweicloud.com>, Liam.Howlett@oracle.com, 
	lorenzo.stoakes@oracle.com, vbabka@suse.cz, jannh@google.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, ebpqwerty472123@gmail.com, 
	zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, 
	jmorris@namei.org, serge@hallyn.com, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, bpf@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, stable@vger.kernel.org, 
	syzbot+1cd571a672400ef3a930@syzkaller.appspotmail.com, 
	Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 11:06=E2=80=AFPM Andrew Morton
<akpm@linux-foundation.org> wrote:
> On Sat, 19 Oct 2024 11:34:08 -0400 Paul Moore <paul@paul-moore.com> wrote=
:
>
> > >  mm/mmap.c | 69 +++++++++++++++++++++++++++++++++++++++++------------=
--
> > >  1 file changed, 52 insertions(+), 17 deletions(-)
> >
> > Thanks for working on this Roberto, Kirill, and everyone else who had
> > a hand in reviewing and testing.
> >
> > Reviewed-by: Paul Moore <paul@paul-moore.com>
> >
> > Andrew, I see you're pulling this into the MM/hotfixes-unstable
> > branch, do you also plan to send this up to Linus soon/next-week?  If
> > so, great, if not let me know and I can send it up via the LSM tree.
>
> In the normal course of things I'd send it upstream next week ...

That sounds good to me, I just wanted to make sure there was a path
forward to get into Linus' tree.

> ... but I
> can include it in this week's batch if we know that -next testing is
> hurting from it?

I don't believe so, I think this was just a syzbot gotcha.  From what
I understand remap_file_pages(2) isn't used much anymore.

--=20
paul-moore.com

