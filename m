Return-Path: <linux-fsdevel+bounces-16746-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF19A8A2009
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 22:22:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E97961C22345
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 20:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC94E17C96;
	Thu, 11 Apr 2024 20:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hHRm1QLg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63453205E1E
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Apr 2024 20:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712866968; cv=none; b=MjjwFu9evajRywssWsOPsOfpox0lFqBTZ9OQIAGMU4VoFlFSnK/dHykjG6nnG+zfr6MmZdccPA02oZG0Aw8QRmLgSnHrtovBYKq8YHdqFzs8a3IEMmfC1SJ/Df1+K3U3v+xfBAYVufn/ZOhwsjbqJ8RWxyrfPuj0gOvbod7Is/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712866968; c=relaxed/simple;
	bh=dkOu2O8WzCBJ47ChmxIx9bdrhdZhytLJzKX9YJkD1KU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AvCNPbPFAtnQE4J9uwzRZ0Ww8E6v22M20D7a6yVQ5ju5LuWHo1krc227vFjVklUIyyTQtazkngvC4MKxy9G/VFQOQLyeEWXxuIgSTHyBv89kPhh7s/BLOwreO7g51Nv/7PsZ+tEF0FaRWbNkyDs5I/2uk2RT97UCbd85DGTAjqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=hHRm1QLg; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-56e6a1edecfso276389a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Apr 2024 13:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1712866964; x=1713471764; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=u06VN/tWbKJg/XvyqgCGuqCQEW3Uw0o35DW++ROLCwY=;
        b=hHRm1QLgJYhN5hqPoU6wcr3zOPSMzRUcl2BFMYTFUku4q0HMJUICywNWZ5n4/FWvft
         MuoMG25eRpRHlYgFelYMvCkqYsg2aeU0eKhGtY0bwFzOEK+grEL5IZEjSDBALoYqviEC
         wyHCqwJTBlT93zw3/edJubsNxde6amd9r/B4A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712866964; x=1713471764;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u06VN/tWbKJg/XvyqgCGuqCQEW3Uw0o35DW++ROLCwY=;
        b=VZ8meDqgyhvyziVT/lw4B+E59WtqnlvpU9onzjVdusqE84XE7RM2wnhvEBNgMYyqWL
         IGyALVoRcJyc+EKWp7nuqaT7RMdLLTbI4lgtQoBvE/pFYDGgCEQxUtZhgKpLORxurNNB
         gjypKAwHmJGrLak69gMTKn+lU2rLF325D5b7lDbDFOADQ6JixFYda/apMrN2uoVDS5+n
         NVsBb0dnlTJdhEq66cocrO55YsZZIom9KJFslk5AhhehdjqkUzu0ukh+GGAoBOOvEfhG
         N1W10hbl2Uj61jykDemWwGoZ19bS0U1+8j/ZdHv+BRdGl69TlMdGOZVcMdKumIDVAUNG
         sGPg==
X-Forwarded-Encrypted: i=1; AJvYcCVx+CMGOVzgyJlVw03XmNu6/A1cQ6QMC93lFD5tIj2+MQVHHIxNdvuR2cRq9pjL1tYwOT7TmaNdN2062oST7cai+7aYJV+MdFltcWNE7A==
X-Gm-Message-State: AOJu0YxAqgiwHHB1HT2eJgiIZaFLZoOSsp10sSigXoixSjvEvqn00AXs
	AZ5GAfoMctncC+Z+GQvLZdlqxjfx/oHWp3f1niadPmBmsuaI/B7Q4UFP/XzEf9wPopitsyX4ysX
	RM1LMWg==
X-Google-Smtp-Source: AGHT+IGwA8VQkVqbc5gV+cxeZV6BssaOwFxJvKN45iFXSMY6vLKnwe8MfZsty9EUY8ZDoBuyfWhXqw==
X-Received: by 2002:a17:906:4086:b0:a51:cab2:e55d with SMTP id u6-20020a170906408600b00a51cab2e55dmr486979ejj.15.1712866964503;
        Thu, 11 Apr 2024 13:22:44 -0700 (PDT)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id ho33-20020a1709070ea100b00a5231efa9afsm114002ejc.58.2024.04.11.13.22.43
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 13:22:43 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a51b008b3aeso21394566b.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Apr 2024 13:22:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVfhxOT4tOji+u3GPGHWSJY9xTiyJSnvcliKxLgHuc8k507V1i/HX9agypUECOK68tKdfJe4zpK3WEYkrk8U73hBJJhlOJvSW1Cyd0usg==
X-Received: by 2002:a17:907:9725:b0:a51:d1f6:3943 with SMTP id
 jg37-20020a170907972500b00a51d1f63943mr537096ejc.56.1712866963123; Thu, 11
 Apr 2024 13:22:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411001012.12513-1-torvalds@linux-foundation.org>
 <CAHk-=wiaoij30cnx=jfvg=Br3YTxhQjp4VWRc6=xYE2=+EVRPg@mail.gmail.com>
 <20240411-alben-kocht-219170e9dc99@brauner> <CAHk-=wjrPDx=f5OSnQVbbJ4id6SZk-exB1VW9Uz3R7rKFvTQeQ@mail.gmail.com>
 <CABe3_aGbsPHY9Z5B9WyVWakeWFtief4DpBrDxUiD00qk1irMrg@mail.gmail.com>
 <CABe3_aGGf7kb97gE4FdGmT79Kh5OhbB_2Hqt898WZ+4XGg6j4Q@mail.gmail.com>
 <CABe3_aE_quPE0zKe-p11DF1rBx-+ecJKORY=96WyJ_b+dbxL9A@mail.gmail.com>
 <CAHk-=wjuzUTH0ZiPe0dAZ4rcVeNoJxhK8Hh_WRBY-ZqM-pGBqg@mail.gmail.com> <CABe3_aEccnYHm6_pvXKNYkWQ98N9q4JWXTbftgwOMMo+FrmA0Q@mail.gmail.com>
In-Reply-To: <CABe3_aEccnYHm6_pvXKNYkWQ98N9q4JWXTbftgwOMMo+FrmA0Q@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 11 Apr 2024 13:22:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjTm-WVoQNnG933Nc3xfup-XrLWJ2d+Y4c-f-3b6ya3rQ@mail.gmail.com>
Message-ID: <CAHk-=wjTm-WVoQNnG933Nc3xfup-XrLWJ2d+Y4c-f-3b6ya3rQ@mail.gmail.com>
Subject: Re: [PATCH] vfs: relax linkat() AT_EMPTY_PATH - aka flink() - requirements
To: Charles Mirabile <cmirabil@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andrew Lutomirski <luto@kernel.org>, Peter Anvin <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 11 Apr 2024 at 13:08, Charles Mirabile <cmirabil@redhat.com> wrote:
>
> The problem with this is that another process might be able to access
> the file during via that name during the brief period before it is
> unlinked. If I am not using NFS, I am always going to prefer using
> O_TMPFILE. I would rather be able to do that without restriction even
> if it isn't the most robust solution by your definition.


Oh, absolutely. I think the right pattern is basically some variation of

    fd = open(filename, O_TMPFILE | O_WRONLY, 0600);
    if (fd < 0) {
        char template{...] = ".tmpfileXXXXXX";
        fd = mkstmp(template);
        unlink(template);
    }
    .. now act on fd to initialize it ..
    linkat(fd, "", AT_FDCWD, "finalname", AT_EMPTY_PATH);

which should work reasonably well in various environments.

Clearly O_TMPFILE is the superior option when it exists. I'm just
saying that anything that *relies* on it existing is dubious.

              Linus

