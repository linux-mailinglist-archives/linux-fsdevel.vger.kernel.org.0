Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E35915AB242
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Sep 2022 15:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238379AbiIBNyc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Sep 2022 09:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238815AbiIBNyC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Sep 2022 09:54:02 -0400
Received: from smtp-8fac.mail.infomaniak.ch (smtp-8fac.mail.infomaniak.ch [IPv6:2001:1600:4:17::8fac])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A881E114C4D
        for <linux-fsdevel@vger.kernel.org>; Fri,  2 Sep 2022 06:28:36 -0700 (PDT)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4MJyy91GrqzMpxcm;
        Fri,  2 Sep 2022 15:12:49 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4MJyy83BDzzlh8Tx;
        Fri,  2 Sep 2022 15:12:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1662124369;
        bh=NZuPz5CF88YaZt2LzRpCh3DjFQ0672gh8CixqZNr/po=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=iufP62Py6dUyfFCZU29paNvSI45kH20mvfnBxS3wCPSy4CD1LIZMXA1ptYBgw5ZDS
         zwBr1r9UpkV+15JODcJ2PFGSAvxShKezmNqvGLyt/bED0EtoB05JMuDE3H6PaYQZuV
         Hgs+3CoVcc4gkl9GlF/kQrTpbCpqvwRX8UzVebME=
Message-ID: <a2b5b85f-bca6-ee7b-d6ad-e1503f3bd447@digikod.net>
Date:   Fri, 2 Sep 2022 15:12:47 +0200
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH v5 0/4] landlock: truncate support
Content-Language: en-US
To:     xiujianfeng <xiujianfeng@huawei.com>,
        =?UTF-8?Q?G=c3=bcnther_Noack?= <gnoack3000@gmail.com>,
        linux-security-module@vger.kernel.org
Cc:     James Morris <jmorris@namei.org>, Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-fsdevel@vger.kernel.org,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
References: <20220817203006.21769-1-gnoack3000@gmail.com>
 <b336dcfc-7d28-dea9-54de-0b8e4b725c1c@digikod.net>
 <0bf1e5f2-3764-d697-d3ab-d3c4064484ef@huawei.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <0bf1e5f2-3764-d697-d3ab-d3c4064484ef@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 02/09/2022 14:26, xiujianfeng wrote:
> Hi,
> 
> 在 2022/9/2 1:10, Mickaël Salaün 写道:
>> Hmm, I think there is an issue with this series. Landlock only enforces
>> restrictions at open time or when dealing with user-supplied file paths
>> (relative or absolute). The use of the path_truncate hook in this series
>> doesn't distinguish between file descriptor from before the current
>> sandbox or from after being sandboxed. For instance, if a file
>> descriptor is received through a unix socket, it is assumed that this is
>> legitimate and no Landlock restriction apply on it, which is not the
>> case with this series anymore. It is the same for files opened before
>> the process sandbox itself.
> 
> so I think this issue also exists in the chown/chmod series, right?
> there is a testcase in that patchset verify the corresponding rights
> inside the sanbox with a fd opened before sanboxing.

Correct. For LANDLOCK_ACCESS_FS_TRUNCATE, we need to add tests to make 
sure that:
* a sandboxed process with the truncate restriction can open a file in 
write mode, forward it to an un-sandboxed process, and make sure this 
receiver cannot truncate the file descriptor, nor its dup.
* an inherited file descriptor can be truncated even if done by a 
sandboxed process, except if it was created by a sandboxed process and 
the truncate restriction applied on it.

However, for the file metadata accesses, I suggest you first focus on 
the inode_setattr and inode_setxattr hook modifications. We'll get back 
to this FD-based restrictions later.
