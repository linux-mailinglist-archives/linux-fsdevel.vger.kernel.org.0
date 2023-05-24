Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D86AE710192
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 May 2023 01:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236779AbjEXXNd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 May 2023 19:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjEXXNc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 May 2023 19:13:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA6BA9;
        Wed, 24 May 2023 16:13:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE0AE6172F;
        Wed, 24 May 2023 23:13:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09EEDC433EF;
        Wed, 24 May 2023 23:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684970011;
        bh=TZkIpxpAgQpdYh2IdY1lcMnQau3zcUBWqWIr6I9VfCM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Txari5z6ZBrn3Eda4nkNy/2JwwlJLQjqX66l5Nj1swylueJgBUynUXM7+f+DTR2Yw
         HR9sMj4wecpB7wFrt/r3pOAjt92yyEhK5FE5UOB21N1jOZ8Gd9j4ahu36iaAGHwMDx
         r4vnQ4XUkQ04DwFI+3583OuKYAvZKda+Bp7JLd1gjhnAJyrFUiMo+ISPRz2OYdo2Hx
         CiDgSF5RxrSfGS52Sia19Q8VE4zWeibHvMQ8xB5t8JLo9xodX3XtHFESosM9lf789N
         LKIxqhtUcl6HOeXm4r31wWKBtsUbsNoaheWsT8dsnpwrNzF+ifumhMhgTCx0R/OYI+
         P06GpR7c9n3RA==
Message-ID: <5d327bed-b532-ad3b-a211-52ad0a3e276a@kernel.org>
Date:   Thu, 25 May 2023 08:13:28 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v22 25/31] zonefs: Provide a splice-read wrapper
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org
References: <12153db1-20af-040b-ded0-31286b5bafca@kernel.org>
 <20230522135018.2742245-1-dhowells@redhat.com>
 <20230522135018.2742245-26-dhowells@redhat.com>
 <3071148.1684874594@warthog.procyon.org.uk>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <3071148.1684874594@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/24/23 05:43, David Howells wrote:
> Damien Le Moal <dlemoal@kernel.org> wrote:
> 
>>> +	if (len > 0) {
>>> +		ret = filemap_splice_read(in, ppos, pipe, len, flags);
>>> +		if (ret == -EIO)
>>
>> Is -EIO the only error that filemap_splice_read() may return ? There are other
>> IO error codes that we could get from the block layer, e.g. -ETIMEDOUT etc. So
>> "if (ret < 0)" may be better here ?
> 
> It can return -ENOMEM, -EINTR and -EAGAIN at least, none of which really count
> as I/O errors.  I based the splice function on what zonefs_file_read_iter()
> does:
> 
> 	} else {
> 		ret = generic_file_read_iter(iocb, to);
> 		if (ret == -EIO)
> 			zonefs_io_error(inode, false);
> 	}

Fair point. But checking again zonefs_io_error(), it will do nothing is nothing
bad is detected for the zone that was used for the failed IO. So calling
zonefs_io_error() for all error codes is actually fine, and likely much safer. I
will change that in zonefs_file_read_iter(). Please use "if (ret < 0)" in your
patch.

-- 
Damien Le Moal
Western Digital Research

