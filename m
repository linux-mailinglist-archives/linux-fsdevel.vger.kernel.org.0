Return-Path: <linux-fsdevel+bounces-44425-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C08C0A6870F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 09:40:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17A743B9526
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 08:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FBFF2512ED;
	Wed, 19 Mar 2025 08:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E1f7Raxu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF721DC9BA
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Mar 2025 08:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742373589; cv=none; b=q7nBzToOK/Rb22eFcMndf6KbUtHPlrp9fqz9k1wboXWnCZpen44sbTix2LhPn7PksIt//VaH6vL0M7sxyGZhKeApSkJ+HDb1KLeOssTAmb/m2CnnzQilIDSAD+w6j0uW96FjexvIwwMp9OCzPZpNba2bLhRhBytXiqicZsPvgm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742373589; c=relaxed/simple;
	bh=5QTQG6QXfisCPA4xpu3CJSfWq5SgqopsiydmqFxhNgo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VKM+Vxen909T3jhZvZTmvteCCP5CXePwz7lbeyvxi1FJ/uSQdJIfNaZLCOcIRsIlh1peUakNPncVULzi0bIMZmGGSLuwnVB81WwKfvsZBj+/4CE3vy4sC6IblyF60xYQSXQIbHfLbH40fLbGdt9aP2/rbGEm1cK6Wz0706osUIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E1f7Raxu; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ac3b12e8518so143946966b.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Mar 2025 01:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742373586; x=1742978386; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5QTQG6QXfisCPA4xpu3CJSfWq5SgqopsiydmqFxhNgo=;
        b=E1f7RaxuaoefCpSEDSbRdHmCoDLBHB7fSZePMKbSqlZ7qI1m7YfoCK8//oY5O9J7EU
         MChQNvG1rIsolCU1WmqnOxTHzErtOW+3rE/luwBfiNMrs9Qxqd1jli0QgbksrTFeTtn0
         lpLSPUmc6tvSNExjJpeAFTG5reT/ZaeZKjDMSIPzKbyDKpL/bBD/HrTMjXsIZhbU1y3K
         FYD90KwebyboD+Ujq21hFFZC5j1Y1NHe7JxHuosMqy8OXzPK2W5mBmtEuzVKUssnCCrW
         wDoQmT4bEwiTNSwEmFhE4j7irnfQGSpA9vCttowP3pcDKCaKBo4TPIG4cTKA3MaXyiTo
         x2Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742373586; x=1742978386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5QTQG6QXfisCPA4xpu3CJSfWq5SgqopsiydmqFxhNgo=;
        b=uI8cT3NRwuIbEtutZJ/Zz+0MzysZcFxPdkzb1FAt61BRcitNC1XmRvxu7tcVWi9lDi
         oUX1CQl9H2/hJ63mJ6NKZRG15eTYtXN781+hHNQcwb28a0h0t9rQNFMkerVIlBUR30vt
         TXNt71sgX9E4pMO9TjAAUimoNslddLZWkq4Ryej49WSa566iyZA7YwrbKdn081PdBCGp
         ycmR7ftoKaompGK8fqQOOEmbmSx7Q+q0nJrlZkiCKFenuSLXKoGmseZ4ITjDx+xVAkux
         oK4rZ5vLFkNwemhEK7te5RcwOf5MSqVXTG7CrB4wPbO8/SaR0/KZ7IQN/+/S2I34s0Cb
         FfcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhM3rBng99T3FAzSGreQrKA5wuEguahPSICZBtByaS9oJpTNxwR5jpqlvS2FbatF/V7FvT3HcgaiMLv0h7@vger.kernel.org
X-Gm-Message-State: AOJu0YzCeRwWMXXXI4T4MrvQZZS7erR3z8BrcQ1xeOSuTD2jOnMefvHx
	RIUcDEffBhARgzs/Uu4faI9eNgoIyZnoqKxJgbi20EoXQPZSPUnBgckuc4bleya2cBF+q/X4Kv9
	4Dk4FVvMX6FYh43oqWMS9Zka22TIVAz+F
X-Gm-Gg: ASbGncsNUrUpveYGmdbkfln5W+ekEfWxfcqEwxbpga4hWZfo1Hhao6I5A5VBnYDc9ux
	g/opXTjDR6xuTk7jLflnby+n2ciI+nYPmXI0jsF9bP77jz3AbAi+Cp/o6ZcWWpLpd3+882GukBj
	1SvqbnSWw26Eh2C/dOd6jibkbt+g==
X-Google-Smtp-Source: AGHT+IGOGSOCaM4ZUgIw0JRb+Mu9LQCE1DvzqnWAlhA0LMSqY9Fr5EONUqh9A4XOh8Oe0WfXCAvi+XTxrDmQJw3IfBE=
X-Received: by 2002:a17:907:f508:b0:abf:514a:946a with SMTP id
 a640c23a62f3a-ac3b7ddf56cmr197460066b.28.1742373585947; Wed, 19 Mar 2025
 01:39:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <61e45688-07e9-4888-855c-b165407b3817@oracle.com>
In-Reply-To: <61e45688-07e9-4888-855c-b165407b3817@oracle.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 19 Mar 2025 09:39:34 +0100
X-Gm-Features: AQ5f1Jp9v2XU4xLWlLN996oBPjn03ncOS8beJgm2SMxCfkzTA5AiH6PtMlFOEEY
Message-ID: <CAOQ4uxhcknKd3bA0FYqGyftweUOaEoR=oYzqHu_mvxn3p0AsYA@mail.gmail.com>
Subject: Re: [Lsf-pc] [LSF/MMBPF BoF] Request for a kdevops BOF session
To: Chuck Lever <chuck.lever@oracle.com>
Cc: lsf-pc@lists.linux-foundation.org, 
	Linux FS Devel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 7:21=E2=80=AFPM Chuck Lever via Lsf-pc
<lsf-pc@lists.linux-foundation.org> wrote:
>
> Hi-
>
> I wish to reserve a BOF session to discuss kdevops.
>
> I've been working on a proof of concept for running kdevops workflows in
> the cloud, and I'd like to give a 10-15 minute WIP talk on that.
>
> I know Luis has been talking with LF and kernelci folks about how to get
> community funding for testing efforts. Maybe he'd like to share a little
> about that or hear some crazy ideas from the audience.
>
> Other related topics?

I scheduled your BoF Tuesday afternoon near other testing related sessions

Thanks,
Amir.

