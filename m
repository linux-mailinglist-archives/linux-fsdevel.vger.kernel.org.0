Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C2D3FCA41
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2019 16:51:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbfKNPvJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Nov 2019 10:51:09 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:39995 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbfKNPvJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Nov 2019 10:51:09 -0500
Received: by mail-io1-f65.google.com with SMTP id p6so7303753iod.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Nov 2019 07:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+RprlYzhSDEqjzZjpfI3XGa25r7ZTr5XLWPzcC7ZwH0=;
        b=cteXF1eMCEYr0oXOfcP1lDv1V3S5fzBjYUjSfH0IIN9GvX9xSomMJJnxLA8dQE7b7C
         TcgraWfimEC/gCZ8OT3NOTaAYpwTRdbo8kvdF39A/2jqo5bWAf78QHTpw7ZevshLYbxh
         ayiBs9Zsa7IvzmfUHJVPwHgS3p+53zDbAQ68EIOBw63WnqvMbViZ/ctH8v7t+qQlSH5t
         hnODKvP9lBhLsQKgjNosMu6fQtgZGrzQypGYLVF5hlen9z2WXVG2W94xg+bQQiFbTS5i
         jeJMtrw3pu4ebbifrprAi53C+mmFefphATmFiYaCTYSa6XGuUE6rtIasK6NjvIMmg+8f
         IwTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+RprlYzhSDEqjzZjpfI3XGa25r7ZTr5XLWPzcC7ZwH0=;
        b=as910+NO2EMqnSG/aahuV9hPFoTcH99cXUjriiMJS/RpDl8wxHXjQ9uchVwoGgU64z
         VQyLOu6MUhnN+CEGdyLn5Ou+EECwi/R/gociLPB5FjCQG2O676D6fCZ10iNViG0rd/Ll
         4NU/RJobvpQKGWPhYA5KqxTRqeTYEm+xRQeAuYYsZ1Xnjdw98r20i960N6i9n8n+rMxb
         B1tKWRB48sZVPe6bi90E7wsDo4DDF+/vT+61dQA47NhcN/w4yRMCTd/Fh2fRTRQOMd31
         BCXn3PAy+aU8fIODDg6oWqsck6KOAoFHcmNFmqI/EfqXwNk5gZCQCadnEx9vY5WjNPkQ
         wbfg==
X-Gm-Message-State: APjAAAXJ78Xlwpjq0KCN4ljY026UDVi1hiJ+S9+RhS6mg5TZpbPut+jL
        KNjz4eugopi22drGs2ZB3jM2BNxA2fY=
X-Google-Smtp-Source: APXvYqzUZbP6xqV2wJ1GNw3wRScPbvb6W/DH56obL15Pg1biAa4jRE2hISaLh7LK+EAxdYhN5OHs8w==
X-Received: by 2002:a5d:8b85:: with SMTP id p5mr9482626iol.9.1573746667749;
        Thu, 14 Nov 2019 07:51:07 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id g11sm827035ilq.39.2019.11.14.07.51.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Nov 2019 07:51:06 -0800 (PST)
Subject: Re: [PATCH RFC] io_uring: make signalfd work with io_uring (and aio)
 POLL
From:   Jens Axboe <axboe@kernel.dk>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jann Horn <jannh@google.com>
Cc:     io-uring@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
References: <58059c9c-adf9-1683-99f5-7e45280aea87@kernel.dk>
 <58246851-fa45-a72d-2c42-7e56461ec04e@kernel.dk>
 <ec3526fb-948a-70c0-4a7b-866d6cd6a788@rasmusvillemoes.dk>
 <CAG48ez3dpphoQGy8G1-QgZpkMBA2oDjNcttQKJtw5pD62QYwhw@mail.gmail.com>
 <ea7a428d-a5bd-b48e-9680-82a26710ec83@rasmusvillemoes.dk>
 <e568a403-3712-4612-341a-a6f22af877ae@kernel.dk>
 <0f74341f-76fa-93ee-c03e-554d02707053@rasmusvillemoes.dk>
 <6243eb59-3340-deb5-d4b8-08501be01f34@kernel.dk>
 <85e8e954-d09c-f0b4-0944-598208098c8c@kernel.dk>
Message-ID: <1a5b156a-fde5-507b-d5cf-f42ba3eacf1a@kernel.dk>
Date:   Thu, 14 Nov 2019 08:51:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <85e8e954-d09c-f0b4-0944-598208098c8c@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/14/19 8:27 AM, Jens Axboe wrote:
> On 11/14/19 8:20 AM, Jens Axboe wrote:
>> On 11/14/19 8:19 AM, Rasmus Villemoes wrote:
>>> On 14/11/2019 16.09, Jens Axboe wrote:
>>>> On 11/14/19 7:12 AM, Rasmus Villemoes wrote:
>>>
>>>>> So, I can't really think of anybody that might be relying on inheriting
>>>>> a signalfd instead of just setting it up in the child, but changing the
>>>>> semantics of it now seems rather dangerous. Also, I _can_ imagine
>>>>> threads in a process sharing a signalfd (initial thread sets it up and
>>>>> blocks the signals, all threads subsequently use that same fd), and for
>>>>> that case it would be wrong for one thread to dequeue signals directed
>>>>> at the initial thread. Plus the lifetime problems.
>>>>
>>>> What if we just made it specific SFD_CLOEXEC?
>>>
>>> O_CLOEXEC can be set and removed afterwards. Sure, we're far into
>>> "nobody does that" land, but having signalfd() have wildly different
>>> semantics based on whether it was initially created with O_CLOEXEC seems
>>> rather dubious.
>>>
>>>     I don't want to break
>>>> existing applications, even if the use case is nonsensical, but it is
>>>> important to allow signalfd to be properly used with use cases that are
>>>> already in the kernel (aio with IOCB_CMD_POLL, io_uring with
>>>> IORING_OP_POLL_ADD). Alternatively, if need be, we could add a specific
>>>> SFD_ flag for this.
>>>
>>> Yeah, if you want another signalfd flavour, adding it via a new SFD_
>>> flag seems the way to go. Though I can't imagine the resulting code
>>> would be very pretty.
>>
>> Well, it's currently _broken_ for the listed in-kernel use cases, so
>> I think making it work is the first priority here.
> 
> How about something like this, then? Not tested.

Tested, works for me. Here's the test case I used. We setup a signalfd
with SIGALRM, and arm a timer for 100msec. Then we queue a poll for the
signalfd, and wait for that to complete with a timeout of 1 second. If
we time out waiting for the completion, we failed. If we do get a
completion but we don't have POLLIN set, we failed.


#include <unistd.h>
#include <sys/signalfd.h>
#include <sys/poll.h>
#include <sys/time.h>
#include <errno.h>
#include <stdio.h>
#include <string.h>

#include <liburing.h>

#define SFD_TASK	00000001

int main(int argc, char *argv[])
{
	struct __kernel_timespec ts;
	struct io_uring_sqe *sqe;
	struct io_uring_cqe *cqe;
	struct io_uring ring;
	struct itimerval itv;
	sigset_t mask;
	int sfd, ret;

	sigemptyset(&mask);
	sigaddset(&mask, SIGALRM);
	sigprocmask(SIG_BLOCK, &mask, NULL);

	sfd = signalfd(-1, &mask, SFD_NONBLOCK | SFD_CLOEXEC | SFD_TASK);
	if (sfd < 0) {
		if (errno == EINVAL) {
			printf("Not supported\n");
			return 0;
		}
		perror("signalfd");
		return 1;
	}

	memset(&itv, 0, sizeof(itv));
	itv.it_value.tv_sec = 0;
	itv.it_value.tv_usec = 100000;
	setitimer(ITIMER_REAL, &itv, NULL);

	io_uring_queue_init(32, &ring, 0);
	sqe = io_uring_get_sqe(&ring);
	io_uring_prep_poll_add(sqe, sfd, POLLIN);
	io_uring_submit(&ring);

	ts.tv_sec = 1;
	ts.tv_nsec = 0;
	ret = io_uring_wait_cqe_timeout(&ring, &cqe, &ts);
	if (ret < 0) {
		fprintf(stderr, "Timed out waiting for cqe\n");
		ret = 1;
	} else {
		if (cqe->res < 0) {
			fprintf(stderr, "cqe failed with %d\n", cqe->res);
			ret = 1;
		} else if (!(cqe->res & POLLIN)) {
			fprintf(stderr, "POLLIN not set in result mask?\n");
			ret = 1;
		} else {
			ret = 0;
		}
	}
	io_uring_cqe_seen(&ring, cqe);

	io_uring_queue_exit(&ring);
	close(sfd);
	return ret;
}

-- 
Jens Axboe

