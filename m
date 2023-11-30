Return-Path: <linux-fsdevel+bounces-4523-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DAF1800048
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 01:36:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1794B209EF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 00:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D0A1C682
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 00:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="MWFTRZ+a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E3910E4
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Nov 2023 15:37:50 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-54af2498e85so1745869a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Nov 2023 15:37:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1701387469; x=1701992269; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ttWeT4tGsUiOgcxlbQdni7f/6KNDsvAfSPwHjSvlekY=;
        b=MWFTRZ+aw92ypERvD7HlQ+4VNngG4AE/icHSmIt/YRjYSumJ48ILXNoWlQ6ecFDi6W
         H9pIwPJiQd4j4d2u+GPi/hZ8AQQzXzXSbRNCQJC1LnDo+KVgRSYBG09Nl1OHex0ar02X
         CcSoLSqyD1LnLH/GPIFb8PKhUBASvtN18UB9g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701387469; x=1701992269;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ttWeT4tGsUiOgcxlbQdni7f/6KNDsvAfSPwHjSvlekY=;
        b=M0mAxYis6B751g/Q1TWfJtQwra/380e/5fIiN3hoeDXEEJf25p0FSlX0HKb46Lyy6n
         FoEBZVcSgy0uoJUIFCdYcks0ZU78nwy3CkQNVJup+IiYbVIhcnnx33NIeixn/mLqltLm
         GIoEyLbllWy5Fba86tvioQRNL/y1ftH57iAwT4D+Dc8CzzfWNFf5JFqXjDY1W1d4pZFv
         FaagbyHnkAKdO4dyOdo86xyBdtydNahcrC71jAYKFZW0uATXkXTyL87CL1KSazAqdB3q
         GdTLBQ30zz9lRTTJ9tupXcSi/cYgHZAkvzL691PH9Tx9N5pwp72uCBLmZ3oZkwXnfcbN
         yP5Q==
X-Gm-Message-State: AOJu0YyIXH5fm5I8XNUBWxsTbjVAj1IO4VSyMXwBHUCAC1cNtF8vNihA
	TLLh/2pO8v8MD+0Am7MN1lWESf3cgR2h5ALhYF03pZT3
X-Google-Smtp-Source: AGHT+IELlcwYga/y/Af8VBAWuihVf6esgkJzz0wqPuAdK4WjuFVCCVKzlkUWO0G3o771b2xBTUpVMA==
X-Received: by 2002:a50:f683:0:b0:54c:4837:7581 with SMTP id d3-20020a50f683000000b0054c48377581mr221252edn.45.1701387469156;
        Thu, 30 Nov 2023 15:37:49 -0800 (PST)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id c20-20020aa7d614000000b0054b55bb5b63sm1041881edr.29.2023.11.30.15.37.48
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Nov 2023 15:37:48 -0800 (PST)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-54af2498e85so1745854a12.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Nov 2023 15:37:48 -0800 (PST)
X-Received: by 2002:a50:a6c3:0:b0:54b:8c96:9aa6 with SMTP id
 f3-20020a50a6c3000000b0054b8c969aa6mr214204edc.37.1701387467645; Thu, 30 Nov
 2023 15:37:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231130-vfs-files-fixes-v1-0-e73ca6f4ea83@kernel.org> <20231130-vfs-files-fixes-v1-3-e73ca6f4ea83@kernel.org>
In-Reply-To: <20231130-vfs-files-fixes-v1-3-e73ca6f4ea83@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 1 Dec 2023 08:37:30 +0900
X-Gmail-Original-Message-ID: <CAHk-=wjWvbbX4c-8nGWOqMden6X8k=8kYCNfy96r0N+8FJbU6g@mail.gmail.com>
Message-ID: <CAHk-=wjWvbbX4c-8nGWOqMden6X8k=8kYCNfy96r0N+8FJbU6g@mail.gmail.com>
Subject: Re: [PATCH RFC 3/5] fs: replace f_rcuhead with f_tw
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.com>, 
	Jens Axboe <axboe@kernel.dk>, Carlos Llamas <cmllamas@google.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"

On Thu, 30 Nov 2023 at 21:49, Christian Brauner <brauner@kernel.org> wrote:
>
> The naming is actively misleading since we switched to
> SLAB_TYPESAFE_BY_RCU. rcu_head is #define callback_head. Use
> callback_head directly and rename f_rcuhead to f_tw.

Please just write it out, ie "f_taskwork" or something. Using random
letter combinations is very illegible. It may make sense at the time
(when you are literally editing a line about "init_task_work()") but
it's literally just line noise in that structure definition that makes
me go "f_tw is wtf backwards, wtf?".

It might even be a good idea to say *what* it is a task work for.

        Linus

