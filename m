Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39506BB77F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2019 17:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbfIWPGw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Sep 2019 11:06:52 -0400
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:37068 "EHLO
        forwardcorp1j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726054AbfIWPGw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Sep 2019 11:06:52 -0400
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::301])
        by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 555682E147E;
        Mon, 23 Sep 2019 18:06:48 +0300 (MSK)
Received: from vla5-2bf13a090f43.qloud-c.yandex.net (vla5-2bf13a090f43.qloud-c.yandex.net [2a02:6b8:c18:3411:0:640:2bf1:3a09])
        by mxbackcorp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id LXwfn27u5e-6lL4Kv1i;
        Mon, 23 Sep 2019 18:06:48 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1569251208; bh=Y6U3tSiPz0hrvdsJTx8ZUTeNaokC8gQiPkS2jx87AIQ=;
        h=In-Reply-To:Message-ID:From:Date:References:To:Subject:Cc;
        b=xZgx83uAgxA0VhhQbGmhCg+PnNLqeqd12GXqBk8hHY2zSJIyt8dLriJFw4G9LwGqc
         GwgYtxnwEHnlSpGcxlpW5CRFFwXeGJRLt07cCKcT3qn59huunmpRnR69Qj9qZrgJ7y
         O3CdfuF9CB6Oq3/PmR/qvEYAW77O6pBBlVlWaIIs=
Authentication-Results: mxbackcorp1o.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:344a:8fe6:6594:f7b2])
        by vla5-2bf13a090f43.qloud-c.yandex.net (nwsmtp/Yandex) with ESMTPSA id BZTsvyuZ7l-6kIG6iKd;
        Mon, 23 Sep 2019 18:06:47 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Subject: Re: [PATCH v2] mm: implement write-behind policy for sequential file
 writes
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Michal Hocko <mhocko@suse.com>,
        Dave Chinner <david@fromorbit.com>,
        Mel Gorman <mgorman@suse.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <156896493723.4334.13340481207144634918.stgit@buzz>
 <875f3b55-4fe1-e2c3-5bee-ca79e4668e72@yandex-team.ru>
 <20190923145242.GF2233839@devbig004.ftw2.facebook.com>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <ed5d930c-88c6-c8e4-4a6c-529701caa993@yandex-team.ru>
Date:   Mon, 23 Sep 2019 18:06:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190923145242.GF2233839@devbig004.ftw2.facebook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 23/09/2019 17.52, Tejun Heo wrote:
> Hello, Konstantin.
> 
> On Fri, Sep 20, 2019 at 10:39:33AM +0300, Konstantin Khlebnikov wrote:
>> With vm.dirty_write_behind 1 or 2 files are written even faster and
> 
> Is the faster speed reproducible?  I don't quite understand why this
> would be.

Writing to disk simply starts earlier.

> 
>> during copying amount of dirty memory always stays around at 16MiB.
> 
> The following is the test part of a slightly modified version of your
> test script which should run fine on any modern systems.
> 
>    for mode in 0 1; do
> 	  if [ $mode == 0 ]; then
> 		  prefix=''
> 	  else
> 		  prefix='systemd-run --user --scope -p MemoryMax=64M'
> 	  fi
> 
> 	  echo COPY
> 	  time $prefix cp -r dummy copy
> 
> 	  grep Dirty /proc/meminfo
> 
> 	  echo SYNC
> 	  time sync
> 
> 	  rm -fr copy
>    done
> 
> and the result looks like the following.
> 
>    $ ./test-writebehind.sh
>    SIZE
>    3.3G    dummy
>    COPY
> 
>    real    0m2.859s
>    user    0m0.015s
>    sys     0m2.843s
>    Dirty:           3416780 kB
>    SYNC
> 
>    real    0m34.008s
>    user    0m0.000s
>    sys     0m0.008s
>    COPY
>    Running scope as unit: run-r69dca5326a9a435d80e036435ff9e1da.scope
> 
>    real    0m32.267s
>    user    0m0.032s
>    sys     0m4.186s
>    Dirty:             14304 kB
>    SYNC
> 
>    real    0m1.783s
>    user    0m0.000s
>    sys     0m0.006s
> 
> This is how we are solving the massive dirtier problem.  It's easy,
> works pretty well and can easily be tailored to the specific
> requirements.
> 
> Generic write-behind would definitely have other benefits and also a
> bunch of regression possibilities.  I'm not trying to say that
> write-behind isn't a good idea but it'd be useful to consider that a
> good portion of the benefits can already be obtained fairly easily.
> 

I'm afraid this could end badly if each simple task like file copying
will require own systemd job and container with manual tuning.
