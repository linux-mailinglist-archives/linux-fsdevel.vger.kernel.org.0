Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 596EE593479
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Aug 2022 20:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232367AbiHOSHK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Aug 2022 14:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiHOSHJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Aug 2022 14:07:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3D35229C8F
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Aug 2022 11:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660586823;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ujM9hbtiDvaKcMcqtlXWweFBU3njnJfsdTVS+tJ21g4=;
        b=c7FrVsKr8kN7gcAEaOeYuNoYMFOUMZjX5jloI/YGOjSeQno5Qw84KLlyjJFrfwjcDhWYNO
        sqhg+MhDwF6SH+pDuOMptNxPJO1Y2Bv9942wEikrYBxxapdob5CPnAHZv4joamHYq3UI1v
        H1553L0PFDVmbAsnktXynYEfLIgxGwk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-14-GftWwSlKO-2_q73CFcKJDg-1; Mon, 15 Aug 2022 14:07:00 -0400
X-MC-Unique: GftWwSlKO-2_q73CFcKJDg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 895A818A6522;
        Mon, 15 Aug 2022 18:06:59 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 42117C15BA8;
        Mon, 15 Aug 2022 18:06:59 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     bcrl@kvack.org, viro@zeniv.linux.org.uk, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] aio: Save a few cycles in 'lookup_ioctx()'
References: <0c3fcdaec33bb12b2367860dfab7ed4224ea000c.1635974999.git.christophe.jaillet@wanadoo.fr>
        <a8666743-4dc5-79b8-56c7-23c05fc88d66@wanadoo.fr>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Mon, 15 Aug 2022 14:10:49 -0400
In-Reply-To: <a8666743-4dc5-79b8-56c7-23c05fc88d66@wanadoo.fr> (Christophe
        JAILLET's message of "Fri, 12 Aug 2022 06:54:09 +0200")
Message-ID: <x49czd1xtqu.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christophe JAILLET <christophe.jaillet@wanadoo.fr> writes:

> Le 03/11/2021 =C3=A0 22:31, Christophe JAILLET a =C3=A9crit=C2=A0:
>> Use 'percpu_ref_tryget_live_rcu()' instead of 'percpu_ref_tryget_live()'=
 to
>> save a few cycles when it is known that the rcu lock is already
>> taken/released.
>>
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>>   fs/aio.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/aio.c b/fs/aio.c
>> index 9c81cf611d65..d189ea13e10a 100644
>> --- a/fs/aio.c
>> +++ b/fs/aio.c
>> @@ -1062,7 +1062,7 @@ static struct kioctx *lookup_ioctx(unsigned long c=
tx_id)
>>   	id =3D array_index_nospec(id, table->nr);
>>   	ctx =3D rcu_dereference(table->table[id]);
>>   	if (ctx && ctx->user_id =3D=3D ctx_id) {
>> -		if (percpu_ref_tryget_live(&ctx->users))
>> +		if (percpu_ref_tryget_live_rcu(&ctx->users))
>>   			ret =3D ctx;
>>   	}
>>   out:
>
>
> Hi,
> gentle reminder.
>
> Is this patch useful?
> When I first posted it, percpu_ref_tryget_live_rcu() was really new.
> Now it is part of linux since 5.16.
>
> Saving a few cycles in a function with "lookup" in its name looks
> always good to me.

The patch looks fine to me.

Reviewed-by: Jeff Moyer <jmoyer@redhat.com>

