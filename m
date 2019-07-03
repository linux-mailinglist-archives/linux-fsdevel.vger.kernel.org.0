Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9625EB12
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2019 20:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbfGCSDs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Jul 2019 14:03:48 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43188 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbfGCSDr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Jul 2019 14:03:47 -0400
Received: by mail-ed1-f65.google.com with SMTP id e3so2935022edr.10;
        Wed, 03 Jul 2019 11:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HktW2jbQb9daIuq89e7+nyOPIHE/MzRFk27e0RIauhk=;
        b=I6CJEt6Z614d/vSVK4+ovKXsIY1OyStNiw/0DEsDi90EDdqxejjwwm6CxHQoLzDKTh
         Kza0fDDdy+hYQnvd1trjWk2Yot/LCubzZ55fOGVoP51pjW5W8C4CMJj6jlD0Yi7cSVj1
         naxRs6Yrh6fjZuddxCjI18AaGlVJvAI2MfTWOT/+6GOyKJbIaw2xOkVaqVG4UODVWSd9
         Jib8DVlH/MamdEaPyeujMXQRMyITR71/z1UQJBPSmjseVyu1RytxGrisCGbvb4IuZzt8
         hJZWi9Pxr9LOswwOA0pNnT1lK+5DPn3+gKuEKRU3tY/bMDvmm/J1qHhrfTzi+KsxNCfT
         Ig6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HktW2jbQb9daIuq89e7+nyOPIHE/MzRFk27e0RIauhk=;
        b=mI/uJgldtzLvQQTfCfMi5qlOqnVG6mNW/Ek5krGY/r/PdbVgGg4G8y9Xq/VXOP305Q
         N5njfHeyTfQnpK9m9OKXNZZKCuPOvT6qJlhcofCb8tLiL3iyAlTk0lkWX8sTy95bKzLa
         On9DQsR4dRK3xHt30WQeNbIldfuYyv3RT74lXVmlC3sqZZjJQn8benXI2m4GkgQW8lzd
         CWZbJrRbNuUDdX8f/9U0zjB+003WS4voIF1uXC1z40X1mp0wED2s3SxsLxoXmVNfvcML
         FpXgXnSbSgWwkDQvJcDYcMti5M9NjrCwG75b1a6Z4UrRtC6/OXHAonly/Kz6CsoeQFYk
         Ve7w==
X-Gm-Message-State: APjAAAXM4fbEwoxOHhcakgZH9wCwj57gVL4DiRCcnA5m3IMbSGIHZRwe
        aknPhnEJ+kD2W9INI2NYR38=
X-Google-Smtp-Source: APXvYqxJnEihMQhEJBAJmLJZlc+dec6NPvUGNPBXjPZf9NCZYQ3YUxTRIiNzg505Yt6WsP+02smZpw==
X-Received: by 2002:aa7:c515:: with SMTP id o21mr44067179edq.2.1562177025786;
        Wed, 03 Jul 2019 11:03:45 -0700 (PDT)
Received: from [10.68.217.182] ([217.70.211.18])
        by smtp.gmail.com with ESMTPSA id g11sm589222ejm.86.2019.07.03.11.03.43
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2019 11:03:45 -0700 (PDT)
Subject: Re: [PATCH] mm: Support madvise_willneed override by Filesystems
To:     Jan Kara <jack@suse.cz>
Cc:     Dave Chinner <david@fromorbit.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Chinner <dchinner@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-bcache@vger.kernel.org,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Zach Brown <zach.brown@ni.com>, Jens Axboe <axboe@kernel.dk>,
        Josef Bacik <josef@toxicpanda.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Amir Goldstein <amir73il@gmail.com>
References: <20190610191420.27007-1-kent.overstreet@gmail.com>
 <CAHk-=wi0iMHcO5nsYug06fV3-8s8fz7GDQWCuanefEGq6mHH1Q@mail.gmail.com>
 <20190611011737.GA28701@kmo-pixel>
 <20190611043336.GB14363@dread.disaster.area>
 <20190612162144.GA7619@kmo-pixel>
 <20190612230224.GJ14308@dread.disaster.area>
 <20190619082141.GA32409@quack2.suse.cz>
 <27171de5-430e-b3a8-16f1-7ce25b76c874@gmail.com>
 <20190703172141.GD26423@quack2.suse.cz>
From:   Boaz Harrosh <openosd@gmail.com>
Message-ID: <7206059e-5a57-aa46-0a6c-e62b085f6c75@gmail.com>
Date:   Wed, 3 Jul 2019 21:03:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190703172141.GD26423@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 03/07/2019 20:21, Jan Kara wrote:
> On Wed 03-07-19 04:04:57, Boaz Harrosh wrote:
>> On 19/06/2019 11:21, Jan Kara wrote:
>> <>
<>
>> Hi Jan
>>
>> Funny I'm sitting on the same patch since LSF last. I need it too for other
>> reasons. I have not seen, have you pushed your patch yet?
>> (Is based on old v4.20)
> 
> Your patch is wrong due to lock ordering. You should not call vfs_fadvise()
> under mmap_sem. So we need to do a similar dance like madvise_remove(). I
> have to get to writing at least XFS fix so that the madvise change gets
> used and post the madvise patch with it... Sorry it takes me so long.
> 
> 								Honza

Ha Sorry I was not aware of this. Lockdep did not catch it on my setup
because my setup does not have any locking conflicts with mmap_sem on the
WILL_NEED path.

But surly you are right because the all effort is to fix the locking problems.

I will also try in a day or two to do as you suggest, and look at madvise_remove()
once I have a bit of time. Who ever gets to be less busy ...

Thank you for your help
Boaz
