Return-Path: <linux-fsdevel+bounces-45435-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ADA1A77963
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 13:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BC373A9024
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 11:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57E41F1909;
	Tue,  1 Apr 2025 11:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k4043wa6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FFA26AE4;
	Tue,  1 Apr 2025 11:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743506065; cv=none; b=n/dJNj8uG2dY4ILT+21tcT66qvAgXxXjj2oWYLl5KTcDNaBualwzTSUYYlFexaQqcRkac6VfmwyPm5FWxSf/vz4lJRFY2nK0d7miC16Jck+cf5jWSlp4Q2Ot5EanYFkLRyi0q6Tkuoco6VirfJpZdvOp3w9V38gNymIjLrpFObg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743506065; c=relaxed/simple;
	bh=XkN6QSSye3gn+M3fMvTNIV0lRCTkeu0sH4/gJnGYDAA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=CCC3WzZrRCgByqfexX4iaNj5OFGe2fWmyqmK6TOXocFNwJxQTpjTcUgT5HNy2U3HTEgHgnojci/lWiXRO7NJ6rW+8Ce0uddTNAp3hazMhhp3UXYWDDbUR5fl7oLZIQaRO2adwv9h6Hce0edPVXysN0Ux1+FW9HWxgkv8mRsO0lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k4043wa6; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-307c13298eeso61682301fa.0;
        Tue, 01 Apr 2025 04:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743506062; x=1744110862; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XkN6QSSye3gn+M3fMvTNIV0lRCTkeu0sH4/gJnGYDAA=;
        b=k4043wa6/OhQnEMfYTCr9J4atpMW6O0YKtcYrMkybvqTUdD/0+54ujxp7LwO8EdSY1
         GtfBMaXejBJOT2PQa8DCklzLbgWfO4JtdN6OlVmz2GoK+bZYJaJRJqGI86anmBSMvgtO
         DIqZ6gWH5Jd5vCW7DdIE/RSeUBeUdm28tF8/GAnFI7h1R2KDccdZ3h7ka2GXq2BrYvmK
         IGsUbc/HCZXc81u5ZpVZ3lINbO9Swt01VdiRyYEGCSbG9gIdfFwNcx1KR6QH1w2w9epe
         LGZqVF97y2fTtKUeYUvJmt6deYLQP7N2D9IokKbqpvGIdVOkkhS+BEbLNIWjoxEPVZzG
         7cMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743506062; x=1744110862;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XkN6QSSye3gn+M3fMvTNIV0lRCTkeu0sH4/gJnGYDAA=;
        b=nYsG/vuNvv6hWYRd54hXNaDbQkofuRGMR8BuwmYzE0TXyl8HHACJ4BBNQ7NCHcxneq
         tClVCk8IVVCoLvE/aZllWN+cbYNYz29JijNmDbGUSMcv5ouSVC9DvhSxxAQHcJhBflzS
         kg2Ilf+KUKJZmsyJSRWkLMkBNNwo4PxK7yA0DK/PXB8RlO9BoyDP9IoPomrEJwqpMn3T
         HGiuSHtAo+sKPRNSRmrlkHdbuA8fv0W+I/Ac1EncwY13GI9KpoHPfE1ISyY6vQpSaQ1K
         J5/xu+AWzBJZn3nrIT5QnF92A5lp8YBsNcDrb0Jn3+Mf/bhz7f8waN+FdQet6xNWRGkI
         du5g==
X-Forwarded-Encrypted: i=1; AJvYcCUJhk7wlObr2QVf2K3pij7OTjndj+PHmiTyk1cq5/gFhO2vAHMjNFGPiAazynQKrOEJbrC98R950pSn94+d@vger.kernel.org, AJvYcCVysGwdisNiczRNthAiz/+Tynvwuc5n3N82/Z83GK73Bwk4vh9VheuGfCwooWiVmjBYqVBshuCvOFk9R2MN@vger.kernel.org
X-Gm-Message-State: AOJu0YwGEy1cUgrcQ8nLdUy2JQHUXMRxIZTQKdefsmY5Vdv6j0+Wgxfx
	swKOtkDIsaR1w2pntAc1uNbB9WnADo22pKR/nKNQG5XtdQLRfEDK+1JdQGOe8BXfTrS/TKPKoJq
	mMeIQ3YI5/thuwKeroq/HzS60ug==
X-Gm-Gg: ASbGncu0xSk+BOwF/jhjnlwEE1xWEFArFNsl8VgU5N5m+sLnNKRyvqUGZyZA7nlTWkX
	OkhYa235Q+5TJG6lu7ETgORRHg0CiGRwuVQaxlnSqylxr5LA6UokZ3ydaj2fgxUyz+3J/5DgivM
	DcwkCicFp3VYV3a66J5xInxZA=
X-Google-Smtp-Source: AGHT+IEHXU3npfPY3e2AZAgiXkRPkDoeSeQ4HIOCYEc6v/XlurUG1d7lGv6TLev+ssbLRtBsmvq1scS5Nrl2RRpvV/8=
X-Received: by 2002:a2e:a905:0:b0:30b:c9cb:47eb with SMTP id
 38308e7fff4ca-30ddf98eed5mr34283631fa.13.1743506061500; Tue, 01 Apr 2025
 04:14:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Alexey Dobriyan <adobriyan@gmail.com>
Date: Tue, 1 Apr 2025 14:14:10 +0300
X-Gm-Features: AQ5f1JpCX8vr8D1N1XWcgqiuCkYPqSO2b-8a00U3lFHSKydprH4QXs3scq0dR6U
Message-ID: <CACVxJT_qZP-AKUzf5sXfp2h+qJ+L0BZit3pgi-aGCuXk4Kmzuw@mail.gmail.com>
Subject: Re: [PATCH 1/2] proc: add a helper for marking files as permanent by
 external consumers
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Linux Kernel <linux-kernel@vger.kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

> +void proc_make_permanent(struct proc_dir_entry *de)
> +{
> + pde_make_permanent(de);
> +}
> +EXPORT_SYMBOL(proc_make_permanent);

no, no, no, no

this is wrong!

marking should be done in the context of a module!

the reason it is not exported is because the aren't safeguards against
module misuse

the flag is supposed to be used in case where
a) PDE itself is never removed and,
b) all the code supporting is never removed,
so that locking can be skipped

this it fine to mark /proc/filesystems because kernel controls it

this is fine to mark /proc/aaa if all module does is to write some
info to it and deletes it during rmmod

but it is not fine to mark /proc/aaa/bbb if "bbb" is created/deleted
while module is running,
locking _must_ be done in this case

