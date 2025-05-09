Return-Path: <linux-fsdevel+bounces-48626-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 518CBAB190E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 17:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B6CA9E052E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 15:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C2622FF2B;
	Fri,  9 May 2025 15:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Cg1T+LEB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C736C20E6F3
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 May 2025 15:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746805296; cv=none; b=KpKiyubMq5vPsWplUUDceWY4pVFqXRx2ML6Jx3hsmwI6w4f0f9RFa6vRPSibiuKeAYhKzyn3EDjtw1SeC6EXPCc1nOnOt+DXMGTIN4wYdAXMrl7cS2w8COfC8lRPqnYMLz+6kYrV9403c1ASHR9f4pfIuWKTp1CqmEQmEulnDO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746805296; c=relaxed/simple;
	bh=S1TcFhsO8IuWax2qpukdjZEEzxsOR3bhYcd+kz01eqQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HcTsIOasUZaunWh6I0K1Zto+w3s8OYSvsUQKcMP3Hi/JAaXO4ufAQ4dBV4lYn0hS8OAo3wMsZlLxdKPRdXfJ0GRTBAZ5hfyAPWTZpuBxT5rvRQbq5T0nbbHraEn9AZlaJArRTpNXmL0kCrptea2f6TX6I2m4HqjcIO68L2NN/q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=Cg1T+LEB; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-47690a4ec97so27908481cf.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 May 2025 08:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1746805293; x=1747410093; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iwHQGzvOP7v2YH6Hs8V0N89gjwgRW1O9VhViKG5Uyck=;
        b=Cg1T+LEBiBcxOd/4ndzM1VerY+G9lm08mpDaZsAJY+CE6WJGml5o3J1WhIyuQdUr0i
         5TZYVtmpMSA5i/r+AM0HNDIfClIh/ymOPdj6PVzNFJFU0Jf+/ZXa3qfHvm5pkhIzYSGA
         7fHJ+hGd0iD9nCTnFg1MuTGmGE/SrtijuYFcw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746805293; x=1747410093;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iwHQGzvOP7v2YH6Hs8V0N89gjwgRW1O9VhViKG5Uyck=;
        b=lCAWlAz5Y5IW9M0QEq2S3AMLE335Tv/znzQpE2/FlpxBwMqPQczB7H8B789b7aNPbC
         AeXUDWAnTDyqaDQg/VF3LljC5LyDeTilqfTR/q4YlVaAl0Uq80vuHxfkeSZsmJYOWfGC
         r3mSTiRLgy8Tw7VsMSXCXzhi3mRzB407YRyP5LLUa5AXkiJAtwGt6ojEeahiPNF+QLu+
         svJnm/1h8AYOqA1wHd1MME+KJlpJ3P9pIK/0J3XyKlEELA55e0c9LcSh35kxfuKGVKtn
         XdFizP1YIw9hfiYafpe4yguyCZna7J0OOEcZtm/Pf2sHPiaVrPydivwHO6cW+WftZ9FS
         pa9g==
X-Gm-Message-State: AOJu0YytRrhg9aMWgJ+pWSY1ZNV4mPtb5nX9QLScXG9sYCzkntFGxzZ2
	z5Ar0lU4OAK57A7u89+JpDDmmH3F06t4hm5JnstjnZYKai4zWOD+K5/ab1oRI0/jR+pjOSHy8bb
	BqQwsKJCgc8mZwHlFzrfnNkvgnm5M+pQrj8QMbQ==
X-Gm-Gg: ASbGncsM8DAcPXTwr94OY7UfPg+uwTlWXEjHGPqVm/AUCO9mVH0ob1OqyvgTp2f3OMG
	9vYp2+L0RRpa80jIjaqekYtcLdhdRd+o7LOvfZOibo8W2HItKDrQ9EW5ytbIkMUw91kfzvWRbaU
	4Da8hDC/cP1OP7O/62jEVA9i+4
X-Google-Smtp-Source: AGHT+IHie2mMkOwHaJXzlXwnOBktp1YsWcPyKpVoybowMoCHOLI8z4YHYt1gX1w3k9K4VNdADMj+ALV9TflztfXJr2Q=
X-Received: by 2002:a05:622a:1481:b0:475:16db:b911 with SMTP id
 d75a77b69052e-494527f3c22mr60158151cf.52.1746805293253; Fri, 09 May 2025
 08:41:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250509-fusectl-backing-files-v3-0-393761f9b683@uniontech.com>
 <20250509-fusectl-backing-files-v3-2-393761f9b683@uniontech.com>
 <CAJfpegvhZ8Pts5EJDU0efcdHRZk39mcHxmVCNGvKXTZBG63k6g@mail.gmail.com>
 <CAC1kPDPeQbvnZnsqeYc5igT3cX=CjLGFCda1VJE2DYPaTULMFg@mail.gmail.com> <CAOQ4uxiBLc9G+CvU-m5XMPbkFJLeCt6R86r8WaGEE2N3k9_qrw@mail.gmail.com>
In-Reply-To: <CAOQ4uxiBLc9G+CvU-m5XMPbkFJLeCt6R86r8WaGEE2N3k9_qrw@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 9 May 2025 17:41:22 +0200
X-Gm-Features: ATxdqUHGurym9NMfs8N7OJsvJs7tgZIOweBaG78XipqocvUE6unX_cB3PETlOXo
Message-ID: <CAJfpegvaCTxS_wC6EGFfh3Gim5DEgOtuju=_=qCsouzkCRvJog@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] fs: fuse: add backing_files control file
To: Amir Goldstein <amir73il@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Chen Linxuan <chenlinxuan@uniontech.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 9 May 2025 at 17:19, Amir Goldstein <amir73il@gmail.com> wrote:

> I remember that there was some push back on this idea.
> If there was no push back, you probably wouldn't have written
> listmount/statmount...

That's true.  IIRC one of arguments was "we don't want to parse
strings", which is not relevant here, since both proposals are text
based.

Not sure if there were any others, will dig into it.

>
> I think that for lsof, any way we present the information in fdinfo
> that is parsable would be good enough for lsof to follow.
>
> We could also list a full copy of backing_files table in fdinfo
> of all the /dev/fuse open files, that will give lsof the pid of fuse server
> in high likelihood.

Right.

> But this is not very scalable with a large number of backing_files. hmm.

That's one of the reasons why I'm advocating a hierarchical
alternative to the flat fdinfo file.

> Is it a bad idea to merge the connections/N/backing_files code anyway
> at least for debugging?

Maybe not, not sure.

> The extra fdinfo in patch 3 is just useful.
> I don't see why we should not add it regardless of the standard  way
> to iterate all backing_files.

Ah, missed 3/3, sorry.  Will review that shortly.

Thanks,
Miklos

