Return-Path: <linux-fsdevel+bounces-24518-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C12AB940098
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 23:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1DCD1C22591
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 21:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC59618D4C2;
	Mon, 29 Jul 2024 21:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ax9zRqia"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9058078C98;
	Mon, 29 Jul 2024 21:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722289843; cv=none; b=gAMdbLb7iUfCFZQIDzvDT+70G+fXF8cRNXqqklJ+JRc0FgoNczBZXgXb3uhFuu0GMSLXOj7zRNr0YD49UXuMW2XmwYbDuLFXWPMAX8/nAqaAMcfLITPclSskeM9QiDTtPGAzumMzJnEuoTjLdLGOZXGzx8NFa/rAAmtdU+X9foU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722289843; c=relaxed/simple;
	bh=JfbXA1oMsQYhnGX+C+o0fXVXJ9ONnD3UKhJ8D4SWc6M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BoM4XI76NlRqVvBwhVvnldfKAZCXrxC0GEJrt4xmTucbJjVZuphnrm+GEA8IZnQEsmXVJ8Eqs8xzryys3WS1jWF++BXqjHUcsm+EYqrlnUW4BqEarZEd6NBoqyYhiRRlWQrjY6jYa4RS5cq6iudBi9jXHOUAIBdLZrLB844IpsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ax9zRqia; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52fc14d6689so3985873e87.1;
        Mon, 29 Jul 2024 14:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722289840; x=1722894640; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZHYdNsV38rSoCEORmGraPdwugk2S8z3fUI1g2ycAeTY=;
        b=Ax9zRqiawYP3jPssJKSrNcxaZKOSrlRimUCA+nmeAdk8AxcrlnknnjnNXmspIGalaP
         ti4dwgDdg94vZv3y26OslzML2+1K3xil3CICy02EIGnrSyyy5/4eP8JJze16GwsJjlC1
         hlMBGVyn8CgQuxHyyCvw602HYqeEn4uz/cgV5HeJuICluaob/Ztx7hYcapYkjNI3wQ5J
         FmNm+e11YKsQG5+HkMF0TFWJezq7/+n+TQ2/GOP9wgeXDRPcRxd15hMmKD2SuwR6pzc4
         GKT7CMWcvOI8kw6/oSDPlpeDuFavJ23QmPEzg8Ua9eT1KdUTZVFQBD7bDn7I0kZBl5C7
         rvBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722289840; x=1722894640;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZHYdNsV38rSoCEORmGraPdwugk2S8z3fUI1g2ycAeTY=;
        b=aAQTvmMxu7iELBjmyNFb8X2ZLXDFqDLBmY7G0mejtsD7If3L1Nu4W77MYi3xpo0Cjy
         8QkrLGmBtoEO45fUDM9RRxhq6n/aFNPENMtYZmYRpoziPfDxa+mStLTMqkqkdOA0o9D/
         6JTyJn2vp/+7DEngyzDOiSjeHDqNc784r9FH7oV+YDW22CnYQ6Tj7OR8zIxTkBhpz+m7
         HAbdXA6m44krTLxkTa6OS8Dg88RoBsdTINiXH6hoU4M49w4rR3C76zZQM+gnghPCgo67
         IAZD28PoXMVCKhce8UQTlZejpC2o0JqE5b1DUn6k6BgDFZC4qbeDzh3Ob24LAjBWIfIT
         K6Ug==
X-Forwarded-Encrypted: i=1; AJvYcCUs7AVROZ3LXsU6/1RqVZH09fkOkTe5m9sflXdSwwfkYdpjK+MxD2zWsv+QRuMBiB0YoJRLTg2rgb0WKgcJkyMhnjDyYGoDiANqtcc6b6qYINeH5fCszsRXmdgHQQRKvZOgKy+71ubxew==
X-Gm-Message-State: AOJu0YyRZeDTZU/Tkja6eKUveTEJvpKA0m6xccJzFrFpUdJIUDie6Yp4
	qDkhePiBEPAn9MsAu9iHOOT3bobhH/ZDJd6xOZomU+2hy6MHPCRuFr/UJjTQbvs80k4a+bUjnId
	lHZxDkjmO1bW+aJBUy1jv4KpZiwQLpHoT
X-Google-Smtp-Source: AGHT+IFWN9JXEn50JPPZa3TKU1Y9seI9IbGFnYcfbiZY/lYQvi1KAIPEO7LrMlmyjsO1cU7AThqUBLYhlAgQS6kwy8w=
X-Received: by 2002:ac2:5b89:0:b0:52c:db0a:a550 with SMTP id
 2adb3069b0e04-5309b2bcbe0mr6048181e87.42.1722289839142; Mon, 29 Jul 2024
 14:50:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAH2r5ms+vyNND3XPkBo+HYEj3-YMSwqZJup8BSt2B3LYOgPF+A@mail.gmail.com>
 <20240729-abwesend-absondern-e90f3209e666@brauner> <CAH2r5muRnhFevDR29k=DkmD_B44xQ5jOXd5RnRqkyH27pKzNDQ@mail.gmail.com>
In-Reply-To: <CAH2r5muRnhFevDR29k=DkmD_B44xQ5jOXd5RnRqkyH27pKzNDQ@mail.gmail.com>
From: Steve French <smfrench@gmail.com>
Date: Mon, 29 Jul 2024 16:50:27 -0500
Message-ID: <CAH2r5mvTFDShaGeygoykFzB59B7SckxM7u5QHzKOwioP_W6e3w@mail.gmail.com>
Subject: Re: Why do very few filesystems have umount helpers
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	CIFS <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 4:50=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
On Mon, Jul 29, 2024 at 12:33=E2=80=AFPM Steve French <smfrench@gmail.com> =
wrote:
> > The first step should be to identify what exactly keeps your mount busy
> > in generic/044 and generic/043.
>
> That is a little tricky to debug (AFAIK no easy way to tell exactly which
> reference is preventing the VFS from proceeding with the umount and
> calling kill_sb).  My best guess is something related to deferred close
> (cached network file handles) that had a brief refcount on
> something being checked by umount, but when I experimented with
> deferred close settings that did not seem to affect the problem so
> looking for other possible causes.
>
> I just did a quick experiment by adding a 1 second wait inside umount
> and confirmed that that does fix it for those two tests when mounted to S=
amba,
> but not clear why the slight delay in umount helps as there is no pending
> network traffic at that point.

I did some more experimentation and it looks like the umount problem
with those two xfstests to Samba is related to IOC_SHUTDOWN.
If I return EOPNOTSUPP on IOC_SHUTDOWN
then the 1 second delay in umount is not necessary - so something that
happens after IOC_SHUTDOWN races with umount (thus the 1 second delay
that I tried as a quick experiment fixes it indirectly) in this
testcase (although
apparently this race between IOC_SHUTDOWN and umount is not an issue
to some other servers but is reproducible to Samba and ksmbd (at least
in some easy to setup configurations)



--=20
Thanks,

Steve

