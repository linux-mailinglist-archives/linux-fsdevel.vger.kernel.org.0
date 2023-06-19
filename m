Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2577473532D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jun 2023 12:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232026AbjFSKmY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jun 2023 06:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbjFSKmH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jun 2023 06:42:07 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 559B6199;
        Mon, 19 Jun 2023 03:42:06 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-988f066f665so21960166b.2;
        Mon, 19 Jun 2023 03:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687171325; x=1689763325;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Lc8A8Vw9LtMkTqv5o4GSfreuArCukUUbiIQJyiLS2Gs=;
        b=meJYO/VluisrybFU77MgPXARQR8H/BczsgubpOvzbai2yX5V/vNJ1a44DdL5P+gT9h
         zWaMyX4vsVMcZpdzrqrHuVgt+KJuH3wxsdVuftFTJAWDxqpYYhN8DbGuM3qnFIwm16oj
         82X3mXu6193cPrAuBqSkaBVCPjA+IlrSg0lVP2EgXLsSKrDYFwgPWW6rm/HGLgLKKYIl
         34H3ha0Lr8mUP3vvONSgYZQMDRcXXwTvK2ivTbHlbWcynep/tWcyXhjnXuYYReLgQVjd
         0N2/eM5FJL05+0TX1P5SmIhH8m9bEJkBy7lV3xJ+RlpmSHuYsp1dMtRC0O3xgQ4t5YUO
         G+mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687171325; x=1689763325;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Lc8A8Vw9LtMkTqv5o4GSfreuArCukUUbiIQJyiLS2Gs=;
        b=e8QBXfYw1FmFcjMWNM9p80fjZMlWzvET+1v5sjuhl1Uj3TiDUvMXiDHFONDGD+qIGq
         7KnEDCdZUM8BK9k/CfXpSvGyXDYNhmI4JKoxhCnw2fuxzrCZsP/c4Yv7wLit7c4uNRyz
         /6oUqlL3I4zUYIZgH8tjvbnK41DF83RtOEXCJYhBeSWknt5If11RNlBswyJDqO9PPJbo
         yGe/7yxkpxOBcV8yJOqXjX/kn5vmwmaXdAAQqgeZXka6cQn+kxPyuif46hdFuc2IkZwE
         5M2cruzwQrFezHTfyFfqIrpshQqJVtmZPAJhfGgTGQRPvlpp18ONF1g6pav9nUKeL0gG
         hnbw==
X-Gm-Message-State: AC+VfDxSeK4NsYG3ZG914aPV99pKWPPbZHiAuyUtMLE/jfTb8qHQKLAm
        pW8/CIaRNzLLQLWfjZS0BzgutEKG6uX6Zw==
X-Google-Smtp-Source: ACHHUZ6gvL3qDfw9MwR4eqOkuWp5n5zJry97i6r137AZVb9sYts/gHSzat3Fvpas0VxRgRcJ5YqdUQ==
X-Received: by 2002:a17:907:7207:b0:988:8786:f56c with SMTP id dr7-20020a170907720700b009888786f56cmr3273576ejc.0.1687171324574;
        Mon, 19 Jun 2023 03:42:04 -0700 (PDT)
Received: from [10.176.234.233] ([147.161.245.31])
        by smtp.gmail.com with ESMTPSA id m23-20020a1709060d9700b00988e400c468sm421140eji.190.2023.06.19.03.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 03:42:04 -0700 (PDT)
Message-ID: <efb4cbf2ee6f006b2b458c209fc0f31e8ba655e2.camel@gmail.com>
Subject: Re: [PATCH v1 2/5] fs/buffer.c: convert block_commit_write to
 return void
From:   Bean Huo <huobean@gmail.com>
To:     Jan Kara <jack@suse.cz>, Bean Huo <beanhuo@iokpp.de>
Cc:     viro@zeniv.linux.org.uk, brauner@kernel.org,
        akpm@linux-foundation.org, jack@suse.com, tytso@mit.edu,
        adilger.kernel@dilger.ca, mark@fasheh.com, jlbec@evilplan.org,
        joseph.qi@linux.alibaba.com, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ocfs2-devel@oss.oracle.com, beanhuo@micron.com
Date:   Mon, 19 Jun 2023 12:42:02 +0200
In-Reply-To: <20230619095604.uknf7uovnn2az2wu@quack3>
References: <20230618213250.694110-1-beanhuo@iokpp.de>
         <20230618213250.694110-3-beanhuo@iokpp.de>
         <20230619095604.uknf7uovnn2az2wu@quack3>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gTW9uLCAyMDIzLTA2LTE5IGF0IDExOjU2ICswMjAwLCBKYW4gS2FyYSB3cm90ZToKPiBMb29r
cyBnb29kIHRvIG1lIGJ1dCB5b3UnbGwgbmVlZCB0byByZW9yZGVyIHRoaXMgcGF0Y2ggYXQgdGhl
IGVuZCBvZgo+IHRoZQo+IHBhdGNoIHNlcmllcyB0byBhdm9pZCBicmVha2luZyBjb21waWxhdGlv
biBpbiB0aGUgbWlkZGxlIG9mIHRoZQo+IHNlcmllcy4KPiBPdGhlcndpc2UgZmVlbCBmcmVlIHRv
IGFkZDoKPiAKPiBSZXZpZXdlZC1ieTogSmFuIEthcmEgPGphY2tAc3VzZS5jej4KPiAKPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoEhvbnphCnRoYW5rcyBKYW4sIEkgd2lsbCByZW9yZGVyIGl0IGluIHRoZSB2Mi4K
CktpbmQgcmVnYXJkcywKQmVhbgo=

