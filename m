Return-Path: <linux-fsdevel+bounces-13109-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A5B86B4A9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 17:22:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F7682899B4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 16:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F7E26EF05;
	Wed, 28 Feb 2024 16:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fko8KDgo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2276A6EEE2
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Feb 2024 16:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709137323; cv=none; b=B52HLAlzS+O1ZzOkaOZrVXxmwKUQUV/R8nupZWUgB4q/ewtMGtggKQwGyYZfde2Py8w8m/gSxYCzVWHdNZLCv1MTqX4bvbbCKrJN2jFU66SP6it/VIE4oZYcsIkyGC1MwsBxrPHS1yctP59oqadTP3L1EQualE+TD6omDl1o38E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709137323; c=relaxed/simple;
	bh=6b9WN4BHnM+fkyceFQS+jklKWx83G11NL9OI1OqeO7k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QOwXMclseZ+cVvrynXuWqJkbhgeuWIeLZnvYTplCxD3R+ePXLCfJ+btI5C2B8iffP+MkzvrH+MsqIxMS/EEMAgpTlXDa85nZmTwBN9TCvmJQAgT7iYUSWpgeu/FJ9+879kPn/K8Hs+8jDmBCsP3XF0mcHUkb4rT+7dYfrzo4DHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fko8KDgo; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6e2ee49ebaaso2322351a34.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Feb 2024 08:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709137321; x=1709742121; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/p0B5eD/2RDhdm0lJf1FVCWakbINUrKkO2xuvlpCHx0=;
        b=fko8KDgobQn3ISIE7pDRMsOR5Z1lxFd9FFKz4WzoqFMgifJfAX50LO31sJIFaXUGlj
         vSaLhshdfPWS5asoa1OaKWSby2dG0G5WPU910RktaYa/DfQuAFKFgXZAinNNuEf7ZyEL
         wwmpa3mKGMKthnJm3YcpbvxZEdDLuodeRCcU/C2Hn2K0sOpb/GeCVCjRtYjwWWMm41o0
         rJYECc3yOOdWa6mJ0YmSfm1awAxc0GwiucSkvi1k/qxwCCm/kKPnes5OzBL/pHx/dI7y
         oWO4gahy4KugKEw/LJCDGf9bDBH9x9w42xFFpT7JRINGm8115Kc5av8HNzst0Z+J9SY7
         DfNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709137321; x=1709742121;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/p0B5eD/2RDhdm0lJf1FVCWakbINUrKkO2xuvlpCHx0=;
        b=TTfZIOV8n3K47pWIpYe9RdhtLURubOOwEAIEAzTziowdwTRp9GIB4idKGz2vYg/EDu
         GUZCQww3N3POPD+O4arNBlSSZmmww3doUFHvQtnxBkV4OVVQo7oe8p8gslE13d9YB5sD
         Euaafo9iyunBgv2AMs8dXL1u4UPy24pM/fjsAccQEcMDkyAWG28FYTOGDOwoyDRfwpbu
         EAC3GixjRdPJjtOBXev/3h+xbCRh3zPGecU7Tu+B87hsmIvwCyugMuRaxKe62tnmcdFM
         bna8x5dfeeqWLb1LrKAyt1lBw7t3p2WzZ2zwdlP3h3GPAtHacnqOxTgdNkrYCwQx1i8R
         hy3w==
X-Forwarded-Encrypted: i=1; AJvYcCX7Idi1bFUPC1pj26Ia9E3yEsaFA4VqQTlMg4930abul5EFkisoVPYLo29LooIxegwStGFCryrkv9Iup20cxt/rPHQ6jbAZeuooT7sNzA==
X-Gm-Message-State: AOJu0YwnkDZKKdEklf28n0kiCxzj2eJ8zSWI6e0BTT8nSCC7yfTJXaUC
	RobBMb0MulrE4atFwplKQx2rJtCiqiUwHcymEuL4H9ZhKyRJXN3qVbD47+u+Zem4e3Y6eeBBrVB
	s21Vrsgkxpc04u2SvkEoRWw802POA/F9hecY=
X-Google-Smtp-Source: AGHT+IHdrYxVNe3yZR5nFN+iGvCWn+rqR+cLvjv1VM/4T4RyNtwnYsukMA195EEPaiM48zKS/1rc7c0cy9QnTPJO+Uw=
X-Received: by 2002:a05:6870:7a18:b0:21e:9236:a37a with SMTP id
 hf24-20020a0568707a1800b0021e9236a37amr177584oab.34.1709137321102; Wed, 28
 Feb 2024 08:22:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206142453.1906268-1-amir73il@gmail.com> <20240206142453.1906268-4-amir73il@gmail.com>
 <450d8b2d-c1d0-4d53-b998-74495e9eca3f@linux.alibaba.com> <CAOQ4uxhAY1m7ubJ3p-A3rSufw_53WuDRMT1Zqe_OC0bP_Fb3Zw@mail.gmail.com>
 <CAJfpegu3_sUtTC1uCD7kFehJWTivkN_OjcQGsSAMkzEdub=XTw@mail.gmail.com>
 <CAOQ4uxji-yzWFeQYP9FKvVXg473GP6tC2pyHUbEPoYxT+qDYsA@mail.gmail.com>
 <4e3d80ad-3c61-4adf-b74f-0c62e468eb54@kernel.dk> <CAJfpegsAs3V8jU2UWyJUB33FCbmoFiOSp9Cjzrgc9+XcomN0Uw@mail.gmail.com>
In-Reply-To: <CAJfpegsAs3V8jU2UWyJUB33FCbmoFiOSp9Cjzrgc9+XcomN0Uw@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 28 Feb 2024 18:21:49 +0200
Message-ID: <CAOQ4uxj2ehXJVdG63U4p8JA7vLy2OCLLvEHmGg_b1eRrM3b3KA@mail.gmail.com>
Subject: Re: [PATCH v15 3/9] fuse: implement ioctls to manage backing files
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Jens Axboe <axboe@kernel.dk>, Jingbo Xu <jefflexu@linux.alibaba.com>, 
	Bernd Schubert <bernd.schubert@fastmail.fm>, linux-fsdevel@vger.kernel.org, 
	Alessio Balsini <balsini@android.com>, Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 5:01=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu> =
wrote:
>
> On Wed, 28 Feb 2024 at 15:32, Jens Axboe <axboe@kernel.dk> wrote:
> >
> > On 2/28/24 4:28 AM, Amir Goldstein wrote:
>
> > > Are fixed files visible to lsof?
> >
> > lsof won't show them, but you can read the fdinfo of the io_uring fd to
> > see them. Would probably be possible to make lsof find and show them
> > too, but haven't looked into that.
>
> Okay, that approach could be used with fuse as well.  This isn't
> perfect, but we can think improving the interface for both.
>
> > > Do they get accounted in rlimit? of which user?
> >
> > The fixed file table is limited in size by RLIMIT_NOFILE by the user
> > that registers it.
>
> That's different for fuse as the server wouldn't register the whole
> file table in one go.  The number of used slots could be limited by
> RLIMIT_NOFILE, I think.
>

Yes. We can limit the number of backing id slots, which is the
number of FUSE_DEV_IOC_BACKING_OPEN for whom the server
did not call FUSE_DEV_IOC_BACKING_CLOSE, and we can easily
display the backing files in backing_files_map, but we also have
inode attached backing file, whose lifetime is that of the fuse files.

Those all harder to iterate and harder to limit, because the server
cannot close/revoke them.
OTOH, we could treat the inode attached backing files same as the
overlayfs backing files - worst case they only double the number of
files in the system.

We can probably keep them also in backing_files_map so we can iterate
them, but maybe let's see how the basic feature works first...

Thanks,
Amir.

