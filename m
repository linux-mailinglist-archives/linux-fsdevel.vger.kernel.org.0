Return-Path: <linux-fsdevel+bounces-20867-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9372D8FA573
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 00:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37E5E1F2531E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 22:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D0113C9C7;
	Mon,  3 Jun 2024 22:18:35 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECD8522E;
	Mon,  3 Jun 2024 22:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717453114; cv=none; b=M/cS8z0p+9zFUGagVD/Y/Mo0gFc54kBxdGtRJGUZz0rSqe0iNQHCoqtAiAnu9VLvwQu0Ce7s+1azIQZ6FAZFZMEwxQRtTj2gg5bUrJz6xASyoAyPUloBca9ffLEJxJIdnEexmFYcLZDa8VPsYpstS4MUK2EkdLa3eVSubyCCedw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717453114; c=relaxed/simple;
	bh=Pe/JUaoyjJimW5/8Dc/JtyU1xBdBAjb+X9J2Einmg2M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qppiRfOM6+1NUYLev44lREnzuRd5lso4cxlbSxNn/SqN4/6pXnRrDdfRBETH5Qn1irMbCu9Lw51fojUqfQHcm3IDsSwLVSaAWdzoinV1WL+T9o6Ot9SB3580X2/XJScp16xA76IBk9QWDxCg4vA1s/R7Xo/emiNYKVBj4FmVRwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6369C2BD10;
	Mon,  3 Jun 2024 22:18:32 +0000 (UTC)
Date: Mon, 3 Jun 2024 18:19:43 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Yafang Shao <laoar.shao@gmail.com>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 audit@vger.kernel.org, linux-security-module@vger.kernel.org,
 selinux@vger.kernel.org, bpf@vger.kernel.org, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH 2/6] tracing: Replace memcpy() with __get_task_comm()
Message-ID: <20240603181943.09a539aa@gandalf.local.home>
In-Reply-To: <CAHk-=whPUBbug2PACOzYXFbaHhA6igWgmBzpr5tOQYzMZinRnA@mail.gmail.com>
References: <20240602023754.25443-1-laoar.shao@gmail.com>
	<20240602023754.25443-3-laoar.shao@gmail.com>
	<20240603172008.19ba98ff@gandalf.local.home>
	<CAHk-=whPUBbug2PACOzYXFbaHhA6igWgmBzpr5tOQYzMZinRnA@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 3 Jun 2024 14:42:10 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Mon, 3 Jun 2024 at 14:19, Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > -               __array(        char,   comm,   TASK_COMM_LEN   )
> > +               __string(       comm,   strlen(comm)            )  
> 
> Is this actually safe is 'comm[]' is being modified at the same time?
> The 'strlen()' will not be consistent with the string copy.

First, I realized that it should actually be:

		__string(	comm,	task->comm	)

But your question is still a valid question, as the internal logic will
call strlen() on the second parameter.

> 
> Because that is very much the case. It's not a stable source.
> 
> For example, strlen() may return 5. But by the time  you then actually
> copy the data, the string may have changed, and there would not
> necessarily be a NUL character at comm[5] any more. It might be
> further in the string, or it might be earlier.

The logic behind __string() and __assign_str() will always add a NUL
character.

__string() is defined as:

  static inline const char *__string_src(const char *str)
  {
       if (!str)
               return EVENT_NULL_STR;
       return str;
  }

  #undef __dynamic_array
  #define __dynamic_array(type, item, len)                              \
        __item_length = (len) * sizeof(type);                           \
        __data_offsets->item = __data_size +                            \
                               offsetof(typeof(*entry), __data);        \
        __data_offsets->item |= __item_length << 16;                    \
        __data_size += __item_length;

  #undef __string
  #define __string(item, src) __dynamic_array(char, item,               \
                    strlen(__string_src(src)) + 1)                      \
        __data_offsets->item##_ptr_ = src;


The above will use the strlen(src) to specify the amount of memory to
allocate on the ring buffer: "strlen(__string_src(src)) + 1)"

This is stored on a special structure for the entry and used in the
__assign_str() (the reason I removed the source to that macro during this
merge window).

  #undef __assign_str
  #define __assign_str(dst)                                             \
        do {                                                            \
                char *__str__ = __get_str(dst);                         \
                int __len__ = __get_dynamic_array_len(dst) - 1;         \
                memcpy(__str__, __data_offsets.dst##_ptr_ ? :           \
                       EVENT_NULL_STR, __len__);                        \
                __str__[__len__] = '\0';                                \
        } while (0)


The source of the string is copied via memcpy() using the length stored
from the __string() macro (minus 1), and then '\0' is added to it to force
the NUL character to be in the memory for the string.

-- Steve

