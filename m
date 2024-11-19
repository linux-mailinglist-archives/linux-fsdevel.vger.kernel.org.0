Return-Path: <linux-fsdevel+bounces-35233-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C36CA9D2E02
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2024 19:35:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01260B31928
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2024 18:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C03C71D2234;
	Tue, 19 Nov 2024 18:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UaiEF/uh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E821D0F63;
	Tue, 19 Nov 2024 18:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732039670; cv=none; b=IijXZ6sX82ArgihpZZOTE5/vCb8QUeACgPdQENldtf1QT+KzA46SE4pjFWZKxgzSDYhZqdlA0iXuzIpheTv7mowqlkAK5wl23xuA9+ehN0RzPSrZSKva3KhY14tMtrGViOHUlzmvnpGRnS82gucltkleq5enYMrNCbCs1NB89Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732039670; c=relaxed/simple;
	bh=oQF52UOBsgf58DOkdl1sz4LFstivHLwN3+CsZzhtXDg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SqO8crX/izYtRoJWeK+e0fgDPKNpzFjH4fo+JIPL1nu21VHvfJANkxt0HCGoOvsErOwQsLJIFEz0mzdvsuMYPcWEwQ+C8iG0NROmvveVyYt/fitkcVOO2KnAVqKE+uQFe/7bK8n5rvTeicPTyF6oNoyYLUGS2EQULEz5AOl1hao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UaiEF/uh; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2fb56cb61baso36756431fa.1;
        Tue, 19 Nov 2024 10:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732039666; x=1732644466; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6q0Eekqr4PrHChR3kf477Bf+y3yz5ioREserDyGSgco=;
        b=UaiEF/uhfMicRKP+N4IqWJZy4lDp4tKtBDQ06P+zUE5AVIVZ8dE4SJPnF8MlEbT4zT
         rmVUFw/duwClvO22tL0kNaSxfpo7sb+ly40ZsMYSYh0Qz3H5DdECI0syNo8QE0MC5/in
         9n6uqUXEFTsfFy/0s/9aZ2j/U4/Jwr81BjLFuqYGOIDQT3puh9ChorJNu07eFWaBBBIw
         t5/WsFQYb6/FvO4UQBmLprvd3nJRmOKr83Ba1IN8Qd716kFJNxP36bFyGmCZQoWDxtlE
         BO/sVC8GaZdXbXYC9/OCGNVohb9Y+qMdzbyovlQlZzgGhWepbJ492OyfoBIBkrX2NgE/
         bdtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732039666; x=1732644466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6q0Eekqr4PrHChR3kf477Bf+y3yz5ioREserDyGSgco=;
        b=S2CfzlTBW6ML41OkYX2z+K71uieNDByWTAPeKjazC8TNbdMr6CJQ48IRRt81WuOISr
         CXPjxQpVGzGcBD31ddS6rhzvR3yALay72vdZJPhOiwbH7pXWeVq+XOX7DWf+c35K+IbT
         YxIl5DN/B4tZYBK5lkZ1cA8MUCBU5ABCJn+LCXeTvWjz8PgVWsu2e3jnVytnU5XTQJ7E
         +jr/35Gsoct9oq3I8RCQY/xN8zxJpsoPWKrpBPvdVGUqHYwXeSAaaC1NotRH7r2vHeDI
         1/eMk9A7k5tm7sMJA/+OGsYRv9H8D4LjfzI68CNlyGG1UdzaLmquCxUohiEc25fmQ2el
         I07Q==
X-Forwarded-Encrypted: i=1; AJvYcCVH/CGW7a71her8rkS0rnYd8yd2GQGG/Ydvp6XjbAWX0IdyRTj9qhbZTEnRPSpCsDKTrP9gNOsn+5NB@vger.kernel.org, AJvYcCVpiNJAuKkSa8b5pP9+sM28WWvvTcbtktUka0MZRZPAuTO/JBL7kRf64G9zkrT6gAK8EIBcS1W6dy8OiQ9Z@vger.kernel.org, AJvYcCXL5aXOg8GXIMNwRdYbB77z5RErzvmSFQtcac0O8UBcBNb2QP9PG10I+IiAUx7lFYG4idmkO2GFxqIzPbLm7A==@vger.kernel.org
X-Gm-Message-State: AOJu0YzMEJDWN0a2i7b9CiruyT+cLAbEk03XPtKVMutfXax9Ue9PVB10
	KEq7VwsQEwney/9d3nd6VmEUnM8DOIhnta8hvHXY9C+1+impsUbwQ5ZsB2gZWkY7QOGwgrVKpY7
	sQ8/Tkz+xrycdpcuM1itOq2TEej0=
X-Google-Smtp-Source: AGHT+IHdqoConUqClj8wLIM0mBnQdxHrbtF0Di+KOTfg36XQ9fCzKrtjZchTS75uFzJMILm9d1Yqc4hTdgQdLeKqdac=
X-Received: by 2002:a2e:b88e:0:b0:2fb:59dc:735a with SMTP id
 38308e7fff4ca-2ff607494aemr69833731fa.41.1732039666148; Tue, 19 Nov 2024
 10:07:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241119094555.660666-1-mjguzik@gmail.com> <20241119175355.GB3484088@mit.edu>
In-Reply-To: <20241119175355.GB3484088@mit.edu>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Tue, 19 Nov 2024 19:07:33 +0100
Message-ID: <CAGudoHFnwtetYnypHWhS8sODnmcjnRy8VkR-YbV0MP9St3g89g@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] symlink length caching
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, hughd@google.com, 
	linux-ext4@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 19, 2024 at 6:53=E2=80=AFPM Theodore Ts'o <tytso@mit.edu> wrote=
:
>
> On Tue, Nov 19, 2024 at 10:45:52AM +0100, Mateusz Guzik wrote:
> >
> > On my v1 Jan remarked 1.5% is not a particularly high win questioning
> > whether doing this makes sense. I noted the value is only this small
> > because of other slowdowns.
>
> Do you have a workload in mind which calls readlink() at sufficiently
> high numbers such that this would be noticeable in
> non-micro-benchmarks?  What motiviated you to do this work?
>

I'm just messing about here. Given the triviality of the patch I'm not
sure where the objection is coming from. I can point a finger at
changes made by other people for supposed perf gains which are
virtually guaranteed to be invisible in isolation, just like this one.

Anyhow, I landed here from strlen -- the sucker is operating one byte
at a time which I was looking to sort out, but then I noticed that one
of the more commonly executing consumers does not even need to call
it.
--=20
Mateusz Guzik <mjguzik gmail.com>

