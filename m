Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85D367BBA78
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Oct 2023 16:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232506AbjJFOkD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Oct 2023 10:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbjJFOkC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Oct 2023 10:40:02 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B418F;
        Fri,  6 Oct 2023 07:39:59 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id D02AC6015F;
        Fri,  6 Oct 2023 16:39:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.hr; s=mail;
        t=1696603196; bh=gWbvobNGF28CJLr9wnkGmX50TRcvlH20M3chC9jCr7g=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=mYOXU7apfkw+pqOran3baDkpA3PUAR3xpBANiH1HVl0QMEEbJDsk9B+YBo+PCvf8z
         +WWJQWFn9BjOMDeA91Xdnejcy6By8nQaBNLO944IH8ROVJp3D3LZ/L8I9F1egwKGZz
         SUCt3B9FEzVnbbTjbp50N5Sr3xLpvic8j1LO1VxH0wt4Lg5i1bPo8UMhDxUIG8rsNi
         WOi8DKUH54QreiqHy6siDljMJjeGofO/T0ZUBWr0FWoH50wtmbu//TmlijWtzrxyik
         NijWlgHnS7TtEOebacd8lQEY79SFuwST326RqUuUqVU8s41M/ZYCQKiB8iCVglTpGY
         WY4NCNIjo7hXQ==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 6DIY4nOvsf05; Fri,  6 Oct 2023 16:39:54 +0200 (CEST)
Received: from [IPV6:2001:b68:2:2600:d8db:4285:ac45:389f] (unknown [IPv6:2001:b68:2:2600:d8db:4285:ac45:389f])
        by domac.alu.hr (Postfix) with ESMTPSA id F15CF6015E;
        Fri,  6 Oct 2023 16:39:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1696603194; bh=gWbvobNGF28CJLr9wnkGmX50TRcvlH20M3chC9jCr7g=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=fDl1y89dp+RnVuhSwjmNI3KS9/0GICfJF24QIglm9I4K6gR+SKD9VEtOeUsIRKpLJ
         YjpVja7nr6DdR8K7KmF0bvt+EUDwXzMSjN1Av171uIv3gMrAi/HBKh/wXshSQGILZ/
         F0MTOFM+CtplXwQQb5tZmk2PJ857NVQqehjp72wvulbQju/Me3QAUxSmSSiw4JWRwu
         Oo3s9Kra2TouJKbadvFs6FCmGiijxu3EyfAU91/c1Lu72JTvX/2nTLc6acDUs4CVS1
         T2ksTQMRdAFFWKSBlGbuzmz229+7dKahvOP3RNLA9xYzQCDSeZLwnTVTnIUiPWLsfQ
         g9p+Z8HMb92lw==
Message-ID: <2c7f2acd-ef37-4504-a0e3-f74b66c455ec@alu.unizg.hr>
Date:   Fri, 6 Oct 2023 16:39:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] xarray: fix the data-race in xas_find_chunk() by
 using READ_ONCE()
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>,
        Yury Norov <yury.norov@gmail.com>
Cc:     Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Jan Kara <jack@suse.cz>, Philipp Stanner <pstanner@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Mason <clm@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-mm@kvack.org
References: <20230918044739.29782-1-mirsad.todorovac@alu.unizg.hr>
 <20230918094116.2mgquyxhnxcawxfu@quack3>
 <22ca3ad4-42ef-43bc-51d0-78aaf274977b@alu.unizg.hr>
 <20230918113840.h3mmnuyer44e5bc5@quack3>
 <fb0f5ba9-7fe3-a951-0587-640e7672efec@alu.unizg.hr>
 <ZQhlt/EbRf3Y+0jT@yury-ThinkPad> <20230918155403.ylhfdbscgw6yek6p@quack3>
 <cda628df-1933-cce8-86cd-23346541e3d8@alu.unizg.hr>
 <ZQidZLUcrrITd3Vy@yury-ThinkPad> <ZQkhgVb8nWGxpSPk@casper.infradead.org>
From:   Mirsad Todorovac <mirsad.todorovac@alu.hr>
In-Reply-To: <ZQkhgVb8nWGxpSPk@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/19/2023 6:20 AM, Matthew Wilcox wrote:
> On Mon, Sep 18, 2023 at 11:56:36AM -0700, Yury Norov wrote:
>> Guys, I lost the track of the conversation. In the other email Mirsad
>> said:
>>          Which was the basic reason in the first place for all this, because something changed
>>          data from underneath our fingers ..
>>
>> It sounds clearly to me that this is a bug in xarray, *revealed* by
>> find_next_bit() function. But later in discussion you're trying to 'fix'
>> find_*_bit(), like if find_bit() corrupted the bitmap, but it's not.
> 
> No, you're really confused.  That happens.
> 
> KCSAN is looking for concurrency bugs.  That is, does another thread
> mutate the data "while" we're reading it.  It does that by reading
> the data, delaying for a few instructions and reading it again.  If it
> changed, clearly there's a race.  That does not mean there's a bug!
> 
> Some races are innocuous.  Many races are innocuous!  The problem is
> that compilers sometimes get overly clever and don't do the obvious
> thing you ask them to do.  READ_ONCE() serves two functions here;
> one is that it tells the compiler not to try anything fancy, and
> the other is that it tells KCSAN to not bother instrumenting this
> load; no load-delay-reload.
> 
>> In previous email Jan said:
>>          for any sane compiler the generated assembly with & without READ_ONCE()
>>          will be exactly the same.
>>
>> If the code generated with and without READ_ONCE() is the same, the
>> behavior would be the same, right? If you see the difference, the code
>> should differ.
> 
> Hopefully now you understand why this argument is wrong ...
> 
>> You say that READ_ONCE() in find_bit() 'fixes' 200 KCSAN BUG warnings. To
>> me it sounds like hiding the problems instead of fixing. If there's a race
>> between writing and reading bitmaps, it should be fixed properly by
>> adding an appropriate serialization mechanism. Shutting Kcsan up with
>> READ_ONCE() here and there is exactly the opposite path to the right direction.
> 
> Counterpoint: generally bitmaps are modified with set_bit() which
> actually is atomic.  We define so many bitmap things as being atomic
> already, it doesn't feel like making find_bit() "must be protected"
> as a useful use of time.
> 
> But hey, maybe I'm wrong.  Mirsad, can you send Yury the bug reports
> for find_bit and friends, and Yury can take the time to dig through them
> and see if there are any real races in that mess?
> 
>> Every READ_ONCE must be paired with WRITE_ONCE, just like atomic
>> reads/writes or spin locks/unlocks. Having that in mind, adding
>> READ_ONCE() in find_bit() requires adding it to every bitmap function
>> out there. And this is, as I said before, would be an overhead for
>> most users.
> 
> I don't believe you.  Telling the compiler to stop trying to be clever
> rarely results in a performance loss.

Hi Mr. Wilcox,

Do you think we should submit a formal patch for this data-race?

Thank you.

Best regards,
Mirsad Todorovac
