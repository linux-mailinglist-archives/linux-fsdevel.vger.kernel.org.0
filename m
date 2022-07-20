Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C09D57BAF1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Jul 2022 17:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233983AbiGTP40 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Jul 2022 11:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiGTP4Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Jul 2022 11:56:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5CD25491E8
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Jul 2022 08:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658332582;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hayOb/2khRpLgcQqaRbsNrhY6csqS2eGKwVckOZ18Pw=;
        b=MEAoZaiDSczJDBkkFQwD+AOiIECA/W0JONVdVA3c4acHLPUAYC2IZ4n1CHXRVtYdvj/cRL
        0JEmH16jxWwGdAL0GO4Sj2YD1YzQlQdiOOsWLt4H82A2CJLS/vJseT+U1vGMnFU3rIve49
        OijtZTKBn7YppUfXKFBk79iMZCG41Ow=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-152-ebRiIFFJMMObA379G1Esbg-1; Wed, 20 Jul 2022 11:56:15 -0400
X-MC-Unique: ebRiIFFJMMObA379G1Esbg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 32AB51019C98;
        Wed, 20 Jul 2022 15:56:15 +0000 (UTC)
Received: from [172.16.176.1] (unknown [10.22.48.8])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 20376909FF;
        Wed, 20 Jul 2022 15:56:13 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Jeff Layton" <jlayton@kernel.org>
Cc:     "Lukas Czerner" <lczerner@redhat.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: should we make "-o iversion" the default on ext4 ?
Date:   Wed, 20 Jul 2022 11:56:12 -0400
Message-ID: <BAFC8295-B629-49DB-A381-DD592182055D@redhat.com>
In-Reply-To: <ad7218a41fa8ac26911a9ccb79c87609d4279fea.camel@kernel.org>
References: <69ac1d3ef0f63b309204a570ef4922d2684ed7f9.camel@kernel.org>
 <20220720141546.46l2d7bxwukjhtl7@fedora>
 <ad7218a41fa8ac26911a9ccb79c87609d4279fea.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 20 Jul 2022, at 10:38, Jeff Layton wrote:
> On Wed, 2022-07-20 at 16:15 +0200, Lukas Czerner wrote:
>>
>> Is there a different way I am not seeing?
>>
>
> Right, implementing this is the difficult bit actually since this uses a
> MS_* flag. If we do make this the default, we'd definitely want to
> continue allowing "-o noiversion" to disable it.
>
> Could we just reverse the default in libmount? It might cause this to
> suddenly be enabled in some deployments, but in most cases, people
> wouldn't even notice and they could still specify -o noiversion to turn
> it off.
>
> Another idea would be to introduce new mount options for this, but
> that's kind of nasty from a UI standpoint.

Is it safe to set SB_I_VERSION at export time?  If so, export_operations
could grow an ->enable_iversion().

Ben

