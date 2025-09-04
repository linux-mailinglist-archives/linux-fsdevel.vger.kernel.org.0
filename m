Return-Path: <linux-fsdevel+bounces-60275-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 045D5B43E03
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 16:05:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB0AB3B0DB5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 14:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D09E2D6619;
	Thu,  4 Sep 2025 14:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="XA+MeHor"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8117302779
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Sep 2025 14:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756994707; cv=none; b=XEmFQGy7mIc7fWsYxPxKCqfvsNCCf39raFDV0A1emKXyEl9vviLqhqx9sPYHtunx6aR9NjdAGy9YwXSu7ZEQikRLF3PkTVabc7XEiYhzaCyqw2Vuqio1wNNlACwnRaGo9tdHJLh29mUIorUVOmiyzBPeE2VoqdaQU8Ke00hFhKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756994707; c=relaxed/simple;
	bh=NH3pRJWbbMMoKdkhANuon2vALhDBD6vUUr5maVOAnmo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U39NhHy0oDKORuqCgTWodvE2PWYXIC6ptudb0E+qvoBWXZMyTzKEm7RJ3Pqd6L8f/lXvRuyAbcYZC6jR4r/TKzEANGPSy+EFSCsi3xDwpG3a0cj/Ve8NW36n0dIEdUAF6q3c0AfgGMcA5u3/7u+BoQlnmyM8iJl56w6mfk/ezVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=XA+MeHor; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-80b7a6b2b47so105618385a.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Sep 2025 07:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1756994704; x=1757599504; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WSKdBSa4KmynrHY8Qu2VnCd/it/OXIoX2KckECp8XuY=;
        b=XA+MeHorY1gLNXpKiXDTpfS0/V32JkyinaMHdD1U/TCd+srH4F42EoQiJMOP+dwgUi
         kdlGFwX1tPDYmv57if95I3i0PTE0ECk0uy+G4KkDRILCiOQ46P3gTts0HmeQzjq1KMb7
         0zLI0D5nB75ayFPo/g6kmjk6kEtG3HzLfK03c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756994704; x=1757599504;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WSKdBSa4KmynrHY8Qu2VnCd/it/OXIoX2KckECp8XuY=;
        b=NRwerBfG7SmXhUwvRDMbatKim9bqhdLG4ROv6CswST4X8NxYODJc8k79x7AG9kuMZh
         yMe3GS0ZzxWRxWRn4Z5Ii8+oAfPPDYtyTUpRePpMSb4lOw4hCHykuUIGXmLSXFbH3QHy
         qVj2HqhXwI8TL2pwFvB9oApsa9nWFP0c3ddJ9iJthTmbXcTDJFww86ZRzowCawqxzaxe
         udvw0uZOM7qF5IEwaFlTZz8OgqMYM3MvA/IizqLZOqTRySzwSDslycVhGY+RxcuPmMsx
         +jtv20bsmncuQ7saRHGfx39yjN+j9z4fixeHMDho2Ef6sJ+xrgf9bQqlHI37SxJCQSS/
         xZtg==
X-Forwarded-Encrypted: i=1; AJvYcCWfqp5PicKtXpoHcTgmM68jrqLw3W+mRpq1xCPDpO2bf2YwNqqi+VQSKXGwFkK1KZackCVc/RAUP9mRCfp3@vger.kernel.org
X-Gm-Message-State: AOJu0YzVnkYZkEjEWqLthd4jMZW/11sQI2YecOmWtIqRht8KPOvQMGWj
	X7+rCDPTBCoa253oeivAVYIRvNR+eqjJhYzRyM7N+KBoCbQPZxEqhn5eV00eWoVObU1dwL6zohA
	UXPDGLef4wypUrBxoZcVZ0a2uzJ8Cjp+OBKq0n7UHSQ==
X-Gm-Gg: ASbGnct7UGIrMOEWQ91qMjI1zGkVknwtny1TFF1r50FNJqVYxQQiIDZtE+LvEuNlfHD
	D4pBLRR2bWZWuRHgYf97j0M9tadxxLxMP6KO/dJr2+CZTKnEqfo6BxZEvymEMXm3uxttF2LXBXy
	fju5JsmHpErdHiZ3BjAehjscmFA763jLHELnxPVb3DjklDz54iej9TawV291rh3yIo3/saC00H4
	+ICdiFaMqIa9VFYZHOI1WCjHh1OKTUuW5Gg0H+2sjKxy13RfGHNJqLSVOdFwp8=
X-Google-Smtp-Source: AGHT+IG71nDWsRW56ZRy5ss0TCyvJZQNME2l23Pl20sqWpuNQtHb8B0JPpOcoTau/Yd4DQQQN642bey+4lqysqbouJA=
X-Received: by 2002:a05:620a:7113:b0:803:7023:36a0 with SMTP id
 af79cd13be357-8037023389emr1855498485a.65.1756994702831; Thu, 04 Sep 2025
 07:05:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <175573708972.17510.972367243402147687.stgit@frogsfrogsfrogs> <175573709157.17510.2779775194786047472.stgit@frogsfrogsfrogs>
In-Reply-To: <175573709157.17510.2779775194786047472.stgit@frogsfrogsfrogs>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 4 Sep 2025 16:04:51 +0200
X-Gm-Features: Ac12FXxhHAMi4yutDl5k9ANM9nhdms84jFeFafwfi9X_urI0ihIRhmJq7npX5Ek
Message-ID: <CAJfpegsUhKYLeWXML+V9G+QLVq3T+YbcwL-qrNDESnT4JzOmcg@mail.gmail.com>
Subject: Re: [PATCH 02/23] fuse: implement the basic iomap mechanisms
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: bernd@bsbernd.com, neal@gompa.dev, John@groves.net, 
	linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 21 Aug 2025 at 02:53, Darrick J. Wong <djwong@kernel.org> wrote:

>  #endif /* _FS_FUSE_I_H */
> diff --git a/fs/fuse/fuse_trace.h b/fs/fuse/fuse_trace.h
> index bbe9ddd8c71696..2389072b734636 100644
> --- a/fs/fuse/fuse_trace.h
> +++ b/fs/fuse/fuse_trace.h

One general thing I'd like to ask is that debugging and tracing be as
much separated from actual functionality as possible.  Not just on the
source tree level but on the patch or even patchset level, please.

Thanks,
Miklos

