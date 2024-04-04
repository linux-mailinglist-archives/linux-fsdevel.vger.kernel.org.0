Return-Path: <linux-fsdevel+bounces-16119-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B27DD898A4A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Apr 2024 16:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAD981C23291
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Apr 2024 14:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2C51BC46;
	Thu,  4 Apr 2024 14:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GBmkNGSO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8121D18654
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Apr 2024 14:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712241691; cv=none; b=U7PsW4WfbRpEAnzskwdRjs52CIXE6UqPjkANkyJA+M80THD5MI/lqspetC7fDltEmV8pvIxcqH9GhFhcevlZTOZKdV4U5AnKBtZZS2fcSJaKkH0zabHH85OaaBkGHohwzlTqLmR+htRUM4191u+Gs0MF6A/YISD7tXsLKXdfiAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712241691; c=relaxed/simple;
	bh=9mASaKTQa8RIIfelBiLvocoKYdItfI5n4cUIZcmIm50=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gJxSUz525WgMS6TCD/IX4Lg4it3fIJUTzl4+eKLdwVJh7bZSwcQ/M1lIL/5rNXqKITYL34nY0Ko699j0XuuRt4Fho61Z9L6nh1xEdjwh0839It2dqIwm3X3v8KiEdjxFXKZJMqBvdd7ptM3DQVImKBR1jUu0pA9SrVntkymUHJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GBmkNGSO; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6991e317e05so19000656d6.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Apr 2024 07:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712241689; x=1712846489; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9mASaKTQa8RIIfelBiLvocoKYdItfI5n4cUIZcmIm50=;
        b=GBmkNGSOpcnTeScJqaZxxfQ9/Rf37ZgIUGzRV9dTVi3iFaRNM772tTWuYurkTzpTm9
         ijqSvXzdE+P0Wo7/eDMyN5aq1n6grYQrhhnQSJYvLFFAE6jfIs04Pk5dw+EPU5Jn1g0k
         WTjEbHaAaXEZ9pu/98fhHMdfPQpsH5NAwcrpn5oGCPbCiJJUmHa0uZFYlZ9WO9rPHHaO
         dinsuXCGfVFD2q5GB1z7litPk8XStDrgePuVSfX7wPdl4vtpun9BEWf/9EKYCdnlC4s3
         M1YAuuct6ekLbfVE2iS6NqhI4NG066axRhsUqEXB7Nm5LVeRyJlNCLi/z9zHMqSVtdlF
         UCgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712241689; x=1712846489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9mASaKTQa8RIIfelBiLvocoKYdItfI5n4cUIZcmIm50=;
        b=o7cXMr/wk9WTdDhb25wv5V54iKTOFN0ydGu5xnqfVoVOYfB782ieDE5BQ/llch5Xn0
         OwYm6XXrD37iiuUMK43QPYTSAWA97lkW3vLZK3gIT//l4pE6LjhUjQv8ABZbrMoSp3x+
         +f3kXyitrkSRoISf13EM3MAsMX5BkFkkL2U43ixkHAgMQTELuJPJN6rphs28tcebxers
         8VOprbpCR9Qbinz2FHyDuXOvOmGIIfUTeZEZmeyq1VpeprtxBMlFleVxJ4wCnLtlu175
         VBpwAWxkhY1esUXfTUyTYY0BFdTEOK2xa9z7OXh/eG/ukKoh6HCAkgSuEYA0tj0h3fQ2
         rZaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHtTX26bbH35I+7EP6uloykLvE/m3bRMAmwePfVl5OkcPteterrW4QNY5G832IrzyZ4tv13SdIzyDzrZV/JrD6yiYiHHuQQhHPiIJA9A==
X-Gm-Message-State: AOJu0YzSzE9qOc3n5rOMIsElZ0F3ahQ7L5wYyydU6U3A5zwWXYSZ1ZN5
	jZasXG9GpCwRpKuBedRWXCi8s1ZP3XEgFTsKRfCGXMydYrQ8X83u0v69Wg11Pe4zsnazuy6Ww0o
	/RYLb3GHec5nUmfiTu9ouhLPac4Q=
X-Google-Smtp-Source: AGHT+IHtJHdY4ttIFesSNInpaEbbU17s8STYWB8bU1lPqpNX8wVl2VkyZZzWJVsQiPITrY2N3mKeOfJbfqomwGdLjnU=
X-Received: by 2002:ad4:4c46:0:b0:699:1b89:178c with SMTP id
 cs6-20020ad44c46000000b006991b89178cmr8613854qvb.2.1712241689382; Thu, 04 Apr
 2024 07:41:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240317184154.1200192-1-amir73il@gmail.com> <CAOQ4uxgssYK=vL3=0af6gh+AgSPx__UR2cU6gAu_1a3nVdYKLA@mail.gmail.com>
 <20240404143443.zfurlpe27m4mysrs@quack3>
In-Reply-To: <20240404143443.zfurlpe27m4mysrs@quack3>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 4 Apr 2024 17:41:18 +0300
Message-ID: <CAOQ4uxiV1Y5ufSVqH4T0xbjwtxLA0ijM=kf9xQMSGZXBjTLFCg@mail.gmail.com>
Subject: Re: [PATCH 00/10] Further reduce overhead of fsnotify permission hooks
To: Jan Kara <jack@suse.cz>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	kernel test robot <oliver.sang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 4, 2024 at 5:34=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Tue 19-03-24 11:59:11, Amir Goldstein wrote:
> > On Sun, Mar 17, 2024 at 8:42=E2=80=AFPM Amir Goldstein <amir73il@gmail.=
com> wrote:
> > >
> > > Jan,
> > >
> > > Commit 082fd1ea1f98 ("fsnotify: optimize the case of no parent watche=
r")
> > > has reduced the CPU overhead of fsnotify hooks, but we can further
> > > reduce the overhead of permission event hooks, by avoiding the call t=
o
> > > fsnotify() and fsnotify_parent() altogether when there are no permiss=
ion
> > > event watchers on the sb.
> > >
> > > The main motivation for this work was to avoid the overhead that was
> > > reported by kernel test robot on the patch that adds the upcoming
> > > per-content event hooks (i.e. FS_PRE_ACCESS/FS_PRE_MODIFY).
> > >
> > > Kernel test robot has confirmed that with this series, the addition o=
f
> > > pre-conent fsnotify hooks does not result in any regression [1].
> > > Kernet test robot has also reported performance improvements in some
> > > workloads compared to upstream on an earlier version of this series, =
but
> > > still waiting for the final results.
> >
> > FYI, the results are back [1] and they show clear improvement in two
> > workloads by this patch set as expected when the permission hooks
> > are practically being disabled:
>
> Patches are now merged into my tree.

Yay!
If possible, please also push fsnotify branch.

Thanks,
Amir.

