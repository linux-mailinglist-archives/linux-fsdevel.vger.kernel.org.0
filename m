Return-Path: <linux-fsdevel+bounces-13633-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1EB8722CC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 16:30:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02CA81F23E87
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Mar 2024 15:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7DC1272C8;
	Tue,  5 Mar 2024 15:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="X6HPIqca"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923598613F
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 Mar 2024 15:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709652611; cv=none; b=mpf9QYNkm4m+4bThicFagzrXRNjeXOhTZ+il4ga1YSevFhsjDzepuw0JGDEXJbp+PY1EHJarXZsjGENv9wpRCus8GdTxHRoCn5lDXkpOyQtHMjVWjEWKwddiwuQjtQUCtoxFkaE3+MTGPItjdTKfDI95valOO+FmdlzggUTzW5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709652611; c=relaxed/simple;
	bh=i4L9yTP7bL/nH6Pe5z/YW+H77sTGLoCZI2eMscCYsjI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qr06p6ZDleno5fGMpg86TUt4JGNouaZ0qhc8wMz5mLVZTGqOqVxpxhNJx1VBCXaLk3CnVzOQkS4g0H8H0sZLT2k3TgnCoFIhdsMbh5Nb2GN8zdIrWuxvU/t4WEorRy7Wjf5nhueaS/hA+Cd1hHtxGbA/No1j9G4ljMIIhZ20ml8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=X6HPIqca; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-512e39226efso5763768e87.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Mar 2024 07:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1709652606; x=1710257406; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xngdhB1LOUGLtRO/ArgUCnVwr9HPZIX2xEzxsCvvQlw=;
        b=X6HPIqcafHSzwgkbrHvYtXjCADqexzhjyAD4NZDKWl71NQ3DGN97MVmay+YeikIiDI
         lP8dQ+HptLCAVUVYu7/UOCiVXTolAFG8bdDrtoH41w2Lnj8pfkFnnKbXncqThX8x9ghv
         NDvUzk9brjCqKS87wzdFG71Au78wV7B3N81kQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709652606; x=1710257406;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xngdhB1LOUGLtRO/ArgUCnVwr9HPZIX2xEzxsCvvQlw=;
        b=CIb1fRtRiHFOPYry+Ub+/XEeLSLOAfyAqgoVlb6+hLWXxtcWnkzNcfwnBHrb7X831d
         ELEIOGuMFDddDR1WGIPIGyXfSxzpahnP60DOokrXGMXjaGKx5j3zbB4lBgR40mdpzXAL
         LsFXNOp+nS0pJXl12xRxFbzUfB9+OW94/nud1r5x0dXdv1D8s3ZOdqyMYFGSmrzSPLiG
         i2EIc49cZZdVjIgCrcD0t+Wn1uGUdVoBduIJJTAkrfIQUdjyMU7VTQy8fRY4gOtdR86H
         QJsEV1apUTO2UJ4Dt6itHlFO09SX4Z7fYSK5+7SfI0Aj/4UZyS8rGu3wNClkuxqvYZ8Y
         og8A==
X-Gm-Message-State: AOJu0Yzkmpvi/3y4IhVkc8+1yLXFTLFqt7DO3AGxr7+zHr6EDOOpBj2e
	WfStry5uM09CW/VYrFKKecinDcMQR+MJsnXtJNJ2hddTRrjQDEeWmC+bLUjbIlD2f2SpsJeRqHs
	+SsYWa/gPZX9cBEdnDtGy2GLVAXWtBwfRyFatTw==
X-Google-Smtp-Source: AGHT+IH5ONANGCBqBEkLzzc2UykzXUKYI1XmYS4bkFpuRD4zcwGXsHw/6zY7DG4ky1lgJz8aoNo/LastKC8006xz1Dg=
X-Received: by 2002:ac2:48b5:0:b0:513:4f60:82bb with SMTP id
 u21-20020ac248b5000000b005134f6082bbmr1700386lfg.13.1709652606623; Tue, 05
 Mar 2024 07:30:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240109092443.519460-1-winters.zc@antgroup.com>
In-Reply-To: <20240109092443.519460-1-winters.zc@antgroup.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 5 Mar 2024 16:29:53 +0100
Message-ID: <CAJfpegtFeOu+znsX6g8or6i47C6xE6Y4MEAhkfLU4uAxKbsY_Q@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] fuse: Add support for resend pending requests
To: Zhao Chen <winters.zc@antgroup.com>
Cc: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 9 Jan 2024 at 10:24, Zhao Chen <winters.zc@antgroup.com> wrote:
>
> After the FUSE daemon crashes, the fuse mount point becomes inaccessible.
> In some production environments, a watchdog daemon is used to preserve
> the FUSE connection's file descriptor (fd). When the FUSE daemon crashes,
> a new FUSE daemon is started and takes over the fd from the watchdog
> daemon, allowing it to continue providing services.
>
> However, if any inflight requests are lost during the crash, the user
> process becomes stuck as it does not receive any replies.
>
> To resolve this issue, this patchset introduces a new notification type
> that enable resending these pending requests to the FUSE daemon again,
> allowing the stuck user process to recover.
>
> When using the resend API, FUSE daemon needs to ensure avoidance of
> processing duplicate non-idempotent requests to prevent potential
> consistency issues. The high bit of the fuse request id is utilized for
> indicating the resend request.

Applied series.  Thanks.

Miklos

