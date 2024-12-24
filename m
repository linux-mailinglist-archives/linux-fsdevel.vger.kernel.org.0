Return-Path: <linux-fsdevel+bounces-38108-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A589FC1C6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Dec 2024 20:45:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE1B7166663
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Dec 2024 19:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937EB1865E2;
	Tue, 24 Dec 2024 19:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="STkEo57J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9042F212D75
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Dec 2024 19:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735069517; cv=none; b=ms3FPVSpH1X/5pIRzQjafOuDIwhughmil70DZosE59dq7ynhU0oOZtP//AXcQ82/iYMhVPTklz40AOVy80LVaFVgcIXb3rdGpFPghWl3rWoe+VwG0pdSNDrypQ/Q6aL541+No29zOMfi/bKYis+eDXf+K3y4Yq+bMyZPfSp+bdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735069517; c=relaxed/simple;
	bh=2Wsma5ZwwZyodBhU+dh/1OBhSiLdyXRVHolH+UQ5FAc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fY05NpVgtMIFfWgQIs9Zo/Mofm3tJ9VzgtJ+Z+AmQU4x2PBbXwsI6uaW0efMjchQud1WfvyygmO6VEquhhHxIvvrOaA/A3wthztkCEmw9bPMu1ut/ud5ZTNuW0I0LJGiWpeO4hRUOrzdksANKOFzsLRwkT5PQANpG+U3zTaia1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=STkEo57J; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5cec9609303so7097536a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Dec 2024 11:45:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1735069513; x=1735674313; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9+vqfmRNhUQlhPzrIz8IEv8//BSnl6u3sl1MOwfgHgs=;
        b=STkEo57JCfQH5lV7Ri+k9Xa0A9C29dco5qpZfnRBQjPh7BiBQs3lSa5m9RbEGjv5FB
         kQqucsSTSAXjcq/zNMbVgSOkijMQ+dnug1BgFTOXS1H45akGGVq7g2Gdt30DI/gFI4d/
         lJvelebphEt6T6JL95ZskZgGJ21MPNRvJkUhQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735069513; x=1735674313;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9+vqfmRNhUQlhPzrIz8IEv8//BSnl6u3sl1MOwfgHgs=;
        b=XHH+q5Wh3Mww8Y2xChHLq4txcNF23qJbMONHOmmccWerWn3uN2gp3tqWzJeD76zuh1
         9CQMZzLCLt/jr8KSludHNJp9FJKvK+rHAJKAtFZg2xCujsWDIz2Sa76azMj+slVOf3yd
         VJkFNmhtXwj9o8TpomGooqwdnMEfW2kp+hEMU64W7c4d5pAqVUI4kqP+M1sRSrnN4cBN
         vOqI97JldVit7iG6N/342+ebnyjSkdTSuMlJ/liKsbibeAEwFoFzfDhFv6bVX5ywJCtQ
         e+vvav4qX0FAqjZ8JWmC40sh4Dl2I1AnFrhseQ2YIUY+zXtkl5rzpAKXVeQ9kd1YJBuy
         m1LQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqvExu0JWjfxOSQgCppUCtVvtq04bFmF5MSZFVq5+v5d5ReV39K2x0YvXBNdZbeqCUKWZ4X+hFnq+97ZBy@vger.kernel.org
X-Gm-Message-State: AOJu0Yzpl1NItRj/M0sZKorFpnowxDUvwgh9tU6AlobXbaSn/qndc0ov
	33TTQqas+7uB5NWsVo7FLiuLfYWYJ5vuj9flnKd/hGg5BJSNmzIL/QwpvA9xYTtArOX9Kk1cyNv
	19o0=
X-Gm-Gg: ASbGncuTw81D2l/IMp6TnoudL13/GPXb53GSCKQjlwzEllZrausojHEsvOikOIHc03w
	RPcjDxLcX+WHruE/WRhLZ6IdYFxmDHpqidqxIwivJRYEmBdxN8zMSDvLBwCGfpIsDvIIc5qyi9O
	HUh6y8ppauCINouYbpgZENxj9DIWogK9WnIGEploEUn4xgGHKfvWmXBmmOKorxBgwy3dFsmZdvW
	XV5wXQSu/McWVhaCOHfAkXVrFivMPZKkXa70jt41Qf1/8YQM9+PasFUYFS/pBSHluzWTELg5JzZ
	6jyOaVBZVtoyl8Pg2JblBcklncbDA54=
X-Google-Smtp-Source: AGHT+IH5vHw8qHbkM4l8BVQ52vsGA9Wo/MlTfCp4SvCOHdUpVZwgT+VVlDm+guqWsSHQX35XzuKeSQ==
X-Received: by 2002:a05:6402:3594:b0:5d7:ea25:c72f with SMTP id 4fb4d7f45d1cf-5d81ddfbf03mr14238073a12.25.1735069513567;
        Tue, 24 Dec 2024 11:45:13 -0800 (PST)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d806feddfasm6802739a12.58.2024.12.24.11.45.11
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Dec 2024 11:45:12 -0800 (PST)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aaee0b309adso280286966b.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Dec 2024 11:45:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWfP7dOLUsTD9ScP9HpdkD1TLcZNLBw9i7qB1yVYTJnRVLJeImK7ZpihA9hKAe1934XiWDWZ9aZ9hCQraOO@vger.kernel.org
X-Received: by 2002:a17:907:728c:b0:aab:9430:40e9 with SMTP id
 a640c23a62f3a-aac2d420441mr1673566466b.32.1735069511389; Tue, 24 Dec 2024
 11:45:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241209035251.GV3387508@ZenIV> <CAHk-=wh4=95ainkHyi5n3nFCToNWhLcfQtziSp3jSFSQGzQUAw@mail.gmail.com>
 <20241209211708.GA3387508@ZenIV> <20241209222854.GB3387508@ZenIV>
 <CAHk-=wjrtchauo9CO1ebkiES0X1VaZinjnHmcXQGBcZNHzyyBA@mail.gmail.com>
 <CAHk-=wj_rCVrTiRMyD8UKkRdUpeGiheyrZcf28H6OADRkLPFkw@mail.gmail.com>
 <20241209231237.GC3387508@ZenIV> <20241210024523.GD3387508@ZenIV>
 <20241223042540.GG1977892@ZenIV> <41e481e9-6e7f-4ce0-8b2d-c12491cce2dc@kernel.dk>
 <20241224191854.GS1977892@ZenIV>
In-Reply-To: <20241224191854.GS1977892@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 24 Dec 2024 11:44:55 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi6-XuqHrQ6ndE5jUR_rLnXZS2ZnhjbqjXTqxUthK_SBA@mail.gmail.com>
Message-ID: <CAHk-=wi6-XuqHrQ6ndE5jUR_rLnXZS2ZnhjbqjXTqxUthK_SBA@mail.gmail.com>
Subject: Re: [PATCH][RFC] make take_dentry_name_snapshot() lockless
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org, 
	Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 24 Dec 2024 at 11:18, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>                 if (f)
>                         seq_file_path(m, f, " \t\n\\<");
>                 else
>                         seq_puts(m, "<none>");

Maybe seq_file_path() could do the "<none>" thing itself.

Right now it looks like d_path() just oopses with a NULL pointer
dereference if you pass it a NULL path. Our printk() routines -
including '%pd' - tend to do "(null)" for this case (and also handle
ERR_PTR() cases) thanks to the 'check_pointer()' logic.

            Linus

