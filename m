Return-Path: <linux-fsdevel+bounces-54513-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F450B003EA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 15:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B0F77BACA2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 13:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C1A262FC0;
	Thu, 10 Jul 2025 13:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="XEgfwOn6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FC9262FCB
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Jul 2025 13:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752154900; cv=none; b=avtcJc00LcwZFw4H0ca4sRKKUUnAxwFmHBxMRjY3vOBTKebnQmYj3A7BLEBeg2ZL1sE29DBeq/ETsnchdTL8vUheZjaEGIQ2fjcDgckpsn83AbwyG3PxfQX8hqWnKdwUSlBfsUjft5UpFrzs9ZcK27sFm3s0JJH7YAowfgJGpCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752154900; c=relaxed/simple;
	bh=Y2cPTKyp8+pa4kvRMd2DbHQIqkwHAegaMbr/kZOwiA8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iz3xDNBOBq+r/bi8gjGx1dyoRV5YrPnGhzmBBllPvTpjaHQSAe8kSfwNCN2kYPIAX/Yh1fd8ywlx8EGtK4Pd4mztS7CbqvoKjenD8rJVpGoH+gY86uqnDUOjdkiadLsmKz1Wqw1poSXHPVzj/ipkJM3NM4zyCe4P+glFhoIu1Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=XEgfwOn6; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ae0df6f5758so176355666b.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 10 Jul 2025 06:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1752154897; x=1752759697; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y2cPTKyp8+pa4kvRMd2DbHQIqkwHAegaMbr/kZOwiA8=;
        b=XEgfwOn6lEE9/qgA61ga1NXFOke9ca1L74o1p+WZjkWJ/CM8+cXLpM0vWp4RAJlLmt
         E8/aZmPgy+LXVRv48r6krjog3A0x17OhAewlZxL7OkaVnj856GbgLsg2QB1/aszz39oz
         BuY+cNeHTRWSvj0R0JYI/b7eQdDRE+7TgV0Li1xTF+K9owuvbD/axBa6hxrc6Q9cFS3n
         4q6nkCk8BMNizCuUGd07o5psDhI48EXo+KMKRTMof/QYIrsbZGFdKDjw4hsPqpt/0OH5
         NCfpXVYRoeOdWeXWxUuAsZ3kndaSvJICAtqmuRNWcPry50hpsC+ldjdkaBZ9kBt8vJ5X
         OxYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752154897; x=1752759697;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y2cPTKyp8+pa4kvRMd2DbHQIqkwHAegaMbr/kZOwiA8=;
        b=S/KVGa2cqzJ6ko/xC4CpaFbm5Qxhyai5LgS9Xk6nd5kr8xLAiYRRU/6GvZLy7Yr/NS
         0cyQNNjl2WsUh5b3mfe7HvKENpAoSuGKr7ubof1sZ5992nvZWk4WYHX0ShbiT1h9D33Z
         5kGL+vqZHoNOi4ulgKouq7vEyEENH3yfjhJ7FsXVJ5rROpjznPIg96zYCwi/0jouUohA
         R6gwXzCSUe6YGIGQcBbWOSPfQiwWXaCy/WEPQ9hz4+rRrf2JSl/5KN0WOVqmwnnkhOmP
         MFERIwqZOIJQrAIrrb9HRBHoqmdfFoSlrZ4cgH0sK35PrsD0Swe0luhlAZs2jkLeLAqW
         1LQw==
X-Forwarded-Encrypted: i=1; AJvYcCXEuNCxT5uec8H+fflyg8UAPsBMLBP2mtgUEOdk5DMc4M/KkkR3kOyfbMsFPCnRXZlEZIPOrl4wWchL6s49@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ3PTPgZZcjDieHOUpgR84ptZ674WAsemuf5UJIDZfsoZuQUPL
	0TgWpf5bVhBVLt5R9OX2TU4rkdv6WDHeoQrFTaBec4sDLh2I9yieeq02EMsr/7I8eSoYt34t++K
	IdemGdwaOOiwNGZRH2chAbK3qLmFLlSTl4InIBTMdaA==
X-Gm-Gg: ASbGncsKCDYuoAO9PS1s/413n9VEOor5ayCtv4UmjcCHvVmfUsMXLVTnNbsFoqxhiqg
	fkpTNWy6hhGKCfrj7+vRDN7knOdI3nMSnCKSal2ScaLFpeOOi2JKB/BhrBdtALpXu19fgSMomRi
	agksG5+Chr3UCy79W2Z7adIsnJ25iICyJtbT5IBlSPgNBNyjjnBLE9SLhk55Mb63fBiChpZ1A=
X-Google-Smtp-Source: AGHT+IEUfIhpap/ErtxncROC/XukLmMNwnnCP5z2dolLnhei5TAHwMgshdrm44CHSjNOH/5s8BRS/dOJLaexhl9LvyA=
X-Received: by 2002:a17:907:d93:b0:ae3:6390:6ad3 with SMTP id
 a640c23a62f3a-ae6e6ea0035mr262408366b.22.1752154896676; Thu, 10 Jul 2025
 06:41:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701163852.2171681-1-dhowells@redhat.com> <CAKPOu+8z_ijTLHdiCYGU_Uk7yYD=shxyGLwfe-L7AV3DhebS3w@mail.gmail.com>
 <2724318.1752066097@warthog.procyon.org.uk> <CAKPOu+_ZXJqftqFj6fZ=hErPMOuEEtjhnQ3pxMr9OAtu+sw=KQ@mail.gmail.com>
 <2738562.1752092552@warthog.procyon.org.uk> <CAKPOu+-qYtC0iFWv856JZinO-0E=SEoQ6pOLvc0bZfsbSakR8w@mail.gmail.com>
 <2807750.1752144428@warthog.procyon.org.uk>
In-Reply-To: <2807750.1752144428@warthog.procyon.org.uk>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Thu, 10 Jul 2025 15:41:25 +0200
X-Gm-Features: Ac12FXzl_JlkX217YnsQK9NDpeOWbIXCejwCEnw4V1qbmZHn5mJ_E34Ih5jkMNQ
Message-ID: <CAKPOu+9TN4hza48+uT_9W5wEYhZGLc2F57xxKDiyhy=pay5XAw@mail.gmail.com>
Subject: Re: [PATCH 00/13] netfs, cifs: Fixes to retry-related code
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <christian@brauner.io>, Viacheslav Dubeyko <slava@dubeyko.com>, 
	Alex Markuze <amarkuze@redhat.com>, Steve French <sfrench@samba.org>, 
	Paulo Alcantara <pc@manguebit.com>, netfs@lists.linux.dev, linux-afs@lists.infradead.org, 
	linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org, 
	ceph-devel@vger.kernel.org, v9fs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 10, 2025 at 12:47=E2=80=AFPM David Howells <dhowells@redhat.com=
> wrote:
> I managed to reproduce it on my test machine with ceph + fscache.
>
> Does this fix the problem for you?

Yes! I can no longer reproduce my problem.
Thanks, David.

