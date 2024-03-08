Return-Path: <linux-fsdevel+bounces-14004-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F32F8766BB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Mar 2024 15:54:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0FF61C21B36
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Mar 2024 14:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E521DDF5;
	Fri,  8 Mar 2024 14:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="iAhReafx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DCF1DDD5
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Mar 2024 14:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709909665; cv=none; b=tvm2C4KQgVmdLVP1c4+SVq6QQ5x9jx24N2GHJPVsXdiClJLwUwLCFTtPmgy4qoBdzxdsAUgnEF9AD0iE1AlIMtzUHhpfgi+3treEKXXifGbguIesHYghL17y+KC/3Buxd+qxjSk5lJJ+toJqhfw8iuopDrokTpY8R4RXz5/OEps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709909665; c=relaxed/simple;
	bh=1VIQT9LF8OLP3d0UxMGr59pNDPhBvCL5RmAVDJ785Sc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tBBlzChVsPSGJ9iZabWMUIvnsxXHl3BLxAPJpqD7/B7x+6F3cZG2u7pMad4dCwK1pGlVHrrXAT8np5tGlA4KkcKcqFdAzi6HJp1dMwdRpBGo7iVv21lGH8R82AoAp5jwm0bCtWvtisj4CPTNCMM8c5Uay8TWb22kve2a/YXfzUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=iAhReafx; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a44665605f3so326369566b.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Mar 2024 06:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1709909661; x=1710514461; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TbdDAr5at4l2JsXjgpwR5xR6wyAgJkOJd3kAOVofZs4=;
        b=iAhReafx+NDn5vqVsc6sCMXNcWF8+0Titaab6aa4lzYQME/tyKdSZFJskrjimgIBXG
         fKab/AqWwDNXY5X3VzHeZYLH+tm6NIA3SXBxQF1lgtwUWlApW+Ab563A+Svxtpb4M1qT
         dVOUCxLpcOk2TqzgVrUlancORtPNB95kHGnl4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709909661; x=1710514461;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TbdDAr5at4l2JsXjgpwR5xR6wyAgJkOJd3kAOVofZs4=;
        b=cugnlrRQ3KLt2ZxXrctmVzuwjnekzSV9QZIabmVLr7uNAQpgTE8DAz+V8cOwzvxxfT
         mIviQjnP2MPlqQlnaDt5b7+ejan50htZF5zhtw//Y2IPeDeReeZjTGypmb7Bzl1nFNIC
         yjKRuGsLX8GLbNhWBgGWWSqLcel/ipvLqP0XuoYDhoAr1A1vBa/4LIj9gLdULGpEAhsI
         DkOLkzml2nH4KBGLMyEDMdeB8FFSvbMN6WjNBOl2ZnVlHlk4dlCWAOX10inWV528uVht
         UOGaWFqmRw5fG+1aeklpo8D+SFptaxMgf1y+6hlgj8thWdIZwy7F5ms8GBLUziQ6MZOl
         APRQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+iqCKpuu7I10H+/c793i1iYOeGb0E7dZVOoK7UbnDLreGOWu2WTQ/ieFwaXGWjWiiG7EM4GNOU6kFeDJdiXCxYW/6VenZZdy4h+tMNA==
X-Gm-Message-State: AOJu0YxOSC9+iw/6ESQuJDF/OJ0PA1DHuER6dRPOaRaDWQtZUy7rlfEM
	XEZ/Ihh7jlrKP/uJ0Dzg209XBjSZFUhDgIdedJGesrJPSogkqjSjvuMr7Fej/9NPxKFDsTKXub/
	cscSWk5OPo+yBunQc4zPc/eh0yX29EH83QGA31w==
X-Google-Smtp-Source: AGHT+IEHzbUOcQ3Y0gAYhFdEs5jPjeXHaOjnewb+mr+Bqf7mY+SlCDhb7DeNO7YL6FNTb/BclMLuG94ZUTKI6NsvkZY=
X-Received: by 2002:a17:906:6ac7:b0:a44:9aea:779f with SMTP id
 q7-20020a1709066ac700b00a449aea779fmr13833106ejs.44.1709909661342; Fri, 08
 Mar 2024 06:54:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cfdebcc3-b9de-4680-a764-6bdf37c0accb@redhat.com>
 <49d1f108-46e3-443f-85a3-6dd730c5d076@redhat.com> <20240306-beehrt-abweichen-a9124be7665a@brauner>
 <CAJfpeguCKgMPBbD_ESD+Voxq5ChS9nGQFdYrA4+YWBz17yFADA@mail.gmail.com>
 <20240306-alimente-tierwelt-01d46f2b9de7@brauner> <49751ee4-d2ce-4db9-af85-f9acf65a4b85@sandeen.net>
 <20240307-winkelmesser-funkkontakt-845889326073@brauner>
In-Reply-To: <20240307-winkelmesser-funkkontakt-845889326073@brauner>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 8 Mar 2024 15:54:09 +0100
Message-ID: <CAJfpegvW1-rn6dSoQ4j4qqQS9fSnNCRZNE6D_xw-iNokpHt+cQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] vfs: Convert debugfs to use the new mount API
To: Christian Brauner <brauner@kernel.org>
Cc: Eric Sandeen <sandeen@sandeen.net>, Eric Sandeen <sandeen@redhat.com>, 
	linux-fsdevel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	"Bill O'Donnell" <billodo@redhat.com>, David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 7 Mar 2024 at 13:04, Christian Brauner <brauner@kernel.org> wrote:

> But I'm not yet clear whether FSOPEN/FSPICK_IGNORE_UNKNOWN wouldn't make
> more sense than FSOPEN/FSPICK_REJECT_UNKNOWN. IOW, invert the logic.

I think there needs to be a mode for fsopen/fspick/fconfig API that
allows implementing full backward compatibility with the old behavior
of mount(8), both in case of new mount and remount.  By old I mean
before any of the API conversions started.  If some filesystems
rejected unknown options and some ignored them, then that is what this
mode should continue to do.  This is what we currently have, so
without additional flags this is what the API should continue to
support.

And I think there needs to be a new "strict" mode for fsopen/fspick
that has clear rules for how filesystems should handle options, which
as you say most filesystem already do.   Since this is a new mode, I
think it needs a new flag, that is rejected if the API or the fs
doesn't support this mode.  Filesystems which already have sane
behavior need not care, they would work the same in both modes.
Filesystems that are currently inconsistent would have to implement
both modes.

Thanks,
Miklos

