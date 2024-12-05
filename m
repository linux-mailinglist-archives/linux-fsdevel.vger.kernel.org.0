Return-Path: <linux-fsdevel+bounces-36559-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E22389E5C94
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2024 18:10:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE4E1168BAE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2024 17:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB60224AEF;
	Thu,  5 Dec 2024 17:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oe/zGAI2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69948F4E2
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Dec 2024 17:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733418598; cv=none; b=JsZ8A3GaLQLcMAjH9cAMh5YYCZQvjW9+4/Vf2v7zZOkLVzZoAsiOZYiJ5x1b42qUYgNbg3Dd+jXm6mvHSIA/MS44jiCUtXpsTQ3mv8zG+DxPsSDcR7LbLoSRVfGgvQGgCdnOdzF9ONoPtXKkuNLu9JppTz2TaPrsMY625dlb3E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733418598; c=relaxed/simple;
	bh=5toDQAAcRSOCpyzBijj29hiD2knprUv+NYmiOJ9q7jA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y3BH3d8tChfJ2eYy29S11ScK2HbBXxPAaiYy3+s1h2OBvvsKknWF6O5UV/si3bc1ZbhZk19YDmooucFA3+Xm7zdPreDg8N8iY5RuUXB8mCjufaKhqUDUQ7e71hbQgJq9vKK54CYWK7OnaAh/N0MxQxStDzk3D9FCMSakXbVtdrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oe/zGAI2; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4668f208f10so10695581cf.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Dec 2024 09:09:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733418596; x=1734023396; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wtQ6DngdHUcUeE19EHM4oNlKe89GsABoP1VEn/gZf7M=;
        b=Oe/zGAI2gR+fkROQ7A8ekyFE5mrWZPH6030JMcJASYfjvbV0e5/hfT5f20bXus6+ZR
         wAoeZp/CSCuoxVPldZqZqVc1Q9Vvc0zBGKl1xk91gdjzUAWQlyScmg9p2MDP8UmvjKTN
         nL8f9rEsX3RBW7l92e7F1Db40wUhgBP1EiWVEhNaSsV09QBOyn3PEOQQsNO6vsAGveHt
         VPikJcsybOyUoQRxB3vPoTAj+lIU1XETH8UToVEwSOkaWtapNFl5Nw7xtz7Xcj7SvpE0
         jfjCchiEL3ya2YMpSL7oBhEpv+aE4uzt4yynzjEgPVoZlD76WYBT7QZvYGzzRTH1g6yI
         g6Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733418596; x=1734023396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wtQ6DngdHUcUeE19EHM4oNlKe89GsABoP1VEn/gZf7M=;
        b=ki+ratLh4xf46O7BT+qL5E4ePOQHIVSzYOC2mWBBBRhr3B/r5EOf/6+dA8KFZGk6vj
         pvxMNg/M95dsbvOebm+YMs3DEKMOTmZ/BnMzTllbUAxYFZgnLMR9LeN0sUl3OFLoRzof
         xMyo0GKGC7JJSKqnOPpyRVYbPXiyiuEgzVNpt/abyCdNdXoZClZO+QdpihPxRiBpJ3BU
         VH5ol2kgXIU6aZaQAdOeMN+fdb4OEsdZ8zYeEXyw5gkjuhWfCftHo1aMJ2Sq2tfNs5wx
         xER9/+mRObnunVcIYm5amgnf3FVptRqk8wQojgFuyXSQOK/QApsLMZe2dfbNo8wcaZMS
         yOGA==
X-Gm-Message-State: AOJu0Ywq1k/biW/kM7ZFDeYCr0E9PT4YI2hPSzjykrVhxxX9Gs6SA09T
	RxyY/1jnSbIvWCrPmU8IikRTKFeSs5yI7kBASWaodm7piI+V0lrXPpVUs4Equn4cUkrN5LpH0TH
	vp3vC49PzBnLnspwCcl6mk+xP4IcDzrXb
X-Gm-Gg: ASbGnctRg4bDi7Zos5hd/2To3IMkcJt71HwP4dg7zTDru4OPBWg/Y+opGUFO61xmqm0
	2/Vsgjd+79KtzKJEQtUoCBdXB0EFiheqQ
X-Google-Smtp-Source: AGHT+IFiXfFYKGH/Asyx4AsPrmowfWXSBj6yu5D/A02QEfAiJOhxRSVtqI9Yf/pLRGfJrbigeyG3D/GoNqcxWQ4SpA4=
X-Received: by 2002:a05:622a:506:b0:463:64b2:2e0d with SMTP id
 d75a77b69052e-4670c3ac6dfmr186004301cf.40.1733418596089; Thu, 05 Dec 2024
 09:09:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204164316.219105-1-etmartin4313@gmail.com> <15ff89fd-f1b1-4dc2-9837-467de7ee2ba4@linux.alibaba.com>
In-Reply-To: <15ff89fd-f1b1-4dc2-9837-467de7ee2ba4@linux.alibaba.com>
From: Etienne <etmartin4313@gmail.com>
Date: Thu, 5 Dec 2024 12:09:45 -0500
Message-ID: <CAMHPp_SwH_sq9vCHMyev6QJbtGFkNL5fpX3ZXSHLF4zz0T3_+w@mail.gmail.com>
Subject: Re: [PATCH] fuse: Prevent hung task warning if FUSE server gets stuck
To: Jingbo Xu <jefflexu@linux.alibaba.com>
Cc: linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, etmartin@cisco.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 8:51=E2=80=AFPM Jingbo Xu <jefflexu@linux.alibaba.co=
m> wrote:
>
>
>
> On 12/5/24 12:43 AM, etmartin4313@gmail.com wrote:
> > From: Etienne Martineau <etmartin4313@gmail.com>
> >
> > If hung task checking is enabled and FUSE server stops responding for a
> > long period of time, the hung task timer may fire towards the FUSE clie=
nts
> > and trigger stack dumps that unnecessarily alarm the user.
>
> Isn't that expected that users shall be notified that there's something
> wrong with the FUSE service (because of either buggy implementation or
> malicious purpose)?  Or is it expected that the normal latency of
> handling a FUSE request is more than 30 seconds?

In one way you're right because seeing those stack dumps tells you
right away that something is wrong with a FUSE service.
Having said that, with many FUSE services running, those stack dumps
are not helpful at pointing out which of the FUSE services is having
issues.

Maybe we should instead have proper debug in place to dump the FUSE
connection so that user can abort via
/sys/fs/fuse/connections/'nn'/abort
Something like "pr_warn("Fuse connection %u not responding\n", fc->dev);" m=
aybe?

Also, now that you are pointing out a malicious implementation, I
realized that on a system with 'hung_task_panic' set, a non-privileged
user can easily trip the hung task timer and force a panic.

I just tried the following sequence using FUSE sshfs and without this
patch my system went down.

 sudo bash -c 'echo 30 > /proc/sys/kernel/hung_task_timeout_secs'
 sudo bash -c 'echo 1 > /proc/sys/kernel/hung_task_panic'
 sshfs -o allow_other,default_permissions you@localhost:/home/you/test ./mn=
t
 kill -STOP `pidof /usr/lib/openssh/sftp-server`
 ls ./mnt/
 ^C

thanks,
Etienne

