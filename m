Return-Path: <linux-fsdevel+bounces-20246-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 124978D060D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 17:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 439001C21EE6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 15:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB95561FCC;
	Mon, 27 May 2024 15:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="CJSDMwWN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6177417E909
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 May 2024 15:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716823430; cv=none; b=g1EHOb25cL54k7zsYUkWLZUr3fKKupLhcOb6OHHPDpGkxPOy8nb8fvU+SH60m7/zNzwEH0kI60g6S/gM9yui4gJOckWfxHsa+Q6/UtAS3eYWG3yxvbswfQYsEIu2vZpUTlqCQurZCCrfiRqGQwoj7hzBTgLSTcWqzJ9CJYrEjUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716823430; c=relaxed/simple;
	bh=rX6Mr8H9PbEB8Nrj9fFUHV2mAOv+AGDZJDj20RP9pWg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MBGeB01dl/pe+G6ZIyrGTfB3oKL39dw815NDBYzrB9N7cHi9w169CVfhTxvCgbZl6xLaCuWdc8vDlM6NcSh0W5Bxtbsu+A+6gWnbgyaMCMrJY5OcKA35wCEyC2UQdWZhmfO0Y8wOVBDdSjJBUZ4cqNH1W/YCDM6yb0MVOc5tduY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=CJSDMwWN; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-57869599ed5so2379021a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 May 2024 08:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1716823426; x=1717428226; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=J6TnsN3hyZ2OmWrwgdcT2rAmhOzue21klQUHKehJR/Y=;
        b=CJSDMwWNjDxUtOs445KO6tNnsRyCuPFFvLlj5heUMOE61oy7tyMjndN1VFzXdFTQ8w
         OwDXBl/Qz8cDMDBEX6YzZh/2+lRfxGvdohyPbawmsH4Dv3RDWzjbdLaslAv24cHQnIoT
         sbeoBV5J1fRm9o+ydvZPkBdXaHBjx17Y8kf6w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716823426; x=1717428226;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J6TnsN3hyZ2OmWrwgdcT2rAmhOzue21klQUHKehJR/Y=;
        b=gRXuKkKDvCd3emcsuNHNTplQPV5n6laUpu6SNpHmC54kd9+hashSoRClayo3yVYl18
         +yx60YUYKeuAHoHE0GPMPK7TnIJOETlnxz4HM2Di2u3rk1ia9qCgnCjvtX3Hj4Q97fzG
         QEfn7ny8/Homa2SS+vxd8H7tujNxMB+LhKx0zF1jN9iBg+1uBWqMV9ICm/BRcXWsLVY4
         MthIoaXgQqPmmNxnbFHlQLO+lk1P0VzwZbHaXb9Q9mxKFyy1w+u5fV7Iqn95gBnCHBgv
         ed1g1WNEeYsp/JQOSkc8FkEbDNfKGFZoLBIGLf6/6lwlab7sd71izc5Ir8ntbyaLtK8r
         wJkw==
X-Forwarded-Encrypted: i=1; AJvYcCUZw2J9/gpyzGVJFuAmzN7jtkCyhYGoTw7hc1Fklw2GHLt7dFw34dCF5c3Oa337J1ys7i7vlaxpOZj3RhIiAjOp3wXHV0/GAf3w0Kvg7g==
X-Gm-Message-State: AOJu0Yx/4BKW1c5Ae+hZMAoNo8y0SnPKtmVc0z2rrH/Y5m5sOfEoFngH
	JO/1DQCDgU4yeVRsmEcdYvC7ukQG8FSV1JGz6xFl90AB0ng8iLISVlfaLwXnWE3Ma6CC7/8dcUS
	pWjc48g==
X-Google-Smtp-Source: AGHT+IE6lGs5XfPulRrlfA4zNbpaD7O6V63VjL9pfIVbX2eBf8ObuSUd+8RLbl+MlXKBURZQ+hMzag==
X-Received: by 2002:a50:d749:0:b0:579:e756:20ef with SMTP id 4fb4d7f45d1cf-579e7567aedmr399324a12.31.1716823426454;
        Mon, 27 May 2024 08:23:46 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-579db5406a7sm836607a12.63.2024.05.27.08.23.45
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 May 2024 08:23:45 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-57869599ed5so2378978a12.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 May 2024 08:23:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUA5rFvJypSN7Q0Jk7lKa/BFt0FNdim3mrsf5gGUHRpAPr93UPif0eZLSZlLbWN/uizsJGI+pLqGtL5+Pm31B+LMpSGa2s17beBW0StuQ==
X-Received: by 2002:a17:907:7005:b0:a5a:2aed:ca2b with SMTP id
 a640c23a62f3a-a62641bbbb8mr669128066b.28.1716823425038; Mon, 27 May 2024
 08:23:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240526034506.GZ2118490@ZenIV> <CAHk-=wjWFM9iPa8a+0apgvBoLv5PsYeQPViuf-zmkLiCGVQEww@mail.gmail.com>
 <20240526192721.GA2118490@ZenIV> <CAHk-=wixYUyQcS9tDNVvnCvEi37puqqpQ=CN+zP=a9Q9Fp5e-Q@mail.gmail.com>
 <20240526231641.GB2118490@ZenIV>
In-Reply-To: <20240526231641.GB2118490@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 27 May 2024 08:23:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=whMtdD37OJ7ABVuBi+JLkG+ZcuXf1+cwC=J+H5B3EASTg@mail.gmail.com>
Message-ID: <CAHk-=whMtdD37OJ7ABVuBi+JLkG+ZcuXf1+cwC=J+H5B3EASTg@mail.gmail.com>
Subject: Re: [PATCH][CFT][experimental] net/socket.c: use straight fdget/fdput (resend)
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 26 May 2024 at 16:16, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> FDPUT_FPUT is *not* a property of file; it's about the original
> reference to file not being guaranteed to stay pinned for the lifetime
> of struct fd in question...

Yup. I forgot the rules and thought we set FDPUT_PUT for cases where
we had exclusive access to 'struct file *', but it's for cases where
we have exclusive access to the 'int fd'.

               Linus

