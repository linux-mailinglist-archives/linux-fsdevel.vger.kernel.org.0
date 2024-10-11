Return-Path: <linux-fsdevel+bounces-31780-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A6E99AE13
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 23:34:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C0121F2196C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 21:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774EA193436;
	Fri, 11 Oct 2024 21:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="caijQmlS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1581C2452
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Oct 2024 21:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728682474; cv=none; b=fvWQQam4GbMr6i1Jo5Ty4oUqgxQmmvW8FefJ0eqQf3EPJKqN5WDrpZroO95dN934duSOjXHIBZhTpfZTqGIwym3mHcy9oQJNYdrCJcThRT/jPPArWxJ0u+78GaSNbn6Nmxq9bvDyy1u9X6Qxiy/FmYELSMjA6elgG0zdiKCQsU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728682474; c=relaxed/simple;
	bh=yn68VGQgjuF57lFPHzPET93dI/gFBtZI+3oFtACRqdY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SiAK8goU5uob81aTUTm75BlkQPc/fmsApvcfHugJZjM57tYvqMFTBT5K0lo21hHpMszSpKJwICt+1iK2CwoYyF530kAWNUPN9A+ollpK25yB8AqpGCXci6mBJhyGedCSW6ug0ezn4WAkYoERDXgXF1Dgc2h9bG8m2oAXzwz+74Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=caijQmlS; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e291b96a64dso1241086276.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Oct 2024 14:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1728682471; x=1729287271; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GuJ38S9WNQES8UxG5Eg7yjwtIJRWC+46hl/pmxrvCWM=;
        b=caijQmlSLH6Mn6V9Bh5OtPmtrih6HODYry4AeeeOsNhI2lrdPj2P8CJcgedFPsFYnN
         9grM3LwYNldCHZawBfBC10tYjsH23tLkAMx86mX+dkgE/7e0mGpcGu+7U6E2HYBrdDqc
         dCUzZ3/4GQ30K5F4OsU9m1jbcF9YnVModAx/RdB1tIaYXbyt8LZw/trWf196QbIMkTnU
         +1hAWpqaXYsMBAw/4J1C3dOhLws2hKV12prYbtqY4ylJhHI4VlkhXU68mqDD57X/nicz
         5MGJjVhgKTGNyRIYt9DQCOTQxOWlOG51E3SVBTY65E8s19rVFXbYAfSPcJ3MiO3PJW37
         7lnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728682471; x=1729287271;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GuJ38S9WNQES8UxG5Eg7yjwtIJRWC+46hl/pmxrvCWM=;
        b=wMXER9AFII7yLx/ZV0b4H14NZewZNdOyYrp6jrzbsn879RtF6LrZsoAlrwOebDMuea
         rYdIVqq1Eo3ouq7c2XyvIYe0suhKk5WNZZ2S1fhrFyGWKVaeDnZ43jFKWax4FNZmPgD9
         AN3S8BtsEN1vAG6e7IprZyPDFwTPKMSOT8I+igkF3eYgnxPr7eFWCrFfMsJtA7HJn/4q
         lO0iLVTZ+7Gp6SxU344KpCGjIKp7tBTVjXv752WkXdt2e0Og0aKPHdlZANzvTQ+gqYUN
         QfO7fXo8qaTiOQIeol6dLzuiYvqvM+W1zRhVqIXucR69yM5VvA3HngPi6TLgis2ZKXVr
         pC4g==
X-Forwarded-Encrypted: i=1; AJvYcCVd737MMs58+tYYca4b/ZEtpio1/kjdegvrgLQJaL2P9NfNnCXJ0ernIXd+lqw10JlPbgFYKBy2sLV/cIU7@vger.kernel.org
X-Gm-Message-State: AOJu0YwpXgfUMC2wlcH8vPl0SqW5GxT0q9J7u1lLW27LIUtv2Mw0k27/
	koHUjpDhmqQWP3xppkG6sDsRYI1He5B35b471GnuLAfAoJGLdYyoyabFn1+G/iMmvIUaiLlkeRm
	6LWPXi/CLwcRARKK2myrHeOVG8aLlL9K/iI8A
X-Google-Smtp-Source: AGHT+IFrYhiJio4X4+ywyBra47qcZ6SUO4xvjf/kfaS0SLCEASRbGZElMMGFLK5PU9YPz4TciK+hv+7VEGUf5UKSZ1k=
X-Received: by 2002:a05:6902:11ca:b0:e29:18e2:622c with SMTP id
 3f1490d57ef6-e2919ffb611mr3143224276.56.1728682471609; Fri, 11 Oct 2024
 14:34:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010152649.849254-1-mic@digikod.net> <20241010152649.849254-2-mic@digikod.net>
In-Reply-To: <20241010152649.849254-2-mic@digikod.net>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 11 Oct 2024 17:34:21 -0400
Message-ID: <CAHC9VhR8AFZN4tU1oAkaHb+CQDCe2_4T4X0oq7xekxCYkFYv6A@mail.gmail.com>
Subject: Re: [RFC PATCH v1 2/7] audit: Fix inode numbers
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org, 
	audit@vger.kernel.org, Eric Paris <eparis@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 11:26=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digi=
kod.net> wrote:
>
> Use the new inode_get_ino() helper to log the user space's view of
> inode's numbers instead of the private kernel values.
>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Eric Paris <eparis@redhat.com>
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> ---
>  security/lsm_audit.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

While answering some off-list questions regarding audit, I realized
we've got similar issues with audit_name->ino and audit_watch->ino.
It would be nice if you could also fix that in this patchset.

--=20
paul-moore.com

