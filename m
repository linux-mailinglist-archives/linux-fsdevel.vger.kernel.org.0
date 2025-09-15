Return-Path: <linux-fsdevel+bounces-61363-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AC98B57A81
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 14:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 823493AF3D1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 12:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB69307AD9;
	Mon, 15 Sep 2025 12:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="J9Ek2QUW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A6A307ACE
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 12:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757938859; cv=none; b=uwLLubZa1lzn0IhDwVBpbjAy0bfmHhdnFIZAOpgSfZWEEoF3KuSV4masNUxSTEYn8+OKRHYqgV43V2J08WcrtYBNyCfyDv4wpdFiQBxJ9I4RCcTws4rdwc0lIw6KKALubrEjFSu6Og9BSAuub1ZCQY/jsOwKhHjPuZqIxOieIiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757938859; c=relaxed/simple;
	bh=SxvSC75+ai5wusFs+sP+EiB6Yy9GbCpqBh03EztSLnM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CYVxH1T4dhA1OJkFEvRrqdPgInEWEq/0XvAunP5RHGAuqKenXuz0tCtLoXaohPyY8+TmNG2mOBZg7XJkaefOv2j5/xEDD9djySrdbhELCrosAXWp8MfSE6cWVOIWuM641+DfO/tPsRRVO8XhXEXa6dCqEtS75sltu62tbGN0sqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=J9Ek2QUW; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-352323388b6so23423891fa.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 05:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757938855; x=1758543655; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SxvSC75+ai5wusFs+sP+EiB6Yy9GbCpqBh03EztSLnM=;
        b=J9Ek2QUW6tDBZIHRKFNeWWaaRM6hgO8mMAKEEFw6P4yjmgP0rhP9ERsqisZpSZB2vJ
         4cFYptTHG8jZA4+UkWkyu7uoSiGF0XyQ20qOFH4QX5jhzdtU8lO+Oqc8/bNq3KKDhk9U
         WNT9++r5sHILcRd74E6oK1G7fC5xw2Ozcumli4zpO1pEEDXx3fKl2+0v7XmcsMvd/98O
         CmP5axfCTyiCPdmyALQTavqD18NsYmdxN+84s1Vn2OvhC8N9KBNJL09yFCVy9W/jpzO5
         8bbRgxzkE8nDU8tOqYfpXNzVjpGxAnNqYhGs+dh+GIn6uGY6zi9Cx+IV7ZkRQcYDoS5/
         YjGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757938855; x=1758543655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SxvSC75+ai5wusFs+sP+EiB6Yy9GbCpqBh03EztSLnM=;
        b=EzZts3MeSyP+rBf3bWhmjjXRQhFd9r+lAuCiZsfR9wd/VBH1EbHrYgHZAGGLOuhJrc
         Io9O001PLdccR1PmTS00FhH/H7qtzDO7/8x/b6fNfGsQzy1z3BXYT0EUoislxdlFamDv
         hY/Ot1VeSr7L11gxS74K+7soL44AdBf4XF/5naBzyqccuT/LPex9WWrvxdCWmFSZGPGS
         ZxKLHnovDkKZbLEQJigJC6HHoaV1279pbceMBXoE1Fger+XX3tpv/e0YnSiQ/HzMACZf
         7vzcJgiWooQRuXAndrn4SazwKCInkuX21TEdHmaic8o8jiZpnEGP4AqGajHXX8PRcjze
         U2Fw==
X-Forwarded-Encrypted: i=1; AJvYcCVaN94uZLIL3SmuKXTkvWYtOYaiyNLAQEg3ymm3XyPIwsLwd+EKxJpdRwJSIweg7NH77/k9yqGjMQ0QZVjn@vger.kernel.org
X-Gm-Message-State: AOJu0YwbpElhUflNkP8EoGoG6Mo1ZkqGPXFrUicSZzbmY7PCPqtL9+ny
	M3D9dRyRc17iQF0dWmfqa4b5LrBOlVP69zorOYu9fbHkP4sH/6j42sIwiqGyJ7qzOJKX6ouW58O
	XRnqrQjint00ubHwhmkU70B3XqgA2vfO0E3KK9439GQ==
X-Gm-Gg: ASbGncvD808EJZZ0kbodQRdcG03Y1cGBnQd1f51DZ6FBMfk0RxA0iN78o7XqZk39sLA
	upXa4b13AVPzulWU/v411R69jFzSQQHrZ79SqzdZYhwEHvXV10mnumb08bV41vf54xtjQLS0nbq
	teJJm1icRI6VppMANOtQHy5Q2qjE1RNihuFLoXJ2uaRjPArclGsnfF5SVyx+CDiJygS4lADxlGY
	A+tF9n7nhkmjO+Huy/DaE+Ia5E8SFYhg40FJqK650zcw6bMdqugvSW02dbD+w==
X-Google-Smtp-Source: AGHT+IEmnxbeEtgOtDLw2NgOQcwtopUOpi5G2yCRmnyfo2ld0ixRQb3kYGv6XZEeEeUDrjZjp8OP35TG4vLNeTrCZVw=
X-Received: by 2002:a05:651c:4355:10b0:338:53d:3517 with SMTP id
 38308e7fff4ca-35140da7e0bmr36430511fa.33.1757938855373; Mon, 15 Sep 2025
 05:20:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905090214.102375-1-marco.crivellari@suse.com> <20250915-abgearbeitet-servolenkung-d0c60406b94e@brauner>
In-Reply-To: <20250915-abgearbeitet-servolenkung-d0c60406b94e@brauner>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Mon, 15 Sep 2025 14:20:44 +0200
X-Gm-Features: AS18NWAvbZYrgBGn8tKMf_pIKrTNfuKWU5DLdSvRtq1XfhAg-6v3KzP7FlMTOHo
Message-ID: <CAAofZF7XWnN1Ozx8LLFtnnsNs=8WV7KZ4vFahK_KoHsVMredbw@mail.gmail.com>
Subject: Re: [PATCH 0/3] fs: replace wq users and add WQ_PERCPU to
 alloc_workqueue() users
To: Christian Brauner <brauner@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 1:50=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
> What is this based on? This doesn't apply to any v6.17-rc* tag so I
> can't merge it.

Sorry Christian, it is still based on an older version. I will rebase
and repost.

Thanks!
--=20

Marco Crivellari

L3 Support Engineer, Technology & Product

marco.crivellari@suse.com

