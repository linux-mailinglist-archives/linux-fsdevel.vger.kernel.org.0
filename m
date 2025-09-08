Return-Path: <linux-fsdevel+bounces-60467-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC93B481B8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 02:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4329F1899A1E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 00:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD36E4964E;
	Mon,  8 Sep 2025 00:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Dy1kPsop"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FFDE139D
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Sep 2025 00:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757292473; cv=none; b=cX7sz7KVRG1SeDDTAflgs1LHCvE4p+whgr+w8ng2ohVddYyBYgKHWXiqzquM5bVnrYFkQEAwLub6sz8ZZz5r/4NayUWFVRv8L3bkMNgMHe+bPzzjVuzLHj418baY3B5B946IIeAYwKAzfpIDK0pmOB/Y1nMOO19p3mIaDUV+Op4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757292473; c=relaxed/simple;
	bh=tLXFV9kXnzFwx6XuYzaGyqB6VZZ/ykP7fkXTWO5k6bU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MHidEFut9z8I6vwdW7dOL/d4/4CPPe7Y+Q3Xu5oTpZi+hEEvF3AnIcCQseChClY+MsTSCxy8h/zuRXJRs/XI+dBGnqCn+hXxQl95vgAiwbhXss2nF5jO5hYOZH8PiYYO/rsj76YYcHiEKmkzjpuxnhT+6qO4k2xZuZOyKFoFb5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Dy1kPsop; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b043da5a55fso514042566b.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 07 Sep 2025 17:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1757292469; x=1757897269; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2jgl5hrjA+jEnaO8fGPBTaFevzGqES6VJn6ZFcpOPEA=;
        b=Dy1kPsoplGEWvfJCMVojz5erXk4yyOyd10hSzFbk/eYtUEa1diQYdxBgCimSW4xyie
         fG460hMRfMs/UvTvl6RMWS7EsLEhF++wAqYQb/GpUgHBUtzduK+rKh8CEnv/Iqnq1Zl8
         It6yNorR25xAaGLTgEueq57oCkqA+/wNtRAxI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757292469; x=1757897269;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2jgl5hrjA+jEnaO8fGPBTaFevzGqES6VJn6ZFcpOPEA=;
        b=j8keV0XpzNQ4IRGUXDPscyJTeyPUE0tFpQl7tgMaPCpRXr2C7sL0bgPgOIl1U3W83G
         0yi+1rkMydq5qU1BvQYnc6OgYr5sGHcM78F2TgBg466V6ixoC1H613tuGkB1voLbwjFd
         0Wn1jdtXvRfNaOLaFQGkm36kHHDu6/2niT0JA1Bql+9NxaikWxCwN4n5+YP5+mfxTqqn
         BPRMqhtSqtx7rAarnCefcNavExEFbUT9/nvtfPvqKaszl6iEIzgu4ns0/U5ptBt5NHFo
         WfTAK0FLEqh0DZKco3QmxcDfUbgTshEN+AAZUurDbGGXLjcPYZUpCHWzQQqc7jz8bKCD
         724Q==
X-Forwarded-Encrypted: i=1; AJvYcCW5MO+P6JwPICqotmQ21LNA4C5r1+CtXcc+6MrLRQwnoYF6E+Iky4AoCeSx4Ts0z3aDXusimQLH6N2t67p4@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8ZLlLSFgXMrO8vRGhXkGvgwVoxPPgLVtjdW6tZ2rKl7gk1CKr
	I9WM8XPMYU3dqrYS6MLtExVOpgSoXd3+V8mnRmA7CaMVx/Zl6XNuICe6MTmShe3r/AlN7aTRdkQ
	HkbY4gys=
X-Gm-Gg: ASbGncunyYqG1YBa2BZAdb/7DlZ2v/BjSVSvLOD2QvsVtYAXdO9NxJWUfp8k8+AgF+z
	lzi6afXDhR+aSYpooPBiAAH4T9jQEnjKWxfQyM2uSvDugZgahSxTPzdxDpwLCGnypwUI4u8oGoO
	+RmfHAhb1f8e90WNi77O4zG2IItmrpGxRQhgthjX2/mgfJtksmrCKYbFto+4t1Hym/nU8dW/6RW
	yxv4ne2sfO6e0VHVXDPKjVwE4nmAxyjyt8UJRqMXWrVdpEc/ahMUbfwXBOBJb/eaSlXm/M8oGjj
	8Go+C5gJwLJfcGMhzsi7LlaLJo+oVIgSii83Z0U25SBzkU6aRc5TVYEPDLPw+3y/LZt11WZOqf2
	MYp7gHg/8yoOWe/3hpXTNPcbG5rGrgPm/UEBswnQ0+ruI6+zPGn/KTGCP0Fx4w2ja/rl0fVUY46
	VVNek9jaU=
X-Google-Smtp-Source: AGHT+IHxDvVfP0e8xo6vGio7w3pDQu/KvAZlUfs0Xl2VUNKa2u3pKXzdWThiWJBJSwQrXygF+1i5LQ==
X-Received: by 2002:a17:906:4783:b0:afc:b38f:5d72 with SMTP id a640c23a62f3a-b04b1687e36mr689136666b.38.1757292469208;
        Sun, 07 Sep 2025 17:47:49 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b0423ed35e4sm1826044266b.25.2025.09.07.17.47.48
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Sep 2025 17:47:48 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b043da5a55fso514040366b.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 07 Sep 2025 17:47:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW3UPpBNihAJCHfaoKzNJMMxiF+APe+PuBIHY82Y0NrIcRkSDXaCHIzeayJLkWO2fpZa3NjRODh9QsoL89w@vger.kernel.org
X-Received: by 2002:a17:907:2da9:b0:b04:3eac:c213 with SMTP id
 a640c23a62f3a-b04b100e2eemr550817766b.0.1757292468048; Sun, 07 Sep 2025
 17:47:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250907203255.GE31600@ZenIV> <CAHk-=wif3NXNMmTERKnmDjDBSbY3qdFgd5ScWTwZaZg0NFACUw@mail.gmail.com>
 <20250908000617.GF31600@ZenIV>
In-Reply-To: <20250908000617.GF31600@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 7 Sep 2025 17:47:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiDHb4Q4tJwOJqDYJd=L_0kJeYrYq3x0W9fEpDcUoCQHA@mail.gmail.com>
X-Gm-Features: Ac12FXxZp3WqIuHdLEohICOg56Ce9zcJDnrkf_4pLIr3PuKv0jfK-l-E8Q20Qbc
Message-ID: <CAHk-=wiDHb4Q4tJwOJqDYJd=L_0kJeYrYq3x0W9fEpDcUoCQHA@mail.gmail.com>
Subject: Re: [RFC] a possible way of reducing the PITA of ->d_name audits
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	Jan Kara <jack@suse.cz>, NeilBrown <neil@brown.name>
Content-Type: text/plain; charset="UTF-8"

On Sun, 7 Sept 2025 at 17:06, Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > You did that with the d_revalidate() callback, and I think that was a
> > clear success. Can we extend on *that* pattern, perhaps?
>
> Umm...  For one thing, there's something wrong with passing two arguments
> that always differ by constant offset (and type, of course)...

I would expect that you *only* do this for the functions where the
name isn't stable (ie it's called without the parent locked).

So rmdir/mknod/link/etc would continue to just pass the dentry,
because the name is stable and filesystems using dentry->d_name is
perfectly fine.

Only the cases where we pass a dentry otherwise, would we do that
separate 'struct qname' - and so then the name would *not* be
'dentry->d_name', but a copy. Exactly like d_revalidate.

Of course, d_revalidate() already *had* that separate copy (created
for the lookup), and when that isn't true you would need to waste time
and effort in creating it.

Ie we'd end up using take_dentry_name_snapshot().

Would that be horribly bad?

Don't a lot of routines already have the parent locked - all the
normal functions where we actually _modify_ the directory - so the
name is stable. No?

Then, the other thing we could do is just mark "struct qstr d_name" as
'const' in struct dentry, and then the (very very few) places that
actually modify the name will have to use an alias to do the
modification.

Wouldn't that deal with at least a majority of the worries of people
playing games?

This is where you go "Oh, Linus, you sweet summer child", and shake
your head. You've been walking through the call-chains, I haven't.

            Linus

