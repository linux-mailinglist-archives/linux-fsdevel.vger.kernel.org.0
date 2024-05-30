Return-Path: <linux-fsdevel+bounces-20534-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE108D4F6C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 17:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FA521C23011
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 15:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 851C8224DD;
	Thu, 30 May 2024 15:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="QtgZpOEx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0F020B12
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 May 2024 15:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717084173; cv=none; b=V8VmClXRe8aIwksDYGEI3ShXAIJUfDIUcSW60HtGx+BdtmfnPHd6tazMugYHNRy0AnKlfVS78ai3hMlJG3p1BNNuN9ICbBre7nn+CK38FmKbX+OZscEEHV3CDRsyXsoC2tsSfDtnTwB7FdLYRpgSxRuwe3lGL4oJzf9hiAdmJh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717084173; c=relaxed/simple;
	bh=HQwd7oKUKBnI6aMJ6IxF4/V3sS4H19qX+AL1ZOmk6BI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u8qZZg15/7EAjMxJw5OJQdWA0gK7YJ2uJMYYr6YC9kOf6KMe7I+DTir7VLAqniOO8I+NO8Gr1zNA4W2i+ZtIafl1U0Khz1kKmYzZFW4uOwvG4BFJEv4t0HoDR6Il5w6oqg+sP38NxLKQmj88VNL9dA1NfUYcgXpzzRhl9j4V3HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=QtgZpOEx; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52b7b829bc7so1261150e87.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 May 2024 08:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1717084169; x=1717688969; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=g+D6IH37mmUyGEvm23+1o1XbuePW7/5oILGst8DpCLA=;
        b=QtgZpOExlXLn3zwc4Jsw16oD3tYj34GIKJ989OUeuypxwFubIrAofmanHR1xEetb/W
         vsEVMTSlcKUCeBhpTaJNHNVih6x5yZxUny1vup9k59E50H0RwUB+XAjG45Jfvdz5LT0a
         7HOpuZhGkSBq/hGHOUCYvImfKrvIy4LtmOy6U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717084169; x=1717688969;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g+D6IH37mmUyGEvm23+1o1XbuePW7/5oILGst8DpCLA=;
        b=YqRpOOR6mCSFBH7I6xFfhEYbprpU/Hs8YsImvslzjhLnaOChz4tIGHIX9HunRoK2TM
         epbFTJcfXUOI7p78cqZZCI4r118HpGhS/EnyJu/IAciD0sNjfz5Xypdfxgx2qdteqi3f
         GSPVW+6jVuzYpFm7+HyWAV4adfzcox7fFpiWc2hFxYT6GBClkWK63lGn1HaaKDihzfsQ
         bwO+nH9aUHhCyVVANuwWBIiSduWIYp+G583uRG2JjIiYbwilTv6uqm8zbKtknUBgWOrR
         R+tYgTUOHUD0F9pwqQxHd7CS/rHxR1r9p49nrIBKsF1V+xAw4GOuGmRxtCMSkXBxewmA
         QpyA==
X-Forwarded-Encrypted: i=1; AJvYcCUIyBIEuDkMwjxEuzSRP191fyC8nEaPjE+IWUeLKHtU8Jg02J5Bgaev/7UFiF2l0hxZCNIRm14PDIRC1A0nazxvPIavqDqt7yzLKU0IYA==
X-Gm-Message-State: AOJu0Yx9xjPNjT5TI23xjBuhzdhuElcdAtP4VVuZTw3ysleG5ANLCtmI
	GYajQDMb2oxRyYvYzZpVx/b2/oL1I+DPoTaTIMus7Md3SBDsHmURLrHrPVAL/kZNd4RCLUrn1QJ
	xWC+NeA==
X-Google-Smtp-Source: AGHT+IG9W4HtA5SKxLojt6WKh5PgjSKsvhu4FaWnMjsZ/F7bDerSgSAHgQrLL6o5/SXylqQWaOeU7Q==
X-Received: by 2002:ac2:539a:0:b0:52b:8255:71d5 with SMTP id 2adb3069b0e04-52b825572dcmr556805e87.55.1717084169418;
        Thu, 30 May 2024 08:49:29 -0700 (PDT)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a62f546025esm457154166b.56.2024.05.30.08.49.28
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 May 2024 08:49:28 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a63036f2daaso112856466b.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 May 2024 08:49:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXAoziDDPnPVH4cLNtjwCLBDXiRazybPfzLpgKxcqjbHufy40dyP2+2EoLTmMrR7OB1oRDh8KUx8FAbWcqtw1SxhFD60dyfC4HVnjYafg==
X-Received: by 2002:a17:906:240f:b0:a62:e3b2:6676 with SMTP id
 a640c23a62f3a-a65e93816d0mr169379866b.73.1717084168200; Thu, 30 May 2024
 08:49:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <72fc22ebeaf50fabf9d14f90f6f694f88b5fc359.1717015144.git.josef@toxicpanda.com>
 <20240530-atheismus-festland-c11c1d3b7671@brauner>
In-Reply-To: <20240530-atheismus-festland-c11c1d3b7671@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 30 May 2024 08:49:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg_rw5jNAQ3HUH8FeMvRDFKRGGiyKJ-QCZF7d+EdNenfQ@mail.gmail.com>
Message-ID: <CAHk-=wg_rw5jNAQ3HUH8FeMvRDFKRGGiyKJ-QCZF7d+EdNenfQ@mail.gmail.com>
Subject: Re: [PATCH][RFC] fs: add levels to inode write access
To: Christian Brauner <brauner@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org, 
	viro@zeniv.linux.org.uk, jack@suse.cz, david@fromorbit.com, 
	amir73il@gmail.com, hch@lst.de
Content-Type: text/plain; charset="UTF-8"

On Thu, 30 May 2024 at 03:32, Christian Brauner <brauner@kernel.org> wrote:
>
> Ofc depends on whether Linus still agrees that removing this might be
> something we could try.

I _definitely_ do not want to see any more complex deny_write_access().

So yes, if people have good reasons to override the inode write
access, I'd rather remove it entirely than make it some eldritch
horror that is even worse than what we have now.

It would obviously have to be tested in case some odd case actually
depends on the ETXTBSY semantics, since we *have* supported it for a
long time.  But iirc nobody even noticed when we removed it from
shared libraries, so...

That said, verity seems to depend on it as a way to do the
"enable_verity()" atomically with no concurrent writes, and I see some
i_writecount noise in the integrity code too.

But maybe that's just a belt-and-suspenders thing?

Because if execve() no longer does it, I think we should just remove
that i_writecount thing entirely.

                 Linus

