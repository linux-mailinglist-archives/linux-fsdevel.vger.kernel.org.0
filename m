Return-Path: <linux-fsdevel+bounces-45672-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE77A7A911
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 20:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D6017A6611
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 18:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B4B2528FC;
	Thu,  3 Apr 2025 18:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="C7WEIsNz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE13D171E49
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Apr 2025 18:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743703804; cv=none; b=iBmDAZuFKpmoE/sT7HL1iSGFEki/BA0MH8TAUAaAgpND65ra8Z20Zg4yGUVXw37D3dE3SYq2+tXDLB9+Uen+CkgneGsVlanoqZdYMRGk8LzEgvn9GR3eXNFlJ7SKZfaBZmwFWHErszF2opva5ZDQr6+LHK2J1y9uTKMSkDCIchY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743703804; c=relaxed/simple;
	bh=tRaMCDQsFxTh97DR7LSJJp2UP+PKxOH/yGDNF3oor4Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WnlOM24NLOZV6CuVBP8kx7ouJ2AG4EePDPL4azvt0jCUPWa9NPmY+fMKg1jb9ytCl678F5mAm/jSTBSgHgDRd802f4MG34C7y/Be2+DfkOfFv+FRcJV4zLD/9BAeGFVqVryMGBFTcn3lpvh04puf1hlyvYoesyM/Ay3/wTImokg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=C7WEIsNz; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ab78e6edb99so174902566b.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Apr 2025 11:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1743703800; x=1744308600; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HcEDrrFsrxiP1Wl9E660bs5VgrcHtAAgyYumdG4aXRY=;
        b=C7WEIsNztGwdeyW70eWkzmRnk9zqvnh+JCVBxlCAJNwCr9zgXBU37z79jepUoyDdqp
         tRrXMgf8LlZkabMEFIrbud8PBGlBxRF7ULkN9riQO4I5b3InmGajvV0TTogsNSWXafpe
         Zke32bhEuUW3ZhZLoC9AMYrFBsBnnODxifPEg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743703800; x=1744308600;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HcEDrrFsrxiP1Wl9E660bs5VgrcHtAAgyYumdG4aXRY=;
        b=AbtbFTDa7natCZSdQbc84Ftpf/Fgr2WbUW+ep0wwIb3uATUJIafpfgoxz169m3rWqC
         FWIwZhjVvGEhAlKF9J/OiAQGhFVjqf/P6MJtflpFDOAn11nTkTtmSLIxfwPhFwxbRlL9
         YnFqTHqAXBHq9NQ//AsmXvnn+kAGWBOnLHOzGPHW8AXGxJPP+wrPkwqs32PjXQ664Rdj
         kDL3pU5B0XP4WBPnhkPsbtKHu2U3zKFCriacPbW2HTQKqCIuHwhYteL5soPn5q0yrIwO
         mC+QZecNELwLcaCNrYm5aCbUoZRqYmoLYB/E9SnB9NqjbDgEEBS0OL8eEZ5tcCW/9wpW
         drpg==
X-Forwarded-Encrypted: i=1; AJvYcCWc0mBb/YhWgZNekxxq126pacb9LE+eunPbmeISxUWOBaQx2OIy1hhrKvynIy9EBh62Mu5DY5A5dkn9NHIV@vger.kernel.org
X-Gm-Message-State: AOJu0YweNhobIHI4WuuiJlUI1nzkyPQLHrnosqQ0PHupqBcyHSa8Ktxs
	9TSTGAhVktMl+ANUZWCLgWgUK/qnDUBzhUnRXIrXf5DnHDfg8LnwMsKZSOUKv5M9CHeJt3idsz5
	I+tw=
X-Gm-Gg: ASbGncvti/FJNZvDHfxdJjaU13bIwV3IMZoMNzz5p8OgRA39daTlwXEC0oeaCqlHJX8
	vuIShGW7CxphGJ8gCcJItQmJZolq2C5e56JLF+ATTu/sEu6EW2KIPR7hyvCqklsXYuIbcmkMgsG
	XXiGv2ncVGIMZSOrbh4qzC0tEqJ8sycXWPzP0Y7X5oBe7vsA1DhZ+bP00Xt5Gx8SO9GS/sG36S0
	3XRc00E+UhwdOLdCELP7qmih8lSddr4tlrzTLV0I31CJGj8dLd7fOSQYAXggfisuemqmLJBeEvC
	R4+AxLqETT3U1ZsVenIVPMhBtxDzE2drD5RqHB4+qkib6o4TsyZTwV4jXLw9oBZg+xN/H7vstCv
	PsYBoYvtWSn8KgEcyFGpnToflnvJSAw==
X-Google-Smtp-Source: AGHT+IH+JDHdo4G79S6LKjHz4otXBTNoywL7ctQpz0WE7hVbR+4V255ui5/4M9FPhAfKbaLrmnEmtQ==
X-Received: by 2002:a17:906:7955:b0:ac6:ba92:79c9 with SMTP id a640c23a62f3a-ac7d188ab85mr61541166b.18.1743703799837;
        Thu, 03 Apr 2025 11:09:59 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac7c01bb793sm127363666b.161.2025.04.03.11.09.59
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Apr 2025 11:09:59 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ac25520a289so203813766b.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Apr 2025 11:09:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX6Mgkt9utwlJcUzK9iSQchgR6XzcloM9gvF6dt+Kmo/DAe5PCoxr8FQVLCDl9AHhTJF8KXNPXEzuwbfDIu@vger.kernel.org
X-Received: by 2002:a17:907:971c:b0:ac3:84d5:a911 with SMTP id
 a640c23a62f3a-ac7d18e240emr44635266b.28.1743703798814; Thu, 03 Apr 2025
 11:09:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250322-vfs-mount-b08c842965f4@brauner> <174285005920.4171303.15547772549481189907.pr-tracker-bot@kernel.org>
 <20250401170715.GA112019@unreal> <20250403-bankintern-unsympathisch-03272ab45229@brauner>
 <20250403-quartal-kaltstart-eb56df61e784@brauner> <196c53c26e8f3862567d72ed610da6323e3dba83.camel@HansenPartnership.com>
 <6pfbsqikuizxezhevr2ltp6lk6vqbbmgomwbgqfz256osjwky5@irmbenbudp2s>
In-Reply-To: <6pfbsqikuizxezhevr2ltp6lk6vqbbmgomwbgqfz256osjwky5@irmbenbudp2s>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 3 Apr 2025 11:09:41 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjksLMWq8At_atu6uqHEY9MnPRu2EuRpQtAC8ANGg82zw@mail.gmail.com>
X-Gm-Features: AQ5f1JqNbQoAaPP_wXcc41hTXOvOxh-9Wv4SKJz_lr5r38JumKJCxYASdK1ME88
Message-ID: <CAHk-=wjksLMWq8At_atu6uqHEY9MnPRu2EuRpQtAC8ANGg82zw@mail.gmail.com>
Subject: Re: [GIT PULL] vfs mount
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Christian Brauner <brauner@kernel.org>, Leon Romanovsky <leon@kernel.org>, pr-tracker-bot@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 3 Apr 2025 at 10:21, Mateusz Guzik <mjguzik@gmail.com> wrote:
>
> I would argue it would be best if a language wizard came up with a way
> to *demand* explicit use of { } and fail compilation if not present.

I tried to think of some sane model for it, but there isn't any good syntax.

The only way to enforce it would be to also have a "end" marker, ie do
something like

        scoped_guard(x) {
                ...
        } end_scoped_guard;

and that you could more-or-less enforce by having

    #define scoped_guard(..) ... real guard stuff .. \
                do {

    #define end_scope } while (0)

where in addition we could add some dummy variable declaration inside
scoped_guard(), and have a dummy use of that variable in the
end_scope, just to further make sure the two pair up.

It does have the advantage of allowing more flexibility with fewer
tricks when you can define your scope in the macros. Right now
"scoped_guard()" plays some rather ugly games internally, just in
order to avoid this pattern.

And that pattern isn't actually new. We *used* to have this pattern in

        do_each_thread(g, t) {
                ...
        } while_each_thread(g, t);

and honestly, people seemed to hate it.

(Also, sparse has that pattern as

        FOR_EACH_PTR(filelist, file) {
                ...
        } END_FOR_EACH_PTR(file);

and it actually works quite well and once you get used to it it's
nice, but I do think people tend to find it really really odd)

> This would also provide a nice side effect of explicitly delineating
> what's protected.

Sadly, I think we have too many uses for this to be worth it any more.
And I do suspect people would hate the odd "both beginning and end"
thing even if it adds some safety.

I dunno. I personally don't mind the "delineate both the beginning and
the end", but we don't have a great history of it.

               Linus

