Return-Path: <linux-fsdevel+bounces-16264-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2834F89A9CB
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Apr 2024 10:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C52EE1F219F0
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Apr 2024 08:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F2822618;
	Sat,  6 Apr 2024 08:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XQU7mZdQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA35F8BF8;
	Sat,  6 Apr 2024 08:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712393845; cv=none; b=sacsCtMlb4K3rVgZ3LSdfmqt7kh/5on7m9W72+Nr0/uoGVFSNmdjUdiK83/13mMfPRVLq4xpiCVvY382pyEdDX7hbiEHpNObqR+A8U5Z4TQV/8D5JhoYMjXUsNu9phlFkpASqn5KtUf89e1LE3Qxng913jTI2H5qPVOEovuspqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712393845; c=relaxed/simple;
	bh=StBXlES+se0UmIkWKsWzRN0DgoDY/J/oleJZeUAhnIM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cLT9mpR5POnUBz4qrdE8W0kYkH4T4phXR8YZsFQSQYy2hltD57yTdWaCbYnM/gkeUYgvVL9Bw6v12ejrRbZs7gp/IkLrsHLGCX4M8ZMck0yxccce5mQLaHkNyg4h4dI4gCfgZ72Pir/R2w2CChMbdsY1IRe6T72WFrVn+brLJIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XQU7mZdQ; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-69625f89aa2so21186186d6.3;
        Sat, 06 Apr 2024 01:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712393843; x=1712998643; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i/MwuJlZNqicRfHzJT4JMkKGmDiUN9LbPXKSHMIDrnY=;
        b=XQU7mZdQrlXuV/B5Yog4GPNUrvFOjUx1J512VPrxlvTxdYoVBtGlCDOj9mtXoAzr5G
         Ak0FNlyjjeby/rPw9Z2dNHVGKhjXAwtdLgitJecbxXqzvYSPFL81CS/AEj7C8v7MXYLR
         yPjCheUo5aIyR+ffiT02KmYXjUFgtoKBcI8MUJV+XFr2kLiphMLEsBo7RpVt1SOIWpUU
         +bKABk2TLGnBrFxfjByuWgCI+UVlLk+MTR1W20IW/Wea+OFyLYgocgWv+9uRhqKXj9o9
         F9C4V2r6jf5XUr/HlcXdMwyPQFpkEdw1VBo/VQQHS51FRZ+rnNu5NWmlDoTdYndrBm8n
         AUIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712393843; x=1712998643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i/MwuJlZNqicRfHzJT4JMkKGmDiUN9LbPXKSHMIDrnY=;
        b=CPWkd4clgqF0OMOLXaa3VGqQoRA8ppg2rU7p9qARUTclziA3uZY+nlYQFCywlilYNE
         9g+IOW+RovTOah8b7kCQ4COsODHK8rQJ0lLkd/Q6aCyrJtFbLtS3UMTmQyWWNsPN900R
         7gAvKpIDpujXZpWIP8lkjE19ads2oIYImNG2gm2XXT7T/pe2z3ch0c/1xdosys8MnDUL
         yIgAvxFn9bPNepbv0CGVKYB2P7jYDdw7PqZs8fqDbwH8rZVKid0FibkGUYactnfV+Mir
         JmxlFFGpylICvP9D0C2aSd8CnvvltzP9wemmbMrVAJ5Dtez2W3WcRd7EQTNOU0LZcwIU
         odgg==
X-Forwarded-Encrypted: i=1; AJvYcCWcY5hUyu4a3B5qOt1yvQ5haAUvQw889UlP/nN6vLGAtL+a7u322AiUk6q4n/8OT0SiWzDTy3iKrowTJiLIL+cvIDZ6e1eTRH5yJlO73RWmjkZQ0K0ezYVAfgdgcC2Wzfy6MQiDYCDdcoeO5Q==
X-Gm-Message-State: AOJu0YzyPSfuP5DiyTf7M1HmAgOdmUic17pAybKibJEFtbAA1a9tSCy/
	yPnZXEMpGpE1R+dvNTb3JvwE9TbTaqqG7mVp+3s04sfpuKC4yoA/32FtDDrqJEiOOT6lW3lbeeo
	X/Xv7sxUUAVC1JeZs9RndhIXgM/4=
X-Google-Smtp-Source: AGHT+IHcXmyv9Qp7IoTlp34aR5y8QmAQRz8JhAAy0mu9y0+b442lmwRmmluSsSSe1RYSPh39naRayCCmXFGgqzwxJ9s=
X-Received: by 2002:ad4:4ead:0:b0:696:93f3:7c9b with SMTP id
 ed13-20020ad44ead000000b0069693f37c9bmr4214263qvb.40.1712393842843; Sat, 06
 Apr 2024 01:57:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOQ4uxgJ5URyDG26Ny5Cmg7DceOeG-exNt9N346pq9U0TmcYtg@mail.gmail.com>
 <000000000000107743061568319c@google.com> <20240406071130.GB538574@ZenIV>
In-Reply-To: <20240406071130.GB538574@ZenIV>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 6 Apr 2024 11:57:11 +0300
Message-ID: <CAOQ4uxhpXGuDy4VRE4Xj9iJpR0MUh9tKYF3TegT8NQJwanHQ8g@mail.gmail.com>
Subject: Re: [syzbot] [kernfs?] possible deadlock in kernfs_fop_llseek
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: syzbot <syzbot+9a5b0ced8b1bfb238b56@syzkaller.appspotmail.com>, 
	brauner@kernel.org, gregkh@linuxfoundation.org, hch@lst.de, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	miklos@szeredi.hu, syzkaller-bugs@googlegroups.com, tj@kernel.org, 
	valesini@yandex-team.ru, Hillf Danton <hdanton@sina.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 6, 2024 at 10:11=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> On Sat, Apr 06, 2024 at 12:05:04AM -0700, syzbot wrote:
>
> > commit:         3398bf34 kernfs: annotate different lockdep class for .=
.
> > git tree:       https://github.com/amir73il/linux/ vfs-fixes
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dc5cda112a84=
38056
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D9a5b0ced8b1bf=
b238b56
> > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for D=
ebian) 2.40
> >
> > Note: no patches were applied.
>

Looks like it fixes the problem:
https://lore.kernel.org/lkml/000000000000a386f2061562ba6a@google.com/

Al,

Are you ok with going with your solution?
Do you want to pick it up through your tree?
Or shall I post it and ask Christian or Greg to pick it up?

Thanks,
Amir.

