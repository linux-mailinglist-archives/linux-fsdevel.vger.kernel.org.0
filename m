Return-Path: <linux-fsdevel+bounces-60173-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C7CB42622
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 18:01:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0FBA1B2644A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 16:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579CA29293D;
	Wed,  3 Sep 2025 16:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="iDj8C8dj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DA729AB12
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Sep 2025 16:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756915298; cv=none; b=PKHIElOFOTwbdUSQJCWb7FLkcDo2vKAZLCiBzgGyXN37YJ9OKI05czpKWIf+n9ggLertPny02RjI8s3FKt4SZbbwA/mgoWpTDJu7jsbM1k9S6gtAEhb5YZ/jClaIZlrgrqNL/ND3eS+5o4uSYdfPdq+NYYmpyTf4sQMBA5jWD3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756915298; c=relaxed/simple;
	bh=PF5lvPkN4p4BKWwQdRQ6ArebWA4mRLmg/l5/JKeQeLs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HyktZJqTmwSmkdQXz33BIPy3xySiq5u94sT2ympOhG430/oXQs3QD8vnEnzD04CR9Y79qRECfj9g0l5eNS1c2hD2reTLUtQXJHmLXQKJmYWLplV4xcCB2mW2uYHReLwABJw0xwWXE/t9k5J8tKI+2U3hW2YuYS8/YpEbNMLIu3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=iDj8C8dj; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7f7a6baf794so13741285a.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Sep 2025 09:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1756915295; x=1757520095; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ax9jQivV9rIihfehyRZ3z6B+16CBGNLjAiR/Egumdkw=;
        b=iDj8C8djVKz/SVVaNq/b97pKULTkOm2wHJd8FWO6kaYGpdsB0HiJtJ9QwNPAJkI8Jw
         fi85jM9BHoR4aOzZwzUD+hiiZ10AGgMK9gtswlh5nq4DxdrlCMWJ6HsMQtHhdZCnTXih
         9C14Wt6251Pd2OFR8+htfjSUpqx3f4Ywy5IBI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756915295; x=1757520095;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ax9jQivV9rIihfehyRZ3z6B+16CBGNLjAiR/Egumdkw=;
        b=M4GVrTmvAaRDoqFRoey4d6b9gajYZjYTFUTczHV/4wMK1Iw0ajUTWvPtHh2NVDC/id
         TXoAwbJYdUhKJzCzxYzzbjLWvOjW1ixyy361bli18BkR//LtmRGSgHYRgewzrJRURY8n
         7vltiW7yvbaghFy12yd+7b2ytC8iH+HwOg2wpvUpwFe7FSqmoJY3WyZz2VGv1d9DKSLC
         Sy3ir5MD7GUavGSOAnkBUZEZHXEqpAV8a98DFDA99EydYoCBwZMM4xi9NkYnlWpyDHFY
         vOkXpJAa0Pw+JaeGrYPZUOQ0gH2Ui8LCI5AO01NDuQbWd6dxCrzWrLkqK6nC/PkKAqqS
         bz8w==
X-Forwarded-Encrypted: i=1; AJvYcCU5DNfMWxnYq0vo4PbXsYoHpsdSr8zxObWsXt6kI+F++T+etiHp52msXVrzy53bF5UD1ZYtcGPYaPUQuVeN@vger.kernel.org
X-Gm-Message-State: AOJu0YwD96nlI+gbTrCmWzULDYXRYEmnpiBJ1VJD93vjYF/u3fJWf5Lw
	594hq7q+yFGxhL5h13Vu5ZLaYISMqjUlm1nFEjVeByUShOaezpgeaY/JkRXIYc0J/nqkR5lfA0i
	xDRIx6k5QEmBaXSDUVTr907q8wysdFBSGlYWzqaeTbw==
X-Gm-Gg: ASbGncvClkXnUk0Z5Cf2UoQrVYoX+V9bPecvrXgIhGJoc+dH0/A4FvlY9ZHU7sVYr/g
	qlj1/SOc0BMgnv3QJj+BS6N1RY/ZfzXCi1rG38uVeW5L1+AwZ2crVS2NQhZm1QAXH01XBHbG4v6
	7cihd2oMQgd24BUmvNOGQpekUqIUAHG4K0ogOs8BKZz/J8/A4Hy3heNejTgbJNv0o5aoLkxjD5B
	j/n8FBE3Q==
X-Google-Smtp-Source: AGHT+IG8wLJCtfVsxPh5Hdzb0y6csbfQqVNGRKMQ4vHWp9ngh9iPx3QFDkpPRcsXGLbv5hGLThcP3N4QK5fbZHvXpow=
X-Received: by 2002:a05:620a:28cf:b0:7e8:4400:d082 with SMTP id
 af79cd13be357-7ff288846abmr1878533185a.36.1756915271921; Wed, 03 Sep 2025
 09:01:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <175573708506.15537.385109193523731230.stgit@frogsfrogsfrogs> <175573708651.15537.17340709280148279543.stgit@frogsfrogsfrogs>
In-Reply-To: <175573708651.15537.17340709280148279543.stgit@frogsfrogsfrogs>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 3 Sep 2025 18:01:00 +0200
X-Gm-Features: Ac12FXz7ixXH7v8CPmmMlUs6HtjRnuBQ4IFe2OiTgB7_UBKBSs5nlhrsNMBeTfE
Message-ID: <CAJfpegtz01gBmGAEaO3cO-HLg+QwFegx2euBrzG=TKViZgzGCQ@mail.gmail.com>
Subject: Re: [PATCH 5/7] fuse: update file mode when updating acls
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: bernd@bsbernd.com, neal@gompa.dev, John@groves.net, 
	linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 21 Aug 2025 at 02:51, Darrick J. Wong <djwong@kernel.org> wrote:
>
> From: Darrick J. Wong <djwong@kernel.org>
>
> If someone sets ACLs on a file that can be expressed fully as Unix DAC
> mode bits, most filesystems will then update the mode bits and drop the
> ACL xattr to reduce inefficiency in the file access paths.  Let's do
> that too.  Note that means that we can setacl and end up with no ACL
> xattrs, so we also need to tolerate ENODATA returns from
> fuse_removexattr.

This goes against the model of leaving this sort of task to the
server.  I understand your desire to do it in the kernel, since that
simplifies your server.   But fuse is often used in passthrough mode,
where this will be done by the kernel, just one layer down the stack.
In that case splitting a setxattr into a removexattr + chmod makes
little sense.

Maybe extend the meaning of fc->default_permissions to mean: userspace
doesn't want to deal with any mode related stuff.   Thoughts?

Thanks,
Miklos

