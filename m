Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57BCD7814E1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Aug 2023 23:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241101AbjHRVsZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Aug 2023 17:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241087AbjHRVsT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Aug 2023 17:48:19 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D94412B;
        Fri, 18 Aug 2023 14:48:17 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 56FC060174;
        Fri, 18 Aug 2023 23:48:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1692395295; bh=kYq3e4DSnRWidSKy5n0H2X3KllpBz86zHAUXjGmyKZY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=jBqOdlj5XF0DllTW4g8I/Be9haSOBJ/MJICTI38nhbpbO+yztImjigmU0XHenlHs5
         7KE//EGT5MPBSSACkBbWus9uHOV8azetz9N3gsmM2pQmNtdQf/eqkTFt+kGGKAfYmG
         0607p2auykOwUzcSSijeiMaCN9ETGFz1Zpz4umF2m1WJUtgREXSXFrR/ysvaXA+qTX
         wbB3BfPKHj13+yC+iNcixPHwnR14+28DFdSddqAnJ6p3D9SyaeKoiuKcv7g+WcqS61
         1y8tL+xYsLpv7kCNR8Lf4548TCfMPPrcqggBQ19Vol0EVx2NNBCq+V5vbNB7Z90mvR
         XXGpgkX+ubSZg==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id PDYZX5sLZhkB; Fri, 18 Aug 2023 23:48:12 +0200 (CEST)
Received: from [192.168.1.6] (unknown [94.250.191.183])
        by domac.alu.hr (Postfix) with ESMTPSA id 012216015E;
        Fri, 18 Aug 2023 23:48:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1692395292; bh=kYq3e4DSnRWidSKy5n0H2X3KllpBz86zHAUXjGmyKZY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=btvEHq1sWIXnomXVCaOYnmOfp3y9elwFfHt+Is5jkx4Xrt8XaP6ChEcaVPb0e0LQs
         gMu5Sl3gTPJN5BRM0o78qUsL28nEuBiY1qkPBXe+bQLM0qhjqg355nvaeI39Hi+2s/
         3FaR6r8y0Zdw7knmvILNtTWd2fDvMZ/jW6w2kSCXDQ07ZsIZ2WtVzzQ/oBI1FnRJKm
         D80xfCbyg6lSITua4e5l6V4uhigWzZKZpeL2YYHZfcpcmjoRU01SSC1K+7lB9FISSu
         xaWHmGi936vVhsR8Ax0jBA8jCYnUpPufc4PVrREBWao8p0fGxvnpOuMOm2Bai9k6MG
         XR+xEKPed6h2Q==
Message-ID: <c89c7143-9d83-141d-08ac-c4745f774e71@alu.unizg.hr>
Date:   Fri, 18 Aug 2023 23:47:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [BUG] KCSAN: data-race in xas_clear_mark / xas_find_marked
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <06645d2b-a964-1c4c-15cf-42ccc6c6e19b@alu.unizg.hr>
 <ZN9iPYTmV5nSK2jo@casper.infradead.org>
 <873686fb-6e42-493d-2dcd-f0f04cbcb0c0@alu.unizg.hr>
 <ZN996RyhG8K5u8i7@casper.infradead.org>
Content-Language: en-US
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <ZN996RyhG8K5u8i7@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 8/18/23 16:19, Matthew Wilcox wrote:
> On Fri, Aug 18, 2023 at 03:37:10PM +0200, Mirsad Todorovac wrote:
>> I am new to KCSAN. I was not aware of KCSAN false positives thus far, so my best bet was to report them.
>>
>> I thought that maybe READ_ONCE() was required, but I will trust your judgment.
>>
>> I hope I can find this resolved.
> 
> I haven't looked into KCSAN in any detail, I don't know what the right
> way is to resolve this.

That's OK, I suppose.

I don't feel clarity about it either.

I am certain that the original developers have the big picture. :-)

Best regards,
Mirsad Todorovac
