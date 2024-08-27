Return-Path: <linux-fsdevel+bounces-27288-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A089600BF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 07:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BF96283697
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 05:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A68F74413;
	Tue, 27 Aug 2024 05:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="McJrtFAI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B36E17BA2;
	Tue, 27 Aug 2024 05:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724734979; cv=none; b=auTxcmjjNJ853imQoOtuj2KI0ro7QZfica/T05VoWDbGZdrA1KgMAQOtMLqdiURu+tQyOktWxOHGr61e/+qtHJ9oOc0G/QhdV5s27oTeczH1K4yF5tX35hvHBxddCvcQlwGict9FiirRdxs4mBmhlEmeTL2BUGOI+2hO9V2fyew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724734979; c=relaxed/simple;
	bh=8y9iQ94NHXc4cCJ1Ma/iTj2MrsadbqKcnH8mBLcgSus=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HxqTjsa/7JFJkgsRJ+NdQ+NsBWCYyfKo3zq+WDlnNKYi9OFFZFco15155mSvTWq/Buff0RAgo4CSChn+rarKGW2sO8TruNTqkJtW8LMiyIrcKpANBKoEgSXnkGXGHV/v4hfc+iFSXcW13+Qk8VikXYjJl3tqMW7WgKcx3zr/u10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=McJrtFAI; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5334a8a1af7so4913083e87.2;
        Mon, 26 Aug 2024 22:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724734975; x=1725339775; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G1tPrUcxqAg1dhruM6WccigDNxnQ/dFY9k4RpKAhaVQ=;
        b=McJrtFAIWxpPuk7J4kDeS0+FkLRIQNOHAf3Ve1a0aIAm5+ZUtqw795mkxCnJFbOJX+
         rPuc1NWg/qZplSda5BHgAgfiAevD16k704uRyZbAjNQGS74HPwFad7PvqmcO3shv9Qvp
         M+PaOBsuDGx1CXHowE5qtkFTm9xvUW+rgrVG+FTHa9D70JoESaHikAeLCmI0O3qBBXWz
         Aoi3xB95DRBsDH7LGz62XaVb9KLNjfp8D0O7CMzMU0w+bg+RwYhfQtJGTilZb3Zm5LAs
         JMcx2/J+7Qgx3H1mM5obnzaFMTP4o0OYKlJjQLrwLq9PtIxIe3MfHP3ZyXtwHmisjb1Y
         yXPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724734975; x=1725339775;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G1tPrUcxqAg1dhruM6WccigDNxnQ/dFY9k4RpKAhaVQ=;
        b=Yg/wZtW/oqOZ+uOiLqwAr682bPnFLwJMoqDf1VauLE2y6yVZKbC0WnubP+nNcH1veJ
         VCGE1I6faTCSmDViRL8IhQz1cSpIp4TJGm29WHSMLkDgnKLygm7gxzEJ871UNd4k5ISB
         vZhndk0YNl5ILMKoSt+K6o5Sc4PAqzcaYq6zQIz84i8VUAD1LYzCaggaB2y9UW2KK6Cw
         atIW78ig544NH8JS0/A9lRd0NXElP2pGf5HKYsuI92pTXo3ELZYOf4eaktUZB5U9Kcvk
         kjV7zmF/l5NrH+n3HrSkVCJOf7X3vohECV5yHfE9+o7pW9Cct9ah91MHViw/SMwhW9QA
         eJsw==
X-Forwarded-Encrypted: i=1; AJvYcCUYHhRUqeDQz+DbaFtM2HhDPdQHbWwLzzZKMqraRv/+rSPfFMk1blXUUuT+IFhj/1HJgEcbY61pStDptKq+bA==@vger.kernel.org, AJvYcCXJPjQYvFpEEc1MJeYTYLnfN458sPhbmMJ1HFuWnz7Sj1i7lhEGyY5WjVSvEx/Ne3WzSIy52JIPUUQb@vger.kernel.org
X-Gm-Message-State: AOJu0YxDLmppm/j2AvuYgKFQWrKYTINHlOsQQsuL7zUTsal5AA9KV57S
	LdI6JspmmNhjGkyJxXzrZeKIndUhMQRnbx7ud3BG36DIzRimnF6UuidJyxokroi8cCKXiE5uk6M
	za9P/qL1bSDCqNJ6JQgRLVtiS/JY=
X-Google-Smtp-Source: AGHT+IEOrUFWw153PpKJ3xQn15rauhXsECsIYW+gk4XwZMm21Fv4vuqd+UVgtsNTZLpMz8YCZ3pmYmlPkiXIS9hAPok=
X-Received: by 2002:a05:6512:3b27:b0:52e:f2a6:8e1a with SMTP id
 2adb3069b0e04-5344e3de28emr1038984e87.29.1724734975021; Mon, 26 Aug 2024
 22:02:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <37fncjpgsq45becdf2pdju0idf3hj3dtmb@sonic.net> <CAH2r5mtZAGg4kC8ERMog=X8MRoup3Wcp1YC7j+d08pXsifXCCg@mail.gmail.com>
 <CAH2r5mt99dz9AjEYvMpBUXoNLePdbK5p0OuH0Lq1tf4m+ExLpw@mail.gmail.com> <Zs1YKh8H0dEX126X@codewreck.org>
In-Reply-To: <Zs1YKh8H0dEX126X@codewreck.org>
From: Steve French <smfrench@gmail.com>
Date: Tue, 27 Aug 2024 00:02:43 -0500
Message-ID: <CAH2r5mtCi52Fd_OZE_8Fnd3SmTsD3SUkj1CEsU6jw38wTuxskw@mail.gmail.com>
Subject: Re: [REGRESSION] cifs: Subreq overread in dmesg, invalid argument &
 no data available in apps
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Forest <forestix@nom.one>, David Howells <dhowells@redhat.com>, 
	Steve French <sfrench@samba.org>, Shyam Prasad N <nspmangalore@gmail.com>, 
	Rohith Surabattula <rohiths.msft@gmail.com>, Jeff Layton <jlayton@kernel.org>, linux-cifs@vger.kernel.org, 
	netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	regressions@lists.linux.dev, Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 26, 2024 at 11:38=E2=80=AFPM Dominique Martinet
<asmadeus@codewreck.org> wrote:
>
> Steve French wrote on Mon, Aug 26, 2024 at 11:27:33PM -0500:
> > I have also confirmed your theory that the regressions (there are
> > multiple) were likely caused by the netfs change added between
> > 6.11-rc3 and 6.11-rc4:
> >         " 9p: Fix DIO read through netfs"
> >
> > But reverting the cifs.ko part of that patch alters the error but does
> > not completely fix the problem, so the netfs change is also related
>
> David sent a bunch of cifs fixes including this patch:
> https://lore.kernel.org/r/20240823200819.532106-8-dhowells@redhat.com
> "netfs, cifs: Fix handling of short DIO read"
>
>
> I don't have any samba server around to try myself, did you have a
> chance to have a look?

Yes - I just verified that David's latest branch does fix the problem
you reported (ie "cat foo" and "xxd foo" on mounts to Samba)
I ran with 12 patches (listed below) of David on top of 6.11-rc5 (and
3 unrelated patches from my for-next branch), but most
of his patches are not in linux-next yet

540511907bbf (HEAD -> for-next, origin/for-next, origin/HEAD) netfs,
cifs: Fix handling of short DIO read
76b6078dcc72 cifs: Fix lack of credit renegotiation on read retry
de7b2d4f8789 netfs: Fix interaction of streaming writes with zero-point tra=
cker
0d718d75935d netfs: Fix missing iterator reset on retry of short read
eb54e19d9cb8 netfs: Fix trimming of streaming-write folios in
netfs_inval_folio()
b10b7505454c netfs: Fix netfs_release_folio() to say no if folio dirty
5fee95cba515 mm: Fix missing folio invalidation calls during truncation
68c4ccecdf68 backing-file: convert to using fops->splice_write
65a5aad19a17 Revert "pidfd: prevent creation of pidfds for kthreads"
3e99ab871c90 netfs, ceph: Partially revert "netfs: Replace PG_fscache
by setting folio->private and marking dirty"
06f646e2d0d4 netfs, cifs: Improve some debugging bits
416871f4fb84 cifs: Fix FALLOC_FL_PUNCH_HOLE support
017d17017436 smb/client: fix rdma usage in smb2_async_writev()
b608e2c31878 smb/client: remove unused rq_iter_size from struct smb_rqst
c724b2ab6a46 smb/client: avoid dereferencing rdata=3DNULL in smb2_new_read_=
req()



--=20
Thanks,

Steve

