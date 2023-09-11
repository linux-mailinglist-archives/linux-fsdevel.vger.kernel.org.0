Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2A1B79A4E8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Sep 2023 09:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232471AbjIKHri (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Sep 2023 03:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231694AbjIKHrh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Sep 2023 03:47:37 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4602A10EC;
        Mon, 11 Sep 2023 00:46:57 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4788D218DF;
        Mon, 11 Sep 2023 07:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1694418320; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MJNZv4oXxKfQte9TmKBOGgbcbZkRHW4Xw8D72ufYQcU=;
        b=FXLMifnFPT7Hb2E+ShASn04gLJntaLjHbkNCb5FIgVq+TQHG4ji0js9e+MaxWqd87JMUtf
        aYYWObtWLVLBQyYCcSY88Q0nU7ydYBIuobf0nFnW053ZEronfsYxdSi8uUodVfUF6LNfnb
        iyv3X0jfskigaZ0/y2JzFgdHqO763vw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1694418320;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MJNZv4oXxKfQte9TmKBOGgbcbZkRHW4Xw8D72ufYQcU=;
        b=4sbFVSbW7T87o/hysAf1k2UEqWUhYOWt8vEOal8rAj0tiWDlPuyYtl68yTIiyJojt7nuia
        t0DOtzliX3u6XTAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DF5C9139CC;
        Mon, 11 Sep 2023 07:45:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mrbHNY/F/mTKbAAAMHmgww
        (envelope-from <hare@suse.de>); Mon, 11 Sep 2023 07:45:19 +0000
Message-ID: <19be4f1f-dc2a-47e7-a7d0-94f3a18778d3@suse.de>
Date:   Mon, 11 Sep 2023 09:45:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 09/12] dm: Add support for copy offload
Content-Language: en-US
To:     Nitesh Shetty <nj.shetty@samsung.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        martin.petersen@oracle.com, mcgrof@kernel.org,
        gost.dev@samsung.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
References: <20230906163844.18754-1-nj.shetty@samsung.com>
 <CGME20230906164407epcas5p3f9e9f33e15d7648fd1381cdfb97d11f2@epcas5p3.samsung.com>
 <20230906163844.18754-10-nj.shetty@samsung.com>
 <cb767dc9-1732-4e31-bcc6-51c187750d66@suse.de>
 <20230911070724.GA28177@green245>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230911070724.GA28177@green245>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/11/23 09:07, Nitesh Shetty wrote:
> On Fri, Sep 08, 2023 at 08:13:37AM +0200, Hannes Reinecke wrote:
>> On 9/6/23 18:38, Nitesh Shetty wrote:
>>> Before enabling copy for dm target, check if underlying devices and
>>> dm target support copy. Avoid split happening inside dm target.
>>> Fail early if the request needs split, currently splitting copy
>>> request is not supported.
>>>
>> And here is where I would have expected the emulation to take place;
>> didn't you have it in one of the earlier iterations?
> 
> No, but it was the other way round.
> In dm-kcopyd we used device offload, if that was possible, before using default
> dm-mapper copy. It was dropped in the current series,
> to streamline the patches and make the series easier to review.
> 
>> After all, device-mapper already has the infrastructure for copying
>> data between devices, so adding a copy-offload emulation for device-mapper
>> should be trivial.
> I did not understand this, can you please elaborate ?
> 
Please see my comments to patch 04.
We should only implement copy-offload if there is a dedicated 
infrastructure in place. But we should not have a 'generic' copy-offload 
emulation.
Problem is that 'real' copy-offload functionalities (ie for NVMe or 
SCSI) are riddled with corner-cases where copy-offload does _not_ work,
and where commands might fail if particular conditions are not met.
Falling back to a generic implementation will cause applications to 
assume that copy-offload worked, and that it gained performance as
the application just had to issue a single command.
Whereas in fact the opposite is true; it wasn't a single command, and 
the application might have performed better by issuing the commands
itself.
Returning -EOPNOTSUPP in these cases will inform the application that 
the attempt didn't work, and that it will have to fall back to the
'normal' copy.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman

