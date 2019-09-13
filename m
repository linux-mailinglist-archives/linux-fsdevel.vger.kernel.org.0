Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A391B1C7F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2019 13:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728746AbfIMLsT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Sep 2019 07:48:19 -0400
Received: from mail.ispras.ru ([83.149.199.45]:49012 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728621AbfIMLsT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Sep 2019 07:48:19 -0400
Received: from [192.168.43.132] (unknown [176.59.5.179])
        by mail.ispras.ru (Postfix) with ESMTPSA id 39039540089;
        Fri, 13 Sep 2019 14:48:16 +0300 (MSK)
Subject: Re: [PATCH v2] lib/memweight.c: open codes bitmap_weight()
To:     Matthew Wilcox <willy@infradead.org>
Cc:     akpm@linux-foundation.org, Akinobu Mita <akinobu.mita@gmail.com>,
        Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org,
        Matthew Wilcox <matthew@wil.cx>, dm-devel@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-media@vger.kernel.org,
        Erdem Tumurov <erdemus@gmail.com>,
        Vladimir Shelekhov <vshel@iis.nsk.su>
References: <20190821074200.2203-1-efremov@ispras.ru>
 <20190824100102.1167-1-efremov@ispras.ru>
 <20190825061158.GC28002@bombadil.infradead.org>
 <ba051566-0343-ea75-0484-8852f65a15da@ispras.ru>
 <20190826183956.GF15933@bombadil.infradead.org>
From:   Denis Efremov <efremov@ispras.ru>
Message-ID: <85d9e45a-9631-a139-2d65-86a6753a35e6@ispras.ru>
Date:   Fri, 13 Sep 2019 14:48:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <20190826183956.GF15933@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

Sorry for reviving this conversation, but it looks to me like
this function could be reduced to a single bitmap_weight call:

static inline size_t memweight(const void *ptr, size_t bytes)
{
        BUG_ON(bytes >= UINT_MAX / BITS_PER_BYTE);
        return bitmap_weight(ptr, bytes * BITS_PER_BYTE);
}

Comparing to the current implementation
https://elixir.bootlin.com/linux/latest/source/lib/memweight.c#L11 
this results in a signification simplification. 

__bitmap_weight already count last bits with hweight_long as we
discussed earlier.

int __bitmap_weight(const unsigned long *bitmap, unsigned int bits)
{
	...
	if (bits % BITS_PER_LONG)
		w += hweight_long(bitmap[k] & BITMAP_LAST_WORD_MASK(bits));
	...
}

and __arch_hweight* functions use popcnt instruction.

I've briefly tested the equivalence of 2 implementations on x86_64 with
fuzzing here: https://gist.github.com/evdenis/95a8b9b8041e09368b31c3a9510491a5

What do you think making this function static inline and moving it
to include/linux/string.h? I could prepare a patch for it and add some tests for
memweight and bitmap_weight. Or maybe I miss something again?

Best regards,
Denis
