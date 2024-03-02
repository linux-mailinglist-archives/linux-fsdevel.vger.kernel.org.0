Return-Path: <linux-fsdevel+bounces-13377-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB35E86F1D0
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Mar 2024 19:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F1902833DD
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Mar 2024 18:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104C536118;
	Sat,  2 Mar 2024 18:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KK1s3AKS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADE32C6B3
	for <linux-fsdevel@vger.kernel.org>; Sat,  2 Mar 2024 18:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709403127; cv=none; b=qdqj4Iqef7i3PFd4uBtnibEUEFUaxCKV3AGcKTxNyb+4grGp4he++aKsNHFiIxJqgtk/IBE1lqODY/aCfTV81/g8PAHCIBoR0fjz4TmhqEVp22W2Fo1mW2n/vxwwKZ/CHUhPUB6oTcK4ZShfKwAx5wIIRD3KZf9nKcSbeARHpyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709403127; c=relaxed/simple;
	bh=UaTnZY8Awdcgt8ZW0ePFAWj+b5DkUlXvw9yVNGy7EKk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pRAvsAj+jafgjH7Y9kosl+ER7dStxyUAp8Oaj7vhMPYNXbHvR28L+LMkwVHWjX3qAdec66JQSrQKzSB9V7Xgl7najDsAVTodwD6xN+q3meXOWAbsXES+LcCwEIeCwyQ5LozZJQZQrvYdZSk43DgbapmIpdWHr0wuu1uZq9s97nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=KK1s3AKS; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-55a5e7fa471so4907773a12.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 02 Mar 2024 10:12:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1709403124; x=1710007924; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mpxtfMFdGHdZ3KBLFHI8lmN/KThAgx7c0/ntlIOIqzY=;
        b=KK1s3AKS9QI5zO1IM+w3Ch6ZpCoQI7Ipd/X5JmGtv/iVdozGaSoSvQwDJf3cgS44IH
         VY/1+kgJiiMNw/Td/Xi8N7sm5B1mmBFNEOYr8Ck964UUWpIGf8l0K5yZeXps7qC2aguF
         yL4QldbtYQFPnquyuaP877/tuSCkdc5K+BZ9k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709403124; x=1710007924;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mpxtfMFdGHdZ3KBLFHI8lmN/KThAgx7c0/ntlIOIqzY=;
        b=abTIUKKRLzMlqI1uKlDRlZ3JU5vPG083JQRUark2gFxK83QyQjeoBvLqo0pBFK5qza
         khZot+AQKsbs0x13oIcbAvlYcrDavYT8YIvbcv9+J3JUND01PzhLb83YmHMqTQSU70mV
         AnQtAtaAYoaJ14XCSm+h5O0OFbbk/eEurfiwcLfyA8dkfWiPivUcIbxGLmI5cgsS19v8
         NBYYOBOfoAjdV+qy75x3lDrE0Kd4T/7xz7jMHJj/HbPQPI9xeqWxc5UoCsoFTsxucQgr
         NxfAxKbS/yU3kHAw/zJJOA2w2g+UxMKePha06J1KGZP03aqH+3WNmp7cp8hxIrFQgz11
         XYuw==
X-Forwarded-Encrypted: i=1; AJvYcCUiT9Vlqhzs009RCUxSzc8m+DAaGqfFCr7oQvhMlLOkf3AvA7cN0+nwQd168G9au7JximG6sWztExvHHbFQ4nZcwTuHTbssfFvr2gPYnw==
X-Gm-Message-State: AOJu0Yx9e5iO9Llg7THWBKfAOq4CQujv8dotZ0yj2bazkMor9CIcxe+s
	bqvnjetHDt99tZE2W7NP0eiAOKSnEreUzYPmoIMQYXKgOWRMybBY82Ic9w9YKPnzN0ydHg+d2uS
	gZcaduQ==
X-Google-Smtp-Source: AGHT+IFcbAwbrf/NyNNl5qGgGOQtTskr7sD01mkz9BFo+0vSoYIf8ufSx7mw5cK6b5SJ8gNPviikow==
X-Received: by 2002:aa7:d604:0:b0:566:edb1:3c7b with SMTP id c4-20020aa7d604000000b00566edb13c7bmr2387857edr.34.1709403124259;
        Sat, 02 Mar 2024 10:12:04 -0800 (PST)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id g8-20020a056402428800b00564f3657a5csm2808931edc.75.2024.03.02.10.12.03
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Mar 2024 10:12:03 -0800 (PST)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a28a6cef709so522497766b.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 02 Mar 2024 10:12:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUulF1mj70yLzrdHFoIXVNcjsT5D9976xhG3ri/pACoWLlZQ0MxPR+A1FR1qiJdrjcuzqkGFjIfoZgOO4rZIrXSWwN2D16F8vz988VR0A==
X-Received: by 2002:a17:906:f190:b0:a44:2134:cba9 with SMTP id
 gs16-20020a170906f19000b00a442134cba9mr3296518ejb.69.1709403123040; Sat, 02
 Mar 2024 10:12:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230925120309.1731676-1-dhowells@redhat.com> <20230925120309.1731676-8-dhowells@redhat.com>
 <4e80924d-9c85-f13a-722a-6a5d2b1c225a@huawei.com> <CAHk-=whG+4ag+QLU9RJn_y47f1DBaK6b0qYq_6_eLkO=J=Mkmw@mail.gmail.com>
 <CAHk-=wjSjuDrS9gc191PTEDDow7vHy6Kd3DKDaG+KVH0NQ3v=w@mail.gmail.com>
 <e985429e-5fc4-a175-0564-5bb4ca8f662c@huawei.com> <CAHk-=wh06M-1c9h7wZzZ=1KqooAmazy_qESh2oCcv7vg-sY6NQ@mail.gmail.com>
 <CAHk-=wiBJRgA3iNqihR7uuft=5rog425X_b3uvgroG3fBhktwQ@mail.gmail.com>
 <f914a48b-741c-e3fe-c971-510a07eefb91@huawei.com> <CAHk-=whBw1EtCgfx0dS4u5piViXA3Q2fuGO64ZuGfC1eH_HNKg@mail.gmail.com>
In-Reply-To: <CAHk-=whBw1EtCgfx0dS4u5piViXA3Q2fuGO64ZuGfC1eH_HNKg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 2 Mar 2024 10:11:46 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjvkP3P9+mAmkQTteRgeHOjxku4XEvZTSq6tAVPJSrOHg@mail.gmail.com>
Message-ID: <CAHk-=wjvkP3P9+mAmkQTteRgeHOjxku4XEvZTSq6tAVPJSrOHg@mail.gmail.com>
Subject: Re: [bug report] dead loop in generic_perform_write() //Re: [PATCH v7
 07/12] iov_iter: Convert iterate*() to inline funcs
To: Tong Tiangen <tongtiangen@huawei.com>
Cc: Al Viro <viro@kernel.org>, David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@lst.de>, Christian Brauner <christian@brauner.io>, 
	David Laight <David.Laight@aculab.com>, Matthew Wilcox <willy@infradead.org>, 
	Jeff Layton <jlayton@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Kefeng Wang <wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 2 Mar 2024 at 10:06, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> In other words, it's the usual "Enterprise Hardware" situation. Looks
> fancy on paper, costs an arm and a leg, and the reality is just sad,
> sad, sad.

Don't get me wrong. I'm sure large companies are more than willing to
sell other large companies very expensive support contracts and have
engineers that they fly out to deal with the problems all these
enterprise solutions have.

The problem *will* get fixed somehow, it's just going to cost you. A lot.

Because THAT is what Enterprise Hardware is all about.

                  Linus

