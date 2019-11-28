Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F039A10CF7D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2019 22:17:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbfK1VR1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Nov 2019 16:17:27 -0500
Received: from mail.phunq.net ([66.183.183.73]:35968 "EHLO phunq.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726558AbfK1VR1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Nov 2019 16:17:27 -0500
Received: from [172.16.1.14]
        by phunq.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
        (Exim 4.92.3)
        (envelope-from <daniel@phunq.net>)
        id 1iaRAD-0006J6-Aq; Thu, 28 Nov 2019 13:17:25 -0800
Subject: Re: [RFC] Thing 1: Shardmap fox Ext4
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
References: <176a1773-f5ea-e686-ec7b-5f0a46c6f731@phunq.net>
 <20191127142508.GB5143@mit.edu>
 <c3636a43-6ae9-25d4-9483-34770b6929d0@phunq.net>
 <20191128022817.GE22921@mit.edu>
From:   Daniel Phillips <daniel@phunq.net>
Message-ID: <4c8c3948-5aa1-6a41-c0a9-cc694e89a579@phunq.net>
Date:   Thu, 28 Nov 2019 13:17:24 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191128022817.GE22921@mit.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019-11-27 6:28 p.m., Theodore Y. Ts'o wrote:
> The use of C++ with templates is presumably one of the "less so"
> parts, and it was that which I had in mind when I said,
> "reimplementing from scratch".

Ah, duopack and tripack. Please consider the C code that was replaced.
by those. See tons of bogus extra parameters resulting in nonsense like
this:

   set_entry(shard_entry(shard, bucket), key & bitmask(shard->lowbits), loc, next, shard->locbits, nextbits);

which in the c++ version looks like:

   *entry = {trio.pack(next, loc, key & bitmask(lowbits))};

They generate roughly identical machine code, but I know which one I prefer
to maintain. That said, porting back to C (in progress right now) includes
substituting some appropriate macro code for those sweet little variable
field width structure templates. Which by the way are central to Shardmap's
scalability and performance. These are what allow the index entry to stay
at just 8 bytes over the entire range from one entry to one billion.

So right, tripack and duopack weill be reimplemented from scratch, using 
the template code as a model. Basically just expanding the templates by
hand and adding in some macro sugar for clarity. Shardmap itself does not
need to be rewritten from scratch in order to port to kernel, far from it.

Regards,

Daniel







