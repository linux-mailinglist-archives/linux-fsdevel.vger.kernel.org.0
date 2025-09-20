Return-Path: <linux-fsdevel+bounces-62318-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66EBEB8CCEA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Sep 2025 18:27:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F22331BC2412
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Sep 2025 16:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB092FD7A5;
	Sat, 20 Sep 2025 16:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gF7BFj7s"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC8F3F9D2
	for <linux-fsdevel@vger.kernel.org>; Sat, 20 Sep 2025 16:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758385610; cv=none; b=OhjFc0bLOuVbIp/qogWTNQ8h96uqaRsE8/Uxe1Gm7DANqSuwVdtlQsFWNRh/RgF7/AHXU7kcX29mo9yJRc+3xRHUpGqZcTu6Ttyzy+PMIIkCj43RuzVPYrtZWM3OvURQdICY23SF6c6fKy0qqLZj4RfhsAmudnVp8IVHVJp+9i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758385610; c=relaxed/simple;
	bh=mNO5F5NJlTITJbrMxJ3wyu2jz7VIBwYhTqCKBzbt4xw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HMW8d1/HMTKJHX9wK/1JK2ZZfAV5pudn5jb2Ndt8KRHEa+2Ily52Jp22Cb31ULn7/vH2u2Bt8h9+2aX5N8ZzQ/Hi3hN/AsLI3OdkZjrt1qJvGozFDpOH3sM7AHJyYeWtK+BzEHGLuOBazrZmTvlZpcNUMYevSvZ9TsBoc0tkeNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=gF7BFj7s; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b07c28f390eso560116666b.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 20 Sep 2025 09:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1758385607; x=1758990407; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GvLRCncIiqRrC6qT6Y0+vbtoZaqXeTLbbsZoYra2n2s=;
        b=gF7BFj7sOv/VqXY+/xuahlh6nSPkoA57qcYvzlRygbgTDQB0zpTeG6kSEMyn5K3Skt
         QhPUjm18PTTAnaN0fddwPfp0vx6EqqzAVpTVGst7XpeZRQXxoFO8aslfjehbjOBiNgS0
         nas2kfYKlT6krlS1MKWeVERsGzlqNiJtB7sdE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758385607; x=1758990407;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GvLRCncIiqRrC6qT6Y0+vbtoZaqXeTLbbsZoYra2n2s=;
        b=sI/FhJOxBzvuI6hSdi4EnbPrCmineFLYxIuILrdW/fG3VecrhJt8uFV2rePQIfSKVo
         X9/mlbrxiKqY5a2pr1H7edr17khxJZlxDL8AktdKR/Dkre0GquTz+GwxpklERtBJiWBw
         CrujpbrImOWMInPebXQ5PwoBUvq70Q6CDigndxQPy4YFdsZX9jqkcM5bylhYJtYUne+t
         HIToKBgmu0caYLMy8tHVT6b13YxmvxC8JfGxqOe1LfSV5N/aSp9HUrGNtFcupoGXl6pd
         5XOdMMaj2GWdB6S7DZnfbsaCVqh2iSRGTiv1xOztNc//5XPA4Z+s2uHYLkyAMqaswe/5
         3/8A==
X-Gm-Message-State: AOJu0YwoVsShai7oC/lSECOZgRWBpSMFPliLSGwcg9uSgn2IeW8nBmHF
	2aaChowOfPMJeXk5XdZn1hf9HRQvS2ErutHjLit2uqWlyE9iBPsZ1XJDDSZiY2Db0CTe7TtB6sm
	xDyp9kI8=
X-Gm-Gg: ASbGncu7Ntm+qqm89hO50PJ0kEo92aQtVG4n6so+Cs7A8YuGBlI0FxFN5I0//MHwap+
	urYkBG3Rojjx7+jKlyubsZCYG3HLXx26Rl0aNR8aWykNU/qmbjd1h+Hrm8a8QFVH/f8FNBsmChj
	0zNvwB/OlHqFECokxia0oRuMH0xL8Hdv7DsP9EB4zotdmf0hbsomXK0Y9apxRTdMuAytpVjLEUH
	CQQgHxkIz51npDCs44qsAZa+GYNqsE2lx0WkHsSiwsrvbXBzZUIuVN4e2ZE01wLqUuldNbtjI6S
	+hNambL2U9FrntAL0Y5visFBQ3RBQZt1ry8nd4WfTkXdbxjVke1Bo+AYNku4eeUflNcds/rKAL7
	ApIMCbE/F3vSA7uStamaEWgSeT8Ah8+3+94pOcn+l6G4Ksby5forB++nx/CdGAO+XFcQ2Ailf
X-Google-Smtp-Source: AGHT+IGCdxu9cly76MdTpITJEuTUi2V1Y0sBAZtPd345ykwXc8MKCWizAzMaxZFRTHHAlF+ZKSUCpA==
X-Received: by 2002:a17:907:6ea5:b0:afe:cbfc:377a with SMTP id a640c23a62f3a-b24ef976f65mr706555966b.27.1758385606662;
        Sat, 20 Sep 2025 09:26:46 -0700 (PDT)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b1fd271e5fesm670769466b.95.2025.09.20.09.26.44
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Sep 2025 09:26:44 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b07c28f390eso560110966b.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 20 Sep 2025 09:26:44 -0700 (PDT)
X-Received: by 2002:a17:907:1c89:b0:b1d:285d:155c with SMTP id
 a640c23a62f3a-b24ed88702cmr706169166b.7.1758385604052; Sat, 20 Sep 2025
 09:26:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250920074156.GK39973@ZenIV>
In-Reply-To: <20250920074156.GK39973@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 20 Sep 2025 09:26:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiXPnY9vWFC87sHudSDYY+wpfTrs-uxd7DBypeE+15Y0g@mail.gmail.com>
X-Gm-Features: AS18NWCBuRxfjxFE7tKBAQqhhkva7pQWM9EJwSLVmis6atYjgiGA5eqHrxKhjLE
Message-ID: <CAHk-=wiXPnY9vWFC87sHudSDYY+wpfTrs-uxd7DBypeE+15Y0g@mail.gmail.com>
Subject: Re: [PATCHES][RFC] the meat of tree-in-dcache series
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	Jan Kara <jack@suse.cz>, Ian Kent <raven@themaw.net>, Miklos Szeredi <miklos@szeredi.hu>, 
	Andreas Hindborg <a.hindborg@kernel.org>, linux-mm@kvack.org, linux-efi@vger.kernel.org, 
	ocfs2-devel@lists.linux.dev, Kees Cook <kees@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-usb@vger.kernel.org, Paul Moore <paul@paul-moore.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, linuxppc-dev@lists.ozlabs.org, 
	Christian Borntraeger <borntraeger@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 20 Sept 2025 at 00:42, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> The branch is -rc5-based; it lives in
> git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #work.persistency

I reacted to the "d_make_persistent() + dput()" pattern, and wondered
if it should just use the refcount that the caller has, but it does
look like that alternate approach would just result in a
"d_make_persistent(dget()))" pattern instead.

And I guess you already get the lock for d_make_persistent(), so it's
better to do the dget while having it - but arguably that is also true
for the dput().

I think you did pick the right model, with d_make_persistent() taking
a ref, and d_make_discardable() releasing it, but this series did make
me think that the refcounting on the caller side is a bit odd.

Because some places would clearly want a "d_make_persistent_and_put()"
function. But probably not worth the extra interface.

Anyway, apart from that I only had one reaction: I think
d_make_discardable() should have a

        WARN_ON(!(dentry->d_flags & DCACHE_PERSISTENT))

because without that I think it can mistakenly be used as some kind of
"dput that always takes the dentry lock", which seems bad.

Or was that intentional for some reason?

Talking about WARN_ON() - please don't add new BUG_ON() cases. I
realize that those will never trigger, but *if* they were to trigger,
some of them would do so during early boot and be a pain for people to
ever even report to us.

BUG_ON() really should be shunned. I think it makes sense to you and
for automated testing, but it really is absolutely *horrendously* bad
for the case where the code hits actual users.

                 Linus

