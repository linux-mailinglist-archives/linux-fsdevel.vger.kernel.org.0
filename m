Return-Path: <linux-fsdevel+bounces-2305-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 328F37E4970
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 20:54:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63DA71C20C4F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 19:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3178F36B06;
	Tue,  7 Nov 2023 19:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="eqc87QZV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D08210E2
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Nov 2023 19:54:22 +0000 (UTC)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD41184
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Nov 2023 11:54:21 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9a6190af24aso939928766b.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Nov 2023 11:54:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1699386860; x=1699991660; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VkTZWMBMLQYUtpSNuy5XagVZn8+B9GVBKFpPpKcdRS4=;
        b=eqc87QZVPahJ5XT4X/bPlLV4zUJeLeRzl6J2dEbou1ea6AHFYWBsbxxH1CDhUZ6o8i
         Wd5Ey7OgDOMl/bMQUaopkNI21jLpry+ynf3KydynFdrYMMnbp7fYm3Hvf3ASkRsY1MdW
         oJAcM9yQxI6kTCKCyA71oelrHy7qOPivLu6Eo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699386860; x=1699991660;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VkTZWMBMLQYUtpSNuy5XagVZn8+B9GVBKFpPpKcdRS4=;
        b=j0QWV9h5xnORTQYWEXErtfglMRqTHyVoNe13m3z5cUggxvBpYCq8xqSBKHVRqoNpn5
         qO0afdCzFJ/WLqNYs5gz96gI7MWUUTgkBGrglO6EVvlLa2xtKsnA//6gT7qLdbzV0PG9
         XBrC/75LKMoMIjZSSUTV+hTupY+CQu+ZPsCG2ygPyYxkFAY2yJ9iz2quYxhNuP1hydsl
         ZUQ02IU3bVZsPddLNuWlrO+Kq9hPBwbNqd9G3A5kyleo6Je+PrRqEsYZU//ZjNwuKhlk
         bgIlMxbaHDQYl0eQwnGSXjlC9nflj/rEStBhMh3I5978MALyTuDNSpJWfDfcawrPR8D0
         QkIw==
X-Gm-Message-State: AOJu0Yy5s0hxYY5mRhu2Coar+xatKxZc4D61tZREREsysnnORnxTywI6
	tiFoVcsippQP21Nv1bc/xK9m9IBH4nULqeCzRVA=
X-Google-Smtp-Source: AGHT+IEtcHeh67nHhepdzNEcxuTxR5oQPRWyM9YMMbHULgrq9tyNMkMFltBHIvy8UqJo9ASxosfqTQ==
X-Received: by 2002:a17:907:960f:b0:9c6:19ea:cdd6 with SMTP id gb15-20020a170907960f00b009c619eacdd6mr18760694ejc.50.1699386860172;
        Tue, 07 Nov 2023 11:54:20 -0800 (PST)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id bl6-20020a170906c24600b009d2eb40ff9dsm1413453ejb.33.2023.11.07.11.54.19
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Nov 2023 11:54:19 -0800 (PST)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5437d60fb7aso10283349a12.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Nov 2023 11:54:19 -0800 (PST)
X-Received: by 2002:a17:907:745:b0:9dd:4811:7111 with SMTP id
 xc5-20020a170907074500b009dd48117111mr13172773ejb.4.1699386858967; Tue, 07
 Nov 2023 11:54:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231106065045.895874-1-amir73il@gmail.com>
In-Reply-To: <20231106065045.895874-1-amir73il@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 7 Nov 2023 11:54:01 -0800
X-Gmail-Original-Message-ID: <CAHk-=whgCwcUGKvoZX0OSAFi9fTye3BOfOCY+wR=t7W8xS_oGQ@mail.gmail.com>
Message-ID: <CAHk-=whgCwcUGKvoZX0OSAFi9fTye3BOfOCY+wR=t7W8xS_oGQ@mail.gmail.com>
Subject: Re: [GIT PULL] overlayfs update for 6.7
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 5 Nov 2023 at 22:50, Amir Goldstein <amir73il@gmail.com> wrote:
>
> - Overlayfs aio cleanups and fixes [1]
>
> - Overlayfs lock ordering changes [2]
>
> - Add support for nesting overlayfs private xattrs [3]
>
> - Add new mount options for appending lowerdirs [4]
>
> [1] https://lore.kernel.org/r/20230912173653.3317828-1-amir73il@gmail.com/
> [2] https://lore.kernel.org/r/20230816152334.924960-1-amir73il@gmail.com/
> [3] https://lore.kernel.org/r/cover.1694512044.git.alexl@redhat.com/
> [4] https://lore.kernel.org/r/20231030120419.478228-1-amir73il@gmail.com/

*Please* don't make me have to follow links just to see basic details.

Merge messages should stand on their own, not just point to "look,
here are the details in our lore archives". Yes, even when having
internet access is much more common, there are situations where it's
not there or is slow. Or maybe lore has issues. Or maybe people just
don't want to switch to a browser to look up details that may or may
not be relevant to them.

I copied the relevant stuff into my merge, but please don't make me do
this next time. Just give me a merge message with the details spelled
out, not some link to a cover letter for a patch series.

             Linus

