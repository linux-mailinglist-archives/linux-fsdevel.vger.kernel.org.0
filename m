Return-Path: <linux-fsdevel+bounces-16827-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB3F8A3508
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 19:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCCA9286DF8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 17:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E464014E2C8;
	Fri, 12 Apr 2024 17:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="CbL6TWIv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0B8148313
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Apr 2024 17:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712943808; cv=none; b=HGS068h1UVYFAKM3/0LvbA8Po5BuzjkzqvUwE6bjpTE3dHYFZP1ooVsc1NhhgfdKYHYqATBMSsdZFaBoiMaXLe5Kbq1nEf5hgQ0R6e/J6OkFq9Yik2fr0jWg/Wc5Sdp3IHCHtui0blLaxJFY15BhrhTZSqsm0ItTzcuXBsUcNrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712943808; c=relaxed/simple;
	bh=BDTZoNZVl2PCqBUJe9bYbdgMaaniF90lPpDoy6XNomw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pkCOKxspkFFzIvTE4muLI6JaXQ9n/tVe/I0NGy5ymQcfTsq4+TAFD39w6dwRd48h5EjT46s/0khozF1o6li0pDzMR67grwimrskkA+DWSmMccTE1GGn9q918HmRqEQh3tN2AW325y9lGWpClWwAssHzvj1yw4Y4m0V56UeE3dx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=CbL6TWIv; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a521fd786beso148676066b.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Apr 2024 10:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1712943805; x=1713548605; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Pghq2XHCUSd3iCPX6kNZHrLa4n2jPknvo2Vf4i7b6Ik=;
        b=CbL6TWIvN3McNIqmNFn0A9nMd5OqF30JoRS0cjrNXe126vz0OTXhhulr/MdcKXeHoD
         baDUZcleFWJqFSp5xyddHQmMR2xPtQELn+tNN1Xj95GEgKthFV/oSGUqckRZByDnqccA
         SJFHVvQgR3sFIdOUXg56B8juSgaHCw2FqFgu4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712943805; x=1713548605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pghq2XHCUSd3iCPX6kNZHrLa4n2jPknvo2Vf4i7b6Ik=;
        b=PmqhbRTqfqJIOvSvYKlIzeXb0zix4t9LSMNDz16rSK4dgc00j3FiMqdTK/jbx3Opmz
         VSDuK52ewodrcAzATZrUv3WWpyFW0FCGPKWyZsQYgf7iPBKr12Xn+Oflmlyjjmzya5ok
         /xH9T//qtY0x6lMeEyQcL8XnkdXKJnD1Mq70pVBAxP7gFakkS68UchF2ZwsJQNaPNqIx
         NngJE/3KwfYlpowSj7uJa+Ngnap+E9X9we/pf4b6qkrDxd991EJcoF9QeMdLAb88hcrB
         GKuocieQ2efUi72VH8lN9XcaAgiA955NXc/f9isWXQPr/YKHMarRpAESMS/navdUUQAs
         TKlg==
X-Gm-Message-State: AOJu0YwfF6O1lnNx5v4FxZjC+5oD0mz3XK0RiQ1kqwf4Aj+BlnkWF+r0
	0TniRWJDIynLBsNh1aXOPtCtHMwfyafUoqvrRyqEtkyD34XSwmcjirPc7khRkQyLC/O8K3eroBY
	1etfluA==
X-Google-Smtp-Source: AGHT+IFHiVHZgJHdkz1jqyPuwi3iCC6C7V/IPC7729k4Y9/dbVaTnx0g+tO2pOSRbdl0BqCIQibF/g==
X-Received: by 2002:a17:906:1685:b0:a52:434e:418e with SMTP id s5-20020a170906168500b00a52434e418emr331502ejd.9.1712943804682;
        Fri, 12 Apr 2024 10:43:24 -0700 (PDT)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id dt3-20020a170907728300b00a4e23400982sm2057961ejc.95.2024.04.12.10.43.23
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Apr 2024 10:43:24 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a521fd786beso148673566b.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Apr 2024 10:43:23 -0700 (PDT)
X-Received: by 2002:a17:906:755:b0:a52:2441:99c with SMTP id
 z21-20020a170906075500b00a522441099cmr1872379ejb.69.1712943803548; Fri, 12
 Apr 2024 10:43:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411001012.12513-1-torvalds@linux-foundation.org> <20240412-vegetarisch-installieren-1152433bd1a7@brauner>
In-Reply-To: <20240412-vegetarisch-installieren-1152433bd1a7@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 12 Apr 2024 10:43:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiYnnv7Kw7v+Cp2xU6_Fd-qxQMZuuxZ61LgA2=Gtftw-A@mail.gmail.com>
Message-ID: <CAHk-=wiYnnv7Kw7v+Cp2xU6_Fd-qxQMZuuxZ61LgA2=Gtftw-A@mail.gmail.com>
Subject: Re: [PATCH] vfs: relax linkat() AT_EMPTY_PATH - aka flink() - requirements
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andrew Lutomirski <luto@kernel.org>, Peter Anvin <hpa@zytor.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"

Side note: I'd really like to relax another unrelated AT_EMPTY_PATH
issue: we should just allow a NULL path for that case.

The requirement that you pass an actual empty string is insane. It's
wrong. And it adds a noticeable amount of expense to this path,
because just getting the single byte and looking it up is fairly
expensive.

This was more noticeable because glibc at one point (still?) did

        newfstatat(6, "", buf, AT_EMPTY_PATH)

when it should have just done a simple "fstat()".

So there were (are?) a *LOT* of AT_EMPTY_PATH users, and they all do a
pointless "let's copy a string from user space".

And yes, I know exactly why AT_EMPTY_PATH exists: because POSIX
traditionally says that a path of "" has to return -ENOENT, not the
current working directory. So AT_EMPTY_PATH basically says "allow the
empty path for lookup".

But while it *allows* the empty path, it does't *force* it, so it
doesn't mean "avoid the lookup", and we really end up doing a lot of
extra work just for this case. Just the user string copy is a big deal
because of the whole overhead of accessing user space, but it's also
the whole "allocate memory for the path etc".

If we either said "a NULL path with AT_EMPTY_PATH means empty", or
even just added a new AT_NULL_PATH thing that means "path has to be
NULL, and it means the same as AT_EMPTY_PATH with an empty path", we'd
be able to avoid quite a bit of pointless work.

                  Linus

