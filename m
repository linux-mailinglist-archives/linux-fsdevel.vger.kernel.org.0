Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92D8E73EFA2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 02:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbjF0AVj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 20:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjF0AVg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 20:21:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D216E106;
        Mon, 26 Jun 2023 17:21:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6353060FA2;
        Tue, 27 Jun 2023 00:21:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B155EC433C0;
        Tue, 27 Jun 2023 00:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687825294;
        bh=zCYjl2OBZzY4gBfpN8JbQDuXoKlqJcnXNVC28tbkJIA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=j6u9wxc+d8meTtoceA0DzFnZSOeATrF/VR0lRFkHVb36PmEJYm7g3Ndr5iYKl5l7H
         KHEaJoOdZYgw4zNyk0tPGTGJJmmmtuprBwOgvjkSswAmmauo4GfSkRcnuY2tDmYbJ1
         /gabe3kPPle/HOKclxNmw4JUYUwJsqUjYG0t+j6Zm3KXr2cmJ1EG9AP8YQ8Jwh1ukU
         edfMF8gbSSqyhtlN0bhF9KifS9mtCkLBF/TWWTVG1gpTG12KZvzTEzOSIMUIX9x8rg
         A2RsqTdKfU7z7trem6UhXGcwwjeH1HkysVO2xyr5GapIQr8h0cDWOs0In8unhCDAwE
         NoSNnpXHXgwTA==
Message-ID: <7481472f-8950-0801-029c-85264b671c19@kernel.org>
Date:   Tue, 27 Jun 2023 09:21:32 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] zonefs: do not use append if device does not support it
Content-Language: en-US
To:     "Andreas Hindborg (Samsung)" <nmi@metaspace.dk>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     "open list:ZONEFS FILESYSTEM" <linux-fsdevel@vger.kernel.org>,
        "gost.dev@samsung.com" <gost.dev@samsung.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20230626164752.1098394-1-nmi@metaspace.dk>
 <02730282-88b0-572e-439c-719cfef379bb@wdc.com> <87r0pygjp1.fsf@metaspace.dk>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <87r0pygjp1.fsf@metaspace.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/27/23 03:23, Andreas Hindborg (Samsung) wrote:
> 
> Johannes Thumshirn <Johannes.Thumshirn@wdc.com> writes:
> 
>> On 26.06.23 18:47, Andreas Hindborg wrote:
>>> From: "Andreas Hindborg (Samsung)" <nmi@metaspace.dk>
>>>
>>> Zonefs will try to use `zonefs_file_dio_append()` for direct sync writes even if
>>> device `max_zone_append_sectors` is zero. This will cause the IO to fail as the
>>> io vector is truncated to zero. It also causes a call to
>>> `invalidate_inode_pages2_range()` with end set to UINT_MAX, which is probably
>>> not intentional. Thus, do not use append when device does not support it.
>>>
>>
>> I'm sorry but I think it has been stated often enough that for Linux Zone Append
>> is a mandatory feature for a Zoned Block Device. Therefore this path is essentially
>> dead code as max_zone_append_sectors will always be greater than zero.
>>
>> So this is a clear NAK from my side.
> 
> OK, thanks for clarifying 👍 I came across this bugging out while
> playing around with zone append for ublk. The code makes sense if the
> stack expects append to always be present.
> 
> I didn't follow the discussion, could you reiterate why the policy is
> that zoned devices _must_ support append?

To avoid support fragmentation and for performance. btrfs zoned block device
support requires zone append and using that command makes writes much faster as
we do not have to go through zone locking.
Note that for zonefs, I plan to add async zone append support as well, linked
with O_APPEND use to further improve write performance with ZNS drives.

> 
> Best regards,
> Andreas
> 

-- 
Damien Le Moal
Western Digital Research

