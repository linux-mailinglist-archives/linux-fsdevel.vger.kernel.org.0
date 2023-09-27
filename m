Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7307B0C15
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Sep 2023 20:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbjI0SnZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Sep 2023 14:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjI0SnZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Sep 2023 14:43:25 -0400
Received: from mail.stoffel.org (mail.stoffel.org [172.104.24.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ED7A8F;
        Wed, 27 Sep 2023 11:43:23 -0700 (PDT)
Received: from quad.stoffel.org (097-095-183-072.res.spectrum.com [97.95.183.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.stoffel.org (Postfix) with ESMTPSA id 266B31E13E;
        Wed, 27 Sep 2023 14:43:23 -0400 (EDT)
Received: by quad.stoffel.org (Postfix, from userid 1000)
        id 92604A89A7; Wed, 27 Sep 2023 14:43:22 -0400 (EDT)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <25876.30666.549398.562913@quad.stoffel.home>
Date:   Wed, 27 Sep 2023 14:43:22 -0400
From:   "John Stoffel" <john@stoffel.org>
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     John Stoffel <john@stoffel.org>, brauner@kernel.org,
        viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org
Subject: Re: [PATCH] vfs: shave work on failed file open
In-Reply-To: <CAGudoHF9nrmR6eH91YpcG4795YAKxemKeMvWNSLaiWtQAYX0uA@mail.gmail.com>
References: <20230925205545.4135472-1-mjguzik@gmail.com>
        <25875.17995.247620.601505@quad.stoffel.home>
        <CAGudoHF9nrmR6eH91YpcG4795YAKxemKeMvWNSLaiWtQAYX0uA@mail.gmail.com>
X-Mailer: VM 8.2.0b under 27.1 (x86_64-pc-linux-gnu)
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_PASS,T_SPF_HELO_PERMERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>>>>> "Mateusz" == Mateusz Guzik <mjguzik@gmail.com> writes:

> On 9/26/23, John Stoffel <john@stoffel.org> wrote:

>> 
>>> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
>>> ---
>>> fs/file_table.c      | 39 +++++++++++++++++++++++++++++++++++++++
>>> fs/namei.c           |  2 +-
>>> include/linux/file.h |  1 +
>>> 3 files changed, 41 insertions(+), 1 deletion(-)
>> 
>>> diff --git a/fs/file_table.c b/fs/file_table.c
>>> index ee21b3da9d08..320dc1f9aa0e 100644
>>> --- a/fs/file_table.c
>>> +++ b/fs/file_table.c
>>> @@ -82,6 +82,16 @@ static inline void file_free(struct file *f)
>>> call_rcu(&f->f_rcuhead, file_free_rcu);
>>> }
>> 
>>> +static inline void file_free_badopen(struct file *f)
>>> +{
>>> +	BUG_ON(f->f_mode & (FMODE_BACKING | FMODE_OPENED));
>> 
>> eww... what a BUG_ON() here?  This seems *way* overkill to crash the
>> system here, and you don't even check if f exists first as well, since
>> I assume the caller checks it or already knows it?
>> 
>> Why not just return an error here and keep going?  What happens if you do?
>> 

> The only caller already checked these flags, so I think BUGing out is prudent.

So how would the flags change if they had been checked before?  And if
they are wrong, why not just exit without doing anything?  Crashing
the system just because you can't free some memory seems like a
horrible thing to do.  

Linus has said multiple times that BUG_ON() isn't the answer.  You
should just do a WARN_ON() instead.  Or WARN_ONCE(), don't just kill
the entire system like this.

John
