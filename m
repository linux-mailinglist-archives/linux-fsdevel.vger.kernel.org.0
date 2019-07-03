Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F24425DAC3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2019 03:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbfGCBZ7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Jul 2019 21:25:59 -0400
Received: from mail-ed1-f50.google.com ([209.85.208.50]:42922 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727101AbfGCBZ6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Jul 2019 21:25:58 -0400
Received: by mail-ed1-f50.google.com with SMTP id z25so371283edq.9;
        Tue, 02 Jul 2019 18:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iwz65avk0f/RVYyKHLQjdNvxMZcgy+RzsGyBsM/m87E=;
        b=Jc6n7jBm97mAvshr0fb/+jJV51H5AJKiJiMbjM/ReftdwufEfb70lK4ZkkbRHUK216
         rJ5wVZAiPoVRmFxAc/XYVurtEZCjyjKkBCmrOJeVVdKO/B2t2YFzIiNdnROpXW4o/95b
         SO6+9K/mNErFkxKTr28/Z+4vRwYT0yFsh1QGdl/zj892xmNC+xrEuJH71Q9ogPqxk/6V
         xrIJHfFep+3lpyhmV7N8d/ni0rEzdl6EP75/kHFINZqep674pizWO3MpAmdOoc54OgEX
         e2ot/13DMG1Wtu+VZpVYkBwoK8GZw2BdTuSs5XJEeN/r6lJzHwJQQCMT5+za8g4VO7Yu
         3c+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iwz65avk0f/RVYyKHLQjdNvxMZcgy+RzsGyBsM/m87E=;
        b=Sm1h4SZlRtgeHXGx7MjEdZqUQthIQBZh+4tAjq4GgNNT4vr33CadPPZdRsvrRR/Zvj
         vr8h0e+CtIbn2SYuC/JUehpJxUJOB6b6K/KWZ9OEOy8GI9ouYB6gr9m95dVK0/cEl0Ji
         V+C7VVMrIEY28NyP2D2ZX/WUZ4OXRzZxxnvTJ07USInGg7gEoZbFoIdQlC/cvX5U/zRG
         fUJWv/jBW560liyWsBxO/QaLTLxiVNm1p9mb0qmLKrdYMUIMNyI6hSlJCSqlJZwMYLzd
         jKYC8J280qYzZrlUx8nAlyA5jG96PWOE63lQ9rUj20bRfHW0/Dt+AfyJS3TQkZgqSr3N
         MHlQ==
X-Gm-Message-State: APjAAAVVS1n4F4qgNgHHfsnIiEg44anFN0E7kAyMdVO44LLHtBZBLyiO
        pNhqnQoI+IDttVtLXa0Cm1s=
X-Google-Smtp-Source: APXvYqwGl54w+Ikuy3dP0wltd7CGiue8snyL34ahEULNWHszDm8iYpLIABCZtv5+e1gtZn6FOx9Uag==
X-Received: by 2002:a50:a5b7:: with SMTP id a52mr39299193edc.237.1562117156841;
        Tue, 02 Jul 2019 18:25:56 -0700 (PDT)
Received: from [10.68.217.182] ([217.70.211.18])
        by smtp.gmail.com with ESMTPSA id 43sm204196edz.87.2019.07.02.18.25.54
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jul 2019 18:25:56 -0700 (PDT)
Subject: Re: pagecache locking
To:     Patrick Farrell <pfarrell@whamcloud.com>,
        Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Dave Chinner <dchinner@redhat.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20190612162144.GA7619@kmo-pixel>
 <20190612230224.GJ14308@dread.disaster.area>
 <20190613183625.GA28171@kmo-pixel>
 <20190613235524.GK14363@dread.disaster.area>
 <CAHk-=whMHtg62J2KDKnyOTaoLs9GxcNz1hN9QKqpxoO=0bJqdQ@mail.gmail.com>
 <CAHk-=wgz+7O0pdn8Wfxc5EQKNy44FTtf4LAPO1WgCidNjxbWzg@mail.gmail.com>
 <20190617224714.GR14363@dread.disaster.area>
 <CAHk-=wiR3a7+b0cUN45hGp1dvFh=s1i1OkVhoP7CivJxKqsLFQ@mail.gmail.com>
 <CAOQ4uxjqQjrCCt=ixgdUYjBJvKLhw4R9NeMZOB_s2rrWvoDMBw@mail.gmail.com>
 <20190619103838.GB32409@quack2.suse.cz>
 <20190619223756.GC26375@dread.disaster.area>
 <3f394239-f532-23eb-9ff1-465f7d1f3cb4@gmail.com>
 <DM6PR19MB250857CB8A3A1C8279D6F2F3C5FB0@DM6PR19MB2508.namprd19.prod.outlook.com>
From:   Boaz Harrosh <openosd@gmail.com>
Message-ID: <9bc50b26-d424-d48a-16db-6fd7e0e88f79@gmail.com>
Date:   Wed, 3 Jul 2019 04:25:53 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <DM6PR19MB250857CB8A3A1C8279D6F2F3C5FB0@DM6PR19MB2508.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 03/07/2019 04:07, Patrick Farrell wrote:
> Recursively read locking is generally unsafe, that’s why lockdep
> complains about it.  The common RW lock primitives are queued in
> their implementation, meaning this recursive read lock sequence:
> P1 - read (gets lock)
> P2 - write
> P1 - read
> 
> Results not in a successful read lock, but P1 blocking behind P2,
> which is blocked behind P1.  

> Readers are not allowed to jump past waiting writers.

OK thanks that makes sense. I did not know about that last part. Its a kind
of a lock fairness I did not know we have.

So I guess I'll keep my two locks than. The write_locker is the SLOW
path for me anyway, right?

[if we are already at the subject, Do mutexes have the same lock fairness as
 above? Do the write_lock side of rw_sem have same fairness? Something I never
 figured out]

Thanks
Boaz

> 
> - Patrick
