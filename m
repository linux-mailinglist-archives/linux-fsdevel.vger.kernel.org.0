Return-Path: <linux-fsdevel+bounces-69571-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A7C1C7E471
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 17:46:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C757B34958F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 16:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A7E214204;
	Sun, 23 Nov 2025 16:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SRQy2BM5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9E81FDD
	for <linux-fsdevel@vger.kernel.org>; Sun, 23 Nov 2025 16:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763916400; cv=none; b=Z5T7LqqkeQAp99LnbOupsDci2BtCrJlIPw+Fry4mC5onnIujG4bvxI2dDHxqK4NiSEQGNxXVm6lrooIHy/JXvKwS5cFg8jMxIKO4IsRZiShr8vMeh6HsMLzdB3vG4GYTKWDn8uAuU84hOYYZDEDv4SR5DiGgYHly4S12BF70GL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763916400; c=relaxed/simple;
	bh=WX2ix5q772n6lrDg4iFKVjYbeSc2DhPgfg8pdwfYMeE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PGW52LHcDmtTFxA60rRhDmZZXvWCcmr0DMS9JrnWV87C14f5JkKY8FLPxf/9mSa3sQeZfVe+wlJ1gFJFEUSZo4pOVdI7jDX2cHfZbpgd/9rUQQiB9s1AedJccsQsRTPlNEQNAL0pt3uF2ixzs+OXYvHCiRBhfSpz16EtTLiOnmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=SRQy2BM5; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b73545723ebso665042766b.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 23 Nov 2025 08:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1763916396; x=1764521196; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mErRRPda4jGI0TroIx/mDz4enmJEzkg0tThuuNGXWvU=;
        b=SRQy2BM5KWofiXknev82XyqH1Fef+8KHQZt78+f5vqsMH42fGeWGACsA13lr7KVyJL
         QMPIuliuS8UtggygAOA1fCG/oCx0uYnWMA56JxltqnO9gDJGP4yB8hR/BTlyb5cOBBOt
         T0qH0wlWQ97qDBKJdXtD/IFKuST9rrZUFcwWE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763916396; x=1764521196;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mErRRPda4jGI0TroIx/mDz4enmJEzkg0tThuuNGXWvU=;
        b=p1jx3IvDRBWvrjpGRLM9tt0JBY6YmKLg2EywLoL+KbB+BbVvFKIboo1M5rVuFGXaQf
         25jVTHd2h5YIZh5iJccshBIhi0NOwO5FMHJsHxEqcvecuCI132/yustZiIUHD/kCzNjN
         c8J/L6O9b7yxEXE84MGrTlCLwqSmUOHXZFE5ydmgccnLcWIs2JHcLD00dInSHbVMG8Cd
         NYC1jKXezzIQJP7/72c8uhmeSAvsbcqoY4FzT3nkklAdIhi0xhNVCc5ldAJIlKrAVb4t
         OzkGF8KCPR55bvj4WH9ZWhiGEBGPs+3XwWr5kDayjANBv5Hmj1vHnVKcU49RVZ2A3qOB
         NHbw==
X-Forwarded-Encrypted: i=1; AJvYcCUavPy1x4/07QV2BCpqMzjqz8X9fXfTTzHBW+jDd06VVP0mGJ3oEk/S878BVsDZNGAOex5clu+xAXDCM+hc@vger.kernel.org
X-Gm-Message-State: AOJu0YymfXdmFjBBTrtKiihAli6aFZLMisVa1ZiJ7IONtKtiL89tzckL
	R/8L6CwYWA3a1nP0231kNBKrjcecNIHCBGd47WvBUOV6k3EHZOh7B+OloNCWPejynJqzpWmwKv4
	F61OO2y3fwA==
X-Gm-Gg: ASbGncvs+LZ8KBihfsxkNnKcaEcT49nWtFGv+j7X3+A6SrhZGS+Gl8qmmrchj4Au70/
	/+iBfv3zgxiUpLyx5M0GGuU4/jp7INuzskrygQufYImKTzNpJkL/8rFkUkvTOUcgieUv2T7CT5B
	4UNH3iwPpu8B5NvFLIzYzu+sB8aQK/KHVjIdkxkmy3s3rc9zYIPoAR7YMb4b5xmIxu40mcI0szo
	1ji5ZJr2Q8VveZNAWw3ECjqXVm/JILKQ/HZvbHGS8MAzMkFnHuomssLCbNxzmpI4JVDS3TQTA4k
	j+6lnu4l0sCfOtxu5nc9S6AFgVzXHF9/0EZKJd1rxjP0QrTtwwhbGN+dHzBKbA/1N/Gl2FkuMCe
	XpzHzxPJt5q5ZSnpUAq9Wx5FYSbyMxrGwMAn+H7jlQJGWfk94rRYWZ75o0EPsFzhEaSwayYzn+F
	LcnxBSA04nq9LaTqT/XJx0QHtLPv1MIo2T8NdUfkXlwhIQ5e6D1qRd5bMNMglz
X-Google-Smtp-Source: AGHT+IHQEKQhabOH4QbFrCxnc6QYegPSbY1otVuO/kEmBB2A1S0+uHEgi231w6WYrpuEmsNqtl6TGQ==
X-Received: by 2002:a17:907:72c6:b0:b73:9aa5:8782 with SMTP id a640c23a62f3a-b767168f5bamr845469566b.9.1763916396227;
        Sun, 23 Nov 2025 08:46:36 -0800 (PST)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7655050d05sm1030857966b.70.2025.11.23.08.46.34
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Nov 2025 08:46:34 -0800 (PST)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-64074f01a6eso6361309a12.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 23 Nov 2025 08:46:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVL6FniN+tN3h0VPQH7mm8j3udb9gmC9WUEOZNfde2+LmtvSgh7I7qUqq3/YUa9ncFeghP9gNncbMMcRugX@vger.kernel.org
X-Received: by 2002:a17:907:3ea9:b0:b70:4377:4d2c with SMTP id
 a640c23a62f3a-b76716888a4mr881984966b.1.1763916394374; Sun, 23 Nov 2025
 08:46:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251123-work-fd-prepare-v4-0-b6efa1706cfd@kernel.org> <CAHk-=wgLeBAXe+gOmv0zf+ZaD9a_gtL81349iLvfesXkUxYyWA@mail.gmail.com>
In-Reply-To: <CAHk-=wgLeBAXe+gOmv0zf+ZaD9a_gtL81349iLvfesXkUxYyWA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 23 Nov 2025 08:46:18 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjphFLTSK0-8_aLnoKsFifpsctUCqD+7Dr0P1mEkxoxKQ@mail.gmail.com>
X-Gm-Features: AWmQ_bmqmlNUa7oE-hEP15BrCVC1dx9ZHBis_dO3C3MhvjFv9Y1-Jt4kyKF_GIs
Message-ID: <CAHk-=wjphFLTSK0-8_aLnoKsFifpsctUCqD+7Dr0P1mEkxoxKQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/47] file: FD_{ADD,PREPARE}()
To: Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"

On Sun, 23 Nov 2025 at 08:43, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So yeah, no more complaints about this from my side.

.. oh, but one note: you should update some of the subject lines.

The subjects typically say "convert xyz to FD_PREPARE()", but half of
them should say "convert xyz to FD_ADD()".

I mean, technically FD_ADD() is obviously just a simple wrapper for
the FD_PREPARE() pattern, so it's not like it's *wrong*, but...

              Linus

