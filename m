Return-Path: <linux-fsdevel+bounces-48734-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C922AB3484
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 12:06:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2C3617CDE7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 May 2025 10:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A16925E474;
	Mon, 12 May 2025 10:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="aeUuY6JI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15646255F5A
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 May 2025 10:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747044392; cv=none; b=pExVjdsR8fh4wdj+Yy5aLfb6OXg6hh4ZwamyGoOPi/EY9ngOUB+08uz5lsY/Ij7Mqrxq6fZVtEjWCc9lXPbeY88OfRJNpc+da8oFspM3tzivQZ5Bsd/z2dK4c6nJHu6Hg+jRNMJ6N3WLLekHU3w9RcAK5kEE3CyQr4HPmEl3zEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747044392; c=relaxed/simple;
	bh=jXo2APXH+xZdQQ1LPdxw6AqlF+M7NqB6TWjVGZL1Pwk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J7DALRnFRAXUd/4t5z1gX4EXLHO0rozi/KG5ljfl6sAv5H04van+XNTZu8ExFp4XnQ66PrWMrUBwg7/tD68UBpa5zvRPm1VdSdR7YLtUTPQAdBqcTSHZy6TkR8+W7eh7XFc+O0xeZ+mUm+rWgOiKbN4c/oubibCY4uWtRSjLPTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=aeUuY6JI; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4774ce422easo47509501cf.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 May 2025 03:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1747044390; x=1747649190; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ao78gq3UEXd8+O1os8ysUZZc/hcTKpCJXFEJKk5K5HY=;
        b=aeUuY6JIupNfBF+0zRN/r6ngAws7GZusdCsZvYozypCq5WBMl/WgVuhCjIQkA4vqqS
         WxGB0ViNLMaGIdOktggHJ8P8H4Am8gNnvBq4OZ+VLg1TRT34pdfkVRDjFAOH1IQPVJ1F
         in8dnmmbHxdmj/XEqQzpaehluL4lHC8ajmX7A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747044390; x=1747649190;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ao78gq3UEXd8+O1os8ysUZZc/hcTKpCJXFEJKk5K5HY=;
        b=QGhuq0S+I+1PF/TskQQ8anRq5dqsejLUr7Nu2WmBHPQ2dmYrOuxcPDTZpIo1U7REJN
         cgh83DHo3pm0i2iUeU7q7XnPRIeop3RCgagQtuhtxV0vunLRjIsnDidKGG1frhjITijY
         kV1wvSfYY2LlJNlL5qB/2ce4HwDx4/R1pS0gwonCv9igJAg94qEGcYV6Ro9eT4rLsEkf
         2Tpet95wjKHnaJWKPTc5AWxWrGlNnu+QRgC/URyy9Tk0r5fO8njhmR5NkDi7/AitwKil
         3rsfWyFrc+j+40BaoWzuhtD7Z1qC2TjnyLnQSX+/jRIrI2BGylW3GIoean/E3f7GVkXR
         VGUg==
X-Forwarded-Encrypted: i=1; AJvYcCWNkOJJWJkEX2bOPmY1+r7SEI35g3b70jFOGUijJOu/vBN/3rWPcaiozphZssoJo4byHqoqjrBdZFGiUa4u@vger.kernel.org
X-Gm-Message-State: AOJu0YyaAi7P68THrqK7tmWGTAhVTc8K7ocQ3zodtDzKFiFhgU+W6o79
	2uqH7YHb/ppEvMZ/LIOazY+9bx1mTVfQ9SX4VFayMdAM9Bb+JjI1KP7LF0k0Cb2AxZJO99ToicC
	Q8TAa8oh8keNfl925p5ctvVjKGQIIJhFrGA8vrQ==
X-Gm-Gg: ASbGnctv5EzYE/ro2itZ6lF22ejX0HtFLmVtiHgQhcKYOz4y9X12oZVUBZd4n4LVBRN
	D1utv/w20bQCXmN4V6FyFcOjLcObGRCTWtueLAUVwwTrQuSpEQw9zaD2EV61rJ7iYYDBPrOK3tA
	9fGxYoVn6IVaunXkpX6SsL6Fy7L0RV1gkL5Ms=
X-Google-Smtp-Source: AGHT+IEL+WJpAtsUDvmDFSJLle5njdmLjkHtqOT7RZHsP38BRVAq3aJtECH83tD3wgaufsVEQl9+03hZAMPCwLXkm0s=
X-Received: by 2002:ac8:5e07:0:b0:476:8eb5:1669 with SMTP id
 d75a77b69052e-494527d49bfmr199930401cf.32.1747044389876; Mon, 12 May 2025
 03:06:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250509-fusectl-backing-files-v3-0-393761f9b683@uniontech.com>
 <20250509-fusectl-backing-files-v3-2-393761f9b683@uniontech.com>
 <CAJfpegvhZ8Pts5EJDU0efcdHRZk39mcHxmVCNGvKXTZBG63k6g@mail.gmail.com>
 <CAC1kPDPeQbvnZnsqeYc5igT3cX=CjLGFCda1VJE2DYPaTULMFg@mail.gmail.com>
 <CAJfpegsTfUQ53hmnm7192-4ywLmXDLLwjV01tjCK7PVEqtE=yw@mail.gmail.com>
 <CAC1kPDPWag5oaZH62YbF8c=g7dK2_AbFfYMK7EzgcegDHL829Q@mail.gmail.com>
 <CAJfpegu59imrvXSbkPYOSkn0k_FrE6nAK1JYWO2Gg==Ozk9KSg@mail.gmail.com> <CAOQ4uxgM+oJxp0Od=i=Twj9EN2v2+rFByEKabZybic=6gA0QgA@mail.gmail.com>
In-Reply-To: <CAOQ4uxgM+oJxp0Od=i=Twj9EN2v2+rFByEKabZybic=6gA0QgA@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 12 May 2025 12:06:19 +0200
X-Gm-Features: AX0GCFvJ3rdELA9Zd75iROohvom6E7GFIBvRnwkO--uzCE2DW0agj0_PJPIYQow
Message-ID: <CAJfpegs-SbCUA-nGnnoHr=UUwzzNKuZ9fOB86+jgxM6RH4twAA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] fs: fuse: add backing_files control file
To: Amir Goldstein <amir73il@gmail.com>
Cc: Chen Linxuan <chenlinxuan@uniontech.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 12 May 2025 at 11:23, Amir Goldstein <amir73il@gmail.com> wrote:

> The way I see it is, generic vs. specialized have pros and cons
> There is no clear winner.
> Therefore, investing time on the getxattr() direction without consensus
> with vfs maintainer is not wise IMO.

AFAIU Christian is hung up about getting a properly sized buffer for the result.

But if the data is inherently variable sized, adding specialized
interface is not going to magically solve that.

Instead we can concentrate on solving the buffer sizing problem
generally, so that all may benefit.

> The problem I see with this scheme is that it is not generic enough.
> If lsof is to support displaying fuse backing files, then it needs to
> know specifically about those magic xattrs.

Yeah, I didn't think that through.  Need some *standard* names.

> Because lsof only displays information about open files, I think
> it would be better to come up with a standard tag in fdinfo for lsof
> to recognize, for example:
>
> hidden_file: /path/to/hidden/file
> hidden_files_list: /path/to/connections/N/backing_files

Ugh.

> Making an interface more hierarchic than hidden_files_list:
> is useless because lsof traverses all fds anyway to filter by
> name pattern and I am very sceptical of anyone trying to
> push for an API get_open_fds_by_name_pattern()...

The problem is that hidden files are hidden, lsof can't traverse them
normally.  It would be good to unhide them in some ways, and for me
that would at least mean that you can

 1) query the path (proc/PID/fd/N link)
 2) query fdinfo
 3) query hidden files

And by recursivity I mean that third point.

Thanks,
Miklos

