Return-Path: <linux-fsdevel+bounces-12999-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 657D9869F8E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 19:53:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EC711C22863
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 18:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B74DF50A7C;
	Tue, 27 Feb 2024 18:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NGK8v8lo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58743D988;
	Tue, 27 Feb 2024 18:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709059992; cv=none; b=Zh/CwcwCeMtlRgXPHn1VL3HCH226OYrzEQw81RyzYbF4+z9scJAnWuQF+VN1LfjkJT9knJV72aiysyZ0SC6aPeMFawTUSdvzbn6GXJp5fkTP0Vwvl2l4n6spP/Oh5ZfHQEQKHOMbPYVkntDv55L5VjMvcoHgKX4umSR2Jy6GWj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709059992; c=relaxed/simple;
	bh=uGlNX+jTcTfdRzjQAeiy2AnVPMJF4P3RTI9e5B0rT6k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FUGyVQuW8lxAHIZEp9SeuCLx9veERAIzdMJLLrTLLMyiO2BmgGbfHrHPvZDz5BwDQ9aAlZgwmo7KwfO0jGOrxnThvcJnCKPGkMTI0hbcoCfgxa80LhGNadMR14OoVKwoeDVQ6A1wHjb87M0q6taZbejYDI/yz1Adea63M+UG7ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NGK8v8lo; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6e125818649so1984173a34.1;
        Tue, 27 Feb 2024 10:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709059990; x=1709664790; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yJgE4tcZXxdG6qBUOGQDTe43qEXsMbRHBHt7t/okJWc=;
        b=NGK8v8lo1pE9XKgj+SkR6GgC131Ygvq61TCSLq1lTkdgK5gFRZmhos44+GNpCBkgNA
         mCKaTnxdxNEkzirpvcZYhCV2PqJJuKfWhfh1/N1kYslQFSnmozst9unkaqxI44e2ync1
         0xFFZgB3+wKd0w7E99zSTS8iEf1l/YmPyx9FwgFpiFG6m9OwUqMNqmElHdHBsoJ68Oj2
         wL0yJe7pw2z3ncgdKwn3Zxz49A896IabgJXUCmgR1GWTTv14+0C9IZORloEN31SGdXra
         dytafljuevVWnELphEITsjviJZmf2eR+m+LO7xr5A+hvAvpqdSgEJVRZUrvFp8y1Dtfi
         MOMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709059990; x=1709664790;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yJgE4tcZXxdG6qBUOGQDTe43qEXsMbRHBHt7t/okJWc=;
        b=fY+Eq1Rpbr4OSWT2jZiUNocp4WrAT0ULy0ev35h9ieSyv8uVDTwhY9iDhhdv/yNpwH
         /wuwcSrA6g/CIWypC/qVH3fFMO4tGGK4LXPk69UYgoZjkvS3boRdNMBRxdxgV1IneefA
         AMUmLd9W7Ib26DUTR2cCMFI22YlAcRIvSeJxOU2TFtvFpLWADorF5joqkGXlCCOZbPLh
         sxg/TKf4iVq525jbqS9wAtPe1xEpZAZWg1hdNSXqixmPey6lh8DPFNVDuEfBiztvzy72
         RF09iTZtfGsR4NU6QE3Sp0HBRatDnwAItjjrDIGNgqWHbucKHj5gnxBdN1SQRdkI5oie
         4dGg==
X-Forwarded-Encrypted: i=1; AJvYcCU0OtdvK6bH5Q0TioIIU4azYpeOxacLQVCTQpX44qp7TID2KZZ6+ClBmGp7XHTjGnuhMtx1e0rQAl0+2NVkr/aFkc2OW8V8cvOM
X-Gm-Message-State: AOJu0YwuIRAMg5aKihbwweYTSrIlO5DLuz0OM6q9HA5gq1PihuhX2xYo
	q0iIuKpBf3tXzdbYiREiRJGzO9odozU65gTAWocFsP74QXHczyhQwlaTnnHp3QPB39UyF6B13PA
	b8DOVEwhuE9Cel+mLd+nL5XeqQHY=
X-Google-Smtp-Source: AGHT+IGgee6map5f0/LWAGvZMZFz4YVnaUlS9R+2e+dWPduZL1ORSwwFai59AbPhG5WTSzRVNE+klUpCOq0oseYx6u8=
X-Received: by 2002:a05:6358:b3c8:b0:17b:583c:c4b7 with SMTP id
 pb8-20020a056358b3c800b0017b583cc4b7mr15147861rwc.3.1709059989857; Tue, 27
 Feb 2024 10:53:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <170900011604.938268.9876750689883987904.stgit@frogsfrogsfrogs> <20240227174649.GL6184@frogsfrogsfrogs>
In-Reply-To: <20240227174649.GL6184@frogsfrogsfrogs>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 27 Feb 2024 20:52:58 +0200
Message-ID: <CAOQ4uxiPfno-Hx+fH3LEN_4D6HQgyMAySRNCU=O2R_-ksrxSDQ@mail.gmail.com>
Subject: Re: [PATCH 14/13] xfs: make XFS_IOC_COMMIT_RANGE freshness data opaque
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, hch@lst.de, 
	jlayton@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 7:46=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> From: Darrick J. Wong <djwong@kernel.org>
>
> To head off bikeshedding about the fields in xfs_commit_range, let's
> make it an opaque u64 array and require the userspace program to call
> a third ioctl to sample the freshness data for us.  If we ever converge
> on a definition for i_version then we can use that; for now we'll just
> use mtime/ctime like the old swapext ioctl.

This addresses my concerns about using mtime/ctime.

I have to say, Darrick, that I think that referring to this concern as
bikeshedding is not being honest.

I do hate nit picking reviews and I do hate "maybe also fix the world"
review comments, but I think the question about using mtime/ctime in
this new API was not out of place and I think that making the freshness
data opaque is better for everyone in the long run and hopefully, this will
help you move to the things you care about faster.

Thanks,
Amir.

