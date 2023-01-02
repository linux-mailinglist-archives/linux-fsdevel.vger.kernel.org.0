Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25CAF65B30C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jan 2023 15:01:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236048AbjABOBr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>); Mon, 2 Jan 2023 09:01:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232870AbjABOBq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Jan 2023 09:01:46 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30ACD6551
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 Jan 2023 06:01:44 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-312-47WmmqTFMC28WcHHaiOhtA-1; Mon, 02 Jan 2023 14:01:41 +0000
X-MC-Unique: 47WmmqTFMC28WcHHaiOhtA-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 2 Jan
 2023 14:01:38 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.044; Mon, 2 Jan 2023 14:01:38 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Ameer Hamza' <ahamza@ixsystems.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "guoren@kernel.org" <guoren@kernel.org>,
        "palmer@rivosinc.com" <palmer@rivosinc.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "slark_xiao@163.com" <slark_xiao@163.com>,
        "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
        "ink@jurassic.park.msu.ru" <ink@jurassic.park.msu.ru>,
        "mattst88@gmail.com" <mattst88@gmail.com>,
        "James.Bottomley@HansenPartnership.com" 
        <James.Bottomley@HansenPartnership.com>,
        "deller@gmx.de" <deller@gmx.de>,
        "davem@davemloft.net" <davem@davemloft.net>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "awalker@ixsystems.com" <awalker@ixsystems.com>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>
Subject: RE: [PATCH v2] Add new open(2) flag - O_EMPTY_PATH
Thread-Topic: [PATCH v2] Add new open(2) flag - O_EMPTY_PATH
Thread-Index: AQHZHXO7YJxmMel9jU25EiVio9tPeK6LKkFQ
Date:   Mon, 2 Jan 2023 14:01:38 +0000
Message-ID: <4b39cf528148470c934fb5823b35e9d5@AcuMS.aculab.com>
References: <202212310842.ysbymPHY-lkp@intel.com>
 <20221231235618.117201-1-ahamza@ixsystems.com>
In-Reply-To: <20221231235618.117201-1-ahamza@ixsystems.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,PDS_BAD_THREAD_QP_64,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ameer Hamza
> Sent: 31 December 2022 23:56
> 
> This patch adds a new flag O_EMPTY_PATH that allows openat and open
> system calls to open a file referenced by fd if the path is empty,
> and it is very similar to the FreeBSD O_EMPTY_PATH flag. This can be
> beneficial in some cases since it would avoid having to grant /proc
> access to things like samba containers for reopening files to change
> flags in a race-free way.
> 

But what does it do?
(Apart from add code to a common kernel code path.)

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

