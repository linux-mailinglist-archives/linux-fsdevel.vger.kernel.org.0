Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E184BB733
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2019 16:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440131AbfIWOwu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Sep 2019 10:52:50 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:45458 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440127AbfIWOwu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Sep 2019 10:52:50 -0400
Received: by mail-qk1-f193.google.com with SMTP id z67so15646533qkb.12;
        Mon, 23 Sep 2019 07:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Cihsrcy+ZQVZz5JC0vGFiq3Z/PSPrpGVXhPvhqb+rOY=;
        b=f5PeulYORxhz3WOQ1pPfWQefeKSMX3DPFUhK6IX+3ZFGl5J4YZs+OspShWQzSTKSva
         iMCdV8LoKrybDSHIBYC3Rfql3TW5h7dtClAKrcf1+r1YFgdmM0IFmundcDdlaQYW09JR
         EfnmvcJCzdsdjBdbl5HsRYQffRHm86zVj/QIDDNc32WrkBax+kAk0j2ZBqfADL0CoxHl
         b45EfOJnUZKMZ9yNtraikYrWb8G12pXoUiUZ9FfYIDeDXtStUF9BTGl4gfSIqG0x1/od
         q9T2f9Gf4zu60KYNVq7TTAPX40S27yxar+7oXy1wO86A9nyO0PSPXfdJMU1eRHxs6pU2
         SOAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Cihsrcy+ZQVZz5JC0vGFiq3Z/PSPrpGVXhPvhqb+rOY=;
        b=SL334DyJHU56M6dDhWbQPXcwgiEa4DYnriMhu0RzXAUbSaaEaTfgvEdQiCRG7H4/tL
         ZUxm1+zOaP2e3vf1brRD/IsshaXPAR6D0D9Vp3wE0ZVwIbQNZEcr1GIoiIY3NE9m50ru
         +3EXdTw+BbpW4zP2iyYbtJBo2aIP45KBD9D1HynuVk0w9bKCDx1UnYMNj2nsjgI/8DW/
         q7Zb2E4LC0cSAkyZ7E+03cjDgIOlGylGOSYJuGHCA3RCVhH4MryoYuYyqiwhQJf5QXw1
         gxC2SLj9cmJ9iTbjZ/dOsKOFs7qHxoP1LVDRgteXMMjuVh6LRaTBi6KLHJhsy4dC6LcB
         GmBw==
X-Gm-Message-State: APjAAAXW1d1gQtgk87GeAfg2ytNp6hEvwwm2T2FRivreFcM/b3pXc5IB
        LhgFzC2jNxKKtlIlndP+9nI=
X-Google-Smtp-Source: APXvYqy7dWYRYJUZoj7yaS2c2MFY0Vo92w266qDfaXXxHEbj9rKr3hlKotaEugAkVtOD0VsMg19YpQ==
X-Received: by 2002:a37:6fc1:: with SMTP id k184mr153829qkc.237.1569250368172;
        Mon, 23 Sep 2019 07:52:48 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::1:83ca])
        by smtp.gmail.com with ESMTPSA id u39sm6397581qtj.34.2019.09.23.07.52.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Sep 2019 07:52:46 -0700 (PDT)
Date:   Mon, 23 Sep 2019 07:52:42 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Michal Hocko <mhocko@suse.com>,
        Dave Chinner <david@fromorbit.com>,
        Mel Gorman <mgorman@suse.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2] mm: implement write-behind policy for sequential file
 writes
Message-ID: <20190923145242.GF2233839@devbig004.ftw2.facebook.com>
References: <156896493723.4334.13340481207144634918.stgit@buzz>
 <875f3b55-4fe1-e2c3-5bee-ca79e4668e72@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875f3b55-4fe1-e2c3-5bee-ca79e4668e72@yandex-team.ru>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello, Konstantin.

On Fri, Sep 20, 2019 at 10:39:33AM +0300, Konstantin Khlebnikov wrote:
> With vm.dirty_write_behind 1 or 2 files are written even faster and

Is the faster speed reproducible?  I don't quite understand why this
would be.

> during copying amount of dirty memory always stays around at 16MiB.

The following is the test part of a slightly modified version of your
test script which should run fine on any modern systems.

  for mode in 0 1; do
	  if [ $mode == 0 ]; then
		  prefix=''
	  else
		  prefix='systemd-run --user --scope -p MemoryMax=64M'
	  fi

	  echo COPY
	  time $prefix cp -r dummy copy

	  grep Dirty /proc/meminfo

	  echo SYNC
	  time sync

	  rm -fr copy
  done

and the result looks like the following.

  $ ./test-writebehind.sh
  SIZE
  3.3G    dummy
  COPY

  real    0m2.859s
  user    0m0.015s
  sys     0m2.843s
  Dirty:           3416780 kB
  SYNC

  real    0m34.008s
  user    0m0.000s
  sys     0m0.008s
  COPY
  Running scope as unit: run-r69dca5326a9a435d80e036435ff9e1da.scope

  real    0m32.267s
  user    0m0.032s
  sys     0m4.186s
  Dirty:             14304 kB
  SYNC

  real    0m1.783s
  user    0m0.000s
  sys     0m0.006s

This is how we are solving the massive dirtier problem.  It's easy,
works pretty well and can easily be tailored to the specific
requirements.

Generic write-behind would definitely have other benefits and also a
bunch of regression possibilities.  I'm not trying to say that
write-behind isn't a good idea but it'd be useful to consider that a
good portion of the benefits can already be obtained fairly easily.

Thanks.

-- 
tejun
