Return-Path: <linux-fsdevel+bounces-34789-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A3C9C8BB9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 14:25:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA58DB279E7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 13:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F761FAEE8;
	Thu, 14 Nov 2024 13:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="O+JLA/y/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC641F9ABF
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 Nov 2024 13:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731590471; cv=none; b=OSJrIhSqJQFfBu4yHTTYUYQQOH/vDUavZkzvfgasL5233s/5VURcEqq8LZ+0QujkBzBolBZKcCMb/iMrcsux0HAsTpMcOKND5g5+nF350u/hzpTUiQddzik2J5f9h4a9VNDgb805qqwJxBaoDWoHcuhZ70cv396SghiySdCM5Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731590471; c=relaxed/simple;
	bh=A786/WKYl8XPMPOFdqL11xIlC2GMhjjJaMsmbu3TsT0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eQlb2s4wVF7+xAMDG0PoZfqzZp1UxFTd+WcZ8TFSrzY+cehR7B/i3fPf8fnCqfzXiM5MjGvH7Eng0RZG9PADLQej8eq2DNB8WwmR7iVrvVVvafqEHXZbSEv5/fDUv1op/ss3rsGzCru8gmfLRI2VSDE+9nx2T2Lk9Y+bRT3r0pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=O+JLA/y/; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4635760725cso7267861cf.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Nov 2024 05:21:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1731590469; x=1732195269; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VRfbnelZeJfrngVoF9cQMEJPOYnQHW9d2DowJs6V8LU=;
        b=O+JLA/y/7rvqOIncYm8X2dBe4uEN1yDyC9pQ2R7cvjXda/IentupLrNI5ec6+2hGxp
         QbOroLvyFx69zbMK6IbtTR8rr/lPQzJ1Ve6agnQeSyfXLdTdL9l3FWw6WB5Yzcp8JDvh
         KM8aiBIua7c0oxQ44+LyeF2MPezf8tVpWgLRk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731590469; x=1732195269;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VRfbnelZeJfrngVoF9cQMEJPOYnQHW9d2DowJs6V8LU=;
        b=cWeI7RYjySaXsoys1MXImUcb1Lm5kXfKDAwCVjF8ipz3IH/YnEb5HOeIGzDcPBsmA0
         HWWyvK7CRagXW9+FIskAPdRMPPKqdrtS0RSTJqQ/wJ219LhysCV153TKCtliuymfduZO
         QIOaJ1bMwqVscOFSTNMx1D7KeKIIZys6PCAbJiSevfn1i4WTitBe9I5Aec00IDYn3QnJ
         2BR4yJEZ6dspR6ppqs0XcaK1KLTCstSJcuF1AIGa4pmu+bb0cgyAZEsqNv25Jk4CHE9V
         ucuiHBDnTzW+w/mVd0/T/XsULhf92ZNQ0T5ZpIrM3Fo+YBv2d59H6zAwuEmjgDh42FbO
         +mpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWHfnPZHThTHq6FVNTiD7ook4570RR4BTLmtpoWOOzFDYz5XlBW9fzVsuha7Ub+TieuwXzj7nNRHmEkfEc@vger.kernel.org
X-Gm-Message-State: AOJu0YyPPC7JGk4/fixFvIjc0cVZ2hi/xq7pOyQjrGYcs8TLprPXNbUt
	eAZmw65wCPB34HpTTZHixZULys4PvkswziiEN6SmRqPMpzYE3JoEfnWrtgTJ4BsYx34cBlgROq0
	F3sAJ15iYsdNKxQ1BuJWKjrjxxh+9JMSWqtMHLQ==
X-Google-Smtp-Source: AGHT+IHov9rGqtzN5oWlMJTxAP3c0s3NW8iCKhJaT2L4/b4lmENmcMVKSJd8PArNdJ46UKbpr5wbhwLZZ1ZKzkomfLY=
X-Received: by 2002:a05:622a:5b0a:b0:462:c1c6:d8f5 with SMTP id
 d75a77b69052e-46356b2db0fmr45431741cf.8.1731590468993; Thu, 14 Nov 2024
 05:21:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241111-statmount-v4-0-2eaf35d07a80@kernel.org>
 <20241112-antiseptisch-kinowelt-6634948a413e@brauner> <hss5w5in3wj3af3o2x3v3zfaj47gx6w7faeeuvnxwx2uieu3xu@zqqllubl6m4i>
 <63f3aa4b3d69b33f1193f4740f655ce6dae06870.camel@kernel.org>
 <20241113151848.hta3zax57z7lprxg@quack3> <83b4c065-8cb4-4851-a557-aa47b7d03b6f@themaw.net>
 <20241114115652.so2dkvhaahl2ygvl@quack3>
In-Reply-To: <20241114115652.so2dkvhaahl2ygvl@quack3>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 14 Nov 2024 14:20:58 +0100
Message-ID: <CAJfpegvDOPSJn1PeXRJqex6NRPUJtWfWvZnwCRD+E9dWVhWumw@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] fs: allow statmount to fetch the fs_subtype and sb_source
To: Jan Kara <jack@suse.cz>
Cc: Ian Kent <raven@themaw.net>, Jeff Layton <jlayton@kernel.org>, Karel Zak <kzak@redhat.com>, 
	Christian Brauner <brauner@kernel.org>, Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"

On Thu, 14 Nov 2024 at 12:56, Jan Kara <jack@suse.cz> wrote:

>   What I'm more worried about is that watching the whole system
> for new mounts is going to be somewhat cumbersome when all you can do is to
> watch new mounts attached under an existing mount / filesystem.

We don't even know if there's a use case for that.  I think it would
make sense to think about it when/if such a use case emerges.  The
inode notification interfaces went through that evolution too, no?

Thanks,
Miklos

