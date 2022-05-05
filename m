Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F98F51C36F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 May 2022 17:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350336AbiEEPK0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 May 2022 11:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232149AbiEEPKZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 May 2022 11:10:25 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D93D12ED67;
        Thu,  5 May 2022 08:06:45 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2BAE468AA6; Thu,  5 May 2022 17:06:42 +0200 (CEST)
Date:   Thu, 5 May 2022 17:06:41 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        "Darrick J. Wong" <djwong@kernel.org>, linux-btrfs@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/5] iomap: add per-iomap_iter private data
Message-ID: <20220505150641.GA19810@lst.de>
References: <20220504162342.573651-1-hch@lst.de> <20220504162342.573651-3-hch@lst.de> <9d53e1bd-b370-cc8c-5194-fa084b887ecc@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d53e1bd-b370-cc8c-5194-fa084b887ecc@suse.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 05, 2022 at 11:06:50AM +0300, Nikolay Borisov wrote:
>> @@ -520,6 +520,14 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
>>   	dio->submit.waiter = current;
>>   	dio->submit.poll_bio = NULL;
>>   +	/*
>> +	 * Transfer the private data that was passed by the caller to the
>> +	 * iomap_iter, and clear it in the iocb, as iocb->private will be
>> +	 * used for polled bio completion later.
>> +	 */
>> +	iomi.private = iocb->private;
>> +	WRITE_ONCE(iocb->private, NULL);
>
> nit: Why use WRITE_ONCE here? Generaly when it's used it will suggest to 
> the reader something funny is going on with accessing that variable without 
> holding a particular lock?

Because we use WRITE_ONCE on iocb->private later on when we use it to
store the bio that is polled for, and we really want the store that
clears it to NULL to be done before we start dealing with bio submission.
