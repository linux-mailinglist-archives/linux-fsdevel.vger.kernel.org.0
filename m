Return-Path: <linux-fsdevel+bounces-43161-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18BBCA4ECC6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 20:07:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3581C169DC3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 19:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76FA5255244;
	Tue,  4 Mar 2025 19:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cEzlNw1l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49145158524;
	Tue,  4 Mar 2025 19:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741115200; cv=none; b=IFKIFHLKu0xu6u0wrDStP1Db62/6wZqxcegACLtkzM5s6dx4o4BCywe6iD3JxmgTfHsoMtNIwTFAtGqX+SFockfOxqjWmjOKjPaI33X6iEDJT7K4YU//A9GXo98YQy4DKPBmpRDQ13FhxP3fkcz9HGr1qkz0kdPhBL6VWZj88kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741115200; c=relaxed/simple;
	bh=qgBjp+ydpJlBw52x0uUkgJn409XwUZVGlumTnsWJ3m0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CvvJj59b0UmDtx7W0zoAYMahjxJ4CGoCJPPCvudXmJmvRyo0678gh8v48Pm3HMg9pwk5pEx1Vj921vyq3YnAXCVGsbQp+Yt2sGpx3P0UhxyAX89e5v7M5ZMoPd7fQZuzeAoa6W7yiC6hfoEKcsQSRQd8b5RZHjQxJkIGRKS5omo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cEzlNw1l; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-471f686642cso54965921cf.2;
        Tue, 04 Mar 2025 11:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741115198; x=1741719998; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tA27Lf3iJciKnB0JvEl1MO3LlYSglnQEOYlC6Hgx3eQ=;
        b=cEzlNw1lynEIgIZFQISmLeHtfKUbOmIuju6y6l3dss/GqCAgbIO77rfOVjoL7hfpfY
         f8nziJ66ODFCa8tl0eEYdoovU/IXeU3Yqf8b3o4zwsHVW8fjOFVguTU1NJAN2fRSg7mf
         Z1Fqw0vTADT3xlSPomFUllleXbhRL6cjqZh1unnNQGPCjKSn4eKYBIQMagBSg15tAXn3
         +N0JHa6nDPDsX44C1gVwiITo+3BbEsq/24X7R0zm2ZePkRKUyt8CNynmXz0HZxI7H1dC
         mKI7J6Dpu5hCUv12ND2ZygLONFJgHP8cQdII6nAELf6RLYdbQVpmSW6yrgR76khXVg/N
         q1Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741115198; x=1741719998;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tA27Lf3iJciKnB0JvEl1MO3LlYSglnQEOYlC6Hgx3eQ=;
        b=fcynWkVpr0APv5mxOymmoyYit6uzMkvbJ4SNrHDBAFgkW0U8EZLKujdET+ENm6IYS7
         Z5da7Nq9Zy+sbNZFHjyajM0xQbiiX075IN+c0t+EFqp0M7ml6Iz02PV4o634DvCYtJ07
         u5VQGyhzKT+EXs1qYU2+8oocOa1GR3qjCBACI7uS7p65PCXvT61Lv8oNe3sJ6eclisM/
         9kp13MKqepvar2YuwDHqm/44gBsNIbZl2zfj8PdWra2LMAWdDZZTGn3xuIzUnS1Apx3G
         OTN19P0utH398beMkQIdlRZqtxSowzgfOJDgsiDibkyPXhB8/qU9mzazJF8j5rO+Fd8Q
         1bZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMy8vxVusF2SJPwDg4W/CzS7zKAM21z78/+ThW3D+8gBskwumSCcthWlVsJJBkdeKYMHxQ643FDx6ANmK+@vger.kernel.org, AJvYcCWVcVGcgtL1H0o6rsq3UkBtYBJL1r+vS9k6VJ5N2UNkGvCxoNlRONXom3RW5JSZq2/gSzrckXWjY8ev2IPJ@vger.kernel.org
X-Gm-Message-State: AOJu0YzTsyh65K6EJjIZ9q/0Y/eC3Z1I4hbVCXvhnYn9/oBX+PzA1DYQ
	JHrkH9G5vmRpWOzVNFYWR51MfLWWPwbHlCsbYAppTMUxp/Uad73F
X-Gm-Gg: ASbGncvwuQrD1KXc7qXxJArTEps7wL2TCUWJx/3OsT0kx/9/JzVU7m2j9OhT0kOGMoF
	oS+ZAImPKkzjtlSc9F2K9AOPDWw57sFy1QoVu/SLiuAaDefVNgxRbRy2smiPthWRdHbgK/vgmVZ
	5OGiNiVYzAUJtUkGSu+3/TFhKIvK9k7TNAUfpvGHFAjSI81DxkZFqcQGl1+Kt16k7vA52qquF5S
	7hxIzoXqZQDS4ZoTUbQzcukY0PHPGarRyXa9IyhnP6h7QggotaV+ziP1SdN90rLtKPH0HbKogIS
	1f55ZAd7azFiira1LkxThxLUk2x+O9pxaz1Sv88VzztLic6FnCx7slgtqGPVMvzYa5/2wOtMiyn
	8
X-Google-Smtp-Source: AGHT+IEHMACm3UtM3g8IwgX8ccOiICa/jh1pmKFAIbjW7DNmAGnXI/0lrR7EO3ZtAv/HzcyoRr3unw==
X-Received: by 2002:a05:622a:198f:b0:472:13f8:a974 with SMTP id d75a77b69052e-4750b4c51d2mr2585531cf.41.1741115198077;
        Tue, 04 Mar 2025 11:06:38 -0800 (PST)
Received: from localhost (pat-199-212-65-16.resnet.yorku.ca. [199.212.65.16])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4746b5eed4fsm76428501cf.31.2025.03.04.11.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 11:06:37 -0800 (PST)
Date: Tue, 4 Mar 2025 14:07:39 -0500
From: Seyediman Seyedarab <imandevel@gmail.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH] inotify: disallow watches on unsupported filesystems
Message-ID: <hg55e37tvfjnb76lvffuhnvozdwm4k6xuqq6nmvjgjaryjqmee@ppujm6t5y7ju>
References: <20250304080044.7623-1-ImanDevel@gmail.com>
 <CAOQ4uxiaY9cZFpj4m65SrAVXm7MqB2OFSfyH5D03hEwmdtiBVQ@mail.gmail.com>
 <5tq33ajgtu62tvaiymf3st74ctkurgskq6xpx2ax53vdbayoce@jffpxkthro3u>
 <CAOQ4uxiZfJYHrYmE2k0vWrgbLLbDQ2LTrVggYwL3pv4FUyjctQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxiZfJYHrYmE2k0vWrgbLLbDQ2LTrVggYwL3pv4FUyjctQ@mail.gmail.com>

On 25/03/04 05:41PM, Amir Goldstein wrote:
> On Tue, Mar 4, 2025 at 5:05 PM Seyediman Seyedarab <imandevel@gmail.com> wrote:
> >
> > On 25/03/04 12:57PM, Amir Goldstein wrote:
> > > On Tue, Mar 4, 2025 at 8:59 AM Seyediman Seyedarab <imandevel@gmail.com> wrote:

> > I understand why it might seem like disallowing users from monitoring
> > these filesystems could break userspace in some way. BUT, programs
> > work incorrectly precisely because they do not receive any information
> > from the kernel, so in other words they are already broken. There is no
> > way for them to know if the fs is supported or not. I mean, even we are
> > not sure at the moment, then how would they know.
> 
> Programs not knowing is a problem that could be fixed with a new API
> or new init flag to fanotify/inotify.
> 
> Existing programs that would break due to this change is unacceptable.
> 

Maybe something like IN_DISALLOW_REMOTE could work for now, at least
until remote change notifications are properly implemented for those
specific filesystems? Later, if needed, it could evolve into a new API,
and the flag could become the default behavior when passed to that API.

> > As an example, 'Waybar' is a userspace program affected by this patch.
> > Since it relies on monitoring sysfs, it isn't working properly anyway.
> > This is also due to the issue mentioned earlier... inotify_add_watch()
> > returns without an error, so the developers haven't realized that
> > inotify isn't actually supported on sysfs. There are over five
> > discussions regarding this issue that you can find them here:
> > https://github.com/Alexays/Waybar/pull/3474
> >
> 
> You need to distinguish "inotify does not work"
> from "inotify does not notify on 'remote' changes"
> that is changes that happen on the network fs server or inside the
> kernel (in sysfs case) vs. changes that happen via vfs syscalls
> on the mounted fs, be it p9, cifs, sysfs.
> 
> There are several discussions about supporting "remote change"
> notifications for network filesystems - this is a more complex problem.
> 
> In any case, I believe performing operations on the mounted fs
> generated inotify events for all the fs that you listed and without
> a claim that nobody is using this facility we cannot regress this
> behavior without an opt-in from the application.

Understood. So this is what I should work on (correct me if anything
seems off):
1. Carefully list all filesystems where "remote" changes occur.
2. Introduce a flag like FS_DISALLOW_INOTIFY_REMOTE in fs_flags
   for these filesystems.
3. Provide an option for userspace, such as IN_DISALLOW_REMOTE,
   so applications can explicitly handle this behavior.
4. (Possibly later, if it makes sense) Introduce a new syscall where
   FS_DISALLOW_INOTIFY_REMOTE is the default behavior.

Regards,
Seyediman

