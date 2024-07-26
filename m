Return-Path: <linux-fsdevel+bounces-24338-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DDB993D79A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2024 19:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FB401C2311F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2024 17:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7340A17C9F3;
	Fri, 26 Jul 2024 17:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="WozWHB6T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF4E21364
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jul 2024 17:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722014990; cv=none; b=DBh3I0Ec8GSm7FGtEV5Ry+JjuK3IsFqL8lBpl87EGGOcV+tKo6n2Ax6J64a8VG09+qKp7kFpM4Dp1wY3buzb2jzjirP3Y63AGIag+ZwYsFB6JY4ChwDTA9acwvpPOrgvpqziuinDrun6KGrARxJ94YWNG19T+HwTXSNO9PdguFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722014990; c=relaxed/simple;
	bh=S1P5MgKMAMUuvhX8/9wDrx+JYxisvWaAYv7Gkg3E/m4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KFAZ3EdpsqJAPTwkmkzVoKP1wXfGHnn4Fbpp3dbxYGuDkmumtwYqQkk2ZWSU6hcOiGZvXqDbXWPfKpFvNSuHIPM/GjyisCm1Fjmn+2QmzNLsP6KZ/BWFJxZVkRSaXVLtZKbW/EyghKjWx/BYKlyN75lK9tCVgazOclqcrNESJKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=WozWHB6T; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a7a9cf7d3f3so209889466b.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jul 2024 10:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1722014987; x=1722619787; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DjZxgKP3aOenYjaNo4PQDBRvFtkEaQ4AGQRhMtdBU3M=;
        b=WozWHB6Ttt563lfMxtcBoC3UBShUMGUc/TJGpGDVvltIJ2jMs4tOLCWSmDU10YU4F0
         3mSvJw2Ll1ENAx892xcOPEW9K+BoE+2uiE8Jro32hSXfSEHPnLjoZHSQWiDNe+hShPqv
         Zep1Vt/t+ZjM+4tDtpImeCIuGnNEuGwu3m1hk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722014987; x=1722619787;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DjZxgKP3aOenYjaNo4PQDBRvFtkEaQ4AGQRhMtdBU3M=;
        b=UWQ5BhkDZu8QC8GdQphwxCPQZX77zpz6MFaWHpZWklx8JNdKvxkHX5ON0kKN6zswLl
         491byLzWXH6EbF2cqybv4xB7UACDrKW5FXZsd/UnX3YYEpEj9Q3yq/zMy6Blrws0NUjA
         Di++ztpUGtqy1YHFSVUsWV0+i5y2FqG2/Ioe+Fdjp9QMlPnRlnaF5nGCRIZlkzQUKPKZ
         3O1O4a689VBoRshtTinNZWJJWyyz2viTBnJOo1rFgP4G6JatMx7lcRrxIGUorf2tc8Pv
         7nMknIwb9mNRQG+/uxVtefkfRmM4zcKj8JK5epyHTZhhPtYBjfFPbv/DAPf2WTZ51TLq
         8+Xw==
X-Gm-Message-State: AOJu0YytiopCefvQN2x/YmuZYbNmtCeYl3dzLrt0aCO8+Jo0xuIkXt+Q
	fyYueLjAaurQiMtpzaujd4p20kUUfyEXZBOBT9o7YB8JecWOPhp6Hww6Q3QqISFaNQoMEE26tWj
	5gE8=
X-Google-Smtp-Source: AGHT+IGtkmCWQM4r2qgqydaVhhVKu8GNl9BdWOstdzQnmI3LoBXQox+Q0wkj8T4jlWXT//pKPs9NRw==
X-Received: by 2002:a17:907:3f1f:b0:a7a:a4be:2f9d with SMTP id a640c23a62f3a-a7d3ff57b7cmr17419966b.12.1722014986786;
        Fri, 26 Jul 2024 10:29:46 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acadb68c2sm197884766b.190.2024.07.26.10.29.46
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jul 2024 10:29:46 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5af6a1afa63so689803a12.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jul 2024 10:29:46 -0700 (PDT)
X-Received: by 2002:a05:6402:5205:b0:5a1:e7e6:ce37 with SMTP id
 4fb4d7f45d1cf-5b0232814d2mr81455a12.26.1722014985942; Fri, 26 Jul 2024
 10:29:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240726054138.GC99483@ZenIV>
In-Reply-To: <20240726054138.GC99483@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 26 Jul 2024 10:29:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgjQOCqchHsohSVPmgqwJOTvZR1RbxAH9efY7_AZunRXQ@mail.gmail.com>
Message-ID: <CAHk-=wgjQOCqchHsohSVPmgqwJOTvZR1RbxAH9efY7_AZunRXQ@mail.gmail.com>
Subject: Re: [git pull] (very belated) struct file leak fixes
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 25 Jul 2024 at 22:41, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-fixes

Well, it's a signed tag, and it's the same key as always - but that
key has expired, and a "gpg --refresh" doesn't find a new expiration
date.

Can you please make sure to push the key with new expiration,
preferably far far in the future?

            Linus

