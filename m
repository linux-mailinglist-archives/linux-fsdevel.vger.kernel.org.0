Return-Path: <linux-fsdevel+bounces-64096-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84CA3BD81AA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 10:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BBAD19225F4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Oct 2025 08:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6EA430F7E0;
	Tue, 14 Oct 2025 08:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="rc1kw4HY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACF730DEB0
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Oct 2025 08:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760429226; cv=none; b=XJOgVJ5fdp1nNRCuu3saW1Mi5dF5W0UTa9zC8plEkTLUSEV5NG1eFaOqvpsEjbUGpQohCFOK7AEVgYJmnF6hAai0fd0ZAWr6swSz1PqE5/kqpohQSstoBsTgN2ttbM9fUQ7znR1mty6MywS8+0ELhAQvhSHgeQBlKG7ZpO4CHPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760429226; c=relaxed/simple;
	bh=gaSrNFnxGmoWet5IGMWfVxdar8Dax24kjJ0xtMz88wY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jIjZDDJgfwVGkRthArYWLinafEbTGJlP5yMUFWvm6+eNK1qe56+41VnWPFk7NW1wV6pVnJtbveslMK+Oorb7EJ44fNo1gtCk3gzX3Ge6XXrGygmB+YNqc3ReDyL9NsGwNqkHUkc3nbowFyJ9Eum/aeKFdU5KhTzHLWrI0wFbQz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=rc1kw4HY; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-78f15d5846dso83276556d6.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Oct 2025 01:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1760429221; x=1761034021; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gaSrNFnxGmoWet5IGMWfVxdar8Dax24kjJ0xtMz88wY=;
        b=rc1kw4HYUwr0J+7VjLspfU3d24nD+7iHjbbFHa4aJJMEPazlubRP3eBm1wfICIWAtE
         zB19VarqawbMtY4QCSQa2TX8nxHGoGnBWvWswkA3X2ZuQ8ItOY527qDJ1m2kE4GGhh8L
         Fhmoqs55xEDQnMA3i2UcCoiDeTF9QT3qYo4Pc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760429221; x=1761034021;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gaSrNFnxGmoWet5IGMWfVxdar8Dax24kjJ0xtMz88wY=;
        b=sCMviOJ1LbCU4bA9rW2wZ4TrrjjAA+lNmVKQeaEgIPkbQ537fsR8h/JxF6dOQheKky
         XNo/wfVZZdsxjxJzeHyqKLEQOxHES8x8NYpNizODOjuYEGuSQIcbrkie6UbmDN2w1z/a
         7daHiKDsg5kPa4BRl5ZmQYPyFskAooJPPxTf0ba6RbsqcyBFAH8um1QXSzM8I3xLcaZW
         V2/pFQpcU2NlV5/t9ja6tC3E2qObuFMx6J4QChTZCNe9SQuIST0hIUVTW3Qn7IjbiErr
         iVU/4JzBru29h/r/4fFZarKFhfYUFWatEaBGOhb2vcOTWNuliac1XDAGHBgdHzgeivt6
         RoSQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3kL/jdrcmBRabKCuShW9SInvl/e1YVUkByQpUw14oxGcR7LZNlx70LLTt7AeCDhVbpsQdPbhn+LiLL8sP@vger.kernel.org
X-Gm-Message-State: AOJu0YwerZzAt1rFQKKig7lFPl/Qg/Sp8zBbbGuGd1kDpWviQnwjgTla
	cZUmTb0PNMAW5Io/kO73/LkR2QM5MlROd9uThP3SYoTJtFItJQD1CMOaIoa27seQa1C/xfbOqfo
	ZBUUBUPt5a1dQ+QAcVGkLlTB/F+5tpyxT/VOQdztifw==
X-Gm-Gg: ASbGnctLC2z/JS05LsgAooqGKqoLbj6JhZzYPV9JorM+WUXtViB0JlIasstZsD0JuEL
	lPhELIeclJQhMGTMD6+9zBLQROXVGcRLnMMIimm7J6xq0ojYyCd2lKbiTN71QafWYikCRP7O75e
	QLzTswsm0JYFtJulzh/lz61A40yxW1Qbgbfj7FfXgCJniSKTfoQG7mh7J8NaufKPhKje2HmSb1z
	algtw1Xp6yezBG5qRpRgJVd/mmRBCOQ2kBpzdIQfHptkwA2mq881ey8rNA85lMFOFceiA==
X-Google-Smtp-Source: AGHT+IGZ+aeN0K7J2mOJHMpdF50iEHtXyXs8Vs6iTcWHhQxhE8sH0fNPoY2WKEuKSaxfOotYWPF0p7oQCdN5qZUhbrM=
X-Received: by 2002:ac8:5d05:0:b0:4b7:8d26:5068 with SMTP id
 d75a77b69052e-4e6eaccbd0dmr317846191cf.17.1760429221421; Tue, 14 Oct 2025
 01:07:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251009110623.3115511-1-giveme.gulu@gmail.com>
 <CAJnrk1aZ4==a3-uoRhH=qDKA36-FE6GoaKDZB7HX3o9pKdibYA@mail.gmail.com>
 <CAFS-8+VcZn7WZgjV9pHz4c8DYHRdP0on6-er5fm9TZF9RAO0xQ@mail.gmail.com>
 <CAFS-8+V1QU8kCWV1eF3-SZtpQwWAuiSuKzCOwKKnEAjmz+rrmw@mail.gmail.com>
 <CAJfpegsFCsEgG74bMUH2rb=9-72rMGrHhFjWik2fV4335U0sCw@mail.gmail.com>
 <CAJfpegs85DzZjzyCNQ+Lh8R2cLDBG=GcMbEfr5PGSS531hxAeA@mail.gmail.com> <d82f3860-6964-4ad2-a917-97148782a76a@bsbernd.com>
In-Reply-To: <d82f3860-6964-4ad2-a917-97148782a76a@bsbernd.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 14 Oct 2025 10:06:49 +0200
X-Gm-Features: AS18NWCR1GKck-Wej2NUo535YcBBaKeSQhVsfQwZGBEEsJgxvdNEg-fGJr-c27I
Message-ID: <CAJfpegt7WvXZr4D4kqGujD=MXEQa7oRH3gvk90+D7Pha0MJJBg@mail.gmail.com>
Subject: Re: [PATCH 5.15] fuse: Fix race condition in writethrough path A race
To: Bernd Schubert <bernd@bsbernd.com>
Cc: lu gu <giveme.gulu@gmail.com>, Joanne Koong <joannelkoong@gmail.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Brian Foster <bfoster@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 13 Oct 2025 at 22:16, Bernd Schubert <bernd@bsbernd.com> wrote:

> For an intelligent server maybe, but let's say one uses
> <libfuse>/example/passthrough*, in combination with some external writes
> to the underlying file system outside of fuse. How would passthrough*
> know about external changes?

It could use fanotify or leases for example to check for external modification

Thanks,
Miklos

