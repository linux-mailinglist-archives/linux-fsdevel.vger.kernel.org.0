Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E15256201B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jun 2022 18:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236308AbiF3QSo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jun 2022 12:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235069AbiF3QSa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jun 2022 12:18:30 -0400
Received: from mail.yonan.net (mail.yonan.net [54.244.116.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB4C1EECA;
        Thu, 30 Jun 2022 09:18:30 -0700 (PDT)
Received: from [10.10.0.40] (unknown [76.130.91.106])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.yonan.net (Postfix) with ESMTPSA id 546323E880;
        Thu, 30 Jun 2022 16:18:29 +0000 (UTC)
Message-ID: <cd783f6c-9aa6-2f63-000c-4bcb252a3567@openvpn.net>
Date:   Thu, 30 Jun 2022 10:18:28 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] namei: implemented RENAME_NEWER flag for renameat2()
 conditional replace
Content-Language: en-US
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
References: <20220627221107.176495-1-james@openvpn.net>
 <CAOQ4uxi5mKd1OuAcdFemx=h+1Ay-Ka4F6ddO5_fjk7m6G88MuQ@mail.gmail.com>
 <3062694c-8725-3653-a8e6-de2942aed1c2@openvpn.net>
 <CAOQ4uxjfZ=c4Orm2VcbsOuqEkdsXViZhxLN55CN5-5ZtSqj4Sg@mail.gmail.com>
From:   James Yonan <james@openvpn.net>
In-Reply-To: <CAOQ4uxjfZ=c4Orm2VcbsOuqEkdsXViZhxLN55CN5-5ZtSqj4Sg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/28/22 23:15, Amir Goldstein wrote:
>> because the application layer has already done the heavy lifting on the
>> networking side so that the filesystem layer can be local, fast, and
>> atomic.  So yes, I haven't tested this yet on networked filesystems.
>> But I'm thinking that because all functionality is implemented at the
>> VFS layer, it should be portable to any fs that also supports
>> RENAME_NOREPLACE, with the caveat that it depends on the ability of the
>> VFS to get a current and accurate mtime attribute inside the critical
>> section between lock_rename() and unlock_rename().
> The implementation is generic. You just implement the logic in the vfs and
> enable it for a few tested filesystems and whoever wants to join the party
> is welcome to test their own filesystems and opt-in to the new flag whether
> they like. Nothing wrong with that.
>
> w.r.t stability of i_mtime, if I am not mistaken i_mtime itself is
> stable with inode
> lock held (i.e. after lock_two_nondirectories()), however, as Dave pointed out,
> the file's data can be modified in page cache, so as long as the file is open
> for write or mmaped writable, the check of mtime is not atomic.
>
> Neil's suggestion to deny the operation on open files makes sense.
> You can use a variant of deny_write_access() that takes inode
> which implies the error  ETXTBSY for an attempt to exchange newer
> with a file that is open for write.

So I will incorporate these suggestions into an upcoming v2 patch.

Thanks,
James


