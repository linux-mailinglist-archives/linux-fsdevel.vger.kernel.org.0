Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBD06567B31
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Jul 2022 02:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiGFA6y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Jul 2022 20:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbiGFA6x (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Jul 2022 20:58:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 87BAA12D25
        for <linux-fsdevel@vger.kernel.org>; Tue,  5 Jul 2022 17:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657069131;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L/VIshmF4xT9wjWGvPNSfMhdl0xNY9tpFrPyWnO0aT8=;
        b=A/s6DgczCzsc6wIKrvToMEeh/tuL+RfN37gUORUNUs3O/I1RqVxvk2mvt4+mY3J3A8Y3OU
        folBGFVoj40+jhz3d12puk7jJ6ZjQq4Phj07h86lnYKViCIeMEr9HBxbeo1NF8gsuh/OqY
        1JnFTuuGfYRwXsMQMy8wCNrlL/QNCLQ=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-83-C-W8pemzN_63GTx2RBPd2A-1; Tue, 05 Jul 2022 20:58:49 -0400
X-MC-Unique: C-W8pemzN_63GTx2RBPd2A-1
Received: by mail-pg1-f199.google.com with SMTP id l185-20020a6391c2000000b0041290b89490so362540pge.19
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Jul 2022 17:58:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=L/VIshmF4xT9wjWGvPNSfMhdl0xNY9tpFrPyWnO0aT8=;
        b=1HNC1fYRr68vOp8lEIBWr130+ZiwXmZlC/+hP+q0vUuj4x9bdRlrKQlRz3nxbOlFdB
         hyTliHbijn/5pnPDY1DwCSFiWyhweLKXHjTAuF5VNjRWyzR/9sytI/MFT9Y771OPAhcy
         PpLnitjoSFs01VqnRiZj59Xvg6JUo6GUJBmrZ9RlV44MBkcGScG6TlaELOI4MQ0lOtVz
         0yZDdkIIXKVf/NDN2AoyQoX4ysyhJrP7997m9hFUubc2UlQcuwCB+QYh5+wh2z4kYMxN
         TN3gNPtxB0S6ixpGZZj7nsYbNMy/u1SvwXKEUNGezU966nJpGWUsNtE7wQs7N5xFbdgD
         JW/Q==
X-Gm-Message-State: AJIora9NDR0xqxAl08Y+QJZZALQ4UgqwjJUOOrImv5lpYNAO/rYoTQOW
        Kohe9P7FAUf/Mpo1/Nsge6s3eQ5yRtSNX2+Ty5X7InGTGh5gfetaCQZ+IlyJ6JXbvRnvovXCRF/
        AAoGNZfp2BgaOovDwpbjyw+W9tw==
X-Received: by 2002:a17:90a:e7c6:b0:1ef:9ab6:406e with SMTP id kb6-20020a17090ae7c600b001ef9ab6406emr7426870pjb.108.1657069128696;
        Tue, 05 Jul 2022 17:58:48 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1silTss9+EIoox09QHdHlVkmVoGOPWNKlZe23v0wKMWdZReT8feVbKNmYUOn6gMvpy4A5MnbA==
X-Received: by 2002:a17:90a:e7c6:b0:1ef:9ab6:406e with SMTP id kb6-20020a17090ae7c600b001ef9ab6406emr7426844pjb.108.1657069128474;
        Tue, 05 Jul 2022 17:58:48 -0700 (PDT)
Received: from [10.72.12.227] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id n13-20020a170903110d00b0016bec529f77sm3774563plh.272.2022.07.05.17.58.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jul 2022 17:58:47 -0700 (PDT)
Subject: Re: [PATCH 1/2] netfs: release the folio lock and put the folio
 before retrying
To:     David Howells <dhowells@redhat.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     idryomov@gmail.com, vshankar@redhat.com,
        linux-kernel@vger.kernel.org, ceph-devel@vger.kernel.org,
        willy@infradead.org, keescook@chromium.org,
        linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com
References: <30a4bd0e19626f5fb30f19f0ae70fba2debb361a.camel@kernel.org>
 <20220701022947.10716-1-xiubli@redhat.com>
 <20220701022947.10716-2-xiubli@redhat.com>
 <2187946.1657027284@warthog.procyon.org.uk>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <8ce8c30f-8a33-87e7-1bdc-b73d5b933c85@redhat.com>
Date:   Wed, 6 Jul 2022 08:58:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <2187946.1657027284@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 7/5/22 9:21 PM, David Howells wrote:
> Jeff Layton <jlayton@kernel.org> wrote:
>
>> I don't know here... I think it might be better to just expect that when
>> this function returns an error that the folio has already been unlocked.
>> Doing it this way will mean that you will lock and unlock the folio a
>> second time for no reason.
> I seem to remember there was some reason you wanted the folio unlocking and
> putting.  I guess you need to drop the ref to flush it.
>
> Would it make sense for ->check_write_begin() to be passed a "struct folio
> **folio" rather than "struct folio *folio" and then the filesystem can clear
> *folio if it disposes of the page?

Yeah, this also sounds good to me.

-- Xiubo


> David
>

