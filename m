Return-Path: <linux-fsdevel+bounces-60545-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 945CAB4922D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 16:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C9FB188ACFF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 14:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E712130C62E;
	Mon,  8 Sep 2025 14:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Mb1Uo9Zu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1719312DDA1
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Sep 2025 14:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757343503; cv=none; b=LkOICHoKCgovFcokFWAL4kfY9UGV9J2rWHPBziN3Cbf6o6Yn0mnLgBdcdXNJqo8gfUIP/UnqIozhFAA6Rt1JDedDgVSV2VyJw37ftj14dczDqtJ81gcAbRDNkAS0eUPArKjoBnehmLUIb9BUokDb7+Wy2cYEXmRl+HVfE8jUDhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757343503; c=relaxed/simple;
	bh=lF+92fwfgVxDorks0tO5XZOYN5o5gxVUZs63Bt3d5cw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n1to+4JCVAQ1WHqki0Dp8MCN28xtX5+SP1sa7MGYy2/RAW1EJ3TJpJuiwdEBSE+ruHB+BPinzZn+nA3LrtV6K2VOPBJXbkiClFG8I+XG8i4zKOSjM427tX2ci6Xn9wOhu82z5abEpsCNhKz0oojA8c22UU9rNYLN4bhtC5xRfrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Mb1Uo9Zu; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-61feb87fe26so5361610a12.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Sep 2025 07:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1757343499; x=1757948299; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3RMLRFrnPHMZ0VFl6Qxdfdx0T7fx+6aNZKVwjS0U42Q=;
        b=Mb1Uo9ZuWYYecoCno4wizLqqTzDkEQgjZOMMQnG4Ogx+3SIf8+JNxEuql89LPdRid3
         bY1JoHUu+0z24ofczodiqa84D0VPnEPTfjbvIcOsfSmS8cx77J0czS+Wc4reSeOy46ip
         xWs4KcPMaL/kyRiUibGKyvkqJdTV2Lqf1ZYLA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757343499; x=1757948299;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3RMLRFrnPHMZ0VFl6Qxdfdx0T7fx+6aNZKVwjS0U42Q=;
        b=UyqJsxQt4JVt2aCJqhyMnTytPEoSZXR6RoHu8Daz1AIgoOqlt7Bt3cmqvPWszgFqOK
         1l8w0mUUyvtgnAwWmnGSjgEFF0ezKreienV4bPntR2nA8Ldy32GU5qQzNOGtp4dWzfYF
         l/Yw2TkfcoZ6Ti0PeyPHszLsCYFkSEfYUdeP+fKnVf4loBDHYOM+YCFNJ+bDhGrrdAhx
         N6ZrtLi7bYNALS8xq1GQOng/aOk5oiJrX8S+pYXsdfLuUYN5rSMkbg1W9xXIXDJiH7+O
         7ZQPZNUYDZM/DTzP7K53XJXXBXR2dHjkoQ0MQKitj0UE5hCZYpnz17BSrVTfjYAySuWr
         16UA==
X-Gm-Message-State: AOJu0YwR7VXKls7zKts/sOKNVJqZINLpe0cJkrag9swy2Ik7/gKhwwKp
	F/28bFr6S2/OxdHldGpArbfjUrL1HRD5GrRnjOxJE8t5ALSCB1Rf1aGFbdRKgRNVaSuiBduhV14
	4IdBeh5s=
X-Gm-Gg: ASbGncvNz3aGLe9Se58b5ThwXYqJpD6tQv55FAaYrjA8ucyXU1bK4KFR/6cQrZJkP6N
	oaF8zJpwQf/Z+83Ti3+vO7XpMWFhTGDljcXeLTwrOJghnOcxaHlv+cDFGE/Dh07+4JqRhfVxR2A
	6oI/B2M93Gmf7IMn1hE7yvRRRnHgSMRQDfChJSvDrWTidYdvI6o41sMH5qr7bF7JZajUhH11PYi
	siWGXtL2LccFt8MrM63FpxWUvfUVgs3uRKQQ9b1bbgzYmkxFi5JrYrGRiXdkVPCkEejKaqxSM4e
	iJTFgxek9f/ELQGtEzsy+IFfQKUIwOrkV9YTUo4CjYX7DM/kX919THVd4OqDHJEk28Qdk+Wqdpf
	GrKhCFaif/j6GAEcYlfRIuVwrdQ6Gcn/be94m3mD31TbsNsQMqlnim+dnbZREdXA9fas9cPAXAo
	nNffhhMLQwx4EdM7Ib4g==
X-Google-Smtp-Source: AGHT+IFLVE/wdpD2S9/SLgUIBL5w53ZezA+vNrAHwVpm6XwSY1KoKyViW6iuGX6jA4f3U3w7yj1r2w==
X-Received: by 2002:a05:6402:5055:b0:618:528b:7f9b with SMTP id 4fb4d7f45d1cf-62378c0de98mr7281778a12.31.1757343499085;
        Mon, 08 Sep 2025 07:58:19 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc5622f0sm21776519a12.51.2025.09.08.07.58.18
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 07:58:18 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b046f6fb2a9so682329566b.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Sep 2025 07:58:18 -0700 (PDT)
X-Received: by 2002:a17:907:7f25:b0:afe:8b53:448f with SMTP id
 a640c23a62f3a-b04b1453dbcmr874541166b.16.1757343497621; Mon, 08 Sep 2025
 07:58:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250908-vfs-fixes-0096f8ec89ff@brauner>
In-Reply-To: <20250908-vfs-fixes-0096f8ec89ff@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 8 Sep 2025 07:58:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjutitpc0F8fyCcJhb55UT_sB_5dLNmtxDAVAwxsYSDWw@mail.gmail.com>
X-Gm-Features: Ac12FXxJC42sHTH1eY98TWco16_KITp_O1bkq650MzDTWXsl7jJWyl4wI3yEGYw
Message-ID: <CAHk-=wjutitpc0F8fyCcJhb55UT_sB_5dLNmtxDAVAwxsYSDWw@mail.gmail.com>
Subject: Re: [GIT PULL] vfs fixes
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 8 Sept 2025 at 02:46, Christian Brauner <brauner@kernel.org> wrote:
>
> the fixes tree was filled before Link: tags were ousted.

LoL. Considering that I've been complaining to people in private for
years, don't worry about it.

Nothing in kernel development needs to be _that_ black-and-white (ok,
the "no regressions" rule comes close, but that's it).

           Linus

