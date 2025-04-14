Return-Path: <linux-fsdevel+bounces-46422-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A783BA89004
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Apr 2025 01:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 100EA1899F94
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Apr 2025 23:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E62E1F5848;
	Mon, 14 Apr 2025 23:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aWCYOHIP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80171F153A
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Apr 2025 23:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744672737; cv=none; b=TsStIIBEA9d4V2dZyYAOqa74hrIvvkASxK33b80QTkMuyarEl3e+Tpw5YXXF2vyu26sCzzExqs37pwEfNIWODpHampxpbLbvE5w8vj7wh8yXhHQkbAruu2XA+tjJndb79G8jVd0v59usyMlUO4tJc2DPvuwB8LYhxnFqGZNcP5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744672737; c=relaxed/simple;
	bh=Vpzaudbp8Y7zrbb390HW78JJPo4FnSlXlz76ZxNyXGY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YN+/sx2VjiY/dNY+M8Sfs3zcqsbrV3SRkTiWEspJZyoXJ2I9XDbev+kRLLfeM3gWFmRjuS0Kd0Bp0rypTa+htQHDma14Sqp8+RalwJHOBIzOYyRF5ubHHq3E/GNNBKdbato62HZWgDB2S5+OlUL8D6StLtgsKsYc5p2u/0QKfrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aWCYOHIP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744672732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qaoK7poL4lFt0zzKd827Q2KBVOP06dQDJUh2ihDBMGA=;
	b=aWCYOHIP9idtg8DWBhWhbzaCK/LD/4jQxJoMSdhUtm7dMsy7KfPiqWcrvnC6UHT60eH94D
	CpBqMSaYG1Xj2kx518kQ4Pf7La4hJ6xM+1ekFgvAEwXsJbv5j0EKWfSwXAJfKkuCYKmVqy
	Q+ZEc5NwhhBhzzTxb1SQhC9ueT5f1UA=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-aVjTTqILNAm3iOgCqsjgnw-1; Mon, 14 Apr 2025 19:18:51 -0400
X-MC-Unique: aVjTTqILNAm3iOgCqsjgnw-1
X-Mimecast-MFC-AGG-ID: aVjTTqILNAm3iOgCqsjgnw_1744672730
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-22410053005so78679005ad.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Apr 2025 16:18:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744672730; x=1745277530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qaoK7poL4lFt0zzKd827Q2KBVOP06dQDJUh2ihDBMGA=;
        b=NwWNRuJwdTtDI9QxnwVlpzxak+kI4JYmLGBnuSwXPc+MgkEQtgoH/gQER6iiCR/iqT
         ycmxEFJ7RS0Zlsc9IDQ7Yx5sB1SnsXTMSY5czQMuWw2+pkUKY0S+Vfjh+CjZzUwX4oRw
         NoHiURYwG9fT0MZfD4Wpm5l4uDZAXN48dRF1Q1byIDs7ofeiCPmSEY/jZL1F5OaXbTz+
         zZSFD1vw15hFFpPqM51JtYyhvHFUFi9S5lEo0CuS2P+DgCovQW/5+K+3kcCw9toE6wkw
         a3g90Xkg5dR4QA9zvVtUEj5lHhtTdUT7thGEDEKObvDu2etOOYZIHKVXpt4PcjGxljrn
         pQOg==
X-Forwarded-Encrypted: i=1; AJvYcCUUQRK0eGyldQIqRUL3FIhlChXWJaqBDmLM6VHfimPjRdont+kwPfab7U4YSlGrpwVpy41AimJWmUqnL+KQ@vger.kernel.org
X-Gm-Message-State: AOJu0YzGReIS5QN9TN8Spsp5/Agkw/BHtyV9aqe8CTLukYoyW+YR0BXU
	CnzryDH8/Wu0fzAWC2t4rpo+7PDcZbZKVv1gPe0S/zHmXkvYsy0BYbsLSny7a3B3xEWqc0y+1dn
	9r9HrrEgxltAwfh2HTXvQWV+jnyKH2/JzdIJim6COIp0CoreS4+k8mScbts/hAoIZcu83FdYOy9
	vweZ0mv/JddxqPX5f7yxyca98sV88HIoibANBCxw==
X-Gm-Gg: ASbGncvl8jFDzt6okYjbzXPXf3ngUHowdazLxDy51cWMxg7g4RMNAozktHfUPnVfXoD
	jop4zI8/w/NpE1v9UuUyOUn522LlU8YQiivoSTnIl2RoMGO555kxaijF3r5d1qDIufrA=
X-Received: by 2002:a17:902:d481:b0:220:f59b:6e6 with SMTP id d9443c01a7336-22bea495687mr151860715ad.8.1744672730474;
        Mon, 14 Apr 2025 16:18:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTkx4rzJcGUvdjR+8IkBuWXjpb03TgR9MDlGC2OL5q8ZwLfz7AdIcQ7zVCufAPTrl8j8sJhif/5Ghk7BA8IQ8=
X-Received: by 2002:a17:902:d481:b0:220:f59b:6e6 with SMTP id
 d9443c01a7336-22bea495687mr151860555ad.8.1744672730227; Mon, 14 Apr 2025
 16:18:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250412163914.3773459-1-agruenba@redhat.com> <20250412163914.3773459-3-agruenba@redhat.com>
 <20250414144741.56f7e4162c5faa9f3fb5c2a6@linux-foundation.org>
In-Reply-To: <20250414144741.56f7e4162c5faa9f3fb5c2a6@linux-foundation.org>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Tue, 15 Apr 2025 01:18:38 +0200
X-Gm-Features: ATxdqUHmoD9wBQhxdgcyUd4MlED8R-VRCkPirnQXdbKIxEeeDfOLknsoCdUpMs4
Message-ID: <CAHc6FU5EMw_S4FHyBLRinTdDc-jh9WPOnabSdvHuVF_MPWQkMw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] writeback: Fix false warning in inode_to_wb()
To: Andrew Morton <akpm@linux-foundation.org>
Cc: cgroups@vger.kernel.org, Jan Kara <jack@suse.cz>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Rafael Aquini <aquini@redhat.com>, 
	gfs2 <gfs2@lists.linux.dev>, Linux-MM <linux-mm@kvack.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 14, 2025 at 11:47=E2=80=AFPM Andrew Morton
<akpm@linux-foundation.org> wrote:
> On Sat, 12 Apr 2025 18:39:12 +0200 Andreas Gruenbacher <agruenba@redhat.c=
om> wrote:
> > From: Jan Kara <jack@suse.cz>
> >
> > inode_to_wb() is used also for filesystems that don't support cgroup
> > writeback. For these filesystems inode->i_wb is stable during the
> > lifetime of the inode (it points to bdi->wb) and there's no need to hol=
d
> > locks protecting the inode->i_wb dereference. Improve the warning in
> > inode_to_wb() to not trigger for these filesystems.
> >
> > ...
> >
> > --- a/include/linux/backing-dev.h
> > +++ b/include/linux/backing-dev.h
> > @@ -249,6 +249,7 @@ static inline struct bdi_writeback *inode_to_wb(con=
st struct inode *inode)
> >  {
> >  #ifdef CONFIG_LOCKDEP
> >       WARN_ON_ONCE(debug_locks &&
> > +                  (inode->i_sb->s_iflags & SB_I_CGROUPWB) &&
> >                    (!lockdep_is_held(&inode->i_lock) &&
> >                     !lockdep_is_held(&inode->i_mapping->i_pages.xa_lock=
) &&
> >                     !lockdep_is_held(&inode->i_wb->list_lock)));
>
> Is this a does-nothing now GFS2 has been altered?
>
> Otherwise, a bogus WARN is something we'll want to eliminate from
> -stable kernels also.  Are we able to identify a Fixes: for this?

The excess warnings started with commit:

  Fixes: aaa2cacf8184 ("writeback: add lockdep annotation to inode_to_wb()"=
)

Getting rid of them requires this change, together with "gfs2: replace
sd_aspace with sd_inode" from gfs2 for-next:

  https://web.git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git/c=
ommit/?h=3D
    a5fb828aba730d08aa6dec6bce3839f25e1f7a9d

Thanks,
Andreas


