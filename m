Return-Path: <linux-fsdevel+bounces-38346-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 275C29FFFEE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jan 2025 21:19:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53A2D1883D5D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Jan 2025 20:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1A631B85FA;
	Thu,  2 Jan 2025 20:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="GHfdjHrN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7503615381A
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Jan 2025 20:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735849179; cv=none; b=gCDnt3NFyZsf9phooGgUrkk3+Xmq6XfHb3fyMCpQgyO5JC91Y+FL1Cr0s6Rq3wkMTiRcobN5Bp/LzmFuW9o0M25Qc8EqL7doME9tkDEr7hvMslyfSsnJBkAhZGdNLRb28Lplzcv+37WMRGC2US/JaTkFoqpVAJfhyoIxVlMXmyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735849179; c=relaxed/simple;
	bh=z2O2sjeBkq5rD9KqkyvD3hkUgTKjHfpT4Z0786PjW9E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t/6E8QGsnWVbE0FqtdjLKmpap7FZgh6KB0O0zuf3/yfHPoNg6Up87Ip6+GvbtLj5kFNPDGQbgpUCWlF/RBpQmvsZVJC1pMgGqUqZdzwZEC58eF4MUIyBn/7uesid6am5qZwYqhcv9OPhGUmrvBIrCJiYZPY0Qe++Yu4dlc3YqnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=GHfdjHrN; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4678cd314b6so112468961cf.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Jan 2025 12:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1735849176; x=1736453976; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=z2O2sjeBkq5rD9KqkyvD3hkUgTKjHfpT4Z0786PjW9E=;
        b=GHfdjHrNCrPo02fTPaMHmKEn1r8SXVGWHLI+VjbNXYZlm9wSuG+wop9EEub2tI3GPL
         /jeoSDehCXQR5Oxq+95XDq9Rfiir9d5SZv34cw3tH/QNJBRK0FkPZlBoyip3rfiiuIRs
         SggKlBCU5BZVzlxRTfrHCXAZOZ9vNJT7LNuCY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735849176; x=1736453976;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z2O2sjeBkq5rD9KqkyvD3hkUgTKjHfpT4Z0786PjW9E=;
        b=JFJjDwmtaJMviaV2mjq9lAHJJ/49l0tDyC92zQ+SxtTRgzgFDGJREOP/1qh7jAPoln
         cv0J+Mec+gRYwC8J6h+LuB7H7GfmPpS/1wlow/OMnj1RJs+FIDNRIxHUzQQfKw2jHioF
         FaHSSfs5wgPgWT99l5ZWLzRKgK1MJ9GYuOhPM7Tee10qo0jHPB5+/ChMUZlNThVh19Hd
         fC03TbenWd74bItj6qVRRZQx7ho7SIjuHmVLvdZ5wIJESdFdBF/sL2MTp4wSfKCcFB+L
         +3OUuDrwdt7/dndnWlZhwSSB9/bjjOf6PaCmoeDpC8peEWLyC0aYt4gX9cCp+pJYFIUk
         NbNA==
X-Forwarded-Encrypted: i=1; AJvYcCUU0479Iep612ScAyqD+GHgM0Pp0jjI2ufDTDSNg3exeyS5mO14FjjM0a/0J1RAnFw7QEElZzkJlEV1s23v@vger.kernel.org
X-Gm-Message-State: AOJu0YygxSIVfpC1LFEY7eTGnS8d3FXdq6iBetJLrWRqYkfQ2xUfzJM8
	c/9rMIK0FNjE8zYzV6jYyh2hRMaWcfojSk7tJEP+y+cT6yMy8njvcMuC/6iE5v/kjJB9u2HZmQh
	EyItuZZxL0UVkjhr3HP45kt9ZLXfAyPHs8rm9EFcXG/5ES7wVEoTMpg==
X-Gm-Gg: ASbGncsIbLClY7tNqYF2kF88SNcbqvJwsSMlACk+2twJkxWFWvOvRmP8fXgOpLdHiiC
	8/aBS4Ji/3yRQ0dY0B/VrDYDIcZhjN3TlIvPTJQ==
X-Google-Smtp-Source: AGHT+IEgLuKQSVpPB4YVR+D/Eu0WUZu+a404D8ur7VThLUXKgoTrU0YM7R7qxZYE0eU0GM6xCI9vUylL3MuySJTw0wE=
X-Received: by 2002:a05:622a:2cc:b0:466:9938:91f6 with SMTP id
 d75a77b69052e-46a4a99e904mr799738851cf.51.1735849176470; Thu, 02 Jan 2025
 12:19:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJfpeguK9Baf4hxBhqS_313bo9Z0ZAGMAAbkaOMQRKTK_auk=w@mail.gmail.com>
 <6776f489.050a0220.3a8527.004f.GAE@google.com>
In-Reply-To: <6776f489.050a0220.3a8527.004f.GAE@google.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 2 Jan 2025 21:19:25 +0100
Message-ID: <CAJfpeguPw9CsK56RHGTfpYhfh4V5Kj8+JHJJo=hJDy39=RB+3w@mail.gmail.com>
Subject: Re: [syzbot] [netfs?] KASAN: slab-use-after-free Read in iov_iter_revert
To: syzbot <syzbot+2625ce08c2659fb9961a@syzkaller.appspotmail.com>
Cc: dhowells@redhat.com, jlayton@kernel.org, joannelkoong@gmail.com, 
	josef@toxicpanda.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mszeredi@redhat.com, netfs@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git
7a4f5418

