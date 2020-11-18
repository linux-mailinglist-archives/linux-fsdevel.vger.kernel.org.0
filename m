Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9B7F2B7ACB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Nov 2020 10:57:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbgKRJzs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Nov 2020 04:55:48 -0500
Received: from mx2.suse.de ([195.135.220.15]:52186 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725804AbgKRJzr (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Nov 2020 04:55:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8DCB7ABDE;
        Wed, 18 Nov 2020 09:55:46 +0000 (UTC)
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        Richard Weinberger <richard@nod.at>, Jan Kara <jack@suse.com>,
        linux-block@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-bcache@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
References: <20201118084800.2339180-1-hch@lst.de>
 <20201118084800.2339180-20-hch@lst.de>
 <e7f826fd-cb9c-b4ab-fae8-dad398c14eed@suse.de> <X7TlIzxJPfa2p+Da@kroah.com>
From:   Coly Li <colyli@suse.de>
Subject: Re: [PATCH 19/20] bcache: remove a superflous lookup_bdev all
Message-ID: <24c818c2-6aba-098c-0c73-0a5081175c06@suse.de>
Date:   Wed, 18 Nov 2020 17:55:38 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <X7TlIzxJPfa2p+Da@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/18/20 5:10 PM, Greg KH wrote:
> On Wed, Nov 18, 2020 at 04:54:51PM +0800, Coly Li wrote:
>> On 11/18/20 4:47 PM, Christoph Hellwig wrote:
>>> Don't bother to call lookup_bdev for just a slightly different error
>>> message without any functional change.
>>>
>>> Signed-off-by: Christoph Hellwig <hch@lst.de>ist
>>
>> Hi Christoph,
>>
>> NACK. This removing error message is frequently triggered and observed,
>> and distinct a busy device and an already registered device is important
>> (the first one is critical error and second one is not).
>>
>> Remove such error message will be a functional regression.
> 
> What normal operation causes this error message to be emitted?  And what
> can a user do with it?

When there was bug and the caching or backing device was not
unregistered successfully, people could see "device busy"; and if it was
because the device registered again, it could be "already registered".
Without the different message, people may think the device is always
busy but indeed it isn't.

he motivation of the patch is OK to me, but we need to make the logical
consistent, otherwise we will have similar bug report for bogus warning
dmesg from bcache users in soon future.

Coly Li
