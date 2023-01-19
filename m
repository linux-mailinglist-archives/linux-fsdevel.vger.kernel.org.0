Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D025C6740D9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jan 2023 19:25:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbjASSZf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Jan 2023 13:25:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbjASSZa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Jan 2023 13:25:30 -0500
X-Greylist: delayed 1799 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 19 Jan 2023 10:25:16 PST
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::2:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E015394323;
        Thu, 19 Jan 2023 10:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
        s=42; h=From:Cc:To:Date:Message-ID;
        bh=Gc4QRic3oOW9jZaNZmu54QNDymxEhCF0UTpzB08co6Q=; b=H9EbDT6g8xJehZrjzjvPj+Rpdl
        3shbnqV44QWZV+w7vBunk5zdZ7YXF3sI6hxb6JV3OVBooar0NU3XBfM2tKiNuwf9UoQL+jD2V4WwV
        zDNk3V2sCPp5HpPUMFtw+KbAehs8opS6wHqVgmhAbjgYFNoG/7iG2Q8UperkhaXb/QX+vLgwCNgco
        oojp2E6wKCr397zSM1qC4/a8iRCJoE4AUGxAEVq8tNRp7oT/HbcbCPcS/5KpvFqSVjir5Ur+j1/xT
        NSSnlHjie1IIVn7M13BQKihQ1qIE75CbEZyPG7DJm64CelF0gWPM/i/VktaCgp2Y9en+8mOb0rYet
        kCRny1lG6BjlEOSL58IrUKexITfdQzYVpb2j+/8YtU/5Rfa9bd9lsM2qbDp4D+gIJP9DiiOLVvwT6
        qh8gVjGxc1cdfqhzr45zp4adk6oICkANGJDXh9QOhr8tuDzf+vRkbWM7366YhDGO1KB3YaS7DAm0n
        JSm6H6/Kuvj4uXNUi6OeVuUh;
Received: from [127.0.0.2] (localhost [127.0.0.1])
        by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
        (Exim)
        id 1pIXjP-009NuW-1f; Thu, 19 Jan 2023 16:25:39 +0000
Message-ID: <8a6b6192-0413-a0cf-218e-4b86c5de3f8a@samba.org>
Date:   Thu, 19 Jan 2023 17:25:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v6 31/34] cifs: Fix problem with encrypted RDMA data read
Content-Language: en-US, de-DE
To:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     Steve French <smfrench@gmail.com>, Tom Talpey <tom@talpey.com>,
        Long Li <longli@microsoft.com>,
        Namjae Jeon <linkinjeon@kernel.org>,
        linux-cifs@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <167391047703.2311931.8115712773222260073.stgit@warthog.procyon.org.uk>
 <167391070712.2311931.8909671251130425914.stgit@warthog.procyon.org.uk>
From:   Stefan Metzmacher <metze@samba.org>
In-Reply-To: <167391070712.2311931.8909671251130425914.stgit@warthog.procyon.org.uk>
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

Am 17.01.23 um 00:11 schrieb David Howells:
> When the cifs client is talking to the ksmbd server by RDMA and the ksmbd
> server has "smb3 encryption = yes" in its config file, the normal PDU
> stream is encrypted, but the directly-delivered data isn't in the stream
> (and isn't encrypted), but is rather delivered by DDP/RDMA packets (at
> least with IWarp).

In that case the client must not use DDP/RDMA offload!
This needs to be fixed in the request code for both read and write!

metze
