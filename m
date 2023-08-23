Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA8F7854F1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Aug 2023 12:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232258AbjHWKK2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Aug 2023 06:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232227AbjHWKKY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Aug 2023 06:10:24 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85FF411F;
        Wed, 23 Aug 2023 03:10:21 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 49FFE2070A;
        Wed, 23 Aug 2023 10:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1692785420; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Dt4LXnYrw4kAFJZczkw29qSFviXn6bGuSZ06J4CVMGc=;
        b=tSd3TO7nAhLNBjDQLlgV8yMozadYVJZda+fMrXANENu/FwFJH9qwnsw7vpqRpmtMIn5CND
        0Kx1TOvgmrI/a8AQjxIyzj6++94m89Ub6Y/635O0Ul8AtkbwJGKDLfPBa6iv5JRzBbzw4B
        ljohnYxwA1BjoucqgSQd/Z27EFkZZHY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1692785420;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Dt4LXnYrw4kAFJZczkw29qSFviXn6bGuSZ06J4CVMGc=;
        b=QgYok9NkFMdwGazAQgQrBrNEzN7VNlmKOtm2khz105XW9UNotzuFrxnEnX9KOo7zBNoOFr
        H4DFgxw+CcnmIAAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B48AD1351F;
        Wed, 23 Aug 2023 10:10:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id HFzVIArb5WRQDgAAMHmgww
        (envelope-from <colyli@suse.de>); Wed, 23 Aug 2023 10:10:18 +0000
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.600.7\))
Subject: Re: [PATCH 09/29] bcache: Convert to bdev_open_by_path()
From:   Coly Li <colyli@suse.de>
In-Reply-To: <4c14b62-22a-e9b4-ab2d-3272d0c0495e@ewheeler.net>
Date:   Wed, 23 Aug 2023 18:10:06 +0800
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Bcache Linux <linux-bcache@vger.kernel.org>,
        Kent Overstreet <kent.overstreet@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <280FD38B-FD92-4995-834F-E3E69CEA49E8@suse.de>
References: <20230810171429.31759-1-jack@suse.cz>
 <20230811110504.27514-9-jack@suse.cz>
 <fd7fc9e-8d24-972-4b63-7eae3d2931e2@ewheeler.net>
 <20230821175053.osjvbwnubr2k6q5q@quack3>
 <4c14b62-22a-e9b4-ab2d-3272d0c0495e@ewheeler.net>
To:     Eric Wheeler <bcache@lists.ewheeler.net>
X-Mailer: Apple Mail (2.3731.600.7)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> 2023=E5=B9=B48=E6=9C=8822=E6=97=A5 02:54=EF=BC=8CEric Wheeler =
<bcache@lists.ewheeler.net> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Mon, 21 Aug 2023, Jan Kara wrote:
>> On Sun 20-08-23 18:06:01, Eric Wheeler wrote:
>>> On Fri, 11 Aug 2023, Jan Kara wrote:
>>>> Convert bcache to use bdev_open_by_path() and pass the handle =
around.
>>>>=20
>>>> CC: linux-bcache@vger.kernel.org
>>>> CC: Coly Li <colyli@suse.de
>>>> CC: Kent Overstreet <kent.overstreet@gmail.com>
>>>> Acked-by: Coly Li <colyli@suse.de>
>>>> Signed-off-by: Jan Kara <jack@suse.cz>
>>>> ---
>>>> drivers/md/bcache/bcache.h |  2 +
>>>> drivers/md/bcache/super.c  | 78 =
++++++++++++++++++++------------------
>>>> 2 files changed, 43 insertions(+), 37 deletions(-)
>>>>=20
>>>> diff --git a/drivers/md/bcache/bcache.h =
b/drivers/md/bcache/bcache.h
>>>> index 5a79bb3c272f..2aa3f2c1f719 100644
>>>> --- a/drivers/md/bcache/bcache.h
>>>> +++ b/drivers/md/bcache/bcache.h
>>>> @@ -299,6 +299,7 @@ struct cached_dev {
>>>> struct list_head list;
>>>> struct bcache_device disk;
>>>> struct block_device *bdev;
>>>> + struct bdev_handle *bdev_handle;
>>>=20
>>> It looks like you've handled most if not all of the `block_device =
*bdev`=20
>>> refactor.  Can we drop `block_device *bdev` and fixup any remaining=20=

>>> references?  More below.
>>=20
>> Well, we could but it's a lot of churn - like 53 dereferences in =
bcache.
>> So if bcache maintainer wants to go this way, sure we can do it. But
>> preferably as a separate cleanup patch on top of this series because =
the
>> series generates enough conflicts as is and this will make it =
considerably
>> worse.
>=20
> A separate cleanup patch seems reasonable, I'll defer to Coly on this =
one=20
> since he's the maintainer.  I just wanted to point out the possible =
issue. =20
> Thanks for your work on this.

Yes, the challenge of this series is from the block layer core, once the =
change in core part is accepted, the cleanup can be followed up if =
necessary.

Thank you all.

Coly Li

