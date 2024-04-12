Return-Path: <linux-fsdevel+bounces-16784-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 592618A2916
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 10:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12C5F28894C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 08:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D8124F213;
	Fri, 12 Apr 2024 08:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="XDsnHAQI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AE24F5E6
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Apr 2024 08:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712909876; cv=none; b=es4cxIdxomDeGiyiJ8SwU5wpXYwH0p7AowC8GKjtStqTB+OEMigFcdrUdzToArRE5vNuKlScSQyzef2XgJn8oQsYhbkIWDXzVQMjeLHGgpvVtJVo+MR6V7KDgWufiOC9ARxqFYjMowB3HrsvHGZmnZt5t7lIvOnQASwoA9JIRp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712909876; c=relaxed/simple;
	bh=6UtEpctNer7kLSjLCBntzXh0tiUhFsPlD+g9J3Yw32M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b2UdqYcPyPd+Z57a3fzPzcH4FnvFtpQDCK+100TzqN5d1fOEtIGjXSzZVUtkKizfcEIhS1O8epWSc5cYL5IAFyQXbxSchdA9XuqODdAJ6cjzcns+La32rVDC3IXC8azjWPTEl8/l4ebSsnuXxzASkCn5N3s3CkexC9nADB5gSys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=XDsnHAQI; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-56e56ee8d5cso797169a12.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Apr 2024 01:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1712909871; x=1713514671; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RMlH/6zX/hbZgJTRiWkLEt3o57fDTpHjfP9/Qzj5bVc=;
        b=XDsnHAQIpmaqFUjZbmkgCqCYraJgM4VNFGY96vcy3RdmpLL5Nnlq6uakzrfOUwTNkj
         C6OYcNiT43N66r3d6LcyASiXsRMenZYUci2EWdXrWHS7lLYyvVDrayFb/aRJhduykWLE
         CD3KFcguW/fq2G3MUS/zIZISSecS04MdLFut8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712909871; x=1713514671;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RMlH/6zX/hbZgJTRiWkLEt3o57fDTpHjfP9/Qzj5bVc=;
        b=O08L07y9RLUPw9WN0KgRYiFnfVpDpVuKcYp5YUVOZEvQM+OFDwXUgFHBuQvAzb+VOd
         O+VLnVaW8pc9yqV5CdbCpsY4K+p3oz3YGMwXPxZqyFohC289lfHOKcnr8Tna8+fOaMaI
         kBYPb6SzBd+W4He4Kn206Y+UP19a617HfEp2oqZ1MB0UZ0cAnBJNnS2s/dmLzGu2ivZx
         50VdOyk1/a4aVMbFozhx2+OrYxmwnwGhCJEZlYAtcNav8NjvZNb9vFW1Z4qzc9ADZZD+
         oqfSCq2ehtasb1EZeDpVgP1LG1scr2UbkINi77eBTk2w/NYmYDrWagVhuSgV/ObmiISr
         Gnyw==
X-Forwarded-Encrypted: i=1; AJvYcCUJeoJTiMEA97N+ZNUxP2U9aCzqbMoND22XPOOkZoWGGa3CW1jsKKF8N4c3fT1SaewSS0BRkefOpBjXMwvPo0qDEPhMiAMJbgpMFPJ0jg==
X-Gm-Message-State: AOJu0Yy+ULBaj4SAGCKgYbYg0UgZTCKN2ZwqCA/p1voaK0bC8m5AQLhR
	+1qyT6BCFfXyedCwhgDoyLpewotvG23aa/RuYbBj1OziTIiG69eJ0cGwNX+bnwqOZpp8sE1715u
	T7a1tTTRVCzK/BuSNw2HjGndQcgU0CRA5ehsw9A==
X-Google-Smtp-Source: AGHT+IFDbpMnTxE8+Z6d8ocmPgVrAwdckX3RxpQVnyx+HnSOj+pxy5fu2uoI+xeWMQ01+rDDhbV9VR+Jsv6tg5zDG58=
X-Received: by 2002:a17:906:66d5:b0:a51:dc1f:a3b1 with SMTP id
 k21-20020a17090666d500b00a51dc1fa3b1mr1179096ejp.39.1712909870663; Fri, 12
 Apr 2024 01:17:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <67785da6-b8fb-44ae-be05-97a4e4dd14a2@spawn.link>
 <CAOQ4uxjOYcNxNf2S0yFxBgV9zPMhOQOxY72v5ToCxCPJ2S0e+g@mail.gmail.com>
 <03958bec-d387-494a-bd6a-fcd3b7842c6d@spawn.link> <CAOQ4uxjNF4Kdae5uos4Ch9qBvmAC2kSH58+wVr=F865XhVZsNQ@mail.gmail.com>
 <a54405ff-d552-420c-88e9-941007c7f0cb@spawn.link> <CAOQ4uxhnSDshQmjn-39Q9TbMJLZiWiYXf+8YLVqB7nPW1L5fBw@mail.gmail.com>
 <G2XhehibMSoDHBWhAJVS3UfIT1-OlMgYkwAgTu5v2ys1BIUCznJ1B475OEKLBFf6M9gnlpXqFIkrsWRmofllLba2b7cRogWLODZQ5Ma748w=@spawn.link>
 <CAOQ4uxiR7BHP4+PNx0EBo8Pg4S9po7sDP50ZMVq1aN3zpk=z0Q@mail.gmail.com>
In-Reply-To: <CAOQ4uxiR7BHP4+PNx0EBo8Pg4S9po7sDP50ZMVq1aN3zpk=z0Q@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 12 Apr 2024 10:17:39 +0200
Message-ID: <CAJfpegukxxb7SOYW_9T5zto9nUgzRgaxVFDzEi_qz1z9A0zkMg@mail.gmail.com>
Subject: Re: passthrough question
To: Amir Goldstein <amir73il@gmail.com>
Cc: Antonio SJ Musumeci <trapexit@spawn.link>, Bernd Schubert <bernd.schubert@fastmail.fm>, 
	Sweet Tea Dorminy <sweettea-kernel@dorminy.me>, linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 12 Apr 2024 at 09:12, Amir Goldstein <amir73il@gmail.com> wrote:

> Not fh value per-se but a backing id, allocated and attached to fuse inode
> on LOOKUP reply, which sticks with this inode until evict/forget.
> OPEN replies on this sort of inode would have to either explicitly state
> FOPEN_PASSTHROUGH or we can allow the kernel to imply passthrough
> mode open in this case. Not sure.

Hmm, maybe allowing a zero  backing_id to mean "use current backing
inode" would be sane.  And if there's no current backing for the
inode, and a zero backing ID is given then it would just return
-ENOENT or something.

I wouldn't change anything else, so FOPEN_PASSTHROUGH would still need
to be given and all the other states would work.  The only difference
would be that LOOKUP would allow setting up a backing path (need to
think about naming, because all these backing somethings are a bit
confusing).

Thoughts?

Thanks,
Miklos

