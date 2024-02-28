Return-Path: <linux-fsdevel+bounces-13125-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE14A86B7EA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 20:10:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E84451C21682
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 19:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3667974409;
	Wed, 28 Feb 2024 19:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SyeeHBnF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4E47440B
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Feb 2024 19:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709147415; cv=none; b=JDQgvPAYIt5iBCdnAz8doqsXjtxo5VoBdUMWWoNyYlyMUzhKLSRobHWDWhUAq7PyG4upJ+luEXRPqPGzv9kJqJafNTVzOOkH8MItOk1R8CFCBp5FeH5d7sUsmuR762Jplm1FCI2BuwLe4cdDKgwlaldI6W4kCJ1jwK0V2dhhzps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709147415; c=relaxed/simple;
	bh=u1H19KqVkYoNCjz+EetB0zrFvXvYPmNTjIiB4Q8DcFM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OaE/58lA8ef3nDFd6+aECX/tWwaguyjI4pRjXXTxzo8u0FVzvPqM+21YyrCjIY+frnImWOMCMTF8mlwEXCGpa91hun5rQSmmggLxqzOxTelInQVrJvNjW3pj02YyqgROjpcbyyiei095ZpDsvXeeDQyg4RqKnqqfEtgxy70lxaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=SyeeHBnF; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a3e706f50beso21937066b.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Feb 2024 11:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1709147412; x=1709752212; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8uVmVxyYpHgrM4fxtY//py2Ki6rLVz7ol7Awl8bOb4Q=;
        b=SyeeHBnFK1I+6VrYEtkO3ofEiVmHlNzhHtjgOowpPBxKPRL6FnJ4w/M1QTvAbXxZBY
         QyV04aPDR8+SkbCrVNi/v3ZQW/Gqya4MjfUjiWQpAanJy1cuYvMvnL1r6gszK75xXkZZ
         L0jJ4OJTzqupjpLplYT5H0Mo6loyGbtv6Nu4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709147412; x=1709752212;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8uVmVxyYpHgrM4fxtY//py2Ki6rLVz7ol7Awl8bOb4Q=;
        b=hRyLSCctE35CbmI9pcH8WWYP9ZbllFrkxLvRpvYm7nNAuhFzmM2ivCRD34M5dZQ5M3
         yNGI71OJQBcTnroN7mYIo6vUWDZ1wMSK0t9zfmObYmRF35uyW3LFyD2hAojzBbSUBfRE
         IFs/JJcXBvpahwEufxbqVQ01Mu5pJOqPOpOT6zMOTISg7Qm6qM4pdka2vk4CQSuj++EF
         0pXHCx56VqVKkGgy7zL3MCuW+kd8k8lQYrvZc9wE9KqrdEn6sWU34Z/lmT926Dwq9W/U
         gpIdlEijGNSKpioGzZEj8FkRwHHI4cCjvZTvM+to4Yb3CHkDodnoR2VMMcj2KwM9FXTF
         EiLg==
X-Forwarded-Encrypted: i=1; AJvYcCXekBSLj3/vK0UFHWLmtTdMWcNMd+Emfnm29L391Je7wYJJCHtSY6GgF0B3hC89pBkTQVvVQaPqPdMGx6qQTSSDZJTVKkeMbxSLVJcy1w==
X-Gm-Message-State: AOJu0YyyxtANVoUdKw2LRoPXEA7rr/N93wG+kj+fs8pFvq5aEzbtLMmU
	79ZmXN+098/C29wNpbdQrof90uERyrmtOL4XKTnw4frhsfVIiwL6Y7x/1StasZR2NL4uJ5naofC
	vwDIMtw==
X-Google-Smtp-Source: AGHT+IGe2RvyBq51ZVjGS94aQ8AMu9EzY5s+vOB5WAM1iPApq/d3csVrnucjbxh/4bdn1oIcoyG8rA==
X-Received: by 2002:a17:906:48d7:b0:a43:553c:ea4f with SMTP id d23-20020a17090648d700b00a43553cea4fmr401070ejt.23.1709147411837;
        Wed, 28 Feb 2024 11:10:11 -0800 (PST)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id c12-20020a17090603cc00b00a433f470cf1sm2144545eja.138.2024.02.28.11.10.10
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 11:10:10 -0800 (PST)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a3e550ef31cso16650466b.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Feb 2024 11:10:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXFXwEwXCzzBfS2r3ADoBmRGbZS695FXmtLCdeMIDreFkkkm/J0musISV4XheP1CMP6P1GxZPmkB+1/EspPIEjFO1ODCPc+INZ/gQl6+w==
X-Received: by 2002:a17:906:3c08:b0:a44:205e:bcb5 with SMTP id
 h8-20020a1709063c0800b00a44205ebcb5mr459062ejg.57.1709147410190; Wed, 28 Feb
 2024 11:10:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zdkxfspq3urnrM6I@bombadil.infradead.org> <xhymmlbragegxvgykhaddrkkhc7qn7soapca22ogbjlegjri35@ffqmquunkvxw>
 <Zd5ecZbF5NACZpGs@dread.disaster.area> <d2zbdldh5l6flfwzcwo6pnhjpoihfiaafl7lqeqmxdbpgoj77y@fjpx3tcc4oev>
 <CAHk-=wjXu68Fs4gikqME1FkbcxBcGQxStXyBevZGOy+NX9BMJg@mail.gmail.com> <4uiwkuqkx3lt7cbqlqchhxjq4pxxb3kdt6foblkkhxxpohlolb@iqhjdbz2oy22>
In-Reply-To: <4uiwkuqkx3lt7cbqlqchhxjq4pxxb3kdt6foblkkhxxpohlolb@iqhjdbz2oy22>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 28 Feb 2024 11:09:53 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiMf=W68wKXXnONVc9U+W7mfuhuHMHcowoZwh0b6SXPNg@mail.gmail.com>
Message-ID: <CAHk-=wiMf=W68wKXXnONVc9U+W7mfuhuHMHcowoZwh0b6SXPNg@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Measuring limits and enhancing buffered IO
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Dave Chinner <david@fromorbit.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, 
	linux-mm <linux-mm@kvack.org>, Daniel Gomez <da.gomez@samsung.com>, 
	Pankaj Raghav <p.raghav@samsung.com>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Chris Mason <clm@fb.com>, Johannes Weiner <hannes@cmpxchg.org>, Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 28 Feb 2024 at 10:18, Kent Overstreet <kent.overstreet@linux.dev> wrote:
>
> I think we can keep that guarantee.
>
> The tricky case was -EFAULT from copy_from_user_nofault(), where we have
> to bail out, drop locks, re-fault in the user buffer - and redo the rest
> of the write, this time holding the inode lock.
>
> We can't guarantee that partial writes don't happen, but what we can do
> is restart the write from the beginning, so the partial write gets
> overwritten with a full atomic write.

I think that's a solution that is actually much worse than the thing
it is trying to solve.

Now a concurrent reader can actually see the data change twice or
more. Either because there's another writer that came in in between,
or because of threaded modifications to the source buffer in the first
writer.

So your solution actually makes for noticeably *worse* atomicity
guarantees, not better.

Not the solution. Not at all.

I do think the solution is to just take the inode lock exclusive (when
we have to modify the inode size or the suid/sgid) or shared (to
prevent concurrent i_size modifications), and leave it at that.

And  we should probably do a mount flag (for defaults) and an
open-time flag (for specific uses) to let people opt in to this
behavior.

            Linus

