Return-Path: <linux-fsdevel+bounces-42697-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15ACCA4644F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 16:15:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3C233AE2AA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 15:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA7A2248BF;
	Wed, 26 Feb 2025 15:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TG8E7+GN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6354D224884;
	Wed, 26 Feb 2025 15:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740582879; cv=none; b=o6H+oFCFS1MkwrVRC55AsrkbRlxBUNx3haHw1ZyNKXKfnrFyxA5X1+6tKHnvoX902ehqaYRIPkWnCB6YpN1sio2CHov9cl0E74DskBMKdWv3cPOZm6wJJDvCnkVSvFqFOVdHUjfuOfVFRPxGdgyWyq8oO5QPopO1vIMitZe2p+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740582879; c=relaxed/simple;
	bh=yyRE6mh4Xnw6o929p+0BwjDI3r6fmKQ8r+qGIXYy/c0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NcsqLEKdpwOricXZ6l96MtNYwdCZWaPZbhKDaXWoC0jgiyHC9u0em8jEsBHmieGkIiFYKk4sZlRiBuxia9it+7u8owwjr+pgg1lFMdomYqKp+D0XsUdQ1qyqXiaRtigMiu3UIUkUVunJfTAy9hato9zvifj4gxb93IAbHThyKQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TG8E7+GN; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=groves.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7272f9b4132so4599674a34.0;
        Wed, 26 Feb 2025 07:14:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740582876; x=1741187676; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YTaqEjHKJlm5xW0aHmbRjCVb26Fl7uOxN3rlFjPKc5g=;
        b=TG8E7+GNUK+uiiNhEYKIxdgrsjgZzyLC/IbGKqxS65xNs2GmXcO2n1J34bKRdcpImV
         Rjn/c+lNfxTWdAaUT692pVZEi+IKWOb74ydpaTwxrcRBeaLJ5QbKvAfDpZTrKvOXzydk
         4a9pteby1sDtRFIYLjxmNLZ4nE4MKU03rIlPYEYgiUYPCcqIxRGIdns/pl9lyGg1YfJ/
         zgTWzst7vDjsxo4T0M9zDHiXx4mTUJDIQOcQvCFitYGC3XS7jVTXvMkCGiFzV+E6eKGs
         8La7lgGLunRmuOuLeEG48he563NgtzwoBZ1Y91HUv2CIv7ZsjBjJe8HctwSwOt+lmE1H
         0E9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740582876; x=1741187676;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YTaqEjHKJlm5xW0aHmbRjCVb26Fl7uOxN3rlFjPKc5g=;
        b=iA39TCnrCiACwCL7bJcS0hXCwImiBv0HADz8F74S77CmguMaRdh0gnQeTRxtzthpVw
         D/nf9MR7PjGmKI9Rw70u6i+KzvvvHzB8DIC1E/F5jXY0VFlOfXAveDHd1FOKnTXwzENx
         pyDTc9cREUnbTb2/+p4iRqUXd4bPPH+VLUbEadwoWcD7eZ4M+PNaP4075SBqElVy+pUY
         0FCaO6ynH7vfEDsxENpZcj+XeelypkupNk0CKqIH0DsX6yV9ChJu9tvpGhMKtv2eshvv
         vuaDE7vl2mKFWjHmwHt3JIYA9GVrh+yOSHcWDcFh/JGu+QLsqHUcVSwk+xnMw9YZJr9V
         qyUw==
X-Forwarded-Encrypted: i=1; AJvYcCVbVZhekUcabyoKcEeqSIaib9RqttzCaqJfZpltjRnlTIfU29IR1YuzkrurZsSSp/Jv33yW/iDcnvQ=@vger.kernel.org, AJvYcCViU2O1wrCfA82o9jE01FwLT4Ss2St8nuceuD0ucsh6NyZDn0PjvWcvdIZzFQIWcoUc7wAiXESVZuDjA+79rg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxyT4Qk7SfnX7JRvggKaf8NfdTj6wKK4g/R9bFwZ7x1R2VFSBjM
	jAFbJib7Lt7CZvynB3IuJP4D3puQimp54IF5fqLhCSMcFescOypK
X-Gm-Gg: ASbGncvbme28y3hWByUzMgX2Cs7lAjeSEVJpd2abfjo+0H3pyz3W2s7/PNiWCYPhAv7
	g0D1KL9bB1ZY1coWecMMbUn5ZZx5lKKe43HtgJ8aMSlTtmxe8gaWFfgI4msGfGKIqZrqfsDfz/L
	Dfj7C7sbBxUnFyquzBGgo91zqvRbU4lgv+8UkeBxuK/BG9Wq6A15L7oaGtg9GC3tD3Du7gdzZmI
	lgs1u095cHy3CD8A7+SBBJPrguHBtq1wZeE/Yi+ONtRMetfIKBfHg3x/eb7cmYmUxzOOlUQrP9V
	D1dGMt67w0jyzQNqlUrhWA45w5Bdsy0MQOKvUH4kNPhlUjRJThU=
X-Google-Smtp-Source: AGHT+IFXvQvNF6xGlaCntn82YWM+O67cZSUzPNRpQyiDPwpgs4JUvvnvml+EYrg7Nml54IB99R+kcw==
X-Received: by 2002:a05:6830:909:b0:71d:f97a:7b with SMTP id 46e09a7af769-728a522897amr2171041a34.20.1740582876222;
        Wed, 26 Feb 2025 07:14:36 -0800 (PST)
Received: from Borg-518.local ([2603:8080:1500:3d89:75cd:812f:f5ed:53af])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2c111286232sm885024fac.13.2025.02.26.07.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 07:14:35 -0800 (PST)
Sender: John Groves <grovesaustin@gmail.com>
Date: Wed, 26 Feb 2025 09:14:34 -0600
From: John Groves <John@groves.net>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, 
	Bernd Schubert <bernd.schubert@fastmail.fm>, Stefan Hajnoczi <shajnocz@redhat.com>, 
	Josef Bacik <josef@toxicpanda.com>, Joanne Koong <joannelkoong@gmail.com>, 
	John Groves <jgroves@micron.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	linux-cxl@vger.kernel.org, Aravind Ramesh <arramesh@micron.com>, 
	Ajay Joshi <ajayjoshi@micron.com>, Eishan Mirakhur <emirakhur@micron.com>
Subject: Re: famfs port to fuse - questions
Message-ID: <o4pw7dvbqq34dn7ui22b6vfyno6xmwxc7cisbt4w5z4bhpfqvd@tsijcoyue2ky>
References: <20250224152535.42380-1-john@groves.net>
 <CAOQ4uxjwn+PacrG1kWf7uki+cigDo9cWXNkg5e987r8hfKiDQw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxjwn+PacrG1kWf7uki+cigDo9cWXNkg5e987r8hfKiDQw@mail.gmail.com>

On 25/02/25 05:59AM, Amir Goldstein wrote:
> Sorry for html reply... Writing from mobile
> But wanted you to have the feedback pre RFC patch
> 
> On Mon, Feb 24, 2025, 4:25 PM John Groves <John@groves.net> wrote:
> 
> > Miklos et. al.:
> >
> > Here are some specific questions related to the famfs port into fuse [1][2]
> > that I hope Miklos (and others) can give me feedback on soonish.
> >
> > This work is active and serious, although you haven't heard much from me
> > recently. I'm showing a famfs poster at Usenix FAST '25 this week [3].
> >
> > I'm generally following the approach in [1] - in a famfs file system,
> > LOOKUP is followed by GET_FMAP to retrieve the famfs file/dax metadata.
> > It's tempting to merge the fmap into the LOOKUP reply, but this seems like
> > an optimization to consider once basic function is established.
> >
> > Q: Do you think it makes sense to make the famfs fmap an optional,
> >    variable sized addition to the LOOKUP response?
> >
> 
> Please see two other email threads from last few days about extending
> LOOKUP response for PASSTHROUGH to backing inode and related question on
> io_uring and PASSTHROUGH
> 
> I think the answer to you question, how to best extend LOOKUP response,
> should be bundled with the answer to the questions on those other threads.

Thanks for the quick reply, Amir. I'm traveling this week with a hectic
schedule (Usenix FAST++), so I won't get much actual work done.

I'll stipulate that my list-participation skills need improvement, but
I haven't figured out which threads those are. If somebody can point me
directly to them, you will have my gratitude.

Time frame for my initial RFC is probably still a few weeks out.

> 
> 
> > Whenever an fmap references a dax device that isn't already known to the
> > famfs/fuse kernel code, a GET_DAXDEV message is sent, with the reply
> > providing the info required to open teh daxdev. A file becomes available
> > when the fmap is complete and all referenced daxdevs are "opened".
> >
> > Q: Any heartburn here?
> >
> 
> See also similar discussions on those other email threads about alternative
> and more efficient APIs for mapping backing files.

Same, see above about my questionable list-searching skills

> 
> As Miklos said before mapping file ranges to backing file also makes sense
> for passthrough use cases so if there are similarities with GET_FMAP maybe
> there is room for sharing design goals, but I am not sure if this is the
> case?

I hope so...

> 
> 
> > When GET_FMAP is separate from LOOKUP, READDIRPLUS won't add value unless
> > it
> > receives fmaps as part of the attributes (i.e. lookups) that come back in
> > its response - since a READDIRPLUS that gets 12 files will still need 12
> > GET_FMAP messages/responses to be complete. Merging fmaps as optional,
> > variable-length components of the READDIRPLUS response buffers could
> > eventualy make sense, but a cleaner solution intially would seem to be
> > to disable READDIRPLUS in famfs. But...
> >
> > * The libfuse/kernel ABI appears to allow low-level fuse servers that don't
> >   support READDIRPLUS...
> > * But libfuse doesn't look at conn->want for the READDIRPLUS related
> >   capabilities
> > * I have overridden that, but the kernel still sends the READDIRPLUS
> >   messages. It's possible I'm doing something hinky, and I'll keep looking
> >   for it.
> > * When I just return -ENOSYS to READDIRPLUS, things don't work well. Still
> >   looking into this.
> >
> > Q: Do you know whether the current fuse kernel mod can handle a low-level
> >    fuse server that doesn't support READDIRPLUS? This may be broken.
> >
> 
> Did you try returning zero d_ino from readdirplus? I thinks that's the
> server way of saying I do not know how to reply as readdirplus.

No, but I'll try that when I get back home. I found documentation somewhere
that said ENOSYS was the answer.

> 
> I would have liked it if there was an FOPEN_NOREADDIRPLUS per opendir.
> This could be more efficient than having to get the first readdirplus
> request.

I don't know enough to have an opinion here (yet), but I'll start thinking
it through.

> 
> 
> > Q: If READDIRPLUS isn't actually optional, do you think the same attribute
> >    reply merge (attr + famfs fmap) is viable for READDIRPLUS? I'd very much
> >    like to do this part "later".
> 
> 
> > Q: Are fuse lowlevel file systems like famfs expected to use libfuse and
> > its
> >    message handling (particularly init), or is it preferred that they not
> >    do so? Seems a shame to throw away all that api version checking, but
> >    turning off READDIRPLUS would require changes that might affect other
> >    libfuse clients. Please advise...
> >
> > Note that the intended use cases for famfs generally involve large files
> > rather than *many* files, so giving up READDIRPLUS may not matter very
> > much,
> > at least in the early going.
> >
> 
> If famfs does not need readdirplus you should not have to deal with it.

Technically it's not that readdirplus can't be helpful for famfs - it's just
that readdirplus is not much help if the response doesn't include famfs
fmaps. 

But I do think the nicest bringup path would be to disable readdirplus, 
so what I should see is a bunch of READDIRs followed by (or alternating 
with?) a bunch of LOOKUPs. That route should aid bringup by avoiding 
new variable payloads on existing commands in the immediate term.

But if said payloads are being designed or considered, I should definitely
get the famfs requirements into that discussion, so we can do something that
works for all of us!

> 
> I don't see a problem with adding noreaddirplus config to libfuse, but not
> sure you even need this to be in init. I would prefer it per opendir.
> 
> Thanks,
> Amir.
> 
> 
> > I'm hoping to get an initial RFC patch set out in a few weeks, but these
> > questions address [some of] the open issues that need to be [at least
> > initially] resolved first.
> >
> >
> > Regards,
> > John
> >
> > [1]
> > https://lore.kernel.org/linux-fsdevel/20241029011308.24890-1-john@groves.net/
> > [2] https://lwn.net/Articles/983105/
> > [3] https://www.usenix.org/conference/fast25/poster-session
> >

Thanks,
John


