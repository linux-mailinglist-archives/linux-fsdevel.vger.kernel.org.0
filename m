Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B22546B2F1C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Mar 2023 21:52:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbjCIUwN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Mar 2023 15:52:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231401AbjCIUv4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Mar 2023 15:51:56 -0500
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC91010461D;
        Thu,  9 Mar 2023 12:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1678394995;
        bh=TxNC+G8LJt1YlLEyyO36tP7EdfEi7ZRgBLptFhwSu+0=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=sJEOIS4cFgIO/Gb3uL4riI/afgPmTw0aGi1iYex2KToml7qBwNYZz5e56YLxQQUXv
         0yXD+I+GxID+a/Djk4E3O4x62qWnbI7um0UgUr2mkqnN1ut2zMBuJNdCjW75akIEYf
         /xVnm8xggxb7KxUbSMTNO3BukSpUPqDaJNbqB5P0=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 5B1B81285F61;
        Thu,  9 Mar 2023 15:49:55 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 5svhtc5N2jGL; Thu,  9 Mar 2023 15:49:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1678394993;
        bh=TxNC+G8LJt1YlLEyyO36tP7EdfEi7ZRgBLptFhwSu+0=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=adb3KIoqy9AY/YQj6fgspkWFfMJOJnXe2iyCMOb8KkL5/RtLXMg4VOOA6OVffTayu
         65wN04qMjXIBC8yi9Bpr9sToDrJTWW0Gju2Uy/Gws8YVkoGquUTf4D5SAxTi5dP9fw
         TlgQQ1iXlSF58IkiouMxOPBOIh0l9W9QqpYd5NlQ=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::c14])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id ACB4F1285ECE;
        Thu,  9 Mar 2023 15:49:52 -0500 (EST)
Message-ID: <f929f8d8e61da345be525ab06d4bb34ed2ce878b.camel@HansenPartnership.com>
Subject: Re: [LSF/MM/BPF TOPIC] Cloud storage optimizations
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Javier =?ISO-8859-1?Q?Gonz=E1lez?= <javier.gonz@samsung.com>,
        Matthew Wilcox <willy@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>, Hannes Reinecke <hare@suse.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Keith Busch <kbusch@kernel.org>,
        Pankaj Raghav <p.raghav@samsung.com>,
        Daniel Gomez <da.gomez@samsung.com>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-block@vger.kernel.org
Date:   Thu, 09 Mar 2023 15:49:50 -0500
In-Reply-To: <yq11qlygevs.fsf@ca-mkp.ca.oracle.com>
References: <c9f6544d-1731-4a73-a926-0e85ae9da9df@suse.de>
         <ZAN2HYXDI+hIsf6W@casper.infradead.org>
         <edac909b-98e5-cb6d-bb80-2f6a20a15029@suse.de>
         <ZAOF3p+vqA6pd7px@casper.infradead.org>
         <0b70deae-9fc7-ca33-5737-85d7532b3d33@suse.de>
         <ZAWi5KwrsYL+0Uru@casper.infradead.org> <20230306161214.GB959362@mit.edu>
         <ZAjLhkfRqwQ+vkHI@casper.infradead.org>
         <CGME20230308181355eucas1p1c94ffee59e210fb762540c888e8eae8a@eucas1p1.samsung.com>
         <1367983d4fa09dcb63e29db2e8be3030ae6f6e8c.camel@HansenPartnership.com>
         <20230309080434.tnr33rhzh3a5yc5q@ArmHalley.local>
         <260064c68b61f4a7bc49f09499e1c107e2a28f31.camel@HansenPartnership.com>
         <yq11qlygevs.fsf@ca-mkp.ca.oracle.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2023-03-09 at 10:23 -0500, Martin K. Petersen wrote:
> > This is not to say I think larger block sizes is in any way a bad
> > idea ... I just think that given the history, it will be driven by
> > application needs rather than what the manufacturers tell us.
> 
> I think it would be beneficial for Linux to support filesystem blocks
> larger than the page size. Based on experience outlined above, I am
> not convinced larger logical block sizes will get much traction. But
> that doesn't prevent devices from advertising larger
> physical/minimum/optimal I/O sizes and for us to handle those more
> gracefully than we currently do.

Right, I was wondering if we could try to persuade the Manufacturers to
advertise a more meaningful optimal I/O size ...  But as you say, the
pressure is coming from applications and filesystems for larger block
sizes and that will create I/O patterns that are more beneficial to the
underlying device hardware regardless of whether it actually tells us
anything about what it would like.

James

