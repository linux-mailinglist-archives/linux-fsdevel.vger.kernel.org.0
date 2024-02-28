Return-Path: <linux-fsdevel+bounces-13086-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7578C86B16B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 15:14:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 053FBB29D6E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 14:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B3D81534F4;
	Wed, 28 Feb 2024 14:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="NyZCX3T7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28A214F998
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Feb 2024 14:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709129656; cv=none; b=gyCiXFh46DRVkBEZZ2ozoSqvm5fnNTTs9PQ/oz8h7uu9+kCuSNYKlMej+BjQpuLQHG8unMcZK/jBY06TbC0Q7DGdNkPur6McbC/noLBBD4oEuSHFp4QrzZZZ0zvc+j/9cspfpX0u/o0pMfPug+FpISOVzDoeLnXlVMLHss0UN2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709129656; c=relaxed/simple;
	bh=StE3BNfMnJAiSX82OpAC0iLGH3GLzMtbBwqWYw4IZGg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OMIEekFp1PSxgv8w6pejw2CvG2X3BLlo9eTVp2Hk7IqcR5+4ZKutVE20LQ4EKMvDiPHNH4vg2qjNB1102f2onYMwJE03Dh2SPEmdztVjDP4FwLIFhqd7jafxpGCTOWpJ/7i4T+0MiEvPLxNuZpzqrmJ9wDo7664FLST9DRxYNZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=NyZCX3T7; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-564fd9eea75so7091922a12.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Feb 2024 06:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1709129652; x=1709734452; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xWvy1mHzaknU/IiKBwn07x/YhG/st3p6ekUL3X/i25g=;
        b=NyZCX3T7Gz2aTctmz+4YZ53hzBYlk47uNQf9qWNBU2yBi2gDFThxRLbY+cxMBqlu9e
         CMl3gDNU9gJsR2SbUURXPnDwJ4EYR3FIC+JKMbWb2wuYFdh7AuS5iiEsnvjkP9vnIETC
         29j5b+W458BaZJ9oAA3kNMgdBZFa0skuPqNIY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709129652; x=1709734452;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xWvy1mHzaknU/IiKBwn07x/YhG/st3p6ekUL3X/i25g=;
        b=Ym9rfJb03BHc6HbINvDL/tWfPBa+TRxnLcRVAY4TRDDKpOxY+hTBxSVFgbaQns7Zwk
         yOMngcbcFbBTdbFG3sOOx24xknh5M/cvM+sZ1wpFLm+irA7qp0VCsGmbtLQVcvmIXLPV
         pcRDtUO1Ee4jSkyeLZjHuaRAcjcblwlgu7d91MLCaBZeTjx9i6lHsarkLkFa7/ie2Z0f
         E4rD6k9/xzxrWlBWe9ErgCLlkv3q52Nk0ev+Eu3TFIrcWdPDmehhVKbGZi2rlcXslUBN
         tNsVx4nh5pLIJtZVoukqzC/sJeipqnqIHymndJ/hbx1hhXQvZWd63fw/zhl/4HUH9rHk
         /xcw==
X-Forwarded-Encrypted: i=1; AJvYcCU0NTbDjWEhpfr5grPhbMxoOs0J5W+cORMBTagvn4CxiqlrswseSs2l9/ATqNwRMxvAnDWMbN0tp6Vna841HVCUhecoK+dL++6hX7GGaw==
X-Gm-Message-State: AOJu0YzLNjgxPuCOdA8PXTzUQRMK7wx6n4Ig+PHwfOlrZ0kXecKS06Y7
	UoleKI+wOirttoMF29889wU31DSDd54cKBs91o2MCNXY12QSmXlGqocLswEkbWoDhENsCiDixQ7
	e9r8KIobUIwGPcXOaiW00pIO5C0QEtv7LqvF34Q==
X-Google-Smtp-Source: AGHT+IFxcZKbsOEf105oI9QjZ62D6juPbzWv6rx1u9zzEAkNL7EHk6N3EnwfwPOpuIlkQtAHQIv8taBk8QkjphR2xE8=
X-Received: by 2002:a17:906:6805:b0:a44:12b9:3762 with SMTP id
 k5-20020a170906680500b00a4412b93762mr929379ejr.10.1709129651932; Wed, 28 Feb
 2024 06:14:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d997c02b-d5ef-41f8-92b6-8c6775899388@spawn.link>
 <93b170b4-9892-4a32-b4f1-6a18b67eb359@fastmail.fm> <BAQ4wsbXlrpVWedBrk1ij49tru5E6jxB11oY2VoWH5C7scO9FgmKRkQIsVekwRNgfxxxwWwWapZlBGSGQFSjSVhMs01urB1nLE4-_o5OOiU=@spawn.link>
 <CAJfpegvSuYPm-oZz8D3Vn-ovA6GXesXEiwvHTPeG5CzXQPQWDg@mail.gmail.com>
 <5b7139d5-52fd-4fd0-8fa0-df0a38d96a33@spawn.link> <CAJfpeguvX1W2M9kY-4Tx9oJhSYE2+nHQuGXDNPw+1_9jtMO7zA@mail.gmail.com>
 <CAJfpegssrySj4Yssu4roFHZn1jSPZ-FLfb=HX4VDsTP2jY5BLA@mail.gmail.com>
 <6fb38202-4017-4acd-8fb8-673eee7182b9@spawn.link> <CAJfpegscxYn9drVRkbVhRztL-+V0+oge8ZqPhgt4BAnvzaPzwQ@mail.gmail.com>
 <f70732f8-4d67-474a-a4b8-320f78c3394d@spawn.link> <9b9aab6f-ee29-441b-960d-a95d99ba90d8@spawn.link>
 <CAJfpegsz_R9ELzXnWaFrdNqy5oU8phwAtg0shJhKuJCBhvku9Q@mail.gmail.com> <f246e9ce-32bd-40df-a407-7a01c7d8939b@fastmail.fm>
In-Reply-To: <f246e9ce-32bd-40df-a407-7a01c7d8939b@fastmail.fm>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 28 Feb 2024 15:14:00 +0100
Message-ID: <CAJfpegu-6WP2nDOh18NMY1Cg3QJ19+tWXfHUax7qp5EUxAe76A@mail.gmail.com>
Subject: Re: [fuse-devel] Proxmox + NFS w/ exported FUSE = EIO
To: Bernd Schubert <bernd.schubert@fastmail.fm>
Cc: Antonio SJ Musumeci <trapexit@spawn.link>, Amir Goldstein <amir73il@gmail.com>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	fuse-devel <fuse-devel@lists.sourceforge.net>
Content-Type: text/plain; charset="UTF-8"

On Wed, 28 Feb 2024 at 14:16, Bernd Schubert <bernd.schubert@fastmail.fm> wrote:

> Could you still apply your previous patch? I think that definitely makes
> sense as well.

Half of it is trivial (s/make_bad_inode/fuse_make_bad/).

The other half is probably broken in that form (see 775c5033a0d1
("fuse: fix live lock in fuse_iget()")).

Things get complicated, though, because the root of submounts can have
nodeid != FUSE_ROOT_ID, yet they should have the same rules as the
original root.   Needs more thought...

> I think what we also need is notification message from kernel to server
> that it does something wrong - instead of going to kernel logs, such
> messages should go to server side logs.

That's generally not possible.  We can return -EIO to the application,
but not the server.  In this case I think it's better to just fall
back to old behavior of ignoring the generation.

Thanks,
Miklos

