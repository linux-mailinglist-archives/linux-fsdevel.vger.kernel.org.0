Return-Path: <linux-fsdevel+bounces-7418-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E09A6824958
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 21:02:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FCEA1C222BE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 20:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 751412C68B;
	Thu,  4 Jan 2024 20:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="TcAgY24T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430062C687
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Jan 2024 20:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-50ea9daac4cso1000758e87.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Jan 2024 12:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1704398539; x=1705003339; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9jDsDfmbTpiQpvGnfOhd0ROcnisF14caf1vpRK9xqg4=;
        b=TcAgY24TVMOu9UYln9SgjwiLLt7KXvS7eV38BEAz0LiDd4c8Itbp+aRmvCzgLDsv8z
         btwA0mPop8VYEmcWhQ9S+Z/LjiG8BmIwlZkLeHhQpB6VdU9jnXdE62t18jTPZqKJsD+z
         4ZpyUNzjCDiJrE7ciRzvpBMU8+3XQB7D0qeNw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704398539; x=1705003339;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9jDsDfmbTpiQpvGnfOhd0ROcnisF14caf1vpRK9xqg4=;
        b=NKKMmOJAZ/06YtvzBxoT+Dx2hGQu0BQZzwwxVw3KQhzEuukmlYMbdaPUr+ma9otBL9
         ZBlH99gay/Vc6Q+DrXb5fRDd8CnnUx6huwY41DQ2JMTi4S+aZGst3YHngC85evY9ojtX
         vVjc4ZXZhm9M2m0cY2pVXD0jZwTEBK63lJy4X/HVL4eQNu5NCdwwBHq5vXBZYmS5py87
         xuXa8LCSKA1IQYG5ifBzzHSHtrBhT3z7YuSy9zR8pxUWJtajV/yhcGMHmsqkFFTE9IEO
         eUPpHflybam1NGAVpXiYrP95w9wIId6kzu9R+ii1IKvdvhTIb2BT2QLO9LfaqQMOdvLn
         H2pQ==
X-Gm-Message-State: AOJu0Yy5kGgI7U3/n9c7GMCCul8nq9QrjZ/uRxDExKjf5MjpV9h4L3BG
	3IHLmInYorrJCdKn4k1z33S9EHv+jLg75rCLx6PqeoWm8WHB8mgW
X-Google-Smtp-Source: AGHT+IF9bHaykoW4zVo5ypxx6XEMo6nBmCp8tn6zlz/UyAZGkYDKI0gXPK1ybNibUaDNfTg7JQ6EDg==
X-Received: by 2002:ac2:5973:0:b0:50e:3907:46b7 with SMTP id h19-20020ac25973000000b0050e390746b7mr520125lfp.107.1704398539103;
        Thu, 04 Jan 2024 12:02:19 -0800 (PST)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id q25-20020a170906a09900b00a2744368bdesm22407ejy.82.2024.01.04.12.02.17
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jan 2024 12:02:18 -0800 (PST)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-55719cdc0e1so432321a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Jan 2024 12:02:17 -0800 (PST)
X-Received: by 2002:a17:907:360b:b0:a1d:932f:9098 with SMTP id
 bk11-20020a170907360b00b00a1d932f9098mr716728ejc.97.1704398537679; Thu, 04
 Jan 2024 12:02:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103203246.115732ec@gandalf.local.home> <20240104014837.GO1674809@ZenIV>
 <20240103212506.41432d12@gandalf.local.home> <20240104043945.GQ1674809@ZenIV>
 <20240104100544.593030e0@gandalf.local.home> <20240104182502.GR1674809@ZenIV>
 <20240104141517.0657b9d1@gandalf.local.home> <CAHk-=wgxhmMcVGvyxTxvjeBaenOmG8t_Erahj16-68whbvh-Ug@mail.gmail.com>
In-Reply-To: <CAHk-=wgxhmMcVGvyxTxvjeBaenOmG8t_Erahj16-68whbvh-Ug@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 4 Jan 2024 12:02:00 -0800
X-Gmail-Original-Message-ID: <CAHk-=wguvq7yFt3qaLrWoZK5FCK8Joizrb2wu=FN==mYM9PSbg@mail.gmail.com>
Message-ID: <CAHk-=wguvq7yFt3qaLrWoZK5FCK8Joizrb2wu=FN==mYM9PSbg@mail.gmail.com>
Subject: Re: [PATCH] tracefs/eventfs: Use root and instance inodes as default ownership
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 4 Jan 2024 at 11:35, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>>
> Which is *NOT* the inode, because the 'struct file' has other things
> in it (the file position, the permissions that were used at open time
> etc, close-on-exec state etc etc).

That close-on-exec thing was a particularly bad example of things that
are in the 'struct file', because it's in fact the only thing that
*isn't* in 'struct file' and is associated directly with the 'int fd'.

But hopefully the intent was clear despite me picking a particularly
bad example.

            Linus

