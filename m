Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF7EE6867D6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Feb 2023 15:01:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbjBAOBA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Feb 2023 09:01:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbjBAOA7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Feb 2023 09:00:59 -0500
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::2:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 811871BC6;
        Wed,  1 Feb 2023 06:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
        s=42; h=From:Cc:To:Date:Message-ID;
        bh=SIVPGp1m/WXlQC/7LheJPFC60E4/kYUyxmIpLpvBOiI=; b=Q25P//OgCzWkORTWuev/RNwPJv
        VKgbpuhX1UOnGxXHfma5jK5HGiPMrBKJX6bkRkn29Rmk0ZDaxf6B2NvrRPg6uAhcr+HrehtsaxU1k
        qTFItGGjcwSlFhGoFhs5H85stAy/gjMsXWlB1hde+qi+J0mEnBT0LjLZq8SDm5QepfQTtLWnKkYxo
        od1bZWJqqpjV98540T8Ecu01uahxDQ5AlgGfjkZDLqGGRvNg9y25eBnXVsF8Y87UTtqwv+6Oi/sOQ
        ERNMP2dt4w2WJz5nTJof0G6ZGWaIvx6YFyY3aRoICWEjKJDsoI+LPyxEa3eg4NF57oFbStBJdjYhS
        ZIWFvnRuJArj2MPyatmnXAixrdQYLWag7kn4fdbPw+WURCR343eANa7IjYQFtrC7zDqVGN5lod9Pe
        fTLDC9k5zO5QPCObe9zyfE3MAkhy5sdosKXLQZaaI04JUWVQkalARAxsWpzds1r8wCRyFVErpuRvz
        Cr53TOwXODN3vJOgw/3n3g/V;
Received: from [127.0.0.2] (localhost [127.0.0.1])
        by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
        (Exim)
        id 1pNDfT-00BF2w-Lr; Wed, 01 Feb 2023 14:00:55 +0000
Message-ID: <4d3e67b1-478e-a10e-4f37-ff284183a988@samba.org>
Date:   Wed, 1 Feb 2023 15:00:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 11/12] cifs: Fix problem with encrypted RDMA data read
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>
Cc:     Steve French <smfrench@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Tom Talpey <tom@talpey.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>, linux-cifs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Long Li <longli@microsoft.com>,
        Namjae Jeon <linkinjeon@kernel.org>
References: <20230131182855.4027499-1-dhowells@redhat.com>
 <20230131182855.4027499-12-dhowells@redhat.com>
 <Y9pq+YUf/iFE8JUC@infradead.org>
From:   Stefan Metzmacher <metze@samba.org>
In-Reply-To: <Y9pq+YUf/iFE8JUC@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Am 01.02.23 um 14:36 schrieb Christoph Hellwig:
> On Tue, Jan 31, 2023 at 06:28:54PM +0000, David Howells wrote:
>> When the cifs client is talking to the ksmbd server by RDMA and the ksmbd
>> server has "smb3 encryption = yes" in its config file, the normal PDU
>> stream is encrypted, but the directly-delivered data isn't in the stream
>> (and isn't encrypted), but is rather delivered by DDP/RDMA packets (at
>> least with IWarp).
> 
> This really needs to be split into a separate backportable fix series.
> And it seems like Stefan has just send such a series.

My changes are triggered by this commit...

Now I'm looking more closely as I didn't understand it...
