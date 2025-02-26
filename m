Return-Path: <linux-fsdevel+bounces-42720-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B2DA46C33
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 21:19:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 015A0188AA05
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2025 20:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E5327561D;
	Wed, 26 Feb 2025 20:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="dveIoudK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EE02755E6
	for <linux-fsdevel@vger.kernel.org>; Wed, 26 Feb 2025 20:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740601172; cv=none; b=PCHhC/jHyVmHhhS5cgPfr5FV5g4K2pyy4tD2URYXBnXMBTzay0o/iS27Eern8v5n3eRc1sXnXrw2gUvdVUqLNJU8awrrOr+UHh5DiWbgrWlw3I+XMxoB+pNXoelRExSX4r6CbAE66NCq9+GOdoX/tI0i4sHhLR6+mWQR+Gvtu0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740601172; c=relaxed/simple;
	bh=pRMgXJFWpAts+pU5cfw2qJI3yKgdhqxFVB1HP3y8nVc=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=EgZ6ojm3bcDv0NbZPrmYdesjhDzwD05jPbtlv1NvAhWaO/evKJ1YE5K/UDvbbH0kRv0+n4C6ScTq3MpgRtUA8jog568EsuNwSJIO7qJFyxok8NMDsM8sl7z5lf6WU9u7XGsh/jc9anerQYOAXnOyaICsXzrcwGAxZQleI722KS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=dveIoudK; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-471f7261f65so2913641cf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Feb 2025 12:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1740601169; x=1741205969; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ghoD3ag/pzPbCtjFY/jPNaeLEDXXel6+TW59rVHfjfk=;
        b=dveIoudKzKxKugANPB5GGsZegCwMrqDZcYGyKaEojssEcxYPTMjaP6BNUAButblbPy
         zbS5usrttUNCBSCnB3ybRBs8awJI2cASsu1AEF+JS+RJS3rFCxP3v78pWBlXIgUc33lY
         6FvP23ZUb7XMbgD86DpwYk3IpYZGNHAnO6yAsuGpixq2myYv0kfg/1voWZ1QGHRC3ytc
         fglXNgv6NNvGAiRh7rugpzBbWn2iogvJZ8Aa5BCQflLaQP0t+4QVBSz9o62UXeX9RDg8
         eoYLKcIeaLBnQEO/hfAvUPW1Bw8Firq21NSMkhtvcqEa1xImEcpcz/GumpEqCTKo7Gkh
         g+cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740601169; x=1741205969;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ghoD3ag/pzPbCtjFY/jPNaeLEDXXel6+TW59rVHfjfk=;
        b=nRLdh3uz6aOyqQ2bbOrSPUHti3HvC9flYZIw5inYY0W2Lgv3GKD99E3pH6QwU5YZDr
         tJi6y2v+CoGgMPTDcobck7cYqH/g+3LYI0qL5NWqGZmpyLN1jYh2QozTDYusDTqtGsXW
         pI+ZNKQyIV2wFkDkBkFqyGdmvR8KqfigjWJswPADLViM6N/EjpQAZVJwRZjRyJYA2Y0o
         MgBIZ9Iko3EAEx77f4am5gDB2BwipNeThz3ptCUh1APHJTwVWRedKYC+nd/a9rByXzDt
         ouYdnjNGzKPwHQcLFPD3Cd4KahSeKbC7wFxjpXymQlcVggZkKHh5AnaIsjnSwiUqYL3Z
         Klag==
X-Gm-Message-State: AOJu0YwQtcg8uCHB/RpL7CvJmUV6YXljkYlrHrgBoh+Ima94LAuXp84F
	yDfQZhuCKZCcct1igHyAebsw1mKEqeMqjVXcrPTwFVMqHNl9JKhxwLOl7hxcwQ==
X-Gm-Gg: ASbGnctw/hejXEEhV77BV+VhqPo/GUwBDe6AN08xaW1/9L7vKQlQljRjxL1v4wlNDmK
	7l3Ojm4voOsKirW2j3346gnv+46QbndtXP5n6/93Y4TXOYPK774L940msxRJSnX3GhmFmou9kmm
	2xQ1qGDm/7vGpUXIoIfyHVChFQpkKPYvJdqFW6Wy3/XwYwsWDUf4GBpIoCGEFVS0GptMjZENKWJ
	guzgxtyU/6zLTek49cD+gzyPQMk77oxhoBgvhZm3bBMZso9PJtXxKZ7HzIYd12zWxaNj/l2A+zi
	a0UTL+/ahvyjCDe5+FaF+u+bkwIvGpcDvJySdj/ExCcHb+M3vx6020xSDPp/0/cPgCIknjA=
X-Google-Smtp-Source: AGHT+IHlD52Lc+Tn+8mhSVeF3cbMWb5L2ojc8igqm9bfmEeYLdqG9MAA2o2DdRWX5V2W073wALgrfQ==
X-Received: by 2002:ac8:59d0:0:b0:472:521:871a with SMTP id d75a77b69052e-473e55a7432mr13431481cf.23.1740601169160;
        Wed, 26 Feb 2025 12:19:29 -0800 (PST)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-474691a45d3sm357351cf.8.2025.02.26.12.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 12:19:28 -0800 (PST)
Date: Wed, 26 Feb 2025 15:19:28 -0500
Message-ID: <4a98d88878a18dd02b3df5822030617a@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250226_1339/pstg-lib:20250226_1339/pstg-pwork:20250226_1339
From: Paul Moore <paul@paul-moore.com>
To: Miklos Szeredi <mszeredi@redhat.com>, selinux@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, linux-security-module@vger.kernel.org
Subject: Re: [PATCH] selinux: add FILE__WATCH_MOUNTNS
References: <20250224154836.958915-1-mszeredi@redhat.com>
In-Reply-To: <20250224154836.958915-1-mszeredi@redhat.com>

On Feb 24, 2025 Miklos Szeredi <mszeredi@redhat.com> wrote:
> 
> Watching mount namespaces for changes (mount, umount, move mount) was added
> by previous patches.
> 
> This patch adds the file/watch_mountns permission that can be applied to
> nsfs files (/proc/$$/ns/mnt), making it possible to allow or deny watching
> a particular namespace for changes.
> 
> Suggested-by: Paul Moore <paul@paul-moore.com>
> Link: https://lore.kernel.org/all/CAHC9VhTOmCjCSE2H0zwPOmpFopheexVb6jyovz92ZtpKtoVv6A@mail.gmail.com/
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
>  security/selinux/hooks.c            | 3 +++
>  security/selinux/include/classmap.h | 2 +-
>  2 files changed, 4 insertions(+), 1 deletion(-)

Thanks Miklos, this looks good to me.  VFS folks / Christian, can you
merge this into the associated FSNOTIFY_OBJ_TYPE_MNTNS branch you are
targeting for linux-next?

Acked-by: Paul Moore <paul@paul-moore.com>

--
paul-moore.com

