Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19599284309
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Oct 2020 01:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725947AbgJEXrl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Oct 2020 19:47:41 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:57308 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgJEXrl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Oct 2020 19:47:41 -0400
Received: from fsav304.sakura.ne.jp (fsav304.sakura.ne.jp [153.120.85.135])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 095NlWEf058208;
        Tue, 6 Oct 2020 08:47:32 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav304.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav304.sakura.ne.jp);
 Tue, 06 Oct 2020 08:47:32 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav304.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 095NlV7I058186
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Tue, 6 Oct 2020 08:47:32 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH v2] splice: fix premature end of input detection
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <20201005121339.4063-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <CAHk-=wiRkmMvm09+TJtbf+zNYyUB_J0-U=B0bzPte=j0hzPdAw@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <54cd9095-8bda-96f0-a744-f817b6e6af40@i-love.sakura.ne.jp>
Date:   Tue, 6 Oct 2020 08:47:29 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <CAHk-=wiRkmMvm09+TJtbf+zNYyUB_J0-U=B0bzPte=j0hzPdAw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/10/06 3:26, Linus Torvalds wrote:
> On Mon, Oct 5, 2020 at 5:14 AM Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>>
>> splice() from pipe should return 0 when there is no pipe writer. However,
>> since commit a194dfe6e6f6f720 ("pipe: Rearrange sequence in pipe_write()
>> to preallocate slot") started inserting empty pages, splice() from pipe
>> also returns 0 when all ready buffers are empty pages.
> 
> Well... Only if you had writers that intentionally did that whole "no
> valid data write" thing.
> 
> Which could be seen as a feature.

pipe_read() is aware of such writers.

  /*
   * We only get here if we didn't actually read anything.
   *
   * However, we could have seen (and removed) a zero-sized
   * pipe buffer, and might have made space in the buffers
   * that way.
   *
   * You can't make zero-sized pipe buffers by doing an empty
   * write (not even in packet mode), but they can happen if
   * the writer gets an EFAULT when trying to fill a buffer
   * that already got allocated and inserted in the buffer
   * array.
   *
   * So we still need to wake up any pending writers in the
   * _very_ unlikely case that the pipe was full, but we got
   * no data.
   */

We also need to care about handle_userfault()
( https://lkml.kernel.org/r/29dd8637-5e44-db4a-9aea-305b079941fb@i-love.sakura.ne.jp )
which we might change it to return an error when pagefault from
pipe_write() takes too long.

> 
> That said, if this actually broke some code, then we need to fix it -
> but I really hate how you have that whole !pipe_empty() loop around
> the empty buffers.
> 
> That case is very unlikely, and you have a loop with !pipe_empty()
> *anyway* with the whole "goto refill". So the loop is completely
> pointless.

This loop just removes all leading empty pages at once.
"goto refill" is a result of all pages were empty.

> 
> Also, what if we have a packet pipe? Do we perhaps want to return at
> packet boundaries? I don't think splice() has cared, so probably not,
> but it's worth perhaps thinking about.

Since manpage says that "Zero-length packets are not supported.", I think that
skipping leading empty pages (either my version or your version) will not break
packet boundaries.

This check is there to avoid returning 0 when all available buffers are empty.
This check should remain no-op if some buffer is not empty.

> 
> Anyway, I'd be a lot happier with the patch being structured something
> like this instead.. UNTESTED

I'm OK with your version.

