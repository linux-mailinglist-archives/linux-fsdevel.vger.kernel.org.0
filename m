Return-Path: <linux-fsdevel+bounces-17066-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 719BA8A72B2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 19:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11FEF1F21DB9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Apr 2024 17:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C808813440C;
	Tue, 16 Apr 2024 17:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cYXJrZft"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DEC39ADB;
	Tue, 16 Apr 2024 17:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713290160; cv=none; b=frPr9OYBFAyuHHTj3Ww1I04d2ODGWsuHn8atptVIJ7dTTukegtbEcDrOwX4jpusJX0J5in6v6lmgXPEU4pHWOhdPX7it4O9IvNHY78G8Yy+9rCGpJ8adLnYjR5yiXg4BaSSXprjdqhUFbHw1u84xaw2phfA4HLez7phQ4o4whGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713290160; c=relaxed/simple;
	bh=App8+f7HQgEyCrYA5e4Q6mJcb9qZ9lT1AGG+bO5rd+o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LlkHP1MvOL1N7fypBIOUQT1ZQXo3sv3EVbMAkAA+bdpzM5P+JgshsErXIdYLIlIoPFLhhoi8sNQIoaz19jtmmj1hGext0VXnlalTT4DCXI7+cqOfE5nHMnHd3HODJtBC6R6JojxUB5z+fRWV+mo/6HqVq3/sYP/wAAapOoI3eT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cYXJrZft; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-69b59c10720so19628646d6.3;
        Tue, 16 Apr 2024 10:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713290158; x=1713894958; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uFtD7yaq2n4Zk9EXXhrU+DmDbuKVn/Z2opH0kLfIHD4=;
        b=cYXJrZftnzbi3VOLrD27bbrfdZVOAT42A4bhiHq7RRV6Alg1+FT0P0IBbK0buLwb3H
         cXsbATyVI1A5jyY0u+wKCXb1dL7WTlBBWmw6WJiVWl9PMa60b2pmkGkIuwDZXjIAOcdk
         2MszKGl64BJeXF7EeCBX4z4hs98PRgszxRvX4bumMxnG/CYT4tnkXw/ZxRyvKEsHIWBh
         KAavcOLjDpmaUX3gq/7DjRF5Bab5bTAMUqaxW5iNr41LfjWkPC7oo0EGsDmCJZMYCM63
         guA/3M9wTJESPUTEvtE1yzymCJNGmX5CyQ29T79Sy8O3gOa/a4fvJj6PTi7w8Rh9+IY9
         VzkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713290158; x=1713894958;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uFtD7yaq2n4Zk9EXXhrU+DmDbuKVn/Z2opH0kLfIHD4=;
        b=bACOU23Kt3FCG4Kcy69D53YqgJ7QSOlXkbmfudBDZU3mr03l/eFBYzkWIhVG8Bex3P
         jxgb/gTaoxfpYX3r/+RMrNllNbE1PgzRi5raPClk1bJVkD/0orzSGhM75soqnmo02I79
         7y4g+DSroOFQHu0U4kJm0/yUpp10i0h0Vlh3iBnIB66KYTfRkgy6l0FqfwwHWOHbuDWF
         YXxzIDBrZrWZo7E8G2+9iETBbz1cCHBNAYD6+6a89cjUFk4nntkIlp4HNJMbSWdqXMQZ
         QC0fROygAf02/E6xUIrwO9nzu7fwa8ApPUixKBsuRwLozRYWDt6hFMYjTAasXhqmHpjR
         rBCA==
X-Forwarded-Encrypted: i=1; AJvYcCU97MqCRbdFhCjkBzBNJmlSxFqSZd46NHbrKYYFNJE2zxmIY9lroIXvK7Sp0cjZOkFTDsXtXb7gy2VZ1Bv9WiE3izXJ6K8VC/JPq8fIS/ZSKKxP8NRAUP+ipVvNfyPIG4YSEGoEZRHaGghLNA==
X-Gm-Message-State: AOJu0YwbAP+6KWG78isE8BSIBQ70dSfQWry5GFHsWA8HP2SqT4UTCNN5
	v+HlOWrdvW4bAUy8TbkLnNWccnvkAQlF4nmGqATEBQqdBqAlOgz/zC0Y4PQ1PhZ/NegwiMsnnUe
	zKNRXfVgfJrbNlD4dyoiXXpnCgNQ=
X-Google-Smtp-Source: AGHT+IFQJKywA2Y/3YBDoIAWsM/7fy1sCAmLUWoivebLj/2RD6YmqZXI7W24GgIVHYjKlDTW71JtHst2clOpBqQ5kZw=
X-Received: by 2002:ad4:4a65:0:b0:69b:5989:1b67 with SMTP id
 cn5-20020ad44a65000000b0069b59891b67mr12654669qvb.47.1713290157890; Tue, 16
 Apr 2024 10:55:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <00000000000095bb400615f4b0ed@google.com> <20240413084519.1774-1-hdanton@sina.com>
 <CAOQ4uxhh4Tm6j+Hh+F2aQFuHfpCh_kJ10FYTfXo+AxoP4m01ag@mail.gmail.com>
 <20240415140333.y44rk5ggbadv4oej@quack3> <CAOQ4uxiG_7HGESMNkrJ7QmsXbgOneUGpMjx8vob87kntwTzUTQ@mail.gmail.com>
 <20240416132207.idn7rjzq4d4rayaz@quack3> <CAOQ4uxjJK3YT1+s_OwtM+=p_C8RCvXaAm6v5V+atyqvRKuKp+g@mail.gmail.com>
 <20240416173211.4lnmgctyo4jn5fha@quack3>
In-Reply-To: <20240416173211.4lnmgctyo4jn5fha@quack3>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 16 Apr 2024 20:55:46 +0300
Message-ID: <CAOQ4uxhQbWQ4hzrG2opRmL0pH5NfWBrkk0PG3aWAF3FODVpbfg@mail.gmail.com>
Subject: Re: [syzbot] Re: [syzbot] [ext4?] KASAN: slab-use-after-free Read in fsnotify
To: Jan Kara <jack@suse.cz>
Cc: Hillf Danton <hdanton@sina.com>, 
	syzbot <syzbot+5e3f9b2a67b45f16d4e6@syzkaller.appspotmail.com>, 
	linux-fsdevel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	linux-kernel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"

> > > > Maybe it is ok to let go of the optimization in fsnotify(), considering
> > > > that we now have stronger optimizations in the inline hooks and
> > > > in __fsnotify_parent()?
> > > >
> > > > I think that Hillf's patch is missing setting s_fsnotify_info to NULL?
> > > >
> > > >  @@ -101,8 +101,8 @@ void fsnotify_sb_delete(struct super_blo
> > > >          wait_var_event(fsnotify_sb_watched_objects(sb),
> > > >                         !atomic_long_read(fsnotify_sb_watched_objects(sb)));
> > > >          WARN_ON(fsnotify_sb_has_priority_watchers(sb, FSNOTIFY_PRIO_CONTENT));
> > > > +       WRITE_ONCE(sb->s_fsnotify_info, NULL);
> > > > +       synchronize_srcu(&fsnotify_mark_srcu);
> > > >          kfree(sbinfo);
> > > >  }
> > >
> > > So I had a look into this. Yes, something like this should work. We'll see
> > > whether synchronize_srcu() won't slow down umount too much. If someone will
> > > complain, we'll have to find a better solution.
> > >
> >
> > Actually, kfree_rcu(sbinfo) may be enough.
> > We do not actually access sbinfo during mark iteration and
> > event handling, we only access it to get to the sb connector.
> >
> > Something like the attached patch?
>
> Hum, thinking about this some more - what if we just freed sb_info from
> destroy_super_work()? By then we definitely are not getting fsnotify()
> calls for the superblock so all the problems are solved.
>

Considering that this is the solution for security_sb_free()
I don't see why not have fsnotify_sb_free().
I'll prepare a patch.

Thanks!
Amir.

