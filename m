Return-Path: <linux-fsdevel+bounces-19978-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 697B88CBAA7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 07:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4060AB207E3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 05:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7019D55E53;
	Wed, 22 May 2024 05:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eUtyHVIt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F25746BF
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 May 2024 05:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716355576; cv=none; b=f4C1mkR+4mPsOWcuEuIqp2W6PNCoUOZSvGI59amq2cCTgtzMWjxxV7FwjKtXtOdl3aWrUikC/1Kxi6obrFX58yi2SDLyIanw3d3NLFo7abgmwlZAlNl33AXK1YZXuBaIKtg7sitgbeXZFrPbpmelLV0qwz8/dg1di4RFUhpqYkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716355576; c=relaxed/simple;
	bh=mRHWU+QVqWic6ek3cPYHxhjIuOZJrBHZXf7AogPN+eY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OWEO9T2oShtzxy9wU/qRaFeaHcZor+EnzFLvvmr8JMKbUUgQvB8fRlAPmpF5i3ay4a4tF/awWDo0GUYAmEkJbJDgNwUFO13PAicu517nu8VVtkZ9a5uHdjQv+CcZxm74rYmPHmL+wiDXKtic+QEbGRJz1xvVFr/YJit0bg8YMpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eUtyHVIt; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-792bcfde2baso72888085a.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 May 2024 22:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716355574; x=1716960374; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mRHWU+QVqWic6ek3cPYHxhjIuOZJrBHZXf7AogPN+eY=;
        b=eUtyHVItUGVv7sL48gdcz4cjNE0/BkhDE9Yxuz20kNsSTFp2e9qBWrb1/n7YP/yxg1
         0616xyDitCxR5iw36pCqG70K0ixRTBThS4Sax+6soj23LHQAUhpVqyTTyq5+tIBry3Ir
         6gGb6px7qDEfpTFrhXzIk2+J7WvRUZrjkFMx1veyGM1fg20KVfiiADj/LusWo9ZfAXzy
         PLCXZAXJbu+Sqa7X2gOJ/4SyDAdrudHjfSAmcJ9AJ3SBwsFU0Djelsmcchu+NCO9g09u
         Xn6VE6V6HYuhHEzh7s7YJKiYvuHBSrKfKU3cmCjN4RFeCirLrTvI0t67xfNWCagOI0DO
         AAeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716355574; x=1716960374;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mRHWU+QVqWic6ek3cPYHxhjIuOZJrBHZXf7AogPN+eY=;
        b=TQ4PXnbwd5TfbkZ7FxWQOVAyd8lavbr9CFvYtReWmfk8Lqx7x2QZMe484ThPu22nGY
         MydUgFAR+lHLh2gwbiaXbArSJ46Uc3IlAKeSmfSV6UnZZApCgOHLyTN796pOPjF9BAO4
         DCqT0r+sYhNRnGB0W4KM3aIwROwy2wL5fmoPUtRJqGj/99yu1rfKGBgFVOo4SI4+ckAz
         xHSSXtBfuVkP7s7O1xb3uVha+NbrFGFy+phwPE5gf7UIMi4OvTKoP3/sOI5iiMrQYbnH
         +DqcspvEhkKz8j4zm+avaamQ2OQMTQFZKoQv/0P+BTKucCYBegQRIuJXUaEIRyHiFQPK
         rfeA==
X-Gm-Message-State: AOJu0Yz97Ev+pLCtsocTNAk51IJppr2C95lHL1AGeV1owwWXuac8bpre
	q3GNsnwMt5jMZMwck1snQsdIXqx4QcOusp5ruDxnWozGd7I0bAPXcxU26nMYZWZ9mZtvU2l4jEh
	iQvz38zuFLNi5E1IZ1yJZ7HowcT55Fw==
X-Google-Smtp-Source: AGHT+IGAZMeB1KfhYTmKD+gzaNopBBopBg7WCw12IKVHdNwvYaJ1a5P4X91+OY2ZxcKsEI4DVZLRnB9cvfYIzvVrdf4=
X-Received: by 2002:a05:620a:558d:b0:792:f87c:7eb5 with SMTP id
 af79cd13be357-794994b6803mr97483685a.57.1716355574424; Tue, 21 May 2024
 22:26:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPSOpYs6Axo03bKGP1=zaJ9+f=boHvpmYj2GmQL1M3wUQnkyPw@mail.gmail.com>
 <CAOQ4uxjCaCJKOYrgY31+4=EiEVh3TZS2mAgSkNz746b-2Yh0Lw@mail.gmail.com>
 <CAPSOpYsZCw_HJhskzfe3L9OHBZHm0x=P0hDsiNuFB6Lz_huHzw@mail.gmail.com>
 <CAOQ4uxhM-KTafejKZOFmE9+REpYXqVcv_72d67qL-j6yHUriEw@mail.gmail.com>
 <CAPSOpYuroNYUpK1LSnmfwOqWdGg0dxO8WZE4oFzWowdodwTYGg@mail.gmail.com> <CAOQ4uxgOmJjJT=mX96-AwWY_p9fHXtvNZFUcPgqggKgGtpsq9A@mail.gmail.com>
In-Reply-To: <CAOQ4uxgOmJjJT=mX96-AwWY_p9fHXtvNZFUcPgqggKgGtpsq9A@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 22 May 2024 08:26:03 +0300
Message-ID: <CAOQ4uxiMtd80k9N93wjkO13vmmSt5s1333WdSrauGD_-b+rsRQ@mail.gmail.com>
Subject: Re: fanotify and files being moved or deleted
To: Jonathan Gilbert <logic@deltaq.org>
Cc: linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"

> > > If /home is a bind mount from, say, /data/home/ and you are watching
> > > both /home and /data, you will need to figure out that they are the same
> > > underlying fs and use a mount_fd of /data.
> >
> > My current plan is to discard any mounts which specify a root that is
> > a subpath of another mount, and in the case of multiple mounts of the
> > same root, pick one to move forward with (with hints from
> > configuration) and only mark that one.
> >
>
> You can also use open_by_handle() to determine if one mount
> is a subtree of another.
>
> if you have two fds and two different fhandles from the root of two mounts
> of the same fsid, only one of these commands will result in an fd with
> non empty path:
> fd2inmount1 = open_by_handle_at(mount1_fd, fhandle2, O_PATH);
> fd1inmount2 = open_by_handle_at(mount2_fd, fhandle1, O_PATH);
>
> So you can throw away subtree mounts of the same fsid keeping
> only one mount_fd per fsid as you traverse the mounts.
>

Well ,that's incorrect.
You may have bind mount of non-overlapping subtrees
and you may not have the root mount at all in your mount namespace.

In that case, you can always keep all mount_fd's of a certain fsid and try to
resolve the file handles in each one. Not optimal, but this is the information
we have in events at the moment.

Thanks,
Amir.

