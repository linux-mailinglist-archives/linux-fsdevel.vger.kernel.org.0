Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A22468B0DC
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Feb 2023 17:12:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbjBEQL7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 Feb 2023 11:11:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjBEQL6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 Feb 2023 11:11:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A941C1ADE6
        for <linux-fsdevel@vger.kernel.org>; Sun,  5 Feb 2023 08:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675613473;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ObU9haac15/5ndYLncPOcflnXZb09Zw6shZT8Mhn0eI=;
        b=aqvf90LOk6OBokvllAnhmTc2U2SahyH28xdKP8q/z8KEG/DBOk6NCot2a3E4QXa7FvS4Yr
        DReb8vGG60gtjFk3oCcek6dQy/7MhhnA08HKNOMlw5purodAxfVkoNJ9P3uFsb3CtCMSCv
        2Nx3m9NlSm6DfCX1JYzKtqeAtHA1zZs=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-50-c6LIMRUfP_CjoR0g_E4NXw-1; Sun, 05 Feb 2023 11:11:10 -0500
X-MC-Unique: c6LIMRUfP_CjoR0g_E4NXw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 01B9E3C025B8;
        Sun,  5 Feb 2023 16:11:10 +0000 (UTC)
Received: from [172.16.176.1] (unknown [10.22.50.5])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E46D0140EBF4;
        Sun,  5 Feb 2023 16:11:07 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Hugh Dickins <hughd@google.com>,
        Charles Edward Lever <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Anna Schumaker <anna@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Linux kernel regressions list <regressions@lists.linux.dev>
Subject: Re: git regression failures with v6.2-rc NFS client
Date:   Sun, 05 Feb 2023 11:11:06 -0500
Message-ID: <3AD5F198-42A1-49F3-85CA-D245775F87DF@redhat.com>
In-Reply-To: <8f122cb0304632b391759788fe1f72ea1bab1ba0.camel@kernel.org>
References: <9A4A5673-691D-47EC-BC44-C43BE7E50A48@oracle.com>
 <D0404F55-2692-4DB6-8DD6-CAC004331AC1@redhat.com>
 <5FF4061F-108C-4555-A32D-DDBFA80EE4E7@redhat.com>
 <F1833EA0-263F-46DF-8001-747A871E5757@redhat.com>
 <B90C62F2-1D3A-40E0-8E33-8C349C6FFD3D@oracle.com>
 <44CB1E86-60E0-4CF0-9FD4-BB7E446542B7@redhat.com>
 <1AAC6854-2591-4B21-952A-BC58180B4091@oracle.com>
 <41813D21-95C8-44E3-BB97-1E9C03CE7FE5@redhat.com>
 <79261B77-35D0-4E36-AA29-C7BF9FB734CC@oracle.com>
 <104B6879-5223-485F-B099-767F741EB15B@redhat.com>
 <966AEC32-A7C9-4B97-A4F7-098AF6EF0067@oracle.com>
 <545B5AB7-93A6-496E-924E-AE882BF57B72@hammerspace.com>
 <FA8392E6-DAFC-4462-BDAE-893955F9E1A4@oracle.com>
 <4dd32d-9ea3-4330-454a-36f1189d599@google.com>
 <0D7A0393-EE80-4785-9A83-44CF8269758B@hammerspace.com>
 <ab632691-7e4c-ccbf-99a0-397f1f7d30ec@google.com>
 <8B4F6A20-D7A4-4A22-914C-59F5EA79D252@hammerspace.com>
 <c5259e81-631e-7877-d3b0-5a5a56d35b42@leemhuis.info>
 <15679CC0-6B56-4F6D-9857-21DCF1EFFF79@redhat.com>
 <031C52C0-144A-4051-9B4C-0E1E3164951E@hammerspace.com>
 <05BEEF62-46DF-4FAC-99D4-4589C294F93A@redhat.com>
 <8f122cb0304632b391759788fe1f72ea1bab1ba0.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5 Feb 2023, at 6:24, Jeff Layton wrote:
> I may be missing something, but would it be possible to move to a more
> stable scheme for readdir cookies for tmpfs?

Yes, totally possible but it was pointed out earlier that's not going to
land in 6.2, so this thread's been focused on trying to reason if
85aa8ddc3818 counts as a regression.

Ben

